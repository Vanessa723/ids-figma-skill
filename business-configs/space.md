# Space Business Configuration

## Product Overview

**Space** is an internal enterprise cloud platform — conceptually similar to Alibaba Cloud or AWS Console, but purpose-built for the company's internal infrastructure and operations.

**Target users:** Internal engineers and operators managing infrastructure resources, configurations, monitoring, and deployments.

**Key characteristics:**
- Dashboard-heavy, data-dense layouts
- Resource management tables (list, filter, sort, paginate)
- Status-driven UI (health states, alert levels, operational flags)
- Multi-level navigation (product lines → sub-products → feature pages)

---

> **Reading guide — read sections in this order:**
>
> 1. **Space Design Language** — The principles behind every Space design decision. Read this first. Apply these principles for every page you generate, whether or not a Biz Component exists.
> 2. **Page Archetypes** — Concrete layout blueprints with ASCII diagrams for the most common Space page types. Use these as your starting layout template.
> 3. **Available Space Biz Components** — Reference index of available Figma components and their variants. Use when they fit; compose from IDS primitives (following the design language) when they don't.

---

## Space Design Language

> **How to use this section:** Biz Components are the pre-built expression of these principles. When a Biz Component exists, use it. When it doesn't, or when the design needs to go beyond what's available, compose from IDS primitives — but always follow these principles. A page that applies these principles correctly will feel native to Space, even without a single Biz Component.

---

### 1. The Navigation Shell

Every Space page lives inside a fixed shell: a 48px top bar + a collapsible side navigation. These two pieces establish where the user is in the product universe.

```
┌──────────────────────────────────────────────────────────────┐
│                        Topbar                                 │  Fixed 48px
├──────────────┬───────────────────────────────────────────────┤
│              │              Page Header                        │
│   Sidebar    ├───────────────────────────────────────────────┤
│  240px / 64px│                                                │
│  collapsed   │            Content Area                        │
│              │                                                │
└──────────────┴───────────────────────────────────────────────┘
```

**Top bar (Topbar)**
- Always 48px, fixed, spans full width
- Left: global menu toggle + product logo/title
- Center: platform-wide search
- Right: notification, user identity, settings icons

**Side navigation (Sidebar)**
- 240px expanded / 64px collapsed (icon-only)
- Structure from top to bottom:
  1. **Context selector** — a Select dropdown for switching namespace, environment, or product. If the sidebar covers multiple products (`Type=Aggregate`), multiple named sections each have their own nav group.
  2. **Navigation items** — hierarchical list with icons; second-level items indent under an expand/collapse chevron
  3. **Utility links** (always at bottom, above the collapse toggle) — User Guide · Raise Issue · Raise Feature. These are secondary access points, never navigation.
- The active item is highlighted with brand blue. Parent items of the active item show as partially highlighted.
- Content area never overlaps the sidebar — they sit side by side.

**Design principle:** The sidebar tells users "what product am I in, and where inside it." The top bar tells users "who am I, and what platform is this." Keep these roles distinct — never put page-level actions in the top bar, and never put global identity in the sidebar.

---

### 2. Page Identity Frame

Every content page has exactly one Page Header. Its job is to answer three questions in order: *Where am I? What am I looking at? What can I do?*

**Page Header anatomy (three horizontal zones):**
```
[ ← Breadcrumb path / Resource ▾ ]                     ← Navigation aids (left)
  ← Title         [Tag] [Tag]     [Action] [Action] [Primary] [⋮]  ← Operations (right)
    Description text (1–2 lines max)
```

**Depth determines complexity:**

| Page depth | What to include | Pattern |
|-----------|----------------|---------|
| Root / feature landing | Title + description | No breadcrumb, no back arrow, no action buttons |
| Resource list (within a product section) | Breadcrumb + title | No back arrow, no MetaInfo |
| Entity detail (a specific resource) | Back arrow + breadcrumb + title + tags + MetaInfo + actions | Full Standard header |
| Dashboard / workspace | Title only, full width | Advanced level, no breadcrumb |

**MetaInfo grid (below the header, for entity pages)**
- 4 columns, 2–3 rows of `Label: Value` pairs
- Labels use secondary text color (.45); values can be text, Avatar, Avatar Group, Tag, or Button (link)
- Shows ownership, region, timestamps, related resource shortcuts
- Edit button top-right if the entity's metadata is editable
- Do NOT use MetaInfo for page-level configuration — it's for object identity only

