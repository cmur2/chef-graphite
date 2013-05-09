# chef-graphite

[![Build Status](https://travis-ci.org/cmur2/chef-graphite.png)](https://travis-ci.org/cmur2/chef-graphite)

## Description

Installs and configures carbon and/or graphite-webapp (including whisper and other required dependencies). Against others there will be no webserver etc. setup because that's another cookbook's job.

### Limitations

* there is currently only a Debian 6 init script using FastCGI adapter
* carbon-relay/carbon-aggregator service management missing (only config)
* carbon-cache is started automatically without choice which out of the carbon-X family to start
* no typed configuration files where e.g. nested array might be transformed into matching data structure, so everything are plain strings

## Usage

Use `recipe[graphite::default]` for getting the full program including standalone carbon and graphite-webapp with AMQP and RRD support enabled.

## Requirements

### Platform

Since this cookbook heavily relies on Pythons `pip` to install the graphite components it should work on any platform that supports it but several dependencies are also pulled in via systems package control, where only Debian is currently supported.

Other cookbooks: python.

## Recipes

### default

By using `node['graphite']['install_mode']` you can choose between three different modes: the default `'both'` will install carbon and the graphite webapp, `'carbon'` will only install the first, `'graphite-web'` only the latter.

All graphite services will run as and relevant directories will belong to `node['graphite']['user']` and `node['graphite']['group']` where the default is `graphite`/`graphite`.

The webapp is configured with the hash `node['graphite']['webapp']['local_settings']` that is directly used to build the `local_settings.py`, every entry in the hash is converted into a python statement of the form `key = value` which allows any values.

The `node['graphite']['webapp']['adapter']` is used to specify the webapps adapter like FastCGI/uwsgi etc where only FastCGI is implemented currently (submit pull requests or issues for more).

Each adapters settings are below `node['graphite']['webapp']['<adapter_name>']` and specific for each adapter:

* FastCGI: `node['graphite']['webapp']['fastcgi']['host']` and `node['graphite']['webapp']['fastcgi']['port']` to listen for connections

The carbon config resides under `node['graphite']['carbon']` where the separate config files are built from:

* `node['graphite']['carbon']['main']` for carbon.conf (ini format)
* `node['graphite']['carbon']['storage-schemas']` for storage-schemas.conf (ini format)
* `node['graphite']['carbon']['storage-aggregation']` for storage-aggregation.conf (ini format)
* `node['graphite']['carbon']['relay-rules']` for relay-rules.conf (ini format)
* `node['graphite']['carbon']['aggregation-rules']` for aggregation-rules.conf (line list format)
* `node['graphite']['carbon']['whitelist']` for whitelist.conf (line list format)
* `node['graphite']['carbon']['blacklist']` for blacklist.conf (line list format)

Regarding the different formats and how they are mapped onto Ruby data structures:

* ini format: a file is represented as a hash of `section_name => section_content` where `section_content` is another hash containing the section's content as simple key/value pairs (both strings)
* line list format: a file is represented as an array of strings for each line

## Notes

carbon-cache Debian 6 init script was [stolen here](https://gist.github.com/chalmerj/1492384).

## License

chef-graphite is licensed under the Apache License, Version 2.0. See LICENSE for more information.
