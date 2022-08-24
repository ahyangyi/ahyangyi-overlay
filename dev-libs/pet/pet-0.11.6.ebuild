EAPI=7

inherit autotools multilib multilib-minimal preserve-libs toolchain-funcs

DESCRIPTION="Polyhedral Extraction Tool"
HOMEPAGE="https://repo.or.cz/pet.git/"
SRC_URI="https://repo.or.cz/pet.git/snapshot/c8adf54b904c7b293d0400d80cb6f21249a5a1cd.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT=0

IUSE="static-libs"

RDEPEND="dev-libs/isl"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S=${WORKDIR}/pet-c8adf54

src_prepare() {
	default

	# FIXME: use eautoreconf and somehow pass a correct AC_CONFIG_SUBDIRS
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
