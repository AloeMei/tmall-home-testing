# 天猫家居检测项要求

天猫家居类目商品检测要求的可筛选查询网页。

## 在线访问（稳定域名）

https://aloemei.github.io/tmall-home-testing/

## 功能

- 四级筛选：一级类目 → 叶子类目名称 → 检测项目 → 标准更新项（全部/有更新/无更新），均为可搜索下拉，级联联动
- 全字段关键词搜索，命中黄色高亮
- 8 列完整展示：一级类目 / 叶子类目名称 / 检测项目 / 检测项目要求 / 检测项目名称 / 测试标准 / 判定标准（产品标准） / 检测结果要求
- 长文本智能排版：标准号（GB/GB/T/FZ/T 等）一行一条等宽卡片、《》/# 标题灰色小字、指标名加粗、逗号分号拆 bullet
- 标准更新标注：月度定时任务核查国家标准新版本，有更新的标准号旁显示红色「已更新」徽章，点击弹窗查看新旧版本、发现日期与来源链接

## 数据与构建

- `data.json`：437 条检测记录（源：天猫家居检测项要求.docx 单表）
- `standards_updates.json`：标准更新记录（月度定时任务维护）
- `template.html`：页面模板（含 `__DATA_JSON__` / `__UPDATES_JSON__` 占位符）
- `build.ps1`：构建脚本，将数据内联进 `index.html`（单文件、无外部依赖）
- `index.html`：构建产物，即 GitHub Pages 部署的页面

重新构建：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File build.ps1
```

## 更新流程

每月 1 日 09:00 定时任务自动：核查标准更新 → 更新 standards_updates.json → 运行 build.ps1 → git push → GitHub Pages 自动部署（域名不变）。
