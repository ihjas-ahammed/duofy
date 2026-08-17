# Duofy Reusable Lesson Format: Structural Concrete Ductility (Tensile Strain & Phi Factors)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Reinforced_Concrete_and_Steel_Design / Limit_State_Design_of_RCC_Beams_Slabs`  
**Lesson Format Type:** `rcc_beam_ductility_net_tensile_strain_and_phi_factors`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the unified design provisions of ACI 318-19 and Eurocode 2 for structural concrete ductility, the calculation of net tensile steel strain ($\epsilon_t$) at nominal flexural strength, the physical differentiation between **Tension-Controlled**, **Transition**, and **Compression-Controlled** sections, and the linear interpolation of the strength reduction factor ($\phi$) to penalize brittle over-reinforced designs (James K. Wight *Reinforced Concrete: Mechanics and Design* Chapter 4; Arthur H. Nilson *Design of Concrete Structures* Chapter 3): formulate the **Net Tensile Strain ($\epsilon_t$) Compatibility Equation**:
$$\mathbf{\epsilon_t = \epsilon_{cu} \left( \frac{d - c}{c} \right) = 0.003 \left( \frac{d - c}{c} \right)}$$
derive the **Three Distinct Failure Regimes & Strength Reduction Factor ($\phi$)**:
1. **Tension-Controlled Section ($\mathbf{\epsilon_t \ge 0.005}$):**
   - Tensile rebar yields substantially before concrete crushes ($\epsilon_t > 2.5 \epsilon_y$);
   - Large ductile deflections and visible flexural cracking provide ample warning of failure;
   - Strength reduction factor: $\mathbf{\phi = 0.90}$;
2. **Compression-Controlled Section ($\mathbf{\epsilon_t \le \epsilon_y = f_y / E_s \approx 0.002}$):**
   - Concrete crushes suddenly and catastrophically in a brittle explosion while steel remains elastic;
   - Strength reduction factor: $\mathbf{\phi = 0.65}$ (tied columns/beams) or $\mathbf{\phi = 0.75}$ (spiral columns);
3. **Transition Zone ($\mathbf{\epsilon_y < \epsilon_t < 0.005}$):**
   - Linear interpolation formula:
     $$\mathbf{\phi = 0.65 + 0.25 \left( \frac{\epsilon_t - \epsilon_y}{0.005 - \epsilon_y} \right)}$$
(proving why building codes mandate minimum reinforcement $A_{s,\text{min}}$ to prevent sudden rupture upon cracking and maximum reinforcement limits $c/d \le 0.375$ to enforce ductile behavior).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Net Tensile Strain ($\epsilon_t = 0.003 \frac{d-c}{c}$), Tension vs Compression Sections & $\phi$-Curves Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Verify Beam Ductility and Determine the Exact Phi Factor Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Strain Regime / Failure Mode & Technical Structural Consequence Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In ACI 318 Structural Concrete Design, a Section Is Defined as Fully Tension-Controlled When the Net Tensile Strain Exceeds ___ (0.005 / Five Thousandths) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Forensic Structural Problem: Evaluating Net Tensile Strain \epsilon_t and Phi Factor for a Heavily Reinforced Beam Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Concrete Ductility & Phi Factors (Wight 2016; ACI 318-19):
   - **Strain & Phi Formulations:**
     $$\mathbf{\epsilon_t = 0.003\left(\frac{d-c}{c}\right) \quad \Big| \quad \phi = 0.90 \ (\epsilon_t \ge 0.005) \quad \Big| \quad \phi = 0.65 + 0.25\left(\frac{\epsilon_t - 0.002}{0.003}\right) \quad \Big| \quad \phi = 0.65 \ (\epsilon_t \le 0.002)}$$
   - **Section Ductility Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Section Classification} & \textbf{Tensile Strain Range } \epsilon_t & \textbf{Phi Factor } \phi & \textbf{Failure Mode Characteristics} \\
     \hline
     \mathbf{\text{Tension-Controlled}} & \mathbf{\epsilon_t \ge 0.005} & \mathbf{\phi = 0.90} & \mathbf{\text{Ductile yielding; large visible deflections and warning}} \\
     \mathbf{\text{Transition Zone}} & 0.002 < \epsilon_t < 0.005 & 0.65 \le \phi < 0.90 & \text{Moderate ductility; interpolated safety factor} \\
     \mathbf{\text{Compression-Controlled}} & \mathbf{\epsilon_t \le 0.002 \ (\epsilon_y)} & \mathbf{\phi = 0.65} & \mathbf{\text{Brittle explosive concrete crushing with ZERO warning!}} \\
     \hline
     \end{array}$$
   - **The Code Philosophy Invariant:** Building codes deliberately punish brittle, over-reinforced designs with a severe safety factor penalty ($\phi = 0.65$ vs $0.90$), heavily incentivizing engineers to design ductile, under-reinforced sections!
