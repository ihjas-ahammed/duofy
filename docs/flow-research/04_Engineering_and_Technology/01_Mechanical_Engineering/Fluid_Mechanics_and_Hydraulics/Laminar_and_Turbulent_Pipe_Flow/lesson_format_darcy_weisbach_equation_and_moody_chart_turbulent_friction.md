# Duofy Reusable Lesson Format: Turbulent Friction (Darcy-Weisbach & Moody Diagram)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Laminar_and_Turbulent_Pipe_Flow`  
**Lesson Format Type:** `darcy_weisbach_equation_and_moody_chart_turbulent_friction`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through turbulent wall boundary layers, major frictional head loss, relative surface roughness, and the universal Moody diagram in hydraulic engineering (Henry Darcy 1857; Julius Weisbach 1845; Lewis Ferry Moody 1944; Frank M. White *Fluid Mechanics* Chapter 6): master the **Darcy-Weisbach Master Head Loss Equation**:
$$\mathbf{h_f = f \frac{L}{D} \frac{V^2}{2g} \quad [\text{meters}] \quad \Longleftrightarrow \quad \mathbf{\Delta P_f = f \frac{L}{D} \frac{\rho V^2}{2} \quad [\text{Pascals}]}}$$
master the **Four Regimes of the Moody Diagram**: (1) **Laminar Flow ($\mathbf{f = \frac{64}{Re}}$)**, (2) **Critical Transition Region ($2300 < Re < 4000$)**, (3) **Smooth-Pipe Turbulent Regime (Blasius Formula $\mathbf{f = 0.3164 Re^{-0.25}}$)** (where the thin viscous laminar sublayer completely submerged surface roughness peaks $\delta_v > \epsilon$), and (4) **Completely Turbulent / Fully Rough Pipe Flow (Von Kármán Equation $\mathbf{\frac{1}{\sqrt{f}} = -2.0 \log_{10}\left(\frac{\epsilon / D}{3.7}\right)}$)** (where roughness protrusions puncture the sublayer, shedding form eddies and causing $f$ to become a horizontal constant **dependent ONLY on relative roughness $\mathbf{\frac{\epsilon}{D}}$ and completely independent of Reynolds Number $Re$**); and solve the **Colebrook-White Implicit Equation**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Darcy-Weisbach Equation ($h_f = f \frac{L}{D} \frac{V^2}{2g}$) & 4 Moody Chart Regimes Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution to Determine Friction Factor f and Calculate Major Head Loss in a Turbulent Pipe Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Moody Chart Flow Regime / Boundary Characteristic & Mathematical Formulation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Completely Rough Turbulent Regime, the Friction Factor f Depends Exclusively on Relative ___ (\epsilon / D) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hydraulic Engineering Analysis: Why Friction Factor Curves Become Completely Horizontal at High Reynolds Numbers Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Darcy-Weisbach & Moody (White 2016; Moody 1944):
   - **Darcy-Weisbach Formulation:**
     $$\mathbf{h_f = f \frac{L}{D} \frac{V^2}{2g} \quad \Big| \quad \Delta P_f = f \frac{L}{D} \frac{\rho V^2}{2}}$$
   - **Moody Chart Regimes Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Flow Regime} & \textbf{Reynolds Range} & \textbf{Friction Factor Formula } f & \textbf{Roughness Sensitivity} \\
     \hline
     \mathbf{\text{Laminar Flow}} & Re \le 2300 & \mathbf{f = \frac{64}{Re}} & \mathbf{\text{0\% Independent of } \epsilon / D} \\
     \mathbf{\text{Smooth Turbulent}} & 4000 < Re < 10^5 & \mathbf{f = 0.3164 Re^{-0.25} \text{ (Blasius)}} & \text{Viscous sublayer covers roughness} \\
     \mathbf{\text{Transitional Turbulent}} & 4000 < Re < 10^7 & \frac{1}{\sqrt{f}} = -2.0 \log\left(\frac{\epsilon/D}{3.7} + \frac{2.51}{Re\sqrt{f}}\right) & \text{Depends on BOTH } Re \text{ and } \epsilon/D \\
     \mathbf{\text{Completely Rough}} & Re \to \infty & \mathbf{\frac{1}{\sqrt{f}} = -2.0 \log_{10}\left(\frac{\epsilon / D}{3.7}\right)} & \mathbf{\text{Horizontal lines: ONLY on } \epsilon / D!} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of turbulent head loss calculation: (1) look up fluid density $\rho$, viscosity $\mu$, and pipe equivalent sand roughness $\epsilon$ (e.g. commercial steel $\epsilon = 0.045\text{ mm}$), (2) calculate Reynolds number $Re = \frac{\rho V D}{\mu}$ and relative roughness ratio $\frac{\epsilon}{D}$, (3) determine whether flow is smooth, transitional, or completely rough on the Moody diagram, (4) look up or calculate Darcy friction factor $f$ using the Colebrook equation or Haaland approximation, (5) apply Darcy-Weisbach equation $h_f = f \frac{L}{D} \frac{V^2}{2g}$ to find frictional head loss!
