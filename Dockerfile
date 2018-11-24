FROM node:11.2 

RUN apt update && apt install -y -qq wget curl libfontconfig libgl1-mesa-dev libxrender-dev libxcomposite-dev python sudo
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

ENV USER_NAME='gitbook' 
RUN useradd --create-home --user-group --password "" "${USER_NAME}"

RUN mkdir -p /etc/sudoers.d/ && echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USER_NAME        
RUN su $USER_NAME -c ' \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 11 && npm install gitbook-cli svgexport -g'
    
# Todo... become user and install nvm
#         install gitbook-cli svgexport and run gitbook install
WORKDIR /docs

# run GitBook when the container starts
ENTRYPOINT ["/home/gitbook/.nvm/versions/node/v11.2.0/bin/gitbook"]
