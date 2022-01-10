FROM registry.fedoraproject.org/fedora-minimal

COPY github-fetch.sh /bin/github-fetch

RUN microdnf install -y tar shadow unzip jq gzip rsync && \
    useradd kutara -u 1000 && \
    mkdir /data && \
    chown -R kutara:kutara /data

USER kutara

VOLUME ["/data"]

ENTRYPOINT [ "/bin/bash" ]