**Design principle:** Tags next to the title = status/type of the entity, not page state. Description = orientation text for first-time users, not operational instructions. Action buttons = the 2–3 most important things a user can do on this page, not a complete list.

---

### 3. Filter → Table Composition

Every data list in Space follows the same two-component rhythm: **Filter Form above, Table below**. They are always presented together, never one without the other.

**Filter form rules:**
- First row: always a full-width General Search input (covers name/keyword search)
- Subsequent rows: structured `Label: Field` pairs in a grid (3 columns default, 4 columns for dense filters)
- Field types: Select, Input, DateRange (never freeform text areas)
- Control row (last): `+` add-filter · filter settings · sort · `Reset` · `Search (primary)` · `Expand ▾`
- Default state: collapsed (shows only 1–2 rows). "Expand" reveals all rows.
- Spacing: 24px padding all around, 8px gap between field rows

**Table rules:**

*Toolbar (always present):*
- Left: Table title (h5/bold) + optional "Last Update: [timestamp]" (shows when data is live/polling)
- Right: Action buttons (2 default + 1 primary + ⋮ overflow) + utility controls (↻ refresh + timer + density + column settings + fullscreen)
- Toolbar height: 56px

*Summary stats row (optional, for monitoring/alert tables):*
- Inline text stats: `Label: N · Label: N · ...` using semantic color for the numbers
- Shows aggregate counts that orient the user before they scan rows

*Bulk action bar (conditional — appears only when ≥1 row selected):*
- Replaces the column header area visually
- Left: `[✓ N Selected] [Unselect]`
- Right: bulk action buttons (never more than 3 visible)

*Table rows:*
- Column order: selection checkbox (if bulk-enabled) → expand toggle (if tree) → primary identifier → key attributes → status → actions
- Status values: ALWAYS use `Tag / Status` with semantic colors — never plain text
- Row actions: max 3 visible text links (Detail · [domain action] · Edit), remaining in `⋮` Dropdown
- Dangerous actions (Delete, Disable) are NEVER visible in the row — always inside `⋮`

*Pagination:* always present at the bottom. Pattern: `< 1 2 3 ... N >` + page-size selector + quick jump input.

**Design principle:** The filter form and table are one unit. A table without filters implies the data is small enough to not need filtering — if it has more than 20 rows, it needs a filter form. A filter form without a table has no meaning.

---

### 4. Destructive Operation Protocol

Deleting, disabling, or resetting infrastructure resources is serious. Space uses a dedicated pattern — not a generic browser `confirm()` or a standard Modal with custom content.

**Always show:**
1. What is being deleted (name + type)
2. Why this is dangerous (consequence text, not just "are you sure")
3. An explicit typed confirmation or a clear Cancel button

**Size by severity:**

| Scenario | Width | Has table? | Alert position |
|----------|-------|-----------|---------------|
| Simple single-resource delete | 480px Standard | No | None |
| Delete with a critical irreversible warning | 480px Standard | No | Top |
| Delete with visible impacted items | 480px Standard | Yes | None or Bottom |
| Cascading delete / large blast radius | 800px Advanced | Yes | Top |

**Alert position semantics:**
- `Top` = "Read this before you decide to proceed" (warning about irreversibility or side effects)
- `Bottom` = "Here is the consequence of your decision" (shown after user has seen the form, just above the action buttons)

**Design principle:** If a delete action affects more than one resource, always show a table of what will be affected. The user must be able to see the full blast radius before confirming. This is not a UX nicety — it's an operational safety requirement.

---

### 5. Configuration Change Visualization

When a user is about to apply a configuration change — or when reviewing what changed historically — Space uses a side-by-side diff view, not a modal summary or a "before/after" description.

**Layout:**
- Left panel: old/before state
- Right panel: new/after state
- Both panels: synchronized line numbers, monospace font (Courier Prime), 28px row height

**Line-level change types:**
- `default` (white): unchanged line, present in both panels
- `Delete` (red bg + `—` icon): entire line removed — left panel only
- `Added` (green bg + `+` icon): entire line added — right panel only
- `None` (hatched pattern): alignment placeholder — one side has more lines than the other

