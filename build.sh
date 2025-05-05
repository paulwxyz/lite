#!/bin/bash
cflags="-Wall -O3 -g -std=c11 -fno-strict-aliasing -Isrc $(pkg-config --cflags sdl2) "
lflags="$(pkg-config --libs sdl2) -lm"

platform="unix"
outfile="lite"
compiler="clang"
cflags="$cflags -DLUA_USE_POSIX"
lflags="$lflags -o $outfile"

echo "compiling ($platform)..."
for f in `find src -name "*.c"`; do
  $compiler -c $cflags $f -o "${f//\//_}.o"
  if [[ $? -ne 0 ]]; then
    got_error=true
  fi
done

if [[ ! $got_error ]]; then
  echo "linking..."
  $compiler *.o $lflags
fi

echo "cleaning up..."
rm *.o
echo "done"
