FROM devuan/migrated:ceres-slim AS base

COPY template /
COPY packages /

RUN apt update && apt upgrade -y

# Install additional apt utils 
RUN apt install -y apt-transport-https ca-certificates

# Re-run apt update after install apt utils
RUN apt update

# Install package list
RUN grep -Ev '^#' /pkglist.cfg | xargs apt install -y --no-install-recommends --no-install-suggests

# Post-install actions
RUN rc-update add udhcpc default

# Clean up cache & files
RUN apt clean && rm -rf /var/lib/apt/lists/*
RUN rm /*.cfg