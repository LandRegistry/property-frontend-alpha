from propertyfrontend.server import app
import mock
import unittest
import requests
import responses

from stubresponses import title
from stubresponses import search_results, test_two_search_results

class ViewPropertyTestCase(unittest.TestCase):

    def setUp(self):
        self.search_api = app.config['SEARCH_API']
        self.service_api = app.config['SERVICE_FRONTEND_URL']
        self.app = app.test_client()

    @mock.patch('requests.get')
    @mock.patch('requests.Response')
    def test_get_property_calls_search_api(self, mock_response, mock_get):
        title_number = "TN1234567"
        mock_response.json.return_value = title
        mock_get.return_value = mock_response
        self.app.get('/property/%s' % title_number)
        mock_get.assert_called_with('%s/titles/%s' % (self.search_api, title_number))

    @mock.patch('requests.get')
    @mock.patch('requests.Response')
    def test_get_property_preserves_downstream_404(self, mock_response, mock_get):
        mock_response.status_code = 404
        mock_response.raise_for_status.side_effect = requests.exceptions.HTTPError
        mock_get.return_value = mock_response
        title_number = "TN1234567"
        response = self.app.get('/property/%s' % title_number)
        assert response.status_code == 404

    @mock.patch('requests.get', returns=search_results)
    def test_search_results_calls_search_api(self, mock_get):
        search_query = "TN12"
        self.app.post('/search/results', data=dict(search=search_query))
        mock_get.assert_called_with('%s/search?query=%s' % (self.search_api, search_query))

    @mock.patch('requests.get')
    @mock.patch('requests.Response')
    def test_get_property_preserves_downstream_500(self, mock_response, mock_get):
        mock_response.status_code = 500
        mock_response.raise_for_status.side_effect = requests.exceptions.HTTPError
        mock_get.return_value = mock_response
        search_query = "TN12"
        response = self.app.post('/search/results', data=dict(search=search_query))
        assert response.status_code == 500

    @mock.patch('requests.get', side_effect=requests.exceptions.ConnectionError)
    def test_requests_connection_error_results_in_500(self, mock_get):
        search_query = "TN12"
        response = self.app.post('/search/results', data=dict(search=search_query))
        assert response.status_code == 500

    @mock.patch('requests.get')
    @mock.patch('requests.Response')
    def test_for_service_frontend_link(self, mock_response, mock_get):
      mock_response.status_code = 200
      mock_response.json.return_value = title
      mock_get.return_value = mock_response
      title_number = "TN1234567"
      rv = self.app.get('/property/%s' % title_number)
      service_frontend_url = '%s/%s/%s' % (self.service_api, 'property', title_number)
      assert service_frontend_url in rv.data

    def test_currency_format(self):
        from propertyfrontend.server import currency
        assert '1.00' == currency(1)
        assert '10.00' == currency(10)
        assert '100.00' == currency(100)
        assert '1,000.00' == currency(1000)
        assert '10,000.00' == currency(10000)
        assert '100,000.00' == currency(100000)


    @responses.activate
    def test_for_two_search_results(self):
        #Mock a response, as though JSON is coming back from SEARCH_API
        TITLE_NUMBER = "TN1234567"
        search_api_url = "%s/%s" % (self.search_api, "search")
        search_url = "%s?query=%s" % (search_api_url, TITLE_NUMBER)
        app.logger.info(search_url)

        #match_querystring essential when a query specified.
        #default value of match_querystring is false.  Relies on query being absent.
        responses.add(responses.GET, search_url, match_querystring = True,
        body = test_two_search_results, status = 200, content_type='application/json')

        rv = self.app.post('search/results', data={'search': TITLE_NUMBER},
          follow_redirects=True)
        app.logger.info(rv.data)
        assert rv.status_code == 200
        assert "TN1234567" in rv.data
        assert "12 High St" in rv.data
        assert "Sometown" in rv.data
        assert "ABC 123" in rv.data
        assert "TN7654321" in rv.data
        assert "10 Low St" in rv.data
        assert "Funtown" in rv.data
        assert "CAB 321" in rv.data


    def health(self):
        response = self.app.get('/health')
        assert response.status == '200 OK'
