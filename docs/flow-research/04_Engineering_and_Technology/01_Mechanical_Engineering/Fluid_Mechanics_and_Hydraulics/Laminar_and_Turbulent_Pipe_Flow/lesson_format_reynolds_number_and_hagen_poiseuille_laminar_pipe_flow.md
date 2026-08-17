# Duofy Reusable Lesson Format: Laminar Flow (Hagen-Poiseuille & Velocity Profiles)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Laminar_and_Turbulent_Pipe_Flow`  
**Lesson Format Type:** `reynolds_number_and_hagen_poiseuille_laminar_pipe_flow`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through viscous internal flows, Reynolds transition criteria, and analytical Hagen-Poiseuille parabolic velocity solutions in circular pipes (Gotthilf Hagen 1839; Jean Poiseuille 1840; Frank M. White *Fluid Mechanics* Chapter 6; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 8): master the **Reynolds Number ($\mathbf{Re = \frac{\rho V D}{\mu} = \frac{V D}{\nu}}$)**, master the **Critical Pipe Transition Criteria** (Laminar: $\mathbf{Re \le 2300}$, Transition: $2300 < Re < 4000$, Fully Turbulent: $\mathbf{Re \ge 4000}$), derive the **Hagen-Poiseuille Parabolic Velocity Distribution**:
$$\mathbf{u(r) = u_{\text{max}}\left(1 - \frac{r^2}{R^2}\right) \quad \Big| \quad u_{\text{max}} = 2 V_{\text{avg}} = -\frac{R^2}{4\mu}\left(\frac{dP}{dx}\right)}$$
(proving why centerline velocity is **exactly twice the cross-sectional average velocity $u_{\text{max}} = 2 V_{\text{avg}}$**), derive the **Hagen-Poiseuille Pressure Drop Equation**:
$$\mathbf{\Delta P_{\text{laminar}} = \frac{32 \mu L V_{\text{avg}}}{D^2} = \frac{128 \mu L Q}{\pi D^4} \implies \mathbf{f_{\text{laminar}} = \frac{64}{Re}}}$$
and analyze why laminar friction factor $f = 64/Re$ is **completely independent of pipe wall surface roughness $\epsilon$**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Reynolds Number ($Re = \frac{\rho V D}{\mu}$), Hagen-Poiseuille Parabolic Profile & $f = 64/Re$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Calculation of Velocity Profile, Wall Shear Stress, and Pressure Drop in Laminar Flow Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Viscous Laminar Flow Parameter / Boundary Condition & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Fully Developed Laminar Pipe Flow, the Maximum Centerline Velocity Is Exactly ___ Times the Average Flow Velocity (2 / Two) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Viscous Fluid Dynamics Problem: Calculating the Pressure Drop of Heavy Lubricating Oil in a Horizontal Pipe Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hagen-Poiseuille Flow (White 2016; Munson 2016):
   - **Hagen-Poiseuille Formulations:**
     $$\mathbf{u(r) = u_{\text{max}}\left(1 - \frac{r^2}{R^2}\right) \quad \Big| \quad u_{\text{max}} = 2 V_{\text{avg}} \quad \Big| \quad \tau_w = \frac{4 \mu V_{\text{avg}}}{R}}$$
   - **Laminar Flow Pressure Drop & Friction Factor:**
     $$\mathbf{\Delta P = \frac{32 \mu L V_{\text{avg}}}{D^2} = \frac{128 \mu L Q}{\pi D^4} \quad \Longleftrightarrow \quad \mathbf{h_f = \frac{64}{Re} \frac{L}{D} \frac{V^2}{2g}} \quad \left(f = \frac{64}{Re}\right)}$$
   - **The Laminar Independence Invariant:** In laminar flow ($Re \le 2300$), fluid layers slide smoothly over each other in concentric cylindrical sheaths without microscopic wall turbulence $\implies$ **Friction factor $f = 64/Re$ is 100% INDEPENDENT of pipe surface roughness $\epsilon$!**
