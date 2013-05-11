
begin
  include_recipe "logrotate"

  if node['graphite']['install_carbon']
    cookbook_file "/opt/graphite/disable_carbon_logrotate.patch" do
      owner node['graphite']['user']
      group node['graphite']['group']
    end
    
    cookbook_file "/opt/graphite/disable_webapp_logrotate.patch" do
      owner node['graphite']['user']
      group node['graphite']['group']
    end
    
    execute "apply-disable-carbon-logrotate-patch" do
      command "patch -b -p1 -i /opt/graphite/disable_carbon_logrotate.patch"
      cwd "/opt/graphite"
      not_if { ::File.exists?("/opt/graphite/lib/carbon/log.py.orig") }
    end
    
    execute "apply-disable-webapp-logrotate-patch" do
      command "patch -b -p1 -i /opt/graphite/disable_webapp_logrotate.patch"
      cwd "/opt/graphite"
      not_if { ::File.exists?("/opt/graphite/webapp/graphite/logger.py.orig") }
    end
    
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
    
    if node['graphite']['carbon']['enable_relay']
      logrotate_app "carbon-relay" do
        cookbook "logrotate"
        path "/opt/graphite/storage/log/carbon-relay/carbon-relay-a/*.log"
        options ["missingok", "compress", "copytruncate"]
        frequency "weekly"
        create "644 #{node['graphite']['user']} #{node['graphite']['group']}"
        rotate 4
      end
    end
    
    if node['graphite']['carbon']['enable_aggregator']
      logrotate_app "carbon-aggregator" do
        cookbook "logrotate"
        path "/opt/graphite/storage/log/carbon-aggregator/carbon-aggregator-a/*.log"
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
