# IDS Figma Design Skill

## 文件结构

```
~/.claude/skills/
├── figma-ids-design.md          # 主规范文件（通用规则）
└── business-configs/             # 业务配置目录
    ├── _template.md              # 配置模板
    ├── space.md                  # Space 业务配置
    ├── datasuite.md              # DataSuite 配置（待创建）
    ├── ask.md                    # Ask 配置（待创建）
    └── smart.md                  # Smart 配置（待创建）
```

## 使用方式

当你需要生成 Figma 设计时，直接告诉 Claude：

> "Generate a Figma design for [describe the interface]"

Claude 会自动：
1. 询问你是哪个产品（Space / DataSuite / Ask / Smart / Other）
2. 加载对应的业务配置文件
3. 按照 IDS 规范 + 业务规范生成设计

## 添加新业务配置

1. 复制 `_template.md` 为 `[product-name].md`
2. 填写产品背景、框架要求、Biz Components 清单
3. 保存后即可使用

## 修改现有配置

直接编辑对应的 `.md` 文件即可，无需重启 Claude。
