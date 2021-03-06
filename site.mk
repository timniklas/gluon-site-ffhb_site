##	gluon site.mk makefile example

##	GLUON_FEATURES
#		Specify Gluon features/packages to enable;
#		Gluon will automatically enable a set of packages
#		depending on the combination of features listed

GLUON_FEATURES := \
	autoupdater \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-limit-arp \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	respondd \
	status-page \
	web-advanced \
	web-wizard

##	GLUON_SITE_PACKAGES
#		Specify additional Gluon/OpenWrt packages to include here;
#		A minus sign may be prepended to remove a packages from the
#		selection that would be enabled by default or due to the
#		chosen feature flags

GLUON_SITE_PACKAGES := \
	gluon-ssid-changer \
	respondd-module-airtime \
	gluon-config-mode-core \
	gluon-config-mode-geo-location \
	gluon-config-mode-geo-location-osm \
	gluon-web-mesh-vpn-fastd \
	gluon-web-private-wifi \
	gluon-radv-filterd \
	gluon-setup-mode \
	gluon-speedtest \
	iwinfo \
	firewall \
	haveged

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.

DEFAULT_GLUON_RELEASE := 0.6+exp$(shell date '+%Y%m%d')

# Variables set with ?= can be overwritten from the command line

##	GLUON_RELEASE
#		call make with custom GLUON_RELEASE flag, to use your own release version scheme.
#		e.g.:
#			$ make images GLUON_RELEASE=23.42+5
#		would generate images named like this:
#			gluon-ff%site_code%-23.42+5-%router_model%.bin

EXCLUDE_NO_WIFI:= -respondd-module-airtime

GLUON_RELEASE ?= $(patsubst v%,%,$(shell git -C $(GLUON_SITEDIR) describe --tags --dirty=+))

# Default priority for updates.
GLUON_PRIORITY ?= 0

# Region code required for some images; supported values: us eu
GLUON_REGION ?= eu

# Languages to include
GLUON_LANGS ?= en de

GLUON_MULTIDOMAIN=1

# ramips-mt7621
ifeq ($(GLUON_TARGET),ramips-mt7621)
	GLUON_ubnt-erx_SITE_PACKAGES +=  $(EXCLUDE_NO_WIFI)
	GLUON_ubnt-erx-sfp_SITE_PACKAGES +=  $(EXCLUDE_NO_WIFI)
endif
