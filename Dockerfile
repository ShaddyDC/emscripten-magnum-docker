FROM emscripten/emsdk AS builder

ARG BUILD_TYPE=RelWithDebInfo

RUN git clone --recurse-submodules https://github.com/mosra/corrade/ && \
    cd corrade/ && mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=OFF && \
    cmake --build . --target install
