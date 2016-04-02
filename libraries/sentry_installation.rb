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
    # @provides sentry_installation
    # @since 1.0
    class SentryInstallation < Chef::Resource
      include Poise(fused: true)
      provides(:sentry_installation)

      attribute(:version, kind_of: String, name_attribute: true)
      attribute(:owner, kind_of: String, default: 'sentry')
      attribute(:group, kind_of: String, default: 'sentry')
      attribute(:directory, kind_of: String, default: '/srv/sentry')
      attribute(:pip_dependencies, kind_of: Hash, default: lazy { default_pip_dependencies })

      def default_pip_dependencies
        { 'django-secure' => {version: '1.0.1'},
          'django-bcrypt' => {version: '0.9.2'},
          'django-sendmail-backend' => {version: '0.1.2'} }
      end

      action(:create) do
        directory ::File.join(new_resource.directory, 'data') do
          recursive true
          owner new_resource.user
          owner new_resource.group
        end

        if node.platform_family?('debian')
          package %w{libxml2-dev libxslt1-dev libffi-dev libyaml-dev libpq-dev libz-dev libssl-dev}
        end

        if node.platform_family?('rhel')
          package %w{libxml2-devel libxslt1-devel libffi-devel libyaml-devel libpq-devel libz-devel libssl-devel}
        end

        include_recipe 'poise-python::default'

        python_virtualenv new_resource.directory do
          owner new_resource.user
          group new_resource.group
        end

        python_package 'sentry' do
          version new_resource.version
          user new_resource.user
          group new_resource.group
          virtualenv new_resource.directory
        end

        new_resource.pip_dependencies.each_pair do |name, options|
          python_package name do
            version options[:version]
            user new_resource.user
            group new_resource.group
            virtualenv new_resource.directory
          end
        end
      end
    end
  end
end
