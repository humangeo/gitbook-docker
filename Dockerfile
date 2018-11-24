FROM node:11

RUN apt update && apt install -y -qq wget curl libfontconfig libgl1-mesa-dev libxrender-dev libxcomposite-dev python sudo
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

ENV VAGRANT_PASSWORD='$6$rounds=656000$OY1EmeRe9//dqf8D$KRUcAe5ezDDL4hDe7nCGdURxev0jnIpOAAtfFzhPdd9wmNouedwX7EMxUaF16yrxxOUgpQlrpHVsZkIokXDKv0'
ENV VAGRANT_USER='vagrant' 
RUN useradd --create-home --user-group --password "${VAGRANT_PASSWORD}" "${VAGRANT_USER}"

RUN mkdir -p /etc/sudoers.d/ && echo "${VAGRANT_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant        
RUN su vagrant -c ' \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 11 && npm install gitbook-cli svgexport -g'
    
# Todo... become user and install nvm
#         install gitbook-cli svgexport and run gitbook install
WORKDIR /docs

# run GitBook when the container starts
ENTRYPOINT ["gitbook"]
