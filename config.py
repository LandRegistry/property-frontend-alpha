import os

class Config(object):
    DEBUG = False
    TITLE_API_URL = os.environ.get('TITLE_API_URL')
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')

class DevelopmentConfig(Config):
    DEBUG = True

class TestConfig(DevelopmentConfig):
    TESTING = True
