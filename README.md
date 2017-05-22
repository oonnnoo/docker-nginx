# Nginx

编译安装Nginx

## Feature

```
OPENSSL 1.0.2k
NGINX 1.13.0
添加 `ngx_http_substitutions_filter_module` 模块，用于反向代理中替换过滤
```

## Use

```
docker run -d --name site -p 80:80 -p 443:443 \
-v /var/www:/usr/local/nginx/html \
-v /etc/nginx/conf.d:/usr/local/nginx/conf.d \
-v /var/logs/nginx:/usr/local/nginx/logs  onnno/nginx
```
