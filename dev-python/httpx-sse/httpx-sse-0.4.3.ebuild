EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1

DESCRIPTION="Consume Server-Sent Event (SSE) messages with HTTPX"
HOMEPAGE="https://github.com/florimondmanca/httpx-sse"
SRC_URI="https://github.com/florimondmanca/httpx-sse/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/httpx-0.27[${PYTHON_USEDEP}]
"

S="${WORKDIR}/httpx-sse-${PV}"