2. **Slide 2 (`ordering`):** Provide 5 steps of laminar pipe flow analysis: (1) calculate Reynolds number $Re = \frac{\rho V D}{\mu}$ to verify that $Re \le 2300$ (laminar flow), (2) determine hydrodynamic entrance length $L_e \approx 0.06 Re \cdot D$ to ensure flow is fully developed, (3) calculate the maximum centerline velocity $u_{\text{max}} = 2 V_{\text{avg}}$, (4) evaluate wall shear stress $\tau_w = \frac{4 \mu V_{\text{avg}}}{R} = \frac{\Delta P \cdot D}{4 L}$, (5) compute total viscous pressure drop $\Delta P = \frac{128 \mu L Q}{\pi D^4}$ and required pumping power $\text{Power} = Q \Delta P$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Reynolds Number $Re$, Hagen-Poiseuille Pressure Drop, Peak Velocity $u_{\text{max}} = 2 V_{\text{avg}}$, Laminar Friction Factor $f=64/Re$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 2 (or Two). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating laminar pressure drop: Heavy lubricating oil ($\rho = 900\text{ kg/m}^3$, dynamic viscosity $\mu = 0.20\text{ Pa}\cdot\text{s}$) flows through a horizontal pipe of diameter $D = 0.05\text{ m}$ ($R = 0.025\text{ m}$) and length $L = 50\text{ m}$ at an average velocity $V_{\text{avg}} = 1.0\text{ m/s}$. What is the viscous pressure drop $\Delta P$ along the pipe? ($Re = \frac{\rho V D}{\mu} = \frac{(900)(1.0)(0.05)}{0.20} = \frac{45}{0.20} = 225 \le 2300$ (Laminar!); $\Delta P = \frac{32 \mu L V_{\text{avg}}}{D^2} = \frac{32(0.20\text{ Pa}\cdot\text{s})(50\text{ m})(1.0\text{ m/s})}{(0.05\text{ m})^2} = \frac{320}{0.0025} = 128,000\text{ Pa} = \mathbf{128\text{ kPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "reynolds_number_and_hagen_poiseuille_laminar_pipe_flow",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hagen-Poiseuille Laminar Pipe Flow \\& Reynolds Criteria (Frank M. White)**\n• **Reynolds Number Transition Spectrum:**\n$$\n\\mathbf{Re = \\frac{\\rho V D}{\\mu} = \\frac{V D}{\\nu} \\quad \\Big| \\quad \\begin{cases} Re \\le 2300 & \\text{\\bf Laminar Regime (Smooth Viscous Sheaths)} \\\\ 2300 < Re < 4000 & \\text{\\bf Transition Regime} \\\\ Re \\ge 4000 & \\text{\\bf Turbulent Regime (Chaotic Eddy Mixing)} \\end{cases}}\n$$\n• **Hagen-Poiseuille Velocity \\& Stress Formulations:**\n$$\n\\mathbf{u(r) = u_{\\text{max}}\\left(1 - \\frac{r^2}{R^2}\\right) \\quad \\Big| \\quad u_{\\text{max}} = 2 V_{\\text{avg}} \\quad \\Big| \\quad \\tau_w = \\frac{4 \\mu V_{\\text{avg}}}{R}}\n$$\n• **Laminar Pressure Drop \\& Darcy Friction Factor:**\n$$\n\\mathbf{\\Delta P_{\\text{laminar}} = \\frac{32 \\mu L V_{\\text{avg}}}{D^2} = \\frac{128 \\mu L Q}{\\pi D^4} \\implies \\mathbf{f_{\\text{laminar}} = \\frac{64}{Re}}}\n$$\n• **Roughness Independence Invariant:** In laminar flow, fluid layers glide smoothly without wall turbulence $\\implies \\mathbf{f = 64/Re}$ is **completely independent of pipe roughness $\\epsilon$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the laminar velocity profile, wall shear stress, and viscous pressure drop in a transport pipeline.",
      "orderItems": [
        "Calculate the Reynolds number Re = rho * V * D / mu and confirm laminar flow conditions (Re <= 2300)",
        "Determine the hydrodynamic entrance length L_e = 0.06 * Re * D to verify fully developed velocity profile",
        "Compute the maximum centerline flow velocity using the exact relationship u_max = 2 * V_avg",
        "Calculate the wall shear stress at the pipe boundary: tau_w = 4 * mu * V_avg / R",
        "Apply the Hagen-Poiseuille equation to determine total viscous pressure drop: delta P = (32 * mu * L * V_avg) / D^2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Laminar Pipe Flow Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Reynolds Number (Re)", "right": "Re = rho * V * D / mu, governing the transition between laminar and turbulent flow regimes" },
        { "left": "Peak Centerline Velocity", "right": "u_max = 2 * V_avg, occurring at the centerline r = 0 of a parabolic velocity profile" },
        { "left": "Laminar Friction Factor (f)", "right": "f = 64 / Re, derived purely from viscous momentum balance independent of pipe roughness" },
        { "left": "Hagen-Poiseuille Pressure Drop", "right": "delta P = 128 * mu * L * Q / (pi * D^4), showing that pressure drop scales inversely with D^4" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In fully developed laminar pipe flow, the maximum centerline velocity is exactly ___ times the average flow velocity.",
      "blankAnswer": "2",
      "blankDistractors": ["4", "1.5", "0.5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Heavy lubricating oil (rho = 900 kg/m^3, dynamic viscosity mu = 0.20 Pa·s) flows through a horizontal pipe of diameter D = 0.05 m and length L = 50 m at an average velocity V_avg = 1.0 m/s. What is the viscous pressure drop delta P across the pipe length?",
      "options": [
        { "text": "delta P = 128 kPa (128,000 Pa, with Re = 225 confirming fully laminar flow)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Hagen-Poiseuille equation (Frank M. White *Fluid Mechanics* Chapter 6). 1. **Check Reynolds Number ($Re$):** $$Re = \\frac{\\rho V_{\\text{avg}} D}{\\mu} = \\frac{(900\\text{ kg/m}^3)(1.0\\text{ m/s})(0.05\\text{ m})}{0.20\\text{ Pa}\\cdot\\text{s}} = \\frac{45}{0.20} = \\mathbf{225}$$ - Since $Re = 225 \\le 2300$, the flow is **strictly laminar**! 2. **Hagen-Poiseuille Pressure Drop Equation:** $$\\Delta P = \\frac{32 \\mu L V_{\\text{avg}}}{D^2}$$ $$\\Delta P = \\frac{32 (0.20\\text{ Pa}\\cdot\\text{s})(50\\text{ m})(1.0\\text{ m/s})}{(0.05\\text{ m})^2} = \\frac{320}{0.0025} = 128,000\\text{ Pa} = \\mathbf{128\\text{ kPa}}$$ 3. **Verification via Darcy-Weisbach:** - $f = \\frac{64}{Re} = \\frac{64}{225} = 0.28444$. - $\\Delta P = f \\frac{L}{D} \\frac{\\rho V^2}{2} = (0.28444)\\left(\\frac{50}{0.05}\\right)\\frac{(900)(1^2)}{2} = (0.28444)(1000)(450) = \\mathbf{128,000\\text{ Pa}}$! Flawless consistency!" },
        { "text": "delta P = 64 kPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "delta P = 256 kPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "delta P = 12.8 kPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
