# Duofy Reusable Lesson Format: Bernoulli Dynamics (Pitot Tubes, Venturi, and Torricelli)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Fluid_Statics_and_Bernoulli_Equation`  
**Lesson Format Type:** `bernoulli_equation_streamlines_pitot_tubes_and_venturi_meters`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through streamline momentum integration, conservation of mechanical flow energy, stagnation pressures, and differential flow meters in fluid mechanics (Daniel Bernoulli 1738; Frank M. White *Fluid Mechanics* Chapter 3; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 3): integrate **Euler's Equation along a Streamline ($\mathbf{\frac{dP}{\rho} + V dV + g dz = 0}$)** for steady, incompressible, frictionless (inviscid) flow to derive the **Bernoulli Equation in Pressure Form**:
$$\mathbf{P + \frac{1}{2}\rho V^2 + \rho g z = \text{Constant} \quad \Longleftrightarrow \quad \mathbf{\frac{P}{\gamma} + \frac{V^2}{2g} + z = H_{\text{total}} \ [\text{meters}]}}$$
master the 3 constituent heads: **1. Pressure Head ($\mathbf{\frac{P}{\gamma}}$)**, **2. Velocity Head ($\mathbf{\frac{V^2}{2g}}$)**, and **3. Elevation Head ($\mathbf{z}$)**; master core engineering flow instruments: (a) **Pitot-Static Tube** for aircraft and wind tunnel airspeeds ($\mathbf{V = \sqrt{\frac{2(P_{\text{stagnation}} - P_{\text{static}})}{\rho}}}$), (b) **Venturi Tube Flow Meters** ($\mathbf{Q = C_d A_2 \sqrt{\frac{2(P_1 - P_2)/\rho}{1 - (A_2/A_1)^2}}}$), and (c) **Torricelli's Law of Free Efflux** ($\mathbf{V_{\text{exit}} = \sqrt{2 g h}}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bernoulli Equation Formulation & Pitot / Venturi Flow Meter Dynamics Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Derivation and Flow Rate Calculation in a Horizontal Venturi Tube Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Fluid Dynamics Instrument / Bernoulli Term & Technical Operational Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Point in a Fluid Flow Where Velocity Is Brought Decelerated to Zero (V = 0), Converting Dynamic Pressure to Static Pressure, Is the ___ Point (Stagnation) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Aerodynamic Flow Measurement Problem: Calculating Aircraft Flight Airspeed from a Pitot-Static Tube Differential Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bernoulli Dynamics (White 2016; Munson 2016):
   - **Bernoulli Formulations:**
     $$\mathbf{\frac{P_1}{\gamma} + \frac{V_1^2}{2g} + z_1 = \frac{P_2}{\gamma} + \frac{V_2^2}{2g} + z_2 = H_{\text{total}} \quad \Big| \quad P_0 = P_{\text{static}} + \frac{1}{2}\rho V^2}$$
   - **Flow Instruments Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Flow Device} & \textbf{Physical Principle} & \textbf{Governing Equation} & \textbf{Application} \\
     \hline
     \mathbf{\text{Pitot-Static Tube}} & \text{Measures } P_{\text{stag}} - P_{\text{stat}} & \mathbf{V = \sqrt{\frac{2 \Delta P}{\rho}}} & \text{Aircraft Airspeed Indicator} \\
     \mathbf{\text{Venturi Meter}} & \text{Continuity + Bernoulli throat drop} & \mathbf{Q = A_1 A_2 \sqrt{\frac{2 \Delta P / \rho}{A_1^2 - A_2^2}}} & \text{Pipeline Volume Flow Rate} \\
     \mathbf{\text{Torricelli Efflux}} & \text{Tank draining from depth } h & \mathbf{V = \sqrt{2 g h}} & \text{Reservoir discharge velocity} \\
     \hline
     \end{array}$$
   - **Bernoulli Assumptions Invariant:** Must be **1. Steady flow**, **2. Incompressible fluid ($\rho = C$)**, **3. Inviscid / Frictionless ($\mu = 0$, zero viscous losses)**, **4. Along a single streamline (or irrotational flow throughout)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of solving a Venturi meter: (1) apply continuity equation $A_1 V_1 = A_2 V_2$ to express velocity in terms of area ratio $V_1 = \frac{A_2}{A_1} V_2$, (2) write Bernoulli equation between inlet 1 and throat 2 ($z_1 = z_2$), (3) substitute $V_1$ into Bernoulli equation to isolate throat velocity $V_2 = \sqrt{\frac{2(P_1 - P_2)/\rho}{1 - (A_2/A_1)^2}}$, (4) evaluate theoretical volumetric flow rate $Q_{\text{theor}} = A_2 V_2$, (5) multiply by discharge coefficient $C_d \approx 0.98$ to find actual flow rate $Q_{\text{actual}} = C_d Q_{\text{theor}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Pitot-Static Tube, Venturi Tube, Torricelli's Law, Velocity Head $\frac{V^2}{2g}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Stagnation. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating airspeed from Pitot-static tube: An aircraft flies through ambient air of density $\rho = 1.2\text{ kg/m}^3$. Its wing-mounted Pitot-static tube measures a dynamic pressure differential of $P_{\text{stagnation}} - P_{\text{static}} = 2400\text{ Pa} = 2400\text{ N/m}^2$. What is the indicated airspeed $V$ of the aircraft? ($V = \sqrt{\frac{2(P_0 - P)}{\rho}} = \sqrt{\frac{2 \times 2400\text{ Pa}}{1.2\text{ kg/m}^3}} = \sqrt{\frac{4800}{1.2}} = \sqrt{4000} \approx \mathbf{63.25\text{ m/s}} \approx \mathbf{227.7\text{ km/h}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bernoulli_equation_streamlines_pitot_tubes_and_venturi_meters",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Bernoulli Flow Equation \\& Dynamic Head (Daniel Bernoulli 1738)**\n• **The Master Mechanical Energy Formulation:**\n$$\n\\mathbf{\\frac{P_1}{\\gamma} + \\frac{V_1^2}{2g} + z_1 = \\frac{P_2}{\\gamma} + \\frac{V_2^2}{2g} + z_2 = H_{\\text{total}} \\ [\\text{meters of fluid}]}\n$$\n• **The Dynamic Head Triad:**\n  - $\\mathbf{\\frac{P}{\\gamma}}$: **Pressure Head** (Flow energy per unit weight);\n  - $\\mathbf{\\frac{V^2}{2g}}$: **Velocity Head** (Kinetic energy per unit weight);\n  - $\\mathbf{z}$: **Elevation Head** (Gravitational potential energy per unit weight)!\n• **Flow Meter Dynamics Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Flow Instrument} & \\textbf{Stagnation / Venturi Relation} & \\textbf{Velocity / Discharge Equation} \\\\\n\\hline\n\\mathbf{\\text{Pitot-Static Tube}} & P_0 = P_{\\text{static}} + \\frac{1}{2}\\rho V^2 & \\mathbf{V = \\sqrt{\\frac{2(P_0 - P_{\\text{static}})}{\\rho}}} \\\\\n\\mathbf{\\text{Venturi Meter}} & \\text{Throat constriction } (A_2 < A_1) & \\mathbf{Q = C_d A_2 \\sqrt{\\frac{2(P_1 - P_2)/\\rho}{1 - (A_2/A_1)^2}}} \\\\\n\\mathbf{\\text{Torricelli Efflux}} & \\text{Free jet discharge from depth } h & \\mathbf{V_{\\text{exit}} = \\sqrt{2 g h}} \\\\\n\\hline\n\\end{array}\n$$\n• **The 4 Bernoulli Axioms:** Valid strictly for: **1. Steady Flow, 2. Incompressible Fluid, 3. Inviscid (Frictionless) Flow, 4. Along a single Streamline**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the volumetric flow rate of water through a horizontal Venturi meter using Bernoulli's equation.",
      "orderItems": [
        "Apply the mass conservation continuity equation A1*V1 = A2*V2 to express inlet velocity as V1 = (A2 / A1) * V2",
        "Formulate Bernoulli's equation between pipe inlet 1 and throat constriction 2 with equal elevation (z1 = z2)",
        "Substitute V1 into Bernoulli's equation: (P1 - P2) / rho = (V2^2 - V1^2) / 2",
        "Solve algebraically for throat velocity: V2 = sqrt((2 * (P1 - P2) / rho) / (1 - (A2 / A1)^2))",
        "Multiply throat velocity by throat area and discharge coefficient: Q_actual = Cd * A2 * V2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fluid Dynamics Instrument to its exact Operating Principle.",
      "matchPairs": [
        { "left": "Pitot-Static Tube", "right": "Measures difference between stagnation pressure and static pressure to determine flight velocity" },
        { "left": "Venturi Tube", "right": "Smooth converging-diverging duct creating a pressure drop at the throat to measure volumetric flow" },
        { "left": "Torricelli's Law", "right": "V = sqrt(2*g*h), expressing efflux velocity of a liquid discharging from an open tank orifice" },
        { "left": "Stagnation Point", "right": "Point on a submerged body where fluid velocity is decelerated to zero (V = 0), maximizing static pressure" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The point in a fluid flow where local velocity is brought to rest (V = 0) is the ___ point.",
      "blankAnswer": "stagnation",
      "blankDistractors": ["cavitation", "vortex", "centroid"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An aircraft flies through ambient air of density rho = 1.2 kg/m^3. Its Pitot-static tube measures a differential dynamic pressure of P_stagnation - P_static = 2400 Pa. What is the true indicated flight airspeed V of the aircraft?",
      "options": [
        { "text": "V = 63.25 m/s (approximately 227.7 km/h)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Pitot tube stagnation equation (Frank M. White *Fluid Mechanics* Chapter 3). 1. **Pitot Stagnation Pressure Formula:** - At the nose tip of the Pitot tube, fluid velocity decelerates to zero ($V_0 = 0$). - Total Stagnation Pressure: $$P_0 = P_{\\text{static}} + \\frac{1}{2} \\rho V^2 \\implies P_0 - P_{\\text{static}} = \\frac{1}{2} \\rho V^2$$ 2. **Solve for Velocity ($V$):** $$V = \\sqrt{\\frac{2(P_0 - P_{\\text{static}})}{\\rho}}$$ 3. **Calculation:** $$V = \\sqrt{\\frac{2(2400\\text{ Pa})}{1.2\\text{ kg/m}^3}} = \\sqrt{\\frac{4800}{1.2}} = \\sqrt{4000} \\approx \\mathbf{63.2456\\text{ m/s}}$$ 4. **Speed Conversion:** $$V = 63.2456\\text{ m/s} \\times 3.6 = \\mathbf{227.7\\text{ km/h}}$$ Flawless aerodynamic airspeed calculation!" },
        { "text": "V = 40.00 m/s (144 km/h)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V = 89.44 m/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V = 2000 m/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
