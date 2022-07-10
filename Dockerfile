FROM registry.fedoraproject.org/fedora-minimal:36@sha256:0ddce246625479dcf8ea8404e6e5342c27e35f6af579428fc59336a4bea67afe

COPY github-fetch.sh /bin/github-fetch

RUN microdnf install -y --nodocs --setopt=keepcache=0 \
    tar rpm-ostree skopeo podman selinux-policy selinux-policy-targeted \
    policycoreutils tar patch ostree shadow unzip jq gzip rsync && \
    useradd kutara -u 1000 && \
    mkdir /data && \
    mkdir -p /sysroot/ostree/repo && \
    ostree init -v --mode archive-z2 --repo /sysroot/ostree/repo && \
    ostree remote add kutara https://ostree.kutara.io --no-gpg-verify --repo /sysroot/ostree/repo && \ 
    chown -R kutara:kutara /data

VOLUME ["/data"]

ENTRYPOINT [ "/bin/bash" ]
