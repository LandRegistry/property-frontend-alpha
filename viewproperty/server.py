from viewproperty import app
from flask import render_template
import requests
@app.debug = true

@app.route('/')
def index():
     return render_template('index.html')

@app.route('/property/<title_number>')
def property(title_number):
    titles_api_url = app.config['TITLE_API_URL']
    title_url = "%s/titles/%s" % (titles_api_url, title_number)
    app.logger.info("URL requested %s" % title_url)
    r = requests.get(title_url)
    json = r.json()
    app.logger.info("Found the following title: %s" % json)
    if json:
        return render_template('view_property.html',  title_number = json['title_number'], address = json['address'], postcode = json['postcode'])
    else:
        return render_template('404.html'), 404

@app.route('/search')
def search():
    return render_template('search.html')

@app.after_request
def after_request(response):
    response.headers.add('Content-Security-Policy', "default-src 'self' 'unsafe-inline' data:") # can we get some guidance on this?
    response.headers.add('X-Frame-Options', 'deny')
    response.headers.add('X-Content-Type-Options', 'nosniff')
    response.headers.add('X-XSS-Protection', '1; mode=block')
    return response
