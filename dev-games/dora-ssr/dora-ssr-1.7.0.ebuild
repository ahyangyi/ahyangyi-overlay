EAPI=8

LUA_COMPAT=( lua5-1 )
inherit lua

DESCRIPTION="Dora (Special Super Rare) Game Engine"
HOMEPAGE="https://dora-ssr.net/"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/IppClub/Dora-SSR.git"
	inherit git-r3
else
	SRC_URI="https://codeload.github.com/IppClub/Dora-SSR/tar.gz/refs/tags/v${PV} -> dora-ssr-v${PV}.tar.gz"

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
