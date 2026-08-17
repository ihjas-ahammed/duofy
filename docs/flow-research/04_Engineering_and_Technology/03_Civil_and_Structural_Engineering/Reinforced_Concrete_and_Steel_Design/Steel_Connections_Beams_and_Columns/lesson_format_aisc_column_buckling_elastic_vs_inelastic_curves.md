# Duofy Reusable Lesson Format: Steel Columns (AISC Inelastic & Elastic Buckling Curves)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Reinforced_Concrete_and_Steel_Design / Steel_Connections_Beams_and_Columns`  
**Lesson Format Type:** `aisc_column_buckling_elastic_vs_inelastic_curves`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanics of axial compression in structural steel wide-flange (W-shape) columns, effective length factors ($K$), column slenderness ratio ($K L / r$), Euler elastic buckling stress ($F_e$), the impact of hot-rolling residual stresses, the transition threshold ($4.71\sqrt{E/F_y}$), and the AISC 360-16 column strength curves (Inelastic vs Elastic buckling) (William T. Segui *Steel Design* 6th ed. Chapter 4; AISC 360-16 Chapter E): formulate the **Euler Elastic Buckling Stress ($F_e$)**:
$$\mathbf{F_e = \frac{\pi^2 E}{\left( \frac{K L}{r} \right)^2} \quad \left(r = \sqrt{\frac{I}{A}}, \quad \frac{K L}{r} \le 200\right)}$$
derive the **AISC 360-16 Column Buckling Stress Equations**:
1. **Inelastic Buckling Regime ($\mathbf{\frac{K L}{r} \le 4.71 \sqrt{\frac{E}{F_y}} \Longleftrightarrow F_e \ge 0.44 F_y}$):**
   - Accounts for premature yielding in flange tips caused by manufacturing residual compressive stresses ($\approx 0.30 F_y$):
     $$\mathbf{F_{cr} = \left[ 0.658^{\frac{F_y}{F_e}} \right] F_y}$$
2. **Elastic Euler Buckling Regime ($\mathbf{\frac{K L}{r} > 4.71 \sqrt{\frac{E}{F_y}} \Longleftrightarrow F_e < 0.44 F_y}$):**
   - Slender columns buckle elastically with initial out-of-straightness reduction:
     $$\mathbf{F_{cr} = 0.877 F_e}$$
