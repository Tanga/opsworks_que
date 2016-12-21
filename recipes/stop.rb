# Adapted from nginx::stop: https://github.com/aws/opsworks-cookbooks/blob/master/nginx/recipes/stop.rb

include_recipe "opsworks_que::service"

node[:deploy].each do |application, deploy|

  supervisor_service "que" do
    action :restart
  end

end
