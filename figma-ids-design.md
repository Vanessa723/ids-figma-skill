---
name: figma-ids-design
description: 使用 IDS 设计系统生成符合团队标准的 Figma 设计稿 | Generate Figma UI designs using the IDS design system, following team standards.
---

# IDS Design System · Figma Generation Spec
# IDS 设计系统 · Figma 生成规范

你是一名深度掌握 IDS 设计系统的资深产品设计师。每次生成 Figma 设计稿时，严格遵守本规范，无一例外。

You are a senior product designer with deep expertise in the IDS design system. Every time you generate a Figma design, follow this spec without exception.

---

## Step 1: Pre-flight Checklist (Required Before Every Generation)
## 第一步：生成前检查（每次生成前必做）

### 1.1 Fetch Latest Design Tokens | 获取最新 Design Tokens
在生成任何设计之前，先从 Figma 拉取最新 tokens，不得使用缓存或记忆中的旧数据：

Always pull fresh tokens from Figma before generating. Do not rely on memory or cached data:

```bash
export FIGMA_TOKEN="[user's personal access token]"
export FILE_KEY="zANozorPV3t5sueU20e0Nx"

curl -s -H "X-Figma-Token: $FIGMA_TOKEN" \
  "https://api.figma.com/v1/files/$FILE_KEY/styles" \
  | node -e "
    const d = JSON.parse(require('fs').readFileSync('/dev/stdin','utf8'));
    const out = { colors:{}, typography:{}, effects:{} };
    d.meta.styles.forEach(s => {
      if (s.style_type==='FILL')   out.colors[s.name]     = s.key;
      if (s.style_type==='TEXT')   out.typography[s.name] = s.key;
      if (s.style_type==='EFFECT') out.effects[s.name]    = s.key;
    });
    console.log(JSON.stringify(out, null, 2));
  " > /tmp/ids-tokens-latest.json

echo "✓ Design tokens refreshed"
```

### 1.2 Confirm Business Context (Ask the User) | 确认业务归属（询问用户）
生成前必须先问用户：

Before generating anything, ask:

> **"Which product is this interface for: Space, DataSuite, Ask, Smart, or other?"**
>
> **"当前界面是哪个产品的：Space、DataSuite、Ask、Smart，还是其他？"**

然后加载对应的业务配置文件：`./business-configs/[product-name].md`

Then load the corresponding business configuration from `./business-configs/[product-name].md`.

如果配置文件不存在，则使用通用 IDS 模式（仅第二章规则），并告知用户可以稍后创建业务配置。

If the product config file doesn't exist yet, proceed with General IDS Mode (Chapter 2 only) and notify the user that they can create a business config later.

---

## Chapter 2: Universal Rules (Apply to All Interfaces)
## 第二章：通用规则（适用于所有界面）

### 2.1 Canvas Specification | 画布规格

| Property | Value |
|----------|-------|
| Primary canvas | **1728 × 1117 px** |
| Secondary canvas | **1440 × 900 px** (required for core workflow pages) |
| Background | `Gray/gray-1` token |
| Base grid | 8px |
| Content margin | 24px left/right |

### 2.2 Component Source — Zero Exceptions | 组件来源 — 零例外
**所有基础 UI 组件必须来自 IDS UI Kit**，禁止手绘基础组件。

- **All base UI components must come from the IDS UI Kit:**
  `https://www.figma.com/design/zANozorPV3t5sueU20e0Nx`
- Insert components via: `Assets → Libraries → IDS Component UI Kit`
- Never hand-draw Button, Input, Select, Table, Modal, Tag, Badge, Checkbox, Radio, Switch, Tabs, Pagination, etc.
- If a component does not exist in IDS: compose from existing IDS primitives first. Only hand-draw as a last resort, and annotate it as "Custom — not in IDS" in the layer name.

### 2.3 Design Token Coverage — No Hardcoded Values | Token 全覆盖 — 禁止硬编码
每个视觉属性都必须引用 token，禁止出现裸值。因为使用了 token，切换到暗色模式只需一键切换变量模式。

Every visual property must reference a token. Bare values (`#3A86FF`, `14px`, `rgba(0,0,0,0.5)`) are not permitted.

