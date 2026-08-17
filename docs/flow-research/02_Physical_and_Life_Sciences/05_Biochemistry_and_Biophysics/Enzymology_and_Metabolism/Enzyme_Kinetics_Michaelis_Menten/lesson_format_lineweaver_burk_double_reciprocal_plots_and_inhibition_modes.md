# Duofy Reusable Lesson Format: Lineweaver-Burk Double-Reciprocal Plots and Inhibition Modes

**Target Topic:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Enzymology_and_Metabolism / Enzyme_Kinetics_Michaelis_Menten`  
**Lesson Format Type:** `lineweaver_burk_double_reciprocal_plots_and_inhibition_modes`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algebraic transformations, intercept geometries, and mathematical models of reversible enzyme inhibition (Hans Lineweaver & Dean Burk 1934): derive the **Lineweaver-Burk Double-Reciprocal Equation ($\frac{1}{v_0} = \frac{K_m}{V_{\max}}\frac{1}{[S]} + \frac{1}{V_{\max}}$)** with **y-intercept $\frac{1}{V_{\max}}$**, **x-intercept $-\frac{1}{K_m}$**, and **slope $\frac{K_m}{V_{\max}}$**, contrast the 4 classic modes of reversible inhibition (**Competitive:** binds $E$ active site, lines intersect on y-axis, $K_m^{\text{app}} = \alpha K_m$, $V_{\max}$ unchanged; **Pure Non-Competitive:** binds allosteric site on $E$ and $ES$ equally, lines intersect on x-axis, $V_{\max}^{\text{app}} = V_{\max}/\alpha$, $K_m$ unchanged; **Uncompetitive:** binds $ES$ complex exclusively, produces **strictly parallel lines**, both $V_{\max}$ and $K_m$ decreased by $\alpha'$; and **Mixed Inhibition**), and evaluate clinical drug paradigms (Statins, Methotrexate, Non-nucleoside reverse transcriptase inhibitors).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lineweaver-Burk Linearization & Reversible Inhibition Modes Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Derivation and Plotting of Double-Reciprocal Kinetics Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Reversible Inhibition Mode & Lineweaver-Burk Diagnostic Geometry Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Lineweaver-Burk Double-Reciprocal X-Intercept Algebraic Form Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Uncompetitive Enzyme Inhibition Parallel Lineweaver-Burk Lines Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Lineweaver-Burk Double-Reciprocal Linearization & Inhibition Modes:
   - **The Lineweaver-Burk Equation:**
     $$\mathbf{\frac{1}{v_0} = \left(\frac{K_m}{V_{\max}}\right)\frac{1}{[S]} + \frac{1}{V_{\max}} \qquad (y = mx + b)}$$
     - **y-intercept ($x = 0$):** $\frac{1}{V_{\max}}$
     - **x-intercept ($y = 0$):** $-\frac{1}{K_m}$
     - **Slope ($m$):** $\frac{K_m}{V_{\max}}$
   - **The 3 Classic Reversible Inhibition Paradigms:**
     $$\begin{array}{|l|l|c|c|l|}
     \hline
     \textbf{Inhibition Type} & \textbf{Binding Target} & \mathbf{V_{\max}^{\text{app}}} & \mathbf{K_m^{\text{app}}} & \textbf{Lineweaver-Burk Appearance} \\
     \hline
     \textbf{Competitive} & \text{Free enzyme } \mathbf{E} \text{ only} & \mathbf{V_{\max}} \text{ (Unchanged)} & \mathbf{\alpha K_m} \text{ (Increased)} & \text{Intersect at } \mathbf{\text{y-axis } (1/V_{\max})} \\
     \textbf{Non-Competitive} & \mathbf{E} \text{ and } \mathbf{ES} \text{ equally} & \mathbf{V_{\max}/\alpha} \text{ (Decreased)} & \mathbf{K_m} \text{ (Unchanged)} & \text{Intersect at } \mathbf{\text{x-axis } (-1/K_m)} \\
     \textbf{Uncompetitive} & \mathbf{ES} \text{ complex ONLY} & \mathbf{V_{\max}/\alpha'} \text{ (Decreased)} & \mathbf{K_m/\alpha'} \text{ (Decreased)} & \mathbf{\text{Parallel lines (Identical slope)}} \\
     \hline
     \end{array}$$
   - **Inhibition Constants:** $\alpha = 1 + \frac{[I]}{K_I}$ and $\alpha' = 1 + \frac{[I]}{K_I'}$.
2. **Slide 2 (`ordering`):** Provide 5 steps to construct and analyze a Lineweaver-Burk plot: (1) measure initial reaction velocities ($v_0$) across a series of substrate concentrations ($[S]$), (2) calculate the mathematical reciprocals $1/v_0$ and $1/[S]$ for each experimental data point, (3) plot $1/v_0$ on the vertical y-axis against $1/[S]$ on the horizontal x-axis, (4) fit a linear regression line through the points and extrapolate back across the negative x-axis, (5) calculate $V_{\max}$ from the reciprocal of the y-intercept ($1/y_0$) and calculate $K_m$ from the negative reciprocal of the x-intercept ($-1/x_0$)!
3. **Slide 3 (`matching`):** Pair 4 inhibition modes (Competitive, Pure Non-Competitive, Uncompetitive, Mixed) with their defining Lineweaver-Burk graphical intersections.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the x-intercept of a standard Lineweaver-Burk plot represents the value of -1/k_m. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the molecular biophysics of uncompetitive enzyme inhibition: Why does an uncompetitive enzyme inhibitor decrease both apparent $V_{\max}$ and apparent $K_m$ by the exact same mathematical factor ($\alpha'$), resulting in a series of perfectly parallel lines on a Lineweaver-Burk double-reciprocal plot? (Because the inhibitor **binds exclusively to the enzyme-substrate ($ES$) complex**; binding pulls the $E + S \rightleftharpoons ES$ equilibrium to the right via Le Chatelier's principle, artificially **increasing apparent substrate affinity (decreasing apparent $K_m$)**, while permanently inactivating the $ESI$ complex to **decrease apparent $V_{\max}$** in equal proportion).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lineweaver_burk_double_reciprocal_plots_and_inhibition_modes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Lineweaver-Burk Linearization & Reversible Inhibition (1934)**\n• **The Double-Reciprocal Equation ($y = mx + b$):**\n$$\n\\mathbf{\\frac{1}{v_0} = \\left(\\frac{K_m}{V_{\\max}}\\right)\\frac{1}{[S]} + \\frac{1}{V_{\\max}}}\n$$\n  - **y-intercept:** $\\frac{1}{V_{\\max}}$ | **x-intercept:** $-\\frac{1}{K_m}$ | **Slope:** $\\frac{K_m}{V_{\\max}}$.\n• **Reversible Inhibition Diagnostics:**\n$$\n\\begin{array}{|l|c|c|l|}\n\\hline\n\\textbf{Inhibition Mode} & \\mathbf{V_{\\max}^{\\text{app}}} & \\mathbf{K_m^{\\text{app}}} & \\textbf{Lineweaver-Burk Geometry} \\\\\n\\hline\n\\textbf{Competitive (binds E)} & \\mathbf{V_{\\max}} & \\mathbf{\\alpha K_m \\uparrow} & \\text{Intersect at } \\mathbf{\\text{y-axis } (1/V_{\\max})} \\\\\n\\textbf{Non-Competitive (binds E \& ES)} & \\mathbf{V_{\\max}/\\alpha \\downarrow} & \\mathbf{K_m} & \\text{Intersect at } \\mathbf{\\text{x-axis } (-1/K_m)} \\\\\n\\textbf{Uncompetitive (binds ES only)} & \\mathbf{V_{\\max}/\\alpha' \\downarrow} & \\mathbf{K_m/\\alpha' \\downarrow} & \\mathbf{\\text{PARALLEL LINES (Same slope!)}} \\\\\n\\hline\n\\end{array}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct and extract kinetic constants from a Lineweaver-Burk plot.",
      "orderItems": [
        "Measure initial reaction velocities (v0) across varying substrate concentrations [S] with and without inhibitor",
        "Take the mathematical reciprocals 1/v0 and 1/[S] for every measured experimental data point",
        "Plot 1/v0 on the vertical y-axis against 1/[S] on the horizontal x-axis",
        "Fit a linear regression line through the points and extrapolate the line across the negative x-axis",
        "Extract Vmax as the inverse of the y-intercept (1/Vmax) and Km as the negative inverse of the x-intercept (-1/Km)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each reversible enzyme inhibition mode to its defining Lineweaver-Burk graphical feature.",
      "matchPairs": [
        { "left": "Competitive Inhibition", "right": "Lines pivot around a common y-intercept (1/Vmax) with steeper slopes and decreased -1/Km" },
        { "left": "Pure Non-Competitive Inhibition", "right": "Lines pivot around a common x-intercept (-1/Km) with higher y-intercepts reflecting decreased Vmax" },
        { "left": "Uncompetitive Inhibition", "right": "A family of perfectly parallel lines with equal slopes (Km/Vmax) shifted upward and to the left" },
        { "left": "Mixed Inhibition", "right": "Lines intersect in the upper-left quadrant to the left of the vertical y-axis" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "On a double-reciprocal Lineweaver-Burk plot, the horizontal x-axis intercept is equal to -1 / ___.",
      "blankAnswer": "k_m",
      "blankDistractors": ["v_max", "k_cat", "k_i"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In an enzymology experiment, adding increasing concentrations of an experimental drug produces a family of perfectly parallel lines on a Lineweaver-Burk double-reciprocal plot. What is the molecular mechanism of this inhibitor?",
      "options": [
        { "text": "UNCOMPETITIVE INHIBITION; the drug binds exclusively to the enzyme-substrate (ES) complex (not free enzyme), pulling the binding equilibrium toward ES to artificially increase apparent affinity (decreasing Km) while inactivating the complex to decrease Vmax by the exact same ratio, keeping the slope (Km/Vmax) constant", "isCorrect": true, "explanation": "Correct! Uncompetitive inhibitors cannot bind to the free enzyme (E); they bind exclusively to an allosteric pocket that is created only after the substrate has bound to form the ES complex. By binding the ES complex and sequestering it as an inactive ESI complex, the inhibitor pulls the E + S <=> ES equilibrium to the right via Le Chatelier's principle. This makes it appear as though the enzyme binds substrate more tightly, reducing apparent Km by a factor of alpha' (Km/alpha'). Simultaneously, because the ESI complex cannot turn over into product, the maximum catalytic capacity Vmax is also reduced by the exact same factor (Vmax/alpha'). Because the slope of a Lineweaver-Burk line is (Km/Vmax) = (Km/alpha') / (Vmax/alpha'), the alpha' factors cancel out, producing lines with identical slopes that are perfectly parallel." },
        { "text": "Competitive inhibition binding directly in the substrate active site", "isCorrect": false, "explanation": "Incorrect: Competitive inhibition changes slope and intersects on the y-axis." },
        { "text": "Irreversible suicide covalent inhibition destroying all protein", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Non-competitive inhibition intersecting on the x-axis", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