**Token-level change types** (for lines that changed partially):
- `Before` (red bg, specific tokens highlighted red): the old version of a modified line
- `After` (green bg, specific tokens highlighted green): the new version of the same line

**Design principle:** Config diff is a trust-building mechanism. Users need to see exactly what will change — not "you changed the timeout from 30s to 60s" in a summary, but the actual line highlighted. The hatched placeholder rows are critical for alignment: they tell users "nothing exists here on this side, the other side has something extra."

---

### 6. Operational Trust Signals

Space serves infrastructure engineers who need to trust the data they see. Certain UI signals exist specifically to communicate data freshness and operational state.

**Timestamp:** Tables showing live or frequently-updated operational data MUST show a "Last Update: [timestamp]" next to the table title. This is a trust signal — it tells users when the data was last synced.

**Auto-refresh controls:** For monitoring or alerting tables, show a refresh button + interval selector (e.g., 30s ▾) in the toolbar. This signals to users that the table is actively polling and they can control the frequency.

**Semantic status colors:** Never represent status as plain text. Always use `Tag / Status` with the appropriate color:
- Running / Active / Healthy → brand blue (`Primary (Infra Blue)/6`)
- Stopped / Inactive / Disabled → gray (`Gray/gray-6`)
- Error / Failed / Critical → red (`Dust Red/6`)
- Warning / Degraded → orange (`Sunset Orange/6`)
- Success / Completed → green (`Polar Green/2`)

**Loading states:** Any data region that is fetching must show a skeleton loader (not a spinner on an empty table). Tables in loading state show skeleton rows matching the expected row count.

**Design principle:** An infra engineer's job depends on accurate, timely information. Every visual element should communicate either the state of a resource or the freshness of the data showing it. If a color, timestamp, or indicator can be omitted, ask whether removing it reduces operational clarity — if yes, keep it.

---

## Page Archetypes

These are the canonical page types in Space. When generating a page, identify which archetype applies first, then compose content within the Content Area accordingly.

---

### Archetype 1: Resource Detail Page (Entity-scoped)

**When used:** User navigates into a specific resource/entity to view its full context — metadata, status, and related sub-resources organized by tabs.

**Sidebar variant:** `Type=Aggregate, Global Filter=Yes, Sidebar Collapsed=No`

```
┌──────────────────────────────────────────────────────────────────────────┐
│ Topbar  [☰] [● Logo · Title]          [🔍 Search]    [icons] [👤 User]  │  48px
├───────────────────┬──────────────────────────────────────────────────────┤
│ Sidebar           │ [ℹ Alert title                                    ✕] │  Alert (optional)
│  Type=Aggregate   ├──────────────────────────────────────────────────────┤
│                   │ Nav Item  /  Resource ▾               ← Breadcrumb   │
│ Product Name      ├──────────────────────────────────────────────────────┤
│ [Select        ▾] │ ← Nav Item   Resource   [Tag][Tag]                   │
│                   │   Description text...                                │
│ [□] Nav Item      │                          [Action C] [Action B] [A●] ⋮│  Page Header
│ [■] Nav Item      ├──────────────────────────────────────────────────────┤
│ [▼] Nav Item      │ Meta Information                          [✎ Edit]   │
│      Nav Item     │ ┌──────────────┬──────────────┬──────────┬──────────┐│
│      Nav Item     │ │ Label: val   │ Label: val   │ Label:   │ Label:   ││
│      Nav Item     │ │ Label: val   │ Label: val   │ Label:   │ Label:   ││
│                   │ │ Label: val   │ Label: val   │ Label:   │ Label:   ││
│ Product Name      │ └──────────────┴──────────────┴──────────┴──────────┘│  MetaInfo
│ [□] Nav Item      ├──────────────────────────────────────────────────────┤
│ [□] Nav Item      │ [Tab ━━━]  Tab   Tab   Tab                           │  Tabs
│ [■] Nav Item      ├──────────────────────────────────────────────────────┤
│ [▼] Nav Item      │ [🔍 General Search    ]  [Label: Select▾] [Label: Date──Date] │
│      Nav Item     │ [Label: Select▾       ]  [Label: Input  ] [Label: Input     ] │
│      Nav Item     │ [Label: Select▾       ]  [Label: Select▾] [+][⚙] [Reset][Search●][Expand▾] │
│      Nav Item     ├──────────────────────────────────────────────────────┤  Query Filter
│                   │ Table Title  Updated: timestamp   [Btn][Btn][Btn●] ⋮  [↻][30s▾][⊞][⚙][⛶] │
│ ────────────────  │ Stat · N   Stat · N   Stat · N   Stat · N            │  Table toolbar
│ ⊕  User Guide     ├──────────────────────────────────────────────────────┤
│ ⚠  Raise Issue    │ [✓ N Selected] [Unselect]              [Btn][Btn][Btn]│  Bulk action (conditional)
│ ★  Raise Feature  ├──────────────────────────────────────────────────────┤
│                   │ [+][☐] Name     Job Type   Date        Status  Actions│
│ [☰]          [⚙] │ [+][☐] cell     Master...  2022-06-02  [●]  Detail Monitor Edit ⋮ │
└───────────────────┤ [+][☐] cell     Slave...   2022-06-02  [●]  Detail Monitor Edit ⋮ │
                    │ [+][☐] cell     Slave...   2022-06-02  [●]  Detail Monitor Edit ⋮ │
                    ├──────────────────────────────────────────────────────┤
                    │ < 1  2  3  4  5  ...  50  >   10/Page ▾  Go to __ Page │
                    └──────────────────────────────────────────────────────┘
```

