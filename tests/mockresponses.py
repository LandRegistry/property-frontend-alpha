class MockResponse(object):
    status_code = 200
    requests_raise_for_status = None # this is in the requests library api

    @classmethod
    def raise_for_status(cls):
        return cls.requests_raise_for_status


class Mock404(MockResponse):
    requests_raise_for_status = True
    status_code = 404


class Mock500(MockResponse):
    requests_raise_for_status = True
    status_code = 500


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
            "price_paid" : "price_paid"
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

