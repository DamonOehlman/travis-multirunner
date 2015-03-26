# Travis Multirunner

This is a set of scripts designed to help you get up and running multibrowser tests on [travis](http://travis-ci.org). The scripts themselves are designed to be fetched during a travis `before_install` process and used to prepare your environment.

[![NPM](https://nodei.co/npm/travis-multirunner.png)](https://nodei.co/npm/travis-multirunner/)

[![Build Status](https://travis-ci.org/DamonOehlman/travis-multirunner.svg?branch=master)](https://travis-ci.org/DamonOehlman/travis-multirunner)

## Usage

Using `travis-multirunner` has never been easier, simply install using:

```
npm install travis-multirunner@latest --save-dev
```

Most of the work will be done for you!  A `.travis.yml` configuration file will be generated from the [`template.yaml`](https://github.com/DamonOehlman/travis-multirunner/blob/master/template.yaml) file in this repo and should allow you to start making use of environment variable driven travis [build matrix](http://docs.travis-ci.com/user/build-configuration/#The-Build-Matrix) builds.

### Use with testling

To use travis-multirunner in conjunection with [`testling`](https://github.com/substack/testling), use the following command as part of you `npm test` command:

```
testling -x ./start-$BROWSER.sh
```

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