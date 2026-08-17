# Duofy Reusable Lesson Format: CSS3 Box Model, Layouts (Flexbox & Grid), and Specificity

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Web_Technologies / HTML5_CSS3_JavaScript_ES6`  
**Lesson Format Type:** `css3_box_model_flexbox_grid_and_specificity_hierarchy`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through CSS layout geometry, box sizing mechanics, multi-dimensional alignment, and cascade precedence mathematics (Eric A. Meyer & Estelle Weyl *CSS: The Definitive Guide* 4th ed.; Rachel Andrew *The New CSS Layout*; W3C CSS Cascading and Inheritance Level 4): master the **Standard vs Alternative Box Model** ($\mathbf{\text{content-box}}$ vs $\mathbf{\text{border-box}}$: $\mathbf{\text{Total Width} = \text{width} + \text{padding} + \text{border}}$ vs $\mathbf{\text{Total Width} = \text{width}}$), master the **CSS Specificity Vector $(a, b, c, d)$** (**$a$:** Inline styles, **$b$:** ID selectors `#id`, **$c$:** Classes `.class`, attributes `[type]`, pseudo-classes `:hover`, **$d$:** Type elements `div`, pseudo-elements `::before`), master **Flexbox 1D Layouts** (main axis vs cross axis, `justify-content`, `align-items`, `flex-grow`, `flex-shrink`, `flex-basis`), and master **CSS Grid 2D Layouts** (`grid-template-columns: repeat(auto-fit, minmax(250px, 1fr))`, `grid-area`, implicit vs explicit grid).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Box Model Formulas (`content-box` vs `border-box`), Specificity $(a,b,c,d)$ Vector Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Calculation of CSS Specificity to Resolve Conflicting Rules Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | CSS Layout / Specificity Construct & Exact Technical Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The CSS Property That Includes Padding and Border Inside an Element's Defined Width Is box-sizing: ___-box (border) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Contrast: When to Choose 1D Flexbox vs 2D CSS Grid for Responsive Design Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CSS Box Model & Specificity (Meyer & Weyl 2017):
   - **The Box Sizing Invariant:**
     $$\begin{array}{|l|l|}
     \hline
     \textbf{Box Model Mode} & \textbf{Rendered Element Width Formula} \\
     \hline
     \mathbf{\texttt{box-sizing: content-box}} & \text{Rendered Width} = \mathbf{\text{width} + \text{padding\_left} + \text{padding\_right} + \text{border\_left} + \text{border\_right}} \\
     \mathbf{\texttt{box-sizing: border-box}} & \mathbf{\text{Rendered Width} = \text{width } (\text{Padding \& border are absorbed INSIDE!})} \\
     \hline
     \end{array}$$
   - **Specificity Vector $(a, b, c, d)$:**
     $$\mathbf{\text{Inline } (a) > \text{IDs } (b) > \text{Classes/Pseudo-classes } (c) > \text{Elements } (d)}$$
     - *Example:* `#nav ul.menu li:hover a` $\implies (0, 1, 2, 3)$.
     - `!important` overrides normal specificity vectors.
