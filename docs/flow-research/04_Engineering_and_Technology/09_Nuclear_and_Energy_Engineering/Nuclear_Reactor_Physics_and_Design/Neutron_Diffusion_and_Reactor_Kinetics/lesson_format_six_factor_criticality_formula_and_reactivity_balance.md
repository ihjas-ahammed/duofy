# Duofy Reusable Lesson Format: Nuclear Criticality (Six-Factor Formula & Reactivity)

**Target Topic:** `04_Engineering_and_Technology / 09_Nuclear_and_Energy_Engineering / Nuclear_Reactor_Physics_and_Design / Neutron_Diffusion_and_Reactor_Kinetics`  
**Lesson Format Type:** `six_factor_criticality_formula_and_reactivity_balance`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the neutron multiplication life cycle in thermal nuclear reactors, the infinite medium **Four-Factor Formula ($k_\infty = \eta \cdot \epsilon \cdot p \cdot f$)**, the finite core **Six-Factor Criticality Formula ($k_{\text{eff}} = k_\infty \cdot P_{\text{FNL}} \cdot P_{\text{TNL}}$)**, fast and thermal non-leakage probabilities ($P_{\text{FNL}} = e^{-B_g^2 \tau}$, $P_{\text{TNL}} = \frac{1}{1 + B_g^2 L^2}$), geometric buckling ($B_g^2$), core **Reactivity ($\rho = \frac{k_{\text{eff}} - 1}{k_{\text{eff}}}$)** in percent mille ($\text{pcm} = 10^{-5}$) and dollars ($\$ = \rho / \beta$), and the physical conditions for subcriticality ($\rho < 0$), criticality ($\rho = 0$), and supercriticality ($\rho > 0$) (John R. Lamarsh, Anthony J. Baratta *Introduction to Nuclear Engineering* 4th ed. Chapter 6; James J. Duderstadt, Louis J. Hamilton *Nuclear Reactor Analysis* Chapter 6; Elmer E. Lewis *Fundamentals of Nuclear Reactor Physics* Chapter 5): formulate the **Six-Factor Effective Multiplication Factor Master Formulation**:
$$\mathbf{k_{\text{eff}} = \eta \cdot \epsilon \cdot p \cdot f \cdot P_{\text{FNL}} \cdot P_{\text{TNL}} = \mathbf{k_\infty \cdot P_{\text{FNL}} \cdot P_{\text{TNL}}}}$$
where:
1. **$\eta$ (Reproduction Factor):** Fast neutrons emitted per thermal neutron absorbed in fuel ($\eta = \nu \frac{\Sigma_{fF}}{\Sigma_{aF}}$);
2. **$\epsilon$ (Fast Fission Factor):** Fast fissions in U-238 boosting neutron population ($\approx 1.03 - 1.05$);
3. **$p$ (Resonance Escape Probability):** Fraction of fast neutrons escaping capture in U-238 resonance peaks ($\approx 0.85 - 0.90$);
4. **$f$ (Thermal Utilization Factor):** Fraction of thermal neutrons absorbed in fuel vs moderator/structure ($f = \frac{\Sigma_{aF}}{\Sigma_a}$);
5. **$P_{\text{FNL}} = e^{-B_g^2 \tau}$:** Fast Non-Leakage probability ($\approx 0.96$);
6. **$P_{\text{TNL}} = \frac{1}{1 + B_g^2 L^2}$:** Thermal Non-Leakage probability ($\approx 0.98$);
derive the **Core Reactivity Master Formulation ($\rho$)**:
$$\mathbf{\rho = \frac{k_{\text{eff}} - 1}{k_{\text{eff}}} \quad \Big| \quad \rho_{\text{pcm}} = \rho \times 10^5 \quad \Big| \quad \mathbf{\text{Reactivity in Dollars (\$) } = \frac{\rho}{\beta}}}$$
master the **Core Criticality States Matrix**:
$$\begin{array}{|l|c|c|c|l|}
\hline
\textbf{Core Operating State} & \textbf{Effective Multiplier } k_{\text{eff}} & \textbf{Reactivity } \rho & \textbf{Reactivity in Dollars} & \textbf{Fission Power Behavior} \\
\hline
\mathbf{\text{Subcritical}} & \mathbf{k_{\text{eff}} < 1.0000} & \mathbf{\rho < 0} & \mathbf{< 0.00\ \$} & \mathbf{\text{Neutron population dies away exponentially}} \\
\mathbf{\text{Critical (Steady)}} & \mathbf{k_{\text{eff}} = 1.0000} & \mathbf{\rho = 0} & \mathbf{0.00\ \$} & \mathbf{\text{Exact power balance; steady MWth generation}} \\
\mathbf{\text{Delayed Supercritical}} & \mathbf{1.0000 < k_{\text{eff}} < 1.0065} & \mathbf{0 < \rho < \beta} & \mathbf{0 < \$ < 1.00\ \$} & \mathbf{\text{Controlled, safe power ascent via delayed neutrons}} \\
\mathbf{\text{Prompt Critical (Hazard)}} & \mathbf{k_{\text{eff}} \ge 1 + \beta} & \mathbf{\rho \ge \beta} & \mathbf{\ge 1.00\ \$} & \mathbf{\text{Uncontrolled microsecond power spike (Chernobyl)}} \\
\hline
\end{array}$$
(proving that safe reactor control strictly mandates operating at $\rho < \beta$, where delayed neutrons enforce slow, human-manageable power transients).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Six-Factor Formula ($k_{\text{eff}} = \eta \epsilon p f P_{\text{FNL}} P_{\text{TNL}}$), Reactivity ($\rho = \frac{k_{\text{eff}}-1}{k_{\text{eff}}}$) & Dollar Units Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Four Factors, Non-Leakage Probabilities, K-effective, and Reactivity Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Criticality Factor / Reactivity Metric & Technical Reactor Design Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Nuclear Engineering, the Dimensionless Ratio Representing the Relative Departure of a Reactor from Criticality $\rho = (k_{\text{eff}} - 1) / k_{\text{eff}}$ Is Defined as Core ___ (Reactivity / Core Reactivity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Nuclear Core Physics Problem: Computing K-effective, Reactivity in pcm, and Dollars for a Commercial PWR Core Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Six-Factor Criticality & Reactivity Mechanics (Lamarsh 2018; Duderstadt 1976):
   - **Criticality Formulations:**
     $$\mathbf{k_\infty = \eta \epsilon p f \quad \Big| \quad k_{\text{eff}} = k_\infty P_{\text{FNL}} P_{\text{TNL}} \quad \Big| \quad \rho = \frac{k_{\text{eff}}-1}{k_{\text{eff}}} \quad \Big| \quad \$ = \frac{\rho}{\beta}}$$
   - **The Dollar Scale Invariant:**
     - $\$1.00$ of reactivity corresponds exactly to $\rho = \beta \approx 0.0065$;
     - Operating at $\$ \ge 1.00$ triggers **Prompt Criticality**, bypassing delayed neutrons and causing instantaneous thermal power runaway!
2. **Slide 2 (`ordering`):** Provide 5 steps of criticality analysis: (1) calculate infinite medium four-factor product $k_\infty = \eta \cdot \epsilon \cdot p \cdot f$, (2) determine geometric buckling $B_g^2$ from core dimensions, (3) calculate fast and thermal non-leakage probabilities: $P_{\text{FNL}} = e^{-B^2 \tau}$ and $P_{\text{TNL}} = 1 / (1 + B^2 L^2)$, (4) compute effective multiplication factor: $k_{\text{eff}} = k_\infty \cdot P_{\text{FNL}} \cdot P_{\text{TNL}}$, (5) calculate core reactivity $\rho = (k_{\text{eff}} - 1) / k_{\text{eff}}$, converting to pcm ($\times 10^5$) and dollars ($\rho / \beta$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Thermal Utilization $f$, Resonance Escape $p$, Fast Fission Factor $\epsilon$, Reproduction Factor $\eta$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Reactivity (or Core Reactivity). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $k_{\text{eff}}$ and reactivity: A pressurized water reactor (PWR) fuel lattice has four-factor product $k_\infty = 1.0800$. The fast non-leakage probability is $P_{\text{FNL}} = 0.9500$ and thermal non-leakage probability is $P_{\text{TNL}} = 0.9800$. Delayed neutron fraction is $\beta = 0.00650$.
   - Effective multiplication factor:
     $k_{\text{eff}} = k_\infty \cdot P_{\text{FNL}} \cdot P_{\text{TNL}} = 1.0800 \times 0.9500 \times 0.9800 = 1.0260 \times 0.9800 = \mathbf{1.00548} \approx \mathbf{1.0055}$;
   - Reactivity $\rho$:
     $\rho = \frac{k_{\text{eff}} - 1}{k_{\text{eff}}} = \frac{1.00548 - 1.00000}{1.00548} = \frac{0.00548}{1.00548} = \mathbf{+0.005450} = \mathbf{+545.0\text{ pcm}}$;
   - Reactivity in Dollars:
     $\$ = \frac{\rho}{\beta} = \frac{0.005450}{0.00650} = \mathbf{+0.8385\ \$ \approx +0.84\ \$}$;
   - What are $k_{\text{eff}}$ and the reactivity in dollars? ($k_{\text{eff}} = \mathbf{1.0055}$ and Reactivity $= \mathbf{+0.84\ \$}$ [Delayed Supercritical]).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "six_factor_criticality_formula_and_reactivity_balance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Six-Factor Criticality \\& Reactivity (John R. Lamarsh)**\n• **Six-Factor Criticality Master Formulation:**\n$$\n\\mathbf{k_{\\text{eff}} = \\eta \\cdot \\epsilon \\cdot p \\cdot f \\cdot P_{\\text{FNL}} \\cdot P_{\\text{TNL}} = k_\\infty \\cdot P_{\\text{FNL}} \\cdot P_{\\text{TNL}}}\n$$\n  - **$\\eta$ (Reproduction Factor):** Neutrons produced per thermal absorption in fuel ($\\approx 2.06$ for U-235);\n  - **$\\epsilon$ (Fast Fission Factor):** Fast U-238 fission boost ($\\approx 1.04$);\n  - **$p$ (Resonance Escape):** Fraction avoiding U-238 resonance capture ($\\approx 0.88$);\n  - **$f$ (Thermal Utilization):** Fraction absorbed in fuel vs cladding/moderator;\n  - **$P_{\\text{FNL}}, P_{\\text{TNL}}$:** Fast and thermal non-leakage probabilities;\n• **Core Reactivity Master Formulation ($\\rho$):**\n$$\n\\mathbf{\\rho = \\frac{k_{\\text{eff}} - 1}{k_{\\text{eff}}} \\quad \\Big| \\quad \\rho_{\\text{pcm}} = \\rho \\times 10^5 \\quad \\Big| \\quad \\text{Dollars (\\$)} = \\frac{\\rho}{\\beta}}\n$$\n• **The Criticality Safety Boundary:** When $\\rho < \\beta$ ($\\$ < 1.00$), reactor power is safely governed by slow **delayed neutrons**; exceeding $1.00\\$$ ($\\rho \\ge \\beta$) causes catastrophic **Prompt Criticality**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the Six-Factor effective multiplication factor keff and reactivity in dollars for a reactor core.",
      "orderItems": [
        "Multiply the material four factors to obtain the infinite medium multiplication factor: k\u221e = \u03b7 * \u03b5 * p * f",
        "Calculate the fast non-leakage probability P_FNL = exp(-Bg^2 * \u03c4) from core geometric buckling",
        "Calculate the thermal non-leakage probability P_TNL = 1 / (1 + Bg^2 * L^2)",
        "Multiply to compute the finite core effective multiplication factor: keff = k\u221e * P_FNL * P_TNL",
        "Calculate core reactivity: \u03c1 = (keff - 1) / keff and divide by \u03b2 to determine reactivity in dollars ($ = \u03c1 / \u03b2)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Nuclear Criticality Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Reproduction Factor (\u03b7)", "right": "Average number of fast fission neutrons emitted per thermal neutron absorbed in fuel material" },
        { "left": "Thermal Utilization (f)", "right": "Ratio of thermal neutrons absorbed in fuel nuclei compared to total core absorption (\u03a3aF / \u03a3a)" },
        { "left": "Resonance Escape (p)", "right": "Probability that a slowing down neutron avoids radiative capture in sharp U-238 resonance peaks" },
        { "left": "Reactivity in Dollars ($)", "right": "Reactivity normalized by total delayed neutron fraction (\u03c1 / \u03b2) where 1.00$ marks prompt criticality" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In nuclear engineering, the dimensionless ratio representing the relative departure of a reactor from criticality \u03c1 = (keff - 1) / keff is defined as core ___.",
      "blankAnswer": "reactivity",
      "blankDistractors": ["flux", "power", "burnup"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A PWR core has k\u221e = 1.0800, P_FNL = 0.9500, P_TNL = 0.9800, and delayed neutron fraction \u03b2 = 0.00650. keff = 1.0800 * 0.9500 * 0.9800 = 1.00548 (\u2248 1.0055). \u03c1 = (1.00548 - 1) / 1.00548 = +0.005450 (+545.0 pcm). Reactivity in dollars is $ = 0.005450 / 0.00650 = +0.8385 $ (\u2248 +0.84 $). What are keff and the reactivity in dollars?",
      "options": [
        { "text": "keff = 1.0055 and Reactivity = +0.84 $ (keff = 1.00548; \u03c1 = +0.005450; $ = 0.005450 / 0.00650 = +0.8385 $ \u2248 +0.84 $, safely delayed supercritical)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Six-Factor criticality and reactivity formulas (John R. Lamarsh & Anthony J. Baratta *Introduction to Nuclear Engineering* Chapter 6; James J. Duderstadt *Nuclear Reactor Analysis* Chapter 6). 1. **Calculate Effective Multiplication Factor ($k_{\\text{eff}}$):** - Infinite multiplication factor: $k_\\infty = 1.0800$. - Fast non-leakage probability: $P_{\\text{FNL}} = 0.9500$. - Thermal non-leakage probability: $P_{\\text{TNL}} = 0.9800$. $$k_{\\text{eff}} = k_\\infty \\cdot P_{\\text{FNL}} \\cdot P_{\\text{TNL}} = 1.0800 \\times 0.9500 \\times 0.9800$$ $$k_{\\text{eff}} = 1.02600 \\times 0.9800 = \\mathbf{1.00548 \\approx 1.0055}$$ 2. **Calculate Core Reactivity ($\\rho$):** $$\\rho = \\frac{k_{\\text{eff}} - 1}{k_{\\text{eff}}} = \\frac{1.00548 - 1.00000}{1.00548} = \\frac{0.00548}{1.00548} = \\mathbf{+0.0054501}$$ - In percent mille: $$\\rho_{\\text{pcm}} = 0.0054501 \\times 10^5 = \\mathbf{+545.0\\text{ pcm}}$$ 3. **Calculate Reactivity in Dollars ($\\$$):** - Delayed neutron fraction: $\\beta = 0.00650$. $$\\$ = \\frac{\\rho}{\\beta} = \\frac{0.0054501}{0.00650} = \\mathbf{+0.83848\\ \\$ \\approx +0.84\\ \\$}$$ - Since $\\$ = +0.84\\ \\$ < +1.00\\ \\$ (i.e. $\\rho < \\beta$), the reactor operates safely in the **delayed supercritical** regime! Flawless nuclear criticality and reactivity derivation!" },
        { "text": "keff = 1.0800 and Reactivity = +1.23 $ (Ignored core leakage probabilities)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "keff = 0.9945 and Reactivity = -0.84 $ (Subtracted non-leakage probabilities instead of multiplying)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "keff = 1.0055 and Reactivity = +84.0 $ (Forgot factor of 100 in dollar normalization)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
