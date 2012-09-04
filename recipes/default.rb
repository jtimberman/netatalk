#
# Cookbook Name:: netatalk
# Recipe:: default
#
# Copyright 2009, Opscode
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

include_recipe "netatalk::build_deb"

package "libpam-cracklib"

directory node['netatalk']['share_base'] do
  owner node['netatalk']['share_base_owner']
  group node['netatalk']['share_base_group']
  mode "0775"
end

template "/etc/netatalk/AppleVolumes.default" do
  source "AppleVolumes.default.erb"
  mode "644"
  owner "root"
  group "root"
  variables :shares => node['netatalk']['shares']
  notifies :restart, "service[netatalk]"
end

service "netatalk" do
  supports :restart => true
  pattern "/usr/sbin/afpd"
  action [:enable, :start]
end
