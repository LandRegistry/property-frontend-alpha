import os

class Config(object):
    DEBUG = False
    SEARCH_API = os.environ['SEARCH_API']
    SERVICE_FRONTEND_URL = os.environ['SERVICE_FRONTEND_URL']
    # the following two are optional and are only configured on
    # heroku so get safely
    BASIC_AUTH_USERNAME = os.environ.get('BASIC_AUTH_USERNAME')
    BASIC_AUTH_PASSWORD = os.environ.get('BASIC_AUTH_PASSWORD')

class DevelopmentConfig(Config):
    DEBUG = True

class TestConfig(DevelopmentConfig):
    TESTING = True

class DockerConfig(Config):
    DEBUG = True
    SEARCH_API = os.environ.get('SEARCHAPI_1_PORT_8003_TCP', '').replace('tcp://', 'http://')
