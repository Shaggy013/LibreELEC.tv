################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2018 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
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
#  along with LibreELEC  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libva-v4l2-request"
PKG_VERSION="c9327dd55a3d"
PKG_ARCH="any"
PKG_LICENSE="LGPL+MIT"
PKG_SITE="https://www.bootlin.com"
PKG_URL="https://github.com/bootlin/libva-v4l2-request/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libva-v4l2-request-$PKG_VERSION*"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libva-v4l2-request"
PKG_LONGDESC="libva-v4l2-request"
PKG_TOOLCHAIN="autotools"

if [ "$DISPLAYSERVER" = "weston" ]; then
  PKG_DEPENDS_TARGET="toolchain libdrm wayland"
else
  PKG_DEPENDS_TARGET="toolchain libdrm libva"
fi

PKG_CONFIGURE_OPTS_TARGET=""
