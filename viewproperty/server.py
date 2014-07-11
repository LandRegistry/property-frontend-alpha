from viewproperty import app
from flask import render_template
import requests

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
    return render_template('view_property.html', title_number = json['title_number'])

@app.after_request
def after_request(response):
    response.headers.add('Content-Security-Policy', "default-src 'self'")
    response.headers.add('X-Frame-Options', 'deny')
    response.headers.add('X-Content-Type-Options', 'nosniff')
    response.headers.add('X-XSS-Protection', '1; mode=block')
    return response
