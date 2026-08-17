# Duofy Reusable Lesson Format: Deep Piles (Axial Capacity, Alpha & Beta Methods)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Shallow_and_Deep_Foundations`  
**Lesson Format Type:** `deep_foundation_pile_capacity_alpha_and_beta_methods`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the geotechnical axial load capacity of single driven and bored piles, calculating total ultimate resistance as the sum of base end-bearing ($Q_p = q_p A_p$) and perimeter shaft skin friction ($Q_s = \sum f_s A_s$), applying the **Total Stress $\alpha$-Method** in saturated cohesive clays, and the **Effective Stress $\beta$-Method** in cohesionless sands and gravels (Braja M. Das *Principles of Foundation Engineering* 9th ed. Chapter 9; Joseph E. Bowles *Foundation Analysis and Design* Chapter 16): formulate the **Total Ultimate Pile Capacity Equation**:
$$\mathbf{Q_u = Q_p + Q_s = q_p \cdot A_p + \sum_{i=1}^M f_{s,i} \cdot A_{s,i}}$$
derive the **Cohesive Clay $\alpha$-Method Formulations**:
1. **Tip End-Bearing ($Q_p$):**
   $$\mathbf{q_p = c_u N_c^* = 9 c_u \implies \mathbf{Q_p = 9 c_u A_p \quad (\text{Deep Bearing Factor } N_c^* = 9.0)}}$$
2. **Shaft Skin Friction ($Q_s$):**
   $$\mathbf{f_s = \alpha \cdot c_u \implies \mathbf{Q_s = \sum \alpha c_u \left( \pi D L \right)} \quad (\alpha = \text{Adhesion Factor } \le 1.0)}$$
