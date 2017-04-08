FROM alpine:3.3

ENV AWSCLI_VERSION "1.10.38"

RUN apk add --update bash groff less python py-pip \
    && pip install awscli==$AWSCLI_VERSION \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

COPY decrypt.sh /usr/bin/

RUN chmod +x /usr/bin/decrypt.sh

CMD "/usr/bin/decrypt.sh"
