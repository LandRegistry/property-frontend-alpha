import os

class Config(object):
    DEBUG = False
    TITLE_API = os.environ.get('TITLE_API')
    SEARCH_API = os.environ.get('SEARCH_API')

class DevelopmentConfig(Config):
    DEBUG = True

class TestConfig(DevelopmentConfig):
    TESTING = True
    SEARCH_API='http://localhost:8003'
