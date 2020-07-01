FROM nginx

RUN mkdir -p /vault/config
RUN mkdir -p /var/log/vault
RUN mkdir -p /start

COPY vault /vault
RUN chmod 770 /vault/vault

COPY  start.sh /start
RUN chmod 770 /start/start.sh

CMD ["./start/start.sh"]
