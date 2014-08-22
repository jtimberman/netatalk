#
# Cookbook Name:: netatalk
# Recipe:: default
#
# Copyright 2009-2012, Opscode
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

if node['netatalk']['package_recipe']
  include_recipe "netatalk::#{node['netatalk']['package_recipe']}"
end

package 'netatalk' if platform_family?('debian') || platform_family?('fedora') || platform_family?('rhel')

package 'cracklib' do
  package_name value_for_platform_family(
    'arch' => 'cracklib',
    'fedora' => 'cracklib',
    'rhel' => 'cracklib',
    'default' => 'libpam-cracklib'
  )
end

directory node['netatalk']['share_base'] do
  owner node['netatalk']['share_base_owner']
  group node['netatalk']['share_base_group']
  mode 02775
end

['afpd.conf', 'AppleVolumes.default'].each do |conf|

  template "/etc/netatalk/#{conf}" do
    source "#{conf}.erb"
    mode 00644
    owner "root"
    group "root"
    variables :shares => node['netatalk']['shares']
    notifies :restart, 'service[netatalk]'
  end

end

service 'netatalk' do
  supports :restart => true
  case node['platform_family']
  when 'debian'
    pattern '/usr/sbin/(afpd|cnid_metad)'
  when 'arch'
    service_name 'afpd'
  end
  action [:enable, :start]
end
