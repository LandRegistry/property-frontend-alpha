from viewproperty.server import app
import mock
import unittest

class ViewProperyTestCase(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        app.config['TITLE_API_URL'] = 'http://somefakeapi'
        self.app = app.test_client()


    @mock.patch('requests.get')
    def test_get_property_calls_api(self, mock_get):
        title_number = "TN1234567"
        self.app.get('/property/%s' % title_number)
        self.assertTrue(mock_get.called)
        mock_get.assert_called_with("http://somefakeapi/titles/%s" % title_number)