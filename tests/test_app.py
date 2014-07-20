from property_frontend.server import app
import mock
import unittest

class ViewProperyTestCase(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.search_api = app.config['SEARCH_API']
        self.app = app.test_client()


    @mock.patch('requests.get')
    def test_get_property_calls_search_api(self, mock_get):
        title_number = "TN1234567"
        self.app.get('/property/%s' % title_number)
        self.assertTrue(mock_get.called)
        mock_get.assert_called_with('%s/titles/%s' % (self.search_api, title_number))
