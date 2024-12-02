PROJECT_ROOT=$(dirname $(dirname $(realpath $0)))

update_submodule() {
    local submodule="$1"
    cmd="git submodule update --init --remote --merge -- $submodule"
    $cmd
}

declare -a submodules=()
readarray -t submodules < <(ls -d "$PROJECT_ROOT/thirdparty/"* )
for sm in "${submodules[@]}"
do
    update_submodule "$sm"
done
