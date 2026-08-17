# Duofy Reusable Lesson Format: Turbomachine Theory (Euler Equation & Velocity Triangles)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Hydraulic_Turbines_and_Pumps`  
**Lesson Format Type:** `euler_turbomachine_equation_and_velocity_triangles`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through angular momentum conservation, blade kinematics, and rotor energy transfer in fluid machinery (Leonhard Euler 1754; Frank M. White *Fluid Mechanics* Chapter 11; S.M. Yahya *Turbines, Compressors and Fans*): master the **Euler Turbomachine Equation**:
$$\mathbf{w_{\text{euler}} = \frac{T \omega}{\dot{m}} = u_2 V_{t2} - u_1 V_{t1} \quad \Longleftrightarrow \quad \mathbf{H_{\text{euler}} = \frac{u_2 V_{t2} - u_1 V_{t1}}{g}}}$$
where $T = \dot{m}(r_2 V_{t2} - r_1 V_{t1})$ is rotor shaft torque, $u = \omega r$ is peripheral blade speed, and $V_t = V \cos\alpha$ is the tangential whirl velocity component; master the **Vector Velocity Triangle ($\mathbf{V} = \mathbf{u} + \mathbf{W}$)** at inlet (state 1) and outlet (state 2) combining **Absolute Velocity ($\mathbf{V}$)**, **Relative Fluid Velocity ($\mathbf{W}$)** along the blade angle $\beta$, and **Blade Tangential Speed ($\mathbf{u}$)**; and contrast **Pumps ($\mathbf{w_{\text{euler}} > 0}$, work done ON fluid)** vs **Turbines ($\mathbf{w_{\text{euler}} < 0}$, work extracted FROM fluid)** with zero-whirl radial entry conditions ($V_{t1} = 0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler Turbomachine Equation ($w = u_2 V_{t2} - u_1 V_{t1}$) & Vector Velocity Triangle ($\mathbf{V} = \mathbf{u} + \mathbf{W}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Construction of Velocity Triangles and Power Output for a Radial Pump Impeller Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Turbomachinery Velocity Vector / Kinematic Angle & Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Component of Absolute Fluid Velocity Oriented Tangentially Along the Direction of Blade Motion Is the ___ Velocity (Whirl / Tangential) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Turbomachinery Mechanics Problem: Calculating the Euler Head Developed by a Centrifugal Pump Impeller Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Euler Turbomachine Equation (White 2016; Yahya 2010):
   - **Euler Turbomachine Formulations:**
     $$\mathbf{w_{\text{euler}} = u_2 V_{t2} - u_1 V_{t1} \quad \Big| \quad H_{\text{euler}} = \frac{u_2 V_{t2} - u_1 V_{t1}}{g} \quad [\text{meters}]}$$
   - **Velocity Triangle Components Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Vector Component} & \textbf{Symbol} & \textbf{Physical Direction} & \textbf{Kinematic Relationship} \\
     \hline
     \mathbf{\text{Absolute Velocity}} & \mathbf{V} & \text{Observed from stationary frame} & \mathbf{\mathbf{V} = \mathbf{u} + \mathbf{W}} \\
     \mathbf{\text{Blade Tangential Speed}} & \mathbf{u} & \text{Tangential to rotor rotation} & \mathbf{u = \omega r = \frac{2 \pi N r}{60}} \\
     \mathbf{\text{Relative Velocity}} & \mathbf{W} & \text{Follows blade surface angle } \beta & \mathbf{W = \mathbf{V} - \mathbf{u}} \\
     \mathbf{\text{Whirl Velocity}} & \mathbf{V_t} & \text{Tangential projection } (V \cos\alpha) & \text{Transfers angular momentum torque} \\
     \mathbf{\text{Flow (Meridional) Velocity}} & \mathbf{V_f} & \text{Normal to rotation } (V \sin\alpha) & \text{Carries volumetric flow } Q = \pi D b V_f \\
     \hline
     \end{array}$$
   - **Zero-Whirl Inlet Rule:** In most centrifugal pumps and reaction turbines, fluid enters radially without prerotation $\implies \mathbf{V_{t1} = 0 \implies H_{\text{euler}} = \frac{u_2 V_{t2}}{g}}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of velocity triangle analysis: (1) calculate blade peripheral speed $u_1 = \omega r_1$ and $u_2 = \omega r_2$ from rotational speed $N$ (RPM), (2) determine flow velocity $V_{f1}$ and $V_{f2}$ from volumetric discharge $Q$ and blade passage areas, (3) construct inlet velocity triangle assuming radial entry ($V_{t1} = 0, \alpha_1 = 90^\circ$), (4) construct outlet velocity triangle using blade angle $\beta_2$ to find tangential whirl velocity $V_{t2} = u_2 - V_{f2} \cot\beta_2$, (5) compute Euler head $H_{\text{euler}} = \frac{u_2 V_{t2}}{g}$ and shaft input power $\text{Power} = \rho Q g H_{\text{euler}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Euler Head $H_{\text{euler}}$, Whirl Velocity $V_t$, Blade Speed $u$, Relative Velocity $W$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Whirl (or Tangential). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Euler pump head: A centrifugal water pump ($\rho = 1000\text{ kg/m}^3, g = 9.81\text{ m/s}^2$) has an impeller outer diameter $D_2 = 0.30\text{ m}$ ($r_2 = 0.15\text{ m}$) rotating at $N = 1800\text{ RPM}$. Water enters radially with zero whirl ($V_{t1} = 0$). At the impeller exit, the tangential whirl velocity is $V_{t2} = 20.0\text{ m/s}$. What is the theoretical Euler head $H_{\text{euler}}$ imparted to the water? ($u_2 = \frac{2 \pi N r_2}{60} = \frac{2 \pi (1800)(0.15)}{60} = 60 \pi (0.15) = 9.0 \pi \approx 28.274\text{ m/s}$; $H_{\text{euler}} = \frac{u_2 V_{t2}}{g} = \frac{(28.274\text{ m/s})(20.0\text{ m/s})}{9.81\text{ m/s}^2} = \frac{565.487}{9.81} \approx \mathbf{57.64\text{ m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "euler_turbomachine_equation_and_velocity_triangles",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Euler Turbomachine Equation \\& Velocity Triangles (Leonhard Euler 1754)**\n• **Euler Specific Work \\& Head Formulations:**\n$$\n\\mathbf{w_{\\text{euler}} = \\frac{T \\omega}{\\dot{m}} = u_2 V_{t2} - u_1 V_{t1} \\quad \\Longleftrightarrow \\quad \\mathbf{H_{\\text{euler}} = \\frac{u_2 V_{t2} - u_1 V_{t1}}{g} \\ [\\text{meters}]}}\n$$\n• **Vector Velocity Triangle Decomposition ($\\mathbf{V = u + W}$):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Velocity Vector} & \\textbf{Symbol} & \\textbf{Reference Frame} & \\textbf{Physical Action} \\\\\n\\hline\n\\mathbf{\\text{Absolute Velocity}} & \\mathbf{V} & \\text{Stationary laboratory frame} & \\text{Actual fluid trajectory in space} \\\\\n\\mathbf{\\text{Blade Tangential Speed}} & \\mathbf{u} & \\mathbf{u = \\omega r = \\frac{2 \\pi N r}{60}} & \\text{Physical motion of rotor metal} \\\\\n\\mathbf{\\text{Relative Velocity}} & \\mathbf{W} & \\text{Rotating blade frame} & \\text{Fluid motion tangential to blade angle } \\beta \\\\\n\\mathbf{\\text{Whirl (Tangential) Comp.}} & \\mathbf{V_t} & V_t = V \\cos\\alpha & \\mathbf{\\text{Generates angular momentum shaft torque!}} \\\\\n\\mathbf{\\text{Flow (Meridional) Comp.}} & \\mathbf{V_f} & V_f = V \\sin\\alpha & \\text{Carries volumetric flow rate } Q \\\\\n\\hline\n\\end{array}\n$$\n• **Radial Inlet Invariant:** In most pumps, fluid enters with zero initial prerotation ($\\mathbf{V_{t1} = 0} \\implies \\mathbf{H_{\\text{euler}} = \\frac{u_2 V_{t2}}{g}}$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct velocity triangles and compute the theoretical Euler head for a centrifugal pump impeller.",
      "orderItems": [
        "Compute the peripheral blade speeds at impeller inlet u1 = omega * r1 and outlet u2 = omega * r2 from shaft RPM",
        "Determine the inlet and outlet meridional flow velocities (V_f1 and V_f2) from the flow rate Q and flow passage areas",
        "Construct the inlet velocity triangle assuming radial fluid entry with zero initial whirl velocity (V_t1 = 0)",
        "Construct the outlet velocity triangle using the backward blade angle beta2 to solve for exit whirl velocity: V_t2 = u2 - V_f2 * cot(beta2)",
        "Evaluate the Euler head using H_euler = (u2 * V_t2) / g and calculate theoretical hydraulic power: Power = rho * Q * g * H_euler"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Turbomachinery Kinematic Term to its exact Vector Definition.",
      "matchPairs": [
        { "left": "Euler Turbomachine Equation", "right": "w = u2*Vt2 - u1*Vt1, expressing work transfer per unit mass from angular momentum conservation" },
        { "left": "Whirl Velocity (V_t)", "right": "Tangential component of absolute fluid velocity responsible for imparting torque to the rotor" },
        { "left": "Flow Velocity (V_f)", "right": "Radial/axial component of velocity dictating the volumetric discharge rate (Q = pi * D * b * V_f)" },
        { "left": "Blade Angle (\u03b2)", "right": "Angle formed between relative velocity vector W and the tangent to the impeller circumference" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The tangential component of absolute fluid velocity responsible for angular momentum transfer is the ___ velocity.",
      "blankAnswer": "whirl",
      "blankDistractors": ["axial", "meridional", "frictional"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A centrifugal pump impeller of outer diameter D2 = 0.30 m (r2 = 0.15 m) rotates at N = 1800 RPM (g = 9.81 m/s^2). Fluid enters radially with zero prerotation (V_t1 = 0). At the impeller discharge, the tangential whirl velocity component is V_t2 = 20.0 m/s. What is the theoretical Euler head H_euler developed by the pump?",
      "options": [
        { "text": "H_euler = 57.64 m (u2 = 28.27 m/s and H_euler = u2 * V_t2 / g)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Euler Turbomachine Equation (Frank M. White *Fluid Mechanics* Chapter 11). 1. **Calculate Impeller Tip Speed ($u_2$):** $$u_2 = \\omega r_2 = \\left(\\frac{2 \\pi N}{60}\\right) r_2 = \\left(\\frac{2 \\pi \\times 1800}{60}\\right) (0.15\\text{ m}) = (60 \\pi)(0.15) = 9.0 \\pi \\approx \\mathbf{28.2743\\text{ m/s}}$$ 2. **Apply the Euler Head Equation ($V_{t1} = 0$):** $$H_{\\text{euler}} = \\frac{u_2 V_{t2} - u_1 V_{t1}}{g} = \\frac{u_2 V_{t2}}{g}$$ $$H_{\\text{euler}} = \\frac{(28.2743\\text{ m/s})(20.0\\text{ m/s})}{9.81\\text{ m/s}^2} = \\frac{565.487}{9.81} \\approx \\mathbf{57.644\\text{ m} \\approx 57.64\\text{ m}}$$ 3. **Physical Significance:** The rotating impeller transfers angular momentum to the fluid, creating $57.64\\text{ meters}$ of theoretical dynamic pressure head available to overcome piping friction and elevate water!" },
        { "text": "H_euler = 28.82 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "H_euler = 115.28 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "H_euler = 9.81 m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
