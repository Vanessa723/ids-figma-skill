# IDS Figma Design System Skill

An AI assistant skill for generating Figma UI designs that comply with IDS (Infra Design System) standards.

## What is this?

This skill enables AI assistants (Claude Code, Cursor, etc.) to generate Figma designs through the **Model Context Protocol (MCP)** by connecting to the Figma API. It provides comprehensive design rules, component references, and business-specific configurations.

**This is NOT for:**
- Figma plugins or extensions
- AI-native design tools like Figma Make or Stitch (which have their own built-in design systems)

**This IS for:**
- General-purpose AI assistants (Claude Code, Cursor) that need IDS design guidance
- Teams who want AI to generate Figma designs following their IDS standards via MCP

## Files

- `figma-ids-design.md` — Main skill file with universal design rules
- `components-index.json` — Pre-indexed component keys for faster lookup (834KB)
- `fetch-components.sh` — Script to refresh component index from Figma
- `business-configs/` — Product-specific configurations

## Quick Start

### Prerequisites
- AI assistant with MCP support (Claude Code, Cursor, etc.)
- Figma MCP server configured
- Figma Personal Access Token

### Setup

**Step 1: Install Figma MCP Server**

For Claude Code, add to `.claude/settings/mcp.json`:
```json
{
  "mcpServers": {
    "figma": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-figma"],
      "env": {
        "FIGMA_PERSONAL_ACCESS_TOKEN": "your_figma_token_here"
      }
    }
  }
}
```

For Cursor, refer to Cursor's MCP configuration documentation.

**Step 2: Get Figma Personal Access Token**

1. Go to Figma → Settings → Personal Access Tokens
2. Generate a new token with read/write permissions
3. Replace `your_figma_token_here` in the config above

**Step 3: Set Environment Variable (for scripts)**

```bash
export FIGMA_TOKEN="your_token_here"
```

**Step 4: Load this skill and invoke**

```
Generate a Figma design for [your description]
```

The AI will follow IDS standards, use design tokens, and reference the component index for faster generation.

## Component Index

The `components-index.json` file contains all IDS component keys, enabling faster component lookup without repeated API calls.

To refresh:
```bash
./fetch-components.sh
```

## Adding New Products

Copy `business-configs/_template.md` to create a new product configuration.
