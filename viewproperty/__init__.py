import os, logging
from flask import Flask

app = Flask(__name__)

app.config.from_object(os.environ.get('SETTINGS'))

if not app.debug:
    app.logger.addHandler(logging.StreamHandler())
    app.logger.setLevel(logging.INFO)

app.logger.info("\nConfiguration\n%s\n" % app.config)

@app.context_processor
def asset_path_context_processor():
    return {'asset_path': '/static/govuk_template/'}
