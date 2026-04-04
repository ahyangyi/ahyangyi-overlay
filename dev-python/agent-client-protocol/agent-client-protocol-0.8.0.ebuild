EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{10,11,12,13,14} )
inherit distutils-r1

DESCRIPTION="A Python implement of Agent Client Protocol (ACP, by Zed Industries)"
HOMEPAGE="https://agentclientprotocol.github.io/python-sdk/"
SRC_URI="https://github.com/agentclientprotocol/python-sdk/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/python-sdk-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/pydantic-2.7[${PYTHON_USEDEP}]
"
