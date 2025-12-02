EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Python wrapper around ripgrep"
HOMEPAGE="https://github.com/securisec/ripgrepy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sys-apps/ripgrep
"
