
if node['graphite']['install_carbon']
  include_recipe 'graphite::configure_carbon'
end


if node['graphite']['install_webapp']
  include_recipe 'graphite::configure_webapp'
end
