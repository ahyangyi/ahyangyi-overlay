EAPI=8

inherit autotools multilib multilib-minimal toolchain-funcs

DESCRIPTION="Polyhedral library"
HOMEPAGE="https://repo.or.cz/w/polylib.git"
SRC_URI="https://repo.or.cz/polylib.git/snapshot/3693c583aec7d7e073834e332fe256e51e0b0404.tar.gz -> ${P}.tar.gz"
HASH=3693c58

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"
S="${WORKDIR}/polylib-${HASH}"

src_prepare() {
	touch AUTHORS ChangeLog NEWS README

	default

	eautoreconf
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
