
default['graphite']['install_carbon'] = true
default['graphite']['install_webapp'] = true
default['graphite']['user'] = 'graphite'
default['graphite']['group'] = 'graphite'

default['graphite']['webapp']['local_settings'] = {}
default['graphite']['webapp']['adapter'] = 'fastcgi'

default['graphite']['webapp']['fastcgi']['host'] = '127.0.0.1'
default['graphite']['webapp']['fastcgi']['port'] = '3000'

default['graphite']['carbon']['main'] = {
  'cache' => {
    'USER' => '',
    'MAX_CACHE_SIZE' => 'inf',
    'MAX_UPDATES_PER_SECOND' => '500',
    'MAX_CREATES_PER_MINUTE' => '50',
    'LINE_RECEIVER_INTERFACE' => '0.0.0.0',
    'LINE_RECEIVER_PORT' => '2003',
    'ENABLE_UDP_LISTENER' => 'False',
    'UDP_RECEIVER_INTERFACE' => '0.0.0.0',
    'UDP_RECEIVER_PORT' => '2003',
    'PICKLE_RECEIVER_INTERFACE' => '0.0.0.0',
    'PICKLE_RECEIVER_PORT' => '2004',
    'USE_INSECURE_UNPICKLER' => 'False',
    'CACHE_QUERY_INTERFACE' => '0.0.0.0',
    'CACHE_QUERY_PORT' => '7002',
    'USE_FLOW_CONTROL' => 'True',
    'LOG_UPDATES' => 'False',
    'WHISPER_AUTOFLUSH' => 'False'
  },
  'relay' => {
    'LINE_RECEIVER_INTERFACE' => '0.0.0.0',
    'LINE_RECEIVER_PORT' => '2013',
    'PICKLE_RECEIVER_INTERFACE' => '0.0.0.0',
    'PICKLE_RECEIVER_PORT' => '2014',
    'RELAY_METHOD' => 'rules',
    'REPLICATION_FACTOR' => '1',
    'DESTINATIONS' => '127.0.0.1:2004',
    'MAX_DATAPOINTS_PER_MESSAGE' => '500',
    'MAX_QUEUE_SIZE' => '10000',
    'USE_FLOW_CONTROL' => 'True'
  },
  'aggregator' => {
    'LINE_RECEIVER_INTERFACE' => '0.0.0.0',
    'LINE_RECEIVER_PORT' => '2023',
    'PICKLE_RECEIVER_INTERFACE' => '0.0.0.0',
    'PICKLE_RECEIVER_PORT' => '2024',
    'DESTINATIONS' => '127.0.0.1:2004',
    'REPLICATION_FACTOR' => '1',
    'MAX_QUEUE_SIZE' => '10000',
    'USE_FLOW_CONTROL' => 'True',
    'MAX_DATAPOINTS_PER_MESSAGE' => '500',
    'MAX_AGGREGATION_INTERVALS' => '5'
  }
}

default['graphite']['carbon']['storage-schemas'] = {
  'default_1min_for_1day' => {
    'pattern' => '^.*',
    'retentions' => '60s:1d'
  }
}

default['graphite']['carbon']['storage-aggregation'] = {}

default['graphite']['carbon']['relay-rules'] = {}

default['graphite']['carbon']['aggregation-rules'] = []

default['graphite']['carbon']['whitelist'] = []

default['graphite']['carbon']['blacklist'] = []
