FROM ruby:latest
ENV LANG ja_JP.UTF-8
ENV AOZORA_EPUB3_FILE AozoraEpub3-1.1.1b30Q.zip
ENV KINDLEGEN_FILE kindlegen_linux_2.6_i386_v2_9.tar.gz
ENV NAROU_VERSION 3.9.1
WORKDIR /opt/narou

RUN apt-get update && \
    apt-get install -y locales && \
    echo "ja_JP UTF-8" > /etc/locale.gen && \
    sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    apt-get install -y --no-install-recommends \
    build-essential \
    unzip wget && \
    rm -rf /var/lib/apt/lists/* 

RUN wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb && \
    dpkg -i jdk-21_linux-x64_bin.deb && \
    rm -rf jdk-21_linux-x64_bin.deb

COPY ${AOZORA_EPUB3_FILE} /tmp
COPY ${KINDLEGEN_FILE} /tmp
COPY init.sh /usr/local/bin

RUN unzip /tmp/${AOZORA_EPUB3_FILE} -d /opt/AozoraEpub3 && \
    rm /tmp/${AOZORA_EPUB3_FILE}

RUN mkdir -p /opt/kindlegen && \
    tar zxf /tmp/${KINDLEGEN_FILE} -C /opt/kindlegen && \
    ln -s /opt/kindlegen/kindlegen /opt/AozoraEpub3 && \
    rm /tmp/${KINDLEGEN_FILE}

RUN git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name" && \
    git clone 'https://github.com/whiteleaf7/narou.git' /opt/narou && \
    cd /opt/narou && \
    git remote add etg-lt 'https://github.com/etg-lt/narou.git' && \
    git remote add rogenobl 'https://github.com/rogenobl/narou.git' && \
    git fetch origin && \
    git fetch etg-lt && \
    git fetch rogenobl && \
    git merge --no-ff etg-lt/patch-1 && \
    git merge --no-ff etg-lt/patch-2 && \
    git merge --no-ff etg-lt/patch-3 && \
    git merge --no-ff rogenobl/fix/replace_erubis && \
    git merge --no-ff rogenobl/fix/yokogaki_text_conv && \
    gem build narou.gemspec && \
    gem install ./narou-${NAROU_VERSION}.gem && \
    gem install erubi -v 1.13 --no-document

RUN (echo ; cat /usr/local/bundle/gems/narou-${NAROU_VERSION}/preset/custom_chuki_tag.txt) >> /opt/AozoraEpub3/chuki_tag.txt

ENTRYPOINT ["init.sh"]
CMD ["narou", "web", "-p", "8200", "-n"]
