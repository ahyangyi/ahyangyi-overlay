# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="A system for processing and editing unstructured 3D triangular meshes"
HOMEPAGE="http://www.meshlab.net"
VCG_VERSION="2022.02"
SRC_URI="https://github.com/cnr-isti-vclab/meshlab/archive/refs/tags/MeshLab-${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/cnr-isti-vclab/vcglib/archive/refs/tags/${VCG_VERSION}.tar.gz -> vcglib-${VCG_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="double-precision minimal"

RDEPEND="
	dev-cpp/eigen:3
	dev-cpp/muParser
	dev-libs/gmp:=
	>=dev-qt/qtcore-5.12:5
	>=dev-qt/qtdeclarative-5.12:5
	>=dev-qt/qtopengl-5.12:5
	>=dev-qt/qtscript-5.12:5
	>=dev-qt/qtxml-5.12:5
	>=dev-qt/qtxmlpatterns-5.12:5
	media-libs/glew:0=
	=media-libs/lib3ds-1*
	media-libs/openctm:=
	media-libs/qhull:=
	sci-libs/levmar
	sci-mathematics/cgal"

DEPEND="${RDEPEND}"

S="${WORKDIR}/meshlab-MeshLab-${PV}/src"

PATCHES=(
	"${FILESDIR}/meshlab-2020.12-disable-updates.patch"
	"${FILESDIR}/meshlab-2021.10-find-plugins.patch"
)

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	unpack vcglib-${VCG_VERSION}.tar.gz
	mv vcglib-${VCG_VERSION}/* vcglib
}

src_configure() {
	# crazy command from https://aur.archlinux.org/packages/meshlab
	sed -i '1i#include <cstdint>' external/e57/include/E57SimpleData.h external/e57/src/BlobNodeImpl.cpp external/e57/src/BlobNodeImpl.h external/e57/src/Common.cpp external/e57/src/Common.h external/e57/src/CompressedVectorNodeImpl.cpp external/e57/src/CompressedVectorNodeImpl.h external/e57/src/CompressedVectorReaderImpl.cpp external/e57/src/CompressedVectorReaderImpl.h external/e57/src/CompressedVectorWriterImpl.cpp external/e57/src/CompressedVectorWriterImpl.h external/e57/src/E57SimpleData.cpp external/e57/src/NodeImpl.cpp external/e57/src/NodeImpl.h external/e57/src/ReaderImpl.cpp external/e57/src/ReaderImpl.h external/nexus/src/corto/include/corto/tunstall.h external/nexus/src/corto/src/tunstall.cpp external/e57/include/E57Format.h

	CMAKE_BUILD_TYPE=Release

	local mycmakeargs=(
		-DBUILD_MINI=$(usex minimal)
		-DBUILD_WITH_DOUBLE_SCALAR=$(usex double-precision)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
}
