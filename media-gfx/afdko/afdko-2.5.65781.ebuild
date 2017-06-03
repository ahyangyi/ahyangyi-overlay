EAPI="6"

DESCRIPTION="Adobe Font Development Kit for OpenType"
HOMEPAGE="http://www.adobe.com/devnet/opentype/afdko.html"
SRC_URI="http://download.macromedia.com/pub/developer/opentype/FDK.${PV}/FDK.${PV}-LINUX.zip"

LICENSE="AFDKL"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}

src_install() {
	# Move Python-related files to a separate location
	mkdir FDK/Tools/python
	mv FDK/Tools/linux/AFDKOPython FDK/Tools/linux/Python FDK/Tools/python/
	# Install /usr/bin files
	dobin FDK/Tools/linux/*
	# Install /usr/share/afdko files
	insinto /usr/share/afdko
	doins -r FDK/Tools/SharedData
}
