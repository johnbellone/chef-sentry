name 'default'
default_source :community
cookbook 'ubuntu'
cookbook 'sentry', path: File.expand_path('../../../..', __FILE__)
run_list 'ubuntu::default', 'sentry::default'
