EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Web scraping tool for text extraction"
HOMEPAGE="https://trafilatura.readthedocs.io"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/charset-normalizer-3.4[${PYTHON_USEDEP}]
	>=dev-python/courlan-1.3.2[${PYTHON_USEDEP}]
	>=dev-python/htmldate-1.9.2[${PYTHON_USEDEP}]
	>=dev-python/justext-3.0.1[${PYTHON_USEDEP}]
	>=dev-python/lxml-5.3[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26[${PYTHON_USEDEP}]
"
