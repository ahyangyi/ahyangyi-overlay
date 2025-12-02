EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1

DESCRIPTION="GenAI Python SDK"
HOMEPAGE="https://github.com/googleapis/python-genai"
SRC_URI="https://github.com/googleapis/python-genai/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/anyio-4.8[${PYTHON_USEDEP}]
	>=dev-python/google-auth-2.45[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.9[${PYTHON_USEDEP}]
	>=dev-python/requests-2.28.1[${PYTHON_USEDEP}]
	>=dev-python/tenacity-8.2.3[${PYTHON_USEDEP}]
	>=dev-python/websockets-13.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.14[${PYTHON_USEDEP}]
	>=dev-python/distro-1.7[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
"

S="${WORKDIR}/python-genai-${PV}"

src_prepare() {
	sed -i 's/\[build-system\]/[build-system]\nbuild-backend = "setuptools.build_meta"/' pyproject.toml || die
	distutils-r1_src_prepare
}
