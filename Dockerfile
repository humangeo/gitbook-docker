FROM node:11.2

RUN apt update && apt install -y -qq wget curl libfontconfig libgl1-mesa-dev libxrender-dev libxcomposite-dev python sudo \
                          gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 libfontconfig1 libgdk-pixbuf2.0-0 \
                          libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 fonts-liberation libappindicator3-1 libnss3 \
                          lsb-release xdg-utils fonts-droid-fallback
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

RUN npm install --unsafe-perm -g gitbook-cli@2.3.2 svgexport
RUN gitbook install
WORKDIR /docs

# run GitBook when the container starts
ENTRYPOINT ["gitbook"]
