FROM node:0-slim

ADD docker-provision.sh /tmp/
RUN cd /tmp/ && sh docker-provision.sh && rm /tmp/docker-provision.sh

WORKDIR /docs

# run GitBook when the container starts
ENTRYPOINT ["gitbook"]
