# predictprotein and some of its underlying
# methods won't run on any Debian version
# greater than jessie
FROM debian:jessie-slim

# Keep Debian from asking questions
ENV DEBIAN_FRONTEND noninteractive

# Addresses package install failing due to non-existent man page directory
# See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN mkdir -p /usr/share/man/man1

# Create directory for perlbrew perl version needed to run some methods
# and copy perlbrew-provided compressed perl version
RUN mkdir -p /usr/share/profphd/prof/perl5/dists/
COPY /package/perlbrew/perl-5.10.1.tar.bz2 /usr/share/profphd/prof/perl5/dists/perl-5.10.1.tar.bz2

# Add necessary repos
COPY /config/etc/apt/*.conf                /etc/apt/
COPY /config/etc/apt/preferences.d/*.pref  /etc/apt/preferences.d/
COPY /config/etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/
COPY /config/etc/apt/apt.conf.d/*          /etc/apt/apt.conf.d/

# Add necessary debian packages
COPY /package/pp-cache-mgr/libboost/*.deb  /var/tmp/
COPY /package/pp-cache-mgr/libicu48/*.deb  /var/tmp/
COPY /package/system/*.deb                 /var/tmp/

# Main installation of all .deb files, including predictprotein.
# Doing this is an attempt at relying less on external sources for
# the Docker image build.
RUN dpkg --unpack --force-all /var/tmp/*.deb && \
    dpkg --configure -a && \
    rm /var/tmp/*.deb && \
    rm -rf /var/lib/apt/lists/* && \
    rm /usr/share/profphd/prof/perl5/dists/perl-5.10.1.tar.bz2 && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# New LetsEncrypt Root Certs - otherwise, loctree3 and metatstudent data files
# won't be able to be retrieved.
COPY /config/etc/ssl/certs/*.pem           /etc/ssl/certs/
RUN sed -i '/^mozilla\/DST_Root_CA_X3.crt$/ s/^/!/' /etc/ca-certificates.conf && \
    update-ca-certificates

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
    https://rostlab.org/public/metastudent/metastudent-data-3-1.0.1.tar.xz && \
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
    ln -s /etc/docker-predictprotein/predictproteinrc  /etc/predictproteinrc

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
