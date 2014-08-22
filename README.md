
Description
===========

Installs netatalk with SSL support, for compatibility with newer
versions of Mac OS X.

Requirements
============

Tested on the following platforms using test-kitchen (converges clean,
OS X 10.8 client can connect).

* Ubuntu 10.04, 12.04
* Debian 6.0
* CentOS 6.5
* Fedora 20

Previously working, but untested:

* ArchLinux

Attributes
==========

Attributes are documented in the cookbook's metadata.

Usage
=====

The default netatalk package on Debian/Ubuntu does not have SSL
support, so newer Mac OS X clients will be unable to authenticate.
Netatalk 2.2 is required, or the package needs to be built from source
with SSL.

Generally, include the default recipe on the node's run list. On older
versions of Ubuntu/Debian, the backport PPA with Netatalk 2.2 will be
enabled. If this is not working in your Ubuntu/Debian nodes, set the
`node['netatalk']['package_recipe']` attribute to `build_deb` and the
package will be built from the deb-src. The build_deb recipe will
install the build dependencies to use debuild to build the netatalk
package. This does take quite some time to build.

The shares do need to be configured, and you can set up the attributes
in a role, e.g. "netatalk_server" with default or override attributes:

    "netatalk" => {
      "share_base" => "/srv/export",
      "share_base_owner" => "jtimberman",
      "share_base_group" => "jtimberman",
      "shares" => [
        '~/ "Home Directory"',
        '/srv/export/timemachine "TimeMachine" allow:jtimberman cnidscheme:cdb'
      ]
    }

To modify the options used in `/etc/netatalk/afpd.conf`, set the
`node['netatalk']['afpd_options']` with the entire string as the
options line that should appear in the configuration file.

License and Author
==================

- Author:: Joshua Timberman <opensource@housepub.org>
- Copyright 2009-2013, Joshua Timberman
- Copyright 2009-2012, Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
