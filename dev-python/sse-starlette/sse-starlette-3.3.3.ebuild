EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Server-Sent Events for Starlette"
HOMEPAGE="https://github.com/sysid/sse-starlette"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/starlette-0.27[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.5[${PYTHON_USEDEP}]
"
