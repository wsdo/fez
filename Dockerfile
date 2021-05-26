FROM prodenv/node-base

# 使用nginx镜像
FROM nginx

# 时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

# 配置服务器端口
EXPOSE 3333

CMD ["nginx"]
