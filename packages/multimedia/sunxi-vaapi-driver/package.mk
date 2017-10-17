################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
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

PKG_NAME="sunxi-vaapi-driver"
PKG_VERSION="c8e187a"
PKG_ARCH="arm arm64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FlorentRevest/sunxi-cedrus-drv-video/"
PKG_URL="https://github.com/FlorentRevest/sunxi-cedrus-drv-video/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="sunxi-cedrus-drv-video-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libva libdrm"
PKG_SECTION="multimedia"
PKG_SHORTDESC="sunxi-vaapi-driver: VA-API user mode driver for Allwinner SoCs"
PKG_LONGDESC="sunxi-vaapi-driver: VA-API user mode driver for Allwinner SoCs"
PKG_AUTORECONF="yes"
