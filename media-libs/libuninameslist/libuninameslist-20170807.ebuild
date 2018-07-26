EAPI=6

inherit autotools

DESCRIPTION="Library of unicode annotation data"
HOMEPAGE="https://github.com/fontforge/libuninameslist"
SRC_URI="https://github.com/fontforge/libuninameslist/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--disable-static
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