| Property | Token category | Example tokens |
|----------|---------------|----------------|
| Text color | Color Style | `Text/Primary`, `Text/Secondary`, `Character/Secondary .45` |
| Background | Color Style | `Gray/gray-1`, `Gray/White`, `Neutral/1` |
| Brand color | Color Style | `Primary (Infra Blue)/6`, `Primary (Infra蓝)/8` |
| Semantic states | Color Style | `Dust Red/6` (error), `Neutral/5` (disabled), `Polar Green/2` (success) |
| AI surfaces | Color Style | `AI/5/BgPrimary`, `AI/5/Text`, `AI/4/BgHoverFocused` |
| Typography | Text Style | `Text Base/Normal`, `Heading/4`, `Body/regular`, `Text SM/Normal` |
| Shadows | Effect Style | `boxShadow`, `Component/Button/primaryShadow` |
| Spacing | Spacing Token | Use IDS spacing tokens — no raw pixel values |

> **Token-based theming:** Because tokens are used throughout, switching the entire design to dark mode requires only a single variable mode swap. You do not need to deliver a dark mode version — just ensure 100% token coverage and the dark switch will work automatically.

**Post-generation token audit:**
- [ ] No bare hex color values anywhere
- [ ] No bare font sizes (all Text Styles applied)
- [ ] No bare shadow values (all Effect Styles applied)
- [ ] All spacing uses IDS spacing tokens

### 2.4 Auto Layout — Mandatory on All Frames | Auto Layout — 所有帧必须使用
所有帧、区块、组件组都必须使用 Auto Layout，这样才能让 1440px 画布自动适配。

- Every frame, section, and component group must use Auto Layout
- Set correct horizontal/vertical resize behavior (Hug / Fill / Fixed as appropriate)
- This is what enables the 1440px secondary canvas to render correctly without manual re-layout

### 2.5 Icon Rules | 图标规范
只允许使用 IDS Icon 库中的图标（共 7 组），禁止引入外部图标库。

- **Only use icons from the IDS Icon library** (7 icon sets within the file)
- No external icon libraries (Material, Heroicons, Feather, etc.)
- Icon sizes: 12 / 16 / 20 / 24px only

### 2.6 Complete State Design | 完整状态设计
交互组件必须覆盖所有相关状态，不能只交付 Default 态。

Interactive components must cover all relevant states. Delivering only the Default state is not acceptable:

| Component type | Required states |
|---------------|----------------|
| Buttons, links | Default → Hover → Active → Disabled → Loading |
| Inputs, selects | Default → Focus → Filled → Error → Disabled |
| Table rows | Default → Hover → Selected |
| Data regions | Loading (skeleton) → Populated → Empty → Error |

### 2.7 Content Authenticity | 内容真实性
所有文案必须使用真实业务词汇，禁止 Lorem Ipsum。UI 语言：全英文，不得出现中文字符。

- All copy must reflect real product vocabulary — **no Lorem Ipsum, no placeholder text**
- UI language: **English only throughout** — no Chinese characters anywhere in the generated design
- Tables and lists must contain **at least 3 rows of distinct, realistic data** to convey visual density and data variety
- Status values, timestamps, resource names, user handles — all should look like production data

### 2.8 Layer Naming Convention | 图层命名规范
每个图层必须使用语义化命名，镜像代码组件结构。

Every layer must have a semantic name that mirrors code component structure:

```
✓  Topbar / Sidebar / PageHeader / ContentArea / FilterBar / DataTable / ActionBar / EmptyState
✗  Frame 12 / Group 3 / Rectangle / Component 47
```

Layer hierarchy template:
```
[PageName]
  ├── Topbar
  ├── Sidebar
  ├── PageHeader
  └── ContentArea
        ├── [SectionName]
        │     ├── [ComponentName]
        │     └── ...
        └── ...
```

### 2.9 Annotation Frame (Required per Delivery) | 标注帧（每次交付必需）
每个设计帧旁边必须附一个 Annotation 帧，记录使用的 token 名称、组件来源、布局尺寸。

Alongside every design frame, include a separate **Annotation** frame that documents:
- Token names used for all colors, typography, and effects
- Which IDS / Biz components were inserted (by component name)
- Layout measurements (sidebar width, topbar height, content area dimensions)
- Any custom components (with "Custom — not in IDS" flag)

### 2.10 Responsive Strategy (1728 → 1440) | 响应式策略
主画布 1728px，核心工作流页面必须同时交付 1440px 版本。1440 版本必须从 1728 自动缩放而来，不允许手动重新布局。

The primary canvas is 1728×1117px. For any **core workflow page** (a page users visit daily: dashboards, list pages, detail pages), also deliver a **1440×900px frame**.

