#
# Cookbook: sentry
# License: Apache 2.0
#
# Copyright 2013-2016, Openhood S.E.N.C.
# Copyright 2016, Bloomberg Finance L.P.
#

default['sentry']['service_name'] = 'sentry'
default['sentry']['service_user'] = 'sentry'
default['sentry']['service_group'] = 'sentry'
default['sentry']['service_home'] = '/srv/sentry'

default['sentry']['install']['version'] = '8.3.0'

default['sentry']['config']['options'] = {
  'allow_registration' => false,
  'public' => false,
  'beacon' => false,
  'secure_proxy_ssl_header' => false,
}
