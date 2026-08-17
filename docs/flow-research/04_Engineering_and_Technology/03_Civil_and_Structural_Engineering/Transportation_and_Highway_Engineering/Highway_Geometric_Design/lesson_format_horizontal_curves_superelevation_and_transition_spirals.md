# Duofy Reusable Lesson Format: Horizontal Alignment (Superelevation & Euler Spirals)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Highway_Geometric_Design`  
**Lesson Format Type:** `horizontal_curves_superelevation_and_transition_spirals`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through horizontal circular curve mechanics, centrifugal acceleration balancing on highway turns, cross-slope banking / **Superelevation ($e$)**, tire-pavement side friction factor ($f_s$), minimum curve radius ($R_{\text{min}}$), maximum superelevation rates ($e_{\text{max}} = 6\%-8\%$ rural, $4\%$ urban), and **Euler Clothoid Transition Spirals ($L_s$)** providing smooth linear transitions of curvature and superelevation runoff (AASHTO Green Book 7th ed. Chapter 3; Fred L. Mannering *Principles of Highway Engineering and Traffic Analysis* Chapter 3): formulate the **Horizontal Curve Centrifugal Equilibrium Equation**:
$$\mathbf{e + f_s = \frac{V^2}{127 R} \quad \left(V \text{ in km/h}, \ R \text{ in meters}\right) \Longleftrightarrow \mathbf{e + f_s = \frac{V^2}{15 R} \quad \left(V \text{ in mph}, \ R \text{ in feet}\right)}}$$
derive the **AASHTO Minimum Curve Radius ($R_{\text{min}}$)**:
$$\mathbf{R_{\text{min}} = \frac{V^2}{127 \left( e_{\text{max}} + f_{s,\text{max}} \right)}}$$
derive the **Euler Clothoid Spiral Transition Length ($L_s$)**:
$$\mathbf{L_s = \frac{V^3}{46.7 \cdot C \cdot R} \quad \left(C = \text{Rate of increase of lateral acceleration } \le 0.60\text{ m/s}^3\right)}$$
master the **Superelevation Runoff Mechanics**:
- Transitioning from normal crown (e.g. $-2.0\%$) to full design superelevation ($+e$);
- $2/3$ of the superelevation runoff length is placed on the tangent approach, and $1/3$ on the circular curve (or $100\%$ on the transition spiral);
(proving how banking angles utilize gravitational vehicle self-weight to counteract outward centrifugal skidding).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Superelevation Equation ($e + f_s = \frac{V^2}{127R}$), $R_{\text{min}}$ & Clothoid Spiral ($L_s$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Minimum Curve Radius and Spiral Length for a Highway Turn Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Horizontal Alignment Parameter / Curve Entity & Technical Highway Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Metric AASHTO Horizontal Curve Design, the Minimum Permissible Radius $R_{\text{min}}$ Equals $V^2$ Divided by $127(e_{\text{max}} + \text{___})$ (f_s,max / Side Friction) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Highway Design Problem: Computing Minimum Curve Radius R_min for 110 km/h with e_max = 6% Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Horizontal Curve Superelevation (AASHTO 2018; Mannering 2020):
   - **Superelevation Formulations:**
     $$\mathbf{e + f_s = \frac{V^2}{127 R} \quad \Big| \quad R_{\text{min}} = \frac{V^2}{127(e_{\text{max}} + f_{s,\text{max}})} \quad \Big| \quad L_s = \frac{V^3}{46.7 C R} \quad (C \le 0.60\text{ m/s}^3)}$$
   - **AASHTO Maximum Side Friction ($f_{s,\text{max}}$) Guidelines:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Design Speed } V & \textbf{Side Friction } f_{s,\text{max}} & \textbf{Max Superelevation } e_{\text{max}} & \textbf{Calculated } R_{\text{min}} \\
     \hline
     \mathbf{60\text{ km/h}} & \mathbf{0.150} & 0.060 \ (6\%) & \mathbf{135\text{ m}} \\
     \mathbf{80\text{ km/h}} & \mathbf{0.140} & 0.060 \ (6\%) & \mathbf{252\text{ m}} \\
     \mathbf{100\text{ km/h}} & \mathbf{0.120} & 0.060 \ (6\%) & \mathbf{437\text{ m}} \\
     \mathbf{120\text{ km/h}} & \mathbf{0.090} & 0.060 \ (6\%) & \mathbf{756\text{ m}} \\
     \hline
     \end{array}$$
   - **The Centrifugal Balancing Invariant:** Road banking tilts vehicle weight by angle $\theta \approx e$, generating an inward horizontal gravity component **$W \sin\theta \approx W e$** that offsets centrifugal outward force $W V^2 / g R$!
