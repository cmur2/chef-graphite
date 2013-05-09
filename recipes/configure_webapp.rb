
template '/etc/init.d/graphite-webapp' do
  source "graphite-webapp-#{node['graphite']['webapp']['flavor']}.sh.erb"
  mode 00755
end

execute 'setup-django-database' do
  command 'python manage.py syncdb --noinput'
  cwd '/opt/graphite/webapp/graphite'
  user node['graphite']['user']
  group node['graphite']['group']
  not_if 'test -f /opt/graphite/storage/graphite.db'
end

execute 'chown-storage-dir' do
  command "chown -R #{node['graphite']['user']}:#{node['graphite']['group']} /opt/graphite/storage"
end

file "/opt/graphite/webapp/graphite/local_settings.py" do
  content node.generate_local_settings
  owner node['graphite']['user']
  group node['graphite']['group']
  mode 00660
end

service "graphite-webapp" do
  action [:enable, :start]
end
