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

default['sentry']['install']['version'] = '7.7.1'

default['sentry']['config']['options'] = {
  'allow_registration' => false,
  'public' => false,
  'beacon' => false,
  'secure_proxy_ssl_header' => false,
}

default["sentry"]["env_d_path"] = "/etc/sentry.d"
default["sentry"]["env_path"] = "#{node["sentry"]["env_d_path"]}/env"

default["sentry"]["config"]["db_engine"] = "django.db.backends.postgresql_psycopg2"
default["sentry"]["config"]["db_options"] = {autocommit: true}
default["sentry"]["config"]["admin_email"] = ""
default["sentry"]["config"]["allow_registration"] = false
default["sentry"]["config"]["beacon"] = false
default["sentry"]["config"]["public"] = false
default["sentry"]["config"]["web_host"] = "127.0.0.1"
default["sentry"]["config"]["web_port"] = 9000
default["sentry"]["config"]["secure_proxy_ssl_header"] = false
default["sentry"]["config"]["web_options"] = {
  "workers" => 3,
  "secure_scheme_headers" => {
    "X-FORWARDED-PROTO" => "https"
  }
}
default["sentry"]["config"]["url_prefix"] = "http://localhost:#{node["sentry"]["config"]["web_port"]}"
default["sentry"]["config"]["email_default_from"] = "#{node["sentry"]["user"]}@#{node[:fqdn]}"
default["sentry"]["config"]["email_backend"] = "django.core.mail.backends.smtp.EmailBackend"
default["sentry"]["config"]["email_host"] = "localhost"
default["sentry"]["config"]["email_port"] = "25"
default["sentry"]["config"]["email_use_tls"] = false
default["sentry"]["config"]["email_subject_prefix"] = nil
default["sentry"]["config"]["additional_apps"] = ["djangosecure", "django_bcrypt"]
default["sentry"]["config"]["prepend_middleware_classes"] = ["djangosecure.middleware.SecurityMiddleware"]
default["sentry"]["config"]["append_middleware_classes"] = []
default["sentry"]["config"]["use_big_ints"] = true
# Redis config
default["sentry"]["config"]["redis_enabled"] = true
default["sentry"]["config"]["redis_config"]["hosts"][0]["host"] = "127.0.0.1"
default["sentry"]["config"]["redis_config"]["hosts"][0]["port"] = "6379"
# Cache config
default["sentry"]["config"]["cache"] = "sentry.cache.redis.RedisCache"
# Queue config
default["sentry"]["config"]["celery_always_eager"] = false # true will disable queue usage
default["sentry"]["config"]["broker_url"] = "redis://localhost:6379"
default["sentry"]["config"]["celeryd_concurrency"] = 1
default["sentry"]["config"]["celery_send_events"] = false
default["sentry"]["config"]["celerybeat_schedule_filename"] = "#{default["sentry"]["filestore_dir"]}/celery_beat_schedule"

default["sentry"]["config"]["ratelimiter"] = "sentry.ratelimits.redis.RedisRateLimiter"
default["sentry"]["config"]["buffer"] = "sentry.buffer.redis.RedisBuffer"
default["sentry"]["config"]["quotas"] = "sentry.quotas.redis.RedisQuota"
default["sentry"]["config"]["tsdb"] = "sentry.tsdb.redis.RedisTSDB"
# Filestore config
default["sentry"]["config"]["filestore"] = "django.core.files.storage.FileSystemStorage"
default["sentry"]["config"]["filestore_options"]["location"] = default["sentry"]["filestore_dir"]

default["sentry"]["data_bag"] = "sentry"
default["sentry"]["data_bag_item"] = "credentials"
default["sentry"]["use_encrypted_data_bag"] = false

default["sentry"]["manage_redis"] = true
