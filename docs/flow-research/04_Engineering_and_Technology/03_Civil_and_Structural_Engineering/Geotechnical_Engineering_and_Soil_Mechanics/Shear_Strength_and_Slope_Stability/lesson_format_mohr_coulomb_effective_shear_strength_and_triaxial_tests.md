# Duofy Reusable Lesson Format: Soil Shear Strength (Mohr-Coulomb & Triaxial Mechanics)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Shear_Strength_and_Slope_Stability`  
**Lesson Format Type:** `mohr_coulomb_effective_shear_strength_and_triaxial_tests`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the Mohr-Coulomb shear strength criterion, the physical distinction between total stress ($\sigma$) and effective stress ($\sigma' = \sigma - u$), effective shear parameters (cohesion $c'$, friction angle $\phi'$), the three standard triaxial testing procedures (Consolidated-Drained $CD$, Consolidated-Undrained $CU$ with pore pressure measurement, and Unconsolidated-Undrained $UU$), and the transformation between principal stresses ($\sigma_1', \sigma_3'$) at failure (Braja M. Das *Principles of Geotechnical Engineering* 9th ed. Chapter 12; Karl Terzaghi *Theoretical Soil Mechanics*): formulate the **Mohr-Coulomb Effective Stress Failure Criterion**:
$$\mathbf{\tau_f = c' + \sigma' \tan\phi' = c' + (\sigma - u) \tan\phi'}$$
derive the **Principal Stress Failure Relationship**:
$$\mathbf{\sigma_1' = \sigma_3' \tan^2\left( 45^\circ + \frac{\phi'}{2} \right) + 2 c' \tan\left( 45^\circ + \frac{\phi'}{2} \right) = \sigma_3' N_\phi + 2 c' \sqrt{N_\phi}}$$
where:
1. **$N_\phi = \tan^2\left(45^\circ + \frac{\phi'}{2}\right) = \frac{1 + \sin\phi'}{1 - \sin\phi'}$:** Flow value / passive earth pressure coefficient;
2. **$\sigma_3'$:** Minor principal effective stress (effective confining pressure $\sigma_3 - u$);
3. **$\sigma_1' = \sigma_3' + \Delta\sigma_d'$:** Major principal effective stress at peak deviator stress;
4. **Undrained Clay Shear Strength ($UU$ Test):** $\mathbf{\phi_u = 0^\circ \implies S_u = c_u = \frac{\sigma_1 - \sigma_3}{2} = \frac{q_u}{2}}$
(proving that pore water pressure $u > 0$ reduces effective confining stress, causing the Mohr circle to shift leftward into the failure envelope).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mohr-Coulomb ($\tau_f = c' + \sigma'\tan\phi'$), Triaxial Tests ($CD, CU, UU$) & $\sigma_1' = \sigma_3' N_\phi + 2c'\sqrt{N_\phi}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Effective Friction Angle \phi' and Cohesion c' from Triaxial Test Data Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Triaxial Testing Regime / Strength Parameter & Technical Testing Method Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In an Unconsolidated-Undrained (UU) Triaxial Test on a Saturated Clay, the Total Stress Internal Friction Angle $\phi_u$ Equals Exactly ___ Degrees (0 / Zero) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Geotechnical Problem: Calculating Effective Deviator Stress and Major Principal Stress \sigma_1' at Failure for Sand Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Mohr-Coulomb & Triaxial Failure (Das 2018; Terzaghi 1943):
   - **Shear Strength & Principal Stress Formulations:**
     $$\mathbf{\tau_f = c' + \sigma'\tan\phi' \quad \Big| \quad \sigma_1' = \sigma_3' \tan^2(45^\circ + \phi'/2) + 2c'\tan(45^\circ + \phi'/2) \quad \Big| \quad N_\phi = \frac{1+\sin\phi'}{1-\sin\phi'}}$$
   - **Triaxial Test Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Test Type} & \textbf{Consolidation Stage} & \textbf{Shearing Stage} & \textbf{Governing Parameters Measured} \\
     \hline
     \mathbf{\text{Consolidated-Drained (CD)}} & \text{Drainage Open } (\Delta u = 0) & \text{Drainage Open } (\Delta u = 0) & \mathbf{c', \ \phi' \ (\text{Long-term drained stability})} \\
     \mathbf{\text{Consolidated-Undrained (CU)}} & \text{Drainage Open } (\Delta u = 0) & \mathbf{\text{Drainage Closed } (\text{Measure } u)} & \mathbf{c', \ \phi' \ (\text{Effective}) \ \& \ c, \ \phi \ (\text{Total})} \\
     \mathbf{\text{Unconsolidated-Undrained (UU)}} & \mathbf{\text{Drainage Closed}} & \mathbf{\text{Drainage Closed}} & \mathbf{S_u = c_u = q_u / 2 \ (\phi_u = 0^\circ \text{ short-term})} \\
     \hline
     \end{array}$$
   - **The Effective Friction Invariant:** For clean cohesionless sands ($c' = 0$), the ratio of principal effective stresses at failure is **a fixed material constant $\frac{\sigma_1'}{\sigma_3'} = \tan^2(45^\circ + \phi'/2)$** regardless of confining pressure!
2. **Slide 2 (`ordering`):** Provide 5 steps of triaxial analysis: (1) apply cell confining pressure $\sigma_3$ to saturate and consolidate specimen, (2) apply axial deviator stress $\Delta\sigma_d = \sigma_1 - \sigma_3$ while measuring pore water pressure $u$, (3) compute effective stresses at failure: $\sigma_3' = \sigma_3 - u_f$ and $\sigma_1' = \sigma_1 - u_f$, (4) plot Mohr circles of effective stress at failure for multiple confining pressures, (5) draw the tangent failure envelope to extract effective cohesion $c'$ (intercept) and friction angle $\phi'$ (slope angle)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Consolidated-Drained Test, Consolidated-Undrained with $u$, Unconsolidated-Undrained $\phi=0$, Flow Value $N_\phi$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0 (or Zero). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating major principal stress at failure: A Consolidated-Drained ($CD$) triaxial compression test is conducted on a clean dry sand ($c' = 0, \phi' = 30^\circ$). The effective cell confining pressure is $\sigma_3' = 150.0\text{ kPa}$. Flow value: $N_\phi = \tan^2(45^\circ + 30^\circ/2) = \tan^2(60^\circ) = (\sqrt{3})^2 = \mathbf{3.00}$. What is the major principal effective stress $\sigma_1'$ and the deviator stress $\Delta\sigma_d$ at shear failure? ($\sigma_1' = \sigma_3' \cdot N_\phi = 150.0\text{ kPa} \times 3.00 = \mathbf{450.0\text{ kPa}}$; Deviator stress $\Delta\sigma_d = \sigma_1' - \sigma_3' = 450.0 - 150.0 = \mathbf{300.0\text{ kPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mohr_coulomb_effective_shear_strength_and_triaxial_tests",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Mohr-Coulomb Failure Criterion \\& Triaxial Mechanics (Karl Terzaghi)**\n• **Mohr-Coulomb Effective Stress Failure Criterion:**\n$$\n\\mathbf{\\tau_f = c' + \\sigma' \\tan\\phi' = c' + (\\sigma - u) \\tan\\phi'}\n$$\n  - **$c'$:** Effective cohesion intercept (kPa);\n  - **$\\phi'$:** Effective angle of internal friction (degrees);\n  - **$u$:** Pore water pressure (reducing effective confining stress);\n• **Principal Stresses at Failure Formulation:**\n$$\n\\mathbf{\\sigma_1' = \\sigma_3' \\tan^2\\left( 45^\\circ + \\frac{\\phi'}{2} \\right) + 2 c' \\tan\\left( 45^\\circ + \\frac{\\phi'}{2} \\right) = \\sigma_3' N_\\phi + 2 c' \\sqrt{N_\\phi}}\n$$\n• **The 3 Standard Triaxial Testing Regimes:**\n  - **$CD$ (Consolidated-Drained):** Slow rate with zero excess pore pressure $\\implies c', \\phi'$;\n  - **$CU$ (Consolidated-Undrained):** Fast shearing measuring pore pressure $u \\implies c', \\phi'$;\n  - **$UU$ (Unconsolidated-Undrained):** Rapid undrained loading of saturated clays $\\implies \\mathbf{\\phi_u = 0^\\circ \\text{ and } S_u = c_u = \\frac{q_u}{2}}$;\n• **The Pore Pressure Invariant:** Positive pore water pressure ($u > 0$) directly decreases $\\sigma'$, shifting the Mohr circle **leftward into premature shear failure**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine effective shear strength parameters (c', \u03c6') from laboratory triaxial compression tests.",
      "orderItems": [
        "Mount the cylindrical soil specimen in the triaxial cell and apply confining fluid pressure \u03c33 to consolidate the soil",
        "Apply axial vertical loading (deviator stress \u0394\u03c3d) at a controlled displacement rate until shear failure occurs",
        "Measure the pore water pressure (u) continuously throughout undrained shearing to evaluate effective stresses",
        "Compute major and minor principal effective stresses at failure: \u03c33' = \u03c33 - u_f and \u03c31' = (\u03c33 + \u0394\u03c3d) - u_f",
        "Plot effective stress Mohr failure circles for multiple confining pressures and fit the tangent envelope: \u03c4f = c' + \u03c3' tan\u03c6'"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Triaxial Shear Testing Regime to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Consolidated-Drained (CD)", "right": "Fully drained consolidation and shearing with u = 0, determining long-term effective parameters c' and \u03c6'" },
        { "left": "Consolidated-Undrained (CU)", "right": "Consolidated under confining pressure then sheared undrained with pore pressure measurement" },
        { "left": "Unconsolidated-Undrained (UU)", "right": "Rapid total stress test on saturated clays yielding undrained shear strength Su = cu with \u03c6u = 0\u00b0" },
        { "left": "Flow Value (N\u03c6)", "right": "N\u03c6 = tan^2(45\u00b0 + \u03c6'/2) = (1 + sin\u03c6') / (1 - sin\u03c6'), principal stress failure ratio multiplier" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an Unconsolidated-Undrained (UU) triaxial test on fully saturated clay, the total stress internal friction angle \u03c6_u equals exactly ___ degrees.",
      "blankAnswer": "0",
      "blankDistractors": ["30", "45", "90"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A Consolidated-Drained (CD) triaxial test on dry clean sand (c' = 0, \u03c6' = 30\u00b0) is conducted with confining pressure \u03c33' = 150.0 kPa. Flow value is N\u03c6 = tan^2(45\u00b0 + 30\u00b0/2) = tan^2(60\u00b0) = 3.00. What is the major principal effective stress \u03c31' and the deviator stress \u0394\u03c3d at failure?",
      "options": [
        { "text": "\u03c31' = 450.0 kPa and \u0394\u03c3d = 300.0 kPa (\u03c31' = \u03c33' * N\u03c6 = 150.0 * 3.00 = 450.0 kPa; \u0394\u03c3d = \u03c31' - \u03c33' = 450.0 - 150.0 = 300.0 kPa)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Mohr-Coulomb principal stress failure equation for cohesionless soils (Braja M. Das *Principles of Geotechnical Engineering* Chapter 12). 1. **Calculate Flow Value ($N_\\phi$):** - Friction angle $\\phi' = 30.0^\\circ$. $$N_\\phi = \\tan^2\\left(45^\\circ + \\frac{\\phi'}{2}\\right) = \\tan^2(45^\\circ + 15^\\circ) = \\tan^2(60.0^\\circ) = (\\sqrt{3})^2 = \\mathbf{3.000}$$ 2. **Calculate Major Principal Effective Stress ($\\sigma_1'$):** - For clean cohesionless sand, effective cohesion $c' = 0$: $$\\sigma_1' = \\sigma_3' \\cdot N_\\phi + 2 c' \\sqrt{N_\\phi} = (150.0\\text{ kPa}) \\times 3.000 + 0 = \\mathbf{450.0\\text{ kPa}}$$ 3. **Calculate Deviator Stress ($\\Delta\\sigma_d$) at Shear Failure:** $$\\Delta\\sigma_d = \\sigma_1' - \\sigma_3' = 450.0\\text{ kPa} - 150.0\\text{ kPa} = \\mathbf{300.0\\text{ kPa}}$$ 4. **Check Mohr Circle Geometry:** - Center of Mohr circle: $$\\sigma_{\\text{center}}' = \\frac{\\sigma_1' + \\sigma_3'}{2} = \\frac{450 + 150}{2} = 300\\text{ kPa}$$ - Radius of Mohr circle: $$R = \\frac{\\sigma_1' - \\sigma_3'}{2} = \\frac{300}{2} = 150\\text{ kPa}$$ - Verify friction angle: $$\\sin\\phi' = \\frac{R}{\\sigma_{\\text{center}}'} = \\frac{150}{300} = 0.500 \\implies \\phi' = 30.0^\\circ\\text{ !}$$ Flawless soil shear strength calculation!" },
        { "text": "\u03c31' = 300.0 kPa and \u0394\u03c3d = 150.0 kPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c31' = 600.0 kPa and \u0394\u03c3d = 450.0 kPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c31' = 450.0 kPa and \u0394\u03c3d = 450.0 kPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
