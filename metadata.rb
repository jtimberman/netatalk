name              "netatalk"
maintainer        "Joshua Timberman"
maintainer_email  "opensource@housepub.org"
license           "Apache 2.0"
description       "Installs netatalk source package on Debian/Ubuntu w/ SSL support"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.1.1"

recipe "netatalk::default", <<-DESC
Includes the appropriate package prep recipe (if any), creates the base share directory, creates AFP config files and manages the netatalk service(s)
DESC

recipe "netatalk::backport_deb", <<-DESC
Enables the Netatalk backport PPA repository
DESC

recipe "netatalk::build_deb", "Builds Netatalk from the source package with OpenSSL support enabled"

recipe "netatalk::build_aur", "Builds Netatalk package from Arch User Repository (AUR) w/ OpenSSL support enabled"

supports "debian", ">= 6.0"
supports "ubuntu", ">= 10.04"
supports "fedora", ">= 19.0"
supports "redhat", ">= 5.0"
supports "centos", ">= 5.0"
supports "scientific", ">= 5.0"

depends "yum-epel"

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

attribute("netatalk/afpd_options",
  :display_name => "AFPD Config Options",
  :description => "String of options written to afpd.conf",
  :type => "string")

attribute("netatalk/package_recipe",
  :display_name => "Package Preparation Recipe",
  :description => "The name of a recipe that is used to set up the package for installation",
  :calculated => true)
