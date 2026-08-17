# Duofy Reusable Lesson Format: Concrete Shear (Truss Analogy & Stirrup Sizing)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Reinforced_Concrete_and_Steel_Design / Limit_State_Design_of_RCC_Beams_Slabs`  
**Lesson Format Type:** `rcc_shear_design_truss_analogies_and_stirrup_spacing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanics of diagonal tension shear failure in reinforced concrete beams, Wilhelm Ritter and Emil Mörsch's **45-Degree Truss Analogy** (concrete diagonal compression struts + steel vertical tension stirrup ties), concrete baseline shear resistance ($V_c$), steel stirrup shear contribution ($V_s$), design shear strength ($\phi V_n = \phi(V_c + V_s) \ge V_u$), maximum spacing limits, and minimum shear reinforcement requirements ($A_{v,\text{min}}$) (James K. Wight *Reinforced Concrete: Mechanics and Design* Chapter 5; ACI 318-19 Section 22.5): formulate the **Ultimate Shear Strength Equations**:
$$\mathbf{V_u \le \phi V_n = \phi \left( V_c + V_s \right) \quad (\text{Shear Strength Reduction Factor } \phi = 0.75)}$$
where:
1. **Concrete Nominal Shear Contribution ($V_c$):**
   $$\mathbf{V_c = 0.17 \lambda \sqrt{f_c'} b_w d \ [\text{N}] \quad (\text{SI Metric}) \quad \Big| \quad V_c = 2 \lambda \sqrt{f_c'} b_w d \ [\text{lbs}] \quad (\text{US Customary})}$$
2. **Steel Stirrup Shear Contribution ($V_s$):**
   $$\mathbf{V_s = \frac{V_u}{\phi} - V_c = \frac{A_v f_{yt} d}{s} \implies \mathbf{s = \frac{A_v f_{yt} d}{V_s}}}$$
master the **Code Spacing & Minimum Steel Invariants**:
- **If $V_u \le 0.5 \phi V_c$:** No stirrups required;
- **If $0.5 \phi V_c < V_u \le \phi V_c$:** Minimum stirrups mandatory: $\mathbf{A_{v,\text{min}} = 0.062 \sqrt{f_c'} \frac{b_w s}{f_{yt}} \ge 0.35 \frac{b_w s}{f_{yt}}}$;
- **Maximum Stirrup Spacing ($s_{\text{max}}$):**
  $$\mathbf{s_{\text{max}} \le \min\left( \frac{d}{2}, \ 600\text{ mm} \ / \ 24\text{ in} \right) \quad \left(\text{Reduced to } \min\left(\frac{d}{4}, \ 300\text{ mm}\right) \text{ if } V_s > 0.33 \sqrt{f_c'} b_w d\right)}$$
(proving why every potential $45^\circ$ diagonal shear crack must be intercepted by at least one transverse steel stirrup tie to prevent catastrophic diagonal shear collapse).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Truss Analogy ($45^\circ$ struts), $V_c = 0.17\lambda\sqrt{f_c'} b_w d$, $V_s = \frac{A_v f_y d}{s}$ & $\phi = 0.75$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Transverse Stirrup Spacing s for an RCC Girder Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Concrete Shear Parameter / Code Threshold & Technical Structural Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In ACI 318 Limit State Shear Design, the Strength Reduction Factor $\phi$ for Shear Is Exactly ___ (0.75 / Three-Fourths) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Civil Engineering Problem: Sizing 2-Legged \Phi 10mm Stirrup Spacing s for a 200 kN Factored Shear Load Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Concrete Shear Mechanics (Wight 2016; ACI 318-19):
   - **Shear Capacity Formulations:**
     $$\mathbf{V_u \le \phi (V_c + V_s) \quad \Big| \quad V_c = 0.17 \lambda \sqrt{f_c'} b_w d \quad \Big| \quad V_s = \frac{A_v f_{yt} d}{s} \quad \Big| \quad s = \frac{A_v f_{yt} d}{V_s} \quad \Big| \quad \phi = 0.75}$$
   - **Shear Design Action Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Factored Shear Demand } V_u & \textbf{Reinforcement Requirement} & \textbf{Maximum Spacing } s_{\text{max}} \\
     \hline
     \mathbf{V_u \le 0.5 \phi V_c} & \text{No shear stirrups required} & \text{None} \\
     \mathbf{0.5 \phi V_c < V_u \le \phi V_c} & \mathbf{\text{Nominal minimum stirrups mandatory } (A_{v,\text{min}})} & \mathbf{\min(d/2, \ 600\text{ mm})} \\
     \mathbf{V_u > \phi V_c} & \mathbf{\text{Engineered stirrups required: } V_s = V_u/\phi - V_c} & \mathbf{\min(d/2, \ 600\text{ mm}) \ [d/4 \text{ if heavy}]} \\
     V_s > 0.66 \sqrt{f_c'} b_w d & \text{Section too small; concrete struts crush} & \text{Must enlarge web dimensions } b_w \times d \\
     \hline
     \end{array}$$
   - **The Crack Interception Invariant:** Because diagonal tension cracks propagate at approximately $45^\circ$, restricting stirrup spacing to **$s \le d/2$ guarantees that every single potential crack is crossed by at least one full vertical stirrup tie**!
2. **Slide 2 (`ordering`):** Provide 5 steps of stirrup design: (1) determine critical factored shear force $V_u$ at distance $d$ from the support face, (2) compute concrete shear capacity $\phi V_c = 0.75 \times (0.17 \lambda \sqrt{f_c'} b_w d)$, (3) evaluate excess shear requiring steel: $V_s = (V_u / \phi) - V_c$, (4) select stirrup bar size ($A_v = 2 \times A_{\text{bar}}$ for 2 legs) and calculate spacing $s = \frac{A_v f_{yt} d}{V_s}$, (5) check code maximum spacing limits ($s \le \min(d/2, 600\text{ mm})$) and round down to constructible increments (e.g. $150\text{ mm}$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Concrete Shear $V_c$, Steel Stirrup Shear $V_s$, Strength Reduction $\phi = 0.75$, Spacing Limit $s \le d/2$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.75 (or Three-Fourths). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sizing stirrups: A reinforced concrete beam ($b_w = 300\text{ mm}, d = 500\text{ mm}, f_c' = 25\text{ MPa}, \lambda = 1.0$) carries a critical factored shear force $V_u = 200.0\text{ kN}$ ($\phi = 0.75$). Steel stirrups have $f_{yt} = 400\text{ MPa}$. The concrete shear strength is $V_c = 0.17 \sqrt{25} \times (300) \times (500) = 0.17 \times 5 \times 150,000 = 127.5\text{ kN}$ ($\phi V_c = 95.63\text{ kN}$). If $2\text{-legged } \Phi 10\text{ mm}$ stirrups are used ($A_v = 2 \times 78.54 = 157.08\text{ mm}^2$), what is the required steel shear force $V_s$ and the maximum theoretical stirrup pitch $s$? ($V_s = \frac{V_u}{\phi} - V_c = \frac{200.0\text{ kN}}{0.75} - 127.5\text{ kN} = 266.67\text{ kN} - 127.5\text{ kN} = \mathbf{139.17\text{ kN} = 139,167\text{ N}}$; $s = \frac{A_v f_{yt} d}{V_s} = \frac{157.08\text{ mm}^2 \times 400\text{ MPa} \times 500\text{ mm}}{139,167\text{ N}} = \frac{31,416,000}{139,167} = \mathbf{225.74\text{ mm} \approx 225\text{ mm}}$; Check $s_{\text{max}} = \min(500/2, 600) = \mathbf{250\text{ mm}}$; Design spacing: $s = \mathbf{225\text{ mm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rcc_shear_design_truss_analogies_and_stirrup_spacing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: RCC Shear Design \\& 45-Degree Truss Analogy (Ritter \\& Mörsch)**\n• **Total Ultimate Shear Strength Equation:**\n$$\n\\mathbf{V_u \\le \\phi V_n = \\phi \\left( V_c + V_s \\right) \\quad (\\text{Shear Strength Reduction Factor } \\mathbf{\\phi = 0.75})}\n$$\n• **Concrete Nominal Shear Capacity ($V_c$):**\n$$\n\\mathbf{V_c = 0.17 \\lambda \\sqrt{f_c'} b_w d \\ [\\text{N}] \\quad (\\text{SI Metric}) \\quad \\Big| \\quad V_c = 2 \\lambda \\sqrt{f_c'} b_w d \\ [\\text{lbs}] \\quad (\\text{US Customary})}\n$$\n• **Transverse Steel Stirrup Shear Contribution ($V_s$) \\& Spacing ($s$):**\n$$\n\\mathbf{V_s = \\frac{V_u}{\\phi} - V_c = \\frac{A_v f_{yt} d}{s} \\implies \\mathbf{s = \\frac{A_v f_{yt} d}{V_s}}}\n$$\n• **Code Maximum Spacing Invariant:** Stirrup spacing is strictly capped at $\\mathbf{s_{\\text{max}} \\le \\min\\left(\\frac{d}{2}, \\ 600\\text{ mm}\\right)}$, ensuring that **every single $45^\\circ$ diagonal tension crack is physically intercepted** by at least one transverse steel tie!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design transverse shear stirrups for an RCC girder under factored ultimate load.",
      "orderItems": [
        "Determine the critical factored shear force Vu located at distance d from the face of the support",
        "Calculate the nominal concrete shear resistance: Vc = 0.17 * \u03bb * \u221afc' * bw * d and compute design capacity \u03c6Vc (\u03c6 = 0.75)",
        "Check if Vu > \u03c6Vc; if active, compute the required excess shear carried by steel: Vs = (Vu / \u03c6) - Vc",
        "Select the stirrup bar diameter (e.g. 2-legged \u03a610mm \u2192 Av = 157 mm^2) and compute theoretical spacing: s = (Av * fyt * d) / Vs",
        "Verify maximum spacing limits: s \u2264 min(d/2, 600 mm) and specify rounded constructible spacing on structural drawings"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Reinforced Concrete Shear Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Concrete Shear Resistance (Vc)", "right": "Vc = 0.17*\u03bb*\u221afc'*bw*d, baseline shear capacity provided by uncracked concrete compression zone and aggregate interlock" },
        { "left": "Stirrup Contribution (Vs)", "right": "Vs = (Av*fyt*d) / s, vertical tension tie capacity resisting diagonal crack opening in the 45\u00b0 truss model" },
        { "left": "Shear Strength Reduction (\u03c6 = 0.75)", "right": "Conservative safety factor accounting for brittle diagonal tension failure mechanisms" },
        { "left": "Maximum Spacing Limit (s \u2264 d/2)", "right": "Geometric requirement ensuring every 45\u00b0 diagonal crack crosses at least one full vertical stirrup tie" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In ACI 318 structural concrete limit state design, the strength reduction factor \u03c6 for shear and torsion is exactly ___.",
      "blankAnswer": "0.75",
      "blankDistractors": ["0.90", "0.65", "0.85"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular concrete beam (bw = 300 mm, d = 500 mm, fc' = 25 MPa, \u03bb = 1.0) carries factored shear Vu = 200.0 kN (\u03c6 = 0.75). Stirrup yield strength is fyt = 400 MPa. Concrete shear capacity is Vc = 127.5 kN (\u03c6Vc = 95.6 kN). Using 2-legged \u03a610 mm stirrups (Av = 157.1 mm^2), what is the required steel shear force Vs and the maximum theoretical stirrup spacing s?",
      "options": [
        { "text": "Vs = 139.2 kN and s = 225 mm (Vs = 200/0.75 - 127.5 = 266.67 - 127.5 = 139.17 kN; s = (157.1 * 400 * 500) / 139167 = 31420000 / 139167 = 225.7 mm \u2264 d/2 = 250 mm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using ACI 318-19 shear design equations (James K. Wight *Reinforced Concrete: Mechanics and Design* Chapter 5). 1. **Calculate Concrete Shear Capacity ($V_c$):** $$V_c = 0.17 \\lambda \\sqrt{f_c'} b_w d = 0.17 \\times 1.0 \\times \\sqrt{25\\text{ MPa}} \\times (300\\text{ mm}) \\times (500\\text{ mm})$$ $$V_c = 0.17 \\times 5.0 \\times 150,000 = 127,500\\text{ N} = \\mathbf{127.50\\text{ kN}}$$ - Design concrete capacity: $$\\phi V_c = 0.75 \\times 127.50\\text{ kN} = \\mathbf{95.625\\text{ kN}}$$ - Since $V_u = 200.0\\text{ kN} > \\phi V_c = 95.625\\text{ kN}$, **shear reinforcement is mandatory**! 2. **Calculate Required Steel Shear Strength ($V_s$):** $$V_s = \\frac{V_u}{\\phi} - V_c = \\frac{200.0\\text{ kN}}{0.75} - 127.50\\text{ kN} = 266.667\\text{ kN} - 127.50\\text{ kN} = \\mathbf{139.167\\text{ kN} = 139,167\\text{ N}}$$ 3. **Calculate Theoretical Stirrup Spacing ($s$):** - Rebar area for 2-legged $\\Phi 10\\text{ mm}$ stirrup: $$A_v = 2 \\times \\left(\\frac{\\pi \\times 10^2}{4}\\right) = 2 \\times 78.54\\text{ mm}^2 = \\mathbf{157.08\\text{ mm}^2}$$ - Spacing formula: $$s = \\frac{A_v f_{yt} d}{V_s} = \\frac{157.08\\text{ mm}^2 \\times 400\\text{ MPa} \\times 500\\text{ mm}}{139,167\\text{ N}} = \\frac{31,416,000}{139,167} = \\mathbf{225.74\\text{ mm} \\approx 225\\text{ mm}}$$ 4. **Check Maximum Code Spacing Limits:** $$s_{\\text{max}} = \\min\\left(\\frac{d}{2}, \\ 600\\text{ mm}\\right) = \\min\\left(\\frac{500}{2}, \\ 600\\right) = \\mathbf{250\\text{ mm}}$$ - Since $s = 225\\text{ mm} < 250\\text{ mm}$, the design pitch is **$s = 225\\text{ mm}$** (or $220\\text{ mm}$ for construction rounding)! Flawless RCC shear stirrup design!" },
        { "text": "Vs = 72.5 kN and s = 433 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Vs = 200.0 kN and s = 157 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Vs = 139.2 kN and s = 350 mm (Exceeds d/2 limit)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
