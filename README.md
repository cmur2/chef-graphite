# chef-graphite

[![Build Status](https://travis-ci.org/cmur2/chef-graphite.png)](https://travis-ci.org/cmur2/chef-graphite)

## Description

Installs and configures Carbon and/or [Graphite](http://graphite.readthedocs.org/) (the webapp) (including whisper and other required dependencies). Against others there will be no webserver etc. setup because that's another cookbook's job.

### Limitations

* there is currently only a Debian 6 init script using FastCGI adapter
* only one carbon daemon of each type per machine
* can install graphite only in /opt/graphite
* maybe support build-index.sh for search indexes via cron?

Internals:

* no typed configuration files where e.g. nested array might be transformed into matching data structure, so everything are plain strings
* `USER = graphite_user` in carbon.conf unsupported

## Usage

Use `recipe[graphite::default]` for getting the full program including standalone carbon-cache and/or graphite-webapp with AMQP and RRD support enabled. You can customize everything (enabling the other carbon daemons etc) when using the default recipe - all other recipes not explicitly listed here are for internal use only.

With `recipe[graphite::logrotate]` you will get *logrotate*-based log file rotation for */opt/graphite/storage/log* automatically for every component you have enabled (out of the carbon-x family + webapp). **But be careful**: since carbon uses it's own *twisted*-based log rotation this recipe will (try to) patch your */opt/graphite/lib/carbon/log.py* file to disable this.

## Requirements

### Platform

Since this cookbook heavily relies on Pythons `pip` to install the graphite components it should work on any platform that supports it but several dependencies are also pulled in via systems package control, where only Debian is currently supported.

It's known to work with Graphite components around version 0.9.10.

Required cookbooks: python

For supported Chef/Ruby version see [Travis](https://travis-ci.org/cmur2/chef-graphite).

## Recipes

### default

Carbon gets installed and configures when `node['graphite']['install_carbon']` is true. Graphite webbapp gets installed and configures when `node['graphite']['install_webapp']` is true.

The version to be installed is pinned to specific versions so python_pip does not always upgrade to `'latest'` version, change via `node['graphite']['install_carbon_version']` and `node['graphite']['install_webapp_version']`.

All graphite services will run as and relevant directories will belong to `node['graphite']['user']` and `node['graphite']['group']` where the default is `graphite`/`graphite`.

#### Webapp

The webapp is configured with the hash `node['graphite']['webapp']['local_settings']` that is directly used to build the `local_settings.py`, every entry in the hash is converted into a python statement of the form `key = value` which allows any values.

The `node['graphite']['webapp']['adapter']` is used to specify the webapps adapter like FastCGI/uwsgi etc where only FastCGI is implemented currently (submit pull requests or issues for more).

Each adapters settings are below `node['graphite']['webapp']['<adapter_name>']` and specific for each adapter:

* FastCGI: `node['graphite']['webapp']['fastcgi']['host']` and `node['graphite']['webapp']['fastcgi']['port']` to listen for connections

The dashboard config is built from `node['graphite']['webapp']['dashboard']` (ini format).

The graph templates are built from `node['graphite']['webapp']['graphTemplates']` (ini format).

#### Carbon

There are three daemons in the carbon family and you can use the boolean `node['graphite']['carbon']['enable_cache']` / `node['graphite']['carbon']['enable_relay']` / `node['graphite']['carbon']['enable_aggregator']` to decide which should be started.

The carbon config resides under `node['graphite']['carbon']` where the separate config files are built from:

* `node['graphite']['carbon']['main']` for carbon.conf (ini format)
* `node['graphite']['carbon']['storage-schemas']` for storage-schemas.conf (ini format)
* `node['graphite']['carbon']['storage-aggregation']` for storage-aggregation.conf (ini format)
* `node['graphite']['carbon']['relay-rules']` for relay-rules.conf (ini format)
* `node['graphite']['carbon']['aggregation-rules']` for aggregation-rules.conf (line list format)
* `node['graphite']['carbon']['whitelist']` for whitelist.conf (line list format)
* `node['graphite']['carbon']['blacklist']` for blacklist.conf (line list format)

#### File Formats

Regarding the different formats and how they are mapped onto Ruby data structures:

* ini format: a file is represented as a hash of `section_name => section_content` where `section_content` is another hash containing the section's content as simple key/value pairs (both strings). Corner case: an empty string for the section_content skips the whole section in case you want to e.g. overwrite a predefined section.
* line list format: a file is represented as an array of strings for each line

## Notes

The carbon-cache (and therefore derived carbon-relay/carbon-aggregator) Debian 6 init script was [stolen here](https://gist.github.com/chalmerj/1492384).

The *disable_internal_logrotate.patch* comes from [here](http://anonscm.debian.org/gitweb/?p=pkg-graphite/packages/graphite-carbon.git;a=blob_plain;f=debian/patches/disable_internal_logroate.patch;hb=HEAD).

## License

chef-graphite is licensed under the Apache License, Version 2.0. See LICENSE for more information.
