FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    wget curl perl xz-utils \
    build-essential \
    libxrender1 libfontconfig1

# Install TeX Live
RUN mkdir /install-tl && \
    cd /install-tl && \
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    echo "selected_scheme scheme-full" > texlive.profile && \
    ./install-tl --profile=texlive.profile

# update path
ENV PATH="/usr/local/texlive/2025/bin/x86_64-linux:${PATH}"

# Install aditionals packets
RUN tlmgr install xcolor

WORKDIR /data
CMD ["pdflatex"]

