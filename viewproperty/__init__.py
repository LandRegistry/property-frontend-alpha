import os, logging
from flask import Flask
from flask.ext.assets import Environment, Bundle

app = Flask(__name__)

app.config.from_object(os.environ.get('SETTINGS'))

if not app.debug:
    app.logger.addHandler(logging.StreamHandler())
    app.logger.setLevel(logging.INFO)

app.logger.info("\nConfiguration\n%s\n" % app.config)

assets = Environment(app)

css_main = Bundle(
    'stylesheets/main.scss',
    filters='scss',
    output='build/main.css',
    depends="**/*.scss"
)

assets.register('css_main', css_main)

@app.context_processor
def asset_path_context_processor():
    return {'asset_path': '/static/govuk_template/'}
