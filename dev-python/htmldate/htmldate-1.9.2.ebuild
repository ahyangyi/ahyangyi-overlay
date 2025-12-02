EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Extract the publication date of web pages"
HOMEPAGE="https://github.com/adbar/htmldate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/charset-normalizer-3.4[${PYTHON_USEDEP}]
	>=dev-python/dateparser-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.9[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26[${PYTHON_USEDEP}]
	>=dev-python/lxml-5.3[${PYTHON_USEDEP}]
"
