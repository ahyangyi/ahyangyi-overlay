# Grabbed from
# https://github.com/fedeliallalinea/gallifrey/blob/master/dev-util/apl/apl-1.8.ebuild
EAPI=7

DESCRIPTION="GNU APL is a free interpreter for the programming language APL"
HOMEPAGE="https://www.gnu.org/software/apl/"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

CXXFLAGS="${CXXFLAGS} -Wno-error=class-memaccess"
