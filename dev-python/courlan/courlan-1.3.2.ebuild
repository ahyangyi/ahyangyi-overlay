EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Clean, filter and sample URLs"
HOMEPAGE="https://github.com/adbar/courlan"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/babel-2.16[${PYTHON_USEDEP}]
	>=dev-python/tld-0.13[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26[${PYTHON_USEDEP}]
"
