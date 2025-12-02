EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Rich renderer for RST (reStructuredText)"
HOMEPAGE="https://github.com/wasi-master/rich-rst"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	>=dev-python/rich-12.0[${PYTHON_USEDEP}]
"
