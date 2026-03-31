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

## Mandatory Page Framework

All Space pages must use this exact layout structure:

```
┌──────────────────────────────────────────────────────────────┐
│                        Topbar                                 │  Fixed height: 48px
├─────────────┬────────────────────────────────────────────────┤
│             │              Page Header                        │  Height: content-driven
│   Sidebar   ├────────────────────────────────────────────────┤
│             │                                                 │
│  (Biz       │            Content Area                         │
│  Component) │         (free composition                       │
│             │          using IDS base components)             │
│             │                                                 │
└─────────────┴────────────────────────────────────────────────┘
```

| Zone | Component name | Source | Sharing rule |
|------|---------------|--------|--------------|
| Top navigation | **Topbar** | Space Biz Components | Space-exclusive |
| Side navigation | **Sidebar** | Space Biz Components | Space-exclusive |
| Page header | **Page Header** | Space Biz Components | Space-exclusive |
| Content area | Composed from IDS base components | IDS UI Kit | Shared across all products |

---

## Available Space Biz Components

### Navigation
- `Topbar` — variants: `Brand=Default`, `Brand=Smart`
- `Sidebar` — Active/Inactive state variants

### Page Header
- `Page Header` — includes breadcrumb, title, description, action area
- `_Breadcrumb`

### Cards & Containers
- `Card`, `Card/Advanced`, `Card 2`
- `SOPConfigCard`, `SOPConfigContainer`, `SOPCheckableCard`
- `Workbench`

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
