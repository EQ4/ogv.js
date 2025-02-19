#!/bin/bash

suffix=so
if [ `uname -s` == "Darwin" ]; then
	suffix=dylib
fi

# compile wrapper around libogg + liboggz + libskeleton
EMCC_FAST_COMPILER=1 emcc \
  -O2 \
  --memory-init-file 0 \
  -s ASM_JS=1 \
  -s VERBOSE=1 \
  -s ERROR_ON_UNDEFINED_SYMBOLS=1 \
  -s NO_FILESYSTEM=1 \
  -s NO_BROWSER=1 \
  -s INVOKE_RUN=0 \
  -s NO_EXIT_RUNTIME=1 \
  -s EXPORT_NAME="'OGVDemuxerOgg'" \
  -s MODULARIZE=1 \
  -s EXPORTED_FUNCTIONS="`< src/ogv-demuxer-exports.json`" \
  -Ibuild/js/root/include \
  -Lbuild/js/root/lib \
  build/js/root/lib/libogg.$suffix \
  build/js/root/lib/liboggz.$suffix \
  build/js/root/lib/libskeleton.$suffix \
  --js-library src/ogv-demuxer-callbacks.js \
  --pre-js src/ogv-module-pre.js \
  --post-js src/ogv-demuxer.js \
  src/ogv-demuxer-ogg.c \
  -o build/ogv-demuxer-ogg.js
