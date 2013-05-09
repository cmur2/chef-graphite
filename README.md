# chef-graphite

[![Build Status](https://travis-ci.org/cmur2/chef-graphite.png)](https://travis-ci.org/cmur2/chef-graphite)

## Description

Installs and configures carbon and/or graphite-webapp (including whisper and other required dependencies). Against others there will be no webserver etc. setup because that's another cookbook's job.

### Limitations

* there is currently only a Debian 6 init script using FastCGI adapter

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

## License

chef-graphite is licensed under the Apache License, Version 2.0. See LICENSE for more information.
