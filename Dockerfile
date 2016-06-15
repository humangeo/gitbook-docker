FROM node:6-slim

ADD docker-provision.sh /tmp/
RUN cd /tmp/ && sh docker-provision.sh

WORKDIR /docs

# run GitBook when the container starts
ENTRYPOINT ["gitbook"]
