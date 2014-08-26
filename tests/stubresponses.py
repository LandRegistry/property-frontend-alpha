import json

title = {
    "title_number": "TN1234567",
    "property": {
        "address": {
            "title_number": "TN1",
            "house_number": "12",
            "road": "High St",
            "town": "Sometown",
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
            "title_number": "TN1",
            "house_number": "10",
            "road": "Low St",
            "town": "Funtown",
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