| Zone | Biz Component | Notes |
|------|--------------|-------|
| Alert Banner | IDS `Alert` (type=info) | Optional, dismissible, spans full content width |
| Breadcrumb | `_Breadcrumb` inside `Space / Page Header` | Shows hierarchy path with last segment as dropdown |
| Page Header | `Space / Page Header` | Back arrow + entity title + tags + description + action buttons |
| MetaInfo | `_Space / Page header / MetaInfo` | 4-column grid; values can be text, avatar, tag, button |
| Tabs | IDS `Tabs / Basic` (Position=Top, Size=Large) | Each tab typically shows one Query Filter + Full Table |
| Query Filter | `Space / Query Filter` | General Search + Label:Field rows + Reset/Search/Expand |
| Full Table | `Space / Full Table` | Toolbar + optional stats row + bulk action + table + pagination |

---

### Archetype 2: Feature Overview Page (Product-scoped)

**When used:** User lands on the top-level section of a product or feature area. No specific entity context — just a categorized list view with optional tabs.

**Sidebar variant:** `Type=Default, Global Filter=Yes, Sidebar Collapsed=No`

```
┌──────────────────────────────────────────────────────────────────────────┐
│ Topbar  [☰] [● Logo · Title]          [🔍 Search]    [icons] [👤 User]  │  48px
├───────────────────┬──────────────────────────────────────────────────────┤
│ Sidebar           │ Product Name                                          │
│  Type=Default     │ Product description text...                          │  Page Header (simple)
│                   ├──────────────────────────────────────────────────────┤
│ Product Name      │ [Tab ━━━]  Tab   Tab   Tab                           │  Tabs
│ [Select        ▾] ├──────────────────────────────────────────────────────┤
│                   │ [🔍 General Search    ]  [Label: Select▾] [Label: Date──Date] │
│ [□] Nav Item      │ [Label: Select▾       ]  [Label: Input  ] [Label: Input     ] │
│ [□] Nav Item      │ [Label: Select▾       ]  [Label: Select▾] [+][⚙] [Reset][Search●][Expand▾] │
│ [■] Nav Item      ├──────────────────────────────────────────────────────┤  Query Filter
│ [▼] Nav Item      │ Table Title                    [Btn][Btn][Btn●] ⋮  [↻][⚙][⛶] │
│      Nav Item     │                                                       │  Table toolbar
│      Nav Item     ├──────────────────────────────────────────────────────┤
│ [□] Nav Item      │ [✓ N Selected] [Unselect]              [Btn][Btn][Btn]│  Bulk action (conditional)
│ [▼] Nav Item      ├──────────────────────────────────────────────────────┤
│      Nav Item     │ [+][☐] Name     Job Type   Date        Status  Actions│
│ [▼] Nav Item      │ [+][☐] cell     Master...  2022-06-02  [●]  Detail Monitor Edit ⋮ │
│      Nav Item     │ [+][☐] cell     Slave...   2022-06-02  [●]  Detail Monitor Edit ⋮ │
│      Nav Item     │ [+][☐] cell     Slave...   2022-06-02  [●]  Detail Monitor Edit ⋮ │
│                   │ [+][☐] cell     Slave...   2022-06-02  [●]  Detail Monitor Edit ⋮ │
│ ────────────────  ├──────────────────────────────────────────────────────┤
│ ⊕  User Guide     │ < 1  2  3  4  5  ...  50  >   10/Page ▾  Go to __ Page │
│ ⚠  Raise Issue    └──────────────────────────────────────────────────────┘
│ ★  Raise Feature
│ [☰]          [⚙]
└───────────────────
```

