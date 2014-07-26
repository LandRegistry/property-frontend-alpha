import requests


class MockResponse(object):
    status_code = 200

    @classmethod
    def raise_for_status(cls):
        return None


class MockProperty(MockResponse):
    title = {
        "title_number": "TN1234567",
        "property": {
            "address" :
            {
                "title_number" : "TN1",
                "house_number" : "12",
                "road" :"High St",
                "town" : "Sometown",
                "postcode" : "ABC 123"
            }
        },
        "payment":{
            "price_paid" : 1000
        }
    }

    @classmethod
    def json(cls):
        return cls.title


class MockSearchResults(MockProperty):
    results = {"results" : [MockProperty.json()]}

    @classmethod
    def json(cls):
        return cls.results


class Mock404(MockResponse):
    status_code = 404

    @classmethod
    def raise_for_status(cls):
        raise requests.exceptions.HTTPError()


class Mock500(Mock404):
    status_code = 500