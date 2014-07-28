Land Registry Property Front End
===============

[![Build Status](https://travis-ci.org/LandRegistry/property-frontend.svg?branch=master)](https://travis-ci.org/LandRegistry/property-frontend)

[![Coverage Status](https://img.shields.io/coveralls/LandRegistry/property-frontend.svg)](https://coveralls.io/r/LandRegistry/property-frontend)

### Getting started

```
git clone git@github.com:LandRegistry/property.git
cd property
```

**Pull down GovUK frontend toolkit**

```
git submodule init
git submodule update
```
You should see the govuk_toolkit in viewpropert/static/


#### Run tests

```
pip intall -r test_requirements.txt
```

Then run:

```
py.test
```

### Environment variables needed

```
export SETTINGS='conig.Config'
export TITLE_API_URL=[base URL of Titles API]
```
Note following defaults are set in run.sh

SETTINGS='conig.Config'
TITLE_API_URL='http://localhost:8003'

These will need to be set on any deployment target as well, including Heroku

e.g.
```
heroku config:set TITLE_API_URL=http://lr-public-titles-api.herokuapp.com/
```

### Run the app

Run in dev mode to enable app reloading

```
./run.sh dev
```

Otherwise with foreman

```
./run.sh
```

** This app runs on PORT 8005
