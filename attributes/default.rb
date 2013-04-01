#
# Cookbook Name:: netatalk
# Attributes:: default
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
#

default['netatalk']['shares'] = []
default['netatalk']['share_base'] = '/srv/afp_share'
default['netatalk']['share_base_owner'] = 'root'
default['netatalk']['share_base_group'] = 'root'
default['netatalk']['afpd_options'] = nil
default['netatalk']['package_recipe'] = nil

# need the backported package for older Debian/Ubuntu
case node['platform']
when 'debian'
  default['netatalk']['package_recipe'] = 'backport_deb'
when 'ubuntu'
  if node['platform_version'].to_f < 11.10
    default['netatalk']['package_recipe'] = 'backport_deb'
  end
when 'arch'
  default['netatalk']['package_recipe'] = 'build_aur'
end