| Zone | Biz Component | Notes |
|------|--------------|-------|
| Page Header | `Space / Page Header` (simple variant) | Title + description only — no back arrow, no tags, no action buttons |
| Tabs | IDS `Tabs / Basic` (Position=Top, Size=Large) | Appears immediately below the page header |
| Query Filter | `Space / Query Filter` | Same structure as Archetype 1 |
| Full Table | `Space / Full Table` | No summary stats row in this archetype (simpler toolbar) |

**Key differences from Archetype 1:**
- No Alert Banner, no Breadcrumb, no MetaInfo
- Page Header is simplified (title + description, no entity-level actions)
- Sidebar uses `Type=Default` (flat nav, no product-grouping headers)
- Table toolbar typically does not show the summary stats row

---

## Available Space Biz Components

> These components implement the Space Design Language principles above. **Use when they fit.** When no Biz Component covers the scenario, compose from IDS primitives following the design language — the result should feel equally native.

**Note:** Some Space business components have underscore prefixes but are approved for use within Space designs. These are exceptions to the general rule in section 2.2 of the main spec.

### Navigation

#### `Topbar`
Variants: `Brand=Default` (standard infra blue) · `Brand=Smart` (Smart product color scheme)

#### `Space / Sidebar`
Docs: https://infrad.shopee.io/space-biz/space-sidebar/

| Dimension | Values | Meaning |
|-----------|--------|---------|
| `Type` | `Default` | Flat single-product nav list — items at one level with optional expand/collapse |
| | `Aggregate` | Multi-product grouped nav — multiple "Product Name" section headers, each with their own nav items. Only available with `Global Filter=Yes` |
| `Global Filter` | `Yes` | Shows a Select dropdown at top (for namespace / environment / product switching) |
| | `No` | No selector, nav items appear directly below the product label |
| `Sidebar Collapsed` | `No` | 240px wide — shows icons + labels |
| | `Yes` | 64px wide — icons only, labels appear on hover as tooltip |

**Bottom utility area** (always present): User Guide · Raise Issue · Raise Feature links + collapse toggle + settings icon

**When to use which:**
- `Default, Global Filter=No` → single product, no environment switching (simplest)
- `Default, Global Filter=Yes` → single product but needs namespace / environment selector
- `Aggregate, Global Filter=Yes` → umbrella page grouping multiple sub-products (e.g., Infra & Platform Devs portal)

---

### Page Header

#### `Space / Page Header`
Docs: https://infrad.shopee.io/space-biz/space-page-container/

| Dimension | Values | Meaning |
|-----------|--------|---------|
| `Level` | `Basic` | Lightweight header — title + description only, no action button zone, no back arrow |
| | `Standard` | Full Space header — back arrow + breadcrumb + title + tags + description + right-side action buttons |
| | `Advanced` | Complex header (Breadcrumbs always False) — for dashboard-level or full-width pages needing richer layout |
| `Breadcrumbs` | `True` | Shows breadcrumb navigation path (e.g., "Nav Item / Resource ▾") |
| | `False` | No breadcrumb — page title stands alone |
| `Meta Info` | `True` | Includes MetaInfo 4-column grid below the title area |
| | `False` | No MetaInfo section |
| `Tab` | `True` | Tab bar is built into the header component itself |
| | `False` | Tabs are rendered separately in the content area (more flexible) |
| `Alert` | `-` | No alert banner |
| | `1` | One alert banner embedded in the header |
| | `2` | Two stacked alert banners |

