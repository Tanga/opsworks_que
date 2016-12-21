# Adapted from unicorn::rails: https://github.com/aws/opsworks-cookbooks/blob/master/unicorn/recipes/rails.rb

apt_package "python-software-properties" do
  action :install
end

include_recipe "supervisor"

# setup que service per app
node[:deploy].each do |application, deploy|

  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping opsworks_que::setup application #{application} as it is not a Rails app")
    next
  end

  supervisor_service "que" do
    action :enable
    user deploy[:user]
    directory "#{deploy[:deploy_to]}/current"
    environment RAILS_ENV: 'production'
    command "./bin/que --worker-count #{node[:que][:worker_count]} -l debug ./config/environment.rb"
    stopsignal "KILL"
  end

  opsworks_deploy_user do
    deploy_data deploy
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

end
