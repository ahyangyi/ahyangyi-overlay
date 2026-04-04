EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10,11,12,13,14} )
inherit distutils-r1 pypi

DESCRIPTION="Parse Python docstrings"
HOMEPAGE="https://github.com/rr-/docstring_parser"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
