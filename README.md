Land Registry Property Front End
===============

[![Build Status](https://travis-ci.org/LandRegistry/property.svg?branch=master)](https://travis-ci.org/LandRegistry/property)


### Getting started

```
git clone git@github.com:LandRegistry/property.git
cd property
```

Pull down GovUK frontend toolkit

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
