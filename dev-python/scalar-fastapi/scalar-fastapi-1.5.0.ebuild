EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Scalar API reference for FastAPI"
HOMEPAGE="https://github.com/scalar/scalar"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/fastapi-0.115[${PYTHON_USEDEP}]
"