derive the **Cohesionless Sand $\beta$-Method Formulations**:
1. **Shaft Friction ($f_s$):**
   $$\mathbf{f_s = \beta \cdot \sigma_v' = K \cdot \sigma_v' \cdot \tan\delta \quad (\beta = \text{Burland Parameter}, \ \delta \approx 0.8\phi')}$$
2. **Tip Resistance ($q_p$):**
   $$\mathbf{q_p = \sigma_v' N_q^* \le q_l \quad (q_l = \text{Limiting Unit Tip Resistance})}$$
derive the **Allowable Design Pile Capacity ($Q_{\text{all}}$)**:
$$\mathbf{Q_{\text{all}} = \frac{Q_u}{FS} = \frac{Q_p + Q_s}{FS} \quad (\text{With } FS = 2.5 - 3.0)}$$
(proving how pile skin friction mobilizes at very small settlements $\approx 5-10\text{ mm}$, whereas full tip bearing requires settlements of $10-15\%$ of the pile diameter).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Pile Capacity ($Q_u = 9c_u A_p + \sum \alpha c_u A_s$), $\beta$-Method & $Q_{\text{all}} = Q_u/FS$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Ultimate Axial Capacity of a Driven Concrete Pile in Clay Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pile Capacity Component / Soil Method & Technical Physical Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Cohesive Soil Pile Design, the Deep Foundation Bearing Capacity Factor $N_c^*$ for Tip Resistance Equals Exactly ___ (9 / Nine) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Deep Foundation Problem: Calculating Total Axial Capacity Q_u for a 15m Long 0.4m Diameter Pile in Clay Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Deep Foundation Pile Capacity (Das 2019; Bowles 1996):
   - **Pile Capacity Formulations:**
     $$\mathbf{Q_u = Q_p + Q_s \quad \Big| \quad \text{Clay: } Q_u = 9 c_u A_p + \sum \alpha c_u A_s \quad \Big| \quad \text{Sand: } Q_u = q' N_q^* A_p + \sum \beta \sigma_v' A_s}$$
   - **Method Selection Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Soil Stratum Type} & \textbf{Analysis Method} & \textbf{Shaft Resistance } f_s & \textbf{End-Bearing Resistance } q_p \\
     \hline
     \mathbf{\text{Saturated Clay}} & \mathbf{\alpha\text{-Method (Total Stress)}} & \mathbf{f_s = \alpha c_u \ (\alpha \approx 0.45 - 0.90)} & \mathbf{q_p = 9 c_u \ (N_c^* = 9.0)} \\
     \mathbf{\text{Cohesionless Sand}} & \mathbf{\beta\text{-Method (Effective Stress)}} & \mathbf{f_s = \beta \sigma_v' = K \sigma_v' \tan\delta} & \mathbf{q_p = \sigma_v' N_q^* \le q_l} \\
     \text{Mixed / General Soil} & \lambda\text{-Method} & f_s = \lambda (\bar{\sigma}_v' + 2\bar{c}_u) & q_p = 9 c_u \text{ or } \sigma_v' N_q^* \\
     \hline
     \end{array}$$
   - **The Mobilization Invariant:** Shaft skin friction $Q_s$ reaches full capacity at minuscule displacements (**$2-6\text{ mm}$**), while end-bearing $Q_p$ mobilizes slowly, requiring **$25-50\text{ mm}$ of settlement**!
2. **Slide 2 (`ordering`):** Provide 5 steps of pile design: (1) determine pile geometry: diameter $D$, length $L$, perimeter $p = \pi D$, and base area $A_p = \pi D^2 / 4$, (2) calculate undrained shear strength $c_u$ at pile tip to evaluate end bearing: $Q_p = 9 c_u A_p$, (3) extract adhesion factor $\alpha$ along shaft embedment layers, (4) integrate shaft skin friction: $Q_s = \sum \alpha c_u (\pi D L)$, (5) sum total ultimate capacity $Q_u = Q_p + Q_s$ and divide by $FS = 2.5$ or $3.0$ to get allowable capacity $Q_{\text{all}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Clay End-Bearing $9 c_u A_p$, Alpha Adhesion Factor, Beta Method Parameter, Limiting Tip Resistance $q_l$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 9 (or Nine). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating pile capacity in clay: A circular concrete pile ($D = 0.40\text{ m}, L = 15.0\text{ m}$) is driven into a uniform saturated clay layer with undrained shear strength $c_u = 50.0\text{ kPa}$. The adhesion factor is $\alpha = 0.60$.
   - Pile base area: $A_p = \frac{\pi (0.40)^2}{4} = \mathbf{0.12566\text{ m}^2}$;
   - Pile shaft perimeter: $p = \pi (0.40) = \mathbf{1.2566\text{ m}}$;
   - Shaft surface area: $A_s = p \times L = 1.2566 \times 15.0 = \mathbf{18.8496\text{ m}^2}$;
   - End-bearing capacity: $Q_p = 9 c_u A_p = 9 \times (50.0\text{ kPa}) \times (0.12566\text{ m}^2) = 450.0 \times 0.12566 = \mathbf{56.55\text{ kN}}$;
   - Shaft friction capacity: $Q_s = \alpha c_u A_s = 0.60 \times (50.0\text{ kPa}) \times (18.8496\text{ m}^2) = 30.0 \times 18.8496 = \mathbf{565.49\text{ kN}}$;
   - Total ultimate capacity: $Q_u = Q_p + Q_s = 56.55 + 565.49 = \mathbf{622.04\text{ kN} \approx 622\text{ kN}}$;
   - What is the total ultimate axial capacity $Q_u$ and the allowable capacity $Q_{\text{all}}$ for $FS = 2.5$? ($Q_u = \mathbf{622.0\text{ kN}}$ and $Q_{\text{all}} = \frac{622.04}{2.5} = \mathbf{248.8\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "deep_foundation_pile_capacity_alpha_and_beta_methods",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Deep Foundation Single Pile Capacity (Braja M. Das)**\n• **Total Ultimate Axial Pile Capacity Formulation:**\n$$\n\\mathbf{Q_u = Q_p + Q_s = q_p \\cdot A_p + \\sum_{i=1}^M f_{s,i} \\cdot A_{s,i}}\n$$\n• **Cohesive Soils ($\\alpha$-Method Total Stress Analysis):**\n$$\n\\mathbf{Q_p = 9 c_u \\cdot A_p \\quad (N_c^* = 9.0) \\quad \\Big| \\quad \\mathbf{Q_s = \\sum \\alpha \\cdot c_u \\cdot (\\pi D L)}}\n$$\n  - **$\\alpha$:** Soil-pile adhesion factor ($0.4 \\le \\alpha \\le 0.9$ based on $c_u / p_a$);\n• **Cohesionless Soils ($\\beta$-Method Effective Stress Analysis):**\n$$\n\\mathbf{f_s = \\beta \\cdot \\sigma_v' = K \\cdot \\sigma_v' \\cdot \\tan\\delta \\quad \\Big| \\quad q_p = \\sigma_v' N_q^* \\le q_l}\n$$\n• **Allowable Design Capacity:** $\\mathbf{Q_{\\text{all}} = \\frac{Q_u}{FS} = \\frac{Q_p + Q_s}{FS} \\quad (FS = 2.5 \\text{ to } 3.0)}$\n• **The Mobilization Gap Invariant:** Shaft skin friction $Q_s$ mobilizes at tiny elastic displacements ($2-5\\text{ mm}$), carrying the entire service working load, whereas end-bearing $Q_p$ acts as the ultimate plastic safety reserve!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the ultimate and allowable axial capacity of a single driven pile in cohesive clay.",
      "orderItems": [
        "Determine the pile geometric dimensions: diameter D, embedded length L, cross-sectional tip area Ap, and shaft perimeter p",
        "Calculate the end-bearing resistance at the pile tip using deep bearing factor Nc* = 9.0: Qp = 9 * cu * Ap",
        "Determine the adhesion factor \u03b1 from empirical charts matching the undrained shear strength cu along the shaft",
        "Integrate the unit shaft skin friction along the embedment depth: Qs = \u2211 (\u03b1 * cu * \u03c0 * D * \u0394L)",
        "Sum the tip and shaft capacities to find total ultimate capacity Qu = Qp + Qs and divide by factor of safety FS = 2.5 to find Q_all"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Deep Foundation Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Deep Tip Factor (Nc* = 9.0)", "right": "Ultimate end-bearing capacity multiplier for deeply embedded foundations in saturated clay" },
        { "left": "Adhesion Factor (\u03b1)", "right": "Empirical reduction coefficient relating pile shaft skin friction to undrained shear strength (fs = \u03b1*cu)" },
        { "left": "Beta Factor (\u03b2 = K*tan\u03b4)", "right": "Effective stress friction parameter combining lateral earth pressure K and interface friction angle \u03b4" },
        { "left": "Limiting Tip Resistance (ql)", "right": "Upper bound threshold capping sand end-bearing capacity at deep penetration depths" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In cohesive soil deep pile foundation design, the bearing capacity factor Nc* for tip end-bearing resistance equals exactly ___.",
      "blankAnswer": "9",
      "blankDistractors": ["5.7", "1.0", "3.0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A circular concrete pile (D = 0.40 m, L = 15.0 m, Ap = 0.1257 m^2, p = 1.257 m) is driven into saturated clay with cu = 50.0 kPa and \u03b1 = 0.60. Tip bearing is Qp = 9*50*0.1257 = 56.6 kN and shaft friction is Qs = 0.60*50*(1.257*15) = 565.5 kN. What is the total ultimate capacity Qu and allowable capacity Q_all (FS = 2.5)?",
      "options": [
        { "text": "Qu = 622.1 kN and Q_all = 248.8 kN (Qu = Qp + Qs = 56.55 + 565.49 = 622.04 kN; Q_all = 622.04 / 2.5 = 248.82 kN)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the $\\alpha$-method for deep piles in cohesive clay (Braja M. Das *Principles of Foundation Engineering* Chapter 9). 1. **Calculate Pile Cross-Sectional Geometry:** - Pile diameter: $D = 0.40\\text{ m}$. - Pile embedded length: $L = 15.0\\text{ m}$. - Tip cross-sectional area: $$A_p = \\frac{\\pi D^2}{4} = \\frac{\\pi \\times (0.40\\text{ m})^2}{4} = \\mathbf{0.125664\\text{ m}^2}$$ - Shaft perimeter: $$p = \\pi D = \\pi \\times 0.40\\text{ m} = \\mathbf{1.256637\\text{ m}}$$ - Total shaft surface area: $$A_s = p \\times L = 1.256637\\text{ m} \\times 15.0\\text{ m} = \\mathbf{18.849556\\text{ m}^2}$$ 2. **Calculate End-Bearing Tip Resistance ($Q_p$):** - Deep clay bearing factor: $N_c^* = 9.0$. $$Q_p = q_p \\cdot A_p = (9 \\cdot c_u) \\cdot A_p = 9 \\times (50.0\\text{ kPa}) \\times 0.125664\\text{ m}^2 = 450.0 \\times 0.125664 = \\mathbf{56.549\\text{ kN}}$$ 3. **Calculate Shaft Skin Friction Resistance ($Q_s$):** - Unit skin friction: $f_s = \\alpha \\cdot c_u = 0.60 \\times 50.0\\text{ kPa} = \\mathbf{30.0\\text{ kPa}}$. $$Q_s = f_s \\cdot A_s = (30.0\\text{ kPa}) \\times 18.849556\\text{ m}^2 = \\mathbf{565.487\\text{ kN}}$$ 4. **Calculate Total Ultimate Axial Capacity ($Q_u$):** $$Q_u = Q_p + Q_s = 56.549\\text{ kN} + 565.487\\text{ kN} = \\mathbf{622.036\\text{ kN} \\approx 622.1\\text{ kN}}$$ 5. **Calculate Allowable Working Load ($Q_{\\text{all}}$) with $FS = 2.5$:** $$Q_{\\text{all}} = \\frac{Q_u}{FS} = \\frac{622.036\\text{ kN}}{2.5} = \\mathbf{248.814\\text{ kN} \\approx 248.8\\text{ kN}}$$ Flawless deep foundation pile capacity derivation!" },
        { "text": "Qu = 622.1 kN and Q_all = 622.1 kN (Forgot factor of safety)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Qu = 565.5 kN and Q_all = 226.2 kN (Ignored tip bearing)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Qu = 113.1 kN and Q_all = 45.2 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
