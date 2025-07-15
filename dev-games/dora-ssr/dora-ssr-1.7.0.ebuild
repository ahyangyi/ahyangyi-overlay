EAPI=8

LUA_COMPAT=( lua5-1 )
inherit lua

CRATES="
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anstyle@1.0.10
	bitflags@1.3.2
	cfixed-string@1.0.0
	clap@4.5.26
	clap_builder@4.5.26
	clap_derive@4.5.24
	clap_lex@0.7.4
	colorchoice@1.0.3
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	heck@0.5.0
	is_terminal_polyfill@1.70.1
	once_cell@1.20.2
	paste@1.0.15
	proc-macro2@1.0.92
	quote@1.0.37
	strsim@0.11.1
	syn@2.0.89
	unicode-ident@1.0.14
	utf8parse@0.2.2
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
"

inherit cargo

DESCRIPTION="Dora (Special Super Rare) Game Engine"
HOMEPAGE="https://dora-ssr.net/"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/IppClub/Dora-SSR.git"
	inherit git-r3
else
	SRC_URI="https://codeload.github.com/IppClub/Dora-SSR/tar.gz/refs/tags/v${PV} -> dora-ssr-v${PV}.tar.gz ${CARGO_CRATE_URIS}"

	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	media-libs/libsdl2
	media-libs/mesa
	dev-libs/openssl
	dev-lang/lua:5.1
	dev-lua/luafilesystem
	dev-lang/rust-bin
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/Dora-SSR-${PV}"

src_compile() {
	# Lua bindings
	(
		cd Tools/tolua++ && lua5.1 tolua++.lua || die 
	)

	# Rust bindings
	(
		cd Source/Rust && cargo build --release --target x86_64-unknown-linux-gnu || die
	)

	cd Projects/Linux
	make x86_64
}
