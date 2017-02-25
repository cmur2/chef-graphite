
# pin specific versions so python_pip does not always upgrade to 'latest'
default['graphite']['install_carbon_version'] = '0.9.12'
default['graphite']['install_webapp_version'] = '0.9.12'
default['graphite']['install_carbon'] = true
default['graphite']['install_webapp'] = true
default['graphite']['user'] = 'graphite'
default['graphite']['group'] = 'graphite'

default['graphite']['webapp']['local_settings'] = {}

default['graphite']['webapp']['dashboard'] = {
  'ui' => {
    'default_graph_width' => '400',
    'default_graph_height' => '250',
    'automatic_variants' => 'true',
    'refresh_interval' => '60',
    'autocomplete_delay' => '375',
    'merge_hover_delay' => '750',
    'theme' => 'default'
  }
}

default['graphite']['webapp']['graphTemplates'] = {
  'default' => {
    'background' => 'black',
    'foreground' => 'white',
    'majorLine' => 'white',
    'minorLine' => 'grey',
    'lineColors' => 'blue,green,red,purple,brown,yellow,aqua,grey,magenta,pink,gold,rose',
    'fontName' => 'Sans',
    'fontSize' => '10',
    'fontBold' => 'False',
    'fontItalic' => 'False'
  },
  'noc' => {
    'background' => 'black',
    'foreground' => 'white',
    'majorLine' => 'white',
    'minorLine' => 'grey',
    'lineColors' => 'blue,green,red,yellow,purple,brown,aqua,grey,magenta,pink,gold,rose',
    'fontName' => 'Sans',
    'fontSize' => '10',
    'fontBold' => 'False',
    'fontItalic' => 'False'
  },
  'plain' => {
    'background' => 'white',
    'foreground' => 'black',
    'minorLine' => 'grey',
    'majorLine' => 'rose'
  },
  'summary' => {
    'background' => 'black',
    'lineColors' => '#6666ff, #66ff66, #ff6666'
  },
  'alphas' => {
    'background' => 'white',
    'foreground' => 'black',
    'majorLine' => 'grey',
    'minorLine' => 'rose',
    'lineColors' => '00ff00aa,ff000077,00337799'
  }
}

default['graphite']['webapp']['adapter'] = 'fastcgi'
default['graphite']['webapp']['fastcgi']['host'] = '127.0.0.1'
default['graphite']['webapp']['fastcgi']['port'] = '3000'

default['graphite']['carbon']['enable_cache'] = true
default['graphite']['carbon']['enable_relay'] = false
default['graphite']['carbon']['enable_aggregator'] = false

default['graphite']['carbon']['main'] = {
  'cache' => {
    'ENABLE_LOGROTATION' => 'False',
    'USER' => '',
    'MAX_CACHE_SIZE' => 'inf',
    'MAX_UPDATES_PER_SECOND' => '500',
    'MAX_CREATES_PER_MINUTE' => '50',
    'LINE_RECEIVER_INTERFACE' => '127.0.0.1',
    'LINE_RECEIVER_PORT' => '2003',
    'ENABLE_UDP_LISTENER' => 'False',
    'UDP_RECEIVER_INTERFACE' => '127.0.0.1',
    'UDP_RECEIVER_PORT' => '2003',
    'PICKLE_RECEIVER_INTERFACE' => '127.0.0.1',
    'PICKLE_RECEIVER_PORT' => '2004',
    'USE_INSECURE_UNPICKLER' => 'False',
    'CACHE_QUERY_INTERFACE' => '127.0.0.1',
    'CACHE_QUERY_PORT' => '7002',
    'USE_FLOW_CONTROL' => 'True',
    'LOG_UPDATES' => 'False',
    'WHISPER_AUTOFLUSH' => 'False'
  },
  'relay' => {
    'LINE_RECEIVER_INTERFACE' => '127.0.0.1',
    'LINE_RECEIVER_PORT' => '2013',
    'PICKLE_RECEIVER_INTERFACE' => '127.0.0.1',
    'PICKLE_RECEIVER_PORT' => '2014',
    'RELAY_METHOD' => 'rules',
    'REPLICATION_FACTOR' => '1',
    'DESTINATIONS' => '127.0.0.1:2004',
    'MAX_DATAPOINTS_PER_MESSAGE' => '500',
    'MAX_QUEUE_SIZE' => '10000',
    'USE_FLOW_CONTROL' => 'True'
  },
  'aggregator' => {
    'LINE_RECEIVER_INTERFACE' => '127.0.0.1',
    'LINE_RECEIVER_PORT' => '2023',
    'PICKLE_RECEIVER_INTERFACE' => '127.0.0.1',
    'PICKLE_RECEIVER_PORT' => '2024',
    'DESTINATIONS' => '127.0.0.1:2004',
    'REPLICATION_FACTOR' => '1',
    'MAX_QUEUE_SIZE' => '10000',
    'USE_FLOW_CONTROL' => 'True',
    'MAX_DATAPOINTS_PER_MESSAGE' => '500',
    'MAX_AGGREGATION_INTERVALS' => '5'
  }
}

default['graphite']['carbon']['storage-schemas'] = []

default['graphite']['carbon']['storage-aggregation'] = []

default['graphite']['carbon']['relay-rules'] = {}

default['graphite']['carbon']['aggregation-rules'] = []

default['graphite']['carbon']['whitelist'] = []

default['graphite']['carbon']['blacklist'] = []
