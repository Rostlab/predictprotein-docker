# predictprotein and some of its underlying
# methods won't run on any Debian version
# greater than jessie
FROM debian:jessie-slim

# Keep and apt from asking questions
ENV DEBIAN_FRONTEND noninteractive

# Addresses package install failing due to non-existent man page directory
# See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN mkdir -p /usr/share/man/man1

# Install public keys for repos
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FCAE2A0E115C3D8A && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 228FE7B0D6EBED94 && \
    apt-key adv --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys 0xA5D32F012649A5A9

# So we can get packages from https repos and some necessary utilities
# By removing /var/lib/apt/lists it reduces the image size, since the apt cache is not stored in a layer.
# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run
RUN apt-get update && \
    apt-get install -y --force-yes \
    apt-transport-https \
    bzip2 \
    ca-certificates \
    gcc \
    locales \
    patch \
    wget \ 
    xz-utils && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Add necessary repos
COPY /config/etc/apt/*.conf                /etc/apt/
COPY /config/etc/apt/preferences.d/*.pref  /etc/apt/preferences.d/
COPY /config/etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/
COPY /config/etc/apt/apt.conf.d/*          /etc/apt/apt.conf.d/

# Copy necessary packages no longer available through repos
COPY /package/pp-cache-mgr/libboost/*.deb  /tmp/
COPY /package/pp-cache-mgr/libicu48/*.deb  /tmp/
RUN dpkg -i /tmp/libboost-system1.49.0_1.49.0-3.2_amd64.deb && \
    dpkg -i /tmp/libboost-filesystem1.49.0_1.49.0-3.2_amd64.deb && \
    dpkg -i /tmp/libboost-program-options1.49.0_1.49.0-3.2_amd64.deb && \
    dpkg -i /tmp/libicu48_4.8.1.1-12+deb7u7_amd64.deb && \
    dpkg -i /tmp/libboost-regex1.49.0_1.49.0-3.2_amd64.deb && \
    rm -f  /tmp/*.deb

# Update and install predictprotein from APT repos
RUN apt-get update && \
    apt-get install -y --force-yes --allow-unauthenticated rostlab-debian-keyring && \
    apt-get install -y --force-yes \
    gdebi-core \
    pp-cache-mgr \
    predictprotein \
    predictprotein-nonfree \
    snap2 \
    snap-cache-mgr && \
    rm -rf /var/lib/apt/lists/*

# Install Rostlab-LCSB-specific (NON-PUBLIC) predictprotein version
# replacing the general-availability version.
# Unlike dpkg, gdebi will make sure dependencies, if any, are also
# installed. 
# Wildcard package name is used with gdebi, so that this file
# doesn't have to be updated everytime there is a new version that
# needs to be installed.
COPY /package/predictprotein/*.deb /tmp/
RUN gdebi --n /tmp/predictprotein_*_all.deb && \
    rm -f /tmp/*.deb

# Now that the packages are installed, copy configs and make necessary ones
# available to docker hosts for configuring external services.
RUN mkdir /etc/docker-predictprotein && \
    mkdir /etc/ppcache && \
    mkdir /mnt/ppcache && \
    mkdir /mnt/ppcache/ppcache-data && \
    mkdir /mnt/ppcache/rost_db && \
    mkdir /mnt/ppcache/sequence-submit && \
    mkdir /mnt/ppcache/results-retrieve && \
    mkdir /usr/share/metastudent-data && \
    mkdir /var/tmp/config

# Retrieve data models needed for loctree3 and metastudent data files
RUN /usr/share/loctree3/loctree2data && \
    wget -O /usr/share/metastudent-data/metastudent-data-3-1.0.1.tar.xz \
    ftp://rostlab.org/metastudent/metastudent-data-3-1.0.1.tar.xz && \
    tar --no-same-owner --no-same-permissions --directory=/usr/share/metastudent-data/ -Jxvf /usr/share/metastudent-data/metastudent-data-3-1.0.1.tar.xz && \
    (cd /usr/share/metastudent-data/metastudent-data-3-1.0.1 && ./configure) && \
    make --directory=/usr/share/metastudent-data/metastudent-data-3-1.0.1 && \
    rm -f /usr/share/metastudent-data/metastudent-data-3-1.0.1.tar.xz

# Entrypoint script - very important
COPY /script/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Configuration files copied to staging area in container
COPY /config/etc/*rc                     /var/tmp/config/
COPY /config/etc/ppcache-my.cnf          /var/tmp/config/ppcache-my.cnf
COPY /config/sql/ppres_tables_mysql.sql  /var/tmp/config/ppres_tables_mysql.sql

# At this point, there are no files at /etc/docker-predictprotein/.
# The following links will be dangling. This is intentional since the
# /usr/local/bin/docker-entrypoint.sh script will copy the configs
# to /etc/docker-predictprotein/, from /var/tmp/config/, if they don't
# exist. This was done to avoid the bind mounts from hiding files where
# the mountpoint in the container exists. 
RUN ln -s /etc/docker-predictprotein/consurfrc         /etc/consurfrc && \
    ln -s /etc/docker-predictprotein/metastudentrc     /etc/metastudentrc && \
    ln -s /etc/docker-predictprotein/ppcache-my.cnf    /etc/ppcache/my.cnf && \
    ln -s /etc/docker-predictprotein/ppcacherc         /etc/ppcacherc && \
    ln -s /etc/docker-predictprotein/predictproteinrc  /etc/predictproteinrc && \
    ln -s /etc/docker-predictprotein/snap2rc           /etc/snap2rc && \
    ln -s /etc/docker-predictprotein/snapcacherc       /etc/snapcacherc

# Create user for running predictprotein - not host dependent
RUN groupadd -g 1000000 atlasg && useradd --no-log-init -g 1000000 -u 1000000 ppcache

# /etc/docker-predictprotein/ - contains the configuration files
# /mnt/ppcache contains subdirectories:
# * ppcache-data - predictprotein cache (ppcache) results database
# * rost_db      - rost_db (internal to Rostlab) or PPMI databases
# * sequence-submit - may be used, when bind mounted, to submit sequences using a file
# * results-retrieve - may be used, when bind mountd, to retrieve a result set from the cache (see ppc_fetch)
# If you don't bind with /mnt/ppcache with the above direcotries, they won't show up, since your bind mount
# hides the existing sub-directories that already exist under /mnt/ppcache in the container.
# /usr/share/loctree2-data - loctree3 data directory
# /usr/share/metastudent-data - metastudent data directory
VOLUME ["/etc/docker-predictprotein/", "/mnt/ppcache/", "/usr/share/loctree2-data", "/usr/share/metastudent-data"]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["predictprotein", "--help"]
