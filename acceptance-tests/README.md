Travis: [![Build Status](https://travis-ci.org/LandRegistry/acceptance-tests.svg)](https://travis-ci.org/LandRegistry/acceptance-tests)<br>
Jenkins: [![Build Status](http://ci.preview.landregistryconcept.co.uk/job/Test-Acceptance/badge/icon)](http://ci.preview.landregistryconcept.co.uk/job/Test-Acceptance/)


Frontend Acceptance Tests
===============

### Overview

This repository contains the front end tests for all the systems.  

### Creating Test Users

To create the test accounts used by the test scripts, run the following script inside vagrant:
```
./create_test_users.sh
```

### Running the tests in the vagrant image

Navigate to the acceptance test repository

```
cd apps/acceptance-tests/
```

To run all the tests:

```
./run_tests.sh
```

Or to run a specific feature:

```
./run_tests.sh features/caseworker/first-registration.feature
```

Or to run a specific scenario(the 29 refers to the line in the future file that your scenario starts on):

```
./run_tests.sh features/caseworker/first-registration.feature:29
```

You can also run using the firefox browser (has to be run outside of vagrant):

```
./run_tests_ff.sh
```


### Running the tests against Preview

To run against the preview environment, then use:

```
./run_tests_preview.sh
```

You will need to set the following environment variables:

```
HTTPAUTH_USERNAME
HTTPAUTH_PASSWORD
```


### Performance Tests

If you want to run a performance test, then use the following command:

```
./run_tests.sh features/performance.feature
```

If you want to generate a performance script from a scenario then do:

```
sh generate_perfornance_scripts.sh features/conveyancer/conveyancer_create_citizen_relationship.feature
```

This requires a custom build of phantomjs from:
https://github.com/mooreandrew/phantomjs
