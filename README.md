# Docker image to run protractor tests

This docker image is based on https://github.com/hortonworks/docker-e2e-protractor but without the use of an entrypoint, which makes it difficult to use on a CI environement. Instead it exposes a `run-protractor` command to be called to run the protractor tests.

# Usage

To use this image as is, you might need to build and run your website in another container image or if you are building a webapp, you can serve it in the `beforeLaunch` of `protractor.conf.js`:
```
baseUrl: 'http://localhost:3001',
beforeLaunch: () => {
  require('connect')().use(require('serve-static')('public')).listen(3001);
},
```

## Running tests locally

You can create your own `Dockerfile` from this image to run your tests:
```
FROM mebibou/up-docker-protractor:latest
# Add your source files necessary for the build and run
ADD . .
# Build your files
```
And then build and run:
```
$ docker build -t $IMAGE .
$ docker run -i --rm --privileged --net=host -v /dev/shm:/dev/shm $IMAGE run-protractor protractor.conf.js
```
You can have a look at https://github.com/hortonworks/docker-e2e-protractor#to-run-your-test-cases-in-this-image to see the options on running protractor, make sure to include `run-protractor` before the conf file.

## Gitlab CI

To use on gitlab, edit your `.gitlab-ci.yml` test stage:
```
test:
  image: mebibou/up-docker-protractor
  script:
    # build your project
    - npm run build
    # use image protractor run script
    - run-protractor protractor.conf.js
  artifacts:
    paths:
      # keep reports configured in your protractor.conf.js
      - reports/
```