**Common combinations:**
- Feature Overview page → `Level=Basic, Breadcrumbs=False, Meta Info=False, Tab=False`
- Resource Detail page → `Level=Standard, Breadcrumbs=True, Meta Info=True, Tab=True`
- Resource list with breadcrumb, no metadata → `Level=Standard, Breadcrumbs=True, Meta Info=False, Tab=True`
- Dashboard header → `Level=Advanced, Breadcrumbs=False, Meta Info=True, Tab=True`

#### `_Space / Page header / MetaInfo`
Docs: https://infrad.uat.shopee.io/space-biz/space-meta-info/

4-column label-value attribute grid shown below the Page Header. Each cell supports: plain text · `Avatar` / `Avatar Group` · `Tag` · `Button` (link or action). Use to show entity ownership, timestamps, region, status, and related resource shortcuts.

#### `_Breadcrumb`
Standalone breadcrumb component, used inside `Space / Page Header`. Last breadcrumb item typically shows a ▾ dropdown for switching between sibling resources.

---

### Data & Tables

#### `Space / Query Filter`
Docs: https://infrad.shopee.io/space-biz/space-table-search-form/

| Dimension | Values | Meaning |
|-----------|--------|---------|
| `Type` | `General Search & Quick Filter` | Search input (full width) + a few inline quick-filter selects. Compact. Best when search is the primary action and filters are secondary |
| | `Standard` | Structured rows of `Label: Field` pairs (Select / Input / DateRange). Best for complex multi-condition filtering. This is the type seen in the page archetype screenshots |
| | `Standard - 4 Columns` | 4 fields per row instead of 3 — more compact for dense filter sets. Only has a Collapsed=True variant (128px tall) |
| `Collapsed` | `True` | Shows only the first row of filters + Reset/Search buttons. "Expand ▾" button reveals more |
| | `False` | All filter rows are visible at once |

**When to use which:**
- Simple list with search-first UX → `General Search & Quick Filter`
- Multi-condition operational data filtering → `Standard` (default choice for Space)
- Many filter fields, space is tight → `Standard - 4 Columns`

#### `_Space / Table / Table Toolbar`
The toolbar that sits at the top of every table, inside `Space / Full Table`.

| Dimension | Values | Meaning |
|-----------|--------|---------|
| `buttons` | `true` | Shows action button group: [Default] [Default] [Primary] [⋮ more] |
| | `false` | No action buttons — read-only or filter-only table |
| `filterType` | `"-"` | No embedded filter — filter is handled by `Space / Query Filter` above the table |
| | `"Light filter"` | Compact inline filter (tabs + search input) embedded directly in the toolbar |
| | `"Query Filter"` | Full query filter embedded inside the toolbar row itself |
| `settings` | `true` | Shows utility controls: [↻ Refresh] [30s ▾] + [Density] [Column Settings] [Fullscreen] |
| | `false` | No utility controls |
| `updateTime` | `true` | Shows "Last Update: [timestamp]" next to the table title |
| | `false` | No timestamp |

**Common configurations:**
- Standard operational table (most common) → `buttons=true, filterType="-", settings=true, updateTime=true`
- Read-only monitoring table → `buttons=false, filterType="-", settings=true, updateTime=true`
- Simple table without utilities → `buttons=true, filterType="-", settings=false, updateTime=false`
- Compact table with inline filter (no separate Query Filter above) → `filterType="Light filter"`

#### `Space / Full Table`
Docs: https://infrad.shopee.io/space-biz/space-pro-table/

Complete table container — wraps: `Table Toolbar` + optional summary stats row + conditional bulk-action bar + data table + `Pagination`. Use this in the vast majority of Space list views. Only use `_Space / Full Table / Table` (inner only) when you need a table without the surrounding toolbar/pagination.

#### `_Space / Full Table / Table`
Inner table only — no toolbar, no stats, no bulk-action, no pagination. Use when embedding a small reference table inside a detail card or modal.

---

### Deletion Flow

#### `Space / Delete`
A pre-built deletion confirmation modal. Use instead of a generic Modal + custom content.

