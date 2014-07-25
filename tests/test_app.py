from propertyfrontend.server import app
import mock
import unittest

from mockresponses import MockProperty
from mockresponses import Mock404
from mockresponses import MockSearchResults
from mockresponses import Mock500

class ViewPropertyTestCase(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.search_api = app.config['SEARCH_API']
        self.app = app.test_client()

    @mock.patch('requests.get', return_value=MockProperty())
    def test_get_property_calls_search_api(self, mock_get):
        title_number = "TN1234567"
        self.app.get('/property/%s' % title_number)
        mock_get.assert_called_with('%s/titles/%s' % (self.search_api, title_number))

    @mock.patch('requests.get', return_value=Mock404())
    def test_get_property_preserves_downstream_404(self, mock_get):
        title_number = "TN1234567"
        response = self.app.get('/property/%s' % title_number)
        assert response.status_code == 404

    @mock.patch('requests.get', return_value=MockSearchResults())
    def test_search_results_calls_search_api(self, mock_get):
        search_query = "TN12"
        self.app.post('/search/results', data=dict(search = search_query))
        mock_get.assert_called_with('%s/search?query=%s' % (self.search_api, search_query))

    @mock.patch('requests.get', return_value=Mock500())
    def test_get_property_preserves_downstream_500(self, mock_get):
        search_query = "TN12"
        response = self.app.post('/search/results', data=dict(search = search_query))
        assert response.status_code == 500

