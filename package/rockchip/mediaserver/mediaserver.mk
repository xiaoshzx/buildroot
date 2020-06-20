MEDIASERVER_SITE = $(TOPDIR)/../app/mediaserver
MEDIASERVER_SITE_METHOD = local

MEDIASERVER_DEPENDENCIES = rkmedia json-for-modern-cpp

MEDIASERVER_CONF_OPTS += -DBR2_SDK_PATH=$(HOST_DIR)

ifeq ($(BR2_PACKAGE_RK_OEM), y)
MEDIASERVER_INSTALL_TARGET_OPTS = DESTDIR=$(BR2_PACKAGE_RK_OEM_INSTALL_TARGET_DIR) install/fast
MEDIASERVER_DEPENDENCIES += rk_oem
MEDIASERVER_CONF_OPTS += -DMEDIASERVER_CONF_PREFIX="\"/oem\""
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_BIN), y)
MEDIASERVER_CONF_OPTS += -DENABLE_MEDIASERVER_BIN=ON
else
MEDIASERVER_CONF_OPTS += -DENABLE_MEDIASERVER_BIN=OFF
MEDIASERVER_INSTALL_STAGING = YES
ifeq ($(BR2_PACKAGE_MEDIASERVE_LIB_EXAMPLE), y)
MEDIASERVER_CONF_OPTS += -DENABLE_MEDIASERVER_LIB_EXAMPLE=ON
endif
endif

ifeq ($(BR2_PACKAGE_MEDIASERVER_SANITIZER_DYNAMIC), y)
MEDIASERVER_CONF_OPTS += -DSANITIZER_DYNAMIC=ON
else

ifeq ($(BR2_PACKAGE_MEDIASERVER_SANITIZER_STATIC), y)
MEDIASERVER_CONF_OPTS += -DSANITIZER_STATIC=ON
endif

endif

ifneq ($(BR2_PACKAGE_MEDIASERVE_CONIFG), "none")
    MEDIASERVER_CONF_OPTS += -DMEDIASERVE_CONF=${BR2_PACKAGE_MEDIASERVE_CONIFG}
endif

ifeq ($(BR2_PACKAGE_RV1126_RV1109),y)
    MEDIASERVER_CONF_OPTS += -DCOMPILE_PLATFORM=rv1109
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_DBUS), y)
    MEDIASERVER_CONF_OPTS += -DENABLE_DBUS=ON
    MEDIASERVER_DEPENDENCIES += dbus dbus-cpp librkdb
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_LINKAPI), y)
    MEDIASERVER_CONF_OPTS += -DENABLE_LINK_SUPPORT=ON
    MEDIASERVER_DEPENDENCIES += cjson
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_MINILOGGER), y)
    MEDIASERVER_CONF_OPTS += -DENABLE_MINILOGGER=ON
    MEDIASERVER_DEPENDENCIES += minilogger
else
    MEDIASERVER_CONF_OPTS += -DENABLE_MINILOGGER=OFF
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_SHM_SERVER), y)
    MEDIASERVER_CONF_OPTS += -DENABLE_SHM_SERVER=ON
    MEDIASERVER_DEPENDENCIES += shm-tools
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_OSD_SERVER), y)
    MEDIASERVER_CONF_OPTS += -DENABLE_OSD_SERVER=ON
    MEDIASERVER_DEPENDENCIES += freetype
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_EXIV2_FEATURE), y)
    MEDIASERVER_CONF_OPTS += -DENABLE_EXIV2_LIB=ON
    MEDIASERVER_DEPENDENCIES += exiv2
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_USE_ROCKFACE), y)
    MEDIASERVER_CONF_OPTS += -DUSE_ROCKFACE=ON
endif

ifeq ($(BR2_PACKAGE_MEDIASERVE_USE_ROCKX), y)
    MEDIASERVER_CONF_OPTS += -DUSE_ROCKX=ON
endif

$(eval $(cmake-package))
