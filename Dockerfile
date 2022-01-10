FROM registry.fedoraproject.org/fedora-minimal

COPY github-fetch.sh /bin/github-fetch

RUN microdnf install -y shadow unzip jq && \
    useradd kutara -u 1000

VOLUME ["/data"]

USER kutara

ENTRYPOINT ["/bin/github-fetch"]
