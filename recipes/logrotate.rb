
begin
  include_recipe "logrotate"

  if node['graphite']['install_carbon']
    if node['graphite']['carbon']['enable_cache']
      logrotate_app "carbon-cache" do
        cookbook "logrotate"
        path "/opt/graphite/storage/log/carbon-cache/carbon-cache-a/*.log"
        options ["missingok", "compress", "copytruncate"]
        frequency "weekly"
        create "644 #{node['graphite']['user']} #{node['graphite']['group']}"
        rotate 4
      end
    end
  end
  
  if node['graphite']['install_webapp']
    logrotate_app "graphite" do
      cookbook "logrotate"
      path "/opt/graphite/storage/log/webapp/*.log"
      options ["missingok", "compress", "copytruncate"]
      frequency "weekly"
      create "644 #{node['graphite']['user']} #{node['graphite']['group']}"
      rotate 4
    end
  end
rescue
  Chef::Log.error "graphite::logrotate requires the logrotate cookbook!"
end
