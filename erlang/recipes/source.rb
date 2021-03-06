#
# Cookbook Name:: erlang
# Recipe:: source
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

%w{ libncurses5-dev libssl-dev }.each do |devpkg|
  package devpkg
end

erlang_version = node[:erlang][:version]
configure_flags = node[:erlang][:configure_flags].join(" ")

remote_file "/tmp/otp_src_#{erlang_version}.tar.gz" do
  source "http://erlang.org/download/otp_src_#{erlang_version}.tar.gz"
  action :create_if_missing
end

bash "compile_erlang_source" do
  cwd "/tmp"
  code <<-EOH
    tar xzf otp_src_#{erlang_version}.tar.gz
    cd otp_src_#{erlang_version}
    ./configure #{configure_flags}
    make && make install
  EOH
  creates node[:erlang][:src_binary]
end
