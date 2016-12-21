include_attribute "deploy"

default[:que] = {}
default[:que][:pool_size] = 4
default[:que][:worker_count] = 10

node[:deploy].each do |application, deploy|

  default[:que][application] = {}
  default[:que][application][:path_to_script] = node[:que][:path_to_script] || 'bin'
  default[:que][application][:pools] = {}

  # Default to node[:que][:pool_size] workers, each with empty ({}) config.
  default[:que][application][:pools][:default] = Hash[node[:que][:pool_size].times.map{|i| [i.to_s, {}] }]

  # Use node[:que][application][:pools][HOSTNAME] if provided.
  default[:que][application][:pool] = node[:que][application][:pools][node[:opsworks][:instance][:hostname]] || node[:que][application][:pools][:default]
  Chef::Log.debug("Set que attributes for #{application} to #{node[:que][application].to_hash.inspect}")

  default[:que][application][:restart_command] = "sudo monit restart -g que_#{application}_group"

  default[:que][:start_command] = './bin/que --worker-count 10 -l debug ./config/environment.rb'

end

