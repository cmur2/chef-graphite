
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

service "carbon-cache" do
  action [:enable, :start]
end
