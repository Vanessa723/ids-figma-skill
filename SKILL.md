---
name: figma-mcp-skill
description: Generates and edits Figma UI using IDS (Infra Design System) tokens, components, and business configs via Figma MCP. Use when the user mentions IDS, Infra Design System, SHOPEE design org, component-index, Space/DataSuite/Ask/Smart products, or asks to create or update Figma files to team standards.
---

# IDS Figma（Cursor 技能入口）

## 何时使用

在通过 **Figma MCP** 生成或修改设计稿、且需符合 **IDS** 与业务配置时启用本技能。不适用：Figma 插件、Figma Make / Stitch 等内置 AI 设计工具。

## 第一步：读完整规范

**必须先阅读**同目录下的 [figma-ids-design.md](figma-ids-design.md)（正文为完整生成规范）。该文件顶部的 YAML 仅供历史兼容；**技能发现以本 `SKILL.md` 的 frontmatter 为准**。

## 本目录资产（相对路径）

| 路径 | 用途 |
|------|------|
| [figma-ids-design.md](figma-ids-design.md) | 生成前检查、通用规则、业务章节、交付清单、Token 速查 |
| [components-index.json](components-index.json) | 按组件集名称索引的 variant → key，减少 API 查询 |
| [business-configs/](business-configs/) | 各产品线配置（标准模式时加载对应 `[product].md`） |
| [fetch-components.sh](fetch-components.sh) | 刷新组件索引（需 `FIGMA_TOKEN`） |
| [README.md](README.md) | 仓库说明、MCP 安装示例、环境变量 |

## MCP 与 Cursor

1. 配置 **Figma MCP**（Personal Access Token，读写权限）。具体写法见 [README.md](README.md)；Cursor 侧以编辑器 MCP 文档为准。
2. 调用 MCP 工具前**查看当前环境提供的工具 schema**（参数名以实际 MCP 为准）。
3. 规范中涉及的 **Figma REST 示例**（如拉取 styles）仍按 [figma-ids-design.md](figma-ids-design.md) 执行；与 MCP 能力互补时使用 MCP 优先、REST 补全。

## 执行顺序（摘要）

完整步骤与禁止项以 [figma-ids-design.md](figma-ids-design.md) 为准；此处仅作索引：

1. **Pre-flight**：拉取最新 tokens、加载 `components-index.json`、确认产品与模式、确认文件创建组织与位置。
2. **询问两个问题确认模式**（见 1.2 节）：
   - 探索模式（Explore）：任意产品 + 方向探索阶段 → 约束最小，创意优先，输出标注"Exploration Draft"
   - 标准模式（Standard）：成熟产品 + 准备交付 → 严格 IDS + 加载 `business-configs/[product].md`
   - 创意模式（Creative）：新产品 + 准备交付 → IDS 组件优先使用，新组件自由创建并注释
3. **交付**（标准 / 创意模式）：画布尺寸、Auto Layout、全 Token、英文真实文案、状态齐全、Annotation 帧、清单自检。

## 更新本技能内容

本目录为 Git 克隆时，可在终端执行：

```bash
git -C ~/.cursor/skills/figma-mcp-skill pull
```

上游仓库：<https://github.com/Vanessa723/figma-mcp-skill>
