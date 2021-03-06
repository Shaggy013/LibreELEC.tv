################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="u-boot"
PKG_ARCH="arm aarch64"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_SOURCE_DIR="u-boot-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain dtc:host"
PKG_LICENSE="GPL"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems, used as the default boot loader by several board vendors. It is intended to be easy to port and to debug, and runs on many supported architectures, including PPC, ARM, MIPS, x86, m68k, NIOS, and Microblaze."
PKG_IS_KERNEL_PKG="yes"

PKG_NEED_UNPACK="$PROJECT_DIR/$PROJECT/bootloader"
[ -n "$DEVICE" ] && PKG_NEED_UNPACK+=" $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader"

case "$PROJECT" in
  Allwinner)
    PKG_VERSION="f4077661c6c0f3b92f26cb7c35432ad64615fe32"
    PKG_SHA256="f9a63bd06195f580122bb31edb10e6a6673b105d22ef4276d38b115c815770ce"
    PKG_URL="https://github.com/Icenowy/u-boot/archive/$PKG_VERSION.tar.gz"
    if [ "$DEVICE" = "H6" ]; then
      PKG_DEPENDS_TARGET+=" sunxi-atf"
    fi
    PKG_PATCH_DIRS="aw"
    ;;
  Rockchip)
    PKG_VERSION="5ecf0ee"
    PKG_SHA256="fba1d26583d446a5bbb5713fe37848e05b546d125384c2c2d2883414d61b7cad"
    PKG_URL="https://github.com/rockchip-linux/u-boot/archive/$PKG_VERSION.tar.gz"
    PKG_PATCH_DIRS="rockchip"
    PKG_DEPENDS_TARGET+=" rkbin"
    PKG_NEED_UNPACK+=" $(get_pkg_directory rkbin)"
    ;;
  *)
    PKG_VERSION="2017.09"
    PKG_SHA256="b2d15f2cf5f72e706025cde73d67247c6da8cd35f7e10891eefe7d9095089744"
    PKG_URL="http://ftp.denx.de/pub/u-boot/u-boot-$PKG_VERSION.tar.bz2"
    ;;
esac

make_target() {
  if [ -z "$UBOOT_SYSTEM" ]; then
    echo "UBOOT_SYSTEM must be set to build an image"
    echo "see './scripts/uboot_helper' for more information"
  else
    if [ "$PROJECT" = "Allwinner" -a "$DEVICE" = "H6" ]; then
      cp -av $(get_build_dir sunxi-atf)/build/sun50i_h6/debug/bl31.bin .
    fi
    CROSS_COMPILE="$TARGET_KERNEL_PREFIX" LDFLAGS="" ARCH=arm make mrproper
    CROSS_COMPILE="$TARGET_KERNEL_PREFIX" LDFLAGS="" ARCH=arm make $($ROOT/$SCRIPTS/uboot_helper $PROJECT $DEVICE $UBOOT_SYSTEM config)
    CROSS_COMPILE="$TARGET_KERNEL_PREFIX" LDFLAGS="" ARCH=arm make HOSTCC="$HOST_CC" HOSTSTRIP="true"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader

    # Only install u-boot.img et al when building a board specific image
    if [ -n "$UBOOT_SYSTEM" ]; then
      find_file_path bootloader/install && . ${FOUND_PATH}
    fi

    # Always install the update script
    find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader

    # Always install the canupdate script
    if find_file_path bootloader/canupdate.sh; then
      cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader
      sed -e "s/@PROJECT@/${DEVICE:-$PROJECT}/g" \
          -i $INSTALL/usr/share/bootloader/canupdate.sh
    fi
}
