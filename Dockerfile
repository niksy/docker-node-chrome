FROM node:12

MAINTAINER Ivan Nikolić <niksy5@gmail.com>

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - ; \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' ; \
    apt-get update && apt-get install -y google-chrome-stable xvfb; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD xvfb.sh /etc/init.d/xvfb
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /etc/init.d/xvfb
RUN chmod +x /entrypoint.sh

ENV DISPLAY :99.0

ENV CHROME_BIN /usr/bin/google-chrome

ENTRYPOINT ["/entrypoint.sh"]
