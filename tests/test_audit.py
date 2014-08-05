import unittest
import mock
import flask
from propertyfrontend.server import app


class PropertyfrontendAuditTestCase(unittest.TestCase):
    """
    Audit logging must have the 'info' level.
    The tests below will fail if at any point the audit handlers
    use a level that is not 'info'.
    """
    LOGGER = 'logging.Logger.info'

    def setUp(self):
        app.config["TESTING"] = True,
        self.app = app
        self.client = app.test_client()

    @mock.patch(LOGGER)
    def test_audit_get_index_anon(self, mock_logger):
        path = '/'
        self.client.get(path)
        args, kwargs = mock_logger.call_args
        assert 'Audit: ' in args[0]

    @mock.patch(LOGGER)
    def test_audit_get_property_anon(self, mock_logger):
        path = '/property/TEST123'
        self.client.get(path)
        # TODO brittle? Indeed!
        assert 'Audit: ' in mock_logger.call_args_list[0][0][0]
