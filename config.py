import os

class Config(object):
    DEBUG=True
    TITLE_API_URL = os.environ.get('TITLE_API_URL')
