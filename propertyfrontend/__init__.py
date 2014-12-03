import os, logging
from flask import Flask
from flask.ext.basicauth import BasicAuth
from raven.contrib.flask import Sentry
from lrutils import dateformat
from lrutils.audit import Audit
from lrutils.errorhandler.errorhandler_utils import ErrorHandler, eh_after_request

app = Flask(__name__)

app.config.from_object(os.environ.get('SETTINGS'))

from werkzeug.contrib.fixers import ProxyFix
app.wsgi_app = ProxyFix(app.wsgi_app)

app.jinja_env.filters['dateformat'] = dateformat

if app.config.get('BASIC_AUTH_USERNAME'):
    app.config['BASIC_AUTH_FORCE'] = True
    basic_auth = BasicAuth(app)

# Sentry exception reporting
if 'SENTRY_DSN' in os.environ:
    sentry = Sentry(app, dsn=os.environ['SENTRY_DSN'])

if not app.debug:
    app.logger.addHandler(logging.StreamHandler())
    app.logger.setLevel(logging.INFO)

app.logger.debug("\nConfiguration\n%s\n" % app.config)

# Audit, error handling and after_request headers all handled by lrutils
Audit(app)
ErrorHandler(app)
app.after_request(eh_after_request)

@app.context_processor
def asset_path_context_processor():
    return {
      'asset_path': '/static/build/',
      'landregistry_asset_path': '/static/build/'
    }

@app.context_processor
def address_processor():
    from lrutils import build_address
    def process_address_json(address_json):
        return build_address(address_json)
    return dict(formatted=process_address_json)
