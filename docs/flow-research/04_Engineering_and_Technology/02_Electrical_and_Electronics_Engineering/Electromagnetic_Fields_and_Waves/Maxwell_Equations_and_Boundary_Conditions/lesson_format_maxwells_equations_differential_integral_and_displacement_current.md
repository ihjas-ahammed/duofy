# Duofy Reusable Lesson Format: Maxwell's Equations (Differential, Integral, & Displacement Current)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electromagnetic_Fields_and_Waves / Maxwell_Equations_and_Boundary_Conditions`  
**Lesson Format Type:** `maxwells_equations_differential_integral_and_displacement_current`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the unification of classical electromagnetism, vector differential operators (divergence $\nabla \cdot$ and curl $\nabla \times$), the four master Maxwell equations, and Maxwell's revolutionary displacement current concept in electrodynamics (James Clerk Maxwell 1865; Matthew N.O. Sadiku *Elements of Electromagnetics* Chapter 9; Fawwaz T. Ulaby *Fundamentals of Applied Electromagnetics* Chapter 6): master the **Four Differential Maxwell Equations**:
$$\mathbf{\nabla \cdot \mathbf{D} = \rho_v \quad \Big| \quad \nabla \cdot \mathbf{B} = 0 \quad \Big| \quad \nabla \times \mathbf{E} = -\frac{\partial \mathbf{B}}{\partial t} \quad \Big| \quad \mathbf{\nabla \times \mathbf{H} = \mathbf{J} + \frac{\partial \mathbf{D}}{\partial t}}}$$
derive **Maxwell's Displacement Current Density ($\mathbf{J}_D$)**:
$$\mathbf{\mathbf{J}_D = \frac{\partial \mathbf{D}}{\partial t} = \epsilon \frac{\partial \mathbf{E}}{\partial t} \ [\text{A/m}^2] \implies \mathbf{I}_D = \int_S \mathbf{J}_D \cdot d\mathbf{S} = C \frac{dv_C}{dt}}$$
prove the **Charge Continuity Compatibility Invariant** (taking the divergence of Ampère's original law $\nabla \cdot (\nabla \times \mathbf{H}) = 0 \ne \nabla \cdot \mathbf{J} = -\frac{\partial \rho_v}{\partial t}$; adding $\frac{\partial \mathbf{D}}{\partial t}$ yields $\nabla \cdot (\mathbf{J} + \frac{\partial \mathbf{D}}{\partial t}) = -\frac{\partial \rho_v}{\partial t} + \frac{\partial(\nabla \cdot \mathbf{D})}{\partial t} = -\frac{\partial \rho_v}{\partial t} + \frac{\partial \rho_v}{\partial t} = \mathbf{0}$, resolving the continuity paradox and proving the existence of electromagnetic waves!).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Four Maxwell Equations (Diff/Integral), Continuity Law & Displacement Current ($\mathbf{J}_D = \epsilon \frac{\partial \mathbf{E}}{\partial t}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Displacement Current Density Inside a Dielectric Capacitor Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Maxwell Equation / Electromagnetic Field Law & Physical Conservation Principle Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Time-Varying Electric Flux Density Term \partial D / \partial t Added by Maxwell to Ampère's Law Is the ___ Current Density (Displacement) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Time-Varying Electromagnetics Problem: Calculating the Displacement Current I_D Inside a High-Frequency Parallel-Plate Capacitor Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Maxwell's Equations & Displacement Current (Sadiku 2021; Ulaby 2020):
   - **The Four Master Maxwell Equations:**
     $$\mathbf{\nabla \cdot \mathbf{D} = \rho_v \quad \Big| \quad \nabla \cdot \mathbf{B} = 0 \quad \Big| \quad \nabla \times \mathbf{E} = -\frac{\partial \mathbf{B}}{\partial t} \quad \Big| \quad \mathbf{\nabla \times \mathbf{H} = \mathbf{J} + \frac{\partial \mathbf{D}}{\partial t}}}$$
   - **Displacement Current Formulation:**
     $$\mathbf{\mathbf{J}_D = \frac{\partial \mathbf{D}}{\partial t} = \epsilon \frac{\partial \mathbf{E}}{\partial t} \quad \Big| \quad I_D = \int_S \mathbf{J}_D \cdot d\mathbf{S} = C \frac{dv_C}{dt}}$$
   - **The Continuity Invariant:** $\mathbf{\nabla \cdot \mathbf{J} = -\frac{\partial \rho_v}{\partial t}}$ (Conservation of charge requires $\mathbf{J}_D$ to complete the circuit loop across insulating capacitor dielectric gaps!).
2. **Slide 2 (`ordering`):** Provide 5 steps of displacement current analysis: (1) determine capacitor plate geometry (area $A$, gap $d$) and dielectric permittivity $\epsilon = \epsilon_0 \epsilon_r$, (2) express the time-harmonic voltage $v(t) = V_0 \sin(\omega t)$ across the plates, (3) compute the electric field intensity $E(t) = \frac{v(t)}{d} = \frac{V_0}{d} \sin(\omega t)$, (4) take time derivative to find displacement current density $J_D = \epsilon \frac{\partial E}{\partial t} = \frac{\epsilon \omega V_0}{d} \cos(\omega t)$, (5) integrate over plate area to obtain total displacement current $I_D = J_D \cdot A = \left(\frac{\epsilon A}{d}\right) \omega V_0 \cos(\omega t) = C \frac{dv}{dt}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Gauss's Law $\nabla \cdot \mathbf{D} = \rho_v$, Gauss's Magnetic Law $\nabla \cdot \mathbf{B} = 0$, Faraday's Law $\nabla \times \mathbf{E} = -\partial\mathbf{B}/\partial t$, Ampère-Maxwell Law $\nabla \times \mathbf{H} = \mathbf{J} + \partial\mathbf{D}/\partial t$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Displacement. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating displacement current: A parallel-plate air capacitor ($\epsilon = \epsilon_0 = 8.854 \times 10^{-12}\text{ F/m}$) has plate area $A = 0.050\text{ m}^2$ and plate separation $d = 2.0\text{ mm} = 0.0020\text{ m}$. A time-varying sinusoidal voltage $v(t) = 100 \cos(2\pi \times 10^6 t)\text{ Volts}$ ($f = 1.0\text{ MHz}$, $\omega = 2\pi \times 10^6\text{ rad/s}$) is applied across the plates. What is the peak amplitude of the displacement current $I_{D,\text{peak}}$ flowing through the dielectric gap? ($C = \frac{\epsilon_0 A}{d} = \frac{(8.854 \times 10^{-12})(0.050)}{0.0020} = 2.2135 \times 10^{-10}\text{ F} \approx 221.35\text{ pF}$; $I_D(t) = C \frac{dv}{dt} = C [ -100 \omega \sin(\omega t) ] \implies I_{D,\text{peak}} = C \cdot 100 \cdot \omega = (2.2135 \times 10^{-10})(100)(2\pi \times 10^6) = (2.2135 \times 10^{-8})(6.283185 \times 10^6) \approx \mathbf{0.13908\text{ A} \approx 139.1\text{ mA}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "maxwells_equations_differential_integral_and_displacement_current",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Maxwell's Equations \\& Displacement Current (James Clerk Maxwell 1865)**\n• **The Four Master Differential Maxwell Equations:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Physical Law} & \\textbf{Differential Equation} & \\textbf{Fundamental Physical Meaning} \\\\\n\\hline\n\\mathbf{\\text{Gauss's Law (Electrostatics)}} & \\mathbf{\\nabla \\cdot \\mathbf{D} = \\rho_v} & \\text{Electric charges are sources and sinks of } \\mathbf{D} \\\\\n\\mathbf{\\text{Gauss's Law (Magnetism)}} & \\mathbf{\\nabla \\cdot \\mathbf{B} = 0} & \\mathbf{\\text{No isolated magnetic monopoles exist in nature}} \\\\\n\\mathbf{\\text{Faraday's Induction Law}} & \\mathbf{\\nabla \\times \\mathbf{E} = -\\frac{\\partial \\mathbf{B}}{\\partial t}} & \\text{Time-varying magnetic flux induces circulating } \\mathbf{E} \\\\\n\\mathbf{\\text{Ampère-Maxwell Law}} & \\mathbf{\\nabla \\times \\mathbf{H} = \\mathbf{J} + \\frac{\\partial \\mathbf{D}}{\\partial t}} & \\mathbf{\\text{Conduction } \\mathbf{J} \\text{ and Displacement } \\mathbf{J}_D \\text{ produce } \\mathbf{H}} \\\\\n\\hline\n\\end{array}\n$$\n• **Maxwell's Displacement Current Formulation:**\n$$\n\\mathbf{\\mathbf{J}_D = \\frac{\\partial \\mathbf{D}}{\\partial t} = \\epsilon \\frac{\\partial \\mathbf{E}}{\\partial t} \\ [\\text{A/m}^2] \\implies \\mathbf{I}_D = \\int_S \\mathbf{J}_D \\cdot d\\mathbf{S} = C \\frac{dv_C}{dt}}\n$$\n• **The Continuity Resolution Invariant:** Taking the divergence of Ampère-Maxwell yields $\\nabla \\cdot (\\nabla \\times \\mathbf{H}) = 0 = \\nabla \\cdot \\mathbf{J} + \\frac{\\partial(\\nabla \\cdot \\mathbf{D})}{\\partial t} = -\\frac{\\partial \\rho_v}{\\partial t} + \\frac{\\partial \\rho_v}{\\partial t} = \\mathbf{0}$, proving **unconditional electric charge conservation**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the displacement current density and total displacement current passing through a dielectric capacitor.",
      "orderItems": [
        "Record the capacitor plate area A, dielectric separation thickness d, and material permittivity epsilon = eps_0 * eps_r",
        "Define the applied time-varying voltage waveform: v(t) = V0 * cos(omega * t)",
        "Determine the uniform electric field intensity between the plates: E(t) = v(t) / d = (V0 / d) * cos(omega * t)",
        "Differentiate the electric flux density D = epsilon * E with respect to time to find J_D = epsilon * dE/dt",
        "Integrate displacement current density over the plate area to compute total displacement current: I_D = J_D * A = C * dv/dt"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Maxwell Equation to its exact Physical Conservation Principle.",
      "matchPairs": [
        { "left": "Gauss's Law (\u2207\u00b7D = \u03c1v)", "right": "Divergence of electric flux density equals local volume charge density, quantifying Coulomb field divergence" },
        { "left": "Magnetic Gauss (\u2207\u00b7B = 0)", "right": "Magnetic flux lines are strictly continuous solenoidal closed loops with zero divergence" },
        { "left": "Faraday's Law (\u2207\u00d7E = -\u2202B/\u2202t)", "right": "Circulating electromotive force generated around a closed loop by a time-varying magnetic field" },
        { "left": "Displacement Current (\u2202D/\u2202t)", "right": "Time-varying electric flux density acting as an effective current source to generate magnetic curl" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The time-varying electric flux density term \u2202D/\u2202t added by Maxwell to Ampère's law is the ___ current density.",
      "blankAnswer": "displacement",
      "blankDistractors": ["conduction", "convection", "eddy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A parallel-plate air capacitor (\u03b5 = \u03b50 = 8.854*10^-12 F/m) has plate area A = 0.050 m^2 and plate gap d = 2.0 mm (0.002 m). A sinusoidal voltage v(t) = 100*cos(2\u03c0*10^6 * t) V (1 MHz frequency) is applied across the plates. What is the peak amplitude of the displacement current I_D flowing through the air gap?",
      "options": [
        { "text": "I_D,peak = 139.1 mA (0.139 A) (C = \u03b50*A/d = 221.35 pF, and I_D,peak = C * 100 V * (2\u03c0*10^6 rad/s) = 0.1391 A)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Maxwell's displacement current formulation (Matthew Sadiku *Elements of Electromagnetics* Chapter 9). 1. **Calculate Capacitance ($C$):** $$C = \\frac{\\epsilon_0 A}{d} = \\frac{(8.854187 \\times 10^{-12}\\text{ F/m})(0.050\\text{ m}^2)}{0.0020\\text{ m}} = \\frac{4.42709 \\times 10^{-13}}{0.0020} = 2.21355 \\times 10^{-10}\\text{ F} = \\mathbf{221.35\\text{ pF}}$$ 2. **Apply the Displacement Current Formulation:** $$I_D(t) = C \\frac{dv(t)}{dt}$$ 3. **Differentiate Voltage:** $$v(t) = 100 \\cos(\\omega t) \\implies \\frac{dv}{dt} = -100 \\omega \\sin(\\omega t) \\quad \\left(\\omega = 2\\pi \\times 10^6\\text{ rad/s} \\approx 6.283185 \\times 10^6\\text{ rad/s}\\right)$$ 4. **Calculate Peak Current Amplitude ($I_{D,\\text{peak}}$):** $$I_{D,\\text{peak}} = C \\cdot 100 \\cdot \\omega = (2.21355 \\times 10^{-10}\\text{ F}) \\times 100\\text{ V} \\times (6.283185 \\times 10^6\\text{ s}^{-1})$$ $$I_{D,\\text{peak}} = (2.21355 \\times 10^{-8}) \\times (6.283185 \\times 10^6) = \\mathbf{0.139082\\text{ A} \\approx 139.1\\text{ mA}}$$ 5. **Physical Meaning:** Exactly $139.1\\text{ mA}$ of pure displacement current passes through the empty air gap between the capacitor plates, completing the circuit loop without a single physical electron crossing the gap!" },
        { "text": "I_D,peak = 22.1 mA", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "I_D,peak = 1.391 A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "I_D,peak = 0 mA (No conduction electrons cross the gap)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
