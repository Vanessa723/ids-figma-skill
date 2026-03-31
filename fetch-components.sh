#!/bin/bash
# Fetch IDS Component Keys from Figma
# Output: components-index.json
# Structure: indexed by component set name, with variants listed under each set
# Underscore-prefixed internal components are excluded

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

    const index = {
      _meta: {
        generated_at: new Date().toISOString(),
        file_key: '$FILE_KEY',
        note: 'Indexed by component set name. Each entry lists its variants and keys. Underscore-prefixed components excluded. Approved exceptions are listed in each product business config.'
      }
    };

    data.meta.components.forEach(comp => {
      if (comp.name.startsWith('_')) return;

      // Use containingComponentSet.name as the primary key (the human-readable component name)
      // Fall back to comp.name if no component set exists
      const setName = (
        comp.containing_frame &&
        comp.containing_frame.containingComponentSet &&
        comp.containing_frame.containingComponentSet.name
      ) || comp.name;

      if (setName.startsWith('_')) return;

      if (!index[setName]) index[setName] = { variants: {} };
      index[setName].variants[comp.name] = comp.key;
    });

    console.log(JSON.stringify(index, null, 2));
  " > components-index.json

echo "✓ Component index saved to components-index.json"
echo "  (Re-run this script whenever the IDS component library is updated)"
