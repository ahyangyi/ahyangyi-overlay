EAPI=8

LUA_COMPAT=( lua5-1 lua5-3 lua5-4 )
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

inherit lua-single rust cmake cargo

DESCRIPTION="Dora (Special Super Rare) Game Engine"
HOMEPAGE="https://dora-ssr.net/"

BGFX_COMMIT=e451db0ca9322a0c135f57f6b81680a99bd6817e
BIMG_COMMIT=a1a2ae3c129d8c33e765eecd91801bffd985c317
BX_COMMIT=de7b3408fc1dd19532c7b3424359f58b2f20c614
GENIE_COMMIT=83c2411fe04a8a5b71c5610d9debeebba07a64e4

SRC_URI="https://codeload.github.com/IppClub/Dora-SSR/tar.gz/refs/tags/v${PV} -> dora-ssr-v${PV}.tar.gz
	https://github.com/pigpigyyy/bgfx/archive/${BGFX_COMMIT}.tar.gz -> bgfx-${BGFX_COMMIT}.tar.gz
	https://github.com/pigpigyyy/bimg/archive/${BIMG_COMMIT}.tar.gz -> bimg-${BIMG_COMMIT}.tar.gz
	https://github.com/pigpigyyy/bx/archive/${BX_COMMIT}.tar.gz -> bx-${BX_COMMIT}.tar.gz
	https://github.com/pigpigyyy/GENie/archive/${GENIE_COMMIT}.tar.gz -> GENie-${GENIE_COMMIT}.tar.gz
	${CARGO_CRATE_URIS}"
KEYWORDS="~amd64 ~arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND="${RDEPEND}"
RDEPEND="
	${LUA_DEPS}
	media-libs/libsdl2
	media-libs/mesa
	dev-libs/openssl
	dev-lua/luafilesystem
	dev-lang/rust-bin
"
BDEPEND="virtual/pkgconfig"
S="${WORKDIR}/Dora-SSR-${PV}"

pkg_setup() {
	lua-single_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	eapply_user

	sed -i '/rustup/d' Tools/build-scripts/build_lib_linux_x86_64.sh

	cd Projects/Linux
	cmake_src_prepare
}

src_compile() {
	export LUA_VERSION="$(lua_get_version)"
	# Lua bindings
	(
		cd Tools/tolua++ && ${LUA} tolua++.lua || die 
	)

	# Rust bindings
	(
		cd Source/Rust && ${CARGO} build --release --target x86_64-unknown-linux-gnu || die
	)

	cd Projects/Linux
	cp -r ../../../bgfx-${BGFX_COMMIT} 3rdParty/bgfx
	cp -r ../../../bimg-${BIMG_COMMIT} 3rdParty/bimg
	cp -r ../../../bx-${BX_COMMIT} 3rdParty/bx
	cp -r ../../../GENie-${GENIE_COMMIT} 3rdParty/GENie
	emake dep_x86_64 lib_x86_64 ARCH=""

	cmake_src_configure
	cmake_build
}

src_install() {
	dobin Projects/Linux_build/dora-ssr

	insinto /usr/share/dora-ssr
	doins -r Assets/*
}
