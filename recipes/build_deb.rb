#
# Cookbook Name:: netatalk
# Recipe:: build_deb
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
#

%w{libcrack2-dev fakeroot libssl-dev}.each do |pkg|
  package pkg
end

directory "/var/tmp/netatalk" do
  owner "root"
  group "root"
end

bash "install_netatalk" do
  cwd "/var/tmp/netatalk"
  code <<-EOF
apt-get build-dep -y netatalk && apt-get source netatalk
(cd netatalk-2* && DEB_BUILD_OPTIONS=ssl dpkg-buildpackage -rfakeroot)
dpkg -i netatalk*.deb && echo 'netatalk hold' | dpkg --set-selections
  EOF
  not_if "dpkg -s netatalk | grep -qx 'Status: hold ok installed'"
end

service "netatalk" do
  action :nothing
end
