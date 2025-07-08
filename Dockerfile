FROM ghcr.io/shadichy/aaropa_rootfs_base:main

COPY template /
COPY packages /
COPY scripts /

RUN apt update && apt upgrade -y

# Create needed folders
RUN mkdir -p /boot

# Install package list
RUN grep -Ev '^#' /pkglist.cfg | xargs apt install -y --no-install-recommends --no-install-suggests

# Post setup
RUN /post-setup.sh

# Clean up cache & files
RUN apt clean && rm -rf /var/lib/apt/lists/*
RUN rm /*.cfg /*.sh