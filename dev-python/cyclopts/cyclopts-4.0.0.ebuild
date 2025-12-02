EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="A powerful command-line argument parsing library"
HOMEPAGE="https://github.com/BrianPugh/cyclopts"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/attrs-23.1[${PYTHON_USEDEP}]
	>=dev-python/docstring-parser-0.15[${PYTHON_USEDEP}]
	>=dev-python/rich-rst-1.3.1[${PYTHON_USEDEP}]
	<dev-python/rich-rst-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.6[${PYTHON_USEDEP}]
"
