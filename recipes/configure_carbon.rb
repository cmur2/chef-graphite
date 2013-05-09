
template '/etc/init.d/carbon-cache' do
  source "carbon-cache.sh.erb"
  mode 00755
end

file "/opt/graphite/conf/carbon.conf" do
  content node.generate_ini(node['graphite']['carbon']['main'])
  #owner node['graphite']['user']
  #group node['graphite']['group']
  #mode 00660
  notifies :restart, "service[carbon-cache]"
end

file "/opt/graphite/conf/storage-schemas.conf" do
  content node.generate_ini(node['graphite']['carbon']['storage-schemas'])
  notifies :restart, "service[carbon-cache]"
end

file "/opt/graphite/conf/storage-aggregation.conf" do
  content node.generate_ini(node['graphite']['carbon']['storage-aggregation'])
  notifies :restart, "service[carbon-cache]"
end

file "/opt/graphite/conf/relay-rules.conf" do
  content node.generate_ini(node['graphite']['carbon']['relay-rules'])
  notifies :restart, "service[carbon-cache]"
end

file "/opt/graphite/conf/aggregation-rules.conf" do
  content node.generate_lines(node['graphite']['carbon']['aggregation-rules'])
  notifies :restart, "service[carbon-cache]"
end

file "/opt/graphite/conf/whitelist.conf" do
  content node.generate_lines(node['graphite']['carbon']['whitelist'])
  notifies :restart, "service[carbon-cache]"
end

file "/opt/graphite/conf/blacklist.conf" do
  content node.generate_lines(node['graphite']['carbon']['blacklist'])
  notifies :restart, "service[carbon-cache]"
end

service "carbon-cache" do
  action [:enable, :start]
end
