# Duofy Reusable Lesson Format: Tribological Regimes (Stribeck Curve & Petroff's Equation)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Bearing_Design_and_Lubrication`  
**Lesson Format Type:** `stribeck_curve_lubrication_regimes_and_petroff_friction_equation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through tribological lubrication regimes, coefficient of friction variations, the classic Stribeck curve, and Petroff's viscous shear friction law in rotating machinery (Richard Stribeck 1902; Nikolai Petroff 1883; Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 12; Robert L. Norton Chapter 14): master the **Stribeck Curve** relating friction coefficient $\mu$ to the dimensionless **Bearing Modulus / Hersey Parameter ($\mathbf{\frac{\mu N'}{P}}$)** across 3 distinct operating zones:
1. **Zone I: Boundary Lubrication:** At startup, shutdown, or extreme overload, fluid film collapses ($h_0 \to 0$); solid surface asperities rub directly against each other ($\mathbf{\mu \approx 0.08 - 0.15}$), causing rapid adhesive wear;
2. **Zone II: Mixed / Thin-Film Lubrication:** Unstable transition zone where fluid film carries part of the load and asperities carry the remainder ($\mu$ drops rapidly toward its minimum);
3. **Zone III: Full-Film Hydrodynamic Lubrication:** Complete fluid separation ($h_0 > \text{asperities}$); friction drops to an ultra-low minimum ($\mathbf{\mu \approx 0.001 - 0.005}$, zero wear); as speed $N'$ increases further, viscous shear causes $\mu$ to rise gently;
and derive **Petroff's Law for Unloaded Journal Viscous Friction Torque**:
$$\mathbf{T_f = \frac{2 \pi^2 \mu N' R^3 L}{c} \implies \mathbf{f = 2 \pi^2 \left(\frac{\mu N'}{P}\right)\left(\frac{R}{c}\right)}}$$

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The Stribeck Curve (Boundary $\to$ Mixed $\to$ Hydrodynamic) & Petroff's Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Petroff Friction Torque and Frictional Power Loss in a Journal Bearing Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Tribological Lubrication Regime / Viscous Term & Technical Physical Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Universal Tribology Diagram Plotting Friction Coefficient Versus Bearing Modulus (\mu*N/P) Is the ___ Curve (Stribeck) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Machine Tribology Problem: Calculating the Viscous Friction Torque in an Unloaded Journal Bearing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Stribeck Curve & Petroff (Budynas 2020; Stribeck 1902; Petroff 1883):
   - **Petroff's Law Formulation (Concentric Journal):**
     $$\mathbf{T_f = \frac{2 \pi^2 \mu N' R^3 L}{c} \quad \Big| \quad f = 2 \pi^2 \left(\frac{\mu N'}{P}\right)\left(\frac{R}{c}\right)}$$
   - **The Stribeck Curve Lubrication Regimes Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Lubrication Zone} & \textbf{Bearing Modulus } \frac{\mu N'}{P} & \textbf{Friction Coeff } \mu & \textbf{Tribological Contact State} \\
     \hline
     \mathbf{\text{Boundary Lubrication}} & \text{Very Low (Low speed/High load)} & \mu \approx 0.08 - 0.15 & \text{Direct metal asperity contact; high wear} \\
     \mathbf{\text{Mixed Lubrication}} & \text{Intermediate} & \mu \approx 0.02 - 0.08 & \text{Partial fluid film; occasional asperity touch} \\
     \mathbf{\text{Full Hydrodynamic}} & \mathbf{\text{Adequate Speed / Viscosity}} & \mathbf{\mu \approx 0.001 - 0.005} & \mathbf{\text{Zero metal contact; infinite bearing life!}} \\
     \hline
     \end{array}$$
   - **The Minimum Friction Invariant:** The minimum of the Stribeck curve marks the boundary where **full fluid film separation is achieved at the lowest possible viscous power loss**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Petroff friction analysis: (1) measure journal radius $R$, bearing length $L$, and radial clearance $c$, (2) determine shaft rotational speed $N'$ (rev/s) and dynamic lubricant viscosity $\mu$, (3) compute shear rate $\dot{\gamma} = \frac{2\pi R N'}{c}$ and viscous wall shear stress $\tau = \mu \dot{\gamma}$, (4) integrate shear stress over bearing surface area $A = 2\pi R L$ to calculate total friction torque $T_f = \frac{2\pi^2 \mu N' R^3 L}{c}$, (5) compute frictional power dissipation $P_{\text{friction}} = 2\pi N' T_f$ to size bearing oil cooling systems!
3. **Slide 3 (`matching`):** Pair 4 concepts (Boundary Lubrication, Mixed Lubrication, Full Hydrodynamic, Petroff's Equation) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Stribeck. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Petroff friction torque: An unloaded concentric journal bearing has radius $R = 40\text{ mm} = 0.040\text{ m}$, length $L = 80\text{ mm} = 0.080\text{ m}$, and radial clearance $c = 0.04\text{ mm} = 4.0 \times 10^{-5}\text{ m}$. It operates at $N' = 25\text{ rev/s}$ ($1500\text{ RPM}$) with lubricating oil viscosity $\mu = 0.030\text{ Pa}\cdot\text{s}$. What is the viscous friction torque $T_f$ resisting rotation? ($T_f = \frac{2 \pi^2 \mu N' R^3 L}{c} = \frac{2 \pi^2 (0.030\text{ Pa}\cdot\text{s})(25\text{ s}^{-1})(0.040\text{ m})^3 (0.080\text{ m})}{4.0 \times 10^{-5}\text{ m}} = \frac{2 (9.8696)(0.030)(25)(6.4 \times 10^{-5})(0.080)}{4.0 \times 10^{-5}} = \frac{14.8044 \times 5.12 \times 10^{-6}}{4.0 \times 10^{-5}} = \frac{7.5798 \times 10^{-5}}{4.0 \times 10^{-5}} \approx \mathbf{1.895\text{ N}\cdot\text{m} \approx 1.90\text{ N}\cdot\text{m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "stribeck_curve_lubrication_regimes_and_petroff_friction_equation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Stribeck Curve \\& Petroff's Viscous Friction Law (Petroff \\& Stribeck)**\n• **Petroff's Concentric Viscous Friction Formulation:**\n$$\n\\mathbf{T_f = \\frac{2 \\pi^2 \\mu N' R^3 L}{c} \\quad \\Big| \\quad f = 2 \\pi^2 \\left(\\frac{\\mu N'}{P}\\right)\\left(\\frac{R}{c}\\right) \\quad \\left(N' = \\frac{\\text{RPM}}{60}\\right)}\n$$\n• **The Stribeck Lubrication Regimes Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Regime Zone} & \\textbf{Bearing Modulus } \\frac{\\mu N'}{P} & \\textbf{Friction Coeff } \\mu & \\textbf{Physical Contact Mechanism} \\\\\n\\hline\n\\mathbf{\\text{Zone I: Boundary}} & \\text{Very Low (Low speed/High load)} & \\mu \\approx 0.08 - 0.15 & \\text{Direct metal asperity contact; high wear} \\\\\n\\mathbf{\\text{Zone II: Mixed}} & \\text{Intermediate} & \\mu \\approx 0.02 - 0.08 & \\text{Partial fluid film; occasional asperity touch} \\\\\n\\mathbf{\\text{Zone III: Full Film}} & \\mathbf{\\text{Adequate Speed / Viscosity}} & \\mathbf{\\mu \\approx 0.001 - 0.005} & \\mathbf{\\text{Complete fluid separation; zero solid wear!}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Hydrodynamic Minimum Invariant:** Operating at the lowest point of the Stribeck curve guarantees **complete metal separation at the absolute minimum frictional power dissipation**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the viscous friction torque and power loss in an operating journal bearing using Petroff's equation.",
      "orderItems": [
        "Record the bearing geometric dimensions: journal radius R, axial length L, and radial clearance c",
        "Convert shaft rotational speed from RPM to revolutions per second: N' = N_RPM / 60",
        "Determine the dynamic viscosity mu of the lubricant at the operating film temperature",
        "Calculate the viscous friction torque resisting shaft rotation: T_f = (2 * pi^2 * mu * N' * R^3 * L) / c",
        "Compute the rate of frictional heat energy generated: H_gen = 2 * pi * N' * T_f in Watts"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Tribology Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Boundary Lubrication", "right": "Regime where oil film fails and load is supported by direct metal-to-metal asperity contact" },
        { "left": "Hydrodynamic Lubrication", "right": "Full fluid film regime (\u03bc \u2248 0.001) where surfaces are completely separated by fluid pressure" },
        { "left": "Petroff's Equation", "right": "T_f = (2*\u03c0^2 * \u03bc * N' * R^3 * L) / c, calculating viscous shear friction torque in a concentric bearing" },
        { "left": "Bearing Modulus (\u03bc*N' / P)", "right": "Dimensionless grouping governing the transition across lubrication regimes on the Stribeck curve" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The universal tribological diagram plotting the friction coefficient versus the bearing modulus (\u03bc*N'/P) is the ___ curve.",
      "blankAnswer": "Stribeck",
      "blankDistractors": ["Reynolds", "Sommerfeld", "Moody"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An unloaded journal bearing has radius R = 40 mm, length L = 80 mm, and radial clearance c = 0.04 mm (4*10^-5 m). The shaft rotates at N' = 25 rev/s (1500 RPM) with oil viscosity \u03bc = 0.030 Pa·s. What is the viscous friction torque T_f resisting rotation?",
      "options": [
        { "text": "T_f = 1.90 N·m (Calculated from T_f = 2 * pi^2 * 0.030 * 25 * (0.040)^3 * 0.080 / (4*10^-5) = 1.895 N·m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Petroff's viscous friction equation (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 12). 1. **Petroff's Friction Torque Formula:** $$T_f = \\frac{2 \\pi^2 \\mu N' R^3 L}{c}$$ 2. **Substitute Given Numerical Values:** - $\\mu = 0.030\\text{ Pa}\\cdot\\text{s}$. - $N' = 25\\text{ rev/s}$. - $R = 0.040\\text{ m} \\implies R^3 = (0.040)^3 = 6.4 \\times 10^{-5}\\text{ m}^3$. - $L = 0.080\\text{ m}$. - $c = 0.04\\text{ mm} = 4.0 \\times 10^{-5}\\text{ m}$. 3. **Calculation:** $$T_f = \\frac{2 \\pi^2 (0.030)(25)(6.4 \\times 10^{-5})(0.080)}{4.0 \\times 10^{-5}}$$ $$T_f = \\frac{2 (9.8696)(0.75)(5.12 \\times 10^{-6})}{4.0 \\times 10^{-5}} = \\frac{14.8044 \\times 5.12 \\times 10^{-6}}{4.0 \\times 10^{-5}} = \\frac{7.57985 \\times 10^{-5}}{4.0 \\times 10^{-5}} \\approx \\mathbf{1.89496\\text{ N}\\cdot\\text{m} \\approx 1.90\\text{ N}\\cdot\\text{m}}$$ 4. **Power Dissipation:** $$P_{\\text{loss}} = 2 \\pi N' T_f = 2 \\pi (25)(1.895) \\approx \\mathbf{297.7\\text{ Watts}}$$ Flawless Petroff calculation!" },
        { "text": "T_f = 0.95 N·m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T_f = 3.80 N·m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T_f = 0.19 N·m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
