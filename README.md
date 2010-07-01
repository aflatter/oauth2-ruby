Introduction
===========

oauth2-ruby is a Ruby library that makes it easy for developers to use OAuth2 protocol, currently in use in sites such as Facebook, Twitter and Launchpad (37 Signals).

**Disclaimer:** As this is alpha software, it is suspected to change and considered unstable.

## OAuth 2 protocol compliance

The current implementation of the gem is based on OAuth2 draft 00 (more about it [here](http://tools.ietf.org/html/draft-ietf-oauth-v2-00) and [here](http://tools.ietf.org/html/draft-hammer-oauth2-00)). Our goal is to support [Draft 09](http://tools.ietf.org/html/draft-ietf-oauth-v2-09) by the time gem hits version 1.0.

## Packages

Currently the project consists of three seperate packages: oauth2-core, oauth2-server and oauth2-client - the latter will be available soon.

### oauth2-core

* makes parsing, validating and building [_Authorization_](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-5.1) and [_WWW-Authenticate_](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-6.1) headers easy
* implements OAuth2::Attributes which gives the possibility to set an attribute via callback (blocks), accessor or passing a hash on object initialization. This ensures that the library is very flexible.

### oauth2-server

* provides different flows according to the OAuth2 specification. Currently, only the [web server](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-3.5.2) flow is implemented.
* makes handling OAuth2 requests easy. It currently supports [bearer](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-5.2) and [cryptographic](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-5.3) requests.

Getting started
===============

The [wiki](http://github.com/aflatter/oauth2-ruby/wikis) features some examples.

How to contribute
=================

If you wish to helps us make OAuth 2 an easy ride with Ruby, please take note of the following:

* If you have an issue, please submit it [here on Github](http://github.com/aflatter/oauth2-ruby/issues)
* Should you wish to commit a patch, please fork the project and send a pull request. But - please - don't forget the tests :)

License
=======

This Ruby GEM is made available to you under the [MIT license](http://github.com/aflatter/oauth2-ruby/blob/master/MIT-LICENSE).
