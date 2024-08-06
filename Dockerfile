FROM mono:latest

RUN apt-get update \
  && apt-get install -y \
  iproute2 supervisor ca-certificates-mono fsharp mono-vbnc nuget \
  referenceassemblies-pcl mono-fastcgi-server4 nginx nginx-extras \
  && rm -rf /var/lib/apt/lists/* /tmp/* \
  && echo "daemon off;" | cat - /etc/nginx/nginx.conf > temp && mv temp /etc/nginx/nginx.conf \
  && sed -i -e 's/www-data/root/g' /etc/nginx/nginx.conf

COPY mono/nginx/ /etc/nginx/
COPY mono/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY mono/pools /etc/mono/pools
COPY mono/publish /var/www/frameworkwebapplication

EXPOSE 80

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]