#
# Cookbook: sentry
# License: Apache 2.0
#
# Copyright 2013-2016, Openhood S.E.N.C.
# Copyright 2016, Bloomberg Finance L.P.
#
require 'poise'

module SentryCookbook
  module Resource
    # @action create
    # @action remove
    # @provides sentry_config
    # @since 1.0
    class SentryConfig < Chef::Resource
      include Poise(fused: true)
      provides(:sentry_config)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:owner, kind_of: String, default: 'sentry')
      attribute(:group, kind_of: String, default: 'sentry')
      attribute(:mode, kind_of: String, default: '0400')
      attribute('',
                template: true,
                default_source: 'sentry.conf.py.erb',
                default_options: lazy { default_options })

      action(:create) do
        directory ::File.dirname(new_resource.path) do
          recursive true
          owner new_resource.owner
          group new_resource.group
        end

        file new_resource.path do
          content new_resource.content
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
        end
      end
    end
  end
end
