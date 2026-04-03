# [Product Name] Business Configuration

## Product Overview

**[Product Name]** is [brief description of what the product does and who uses it].

**Target users:** [describe the primary user personas]

**Key characteristics:**
- [characteristic 1]
- [characteristic 2]
- [characteristic 3]

---

> **Reading guide — read sections in this order:**
>
> 1. **Design Language** — The principles behind this product's design decisions. Read first. Apply always.
> 2. **Page Archetypes** — Concrete layout blueprints for the most common page types.
> 3. **Biz Components** — Available Figma components and their variants. Use when they fit; compose from IDS primitives (following the design language) when they don't.

---

## [Product] Design Language

> **How to use this section:** These are the principles that make this product feel native. When a Biz Component exists, use it. When it doesn't, compose from IDS primitives — but always apply these principles. A page that follows these principles will feel right, even without a single Biz Component.

---

### 1. [Navigation / Layout Shell]

[Describe the fixed structural shell of this product — how the page is divided into zones, what goes where, what is fixed vs. scrollable.]

[Include an ASCII diagram showing the overall layout structure:]

```
┌────────────────────────────────────────────────┐
│  [Top zone — e.g. Header / Nav bar]            │
├──────────────┬─────────────────────────────────┤
│              │                                 │
│  [Side zone] │  [Main content area]            │
│  (optional)  │                                 │
└──────────────┴─────────────────────────────────┘
```

**Design principle:** [What is the core layout decision this product makes, and why?]

---

### 2. [Page Identity / Navigation]

[Describe how pages communicate their location, purpose, and available actions — the page header / breadcrumb / title pattern.]

**Design principle:** [The underlying reason for how page identity is expressed.]

---

### 3. [Primary Data / Content Pattern]

[Describe the most common content pattern in this product — e.g., data tables, card grids, conversation threads, dashboards. What does a typical "content page" look like?]

**Design principle:** [Why this pattern exists for this product's users.]

---

### 4. [Interaction / Workflow Pattern]

[Describe the key interaction pattern — e.g., how the user creates/edits things, how destructive actions work, how configuration flows are presented.]

**Design principle:** [The reason behind this product's interaction conventions.]

---

### 5. [Trust / State / Feedback Signals]

[Describe how this product communicates state, loading, errors, success, and data freshness to the user.]

**Design principle:** [What does trust mean for this product's users, and how does the design support it?]

---

## Page Archetypes

[List the canonical page types in this product. For each archetype, provide:
1. When it's used (the user's goal / entry point)
2. An ASCII layout diagram using box-drawing characters showing key zones
3. A zone-to-component table explaining what belongs where

This section is the most important input for AI layout decisions — the more accurate and complete, the better the generated designs.]

Use box-drawing characters for ASCII diagrams:
`┌ ┐ └ ┘ ─ │ ├ ┤ ┬ ┴ ┼` (horizontal/vertical lines, corners, and junctions)

---

### Archetype 1: [Name]

**When used:** [The user's goal or entry point that leads to this page type]

```
┌──────────────────────────────────────────────────────────────┐
│  [Zone 1 description]                                        │
├──────────────────────────────────────────────────────────────┤
│  [Zone 2 description]                                        │
├──────────────────────────────────────────────────────────────┤
│  [Zone 3 description]                                        │
└──────────────────────────────────────────────────────────────┘
```

| Zone | Biz Component | Notes |
|------|--------------|-------|
| [Zone 1] | [Component or "IDS primitives"] | [Usage notes] |
| [Zone 2] | [Component or "IDS primitives"] | [Usage notes] |

---

### Archetype 2: [Name]

**When used:** [The user's goal or entry point]

```
[ASCII diagram]
```

| Zone | Biz Component | Notes |
|------|--------------|-------|
| [Zone] | [Component] | [Notes] |

---

### [Archetype N: add more as needed]

---

## Available [Product] Biz Components

> These components implement the Design Language principles above. **Use when they fit.** When no Biz Component covers the scenario, compose from IDS primitives following the design language — the result should feel equally native.

**Note:** [Any exceptions to the underscore-prefix rule, or other access notes.]

### [Category 1 — e.g. Navigation]

#### `[Component Name]`
[One-line description of what it does and when to use it.]

| Dimension | Values | Meaning |
|-----------|--------|---------|
| `[Dimension]` | `[Value]` | [What this value means visually / functionally] |
| | `[Value]` | [Alternative value] |

**When to use which:**
- [Scenario] → `[Variant combination]`
- [Scenario] → `[Variant combination]`

---

### [Category 2 — e.g. Content / Data]

#### `[Component Name]`
[Description + docs link if available]

[Dimension table if applicable]

---

### [Category N: add more as needed]

---

## Content Patterns

### [Pattern 1]
[Describe a recurring UI pattern specific to this product — e.g., "Bulk action bar appears conditionally when rows are selected", "Empty states always include a primary CTA"]

### [Pattern 2]
[Another pattern]

### Domain Vocabulary
Use these terms in UI copy:
- [term 1], [term 2], [term 3]
- [term 4], [term 5], [term 6]
