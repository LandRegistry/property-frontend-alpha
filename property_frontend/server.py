from property_frontend import app
from flask import render_template
from flask import request
import requests

@app.route('/')
def index():
     return render_template('index.html')

@app.route('/property/<title_number>')
def property(title_number):
    titles_api_url = app.config['TITLE_API_URL']
    title_url = "%s/title/%s" % (titles_api_url, title_number)
    app.logger.info("URL requested %s" % title_url)
    r = requests.get(title_url)
    app.logger.info("Status code %s" % r.status_code)
    if r.status_code == 400:
            return render_template('404.html'), 404
    else:
        json = r.json()
        app.logger.info("Found the following title: %s" % json)
        return render_template('view_property.html',
                title_number = json['title_number'],
                house_number = json['house_number'],
                road = json['road'],
                town = json['town'],
                postcode = json['postcode'],
                pricepaid = json['price_paid'])


# Note -Does elasticsearch return empty json array
# for now results? If so I don't think maybe just show
# results page with no results message not 404?
@app.route('/search/')
def search():
    return render_template('search.html')

@app.route('/search/results/', methods=['POST'])
def search_results():
    query = request.form['search']
    search_api_url = app.config['SEARCH_API_URI']
    search_url = search_api_url + "?query=" + query
    # Note
    #   search_url = "%s?query=%s" % (search_api_url, query)
    # or
    # search_url = "{0}?={1}".format(search_api_url, query)

    app.logger.info("URL requested %s" % search_url)
    r = requests.get(search_url)
    json = r.json()
    app.logger.info("Searched for the following: %s" % json)
    if json:
        return render_template('search_results.html', results = json['results'])
    else:
        return render_template('404.html'), 404


@app.after_request
def after_request(response):
    response.headers.add('Content-Security-Policy', "default-src 'self' 'unsafe-inline' data:") # can we get some guidance on this?
    response.headers.add('X-Frame-Options', 'deny')
    response.headers.add('X-Content-Type-Options', 'nosniff')
    response.headers.add('X-XSS-Protection', '1; mode=block')
    return response
