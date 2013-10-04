
dep_pkgs = %w[]

case node['platform']
when 'debian'
  case node['platform_version'].to_i
  when 6
    dep_pkgs = %w[python-cairo python-django python-django-tagging python-flup python-memcache python-pysqlite2 python-rrdtool python-simplejson python-twisted]
  end
end

dep_pkgs.each do |p|
  package p
end

dep_pip_pkgs = %w[whisper txamqp]
dep_pip_pkgs.each do |p|
  python_pip p do
    action :install
  end
end

if node['graphite']['install_carbon']
  python_pip 'carbon' do
    version node['graphite']['install_carbon_version']
    action :install
  end
end

if node['graphite']['install_webapp']
  python_pip 'graphite-web' do
    version node['graphite']['install_webapp_version']
    action :install
  end
end
