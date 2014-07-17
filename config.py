import os

class Config(object):
    DEBUG = False
    TITLE_API_URL = os.environ.get('TITLE_API_URL')
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')
    SEARCH_API_URI = os.environ.get('SEARCH_API_URI', 'http://localhost:8003/search') 

class DevelopmentConfig(Config):
    DEBUG = True

class TestConfig(DevelopmentConfig):
    TESTING = True
