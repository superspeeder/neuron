ME="$(dirname -- "${BASH_SOURCE[0]}")"

if [ ! -d "$ME/build" ]; then
    mkdir "$ME/build"
fi

cmake -S "$ME" -B "$ME/build" -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cp "$ME/build/compile_commands.json" "$ME/compile_commands.json"
