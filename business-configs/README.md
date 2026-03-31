# Business Configurations

This directory contains product-specific design configurations for the IDS Figma skill.

## Directory Structure

```
business-configs/
├── README.md              # This file
├── _template.md           # Template for new product configs
├── space.md               # Space product configuration
├── datasuite.md           # DataSuite configuration (to be created)
├── ask.md                 # Ask configuration (to be created)
└── smart.md               # Smart configuration (to be created)
```

## How It Works

When generating a Figma design, the AI will:
1. Ask which product the interface is for (Space / DataSuite / Ask / Smart / Other)
2. Load the corresponding business configuration file
3. Apply IDS universal rules + product-specific rules

## Adding a New Product Configuration

1. Copy `_template.md` to `[product-name].md`
2. Fill in:
   - Product overview and target users
   - Mandatory page framework structure
   - Available business components
   - Content patterns and domain vocabulary
3. Save and commit — the configuration is immediately available

## Modifying Existing Configurations

Edit the corresponding `.md` file directly. Changes take effect immediately.
