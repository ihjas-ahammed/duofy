# Duofy Reusable Lesson Format: Enzyme Kinetics and Michaelis-Menten Inhibition

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Chemical_Kinetics_and_Reaction_Dynamics`  
**Lesson Format Type:** `enzyme_kinetics_and_michaelis_menten_inhibition`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical kinetics and catalytic mechanisms of biological enzymes: derive the **Michaelis-Menten Equation ($v_0 = \frac{V_{\text{max}}[S]}{K_M + [S] = \frac{k_{\text{cat}}[E]_0[S]}{K_M + [S]}}$)** using the Briggs-Haldane steady-state approximation for $[ES]$, linearize data via the **Lineweaver-Burk Double-Reciprocal Plot ($\frac{1}{v_0} = \frac{K_M}{V_{\text{max}}}\frac{1}{[S]} + \frac{1}{V_{\text{max}}}$)**, diagnose reversible inhibition modes (**Competitive**: $K_M^{\text{app}} = \alpha K_M$, $V_{\text{max}}$ constant; **Non-Competitive / Mixed**: $V_{\text{max}}^{\text{app}} = V_{\text{max}}/\alpha$, $K_M$ constant; **Uncompetitive**: both $V_{\text{max}}$ and $K_M$ decreased by $\alpha'$ with parallel lines), and evaluate the **Catalytic Efficiency Metric ($k_{\text{cat}}/K_M$)** approaching the diffusion limit ($10^8 - 10^9\ \text{M}^{-1}\text{s}^{-1}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Michaelis-Menten Model & Lineweaver-Burk Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Briggs-Haldane Steady-State Enzyme Rate Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Enzyme Inhibition Mode & Lineweaver-Burk Plot Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Lineweaver-Burk Double Reciprocal Y-Intercept Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Competitive Inhibitor Lineweaver-Burk Plot Intersect Location Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Enzyme Kinetics & Reversible Inhibition:
   - **The Michaelis-Menten Mechanism (Leonor Michaelis & Maud Menten, 1913; G.E. Briggs & J.B.S. Haldane, 1925):**
     $$\text{E} + \text{S} \xrightleftharpoons[k_{-1}]{k_1} \text{ES} \xrightarrow{k_2 = k_{\text{cat}}} \text{E} + \text{P}$$
   - **The Rate Law:**
     $$v_0 = \frac{V_{\text{max}} [S]}{K_M + [S]} = \frac{k_{\text{cat}} [E]_0 [S]}{K_M + [S]}$$
     - $V_{\text{max}} = k_{\text{cat}} [E]_0$ (Maximum velocity at substrate saturation).
     - $K_M = \frac{k_{-1} + k_{\text{cat}}}{k_1}$ (Michaelis constant; substrate concentration at which $v_0 = \frac{1}{2}V_{\text{max}}$).
     - **Catalytic Efficiency:** $\frac{k_{\text{cat}}}{K_M}$ (Upper ceiling: diffusion limit $\approx 10^8 - 10^9\ \text{M}^{-1}\text{s}^{-1}$).
   - **The Lineweaver-Burk Double-Reciprocal Transformation:**
     $$\frac{1}{v_0} = \left(\frac{K_M}{V_{\text{max}}}\right) \frac{1}{[S]} + \frac{1}{V_{\text{max}}}$$
     - $\text{Y-Intercept} = \frac{1}{V_{\text{max}}}$, $\quad \text{X-Intercept} = -\frac{1}{K_M}$, $\quad \text{Slope} = \frac{K_M}{V_{\text{max}}}$.
   - **The 3 Classic Reversible Inhibition Modes:**
     1. **Competitive ($I$ binds $E$ only):** $K_M$ increases ($K_M^{\text{app}} = \alpha K_M$), $V_{\text{max}}$ unchanged $\implies$ **Lines intersect at the Y-axis**.
     2. **Pure Non-Competitive ($I$ binds $E$ and $ES$ equally):** $V_{\text{max}}$ decreases ($V_{\text{max}}^{\text{app}} = V_{\text{max}}/\alpha$), $K_M$ unchanged $\implies$ **Lines intersect at the X-axis**.
     3. **Uncompetitive ($I$ binds $ES$ only):** Both $V_{\text{max}}$ and $K_M$ decrease by factor $\alpha' \implies$ **Parallel lines (no intersection)**.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Michaelis-Menten equation using the Briggs-Haldane steady-state approach: (1) write mass balance for total enzyme: $[E]_0 = [E] + [ES]$, (2) set up steady-state rate equation for enzyme-substrate complex: $\frac{d[ES]}{dt} = k_1 [E][S] - (k_{-1} + k_2)[ES] = 0$, (3) substitute $[E] = [E]_0 - [ES]$ and define $K_M = \frac{k_{-1} + k_2}{k_1}$, (4) solve algebraically for the steady-state complex concentration: $[ES] = \frac{[E]_0 [S]}{K_M + [S]}$, (5) substitute $[ES]$ into initial velocity equation $v_0 = k_2[ES]$ and define $V_{\text{max}} = k_2[E]_0$ to establish $v_0 = \frac{V_{\text{max}}[S]}{K_M + [S]}$!
3. **Slide 3 (`matching`):** Pair 4 inhibition modes (Competitive Inhibition, Pure Non-Competitive Inhibition, Uncompetitive Inhibition, Irreversible Suicide Inhibition) with their diagnostic Lineweaver-Burk graphical patterns.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in a Lineweaver-Burk double-reciprocal plot, the y-intercept is identically equal to 1 / V_max. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on competitive inhibition: An enzymatic assay is performed in the presence of an inhibitor. The Lineweaver-Burk plot shows that the slope increases, the x-intercept shifts closer to zero (from $-0.5\ \text{mM}^{-1}$ to $-0.2\ \text{mM}^{-1}$), but the y-intercept remains strictly identical at $0.05\ (\mu\text{mol/min})^{-1}$. What type of inhibition is occurring? (This is **Competitive Inhibition**; because the inhibitor binds reversibly to the free enzyme's active site, high substrate concentrations $[S] \to \infty$ can fully outcompete the inhibitor, leaving $V_{\text{max}}$ ($1/\text{y-intercept} = 20\ \mu\text{mol/min}$) completely unchanged while increasing the apparent $K_M$ from $2.0\text{ mM}$ to $5.0\text{ mM}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "enzyme_kinetics_and_michaelis_menten_inhibition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Enzyme Kinetics and Michaelis-Menten Inhibition**\n• **The Michaelis-Menten Equation (1913, 1925):**\n$$\nv_0 = \\frac{V_{\\text{max}} [S]}{K_M + [S]} = \\frac{k_{\\text{cat}} [E]_0 [S]}{K_M + [S]}\n$$\n  - $V_{\\text{max}} = k_{\\text{cat}} [E]_0$ (Saturation limit).\n  - $K_M = \\frac{k_{-1} + k_{\\text{cat}}}{k_1}$ (Substrate concentration at $v_0 = \\frac{1}{2}V_{\\text{max}}$).\n• **Lineweaver-Burk Double-Reciprocal Plot:**\n$$\n\\frac{1}{v_0} = \\left( \\frac{K_M}{V_{\\text{max}}} \\right) \\frac{1}{[S]} + \\frac{1}{V_{\\text{max}}}\n$$\n  - $\\text{Y-Intercept} = \\frac{1}{V_{\\text{max}}}, \\qquad \\text{X-Intercept} = -\\frac{1}{K_M}, \\qquad \\text{Slope} = \\frac{K_M}{V_{\\text{max}}}$.\n• **Reversible Inhibition Diagnostics:**\n  - **Competitive:** $K_M$ increases ($\\alpha K_M$), $V_{\\text{max}}$ unchanged $\\implies$ **Intersect on Y-Axis**.\n  - **Non-Competitive:** $V_{\\text{max}}$ decreases, $K_M$ unchanged $\\implies$ **Intersect on X-Axis**.\n  - **Uncompetitive:** Both $V_{\\text{max}}$ and $K_M$ decrease by same ratio $\\implies$ **Parallel Lines**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the Briggs-Haldane derivation steps for the Michaelis-Menten enzyme rate equation.",
      "orderItems": [
        "State the enzyme conservation law for total enzyme: [E]_0 = [E] + [ES]",
        "Apply the Steady-State Approximation to the enzyme-substrate complex: d[ES]/dt = k_1[E][S] - (k_-1 + k_cat)[ES] = 0",
        "Substitute [E] = [E]_0 - [ES] and define the Michaelis constant K_M = (k_-1 + k_cat) / k_1",
        "Solve algebraically for the steady-state complex concentration: [ES] = [E]_0 * [S] / (K_M + [S])",
        "Substitute [ES] into initial velocity v_0 = k_cat * [ES] and define V_max = k_cat * [E]_0 to establish v_0 = V_max[S] / (K_M + [S])"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each enzyme inhibition type to its diagnostic Lineweaver-Burk graphical feature.",
      "matchPairs": [
        { "left": "Competitive Inhibition", "right": "Lines intersect directly on the Y-axis (1/V_max unchanged, K_M increases)" },
        { "left": "Pure Non-Competitive Inhibition", "right": "Lines intersect directly on the X-axis (-1/K_M unchanged, V_max decreases)" },
        { "left": "Uncompetitive Inhibition", "right": "Parallel lines with equal slope (both V_max and K_M decrease by identical factor)" },
        { "left": "Catalytic Perfection Ceiling", "right": "k_cat / K_M ~ 10^8 - 10^9 M^-1 s^-1 (limited only by diffusion of substrate to active site)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Lineweaver-Burk double-reciprocal plot (1/v_0 vs 1/[S]), the y-axis intercept is equal to the reciprocal of V_max (1 / ___).",
      "blankAnswer": "vmax",
      "blankDistractors": ["km", "kcat", "k1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An enzyme inhibitor increases the slope of the Lineweaver-Burk plot and shifts the x-intercept to the right, but leaves the y-intercept COMPLETELY UNCHANGED. What type of inhibitor is this?",
      "options": [
        { "text": "A COMPETITIVE INHIBITOR; because it binds only to the free enzyme's active site, saturating substrate concentrations ([S] -> infinity) completely outcompete the inhibitor, preserving the true V_max (identical y-intercept)", "isCorrect": true, "explanation": "Correct! In competitive inhibition, the inhibitor and substrate compete for the exact same active site. Because high substrate concentrations displace the inhibitor, V_max is unaffected, so the y-intercept (1/V_max) remains identical. The apparent K_M increases (requiring more substrate to reach half-maximal velocity), shifting the x-intercept (-1/K_M) toward the origin." },
        { "text": "A non-competitive inhibitor", "isCorrect": false, "explanation": "Incorrect: Non-competitive inhibition lowers V_max and changes the y-intercept." },
        { "text": "An uncompetitive inhibitor", "isCorrect": false, "explanation": "Incorrect: Uncompetitive produces parallel lines." },
        { "text": "An irreversible covalent poison", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
