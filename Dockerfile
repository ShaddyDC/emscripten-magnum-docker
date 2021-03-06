FROM emscripten/emsdk AS builder

ARG BUILD_TYPE=RelWithDebInfo

RUN git clone --recurse-submodules https://github.com/mosra/corrade/ && \
    cd corrade/ && mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=OFF && \
    cmake --build . --target install && \
    cd .. && mkdir build-emscripten && cd build-emscripten && \
    cmake .. -DCMAKE_TOOLCHAIN_FILE="../toolchains/generic/Emscripten-wasm.cmake" \
        -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
        -DCMAKE_INSTALL_PREFIX=/emsdk/upstream/emscripten/system \
        -DBUILD_TESTS=OFF && \
    cmake --build . --target install && \
    cd ../../ && \
    git clone --recurse-submodules https://github.com/mosra/magnum && \
    cd magnum && mkdir build-emscripten && cd build-emscripten && \
    cmake .. -DCMAKE_TOOLCHAIN_FILE="../toolchains/generic/Emscripten-wasm.cmake" \
        -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
        -DCMAKE_INSTALL_PREFIX=/emsdk/upstream/emscripten/system \
        -DMAGNUM_DEPLOY_PREFIX=/srv/http/emscripten-webgl2 \
        -DTARGET_GLES2=OFF \
        -DWITH_AUDIO=ON \
        -DWITH_EMSCRIPTENAPPLICATION=ON \
        -DWITH_SDL2APPLICATION=ON \
        -DWITH_WINDOWLESSEGLAPPLICATION=ON \
        -DWITH_ANYAUDIOIMPORTER=ON \
        -DWITH_ANYIMAGECONVERTER=ON \
        -DWITH_ANYIMAGEIMPORTER=ON \
        -DWITH_ANYSCENECONVERTER=ON \
        -DWITH_ANYSCENEIMPORTER=ON \
        -DWITH_MAGNUMFONT=ON \
        -DWITH_OBJIMPORTER=ON \
        -DWITH_TGAIMAGECONVERTER=ON \
        -DWITH_TGAIMPORTER=ON \
        -DWITH_WAVAUDIOIMPORTER=ON \
        -DWITH_GL_INFO=ON \
        -DWITH_AL_INFO=ON \
        -DBUILD_TESTS=OFF \
        -DBUILD_GL_TESTS=OFF && \
    cmake --build . --target install