derive the **Design Compressive Strength ($\phi_c P_n$)**:
$$\mathbf{\phi_c P_n = \phi_c F_{cr} A_g \ge P_u \quad (\text{Resistance Factor } \phi_c = 0.90)}$$
(proving how the exponential term $0.658^{F_y/F_e}$ provides a continuous, experimentally validated transition from full plastic squash load $F_y$ to slender Euler buckling).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Slenderness ($KL/r$), Euler Stress ($F_e$), AISC Inelastic/Elastic Equations & $\phi_c = 0.90$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Design Compressive Strength \phi_c Pn of a Steel Column Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Column Buckling Parameter / Regime & Technical Structural Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In AISC 360-16, the Transition Slenderness Ratio Boundary Between Inelastic and Elastic Buckling Is $4.71 \times \sqrt{E / \text{___}}$ (Fy / Yield Strength) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High-Rise Structural Problem: Computing F_cr and Design Compressive Strength for a W14x90 Steel Column Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Steel Column Buckling (Segui 2018; AISC 360-16):
   - **Column Equations & Transition Formulations:**
     $$\mathbf{F_e = \frac{\pi^2 E}{(KL/r)^2} \quad \Big| \quad F_{cr} = [0.658^{F_y/F_e}] F_y \ \left(\frac{KL}{r} \le 4.71\sqrt{\frac{E}{F_y}}\right) \quad \Big| \quad F_{cr} = 0.877 F_e \ \left(\frac{KL}{r} > 4.71\sqrt{\frac{E}{F_y}}\right)}$$
   - **Column Buckling Regimes Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Buckling Regime} & \textbf{Slenderness Threshold} & \textbf{Critical Stress Formula } F_{cr} & \textbf{Physical Failure Mechanism} \\
     \hline
     \mathbf{\text{Inelastic Buckling}} & \mathbf{\frac{K L}{r} \le 4.71\sqrt{\frac{E}{F_y}}} & \mathbf{F_{cr} = \left[ 0.658^{F_y/F_e} \right] F_y} & \mathbf{\text{Yielding of flange tips due to residual stress}} \\
     \mathbf{\text{Elastic Euler Buckling}} & \mathbf{\frac{K L}{r} > 4.71\sqrt{\frac{E}{F_y}}} & \mathbf{F_{cr} = 0.877 F_e} & \mathbf{\text{Elastic flexural buckling before any yielding}} \\
     \hline
     \end{array}$$
   - **The Residual Stress Invariant:** Hot-rolled structural steel shapes contain built-in cooling residual compressive stresses of up to **$0.30 F_y$ in the flange tips**, causing inelastic yielding to initiate at an applied stress of only **$0.70 F_y$ (where $F_e \approx 0.44 F_y$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of column capacity calculation: (1) determine effective length $K L$ and minimum radius of gyration $r = r_{\text{min}}$ (typically $r_y$), (2) compute governing slenderness ratio $K L / r \le 200$, (3) compute Euler elastic buckling stress $F_e = \frac{\pi^2 E}{(K L / r)^2}$, (4) compare $K L / r$ against threshold $4.71\sqrt{E/F_y}$ to select Inelastic or Elastic $F_{cr}$ formula, (5) evaluate critical stress $F_{cr}$ and calculate design compressive strength $\phi_c P_n = 0.90 F_{cr} A_g$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Inelastic Column Curve, Elastic Column Curve, Euler Stress $F_e$, Slenderness Ratio $KL/r$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Fy (or Yield Strength). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating column capacity: A structural steel column ($F_y = 350\text{ MPa} \approx 50\text{ ksi}, E = 200,000\text{ MPa}$) has gross area $A_g = 10,000\text{ mm}^2$ and governing slenderness ratio $K L / r = 70.0$. Transition threshold: $4.71\sqrt{\frac{E}{F_y}} = 4.71\sqrt{\frac{200,000}{350}} = 4.71\sqrt{571.4} = 4.71 \times 23.90 = \mathbf{112.6}$. What is the Euler stress $F_e$, the critical buckling stress $F_{cr}$, and the design compressive capacity $\phi_c P_n$ ($\phi_c = 0.90$)? ($F_e = \frac{\pi^2 E}{(KL/r)^2} = \frac{\pi^2 \times 200,000}{70^2} = \frac{1,973,920}{4900} = \mathbf{402.84\text{ MPa}}$; Since $K L / r = 70.0 \le 112.6$, the column is in the **Inelastic Regime**; Power term: $\frac{F_y}{F_e} = \frac{350}{402.84} = 0.8688$; $F_{cr} = [0.658^{0.8688}] \times 350\text{ MPa} = 0.6953 \times 350 = \mathbf{243.37\text{ MPa} \approx 243.4\text{ MPa}}$; $\phi_c P_n = 0.90 \times (243.37\text{ MPa}) \times (10,000\text{ mm}^2) = 0.90 \times 2,433,700\text{ N} = \mathbf{2190.3\text{ kN} \approx 2190\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "aisc_column_buckling_elastic_vs_inelastic_curves",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: AISC 360-16 Steel Column Buckling (William Segui)**\n• **Euler Elastic Buckling Stress ($F_e$):**\n$$\n\\mathbf{F_e = \\frac{\\pi^2 E}{\\left( \\frac{K L}{r} \\right)^2} \\quad \\left(r = \\sqrt{\\frac{I}{A}}, \\quad \\frac{K L}{r} \\le 200\\right)}\n$$\n• **AISC Critical Buckling Stress ($F_{cr}$) Formulations:**\n  - **Inelastic Buckling ($\\mathbf{\\frac{K L}{r} \\le 4.71 \\sqrt{\\frac{E}{F_y}}}$ or $F_e \\ge 0.44 F_y$):**\n$$\n\\mathbf{F_{cr} = \\left[ 0.658^{\\frac{F_y}{F_e}} \\right] F_y}\n$$\n  - **Elastic Euler Buckling ($\\mathbf{\\frac{K L}{r} > 4.71 \\sqrt{\\frac{E}{F_y}}}$ or $F_e < 0.44 F_y$):**\n$$\n\\mathbf{F_{cr} = 0.877 F_e}\n$$\n• **Design Compressive Strength:** $\\mathbf{\\phi_c P_n = \\phi_c F_{cr} A_g \\ge P_u \\quad (\\phi_c = 0.90)}$\n• **The Residual Stress Invariant:** Hot-rolled steel sections contain cooling residual compressive stresses of $\\approx 0.30 F_y$ in the flange tips; this causes **inelastic yielding at $0.70 F_y$**, which is modeled by the exponential $0.658^{F_y/F_e}$ curve!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the design axial compressive capacity \u03c6c Pn of a structural steel column per AISC 360-16.",
      "orderItems": [
        "Determine the effective length factor K and compute the governing maximum slenderness ratio: KL/r \u2264 200",
        "Calculate the Euler elastic buckling stress: Fe = (\u03c0^2 * E) / (KL/r)^2",
        "Compute the transition boundary threshold: 4.71 * \u221a(E / Fy)",
        "Select the Inelastic formula (Fcr = 0.658^(Fy/Fe) * Fy) or Elastic formula (Fcr = 0.877 * Fe) based on the threshold comparison",
        "Multiply critical buckling stress by gross area and resistance factor: \u03c6c Pn = 0.90 * Fcr * Ag"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Column Buckling Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Inelastic Buckling Curve", "right": "Fcr = [0.658^(Fy/Fe)]*Fy, accounting for residual compressive stresses in moderately slender columns" },
        { "left": "Elastic Buckling Curve", "right": "Fcr = 0.877*Fe, governing slender columns that buckle elastically with initial crookedness reduction" },
        { "left": "Transition Threshold (4.71\u221a(E/Fy))", "right": "Slenderness boundary separating inelastic yielding-buckling interaction from pure elastic Euler instability" },
        { "left": "Compression Resistance (\u03c6c = 0.90)", "right": "LRFD strength reduction factor for axial compression members per AISC 360-16" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In AISC 360-16, the transition slenderness ratio boundary between inelastic and elastic buckling is 4.71 times the square root of E divided by ___.",
      "blankAnswer": "Fy",
      "blankDistractors": ["Fu", "Ag", "Fe"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A steel column (Fy = 350 MPa, E = 200,000 MPa, 4.71\u221a(E/Fy) = 112.6) has gross area Ag = 10,000 mm^2 and governing slenderness KL/r = 70.0. What is the Euler elastic stress Fe, the critical buckling stress Fcr, and the design capacity \u03c6c Pn (\u03c6c = 0.90)?",
      "options": [
        { "text": "Fe = 402.8 MPa, Fcr = 243.4 MPa, and \u03c6c Pn = 2190.3 kN (Fe = \u03c0^2 * 200000 / 70^2 = 402.84 MPa; since KL/r = 70 \u2264 112.6 (inelastic), Fcr = 0.658^(350/402.84) * 350 = 0.6953 * 350 = 243.37 MPa; \u03c6c Pn = 0.90 * 243.37 * 10000 * 10^-3 = 2190.3 kN)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using AISC 360-16 column design equations (William T. Segui *Steel Design* Chapter 4). 1. **Calculate Euler Elastic Buckling Stress ($F_e$):** $$F_e = \\frac{\\pi^2 E}{\\left(\\frac{K L}{r}\\right)^2} = \\frac{\\pi^2 \\times 200,000\\text{ MPa}}{(70.0)^2} = \\frac{1,973,920.88}{4900} = \\mathbf{402.841\\text{ MPa}}$$ 2. **Check the Inelastic vs Elastic Transition Boundary:** $$\\text{Threshold} = 4.71 \\sqrt{\\frac{E}{F_y}} = 4.71 \\sqrt{\\frac{200,000\\text{ MPa}}{350\\text{ MPa}}} = 4.71 \\times \\sqrt{571.428} = 4.71 \\times 23.9045 = \\mathbf{112.59}$$ - Because $\\frac{K L}{r} = 70.0 \\le 112.59$, the column is in the **Inelastic Buckling Regime**! 3. **Calculate Critical Buckling Stress ($F_{cr}$):** - Ratio: $$\\frac{F_y}{F_e} = \\frac{350\\text{ MPa}}{402.841\\text{ MPa}} = 0.868828$$ - AISC Inelastic Equation: $$F_{cr} = \\left[ 0.658^{\\frac{F_y}{F_e}} \\right] F_y = \\left[ 0.658^{0.868828} \\right] \\times 350\\text{ MPa} = 0.695337 \\times 350\\text{ MPa} = \\mathbf{243.368\\text{ MPa} \\approx 243.4\\text{ MPa}}$$ 4. **Calculate Design Compressive Capacity ($\\phi_c P_n$):** $$\\phi_c P_n = \\phi_c \\cdot F_{cr} \\cdot A_g = 0.90 \\times (243.368\\text{ MPa}) \\times (10,000\\text{ mm}^2) = 0.90 \\times 2,433,680\\text{ N} = \\mathbf{2,190.31\\text{ kN} \\approx 2190.3\\text{ kN}}$$ Flawless AISC 360-16 steel column design!" },
        { "text": "Fe = 402.8 MPa, Fcr = 353.3 MPa, and \u03c6c Pn = 3180.0 kN (Used elastic formula by mistake)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Fe = 200.0 MPa, Fcr = 150.0 MPa, and \u03c6c Pn = 1350.0 kN", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Fe = 402.8 MPa, Fcr = 350.0 MPa, and \u03c6c Pn = 3150.0 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
