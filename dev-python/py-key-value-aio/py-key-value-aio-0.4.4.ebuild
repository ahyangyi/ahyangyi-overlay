EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Asyncio-compatible key-value store with pluggable backends"
HOMEPAGE="https://github.com/jlowin/py-key-value"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/beartype-0.20[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/uv-build[${PYTHON_USEDEP}]
"
