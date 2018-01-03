from httpd:2.2.31

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends rsync openssh-server && \
  apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir -p /home/ssh_user/public_html && \
  useradd --no-log-init ssh_user -d /home/ssh_user -s /bin/bash && \
  usermod --password '$1$M0bQuei9$pyZ6gK40bcHpj93nP0ulh.' ssh_user && \
  chown ssh_user:ssh_user -R /home/ssh_user

RUN echo 'Include conf.d/*.conf' >> /usr/local/apache2/conf/httpd.conf

COPY httpd.conf /usr/local/apache2/conf.d/site.conf
COPY run.sh /usr/local/bin/

CMD ["run.sh"]
