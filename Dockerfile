FROM debian:bullseye
RUN apt-get update && \
    apt-get install -y bash salt-master salt-ssh bash openssh-client
RUN mkdir /s
WORKDIR /s
CMD ["/s/entrypoint.sh"]