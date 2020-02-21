# Nginx

编译安装Nginx

## Feature

```
OPENSSL 1.1.1d
NGINX 1.17.8
添加 `ngx_http_substitutions_filter_module` 模块，用于反向代理中替换过滤
```

## Use

```
docker run -d --name site -p 80:80 -p 443:443 \
-v /var/www:/var/www \
-v /etc/nginx/conf.d:/usr/local/nginx/conf.d \
-v /var/log/nginx:/usr/local/nginx/logs \
-v /etc/letsencrypt:/etc/letsencrypt \
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

## notice

镜像仅供参考，镜像的依赖、运行方式等可能会不定时修改。

Nginx 配置参考 [ryanlid/nginx-conf](https://github.com/ryanlid/nginx-conf)