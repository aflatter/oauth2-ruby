oauth2-ruby
===========

oauth2-ruby is an implementation of the current [OAuth2 draft](http://tools.ietf.org/html/draft-hammer-oauth2-00) in [Ruby](http://ruby-lang.com) released under the [MIT license](http://github.com/aflatter/oauth2-ruby/blob/master/MIT-LICENSE). The project at the moment consists of three seperate packages: oauth2-core, oauth2-server and oauth2-client - the latter will be available soon.

**Disclaimer:** As this is alpha software, it is suspected to change and considered unstable.

## oauth2-core

* makes parsing, validating and building [_Authorization_](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-5.1) and [_WWW-Authenticate_](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-6.1) headers easy
* implements OAuth2::Attributes which gives the possibility to set an attribute via callback (blocks), accessor or passing a hash on object initialization. This ensures that the library is very flexible.

## oauth2-server

* provides different flows according to the OAuth2 specification. Currently, only the [web server](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-3.5.2) flow is implemented.
* makes handling OAuth2 requests easy. It currently supports [bearer](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-5.2) and [cryptographic](http://tools.ietf.org/html/draft-hammer-oauth2-00#section-5.3) requests.

Getting started
===============

The [wiki](http://github.com/aflatter/oauth2-ruby/wikis) features some examples.