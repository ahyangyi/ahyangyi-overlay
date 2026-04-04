EAPI=8

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{8..14} pypy3 )
inherit distutils-r1

DESCRIPTION="Python bindings to picosat (a SAT solver)"
HOMEPAGE="https://github.com/ContinuumIO/pycosat"
SRC_URI="https://github.com/ContinuumIO/pycosat/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~riscv ~x86"

distutils_enable_tests pytest
