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
-v /var/www:/var/www \
-v /etc/nginx/conf.d:/usr/local/nginx/conf.d \
-v /var/logs/nginx:/usr/local/nginx/logs \
-v /etc/letsencrypt:/etc/letsencrypt\
onnno/nginx
```

## Useful command

测试 Nginx 配置文件是否正确

```
docker exec [Container_ID] /usr/local/nginx/sbin/nginx -t
```

Nginx 重启，并重新加载配置文件

```
docker exec [Container_ID] /usr/local/nginx/sbin/nginx -s reload
```
