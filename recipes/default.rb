
include_recipe 'python'

# create graphite user and group
user node['graphite']['user']
group node['graphite']['group'] do
  members [node['graphite']['user']]
end

include_recipe 'graphite::install'
include_recipe 'graphite::configure'
