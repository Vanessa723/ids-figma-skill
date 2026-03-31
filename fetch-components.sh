#!/bin/bash
# Fetch IDS Component Keys from Figma
# Outputs to components-index.json — underscore-prefixed internal components are excluded

export FIGMA_TOKEN="${FIGMA_TOKEN:-[your_token_here]}"
export FILE_KEY="zANozorPV3t5sueU20e0Nx"

if [ "$FIGMA_TOKEN" = "[your_token_here]" ]; then
  echo "✗ Error: FIGMA_TOKEN is not set. Run: export FIGMA_TOKEN=your_token_here"
  exit 1
fi

echo "Fetching components from Figma..."

curl -s -H "X-Figma-Token: $FIGMA_TOKEN" \
  "https://api.figma.com/v1/files/$FILE_KEY/components" \
  | node -e "
    const data = JSON.parse(require('fs').readFileSync('/dev/stdin', 'utf8'));
    if (data.err) { console.error('Figma API error:', data.err); process.exit(1); }
    const components = {
      _meta: {
        generated_at: new Date().toISOString(),
        file_key: '$FILE_KEY',
        note: 'Underscore-prefixed internal components are excluded. See each product business config for approved exceptions.'
      }
    };
    if (data.meta && data.meta.components) {
      data.meta.components.forEach(comp => {
        if (!comp.name.startsWith('_')) {
          components[comp.name] = comp.key;
        }
      });
    }
    console.log(JSON.stringify(components, null, 2));
  " > components-index.json

echo "✓ Component index saved to components-index.json"
echo "  (Re-run this script whenever the IDS component library is updated)"
