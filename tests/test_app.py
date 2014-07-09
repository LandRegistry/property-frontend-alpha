from viewproperty.server import app
import unittest

class ViewProperyTestCase(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_property(self):
        title_number = "TN1234567"
        rv = self.app.get('/property/%s' % title_number)
        assert title_number in rv.data
