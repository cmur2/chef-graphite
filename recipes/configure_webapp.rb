
template '/etc/init.d/graphite-webapp' do
  source "graphite-webapp-#{node['graphite']['webapp']['adapter']}.sh.erb"
  mode 00755
end

execute 'chown-storage-dir' do
  command "chown -R #{node['graphite']['user']}:#{node['graphite']['group']} /opt/graphite/storage"
end

file "/opt/graphite/webapp/graphite/local_settings.py" do
  content node.generate_local_settings
  owner node['graphite']['user']
  group node['graphite']['group']
  mode 00660
  notifies :restart, "service[graphite-webapp]"
end

file "/opt/graphite/conf/dashboard.conf" do
  content node.generate_ini(node['graphite']['webapp']['dashboard'])
  owner node['graphite']['user']
  group node['graphite']['group']
  mode 00660
  notifies :restart, "service[graphite-webapp]"
end

file "/opt/graphite/conf/graphTemplates.conf" do
  content node.generate_ini(node['graphite']['webapp']['graphTemplates'])
  owner node['graphite']['user']
  group node['graphite']['group']
  mode 00660
  notifies :restart, "service[graphite-webapp]"
end

# execute after generating config
execute 'setup-django-database' do
  command 'python manage.py syncdb --noinput'
  cwd '/opt/graphite/webapp/graphite'
  user node['graphite']['user']
  group node['graphite']['group']
  not_if 'test -f /opt/graphite/storage/graphite.db'
end

service "graphite-webapp" do
  action [:enable, :start]
end
