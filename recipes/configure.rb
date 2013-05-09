
if node['graphite']['install_mode'] == 'both' or node['graphite']['install_mode'] == 'carbon'
  include_recipe 'graphite::configure_carbon'
end


if node['graphite']['install_mode'] == 'both' or node['graphite']['install_mode'] == 'graphite-web'
  include_recipe 'graphite::configure_webapp'
end
