FROM registry.fedoraproject.org/fedora-minimal

COPY github-fetch.sh /bin/github-fetch

RUN microdnf install -y tar rpm-ostree skopeo selinux-policy selinux-policy-targeted policycoreutils tar patch ostree shadow unzip jq gzip rsync && \
    useradd kutara -u 1000 && \
    mkdir /data && \
    chown -R kutara:kutara /data

VOLUME ["/data"]

ENTRYPOINT [ "/bin/bash" ]
