import os, logging
from flask import Flask
from flask.ext.basicauth import BasicAuth
from raven.contrib.flask import Sentry

app = Flask(__name__)

app.config.from_object(os.environ.get('SETTINGS'))

if app.config.get('BASIC_AUTH_USERNAME'):
    app.config['BASIC_AUTH_FORCE'] = True
    basic_auth = BasicAuth(app)

# Sentry exception reporting
if 'SENTRY_DSN' in os.environ:
    sentry = Sentry(app, dsn=os.environ['SENTRY_DSN'])

if not app.debug:
    app.logger.addHandler(logging.StreamHandler())
    app.logger.setLevel(logging.INFO)

app.logger.info("\nConfiguration\n%s\n" % app.config)

@app.context_processor
def asset_path_context_processor():
    return {
      'asset_path': '/static/build/',
      'landregistry_asset_path': '/static/build/'
      'js_path': '/templates/'
    }
