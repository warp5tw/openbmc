# Initialization
AC_PREREQ([2.69])
AC_INIT([phosphor-host-postd], [1.0], [https://github.com/openbmc/phosphor-host-postd/issues])
AC_LANG([C++])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([subdir-objects -Wall -Werror foreign dist-xz])
AM_SILENT_RULES([yes])

# Checks for programs.
AC_PROG_CXX
AM_PROG_AR
AC_PROG_INSTALL
AC_PROG_MAKE_SET

# Checks for typedefs, structures, and compiler characteristics.
AX_CXX_COMPILE_STDCXX_17([noext])
AX_APPEND_COMPILE_FLAGS([-fpic -Wall -Werror], [CXXFLAGS])

# Checks for libraries.
PKG_CHECK_MODULES([SYSTEMD], [libsystemd >= 221])
PKG_CHECK_MODULES([SDBUSPLUS], [sdbusplus])
PKG_CHECK_MODULES([SDEVENTPLUS], [sdeventplus])
PKG_CHECK_MODULES([PHOSPHOR_DBUS_INTERFACES], [phosphor-dbus-interfaces])
AC_CHECK_HEADER(experimental/filesystem, ,[AC_MSG_ERROR([Could not find experimental/filesystem...libstdc++fs development package required])])

# Checks for library functions.
LT_INIT # Required for systemd linking

AC_ARG_VAR(SYSTEMD_TARGET, "Target for starting this service")

# Create configured output
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