3. **Slide 3 (`matching`):** Pair 4 concepts (Darcy-Weisbach Equation, Blasius Smooth Formula, Colebrook-White Equation, Fully Rough Regime) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Roughness. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why friction factor curves become horizontal at high $Re$: On the Moody diagram for turbulent pipe flow, why do the friction factor ($f$) curves flatten into completely horizontal lines at very high Reynolds numbers (the 'Fully Rough' regime), making $f$ completely independent of the Reynolds number? (Near the pipe wall, a laminar viscous sublayer exists at moderate $Re$; **as the Reynolds number becomes extremely high ($Re \to \infty$), the laminar sublayer becomes so paper-thin that the microscopic pipe wall roughness asperities ($\epsilon$) protrude completely into the high-velocity turbulent core; viscous shear is overwhelmed by turbulent form drag (eddy shedding behind rough surface peaks), which scales purely with dynamic pressure $\frac{1}{2}\rho V^2$, making friction factor $f$ a constant dependent ONLY on the geometric relative roughness $\frac{\epsilon}{D}$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "darcy_weisbach_equation_and_moody_chart_turbulent_friction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Darcy-Weisbach Equation \\& The Moody Diagram (Lewis F. Moody 1944)**\n• **Darcy-Weisbach Major Frictional Head Loss Formulation:**\n$$\n\\mathbf{h_f = f \\frac{L}{D} \\frac{V^2}{2g} \\ [\\text{meters}] \\quad \\Longleftrightarrow \\quad \\mathbf{\\Delta P_f = f \\frac{L}{D} \\frac{\\rho V^2}{2} \\ [\\text{Pa}]}}\n$$\n• **The 4 Moody Diagram Flow Regimes:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Regime Profile} & \\textbf{Reynolds Index } Re & \\textbf{Friction Factor Formula } f & \\textbf{Dominant Mechanism} \\\\\n\\hline\n\\mathbf{\\text{Laminar Line}} & Re \\le 2300 & \\mathbf{f = 64 / Re} & \\text{Viscous shear (Independent of } \\epsilon) \\\\\n\\mathbf{\\text{Smooth Pipe Limit}} & Re \\ge 4000 & \\mathbf{f \\approx 0.3164 Re^{-0.25}} & \\text{Laminar sublayer buries roughness} \\\\\n\\mathbf{\\text{Transitional Turbulent}} & \\text{Moderate } Re & \\frac{1}{\\sqrt{f}} = -2 \\log\\left(\\frac{\\epsilon/D}{3.7} + \\frac{2.51}{Re\\sqrt{f}}\\right) & \\text{Combined viscous \\& rough eddy drag} \\\\\n\\mathbf{\\text{Fully Rough Regime}} & \\mathbf{Re \\to \\infty} & \\mathbf{\\frac{1}{\\sqrt{f}} = -2.0 \\log_{10}\\left(\\frac{\\epsilon / D}{3.7}\\right)} & \\mathbf{\\text{Form drag only: Independent of } Re!} \\\\\n\\hline\n\\end{array}\n$$\n• **The Invariant Law:** In the fully rough regime, $f$ curves are **completely horizontal**, governed **ONLY by Relative Roughness ($\\mathbf{\\epsilon / D}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the Darcy friction factor f and compute the major frictional head loss in a turbulent water pipeline.",
      "orderItems": [
        "Determine the fluid properties (density rho, dynamic viscosity mu) and look up pipe equivalent roughness \u03b5 (e.g. cast iron)",
        "Calculate the Reynolds number Re = rho * V * D / mu and compute the relative roughness ratio \u03b5 / D",
        "Locate the Reynolds number on the horizontal axis and relative roughness curve on the right-hand axis of the Moody diagram",
        "Trace the intersection point to the left vertical axis to read the Darcy friction factor f (or solve Colebrook's equation)",
        "Substitute f into the Darcy-Weisbach equation: h_f = f * (L / D) * (V^2 / 2g) to calculate total major head loss in meters"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Turbulent Pipe Flow Principle to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Darcy-Weisbach Equation", "right": "h_f = f * (L/D) * (V^2 / 2g), calculating major head loss for any fluid in any pipe regime" },
        { "left": "Colebrook Equation", "right": "Implicit transcendental equation combining smooth and rough turbulent friction factors" },
        { "left": "Relative Roughness (\u03b5 / D)", "right": "Dimensionless ratio of microscopic surface roughness height \u03b5 to internal pipe diameter D" },
        { "left": "Fully Rough Turbulent Regime", "right": "Region where friction factor curves flatten horizontally and depend exclusively on \u03b5 / D" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the completely rough turbulent regime on the Moody chart, the friction factor f depends exclusively on relative ___.",
      "blankAnswer": "roughness",
      "blankDistractors": ["viscosity", "velocity", "density"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "On the Moody diagram for turbulent pipe flow, why do the friction factor (f) curves become completely horizontal at very high Reynolds numbers (the 'Fully Rough' regime), making f completely independent of the Reynolds number?",
      "options": [
        { "text": "At very high Reynolds numbers, the laminar viscous sublayer near the pipe wall becomes so extraordinarily thin that the microscopic surface roughness asperities (\u03b5) protrude completely into the high-speed turbulent core flow; this completely destroys viscous boundary layer shearing and causes frictional resistance to be dominated entirely by pressure drag (form drag and eddy wake shedding behind individual roughness peaks), which scales strictly with dynamic pressure (rho*V^2/2), resulting in a constant friction factor f that depends ONLY on the geometric relative roughness ratio \u03b5/D", "isCorrect": true, "explanation": "Correct! This is Frank M. White and Lewis Moody's fundamental fluid mechanics explanation for the fully rough turbulent regime (*Fluid Mechanics* Chapter 6). 1. **The Laminar Sublayer Mechanism:** - Near the wall, a laminar sublayer of thickness $\\delta_v \\approx \\frac{5 \\nu}{u^*}$ exists. - In smooth pipes at low $Re$, $\\delta_v > \\epsilon$ (the roughness peaks are completely buried inside the smooth viscous sublayer). 2. **What Happens as $Re \\to \\infty$:** - Velocity $V$ increases $\\implies$ Viscous sublayer thickness $\\delta_v$ shrinks to zero! - The microscopic roughness peaks $\\epsilon$ stick out directly into the turbulent flow! 3. **Viscous Shear vs Form Drag:** - Fluid slamming into roughness protrusions creates **eddy wakes and form drag** (like air hitting a brick wall). - Form drag is proportional to $V^2$ with a constant drag coefficient $C_D$. - Therefore, total wall shear stress $\\tau_w \\propto \\rho V^2$ without any viscosity $\\mu$ dependence! - **Result:** The Darcy friction factor $f = \\frac{8 \\tau_w}{\\rho V^2}$ becomes a **pure geometric constant depending ONLY on $\\frac{\\epsilon}{D}$**, and the Moody curves become **100% horizontal lines**!" },
        { "text": "Because water stops experiencing friction when traveling faster than 10 m/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because high Reynolds numbers convert liquid water into a solid block", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Moody chart only has room for horizontal lines on the right side", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
