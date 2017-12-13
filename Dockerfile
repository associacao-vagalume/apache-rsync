from httpd:2.2.31

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends rsync openssh-server && \
  apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir -p /home/ssh_user/public_html && \
  useradd --no-log-init ssh_user -d /home/ssh_user && \
  usermod --password '$1$M0bQuei9$pyZ6gK40bcHpj93nP0ulh.' ssh_user && \
  chown ssh_user:ssh_user -R /home/ssh_user

RUN echo '\n\
<VirtualHost *:80>\n\
ServerAdmin webmaster@vagalume.org.br\n\
DocumentRoot /home/ssh_user/public_html\n\
ServerName vagalume.org.br\n\
\n\
  <Directory "/home/ssh_user/public_html">\n\
      Options Indexes FollowSymLinks\n\
      AllowOverride All\n\
      Allow from all \n\
  </Directory>\n\
</VirtualHost>\n\
' >> /usr/local/apache2/conf/httpd.conf

COPY run.sh /usr/local/bin/

CMD ["run.sh"]