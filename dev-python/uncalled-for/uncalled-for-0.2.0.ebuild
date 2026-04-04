EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10,11,12,13,14} )
inherit distutils-r1 pypi

DESCRIPTION="Async dependency injection for Python functions"
HOMEPAGE="https://github.com/chrisguidry/uncalled-for"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	# Replace dynamic version with static version
	sed -i "s/^dynamic = \[\"version\"\]/version = \"${PV}\"/" pyproject.toml || die
	distutils-r1_src_prepare
}
