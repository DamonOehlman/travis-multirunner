# Travis Multirunner

This is a set of scripts designed to help you get up and running multibrowser tests on [travis](http://travis-ci.org). The scripts themselves are designed to be fetched during a travis `before_script` process and used to prepare your environment.

[![NPM](https://nodei.co/npm/travis-multirunner.png)](https://nodei.co/npm/travis-multirunner/)

[![Build Status](https://travis-ci.org/DamonOehlman/travis-multirunner.svg?branch=master)](https://travis-ci.org/DamonOehlman/travis-multirunner)
[![bitHound Overall Score](https://www.bithound.io/github/DamonOehlman/travis-multirunner/badges/score.svg)](https://www.bithound.io/github/DamonOehlman/travis-multirunner)

## Usage

Using `travis-multirunner` has never been easier, simply install using:

```
npm install travis-multirunner@latest --save-dev
```

Most of the work will be done for you!  A `.travis.yml` configuration file will be generated from the [`template.yaml`](https://github.com/DamonOehlman/travis-multirunner/blob/master/template.yaml) file in this repo and should allow you to start making use of environment variable driven travis [build matrix](http://docs.travis-ci.com/user/build-configuration/#The-Build-Matrix) builds.

### Use with testling

For use with [`testling`](https://github.com/substack/testling):

- install required dev dependencies

  ```
  npm install testling --save-dev
  ```

- Add the following command to your npm `test` script:

  ```
  testling -x start-$BROWSER
  ```

### Use with broth

For use with [`broth`](https://github.com/DamonOehlman/broth):

- install required dev dependencies

  ```
  npm install browserify broth tap-spec --save-dev
  ```

- Add the following command to your npm `test` script:

  ```
  browserify test/all.js | broth ./start.sh | tap-spec
  ```

### Use with smokestack

Use with [`smokestack`](https://github.com/hughsk/smokestack) has not yet been investigated...

## Contributing

If you want to patch travis-multirunner, here's what you have to do:

- clone this repo
- npm install
- export BROWSER=chrome BVER=stable (or any other combo of your choice).
  This is required for the next steps.
- ./setup.sh
- npm test
- exit the browser started

Make your patches and test them in the usual fashion, and create a pull
request. The pull request will run Travis to verify that your patch works
for all the standard browser combos.

## Prior Art

None of this would have been possible without the docs and code listed below:

- [Automated testing in Travis CI for WebRTC](http://lynckia.com/licode/travis-webrtc.html)

- `.travis-setup.sh` from the [web-animations-js](https://github.com/web-animations/web-animations-js) project

- Travis docs on [GUI and Headless Browsers](http://docs.travis-ci.com/user/gui-and-headless-browsers/)

## LICENSE

### ISC

Copyright (c) 2015, Damon Oehlman <damon.oehlman@gmail.com>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
