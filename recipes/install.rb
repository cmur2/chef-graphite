
dep_pkgs = %w[python-cairo python-django python-django-tagging python-memcache python-pysqlite2 python-rrdtool python-simplejson python-twisted]
dep_pkgs.each do |p|
  package p
end

dep_pip_pkgs = %w[whsiper txamqp]
dep_pkgs.each do |p|
  python_pip p
end

if ['graphite']['install_target'] == 'both' or ['graphite']['install_target'] == 'carbon'
  python_pip 'carbon'
end

if ['graphite']['install_target'] == 'both' or ['graphite']['install_target'] == 'graphite-web'
  python_pip 'graphite-web'
end
