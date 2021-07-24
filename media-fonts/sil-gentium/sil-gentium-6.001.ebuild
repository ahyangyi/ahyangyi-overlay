EAPI=7

inherit font

MY_PN="GentiumPlus"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Gentium Plus unicode font for Latin and Greek languages"
HOMEPAGE="https://software.sil.org/gentium/"
SRC_URI="https://software.sil.org/downloads/r/gentium/GentiumPlus-6.001.zip"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~hppa ~ia64 ppc ppc64 ~s390 sparc x86 ~ppc-macos ~x64-macos"
IUSE="doc"

BDEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"

src_unpack() {
	unpack ${A}
	rm -R "${S}"/documentation/source/
}

src_install() {
	font_src_install
	use doc && dodoc -r "${S}"/documentation
}
