# IDS Figma Design System Skill

A Claude Code skill for generating Figma UI designs following the IDS (Infra Design System) standards.

## Features

- **Token-first approach**: Enforces 100% design token coverage (no hardcoded values)
- **Multi-product support**: Extensible business configuration system
- **Responsive by default**: 1728px primary + 1440px secondary canvas
- **Complete state coverage**: Ensures all interactive states are designed
- **Auto Layout mandatory**: Enables proper responsive behavior

## Structure

```
figma-ids-design.md          # Main specification (universal rules)
business-configs/
  ├── _template.md            # Template for new products
  ├── space.md                # Space product configuration
  └── README.md               # Configuration guide
```

## Usage

In Claude Code, simply say:

> "Generate a Figma design for [your interface description]"

Claude will ask which product (Space, DataSuite, Ask, Smart, etc.) and apply the appropriate rules.

## Adding New Products

1. Copy `business-configs/_template.md` to `business-configs/[product-name].md`
2. Fill in product background, framework requirements, and Biz Components
3. Save and use immediately

## Requirements

- Figma Personal Access Token (for fetching latest design tokens)
- IDS Component UI Kit: `https://www.figma.com/design/zANozorPV3t5sueU20e0Nx`
