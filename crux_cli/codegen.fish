#!/usr/bin/env fish
argparse h/help -- $argv
or return

if set -q _flag_help
    echo must specify example as the single argument
    return 0
end

argparse --min-args=1 -- $argv
or return

cargo build

pushd $argv[1]
RUST_LOG=info ../../target/debug/crux codegen \
    --crate-name shared \
    --out-dir ./shared/generated \
    --java com.crux.example.counter.shared \
    --swift SharedTypes \
    --typescript shared_types
popd
