FROM hub.c.163.com/library/python:3.6
MAINTAINER netease

ENV PHANTOM_VERSION phantomjs-2.1.1
ENV ARCH x86_64
ENV PHANTOM_JS $PHANTOM_VERSION-linux-$ARCH

# 更新软件源
RUN sed -i "s/security.debian.org/mirrors.163.com\/debian-security/g" /etc/apt/sources.list
RUN sed -i "s/deb.debian.org/mirrors.163.com/g" /etc/apt/sources.list

RUN apt-get update && apt-get install -y curl build-essential chrpath libssl-dev libxft-dev \
																					libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev \
		&& wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 \
		&& tar xvjf $PHANTOM_JS.tar.bz2 \
		&& mv $PHANTOM_JS /usr/local/share \								
		&& ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin \
		&& rm $PHANTOM_JS.tar.bz2 \
		&& pip install selenium \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

CMD ["python3"]
