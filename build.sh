#!/bin/sh -e

echo "Compile add.c into add.wasm"
clang -Os --target=wasm32 -c -o build/add.wasm add.c

echo "Transform add.wasm into add_in_wasm.c"
wasm2c -o build/add_in_wasm.c build/add.wasm

echo "Compile add_in_wasm.c into add_in_wasm.o (using default runtime)"
clang -DWASM_RT_MODULE_PREFIX=fixpoint_ -Os -I. -Ihelpers -c -o build/add_in_wasm.o build/add_in_wasm.c

echo "Compile run_function"
clang -DWASM_RT_MODULE_PREFIX=fixpoint_ -Os -Ibuild -Ihelpers -c -o build/run_function.o run_function.c

echo "Compile default runtime implementation"
clang -DWASM_RT_MODULE_PREFIX=fixpoint_ -Os -Ihelpers -c -o build/wasm-rt-impl.o helpers/wasm-rt-impl.c

echo "Link three things together to make an executable: run_function, add-in-WASM, and the default runtime"
clang -o run_function build/run_function.o build/add_in_wasm.o build/wasm-rt-impl.o