2. **Slide 2 (`ordering`):** Provide 5 steps of horizontal curve design: (1) determine highway design speed $V$ and select maximum allowable superelevation $e_{\text{max}}$ (e.g. $0.06$ or $0.08$), (2) look up the maximum permissible side friction factor $f_{s,\text{max}}$ for the design speed, (3) calculate the minimum horizontal curve radius: $R_{\text{min}} = \frac{V^2}{127(e_{\text{max}} + f_{s,\text{max}})}$, (4) select a circular curve radius $R \ge R_{\text{min}}$ conforming to site topography, (5) calculate transition spiral length: $L_s = \frac{V^3}{46.7 C R}$ to introduce curvature and superelevation smoothly!
3. **Slide 3 (`matching`):** Pair 4 concepts (Superelevation $e$, Side Friction Factor $f_s$, Minimum Radius $R_{\text{min}}$, Euler Clothoid Spiral) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of f_s,max (or Side Friction). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating minimum curve radius: A rural freeway is designed for $V = 110.0\text{ km/h}$. The maximum allowable superelevation is $e_{\text{max}} = 0.060$ ($6\%$) and the AASHTO maximum side friction factor is $f_{s,\text{max}} = 0.110$.
   - Sum of banking and friction: $e_{\text{max}} + f_{s,\text{max}} = 0.060 + 0.110 = \mathbf{0.170}$;
   - Velocity squared: $V^2 = (110.0)^2 = \mathbf{12,100}$;
   - Denominator: $127 \times (0.170) = \mathbf{21.59}$;
   - Minimum radius: $R_{\text{min}} = \frac{12,100}{21.59} = \mathbf{560.44\text{ m} \approx 560.4\text{ m}}$ (AASHTO standard tables round up to $\mathbf{565\text{ m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "horizontal_curves_superelevation_and_transition_spirals",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Horizontal Curves \\& Superelevation (AASHTO Green Book)**\n• **Centrifugal Equilibrium Master Equation (SI Units):**\n$$\n\\mathbf{e + f_s = \\frac{V^2}{127 R} \\quad \\left(V \\text{ in km/h}, \\ R \\text{ in meters}\\right)}\n$$\n  - **$e$:** Cross-slope superelevation rate ($\\text{m/m}$);\n  - **$f_s$:** Tire-pavement side friction factor;\n  - **$R$:** Radius of the horizontal circular curve ($\\text{m}$);\n• **AASHTO Minimum Curve Radius Formulation:**\n$$\n\\mathbf{R_{\\text{min}} = \\frac{V^2}{127 \\left( e_{\\text{max}} + f_{s,\\text{max}} \\right)}}\n$$\n• **Euler Clothoid Transition Spiral Length Formulation ($L_s$):**\n$$\n\\mathbf{L_s = \\frac{V^3}{46.7 \\cdot C \\cdot R} \\quad \\left(C = \\text{Rate of change of lateral acceleration } \\le 0.60\\text{ m/s}^3\\right)}\n$$\n• **The Gravity Balancing Invariant:** Superelevation banks the road inward by slope $e$, mobilizing a component of vehicle weight **$W \\cdot e$** to neutralize outward centrifugal skidding forces without depending entirely on tire friction!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the minimum radius and transition spiral length for a horizontal highway curve.",
      "orderItems": [
        "Identify highway design speed V and select maximum allowable superelevation e_max (e.g. 0.06 or 0.08)",
        "Look up the AASHTO maximum permissible side friction factor fs,max corresponding to design speed V",
        "Calculate the absolute minimum horizontal curve radius: R_min = V^2 / [127 * (e_max + fs,max)]",
        "Select a practical circular curve radius R \u2265 R_min that fits regional topography and property right-of-way",
        "Calculate the minimum Euler clothoid transition spiral length: Ls = V^3 / (46.7 * C * R) to achieve smooth superelevation runoff"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Horizontal Alignment Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Superelevation (e)", "right": "Transverse roadway slope banking tilting the pavement inward to counteract centrifugal force" },
        { "left": "Side Friction (fs)", "right": "Lateral grip between tire rubber and pavement surface preventing outward vehicle skidding" },
        { "left": "Minimum Radius (R_min)", "right": "Sharpest allowable curve radius safely negotiated at design speed without exceeding friction limits" },
        { "left": "Euler Clothoid Spiral", "right": "Transition curve whose curvature increases linearly with arc length (1/R \u221d Ls)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In metric AASHTO horizontal curve design, the minimum permissible radius R_min equals V^2 divided by 127(e_max + ___).",
      "blankAnswer": "fs_max",
      "blankDistractors": ["f_t", "G", "tr"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rural freeway is designed for V = 110.0 km/h with maximum superelevation e_max = 0.060 (6%) and maximum side friction fs,max = 0.110. What is the calculated minimum horizontal curve radius R_min?",
      "options": [
        { "text": "R_min = 560.4 m (R_min = 110^2 / [127 * (0.060 + 0.110)] = 12100 / (127 * 0.170) = 12100 / 21.59 = 560.44 m; AASHTO rounds to 565 m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the AASHTO horizontal curve superelevation formula (AASHTO Green Book 7th ed. Chapter 3). 1. **Identify Given Design Inputs:** - Design speed: $V = 110.0\\text{ km/h}$. - Maximum superelevation: $e_{\\text{max}} = 0.060$. - Maximum side friction: $f_{s,\\text{max}} = 0.110$. 2. **Calculate Combined Transverse Resistance:** $$e_{\\text{max}} + f_{s,\\text{max}} = 0.060 + 0.110 = \\mathbf{0.170}$$ 3. **Calculate Minimum Curve Radius ($R_{\\text{min}}$):** $$R_{\\text{min}} = \\frac{V^2}{127 \\left( e_{\\text{max}} + f_{s,\\text{max}} \\right)} = \\frac{(110.0\\text{ km/h})^2}{127 \\times (0.170)}$$ $$R_{\\text{min}} = \\frac{12,100}{21.59} = \\mathbf{560.4446\\text{ m} \\approx 560.4\\text{ m}}$$ 4. **AASHTO Design Standard:** - Highway design tables specify a standard rounded radius of **$565\\text{ m}$** for $110\\text{ km/h}$ at $e_{\\text{max}} = 6\\%$! Flawless horizontal curve superelevation and radius derivation!" },
        { "text": "R_min = 350.0 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "R_min = 890.2 m (Used only side friction fs = 0.110)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "R_min = 560.4 m with spiral length = 20 m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
