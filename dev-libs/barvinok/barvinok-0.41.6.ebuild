EAPI=7

inherit autotools toolchain-funcs

DESCRIPTION="A library for counting the number of integer points in polytopes."
HOMEPAGE="https://repo.or.cz/barvinok.git"
SRC_URI="https://repo.or.cz/barvinok.git/snapshot/c067f2f7e37856db978e67306f70649fae2c7c01.tar.gz -> ${P}.tar.gz"
COMMIT_HASH="c067f2f"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND="dev-libs/polylib
	dev-libs/ntl[threads]
"

DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig"
S="${WORKDIR}/barvinok-${COMMIT_HASH}"

src_prepare() {
	default

	autoreconf -i
}

multilib_src_configure() {
	local econf_opts=(
		$(use_enable static-libs static)

		# AX_PROG_CC_FOR_BUILD deficiency:
		# https://wiki.gentoo.org/wiki/Project:Toolchain/use_native_symlinks
		CC_FOR_BUILD="$(tc-getBUILD_CC)"
	)

	if ! tc-is-cross-compiler; then
		# Incorrect CFLAGS handling as CFLAGS_FOR_BUILD
		# even for native builds. As a result -O3 is being used
		# regardless of user's CFLAGS.
		econf_opts+=(
			CFLAGS_FOR_BUILD="${CFLAGS}"
		)
	fi

	ECONF_SOURCE="${S}" econf "${econf_opts[@]}"
}

multilib_src_install_all() {
	einstalldocs

	find "${ED}" -type f -name '*.la' -delete || die
}
