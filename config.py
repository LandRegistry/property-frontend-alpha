import os

class Config(object):
    DEBUG=False
    TITLE_API_URL = os.environ.get('TITLE_API_URL')

class DevConfig(object):
    DEBUG=True