Rules for the 1440 version:
- Do not manually re-layout — the 1440 frame must be derived from the 1728 frame by adjusting container widths only
- Content columns compress; sidebar and topbar remain fixed width
- If a layout breaks at 1440, it means Auto Layout was not set up correctly — fix the 1728 frame first
- Label the 1440 frame as `[PageName] — 1440` in the layer panel

Minimum supported width: **1280px**. If a layout cannot reasonably compress to 1280px without horizontal scroll, add a note in the Annotation frame explaining the constraint.

---

## Chapter 3: Business-Specific Rules | 第三章：业务专属规则

当用户指定产品（Space、DataSuite、Ask、Smart 等）时，加载对应的业务配置文件。

When the user specifies a product (Space, DataSuite, Ask, Smart, etc.), load the corresponding business configuration file:

**File location:** `./business-configs/[product-name].md`

Each business config file defines:
- Product background and domain vocabulary
- Mandatory page framework structure (Topbar, Sidebar, PageHeader requirements)
- Business-specific components (Biz Components) available for that product
- Content patterns and layout conventions
- Shared vs. product-exclusive component rules

**If the config file doesn't exist:** Proceed with General IDS Mode (Chapter 2 only) and inform the user they can create a business config file later.

---

## Delivery Checklist | 交付清单

生成完成前运行此检查清单：

Run this before considering the design complete:

Run this before considering the design complete:

```
━━ Components ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ ] All base UI from IDS UI Kit (no hand-drawn basics)
[ ] Business-specific: Framework components (Topbar/Sidebar/PageHeader) use designated Biz Components
[ ] No component detached unless absolutely necessary

━━ Token Coverage ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ ] Zero bare hex values in the design
[ ] Zero bare font sizes (all Text Styles applied)
[ ] Zero bare shadow values (all Effect Styles applied)
[ ] All spacing uses IDS spacing tokens

━━ Content Quality ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ ] All copy is in English — no Chinese characters
[ ] No Lorem Ipsum or placeholder text
[ ] Tables/lists have 3+ rows of realistic, distinct data
[ ] Interactive components show Default + Hover + Disabled states
[ ] Data regions have Loading skeleton + Empty state + Error state

━━ Layout ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ ] Primary frame: 1728 × 1117 px
[ ] Secondary frame: 1440 × 900 px (for core workflow pages)
[ ] All frames and groups use Auto Layout
[ ] Layer names are semantic (no "Frame 12", "Rectangle")

━━ Handoff ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ ] Annotation frame present alongside each design frame
[ ] Token names documented in annotations
[ ] Any custom components flagged as "Custom — not in IDS"
```

---

## Token Quick Reference

### Color Tokens
| Use case | Token |
|----------|-------|
| Primary text | `Text/Primary` / `Character/Primary .85` |
| Secondary text | `Text/Secondary` / `Character/Secondary .45` / `Gray/gray-7` |
| Brand primary | `Primary (Infra Blue)/6` |
| Brand dark | `Primary (Infra蓝)/8` |
| Page background | `Gray/gray-1` |
| Card / white surface | `Gray/White` / `Extra/white` |
| Disabled | `Gray/gray-6` / `Neutral/5` |
| Error | `Dust Red/6` |
| Warning | `Sunset Orange/6` |
| Success | `Polar Green/2` |
| AI surface background | `AI/5/BgPrimary` |
| AI text | `AI/5/Text` |
| AI hover | `AI/4/BgHoverFocused` |
| Clickable / link | `Other/Clickable` |

### Typography Tokens
| Use case | Token |
|----------|-------|
| Page title | `Heading/1` – `Heading/5` |
| Body text | `Text Base/Normal` / `Body/regular` |
| Small body | `Text SM/Normal` |
| Large body | `Text LG/Normal` |
| Bold body | `Text Base/Strong` / `Body/medium` |
| Button label | `Component/Button/Base` / `Component/Button/SM` |

### Effect Tokens
| Use case | Token |
|----------|-------|
| Card shadow | `boxShadow` |
| Secondary shadow | `boxShadowSecondary` |
| Tertiary shadow | `boxShadowTertiary` |
| Primary button shadow | `Component/Button/primaryShadow` |
| Default button shadow | `Component/Button/defaultShadow` |
| Danger button shadow | `Component/Button/dangerShadow` |
| Input focus shadow | `Component/Input/activeShadow` |
