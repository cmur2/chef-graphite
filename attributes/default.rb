
default['graphite']['install_mode'] = 'both'
default['graphite']['user'] = 'graphite'
default['graphite']['group'] = 'graphite'

default['graphite']['webapp']['local_settings'] = {}
default['graphite']['webapp']['adapter'] = 'fastcgi'

default['graphite']['webapp']['fastcgi']['host'] = '127.0.0.1'
default['graphite']['webapp']['fastcgi']['port'] = '3000'
