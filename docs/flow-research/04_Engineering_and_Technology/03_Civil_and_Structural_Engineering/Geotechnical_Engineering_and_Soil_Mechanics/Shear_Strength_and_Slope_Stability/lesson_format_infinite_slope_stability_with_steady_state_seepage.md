# Duofy Reusable Lesson Format: Infinite Slopes (Groundwater Seepage & Safety Factors)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Shear_Strength_and_Slope_Stability`  
**Lesson Format Type:** `infinite_slope_stability_with_steady_state_seepage`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the limit equilibrium mechanics of infinite slopes in cohesionless and cohesive soils, the destabilizing role of pore water pressure ($u$) under steady-state groundwater seepage parallel to the slope face, the comparison of Factor of Safety ($FS$) under dry, submerged, and steady seepage conditions, and the critical slope inclination angle triggering debris flow liquefaction (Braja M. Das *Principles of Geotechnical Engineering* 9th ed. Chapter 14; J. Michael Duncan *Soil Strength and Slope Stability* 2nd ed. Chapter 6): formulate the **General Infinite Slope Factor of Safety ($FS$)**:
$$\mathbf{FS = \frac{\tau_f}{\tau_d} = \frac{c' + \sigma' \tan\phi'}{\tau_d}}$$
derive the **Three Fundamental Infinite Slope Groundwater Regimes ($c' = 0$)**:
1. **Completely Dry Slope (No Water):**
   $$\mathbf{FS_{\text{dry}} = \frac{\tan\phi'}{\tan\beta} \quad (\text{Stable if slope angle } \beta \le \phi')}$$
2. **Fully Submerged Slope (Static Water with No Seepage):**
   $$\mathbf{FS_{\text{submerged}} = \frac{\gamma'}{\gamma'} \frac{\tan\phi'}{\tan\beta} = \frac{\tan\phi'}{\tan\beta} = FS_{\text{dry}}}$$
3. **Steady-State Seepage Parallel to Slope (Groundwater at Surface):**
   - Pore water pressure at depth $z$: $u = \gamma_w z \cos^2\beta$;
   - Resisting shear stress: $\tau_f = (\gamma_{\text{sat}} - \gamma_w) z \cos^2\beta \tan\phi' = \gamma' z \cos^2\beta \tan\phi'$;
   - Driving shear stress: $\tau_d = \gamma_{\text{sat}} z \sin\beta \cos\beta$;
   $$\mathbf{FS_{\text{seepage}} = \frac{\gamma'}{\gamma_{\text{sat}}} \cdot \frac{\tan\phi'}{\tan\beta} \approx \frac{1}{2} \frac{\tan\phi'}{\tan\beta} = \mathbf{\frac{1}{2} FS_{\text{dry}}}}$$
(proving why heavy rainfall and rising groundwater tables instantly cut the Factor of Safety of natural hillsides in half, triggering catastrophic mudslides).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Infinite Slope Mechanics, Dry ($FS = \frac{\tan\phi'}{\tan\beta}$) vs Seepage ($FS = \frac{\gamma'}{\gamma_{\text{sat}}} \frac{\tan\phi'}{\tan\beta}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Stability Factor of Safety for an Infinite Sand Slope Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Groundwater Seepage Condition / Slope Parameter & Technical Mechanical Impact Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Cohesionless Infinite Slope ($c' = 0$) with Steady Seepage Parallel to the Slope Face, the Factor of Safety Is Reduced by the Ratio $\gamma'$ Divided by ___ (gamma_sat / Saturated Unit Weight) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Geotechnical Problem: Evaluating Slope Stability for a 20-Degree Embankment Under Dry vs Seepage Conditions Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Infinite Slope Seepage Mechanics (Duncan 2014; Das 2018):
   - **Factor of Safety Formulations:**
     $$\mathbf{FS = \frac{c' + (\gamma_{\text{sat}} z \cos^2\beta - u)\tan\phi'}{\gamma_{\text{sat}} z \sin\beta \cos\beta} \quad \Big| \quad FS_{\text{dry}} = \frac{\tan\phi'}{\tan\beta} \quad \Big| \quad FS_{\text{seepage}} = \frac{\gamma'}{\gamma_{\text{sat}}} \frac{\tan\phi'}{\tan\beta} \approx 0.5 \frac{\tan\phi'}{\tan\beta}}$$
   - **Groundwater Seepage Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Hydraulic State} & \textbf{Pore Pressure } u & \textbf{Factor of Safety } FS & \textbf{Critical Slope Angle } \beta_{\text{crit}} \\
     \hline
     \mathbf{\text{Dry Slope}} & u = 0 & \mathbf{FS = \tan\phi' / \tan\beta} & \mathbf{\beta_{\text{crit}} = \phi'} \\
     \mathbf{\text{Submerged (Static)}} & u = \gamma_w z_{\text{sub}} & \mathbf{FS = \tan\phi' / \tan\beta} & \mathbf{\beta_{\text{crit}} = \phi'} \\
     \mathbf{\text{Parallel Seepage at Surface}} & \mathbf{u = \gamma_w z \cos^2\beta} & \mathbf{FS = \frac{\gamma'}{\gamma_{\text{sat}}} \frac{\tan\phi'}{\tan\beta} \approx \frac{1}{2} FS_{\text{dry}}} & \mathbf{\beta_{\text{crit}} \approx \frac{\phi'}{2} \ (\text{Halved!})} \\
     \hline
     \end{array}$$
   - **The Buoyancy Penalty Invariant:** Because buoyant unit weight $\gamma' = \gamma_{\text{sat}} - \gamma_w \approx 10\text{ kN/m}^3$ while saturated weight $\gamma_{\text{sat}} \approx 20\text{ kN/m}^3$, the ratio $\frac{\gamma'}{\gamma_{\text{sat}}} \approx \mathbf{0.50}$, reducing slope capacity by approximately **$50\%$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of infinite slope analysis: (1) determine soil properties: effective friction angle $\phi'$, cohesion $c'$, and saturated unit weight $\gamma_{\text{sat}}$, (2) measure slope inclination angle $\beta$ and depth $z$ to potential slip interface, (3) evaluate pore water pressure distribution $u = \gamma_w z \cos^2\beta$ for parallel seepage, (4) compute effective normal stress $\sigma' = \gamma_{\text{sat}} z \cos^2\beta - u = \gamma' z \cos^2\beta$, (5) evaluate resisting vs driving shear stress to compute $FS = \frac{\gamma'}{\gamma_{\text{sat}}} \frac{\tan\phi'}{\tan\beta}$ and verify $FS \ge 1.50$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Dry Slope $FS$, Seepage Slope $FS$, Buoyant Ratio $\gamma'/\gamma_{\text{sat}}$, Critical Angle $\beta_{\text{crit}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of gamma_sat (or Saturated Unit Weight). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing $FS$ under seepage: A sandy embankment slope has inclination angle $\beta = 18.0^\circ$ and effective internal friction angle $\phi' = 32.0^\circ$ ($c' = 0$). Saturated unit weight is $\gamma_{\text{sat}} = 20.0\text{ kN/m}^3$ and water unit weight is $\gamma_w = 9.81\text{ kN/m}^3$ ($\gamma' = 20.0 - 9.81 = 10.19\text{ kN/m}^3$).
   - Given $\tan(32.0^\circ) = 0.62487$ and $\tan(18.0^\circ) = 0.32492$.
   - Dry Factor of Safety: $FS_{\text{dry}} = \frac{\tan(32^\circ)}{\tan(18^\circ)} = \frac{0.62487}{0.32492} = \mathbf{1.923}$;
   - What is the Factor of Safety $FS_{\text{seepage}}$ when steady groundwater seepage develops parallel to the slope with the water table at the surface? ($FS_{\text{seepage}} = \frac{\gamma'}{\gamma_{\text{sat}}} \times \frac{\tan\phi'}{\tan\beta} = \frac{10.19\text{ kN/m}^3}{20.00\text{ kN/m}^3} \times 1.9231 = 0.5095 \times 1.9231 = \mathbf{0.980 \approx 0.98} < 1.0 \implies \text{Slope collapses!}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "infinite_slope_stability_with_steady_state_seepage",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Infinite Slope Stability \\& Groundwater Seepage (Duncan \\& Wright)**\n• **General Cohesionless Infinite Slope Formulation ($c' = 0$):**\n$$\n\\mathbf{FS = \\frac{\\text{Resisting Shear Strength } \\tau_f}{\\text{Driving Shear Stress } \\tau_d}}\n$$\n• **The 3 Fundamental Seepage Regimes:**\n  - **Dry Slope Condition:**\n$$\n\\mathbf{FS_{\\text{dry}} = \\frac{\\tan\\phi'}{\\tan\\beta} \\quad (\\text{Stable if } \\beta \\le \\phi')}\n$$\n  - **Steady Groundwater Seepage Parallel to Slope (Water at Surface):**\n$$\n\\mathbf{FS_{\\text{seepage}} = \\frac{\\gamma'}{\\gamma_{\\text{sat}}} \\cdot \\frac{\\tan\\phi'}{\\tan\\beta} = \\frac{\\gamma_{\\text{sat}} - \\gamma_w}{\\gamma_{\\text{sat}}} \\cdot \\frac{\\tan\\phi'}{\\tan\\beta} \\approx \\mathbf{\\frac{1}{2} FS_{\\text{dry}}}}\n$$\n• **The Landslide Hazard Invariant:** Because $\\frac{\\gamma'}{\\gamma_{\\text{sat}}} \\approx \\frac{10}{20} = \\mathbf{0.50}$, saturation with seepage **cuts the Factor of Safety in half**, causing slopes stable when dry ($FS = 1.9$) to catastrophically fail ($FS = 0.95 < 1.0$) during heavy monsoon storms!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the Factor of Safety of an infinite sand slope subjected to parallel groundwater seepage.",
      "orderItems": [
        "Determine the slope geometry: inclination angle \u03b2 and depth z to the potential failure slip interface",
        "Obtain soil effective shear strength parameters: friction angle \u03c6' (with c' = 0 for sand) and saturated unit weight \u03b3sat",
        "Calculate the buoyant effective unit weight: \u03b3' = \u03b3sat - \u03b3w accounting for hydrostatic pore pressure u = \u03b3w * z * cos^2(\u03b2)",
        "Compute the driving shear stress: \u03c4d = \u03b3sat * z * sin(\u03b2)*cos(\u03b2) and resisting shear strength: \u03c4f = \u03b3' * z * cos^2(\u03b2)*tan(\u03c6')",
        "Calculate the factor of safety: FS = (\u03b3' / \u03b3sat) * (tan\u03c6' / tan\u03b2) and check if FS \u2265 1.50 for long-term stability"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Slope Stability Regime to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Dry Slope Factor of Safety", "right": "FS = tan\u03c6' / tan\u03b2, governed purely by particle friction without pore water destabilization" },
        { "left": "Parallel Seepage Factor of Safety", "right": "FS = (\u03b3' / \u03b3sat) * (tan\u03c6' / tan\u03b2), incorporating pore water pressure that cuts stability by ~50%" },
        { "left": "Buoyancy Ratio (\u03b3' / \u03b3sat)", "right": "Fraction of effective normal stress remaining after subtracting buoyant pore water pressure" },
        { "left": "Critical Slope Angle Under Seepage", "right": "\u03b2_crit \u2248 \u03c6' / 2, maximum stable hillside inclination angle during heavy saturation events" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a cohesionless infinite slope with steady seepage parallel to the slope face, the Factor of Safety is reduced by the ratio \u03b3' divided by ___.",
      "blankAnswer": "gamma_sat",
      "blankDistractors": ["gamma_w", "tan_phi", "cos_beta"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A sandy slope has inclination \u03b2 = 18.0\u00b0 (tan18\u00b0 = 0.3249) and friction angle \u03c6' = 32.0\u00b0 (tan32\u00b0 = 0.6249). Saturated unit weight is \u03b3sat = 20.0 kN/m^3 and \u03b3w = 9.81 kN/m^3 (\u03b3' = 10.19 kN/m^3). What is the Factor of Safety when dry (FS_dry) versus when fully saturated with parallel seepage (FS_seepage)?",
      "options": [
        { "text": "FS_dry = 1.92 and FS_seepage = 0.98 (Failure!) (FS_dry = 0.6249 / 0.3249 = 1.923; FS_seepage = (10.19 / 20.0) * 1.923 = 0.5095 * 1.923 = 0.980 < 1.0, triggering slope collapse)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using infinite slope stability mechanics (J. Michael Duncan *Soil Strength and Slope Stability* Chapter 6). 1. **Calculate Factor of Safety for the Dry Slope ($FS_{\\text{dry}}$):** $$FS_{\\text{dry}} = \\frac{\\tan\\phi'}{\\tan\\beta} = \\frac{\\tan(32.0^\\circ)}{\\tan(18.0^\\circ)} = \\frac{0.624869}{0.324920} = \\mathbf{1.9231 \\approx 1.92}$$ - When dry, the slope is **exceptionally safe and stable** ($FS = 1.92 > 1.50$)! 2. **Calculate Buoyant Effective Unit Weight ($\\gamma'$):** $$\\gamma' = \\gamma_{\\text{sat}} - \\gamma_w = 20.00\\text{ kN/m}^3 - 9.81\\text{ kN/m}^3 = \\mathbf{10.19\\text{ kN/m}^3}$$ 3. **Calculate Factor of Safety with Steady Parallel Seepage ($FS_{\\text{seepage}}$):** $$FS_{\\text{seepage}} = \\frac{\\gamma'}{\\gamma_{\\text{sat}}} \\cdot \\frac{\\tan\\phi'}{\\tan\\beta} = \\left(\\frac{10.19\\text{ kN/m}^3}{20.00\\text{ kN/m}^3}\\right) \\times 1.9231$$ $$FS_{\\text{seepage}} = (0.5095) \\times 1.9231 = \\mathbf{0.9798 \\approx 0.98}$$ 4. **Physical Interpretation \\& Engineering Diagnosis:** - Because $FS_{\\text{seepage}} = 0.98 < 1.00$, the driving gravity shear stresses exceed the available frictional resistance! - **Outcome:** The slope **collapses in a catastrophic shallow translational landslide / debris flow** as soon as groundwater rises to the ground surface! Flawless geotechnical slope stability calculation!" },
        { "text": "FS_dry = 1.92 and FS_seepage = 1.92 (Water does not affect cohesionless slope)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FS_dry = 0.98 and FS_seepage = 0.50", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FS_dry = 1.92 and FS_seepage = 1.50", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
