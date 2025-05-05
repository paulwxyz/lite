#!/bin/bash
./build.sh release
rm lite.zip 2>/dev/null
strip lite
zip lite.zip lite lite.exe SDL2.dll data -r

