EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{9,10,11,12,13,14} )
inherit distutils-r1
SRC_URI="https://github.com/anthropics/anthropic-sdk-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="The official Python library for the anthropic API"
HOMEPAGE="https://github.com/anthropics/anthropic-sdk-python"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	>=dev-python/pydantic-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.25.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.10.0[${PYTHON_USEDEP}]
	>=dev-python/anyio-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/distro-1.7.0[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"

S="${WORKDIR}/anthropic-sdk-python-${PV}"
