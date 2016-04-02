#
# Cookbook: sentry
# License: Apache 2.0
#
# Copyright 2013-2016, Openhood S.E.N.C.
# Copyright 2016, Bloomberg Finance L.P.
#

group node['sentry']['service_group'] do
  system true
end

user node['sentry']['service_user'] do
  system true
  home node['sentry']['service_home']
  gid node['sentry']['service_group']
end

sentry_installation node['sentry']['install']['version'] do
  directory node['sentry']['service_home']
  user node['sentry']['service_user']
  group node['sentry']['service_group']
end

sentry_config node['sentry']['service_name'] do |r|
  path File.join(node['sentry']['service_home'], 'etc', 'config.py')
  owner node['sentry']['service_user']
  group node['sentry']['service_group']

  node['sentry']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "poise_service[#{name}]", :delayed
end

poise_service node['sentry']['service_name'] do
  command 'bin/sentry'
  user node['sentry']['service_user']
  directory node['sentry']['service_home']
end
