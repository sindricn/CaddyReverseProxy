# Caddy Reverse Proxy

一个快速部署的反向代理服务，支持自动生成 Caddyfile 并通过 Docker 容器运行。适用于 Cloudflare Pages、Vercel、Netlify 等平台的自定义域名访问加速。

---

## 🚀 一键 Docker 部署（使用预构建镜像）

适合快速部署，使用你未来构建并发布的 Docker 镜像（如：`sindricn/caddy-reverse-proxy`）：

```bash
docker run -d \
  --name caddy-reverse-proxy \
  -e DOMAIN=example.com \
  -e TARGET=https://your.target.url \
  -p 80:80 -p 443:443 \
  sindricn/caddy-reverse-proxy
```

**参数说明：**

* `DOMAIN`：你的自定义域名（例如：`example.com`）。
* `TARGET`：目标地址（例如：`https://your.target.url`）。

> ✅ 此方式依赖你发布的镜像，未来在 Docker Hub/GitHub Container Registry 发布后使用。

---

## 🧩 使用 Docker Compose 部署

适合在开发/生产中统一管理服务：

### 示例 `docker-compose.yml`

```yaml
version: '3'
services:
  proxy:
    image: sindricn/caddy-reverse-proxy
    container_name: caddy-reverse-proxy
    ports:
      - "80:80"
      - "443:443"
    environment:
      - DOMAIN=example.com
      - TARGET=https://your.target.url
```

### 运行

```bash
docker-compose up -d
```

---

## 🛠️ 手动部署（本地生成 Caddyfile 并运行 Caddy 容器）

适合自定义配置或开发测试。

### 1. 克隆项目

```bash
git clone https://github.com/sindricn/CaddyReverseProxy.git
cd CaddyReverseProxy
```

### 2. 命令行参数方式（推荐）

```bash
chmod +x deploy.sh
./deploy.sh yourdomain.com https://yourtarget.url
```

### 3. 交互式方式

```bash
chmod +x deploy.sh
./deploy.sh
```

然后根据提示输入：

* 域名（如：`example.com`）
* 目标地址（如：`https://target.pages.dev`）

---

如有建议或问题，欢迎提交 issue 或 PR！


