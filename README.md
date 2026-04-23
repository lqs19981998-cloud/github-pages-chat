# GitHub Pages 部署说明

这个目录用于部署 `Pulse Relay` 多人实时互传页面到 GitHub Pages。

## 包含文件

- `index.html`
- `.nojekyll`
- `README.md`

## 部署步骤

1. 新建一个 GitHub 仓库
2. 把这 3 个文件上传到仓库根目录
3. 打开 GitHub 仓库的 `Settings` -> `Pages`
4. `Source` 选择：
   - `Deploy from a branch`
   - Branch 选 `main`
   - Folder 选 `/ (root)`
5. 保存后等待 GitHub Pages 发布

## 说明

- 页面已经内置 Supabase 项目的 `URL` 和 `publishable key`
- 首次进入会自动匿名登录
- 用户名会写入浏览器 `localStorage`
- 页面为无历史模式，只显示进入页面后的实时消息
- 图片支持 `jpg/png/gif`
- 所有上传文件限制为 `10MB`

## 清理策略

- 建议在 Supabase SQL Editor 执行：
  - `supabase/no-history-cleanup-1h.sql`
- 作用：
  - 每 10 分钟清理一次
  - 删除 10 分钟前的消息
  - 删除 10 分钟前的上传文件

## 注意

- 如果之后要换 Supabase 项目，直接改 `index.html` 里的：
  - `SUPABASE_URL`
  - `SUPABASE_KEY`
