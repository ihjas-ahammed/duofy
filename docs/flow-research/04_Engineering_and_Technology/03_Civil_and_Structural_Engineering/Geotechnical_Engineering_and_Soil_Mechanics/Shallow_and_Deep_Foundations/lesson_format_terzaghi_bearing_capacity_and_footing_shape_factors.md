# Duofy Reusable Lesson Format: Shallow Footings (Terzaghi Bearing Capacity & Geometry)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Shallow_and_Deep_Foundations`  
**Lesson Format Type:** `terzaghi_bearing_capacity_and_footing_shape_factors`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Karl Terzaghi's 1943 classical **Ultimate Bearing Capacity Theory** for shallow spread foundations ($D_f \le B$), general shear failure zones (Zone I active elastic wedge, Zone II radial Prandtl log-spiral shear, Zone III passive linear Rankine wedge), surcharge overburden pressure ($q = \gamma D_f$), bearing capacity factors ($N_c, N_q, N_\gamma$), footing geometry modification factors (strip, square, circular), and the calculation of allowable soil pressure ($q_{\text{all}} = q_u / FS$) (Braja M. Das *Principles of Foundation Engineering* 9th ed. Chapter 3; Karl Terzaghi *Theoretical Soil Mechanics* Chapter 8): formulate the **Terzaghi Ultimate Bearing Capacity Equations**:
1. **Continuous Strip Footing ($L \gg B$):**
   $$\mathbf{q_u = c' N_c + q N_q + \frac{1}{2} \gamma B N_\gamma \quad (q = \gamma D_f)}$$
2. **Square Footing ($B \times B$):**
   $$\mathbf{q_u = 1.3 c' N_c + q N_q + 0.4 \gamma B N_\gamma}$$
3. **Circular Footing ($\text{Diameter } B$):**
   $$\mathbf{q_u = 1.3 c' N_c + q N_q + 0.3 \gamma B N_\gamma}$$
master the **Undrained Saturated Clay Boundary Case ($\mathbf{\phi_u = 0^\circ}$)**:
- $N_c = 5.7, \ N_q = 1.0, \ N_\gamma = 0$:
  $$\mathbf{q_u = 5.7 c_u + \gamma D_f \quad (\text{Strip}) \quad \Big| \quad \mathbf{q_u = 1.3(5.7) c_u + \gamma D_f = 7.41 c_u + \gamma D_f \quad (\text{Square})}}$$
derive the **Allowable Foundation Load ($Q_{\text{all}}$)**:
$$\mathbf{q_{\text{all}} = \frac{q_u}{FS} \quad (FS = 3.0 \text{ standard}) \implies \mathbf{Q_{\text{all}} = q_{\text{all}} \cdot A_{\text{footing}}}}$$
(proving that soil bearing capacity is a non-linear superposition of cohesion shear resistance, surcharge confinement, and soil self-weight).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Terzaghi Master Formulas (Strip, Square, Circular), $N_c, N_q, N_\gamma$ & $q_{\text{all}} = q_u/3$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Ultimate and Allowable Load for a Square Spread Footing Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Bearing Capacity Component / Factor & Technical Geotechnical Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | For a Strip Footing on Saturated Clay with Undrained Friction Angle $\phi_u = 0^\circ$, Terzaghi's Cohesion Bearing Factor $N_c$ Equals Exactly ___ (5.7 / Five Point Seven) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Foundation Engineering Problem: Computing Ultimate Bearing Capacity q_u and Allowable Column Load for a 2m Square Footing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Terzaghi Bearing Capacity (Terzaghi 1943; Das 2019):
   - **Bearing Capacity Formulations:**
     $$\mathbf{q_u = c' N_c s_c + q N_q + \frac{1}{2} \gamma B N_\gamma s_\gamma \quad \Big| \quad q = \gamma D_f \quad \Big| \quad q_{\text{all}} = \frac{q_u}{FS} \quad (FS = 3.0)}$$
   - **Footing Geometry Shape Factor Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Footing Geometry} & \textbf{Cohesion Term Multiplier } s_c & \textbf{Soil Weight Term Multiplier } s_\gamma & \textbf{Ultimate Capacity Formula } q_u \\
     \hline
     \mathbf{\text{Continuous Strip Footing}} & \mathbf{1.0} & \mathbf{1.0 \ (0.5 \gamma B N_\gamma)} & \mathbf{c' N_c + q N_q + 0.5 \gamma B N_\gamma} \\
     \mathbf{\text{Square Footing } (B \times B)} & \mathbf{1.3} & \mathbf{0.8 \ (0.4 \gamma B N_\gamma)} & \mathbf{1.3 c' N_c + q N_q + 0.4 \gamma B N_\gamma} \\
     \mathbf{\text{Circular Footing } (\text{Dia } B)} & \mathbf{1.3} & \mathbf{0.6 \ (0.3 \gamma B N_\gamma)} & \mathbf{1.3 c' N_c + q N_q + 0.3 \gamma B N_\gamma} \\
     \hline
     \end{array}$$
   - **The Surcharge Invariant:** Embedding a footing to depth $D_f$ increases stability exponentially through the surcharge term **$q N_q = (\gamma D_f) N_q$**, which provides confining pressure over the passive failure zone!
2. **Slide 2 (`ordering`):** Provide 5 steps of bearing capacity calculation: (1) extract soil shear parameters ($c', \phi', \gamma$) and footing dimensions ($B, D_f$), (2) look up Terzaghi bearing capacity factors $N_c, N_q, N_\gamma$ corresponding to $\phi'$, (3) compute surcharge overburden pressure at foundation base: $q = \gamma D_f$, (4) evaluate ultimate bearing capacity $q_u$ using appropriate shape multipliers (e.g. $1.3, 1.0, 0.4$ for square), (5) apply factor of safety $FS = 3.0$ to obtain $q_{\text{all}} = q_u / 3.0$ and calculate allowable column load $Q_{\text{all}} = q_{\text{all}} \times B^2$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Cohesion Term $c' N_c$, Surcharge Term $q N_q$, Wedge Weight Term $0.5 \gamma B N_\gamma$, Safety Factor $FS = 3.0$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 5.7 (or Five Point Seven). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating square footing capacity: A square spread footing ($B = 2.0\text{ m} \times 2.0\text{ m}$) is founded at depth $D_f = 1.50\text{ m}$ in a soil with $\gamma = 18.0\text{ kN/m}^3$, effective cohesion $c' = 15.0\text{ kPa}$, and $\phi' = 25^\circ$. Terzaghi factors for $\phi' = 25^\circ$: $N_c = 25.13, \ N_q = 12.72, \ N_\gamma = 8.34$.
   - Surcharge: $q = \gamma D_f = 18.0 \times 1.50 = 27.0\text{ kPa}$;
   - Cohesion term: $1.3 c' N_c = 1.3 \times (15.0) \times (25.13) = 19.5 \times 25.13 = \mathbf{490.04\text{ kPa}}$;
   - Surcharge term: $q N_q = (27.0) \times (12.72) = \mathbf{343.44\text{ kPa}}$;
   - Unit weight term: $0.4 \gamma B N_\gamma = 0.4 \times (18.0) \times (2.0\text{ m}) \times (8.34) = 14.4 \times 8.34 = \mathbf{120.10\text{ kPa}}$;
   - Total $q_u = 490.04 + 343.44 + 120.10 = \mathbf{953.58\text{ kPa} \approx 953.6\text{ kPa}}$;
   - Allowable column load ($FS = 3.0$): $Q_{\text{all}} = \frac{q_u}{3.0} \times B^2 = \frac{953.58}{3.0} \times (4.0\text{ m}^2) = 317.86\text{ kPa} \times 4.0 = \mathbf{1271.4\text{ kN} \approx 1271\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "terzaghi_bearing_capacity_and_footing_shape_factors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Terzaghi Bearing Capacity Theory (Karl Terzaghi 1943)**\n• **Continuous Strip Footing Ultimate Capacity Formulation:**\n$$\n\\mathbf{q_u = c' N_c + q N_q + \\frac{1}{2} \\gamma B N_\\gamma \\quad (q = \\gamma D_f = \\text{Base Surcharge})}\n$$\n• **Shape-Modified Formulations for Spread Footings:**\n  - **Square Footing ($B \\times B$):**\n$$\n\\mathbf{q_u = 1.3 c' N_c + q N_q + 0.4 \\gamma B N_\\gamma}\n$$\n  - **Circular Footing (Diameter $B$):**\n$$\n\\mathbf{q_u = 1.3 c' N_c + q N_q + 0.3 \\gamma B N_\\gamma}\n$$\n• **Undrained Saturated Clay ($\\mathbf{\\phi_u = 0^\\circ \\implies N_c = 5.7, \\ N_q = 1.0, \\ N_\\gamma = 0}$):**\n$$\n\\mathbf{q_u = 5.7 c_u + \\gamma D_f \\quad (\\text{Strip Footing})}\n$$\n• **Allowable Design Capacity:** $\\mathbf{q_{\\text{all}} = \\frac{q_u}{FS} \\quad (FS = 3.0 \\text{ Standard Global Safety Factor})}$\n• **The Surcharge Confinement Invariant:** Embedding the footing base to depth $D_f$ confines the passive shear zone via **$q N_q = (\\gamma D_f) N_q$**, multiplying load resistance several-fold compared to surface footings!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the ultimate bearing capacity and allowable column load for a square shallow spread footing.",
      "orderItems": [
        "Extract soil properties (c', \u03c6', \u03b3), footing width (B), and foundation embedment depth (Df)",
        "Look up Terzaghi bearing capacity factors (Nc, Nq, N\u03b3) corresponding to the soil friction angle \u03c6'",
        "Calculate the surcharge overburden pressure acting at the foundation base level: q = \u03b3 * Df",
        "Compute the ultimate bearing capacity using square shape factors: qu = 1.3*c'*Nc + q*Nq + 0.4*\u03b3*B*N\u03b3",
        "Apply factor of safety FS = 3.0: q_all = qu / 3.0 and multiply by footing area (A = B^2) to obtain allowable load Q_all"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Terzaghi Bearing Capacity Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Cohesion Term (c'*Nc)", "right": "Shear resistance mobilized along the curved Prandtl log-spiral slip boundaries" },
        { "left": "Surcharge Term (q*Nq)", "right": "Overburden confining pressure (\u03b3*Df) holding down the passive Rankine breakout wedge" },
        { "left": "Soil Weight Term (0.5*\u03b3*B*N\u03b3)", "right": "Self-weight gravity resistance generated within the active triangular wedge beneath footing" },
        { "left": "Factor of Safety (FS = 3.0)", "right": "Global geotechnical margin preventing shear failure while limiting tolerable building settlements" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For a continuous strip footing on saturated clay under undrained conditions (\u03c6_u = 0\u00b0), Terzaghi's cohesion factor Nc equals exactly ___.",
      "blankAnswer": "5.7",
      "blankDistractors": ["1.0", "0", "9.0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A square footing (B = 2.0 m, Df = 1.5 m) is placed in soil with \u03b3 = 18.0 kN/m^3, c' = 15.0 kPa, and \u03c6' = 25\u00b0 (Nc = 25.13, Nq = 12.72, N\u03b3 = 8.34). What is the ultimate bearing capacity qu and the total allowable column load Q_all for a factor of safety FS = 3.0?",
      "options": [
        { "text": "qu = 953.6 kPa and Q_all = 1271.4 kN (q = 18*1.5 = 27 kPa; qu = 1.3*15*25.13 + 27*12.72 + 0.4*18*2*8.34 = 490.04 + 343.44 + 120.10 = 953.58 kPa; q_all = 953.58/3 = 317.86 kPa; Q_all = 317.86 * (2^2) = 1271.4 kN)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Terzaghi's bearing capacity equation for square footings (Braja M. Das *Principles of Foundation Engineering* Chapter 3). 1. **Calculate Base Surcharge Pressure ($q$):** $$q = \\gamma \\cdot D_f = 18.0\\text{ kN/m}^3 \\times 1.50\\text{ m} = \\mathbf{27.0\\text{ kPa}}$$ 2. **Evaluate the 3 Component Terms of Terzaghi's Square Equation:** - **Cohesion Term:** $$1.3 \\cdot c' \\cdot N_c = 1.3 \\times (15.0\\text{ kPa}) \\times 25.13 = 19.5 \\times 25.13 = \\mathbf{490.035\\text{ kPa}}$$ - **Surcharge Overburden Term:** $$q \\cdot N_q = 27.0\\text{ kPa} \\times 12.72 = \\mathbf{343.440\\text{ kPa}}$$ - **Soil Weight Wedge Term:** $$0.4 \\cdot \\gamma \\cdot B \\cdot N_\\gamma = 0.4 \\times (18.0\\text{ kN/m}^3) \\times (2.0\\text{ m}) \\times 8.34 = 14.4 \\times 8.34 = \\mathbf{120.096\\text{ kPa}}$$ 3. **Sum Total Ultimate Bearing Capacity ($q_u$):** $$q_u = 490.035 + 343.440 + 120.096 = \\mathbf{953.571\\text{ kPa} \\approx 953.6\\text{ kPa}}$$ 4. **Calculate Allowable Soil Pressure ($q_{\\text{all}}$) with $FS = 3.0$:** $$q_{\\text{all}} = \\frac{q_u}{FS} = \\frac{953.571\\text{ kPa}}{3.0} = \\mathbf{317.857\\text{ kPa}}$$ 5. **Calculate Total Allowable Column Load ($Q_{\\text{all}}$):** $$Q_{\\text{all}} = q_{\\text{all}} \\times A_{\\text{footing}} = 317.857\\text{ kPa} \\times (2.0\\text{ m} \\times 2.0\\text{ m}) = 317.857 \\times 4.0\\text{ m}^2 = \\mathbf{1271.43\\text{ kN} \\approx 1271.4\\text{ kN}}$$ Flawless shallow foundation bearing capacity derivation!" },
        { "text": "qu = 953.6 kPa and Q_all = 3814.3 kN (Forgot to divide by FS = 3.0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "qu = 490.0 kPa and Q_all = 653.3 kN", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "qu = 1200.0 kPa and Q_all = 1600.0 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
