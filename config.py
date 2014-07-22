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

class DockerConfig(Config):
    DEBUG = True
    TITLE_API = os.environ.get('PUBLICTITLESAPI_1_PORT_8005_TCP', '').replace('tcp://', 'http://')
    SEARCH_API = os.environ.get('SEARCHAPI_1_PORT_8003_TCP', '').replace('tcp://', 'http://')
