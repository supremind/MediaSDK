FROM ubuntu18.04

RUN apt-get update -y && apt-get -y install \
    wget git vim cmake autoconf libtool libdrm-dev xorg xorg-dev openbox libx11-dev libgl1-mesa-glx libgl1-mesa-dev

# GMMLIB  Intel graphic mem manage lib
RUN git clone git clone https://github.com/intel/gmmlib.git && \
    cd gmmblib && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DARCH=64 .. && \
    make && make install

# INSTALL an implementation for VA-API (Video Acceleration API)
RUN git clone https://github.com/intel/libva.git && cd libva && \
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu && make && make install

RUN git clone https://github.com/intel/libva-utils.git && cd libva-utils && \
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu && make

# media driver
RUN git clone https://github.com/intel/media-driver.git && \
    cd media_driver && mkdir build && cmake ../media-driver && make && make install

RUN git clone https://github.com/intel/intel-vaapi-driver.git && \
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu make make install

RUN git clone https://github.com/supremind/MediaSDK.git && cd MediaSDK && \
    mkdir build && cd build && cmake.. && make && make install

