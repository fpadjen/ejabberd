#
# Cookbook Name:: ejabberd
# Recipe:: default
#
# All rights reserved - Do Not Redistribute
#

# get our self-built package
remote_file "/tmp/ejabberd.deb" do
  # TODO ejabberd_#{version}_#{arch}.deb
  # TODO find storage for our debs
  source "https://baal.lab6.org/ejabberd.deb"
  checksum "6587b9db76b209ac64bc051c404959835a212d076a57861679cfe428e7d8c562" # SHA256
  mode 0644
  not_if "dpkg -l | grep ejabberd"
end

# install fetched deb package
dpkg_package "ejabberd" do
  source "/tmp/ejabberd.deb"
  not_if "dpkg -l | grep ejabberd"
  action :install
end

# create config file from template
template "/etc/ejabberd/ejabberd.yml"
  source "ejabberd_yml.erb"
  action :create_if_missing
  mode 0644
  owner "ejabberd"
  group "ejabberd"
end
