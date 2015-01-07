Frontend Acceptance Tests
===============

### Overview

This repository contains the front end tests.

### Running the tests in the vagrant virtual env

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
