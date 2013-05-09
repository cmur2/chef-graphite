
default['graphite']['install_target'] = 'both'
default['graphite']['user'] = 'graphite'
default['graphite']['group'] = 'graphite'

default['graphite']['webapp']['local_settings'] = {}
default['graphite']['webapp']['flavor'] = 'fastcgi'

default['graphite']['webapp']['fastcgi']['host'] = '127.0.0.1'
default['graphite']['webapp']['fastcgi']['port'] = '8080'
