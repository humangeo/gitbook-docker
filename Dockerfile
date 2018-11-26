FROM node:11.2

RUN apt update && apt install -y -qq wget curl libfontconfig libgl1-mesa-dev libxrender-dev libxcomposite-dev python sudo
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

RUN npm install --unsafe-perm -g gitbook-cli@2.3.2 svgexport
WORKDIR /docs

# run GitBook when the container starts
ENTRYPOINT ["gitbook"]
