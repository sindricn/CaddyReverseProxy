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
