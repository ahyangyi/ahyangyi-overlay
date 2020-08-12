EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1
SRC_URI="https://github.com/rougier/freetype-py/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
RESTRICT="primaryuri"

DESCRIPTION="Python bindings for the freetype library"
HOMEPAGE="https://github.com/rougier/${PN}"

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	media-libs/freetype:2
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -e '/setup_requires/d' \
		-e "s/use_scm_version.*/version = '${P}',/" \
		-i setup.py

	eapply_user
}
