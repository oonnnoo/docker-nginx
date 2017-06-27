FROM onnno/ubuntu:16.04-0.1.0

MAINTAINER Dong Li "docker@lidong.me”

ENV SSL_VERSION 1.0.2k
ENV NGINX_VERSION 1.13.2

RUN apt-get update \
	&& apt-get install -y wget unzip gcc build-essential libpcre3 libpcre3-dev zlib1g-dev \
	&& apt-get autoremove \

# 下载openssl
	&& wget -c https://www.openssl.org/source/openssl-$SSL_VERSION.tar.gz \
	&& tar zxf openssl-$SSL_VERSION.tar.gz \
	&& mv openssl-$SSL_VERSION/ openssl \

# 下载 ngx_http_substitutions_filter_module 模块，用于反向代理中替换过滤
	&& wget -c https://github.com/yaoweibin/ngx_http_substitutions_filter_module/archive/master.zip \
	&& unzip master.zip \

# 下载安装 nginx
	&& wget -c https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz \
	&& tar xvf nginx-$NGINX_VERSION.tar.gz \
	&& cd nginx-$NGINX_VERSION \
	&& ./configure --with-http_v2_module --with-http_ssl_module --with-openssl=./../openssl/ --add-module=./../ngx_http_substitutions_filter_module-master/ \
	&& make \
	&& make install \
	&& /usr/local/nginx/sbin/nginx -V \
	&& rm -rf master.zip \
	&& rm -rf /ngx_http_substitutions_filter_module-master \
	&& rm -rf /openssl \
	&& rm -rf /var/lib/apt/lists/* \

# forward request and error logs to docker log collector
  && ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
  && ln -sf /dev/stderr /usr/local/nginx/logs/error.log
	
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

# VOLUME
# "/var/www" 网站文件目录
# "/usr/local/nginx/logs" Nginx日志目录
# "/usr/local/nginx/conf.d" Nginx配置文件目录
# "/etc/letsencrypt" SSL证书保存目录
VOLUME ["/var/www","/usr/local/nginx/logs","/usr/local/nginx/conf.d","/etc/letsencrypt"]

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
