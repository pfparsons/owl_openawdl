PROJECT_ROOT=$(dirname $(dirname $(realpath $0)))
start_dir="$(pwd)"
build_base="$PROJECT_ROOT/build/thirdparty"

mkdir -p "$build_base/libnl"
autoreconf -fi $PROJECT_ROOT/thirdparty/libnl
cd "$build_base"/libnl 
$PROJECT_ROOT/thirdparty/libnl/configure
make -j4


python -m venv "$build_base/meson_venv"
. "$build_base/meson_venv/bin/activate"
pip install meson pyelftools


mkdir -p "$build_base/dpdk"
cd "$PROJECT_ROOT/thirdparty/dpdk"
meson setup "$build_base/dpdk"
meson compile -C "$build_base/dpdk"

cd "$start_dir"
