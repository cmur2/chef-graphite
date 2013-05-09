
if node['graphite']['install_target'] == 'both' or node['graphite']['install_target'] == 'carbon'
  include_recipe 'graphite::configure_carbon'
end


if node['graphite']['install_target'] == 'both' or node['graphite']['install_target'] == 'graphite-web'
  include_recipe 'graphite::configure_webapp'
end
