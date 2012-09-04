name              "netatalk"
maintainer        "Joshua Timberman"
maintainer_email  "opensource@housepub.org"
license           "Apache 2.0"
description       "Installs netatalk source package on Debian/Ubuntu w/ SSL support"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"

recipe "netatalk::default", <<-DESC
Includes the build_deb recipe, manages the shares and AppleVolumes.default as a template
DESC

recipe "netatalk::build_deb", "Builds Netatalk from the source package with OpenSSL support enabled"

supports "debian", ">= 5.0"
supports "ubuntu", ">= 10.04"

attribute("netatalk/shares",
           :display_name => "Shares",
           :description => "Array of shares that populates AppleVolumes.default, one line per entry",
           :type => "array",
           :default => [])

attribute("netatalk/share_base",
           :display_name => "Base Directory",
           :description => "Base directory to share via AFP",
           :type => "string",
           :default => "/srv/afp_share")

attribute("netatalk/share_base_owner",
           :display_name => "Base Directory Owner",
           :description => "User that should own the share_base",
           :type => "string",
           :default => "root")

attribute("netatalk/share_base_group",
           :display_name => "Base Directory Group",
           :description => "Group that should own the share_base",
           :type => "string",
           :default => "root")
