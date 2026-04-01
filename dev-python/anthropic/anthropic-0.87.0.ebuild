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
	>=dev-python/pydantic-2.12.5[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.12.1[${PYTHON_USEDEP}]
	>=dev-python/distro-1.9.0[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	>=dev-python/jiter-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/docstring-parser-0.15[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"

S="${WORKDIR}/anthropic-sdk-python-${PV}"
