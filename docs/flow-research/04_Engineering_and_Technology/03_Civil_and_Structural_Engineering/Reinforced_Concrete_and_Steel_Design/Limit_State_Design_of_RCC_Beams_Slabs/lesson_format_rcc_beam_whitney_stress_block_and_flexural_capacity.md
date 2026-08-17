# Duofy Reusable Lesson Format: RCC Flexure (Whitney Stress Block & Nominal Capacity)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Reinforced_Concrete_and_Steel_Design / Limit_State_Design_of_RCC_Beams_Slabs`  
**Lesson Format Type:** `rcc_beam_whitney_stress_block_and_flexural_capacity`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanics of flexural failure in singly reinforced concrete beams, the replacement of non-linear parabolic concrete compressive stress with Charles S. Whitney's equivalent rectangular stress block ($\alpha = 0.85, a = \beta_1 c$), internal force equilibrium ($C = T$), internal lever arm $(d - a/2)$, and the calculation of nominal ($M_n$) and design ($\phi M_n$) moment capacities (James K. Wight *Reinforced Concrete: Mechanics and Design* Chapter 4; ACI 318-19 Section 22.2): formulate the **Whitney Stress Block & Internal Equilibrium Equations**:
$$\mathbf{C = 0.85 f_c' \cdot a \cdot b \quad \Big| \quad T = A_s f_y \implies \mathbf{C = T \Longleftrightarrow 0.85 f_c' a b = A_s f_y}}$$
$$\mathbf{a = \frac{A_s f_y}{0.85 f_c' b} \quad \Big| \quad \mathbf{c = \frac{a}{\beta_1}} \quad \left(\beta_1 = 0.85 \text{ for } f_c' \le 28\text{ MPa} \ / \ 4000\text{ psi}\right)}$$
derive the **Nominal Flexural Moment Capacity ($M_n$)**:
$$\mathbf{M_n = T \left( d - \frac{a}{2} \right) = A_s f_y \left( d - \frac{a}{2} \right) \Longleftrightarrow M_n = C \left( d - \frac{a}{2} \right) = 0.85 f_c' a b \left( d - \frac{a}{2} \right)}$$
derive the **Design Moment Capacity ($\phi M_n$)**:
$$\mathbf{\phi M_n = \phi A_s f_y \left( d - \frac{a}{2} \right) \ge M_u \quad (\text{With } \phi = 0.90 \text{ for Tension-Controlled Sections})}$$
(proving that the Whitney stress block matches experimental ultimate flexural capacities within $1-2\%$ error while simplifying non-linear parabolic integration into high school algebra).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Whitney Stress Block ($a = \frac{A_s f_y}{0.85 f_c' b}$), Lever Arm ($d - a/2$) & Moment Capacity ($\phi M_n$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Design Moment Capacity \phi M_n of a Singly Reinforced Concrete Beam Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Concrete Flexural Variable / Parameter & Technical Structural Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Whitney Equivalent Stress Block, the Magnitude of the Average Concrete Compressive Stress Is Taken as Exactly ___ Times f'c (0.85 / Eighty-Five Percent) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Civil Engineering Problem: Calculating Stress Block Depth a and Design Moment \phi M_n for a 300x500mm RCC Beam Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Whitney Stress Block & Capacity (Wight 2016; ACI 318-19):
   - **Stress Block & Moment Formulations:**
     $$\mathbf{a = \frac{A_s f_y}{0.85 f_c' b} \quad \Big| \quad c = \frac{a}{\beta_1} \quad \Big| \quad M_n = A_s f_y \left(d - \frac{a}{2}\right) \quad \Big| \quad \phi M_n \ge M_u}$$
   - **Stress Block Parameter Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Concrete Strength Range } f_c' & \textbf{Stress Block Depth Factor } \beta_1 & \textbf{Ultimate Concrete Strain } \epsilon_{cu} \\
     \hline
     \mathbf{f_c' \le 28\text{ MPa} \ (\le 4000\text{ psi})} & \mathbf{\beta_1 = 0.85} & \mathbf{\epsilon_{cu} = 0.003 \ (\text{ACI 318})} \\
     28\text{ MPa} < f_c' \le 55\text{ MPa} & \beta_1 = 0.85 - 0.05 \left(\frac{f_c' - 28}{7}\right) & \epsilon_{cu} = 0.003 \\
     f_c' > 55\text{ MPa} \ (> 8000\text{ psi}) & \beta_1 = 0.65 \ (\text{Minimum Lower Bound}) & \epsilon_{cu} = 0.003 \\
     \hline
     \end{array}$$
   - **The Tension Yielding Invariant:** In an under-reinforced beam, tensile steel rebar yields completely ($f_s = f_y$) long before the concrete reaches crushing strain ($\epsilon_{cu} = 0.003$), allowing the internal tension force $T$ to be fixed at $A_s f_y$!
2. **Slide 2 (`ordering`):** Provide 5 steps of nominal moment calculation: (1) extract material properties ($f_c', f_y$), cross-section dimensions ($b, d$), and total tensile steel area $A_s$, (2) equate internal compression and tension $C = T$ to solve equivalent stress block depth: $a = \frac{A_s f_y}{0.85 f_c' b}$, (3) compute neutral axis depth $c = a / \beta_1$ and verify net tensile strain $\epsilon_t \ge 0.005$, (4) compute nominal moment capacity $M_n = A_s f_y (d - a/2)$, (5) apply strength reduction factor $\phi = 0.90$ to obtain design moment capacity $\phi M_n$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Whitney Stress Block Depth $a$, Neutral Axis Depth $c$, Internal Lever Arm $d - a/2$, Design Moment Capacity $\phi M_n$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.85 (or Eighty-Five Percent). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating design moment capacity: A singly reinforced rectangular beam has width $b = 300\text{ mm}$, effective depth $d = 500\text{ mm}$, concrete compressive strength $f_c' = 25\text{ MPa}$ ($\beta_1 = 0.85$), and steel yield strength $f_y = 400\text{ MPa}$. The tension reinforcement consists of $3 \times \Phi 25\text{ mm}$ rebars ($A_s = 3 \times 490.9 = 1472.7\text{ mm}^2 \approx 1473\text{ mm}^2$). What is the equivalent rectangular stress block depth $a$ and the design flexural moment capacity $\phi M_n$ ($\phi = 0.90$)? ($a = \frac{A_s f_y}{0.85 f_c' b} = \frac{1472.7 \times 400}{0.85 \times 25 \times 300} = \frac{589080}{6375} = \mathbf{92.40\text{ mm} \approx 92.4\text{ mm}}$; Lever arm $= d - \frac{a}{2} = 500 - \frac{92.40}{2} = 500 - 46.20 = \mathbf{453.80\text{ mm}}$; $M_n = A_s f_y (d - a/2) = (1472.7\text{ mm}^2) \times (400\text{ MPa}) \times (453.80\text{ mm}) = 589080 \times 453.80 = 267,324,504\text{ N}\cdot\text{mm} = \mathbf{267.32\text{ kN}\cdot\text{m}}$; $\phi M_n = 0.90 \times 267.32\text{ kN}\cdot\text{m} = \mathbf{240.59\text{ kN}\cdot\text{m} \approx 240.6\text{ kN}\cdot\text{m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rcc_beam_whitney_stress_block_and_flexural_capacity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Whitney Stress Block \\& RCC Flexural Capacity (Charles Whitney)**\n• **Internal Force Equilibrium ($C = T$):**\n$$\n\\mathbf{C = 0.85 f_c' \\cdot a \\cdot b \\quad \\Big| \\quad T = A_s f_y \\implies \\mathbf{a = \\frac{A_s f_y}{0.85 f_c' b}}}\n$$\n• **Neutral Axis Depth ($c$) Formulation:**\n$$\n\\mathbf{c = \\frac{a}{\\beta_1} \\quad (\\beta_1 = 0.85 \\text{ for } f_c' \\le 28\\text{ MPa} \\ / \\ 4000\\text{ psi})}\n$$\n• **Nominal \\& Design Flexural Moment Capacity:**\n$$\n\\mathbf{M_n = A_s f_y \\left( d - \\frac{a}{2} \\right) \\implies \\mathbf{\\phi M_n = \\phi A_s f_y \\left( d - \\frac{a}{2} \\right) \\ge M_u \\quad (\\phi = 0.90)}}\n$$\n• **The Ductility Invariant:** Sizing reinforcement such that steel yields ($f_s = f_y$) before concrete crushes guarantees **ductile flexural failure**, providing visible warning through flexural cracks and large deflections!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the design flexural moment capacity \u03c6Mn of a singly reinforced concrete beam.",
      "orderItems": [
        "Extract beam cross-section geometry (width b, effective depth d) and material strengths (fc', fy)",
        "Calculate the total tensile reinforcement cross-sectional steel area (As = n * \u03c0*db^2 / 4)",
        "Equate compression to tension (C = T) to solve the Whitney stress block depth: a = (As * fy) / (0.85 * fc' * b)",
        "Compute the internal flexural lever arm: jd = (d - a/2) between tension steel and compression concrete",
        "Calculate nominal capacity Mn = As * fy * (d - a/2) and multiply by \u03c6 = 0.90 to obtain design moment capacity \u03c6Mn"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Reinforced Concrete Flexural Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Whitney Stress Block Depth (a)", "right": "a = (As * fy) / (0.85 * fc' * b), equivalent rectangular compressive stress zone depth" },
        { "left": "Neutral Axis Depth (c)", "right": "c = a / \u03b21, physical boundary separating compressive and tensile concrete strains" },
        { "left": "Internal Lever Arm (d - a/2)", "right": "Distance between the tensile steel centroid and the centroid of the concrete compressive block" },
        { "left": "Strength Reduction Factor (\u03c6 = 0.90)", "right": "Safety multiplier for tension-controlled ductile sections providing ample warning before failure" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Whitney equivalent stress block, the magnitude of the uniform concrete compressive stress is taken as exactly ___ times f'c.",
      "blankAnswer": "0.85",
      "blankDistractors": ["0.65", "1.00", "0.50"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A singly reinforced rectangular beam has width b = 300 mm, effective depth d = 500 mm, concrete strength fc' = 25 MPa (\u03b21 = 0.85), and steel yield strength fy = 400 MPa. Tension reinforcement is As = 1473 mm^2 (3 \u03a625 bars). What is the Whitney stress block depth a and the design moment capacity \u03c6Mn (\u03c6 = 0.90)?",
      "options": [
        { "text": "a = 92.4 mm and \u03c6Mn = 240.6 kNm (a = (1473 * 400) / (0.85 * 25 * 300) = 589200 / 6375 = 92.42 mm; Mn = 1473 * 400 * (500 - 92.42/2) * 10^-6 = 267.37 kNm; \u03c6Mn = 0.90 * 267.37 = 240.63 kNm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using ACI 318-19 / Wight-MacGregor flexural limit state equations (James K. Wight *Reinforced Concrete: Mechanics and Design* Chapter 4). 1. **Calculate Whitney Stress Block Depth ($a$):** - Internal tensile force: $$T = A_s f_y = 1473\\text{ mm}^2 \\times 400\\text{ MPa} = \\mathbf{589,200\\text{ N} = 589.2\\text{ kN}}$$ - Internal compressive force: $$C = 0.85 f_c' \\cdot a \\cdot b = 0.85 \\times 25\\text{ MPa} \\times 300\\text{ mm} \\times a = 6375 \\cdot a\\text{ N}$$ - Equate $C = T$: $$6375 \\cdot a = 589,200 \\implies a = \\frac{589,200}{6375} = \\mathbf{92.4235\\text{ mm} \\approx 92.4\\text{ mm}}$$ 2. **Check Neutral Axis Depth ($c$) and Ductility:** $$c = \\frac{a}{\\beta_1} = \\frac{92.4235\\text{ mm}}{0.85} = \\mathbf{108.73\\text{ mm}}$$ - Extreme tensile steel strain: $$\\epsilon_t = 0.003 \\left(\\frac{d - c}{c}\\right) = 0.003 \\left(\\frac{500 - 108.73}{108.73}\\right) = 0.003 \\times 3.5985 = \\mathbf{0.0108}$$ - Since $\\epsilon_t = 0.0108 \\ge 0.005$, the section is **fully tension-controlled**, confirming $\\mathbf{\\phi = 0.90}$! 3. **Calculate Nominal Moment Capacity ($M_n$):** $$M_n = A_s f_y \\left(d - \\frac{a}{2}\\right) = 589,200\\text{ N} \\times \\left(500\\text{ mm} - \\frac{92.4235\\text{ mm}}{2}\\right)$$ $$M_n = 589,200\\text{ N} \\times (500 - 46.212\\text{ mm}) = 589,200 \\times 453.788\\text{ mm} = 267,372,000\\text{ N}\\cdot\\text{mm} = \\mathbf{267.37\\text{ kN}\\cdot\\text{m}}$$ 4. **Calculate Design Flexural Capacity ($\\phi M_n$):** $$\\phi M_n = 0.90 \\times 267.372\\text{ kN}\\cdot\\text{m} = \\mathbf{240.635\\text{ kN}\\cdot\\text{m} \\approx 240.6\\text{ kN}\\cdot\\text{m}}$$ Flawless RCC flexural capacity derivation!" },
        { "text": "a = 46.2 mm and \u03c6Mn = 267.4 kNm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "a = 92.4 mm and \u03c6Mn = 180.5 kNm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "a = 150.0 mm and \u03c6Mn = 240.6 kNm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