2. **Slide 2 (`ordering`):** Provide 5 steps of ductility verification: (1) calculate Whitney stress block depth $a = A_s f_y / (0.85 f_c' b)$, (2) compute neutral axis depth $c = a / \beta_1$, (3) compute extreme fiber tensile steel strain $\epsilon_t = 0.003 (d - c)/c$, (4) compare $\epsilon_t$ against the threshold $0.005$, (5) assign $\phi = 0.90$ if $\epsilon_t \ge 0.005$ or interpolate $\phi$ if in the transition zone!
3. **Slide 3 (`matching`):** Pair 4 concepts (Tension-Controlled $\phi = 0.90$, Compression-Controlled $\phi = 0.65$, Transition Interpolation, Minimum Steel $A_{s,\text{min}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.005 (or Five Thousandths). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing $\epsilon_t$ and $\phi$: A heavily reinforced rectangular beam has effective depth $d = 450\text{ mm}$, with stress block depth calculated as $a = 153.0\text{ mm}$ in a $25\text{ MPa}$ concrete section ($\beta_1 = 0.85$, $f_y = 400\text{ MPa}, \ \epsilon_y = 0.002$). What is the neutral axis depth $c$, the net tensile strain $\epsilon_t$, and the resulting strength reduction factor $\phi$? ($c = \frac{a}{\beta_1} = \frac{153.0\text{ mm}}{0.85} = \mathbf{180.0\text{ mm}}$; $\epsilon_t = 0.003 \left(\frac{d - c}{c}\right) = 0.003 \left(\frac{450 - 180}{180}\right) = 0.003 \left(\frac{270}{180}\right) = 0.003 \times 1.50 = \mathbf{0.0045}$; Since $0.002 < 0.0045 < 0.005$, the section is in the **Transition Zone**; $\phi = 0.65 + 0.25 \left(\frac{0.0045 - 0.0020}{0.0050 - 0.0020}\right) = 0.65 + 0.25 \left(\frac{0.0025}{0.0030}\right) = 0.65 + 0.25(0.8333) = 0.65 + 0.2083 = \mathbf{0.8583 \approx 0.858}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rcc_beam_ductility_net_tensile_strain_and_phi_factors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Net Tensile Strain \\& Concrete Ductility (ACI 318-19)**\n• **Net Tensile Steel Strain ($\\epsilon_t$) Formulation:**\n$$\n\\mathbf{\\epsilon_t = \\epsilon_{cu} \\left( \\frac{d - c}{c} \\right) = 0.003 \\left( \\frac{d - c}{c} \\right)}\n$$\n• **The 3 Ductility Regimes \\& Strength Reduction Factor ($\\phi$):**\n  - **Tension-Controlled ($\\mathbf{\\epsilon_t \\ge 0.005}$):** Ductile steel yielding with extensive warning $\\implies \\mathbf{\\phi = 0.90}$;\n  - **Transition Zone ($0.002 < \\epsilon_t < 0.005$):** Linear interpolation $\\implies \\mathbf{\\phi = 0.65 + 0.25 \\left( \\frac{\\epsilon_t - 0.002}{0.003} \\right)}$;\n  - **Compression-Controlled ($\\mathbf{\\epsilon_t \\le 0.002}$):** Sudden brittle concrete crushing $\\implies \\mathbf{\\phi = 0.65}$ (tied beams/columns);\n• **The Code Penalty Invariant:** Building codes impose a massive **$28\\%$ capacity penalty ($\\phi = 0.65$ vs $0.90$)** on over-reinforced brittle beams to ensure structures fail gracefully with visible crack warnings before collapse!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate the net tensile strain and determine the exact strength reduction factor \u03c6 for a reinforced concrete beam.",
      "orderItems": [
        "Calculate the Whitney stress block depth a from internal equilibrium: a = (As * fy) / (0.85 * fc' * b)",
        "Determine the neutral axis depth c using the concrete strength factor \u03b21: c = a / \u03b21",
        "Compute the extreme fiber net tensile steel strain: \u03b5t = 0.003 * (d - c) / c from strain compatibility",
        "Classify the section failure mode by comparing \u03b5t against the limits: \u03b5y \u2248 0.002 and \u03b5t = 0.005",
        "Assign \u03c6 = 0.90 for tension-controlled or calculate the interpolated \u03c6 factor if operating in the transition zone"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Concrete Ductility Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Tension-Controlled (\u03b5t \u2265 0.005)", "right": "Ductile failure regime with \u03c6 = 0.90 providing visible crack warning and large plastic deflections" },
        { "left": "Compression-Controlled (\u03b5t \u2264 0.002)", "right": "Brittle failure regime with \u03c6 = 0.65 where concrete crushes explosively before steel reaches yield" },
        { "left": "Transition Zone (0.002 < \u03b5t < 0.005)", "right": "Interpolated strength reduction factor: \u03c6 = 0.65 + 0.25 * [(\u03b5t - 0.002) / 0.003]" },
        { "left": "Minimum Reinforcement (As,min)", "right": "Code-mandated steel threshold preventing sudden catastrophic snapping when concrete cracks" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In ACI 318 structural concrete design, a flexural section is defined as fully tension-controlled when the net tensile strain exceeds ___.",
      "blankAnswer": "0.005",
      "blankDistractors": ["0.002", "0.003", "0.010"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A reinforced concrete beam with d = 450 mm has stress block depth a = 153.0 mm (fc' = 25 MPa, \u03b21 = 0.85, fy = 400 MPa, \u03b5y = 0.002). What is the neutral axis depth c, net tensile strain \u03b5t, and the exact strength reduction factor \u03c6?",
      "options": [
        { "text": "c = 180.0 mm, \u03b5t = 0.0045, and \u03c6 = 0.858 (c = 153/0.85 = 180 mm; \u03b5t = 0.003*(450-180)/180 = 0.0045; since 0.002 < 0.0045 < 0.005 (transition zone), \u03c6 = 0.65 + 0.25*(0.0045-0.002)/0.003 = 0.8583)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using ACI 318-19 section ductility and $\\phi$-factor equations (James K. Wight *Reinforced Concrete: Mechanics and Design* Chapter 4). 1. **Calculate Neutral Axis Depth ($c$):** $$c = \\frac{a}{\\beta_1} = \\frac{153.0\\text{ mm}}{0.85} = \\mathbf{180.0\\text{ mm}}$$ 2. **Calculate Net Tensile Steel Strain ($\\epsilon_t$):** $$\\epsilon_t = \\epsilon_{cu} \\left(\\frac{d - c}{c}\\right) = 0.003 \\left(\\frac{450\\text{ mm} - 180\\text{ mm}}{180\\text{ mm}}\\right) = 0.003 \\left(\\frac{270\\text{ mm}}{180\\text{ mm}}\\right) = 0.003 \\times 1.50 = \\mathbf{0.00450}$$ 3. **Classify Section Behavior:** - Since $\\epsilon_y = 0.002 < \\mathbf{0.00450} < 0.0050$, the beam is in the **Transition Zone** (yielding has occurred, but ductility is below the full tension-controlled threshold). 4. **Calculate Strength Reduction Factor ($\\phi$) via Linear Interpolation:** $$\\phi = 0.65 + 0.25 \\left(\\frac{\\epsilon_t - \\epsilon_y}{0.005 - \\epsilon_y}\\right) = 0.65 + 0.25 \\left(\\frac{0.0045 - 0.0020}{0.0050 - 0.0020}\\right)$$ $$\\phi = 0.65 + 0.25 \\left(\\frac{0.0025}{0.0030}\\right) = 0.65 + 0.25 \\times (0.83333) = 0.65 + 0.20833 = \\mathbf{0.85833 \\approx 0.858}$$ 5. **Design Impact:** The nominal moment capacity $M_n$ must be multiplied by $\\phi = 0.858$ instead of $0.900$ to account for reduced plastic deformation warning! Flawless concrete ductility analysis!" },
        { "text": "c = 180.0 mm, \u03b5t = 0.0060, and \u03c6 = 0.900", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "c = 153.0 mm, \u03b5t = 0.0045, and \u03c6 = 0.650", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "c = 225.0 mm, \u03b5t = 0.0030, and \u03c6 = 0.733", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
