#
# Cookbook Name:: riak
# Recipe:: default
# Author:: Ben Browning <bbrowning@trengine.com>
#
# Copyright 2010, Trengine
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

riak_version = node[:riak][:version]

remote_file "/tmp/riak-#{riak_version}.tar.gz" do
  source "http://bitbucket.org/basho/riak/get/riak-#{riak_version}.tar.gz"
  action :create_if_missing
end

bash "build_riak" do
  cwd "/tmp"
  code <<-EOH
    tar xzf riak-#{riak_version}.tar.gz
    cd riak
    PATH=$PATH:#{node[:erlang][:install_path]}/bin make all rel
    cp -r rel/riak #{node[:riak][:install_path]}
  EOH
  creates node[:riak][:src_binary]
end

template "/etc/init.d/riak" do
  source "riak-init.d.erb"
  mode "0755"
end

service "riak" do
  supports :start => true, :restart => true, :stop => true
  status_command "ping"
  subscribes :restart, resources(:bash => "build_riak")
  action [:enable, :start]
end
