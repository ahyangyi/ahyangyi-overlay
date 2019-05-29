EAPI=7

DESCRIPTION="NVIDIA Accelerated Deep Learning on GPU library"
HOMEPAGE="https://developer.nvidia.com/cuDNN"

MY_PV=$(ver_cut 1-4)
CUDA_PV=$(ver_cut 5-6)
SRC_URI="cudnn-${CUDA_PV}-linux-x64-v${MY_PV}.tgz"

SLOT="0/7"
KEYWORDS="~amd64 ~amd64-linux"
RESTRICT="fetch"
LICENSE="NVIDIA-cuDNN"
QA_PREBUILT="*"

S="${WORKDIR}"

DEPEND="=dev-util/nvidia-cuda-toolkit-${CUDA_PV}*"
RDEPEND="${DEPEND}"

src_install() {
	insinto /opt/cuda
	doins cuda/NVIDIA_SLA_cuDNN_Support.txt

	insinto /opt/cuda/targets/x86_64-linux/include
	doins -r cuda/include/*

	insinto /opt/cuda/targets/x86_64-linux/lib
	doins -r cuda/lib*/*
}
