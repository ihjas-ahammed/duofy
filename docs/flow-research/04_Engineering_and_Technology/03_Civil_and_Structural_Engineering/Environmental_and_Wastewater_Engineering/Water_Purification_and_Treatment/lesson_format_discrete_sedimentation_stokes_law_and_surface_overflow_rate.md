# Duofy Reusable Lesson Format: Clarification (Stokes' Settling & Surface Overflow Rates)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Water_Purification_and_Treatment`  
**Lesson Format Type:** `discrete_sedimentation_stokes_law_and_surface_overflow_rate`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Type 1 discrete non-flocculent particle settling in sedimentation clarifiers, terminal settling velocity derivation via Stokes' Law, Allen Hazen's ideal rectangular horizontal-flow settling basin model, the fundamental concept of **Surface Overflow Rate ($\text{SOR} = v_0 = Q / A_s$)**, $100\%$ particle capture condition ($v_s \ge v_0$), fractional removal of smaller particles ($F_i = v_{s,i} / v_0$), weir overflow loading rate ($\text{WLR}$), and the mathematical proof that clarifier removal efficiency depends strictly on surface area ($A_s$), completely independent of tank depth ($H$) (Mackenzie L. Davis *Water and Wastewater Engineering* 2nd ed. Chapter 7; Metcalf & Eddy *Wastewater Engineering* Chapter 5): formulate **Stokes' Law Settling Velocity**:
$$\mathbf{v_s = \frac{g \left( \rho_p - \rho_w \right) d^2}{18 \mu} \quad [\text{m/s}] \quad (\text{Valid for particle Reynolds number } Re_p = \frac{\rho_w v_s d}{\mu} < 1.0)}$$
where:
1. **$g$:** Gravitational acceleration ($9.81\text{ m/s}^2$);
2. **$\rho_p$:** Particle mass density (e.g. $\rho_{\text{sand}} \approx 2650\text{ kg/m}^3, \rho_{\text{floc}} \approx 1050\text{ kg/m}^3$);
3. **$\rho_w$:** Water density ($998.2\text{ kg/m}^3$ at $20^\circ\text{C}$);
4. **$d$:** Particle diameter in meters;
5. **$\mu$:** Water dynamic viscosity ($1.002 \times 10^{-3}\text{ Pa}\cdot\text{s}$);
formulate **Hazen's Surface Overflow Rate (SOR / $v_0$) & Capture Criteria**:
$$\mathbf{\text{SOR} = v_0 = \frac{Q}{A_s} = \frac{Q}{L \cdot W} \quad [\text{m/s} \text{ or } \text{m}^3\text{/m}^2/\text{day}]}$$
$$\mathbf{\text{Percent Removal } \eta = \begin{cases} 100\% & \text{if } v_s \ge v_0 \\ \left( \frac{v_s}{v_0} \right) \times 100\% & \text{if } v_s < v_0 \end{cases}}$$
(proving that shallow sedimentation basins and plate/tube settlers achieve the exact same solids removal as deep clarifiers while requiring a fraction of the footprint volume).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Stokes' Law ($v_s = \frac{g(\rho_p-\rho)d^2}{18\mu}$), Hazen's SOR ($v_0 = Q/A_s$) & Removal Fraction ($v_s/v_0$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Settling Velocity, Surface Area, and Percent Solids Removal Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sedimentation Parameter / Clarifier Dimension & Technical Environmental Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In an Ideal Horizontal-Flow Sedimentation Basin, a Particle Whose Settling Velocity $v_s$ Is Less Than the Surface Overflow Rate $v_0$ Has a Removal Efficiency Exactly Equal to $v_s$ Divided by ___ (v_0 / Surface Overflow Rate / SOR) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Water Treatment Problem: Computing Stokes' Settling Velocity vs, Required Clarifier Area As, and Sand Removal Efficiency Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Discrete Sedimentation & Hazen Clarification (Hazen 1904; Stokes 1851; Davis 2020):
   - **Settling & Clarification Formulations:**
     $$\mathbf{v_s = \frac{g(\rho_p - \rho_w)d^2}{18\mu} \quad \Big| \quad v_0 = \text{SOR} = \frac{Q}{A_s} \quad \Big| \quad \text{Removal Fraction: } F = \min\left(1.0, \frac{v_s}{v_0}\right) \quad \Big| \quad \text{WLR} = \frac{Q}{L_{\text{weir}}}}$$
   - **Sedimentation Regimes Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Settling Type} & \textbf{Particle Interaction} & \textbf{Governing Theory} & \textbf{Treatment Unit Location} \\
     \hline
     \mathbf{\text{Type 1 (Discrete)}} & \text{Non-flocculent, isolated sand/silt} & \mathbf{\text{Stokes' Law }} (v_s \propto d^2) & \text{Grit chambers, raw sand pre-settling} \\
     \mathbf{\text{Type 2 (Flocculent)}} & \text{Particles agglomerate as they fall} & \text{Empirical settling column} & \text{Primary clarifiers, alum floc basins} \\
     \mathbf{\text{Type 3 (Zone / Hindered)}} & \text{Inter-particle blanket settling} & \text{Kynch flux theory} & \text{Secondary clarifiers (activated sludge)} \\
     \mathbf{\text{Type 4 (Compression)}} & \text{Compaction of bottom sludge} & \text{Consolidation theory} & \text{Sludge thickeners} \\
     \hline
     \end{array}$$
   - **The Depth Independence Invariant:** Hazen's theorem proves that **clarifier capacity depends solely on surface area ($A_s = L \times W$)**, not depth ($H$); doubling length doubles solids removal, but doubling depth only increases detention time without changing the critical capture velocity $v_0$!
2. **Slide 2 (`ordering`):** Provide 5 steps of clarifier design: (1) determine plant flow rate $Q$ and target discrete particle diameter $d$ and density $\rho_p$, (2) calculate terminal settling velocity using Stokes' Law: $v_s = \frac{g(\rho_p - \rho)d^2}{18\mu}$, (3) set design surface overflow rate $v_0 \le v_s$ for $100\%$ removal of design particles, (4) calculate required clarifier surface area: $A_s = Q / v_0$, (5) select length-to-width aspect ratio ($L/W \ge 4:1$) and check weir overflow loading rate: $\text{WLR} = Q / L_{\text{weir}} \le 250\text{ m}^3\text{/m/day}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Stokes' Settling Velocity $v_s$, Surface Overflow Rate $v_0$, Depth Independence, Weir Loading Rate) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of v_0 (or Surface Overflow Rate / SOR). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Stokes' velocity and clarifier removal: A grit chamber treats $Q = 0.20\text{ m}^3\text{/s} = 17,280\text{ m}^3\text{/day}$ with surface area $A_s = 50.0\text{ m}^2$ (Surface overflow rate $v_0 = \frac{0.20}{50.0} = 0.0040\text{ m/s} = 4.0\text{ mm/s}$). Water has $\rho = 1000\text{ kg/m}^3, \mu = 1.0 \times 10^{-3}\text{ Pa}\cdot\text{s}$. Sand particles have density $\rho_p = 2650\text{ kg/m}^3$ and diameter $d = 0.10\text{ mm} = 1.0 \times 10^{-4}\text{ m}$ ($d^2 = 1.0 \times 10^{-8}\text{ m}^2$).
   - Stokes settling velocity:
     $$v_s = \frac{9.81 \times (2650 - 1000) \times (1.0 \times 10^{-8})}{18 \times (1.0 \times 10^{-3})} = \frac{9.81 \times 1650 \times 10^{-8}}{0.018} = \frac{1.61865 \times 10^{-4}}{0.018} = \mathbf{0.00899\text{ m/s} = 8.99\text{ mm/s}}$$;
   - What is the settling velocity $v_s$ and the removal efficiency of these $0.10\text{ mm}$ sand particles in the basin? ($v_s = \mathbf{8.99\text{ mm/s}}$; since $v_s = 8.99\text{ mm/s} > v_0 = 4.0\text{ mm/s}$, removal is $\mathbf{100\%}$!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "discrete_sedimentation_stokes_law_and_surface_overflow_rate",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Discrete Sedimentation \\& Hazen's Law (Allen Hazen \\& Stokes)**\n• **Stokes' Law Terminal Settling Velocity Formulation:**\n$$\n\\mathbf{v_s = \\frac{g \\left( \\rho_p - \\rho_w \\right) d^2}{18 \\mu} \\quad [\\text{m/s}] \\quad (\\text{Valid for Laminar } Re_p < 1.0)}\n$$\n  - **$\\rho_p, \\rho_w$:** Particle and water densities ($\\text{kg/m}^3$);\n  - **$d$:** Particle diameter ($\\text{m}$);\n  - **$\\mu$:** Dynamic viscosity of water ($\\approx 1.002 \\times 10^{-3}\\text{ Pa}\\cdot\\text{s}$);\n• **Surface Overflow Rate (SOR / $v_0$) \\& Removal Fraction:**\n$$\n\\mathbf{\\text{SOR} = v_0 = \\frac{Q}{A_s} = \\frac{Q}{L \\cdot W} \\quad [\\text{m/s}]}\n$$\n$$\n\\mathbf{\\text{Removal Efficiency } \\eta = \\begin{cases} 100\\% & \\text{if } v_s \\ge v_0 \\\\ \\left( \\frac{v_s}{v_0} \\right) \\times 100\\% & \\text{if } v_s < v_0 \\end{cases}}\n$$\n• **Hazen's Depth Independence Invariant:** Clarifier solids removal depends **strictly on the plan surface area ($A_s$)**, completely independent of tank water depth $H$; shallow settling plates achieve identical removal in 90% less volume!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a discrete particle sedimentation basin for 100% removal of target sand particles.",
      "orderItems": [
        "Determine the design volumetric flow rate Q and target particle characteristics (diameter d and density \u03c1p)",
        "Calculate the terminal settling velocity vs of the target particle using Stokes' Law: vs = [ g*(\u03c1p - \u03c1w)*d^2 ] / (18*\u03bc)",
        "Set the design Surface Overflow Rate v0 equal to or less than vs to guarantee 100% capture: v0 \u2264 vs",
        "Calculate the required clarifier plan surface area: As = Q / v0",
        "Establish basin geometry (length-to-width ratio L/W \u2265 4:1) and verify weir overflow loading rate: WLR = Q / Lweir \u2264 250 m^3/m/day"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Sedimentation Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Stokes' Settling Velocity (vs)", "right": "Terminal gravity velocity where drag equals buoyant particle weight, scaling quadratically with diameter (d^2)" },
        { "left": "Surface Overflow Rate (v0)", "right": "SOR = Q / As, critical upward velocity threshold defining the slowest-settling particle removed at 100%" },
        { "left": "Fractional Removal (vs / v0)", "right": "Proportion of sub-critical particles (vs < v0) captured because they entered in lower vertical strata" },
        { "left": "Depth Independence", "right": "Hazen's principle showing clarifying capacity is solely a function of floor plan area As, not tank depth" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an ideal sedimentation basin, a discrete particle whose settling velocity vs is less than the surface overflow rate v0 has a removal efficiency exactly equal to vs divided by ___.",
      "blankAnswer": "v0",
      "blankDistractors": ["vs", "Q", "As"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A settling basin has Q = 0.20 m^3/s and surface area As = 50.0 m^2 (v0 = 0.0040 m/s = 4.0 mm/s). Water viscosity is \u03bc = 0.0010 Pa*s, \u03c1w = 1000 kg/m^3. Sand particles have \u03c1p = 2650 kg/m^3 and diameter d = 0.10 mm (10^-4 m). What is Stokes' settling velocity vs and what percent of these sand particles are removed?",
      "options": [
        { "text": "vs = 8.99 mm/s and 100% removal (vs = 9.81 * (2650 - 1000) * (10^-4)^2 / (18 * 0.0010) = 9.81 * 1650 * 10^-8 / 0.018 = 0.00899 m/s = 8.99 mm/s; since vs = 8.99 mm/s > v0 = 4.0 mm/s, removal is 100%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Stokes' Law and Hazen's sedimentation theory (Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 7). 1. **Identify Given Physical Parameters:** - Flow rate: $Q = 0.20\\text{ m}^3\\text{/s}$. - Basin surface area: $A_s = 50.0\\text{ m}^2$. - Water density: $\\rho_w = 1000\\text{ kg/m}^3$. - Particle density: $\\rho_p = 2650\\text{ kg/m}^3 \\implies \\Delta\\rho = 2650 - 1000 = \\mathbf{1650\\text{ kg/m}^3}$. - Particle diameter: $d = 0.10\\text{ mm} = 1.0 \\times 10^{-4}\\text{ m} \\implies d^2 = \\mathbf{1.0 \\times 10^{-8}\\text{ m}^2}$. - Water dynamic viscosity: $\\mu = 1.00 \\times 10^{-3}\\text{ Pa}\\cdot\\text{s}$. 2. **Calculate Surface Overflow Rate ($v_0$):** $$v_0 = \\frac{Q}{A_s} = \\frac{0.20\\text{ m}^3\\text{/s}}{50.0\\text{ m}^2} = 0.0040\\text{ m/s} = \\mathbf{4.00\\text{ mm/s}}$$ 3. **Calculate Stokes' Terminal Settling Velocity ($v_s$):** $$v_s = \\frac{g (\\rho_p - \\rho_w) d^2}{18 \\mu} = \\frac{9.81\\text{ m/s}^2 \\times (1650\\text{ kg/m}^3) \\times (1.0 \\times 10^{-8}\\text{ m}^2)}{18 \\times (1.00 \\times 10^{-3}\\text{ Pa}\\cdot\\text{s})}$$ $$v_s = \\frac{1.61865 \\times 10^{-4}}{0.018} = \\mathbf{0.0089925\\text{ m/s} = 8.9925\\text{ mm/s} \\approx 8.99\\text{ mm/s}}$$ 4. **Calculate Particle Removal Efficiency ($\\eta$):** - Comparing settling velocity to overflow rate: $$v_s = 8.9925\\text{ mm/s} > v_0 = 4.00\\text{ mm/s}$$ - Therefore, every single particle of this diameter hits the basin floor before reaching the effluent weir: $$\\mathbf{\\eta = 100\\% \\text{ Removal Efficiency!}}$$ Flawless Stokes' settling velocity and Hazen clarifier removal derivation!" },
        { "text": "vs = 4.50 mm/s and 100% removal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "vs = 8.99 mm/s and 44.5% removal (Inverted the ratio v0/vs)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "vs = 2.25 mm/s and 56.3% removal", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
