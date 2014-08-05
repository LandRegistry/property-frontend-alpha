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
    ANON_GET_TEMPLATE = "Audit: user=[anon], request=[<Request 'http://localhost%s' [GET]>]"

    def setUp(self):
        app.config["TESTING"] = True,
        self.app = app
        self.client = app.test_client()

    @mock.patch(LOGGER)
    def test_audit_get_index_anon(self, mock_logger):
        path = '/'
        self.client.get(path)
        mock_logger.assert_called_with(self.ANON_GET_TEMPLATE % path)

    @mock.patch(LOGGER)
    def test_audit_get_registration_anon(self, mock_logger):
        path = '/property/TEST123'
        self.client.get(path)
        mock_logger.assert_any_call(self.ANON_GET_TEMPLATE % path)
