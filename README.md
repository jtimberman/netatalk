
Description
===========

Installs netatalk from deb-src package with SSL support.

Requirements
============

* Ubuntu 10.04, 12.04
* Debian 6.0

Attributes
==========

The attributes set in the cookbook are used for managing settings for
the shares that should be in AppleVolumes.default, and the base
directory shared over AFP.

Usage
=====

The default netatalk package on Debian/Ubuntu does not have SSL
support, so newer Mac OS X clients will be unable to authenticate.

Include the "netatalk" recipe on the desired node's run list. This
recipe will include the "`netatalk::build_deb`" recipe, which
downloads the source package and builds with SSL support. The
build_deb recipe will install the build dependencies to use debuild to
build the netatalk package. This does take quite some time to build.

Once the package is built, it will be installed with dpkg. The base
share directory will be created as well, and the AppleVolumes.default
share config file will be written.

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

License and Author
==================

- Author:: Joshua Timberman <opensource@housepub.org>
- Copyright 2009-2012, Joshua Timberman
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
