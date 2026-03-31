#!/bin/bash
# Fetch IDS Component Keys from Figma

export FIGMA_TOKEN="${FIGMA_TOKEN:-[your_token_here]}"
export FILE_KEY="zANozorPV3t5sueU20e0Nx"

echo "Fetching components from Figma..."

curl -s -H "X-Figma-Token: $FIGMA_TOKEN" \
  "https://api.figma.com/v1/files/$FILE_KEY/components" \
  | node -e "
    const data = JSON.parse(require('fs').readFileSync('/dev/stdin', 'utf8'));
    const components = {};
    if (data.meta && data.meta.components) {
      data.meta.components.forEach(comp => {
        // Skip underscore-prefixed internal components
        if (!comp.name.startsWith('_')) {
          components[comp.name] = comp.key;
        }
      });
    }
    console.log(JSON.stringify(components, null, 2));
  " > components-full.json

echo "✓ Full component index saved to components-full.json"
