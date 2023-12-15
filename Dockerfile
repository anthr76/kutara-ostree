FROM registry.fedoraproject.org/fedora:40

COPY github-fetch.sh /bin/github-fetch

RUN \
    echo 'installonly_limit=20' >> /etc/dnf/dnf.conf && \
    echo 'fastestmirror=True' >> /etc/dnf/dnf.conf && \
    echo 'max_parallel_downloads=20' >> /etc/dnf/dnf.conf && \
    dnf install 'dnf-command(copr)' -y && \
    dnf copr enable anthr76/golang-to-fedora -y && \
    dnf install -y --nodocs --setopt=keepcache=0 \
    tar rpm-ostree skopeo podman selinux-policy selinux-policy-targeted \
    policycoreutils tar patch ostree shadow unzip jq gzip rsync s5cmd \
    busybox rng-tools dmraid device-mapper-multipath tpm2-tss nvme-cli \
    && useradd kutara -u 1000 \
    && mkdir /data \
    && mkdir -p /sysroot/ostree/repo \
    && ostree init -v --mode archive --repo /sysroot/ostree/repo \
    && ostree remote add kutara "https://ostree.kutara.io" --no-gpg-verify --repo /sysroot/ostree/repo \ 
    && chown -R kutara:kutara /data

VOLUME [ "/data" ]

ENTRYPOINT ["/bin/bash", "-l", "-c"]

LABEL org.opencontainers.image.source = https://github.com/anthr76/kutara-ostree