| Dimension | Values | Meaning |
|-----------|--------|---------|
| `Level` | `Standard` | 480px wide — simple confirmation: item name + warning text + Cancel/Delete buttons |
| | `Advanced` | 800px wide — complex confirmation: detailed impact description, cascading effect explanation |
| `Alert` | `None` | Standard warning text only |
| | `Top` | Adds an Alert banner above the main content (e.g., "This action cannot be undone") |
| | `Bottom` | Adds an Alert banner below the main content, above the action buttons |
| `Table` | `No` | No preview — simple confirmation only |
| | `Yes` | Shows a table of items that will be affected or deleted (for bulk / cascading deletes) |

**When to use which:**
- Delete a single resource with no dependencies → `Standard, Alert=None, Table=No`
- Delete with a critical irreversible warning → `Standard, Alert=Top, Table=No`
- Delete where user needs to confirm impacted items → `Standard, Alert=None, Table=Yes`
- Cascading delete with large impact → `Advanced, Alert=Top, Table=Yes`

---

### Diff & Code Visualization

#### `Space / Diff / Code diff`
Side-by-side code diff viewer. Used to show configuration changes before applying, audit trail of what changed between two versions, or deployment preview (before → after state). Width: 954px total (two equal panels).

**Layout:** Left panel = old version · Right panel = new version. Both panels synchronized by line number.

Each row is rendered using `_Diff / Code diff / Code item`, which has these types:

| Row type | Visual style | When to use |
|----------|-------------|-------------|
| `default` | White background, no indicator | Unchanged line — appears identically in both panels |
| `None` | Hatched diagonal stripe pattern | Empty placeholder on one side when the other side has an insert or delete with no line counterpart (keeps panels aligned) |
| `Delete` | Red/pink background + `—` MinusOutlined icon | Line deleted in the new version (left panel only) |
| `Added` | Green background + `+` PlusOutlined icon | Line added in the new version (right panel only) |
| `Before` | Red/pink background, changed tokens highlighted in red | Modified line — shows the old content; inline diff highlights only the changed words/tokens |
| `After` | Green background, changed tokens highlighted in green | Modified line — shows the new content; inline diff highlights only the changed words/tokens |

**Typical usage scenarios in Space:**
- Config change preview before deploying → left = current config, right = new config
- Audit log detail view → show exactly what was changed in a historical operation
- YAML / JSON rule diff → comparing two versions of an operational configuration

**ASCII layout:**
```
┌───────────────────────────────────┬───────────────────────────────────┐
│  Before (old version)             │  After (new version)              │
├───────────────────────────────────┼───────────────────────────────────┤
│ 1 │ Hello World,                  │ 1 │ Hello World,                  │
│ 2 │ Hello World,                  │ 2 │ Hello World,                  │
│ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ 3 + Hello                (Added) │
│ 3 │ Hello World,                  │ 4 │ Hello World,                  │
│ 4 — [Hello] World,    (Before)    │ 5 │ [Hello] World,       (After)  │
│ 5 — [Hello] World,    (Before)    │ 6 │ [Hello] World,       (After)  │
│ 6 — Hello             (Delete)    │ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │
│ 7 │ Hello                         │ 7 │ Hello                         │
└───────────────────────────────────┴───────────────────────────────────┘
▓▓▓ = None (hatched placeholder)   [ ] = inline diff highlight
```

---

### Cards & Containers
- `Card`, `Card/Advanced` — content containers with optional header/footer/border

### Utility
- `_Dropdown Menu` (4 variants)
- `_Cascader`
- `Tag` (2 variants)
- `Modal` (5 variants)

---

## Content Patterns

### Resource Tables
Must include:
- Filter bar with search and filter controls
- Column headers with sort indicators
- Pagination controls
- Row actions (view, edit, delete)
- Bulk action bar (when multiple rows selected)

### Status Tags
Use semantic color tokens consistently:
- Running / Active → `Primary (Infra Blue)/6`
- Stopped / Inactive → `Gray/gray-6`
- Error / Failed → `Dust Red/6`
- Warning → `Sunset Orange/6`
- Success / Healthy → `Polar Green/2`

### Domain Vocabulary
Use these terms in UI copy:
- Resources, Instances, Clusters, Nodes
- Deploy, Configure, Monitor, Scale
- Health Status, Alert Level, Operational State
- Namespace, Region, Availability Zone
