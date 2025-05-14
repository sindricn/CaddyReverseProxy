
# 一键部署 Caddy 反向代理

此脚本用于加速访问在其他平台（如 Cloudflare Pages、Vercel、Netlify 等）部署的站点，并绑定自定义域名，支持自动生成 Caddyfile 配置并启动 Docker 容器。

## 功能

- 自动安装 Docker 容器版 Caddy
- 生成最小反向代理 Caddyfile 配置
- 支持命令行参数或交互式输入

## 使用方法

### 方式一：命令行参数方式（推荐）

如果你已经有域名和目标 URL，直接使用以下命令：

```bash
chmod +x deploy.sh
./deploy.sh yourdomain.com https://yourtarget.url
````

### 方式二：交互式输入方式

如果你不想传递命令行参数，可以直接运行脚本，脚本会提示输入：

```bash
./deploy.sh
```

然后依次输入你的 **域名** 和 **目标 URL**。

## 依赖

* Docker: 确保系统已安装 Docker

## 注意事项

* 脚本默认自动申请 HTTPS 证书，Caddy 会使用 Let's Encrypt。
* 请确保你的域名已经正确解析到服务器公网 IP。
* 脚本不会覆盖已存在的容器，更新时请手动删除旧容器：`docker rm -f caddy-reverse-proxy`。

## 支持平台

* Cloudflare Pages
* Vercel
* Netlify

其他平台的静态网站同样适用。