2. **Slide 2 (`ordering`):** Provide 5 steps of resolving CSS selector conflicts on `<button id="submit-btn" class="btn primary">`: (1) Selector 1: `button` $\implies (0,0,0,1)$ applies `color: black`, (2) Selector 2: `.btn.primary` $\implies (0,0,2,0)$ overrides `button` with `color: blue`, (3) Selector 3: `#submit-btn` $\implies (0,1,0,0)$ overrides `.btn.primary` with `color: green`, (4) Selector 4: `button#submit-btn.btn` $\implies (0,1,1,1)$ beats `#submit-btn` with `color: purple`, (5) final computed style applies `color: purple` as the highest specificity vector!
3. **Slide 3 (`matching`):** Pair 4 concepts (`border-box`, Specificity Vector, Flexbox Main Axis, CSS Grid `minmax()`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of `border-box`. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Flexbox vs Grid selection: In modern web development, what is the definitive architectural distinction between CSS Flexbox and CSS Grid, and when should you choose one over the other? (CSS Flexbox is fundamentally **one-dimensional (1D)**, designed for laying out items along a single axis (either row or column) with dynamic content-driven sizing (ideal for navigation bars, button toolbars, and aligned list items); CSS Grid is fundamentally **two-dimensional (2D)**, designed for simultaneously aligning elements across intersecting rows AND columns with strict coordinate placement (ideal for full-page application layouts, dashboard card grids with `repeat(auto-fit, minmax(300px, 1fr))`, and complex magazine layouts)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "css3_box_model_flexbox_grid_and_specificity_hierarchy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CSS Box Model, Specificity \\& Layouts (Eric Meyer)**\n• **Box Model Geometry Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Box Sizing Mode} & \\textbf{Rendered Width Computation} & \\textbf{Layout Stability} \\\\\n\\hline\n\\mathbf{\\texttt{content-box}} & \\text{Width} = \\mathbf{\\text{width} + \\text{padding} + \\text{border}} & \\text{Adding padding breaks container grid!} \\\\\n\\mathbf{\\texttt{border-box}} & \\mathbf{\\text{Width} = \\text{width (Padding absorbed inside)}} & \\mathbf{\\text{Rock-solid 100% predictable responsive sizing!}} \\\\\n\\hline\n\\end{array}\n$$\n• **The 4-Component Specificity Vector $\\mathbf{(a, b, c, d)}$:**\n$$\n\\mathbf{\\text{Inline Styles } (a=1000) > \\text{IDs } (b=0100) > \\text{Classes/Pseudo-classes } (c=0010) > \\text{Elements } (d=0001)}\n$$\n• **Layout Scope:** **Flexbox = 1-Dimensional (Row OR Column)** $\\longleftrightarrow$ **CSS Grid = 2-Dimensional (Rows AND Columns)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential evaluation of competing CSS rules on <button id='pay-btn' class='btn primary'> from lowest to highest specificity.",
      "orderItems": [
        "Rule 1: 'button { color: black; }' evaluates to Specificity Vector (0, 0, 0, 1) -> Score: 1",
        "Rule 2: '.btn.primary { color: blue; }' evaluates to Specificity Vector (0, 0, 2, 0) -> Score: 20",
        "Rule 3: '#pay-btn { color: green; }' evaluates to Specificity Vector (0, 1, 0, 0) -> Score: 100",
        "Rule 4: 'button#pay-btn.primary { color: purple; }' evaluates to Specificity Vector (0, 1, 1, 1) -> Score: 111",
        "The browser applies the highest winning specificity vector (0, 1, 1, 1), rendering the button in purple text"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CSS Architecture Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "box-sizing: border-box", "right": "Forces padding and border to be calculated inside the declared width and height" },
        { "left": "CSS Specificity Vector", "right": "Weight system (Inline, ID, Class, Element) determining which conflicting style rule takes precedence" },
        { "left": "Flexbox (1D Layout)", "right": "Distributes space and aligns items along a single main axis or cross axis dynamically" },
        { "left": "CSS Grid (2D Layout)", "right": "Defines simultaneous row and column track structures for complex two-dimensional templates" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The CSS box-sizing value that absorbs padding and border into the element's width is ___-box.",
      "blankAnswer": "border",
      "blankDistractors": ["content", "margin", "padding"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In professional frontend responsive design, what is the fundamental architectural difference between CSS Flexbox and CSS Grid, and how should an engineer select between them?",
      "options": [
        { "text": "CSS Flexbox is inherently one-dimensional (1D), designed for arranging and distributing content along a single axis (either row OR column) where item dimensions are dynamically driven by content size (ideal for navigation bars, button rows, form controls, and centered elements); CSS Grid is inherently two-dimensional (2D), designed for orchestrating layout across intersecting rows AND columns simultaneously with rigid coordinate alignment (ideal for macro page layouts, complex dashboards, photo galleries, and responsive card grids using repeat(auto-fit, minmax(280px, 1fr)))", "isCorrect": true, "explanation": "Correct! This is Rachel Andrew and Eric Meyer's definitive layout selection guideline (*The New CSS Layout*; *CSS: The Definitive Guide*). 1. **Flexbox (1-Dimensional, Content-First):** - Operates on a single axis (Main Axis vs Cross Axis). - Think of it as: *\"I have a collection of items, and I want them to line up nicely and wrap if needed.\"* - Perfect for: Navbar menus, button groups, modal footers, vertical media objects. 2. **CSS Grid (2-Dimensional, Container-First):** - Operates on rows AND columns at the exact same time. - Think of it as: *\"I have a 2D page area, and I want to slice it into a master grid of tracks where elements occupy specific rows and columns.\"* - Perfect for: Page layouts (Header, Sidebar, Main, Footer via `grid-template-areas`), responsive product grids with zero media queries (`grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));`). 3. **The Best Practice:** Use **CSS Grid for outer page layout structures** and **Flexbox for inner component UI alignments**!" },
        { "text": "Because Flexbox only works in mobile browsers while CSS Grid only works on laptops", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CSS Grid was deprecated in HTML5", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Flexbox cannot display text elements", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
