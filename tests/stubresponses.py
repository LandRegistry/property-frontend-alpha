import json

title = {
    "title_number": "TN1234567",
    "property": {
        "address": {
            "address_line_1": "12",
            "address_line_2": "High St",
            "city": "Sometown",
            "postcode": "ABC 123"
        }
    },
    "payment": {
        "price_paid": 1000
    },
    "extent": {
        "crs": {
            "properties": {
                "name": "urn:ogc:def:crs:EPSG:27700"
            },
            "type": "name"
        },
        "geometry": {
            "coordinates": [
                [
                    [
                        [
                            530857.01,
                            181500
                        ],
                        [
                            530857,
                            181500
                        ],
                        [
                            530857,
                            181500
                        ],
                        [
                            530857,
                            181500
                        ],
                        [
                            530857.01,
                            181500
                        ]
                    ]
                ]
            ],
            "type": "MultiPolygon"
        },
        "properties": {},
        "type": "Feature"
    }
}

title1 = {
    "title_number": "TN7654321",
    "property": {
        "address": {
            "address_line_1": "10",
            "address_line_2": "Low St",
            "city": "Funtown",
            "postcode": "CAB 321"
        }
    },
    "payment": {
        "price_paid": 1000
    },
    "extent": {
        "crs": {
            "properties": {
                "name": "urn:ogc:def:crs:EPSG:27700"
            },
            "type": "name"
        },
        "geometry": {
            "coordinates": [
                [
                    [
                        [
                            530857.01,
                            181500
                        ],
                        [
                            530857,
                            181500
                        ],
                        [
                            530857,
                            181500
                        ],
                        [
                            530857,
                            181500
                        ],
                        [
                            530857.01,
                            181500
                        ]
                    ]
                ]
            ],
            "type": "MultiPolygon"
        },
        "properties": {},
        "type": "Feature"
    }
}

search_results = {"results" : [title]}
test_two_search_results = json.dumps({"results" : [title, title1]})
