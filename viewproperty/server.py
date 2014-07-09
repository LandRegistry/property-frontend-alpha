from viewproperty import app
from flask import render_template

@app.route('/')
def index():
    return "Nothing to see here!"

@app.route('/property/<title_number>')
def property(title_number):
    return render_template('view_property.html', title_number=title_number)

@app.after_request
def after_request(response):
    response.headers.add('Content-Security-Policy', "default-src 'self'")
    response.headers.add('X-Frame-Options', 'deny')
    response.headers.add('X-Content-Type-Options', 'nosniff')
    response.headers.add('X-XSS-Protection', '1; mode=block')
    return response
