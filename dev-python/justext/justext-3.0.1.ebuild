EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13,14} )
inherit distutils-r1 pypi

DESCRIPTION="Heuristic algorithm to extract article text from HTML"
HOMEPAGE="https://github.com/miso-belica/jusText"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/lxml-4.4.2[${PYTHON_USEDEP}]
"
