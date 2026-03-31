# IDS Figma Design System Skill

A Claude Code skill for generating Figma UI designs that comply with IDS (Infra Design System) standards.

## Files

- `figma-ids-design.md` — Main skill file with universal design rules
- `components-index.json` — Pre-indexed component keys for faster lookup (834KB)
- `fetch-components.sh` — Script to refresh component index from Figma
- `business-configs/` — Product-specific configurations

## Quick Start

1. Set your Figma token:
```bash
export FIGMA_TOKEN="your_token_here"
```

2. Invoke the skill in Claude Code:
```
Generate a Figma design for [your description]
```

## Component Index

The `components-index.json` file contains all IDS component keys, enabling faster component lookup without repeated API calls.

To refresh:
```bash
./fetch-components.sh
```

## Adding New Products

Copy `business-configs/_template.md` to create a new product configuration.
