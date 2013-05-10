
file "/opt/graphite/conf/carbon.conf" do
  content node.generate_ini(node['graphite']['carbon']['main'])
  #owner node['graphite']['user']
  #group node['graphite']['group']
  #mode 00660
  notifies :restart, "service[carbon-cache]" if node['graphite']['carbon']['enable_cache']
  notifies :restart, "service[carbon-relay]" if node['graphite']['carbon']['enable_relay']
  notifies :restart, "service[carbon-aggregator]" if node['graphite']['carbon']['enable_aggregator']
end

# this file is scanned for changes every 60 seconds
file "/opt/graphite/conf/storage-schemas.conf" do
  content node.generate_ini(node['graphite']['carbon']['storage-schemas'])
end

# this file is scanned for changes every 60 seconds
file "/opt/graphite/conf/storage-aggregation.conf" do
  content node.generate_ini(node['graphite']['carbon']['storage-aggregation'])
end

file "/opt/graphite/conf/relay-rules.conf" do
  content node.generate_ini(node['graphite']['carbon']['relay-rules'])
  notifies :restart, "service[carbon-relay]" if node['graphite']['carbon']['enable_relay']
end

# this file will be re-read automatically by interested daemons
file "/opt/graphite/conf/aggregation-rules.conf" do
  content node.generate_lines(node['graphite']['carbon']['aggregation-rules'])
end

# this file will be re-read automatically by interested daemons
file "/opt/graphite/conf/whitelist.conf" do
  content node.generate_lines(node['graphite']['carbon']['whitelist'])
end

# this file will be re-read automatically by interested daemons
file "/opt/graphite/conf/blacklist.conf" do
  content node.generate_lines(node['graphite']['carbon']['blacklist'])
end

if node['graphite']['carbon']['enable_cache']
  template '/etc/init.d/carbon-cache' do
    source "carbon-cache.sh.erb"
    mode 00755
  end

  service "carbon-cache" do
    action [:enable, :start]
  end
end

if node['graphite']['carbon']['enable_relay']
  template '/etc/init.d/carbon-relay' do
    source "carbon-relay.sh.erb"
    mode 00755
  end

  service "carbon-relay" do
    action [:enable, :start]
  end
end

if node['graphite']['carbon']['enable_aggregator']
  template '/etc/init.d/carbon-aggregator' do
    source "carbon-aggregator.sh.erb"
    mode 00755
  end

  service "carbon-aggregator" do
    action [:enable, :start]
  end
end
