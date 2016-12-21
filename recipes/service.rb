apt_package "python-software-properties" do
  action :install
end

# start services

include_recipe "supervisor"

node[:deploy].each do |application, deploy|

  supervisor_service "que" do
    action :enable
    user deploy[:user]
    directory "#{deploy[:deploy_to]}/current"
    environment RAILS_ENV: 'production'
    command "./bin/que --worker-count #{node[:que][:worker_count]} -l debug ./config/environment.rb"
    stopsignal "KILL"
  end

end
