# Duofy Reusable Lesson Format: Foundation Capacity (Meyerhof General Equation & Factors)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Shallow_and_Deep_Foundations`  
**Lesson Format Type:** `meyerhof_general_bearing_capacity_equation_and_depth_factors`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through G. G. Meyerhof's 1963 **General Bearing Capacity Equation**, extending Terzaghi's theory to incorporate shearing resistance of the soil above the foundation embedment level, shape correction factors ($s_c, s_q, s_\gamma$), embedment depth factors ($d_c, d_q, d_\gamma$), load inclination factors ($i_c, i_q, i_\gamma$), and groundwater table corrections ($\gamma'$ modifications) (Braja M. Das *Principles of Foundation Engineering* 9th ed. Chapter 4; Joseph E. Bowles *Foundation Analysis and Design* Chapter 4): formulate the **Meyerhof General Bearing Capacity Master Formulation**:
$$\mathbf{q_u = c' N_c \left( s_c d_c i_c \right) + q N_q \left( s_q d_q i_q \right) + \frac{1}{2} \gamma B N_\gamma \left( s_\gamma d_\gamma i_\gamma \right)}$$
where:
1. **Meyerhof Bearing Capacity Factors ($N_c, N_q, N_\gamma$):**
   $$\mathbf{N_q = \tan^2\left( 45^\circ + \frac{\phi'}{2} \right) e^{\pi \tan\phi'} \quad \Big| \quad N_c = (N_q - 1) \cot\phi' \quad \Big| \quad N_\gamma = 2 (N_q + 1) \tan\phi'}$$
2. **Shape Factors ($s$):**
   $$\mathbf{s_c = 1 + \left(\frac{B}{L}\right)\left(\frac{N_q}{N_c}\right) \quad \Big| \quad s_q = 1 + \left(\frac{B}{L}\right)\tan\phi' \quad \Big| \quad s_\gamma = 1 - 0.4\left(\frac{B}{L}\right)}$$
3. **Depth Factors ($d$ for $D_f / B \le 1.0$):**
   $$\mathbf{d_c = 1 + 0.4 \left(\frac{D_f}{B}\right) \quad \Big| \quad d_q = 1 + 2 \tan\phi'(1 - \sin\phi')^2 \left(\frac{D_f}{B}\right) \quad \Big| \quad d_\gamma = 1.0}$$
master the **Groundwater Table Submersion Rules**:
- **Case 1 ($d_w \le D_f$):** $q = \gamma d_w + \gamma'(D_f - d_w)$, and use $\gamma = \gamma'$ in the 3rd term;
- **Case 2 ($D_f < d_w \le D_f + B$):** $q = \gamma D_f$, and use weighted $\bar{\gamma} = \gamma' + \frac{d_w - D_f}{B}(\gamma - \gamma')$ in the 3rd term.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Meyerhof General Equation ($q_u = c' N_c s_c d_c i_c + q N_q s_q d_q i_q + 0.5 \gamma B N_\gamma s_\gamma d_\gamma i_\gamma$) & GWT Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Meyerhof Bearing Capacity for a Rectangular Footing with Water Table Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Meyerhof Correction Factor / Water Table Case & Technical Geotechnical Effect Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Meyerhof's General Bearing Capacity Equation, the Depth Factor $d_\gamma$ for the Soil Weight Term Is Mathematically Taken as Exactly ___ (1.0 / One) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Foundation Design Problem: Sizing Ultimate Bearing Capacity q_u for a 1.5m x 3.0m Rectangular Footing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Meyerhof General Bearing Capacity (Meyerhof 1963; Das 2019):
   - **General Formulations:**
     $$\mathbf{q_u = c' N_c s_c d_c i_c + q N_q s_q d_q i_q + \frac{1}{2} \gamma B N_\gamma s_\gamma d_\gamma i_\gamma \quad \Big| \quad N_q = e^{\pi\tan\phi'}\tan^2(45^\circ+\phi'/2)}$$
   - **Correction Factors Matrix ($D_f/B \le 1.0$, Vertical Load $i=1.0$):**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Term Component} & \textbf{Shape Factor } s & \textbf{Depth Factor } d & \textbf{Physical Correction Role} \\
     \hline
     \mathbf{\text{Cohesion } (c')} & s_c = 1 + (B/L)(N_q/N_c) & d_c = 1 + 0.4(D_f/B) & \text{3D shearing along 4 sides + embedment shear} \\
     \mathbf{\text{Surcharge } (q)} & s_q = 1 + (B/L)\tan\phi' & d_q = 1 + 2\tan\phi'(1-\sin\phi')^2(D_f/B) & \text{Confining surcharge enhancement with depth} \\
     \mathbf{\text{Soil Weight } (\gamma)} & s_\gamma = 1 - 0.4(B/L) & \mathbf{d_\gamma = 1.0 \ (\text{Constant})} & \text{Reduction in wedge weight for rectangular aspect} \\
     \hline
     \end{array}$$
   - **The Prandtl Factor Invariant:** Meyerhof's formulation captures the **shearing resistance of the soil above the base level ($D_f$)**, providing a more realistic and slightly higher capacity than Terzaghi's idealized surface surcharge model!
2. **Slide 2 (`ordering`):** Provide 5 steps of Meyerhof analysis: (1) extract footing dimensions ($B, L, D_f$) and soil properties ($c', \phi', \gamma, \gamma_{\text{sat}}$), (2) check water table depth $d_w$ and adjust effective surcharge $q$ and base unit weight $\gamma$, (3) compute Meyerhof bearing factors $N_c, N_q, N_\gamma$, (4) compute shape factors ($s_c, s_q, s_\gamma$) and depth factors ($d_c, d_q, d_\gamma$), (5) multiply each tri-term product and sum to evaluate ultimate bearing capacity $q_u$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Shape Factor $s_c$, Depth Factor $d_c$, Depth Factor $d_\gamma = 1.0$, Water Table Case 1) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 1.0 (or One). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Meyerhof capacity: A rectangular footing ($B = 1.50\text{ m}, L = 3.00\text{ m}, D_f = 1.50\text{ m}$) is founded in a cohesionless sand ($c' = 0, \phi' = 30^\circ, \gamma = 18.0\text{ kN/m}^3$) with no groundwater. For $\phi' = 30^\circ$: $N_q = 18.40, \ N_\gamma = 15.67$.
   - Surcharge: $q = \gamma D_f = 18.0 \times 1.50 = 27.0\text{ kPa}$;
   - Ratio $B/L = 1.50 / 3.00 = 0.50$; $D_f / B = 1.50 / 1.50 = 1.00$;
   - Shape factors: $s_q = 1 + (0.50)\tan(30^\circ) = 1 + 0.50(0.5774) = \mathbf{1.2887}$; $s_\gamma = 1 - 0.4(0.50) = \mathbf{0.800}$;
   - Depth factors: $d_q = 1 + 2\tan(30^\circ)(1 - \sin 30^\circ)^2 (1.00) = 1 + 2(0.57735)(0.50)^2 = 1 + 0.2887 = \mathbf{1.2887}$; $d_\gamma = \mathbf{1.00}$;
   - Surcharge term: $q N_q s_q d_q = 27.0 \times 18.40 \times 1.2887 \times 1.2887 = 496.8 \times 1.6607 = \mathbf{825.04\text{ kPa}}$;
   - Soil weight term: $0.5 \gamma B N_\gamma s_\gamma d_\gamma = 0.5 \times 18.0 \times 1.50 \times 15.67 \times 0.80 \times 1.00 = 211.545 \times 0.80 = \mathbf{169.24\text{ kPa}}$;
   - Total $q_u = 825.04 + 169.24 = \mathbf{994.28\text{ kPa} \approx 994.3\text{ kPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "meyerhof_general_bearing_capacity_equation_and_depth_factors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Meyerhof General Bearing Capacity (G. G. Meyerhof 1963)**\n• **General Ultimate Bearing Capacity Master Formulation:**\n$$\n\\mathbf{q_u = c' N_c \\left( s_c d_c i_c \\right) + q N_q \\left( s_q d_q i_q \\right) + \\frac{1}{2} \\gamma B N_\\gamma \\left( s_\\gamma d_\\gamma i_\\gamma \\right)}\n$$\n  - **$s_c, s_q, s_\\gamma$:** Footing shape modification factors ($B/L$ aspect);\n  - **$d_c, d_q, d_\\gamma$:** Embedment depth enhancement factors ($D_f/B$ ratio);\n  - **$i_c, i_q, i_\\gamma$:** Load inclination reduction factors;\n• **Key Shape \\& Depth Factor Formulas ($D_f / B \\le 1.0$):**\n$$\n\\mathbf{s_q = 1 + \\left(\\frac{B}{L}\\right) \\tan\\phi' \\quad \\Big| \\quad s_\\gamma = 1 - 0.4 \\left(\\frac{B}{L}\\right) \\quad \\Big| \\quad \\mathbf{d_\\gamma = 1.0}}\n$$\n$$\n\\mathbf{d_q = 1 + 2 \\tan\\phi' (1 - \\sin\\phi')^2 \\left(\\frac{D_f}{B}\\right)}\n$$\n• **The Embedment Shear Invariant:** Meyerhof explicitly accounts for the **shearing strength of the soil above the base level ($D_f$)**, providing higher and more accurate bearing estimates than Terzaghi's surface surcharge model!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the ultimate bearing capacity of a rectangular footing using Meyerhof's General Equation.",
      "orderItems": [
        "Extract footing dimensions (width B, length L, depth Df) and soil parameters (c', \u03c6', \u03b3)",
        "Check groundwater table location to determine adjusted effective surcharge (q) and base unit weight (\u03b3)",
        "Look up Meyerhof bearing capacity factors (Nc, Nq, N\u03b3) corresponding to friction angle \u03c6'",
        "Calculate the 3D shape factors (sc, sq, s\u03b3) and embedment depth factors (dc, dq, d\u03b3 = 1.0)",
        "Multiply each tri-term product (c'*Nc*sc*dc, q*Nq*sq*dq, 0.5*\u03b3*B*N\u03b3*s\u03b3*d\u03b3) and sum to obtain ultimate bearing capacity qu"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Meyerhof Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Shape Factor (sq)", "right": "sq = 1 + (B/L)*tan\u03c6', accounting for 3D circumferential shear resistance on rectangular perimeters" },
        { "left": "Depth Factor (dq)", "right": "dq = 1 + 2*tan\u03c6'*(1-sin\u03c6')^2*(Df/B), increasing surcharge confinement due to embedment" },
        { "left": "Depth Factor (d\u03b3 = 1.0)", "right": "Constant unity multiplier for the soil self-weight term regardless of foundation depth" },
        { "left": "Water Table Case 1 (dw \u2264 Df)", "right": "Submerged condition requiring buoyant unit weight \u03b3' in both surcharge and base wedge terms" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Meyerhof's General Bearing Capacity Equation, the depth factor d_\u03b3 for the soil weight term is mathematically taken as exactly ___.",
      "blankAnswer": "1.0",
      "blankDistractors": ["1.3", "0.4", "0.5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular footing (B = 1.50 m, L = 3.00 m, Df = 1.50 m) is placed in dry sand (c' = 0, \u03c6' = 30\u00b0, \u03b3 = 18.0 kN/m^3, Nq = 18.40, N\u03b3 = 15.67). Surcharge is q = 27.0 kPa. Calculated factors: sq = 1.2887, s\u03b3 = 0.800, dq = 1.2887, d\u03b3 = 1.00. Surcharge term is 825.0 kPa and soil weight term is 169.2 kPa. What is the ultimate bearing capacity qu?",
      "options": [
        { "text": "qu = 994.3 kPa (qu = q*Nq*sq*dq + 0.5*\u03b3*B*N\u03b3*s\u03b3*d\u03b3 = 825.04 + 169.24 = 994.28 kPa)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Meyerhof's General Bearing Capacity Equation for cohesionless soil (Braja M. Das *Principles of Foundation Engineering* Chapter 4). 1. **Identify Given Geometry \\& Soil Parameters:** - $B = 1.50\\text{ m}, \\quad L = 3.00\\text{ m} \\implies \\frac{B}{L} = 0.50$ - $D_f = 1.50\\text{ m} \\implies \\frac{D_f}{B} = 1.00$ - Cohesion: $c' = 0$ (cohesion term vanishes: $c' N_c s_c d_c = 0$). - Surcharge: $q = \\gamma D_f = 18.0\\text{ kN/m}^3 \\times 1.50\\text{ m} = \\mathbf{27.0\\text{ kPa}}$. 2. **Calculate Surcharge Overburden Term ($q N_q s_q d_q$):** - Factors: $N_q = 18.40, \\quad s_q = 1.2887, \\quad d_q = 1.2887$. $$q N_q s_q d_q = (27.0\\text{ kPa}) \\times 18.40 \\times 1.2887 \\times 1.2887 = 496.80 \\times 1.66074 = \\mathbf{825.04\\text{ kPa}}$$ 3. **Calculate Soil Weight Wedge Term ($0.5 \\gamma B N_\\gamma s_\\gamma d_\\gamma$):** - Factors: $N_\\gamma = 15.67, \\quad s_\\gamma = 0.800, \\quad d_\\gamma = 1.00$. $$0.5 \\gamma B N_\\gamma s_\\gamma d_\\gamma = 0.5 \\times (18.0\\text{ kN/m}^3) \\times (1.50\\text{ m}) \\times 15.67 \\times 0.800 \\times 1.00$$ $$0.5 \\gamma B N_\\gamma s_\\gamma d_\\gamma = 13.50 \\times 15.67 \\times 0.800 = 211.545 \\times 0.800 = \\mathbf{169.24\\text{ kPa}}$$ 4. **Sum Total Ultimate Bearing Capacity ($q_u$):** $$q_u = 0 + 825.04\\text{ kPa} + 169.24\\text{ kPa} = \\mathbf{994.28\\text{ kPa} \\approx 994.3\\text{ kPa}}$$ Flawless Meyerhof general bearing capacity derivation!" },
        { "text": "qu = 825.0 kPa (Omitted soil self-weight term)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "qu = 1450.0 kPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "qu = 994.3 kPa with allowable load = 331.4 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
