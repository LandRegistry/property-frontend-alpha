from property_frontend import app
from flask import render_template, request, redirect, url_for
import requests

@app.route('/')
def index():
     return render_template('search.html')

@app.route('/property/<title_number>')
def property(title_number):

    title_url = "%s/%s/%s" % (app.config['SEARCH_API'], 'titles', title_number)
    app.logger.info("Requesting title url : %s" % title_url)

    #TODO - put more/better error handling around request
    try:
        response = requests.get(title_url)
        app.logger.info("Status code %s" % response.status_code)
        if response.status_code == 404:
                return render_template('404.html'), 404
        else:
            title_json = response.json()
            print title_json
            app.logger.info("Found the following title: %s" % title_json)
            return render_template('view_property.html', title_json = title_json)
    except Exception as e:
        app.logger.error("Could not retrieve title number %s: Error %s" % (title_url, e))
        raise RuntimeError


# Note -Does elasticsearch return empty json array
# for now results? If so I don't think maybe just show
# results page with no results message not 404?
@app.route('/search/')
def search():
    return redirect(url_for('index'))

@app.route('/search/results/')
def search_results():
    query = request.args.get('search', '')
    search_api_url = "%s/%s" % (app.config['SEARCH_API'], 'search')
    search_url = search_api_url + "?query=" + query
    # Note
    #   search_url = "%s?query=%s" % (search_api_url, query)
    # or
    # search_url = "{0}?={1}".format(search_api_url, query)

    app.logger.info("URL requested %s" % search_url)
    r = requests.get(search_url)
    json = r.json()
    app.logger.info("Found for the following: %s" % json)
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
