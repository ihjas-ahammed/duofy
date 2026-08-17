# Duofy Reusable Lesson Format: Induction Motors (Slip Dynamics & Power Flow Ratio)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Induction_and_Synchronous_Motors`  
**Lesson Format Type:** `induction_motor_slip_equivalent_circuit_and_power_flow`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the electromagnetic induction principles of three-phase asynchronous motors, rotating stator magnetic field speed ($n_s$), mechanical rotor slip ($s$), the exact per-phase IEEE equivalent circuit, and the fundamental power flow decomposition triple ($P_{ag} : P_{rcu} : P_{conv} = 1 : s : (1 - s)$) in industrial electric machinery (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 6; A. E. Fitzgerald *Electric Machinery* Chapter 5): formulate **Synchronous Speed ($n_s$) and Slip ($s$)**:
$$\mathbf{n_s = \frac{120 f_e}{P} \ [\text{RPM}] \quad \Big| \quad \mathbf{s = \frac{n_s - n_m}{n_s} = \frac{\omega_s - \omega_m}{\omega_s}} \quad \Big| \quad \mathbf{f_r = s f_e}}$$
derive the **Per-Phase Equivalent Circuit Mechanical Resistance Decomposition**:
$$\mathbf{\frac{R_2'}{s} = R_2' + R_2' \left( \frac{1 - s}{s} \right) = \mathbf{R_{\text{rotor,ohmic}} + R_{\text{mech,load}}}}$$
derive the **Master Power Flow Proportion Triple**:
$$\mathbf{P_{ag} : P_{rcu} : P_{conv} = 1 : s : (1 - s)}$$
$$\mathbf{P_{rcu} = s \cdot P_{ag} \quad (\text{Rotor Copper Ohmic Loss}) \quad \Big| \quad \mathbf{P_{conv} = (1 - s) \cdot P_{ag} = \tau_{ind} \cdot \omega_m} \quad (\text{Converted Mechanical Power})}$$
$$\mathbf{P_{\text{out}} = P_{conv} - P_{\text{rotational}} \quad (P_{\text{rotational}} = P_{f,w} + P_{\text{misc}})}$$
(proving that rotor electrical efficiency $\eta_{\text{rotor}} = 1 - s$ is directly capped by slip, making low-slip operation mandatory for high-efficiency industrial motors).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Synchronous Speed ($n_s = \frac{120f}{P}$), Slip ($s$), Equivalent Circuit & Power Ratio ($1:s:1-s$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Complete Power Flow from Stator Input to Shaft Output Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Power Stage / Motor Equivalent Resistance & Technical Energy Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Three-Phase Induction Motor, the Power Transferred Across the Air Gap Converted to Rotor Copper Loss Equals Slip Multiplied by ___ Power (Air-Gap / Pag) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Heavy Industry Problem: Calculating Rotor Copper Loss, Converted Power, and Efficiency for a 460V Motor Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Induction Motor Slip & Power Flow (Chapman 2012; Fitzgerald 2013):
   - **Speed, Slip & Power Formulations:**
     $$\mathbf{n_s = \frac{120 f}{P} \quad \Big| \quad s = \frac{n_s - n_m}{n_s} \quad \Big| \quad P_{ag} = 3 (I_2')^2 \frac{R_2'}{s} \quad \Big| \quad P_{rcu} = s P_{ag} \quad \Big| \quad P_{conv} = (1 - s) P_{ag}}$$
   - **Power Flow Progression Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Power Stage} & \textbf{Mathematical Equation} & \textbf{Physical Meaning} \\
     \hline
     \mathbf{\text{Stator Input } P_{\text{in}}} & P_{\text{in}} = \sqrt{3} V_L I_L \cos\theta & \text{Total 3-phase electrical power consumed from grid} \\
     \mathbf{\text{Air-Gap Power } P_{ag}} & P_{ag} = P_{\text{in}} - P_{\text{stator,cu}} - P_{\text{core}} & \mathbf{\text{Total electromagnetic power crossing air gap into rotor}} \\
     \mathbf{\text{Rotor Copper Loss } P_{rcu}} & \mathbf{P_{rcu} = s \cdot P_{ag}} & \mathbf{\text{Ohmic heat dissipation in squirrel-cage rotor bars}} \\
     \mathbf{\text{Converted Power } P_{conv}} & \mathbf{P_{conv} = (1 - s) \cdot P_{ag} = \tau_{ind} \omega_m} & \mathbf{\text{Electromechanical power converted to rotating shaft motion}} \\
     \mathbf{\text{Useful Shaft Power } P_{\text{out}}} & P_{\text{out}} = P_{conv} - P_{f,w} - P_{\text{stray}} & \text{Net brake horsepower delivered to the mechanical load} \\
     \hline
     \end{array}$$
   - **The Rotor Efficiency Invariant:** The internal rotor efficiency is **strictly equal to $(1 - s)$**; an induction motor running at $s = 0.05$ converts $95\%$ of air-gap power to mechanical work, but running at $s = 0.50$ wastes $50\%$ of power directly as rotor heat!
2. **Slide 2 (`ordering`):** Provide 5 steps of induction motor power flow analysis: (1) calculate synchronous speed $n_s = 120 f / P$ and operating slip $s = (n_s - n_m) / n_s$, (2) calculate stator input power $P_{\text{in}}$ and deduct stator copper and core losses to find air-gap power $P_{ag}$, (3) compute rotor copper loss $P_{rcu} = s \cdot P_{ag}$, (4) compute converted electromechanical power $P_{conv} = (1 - s) \cdot P_{ag}$, (5) subtract friction, windage, and stray rotational losses to determine net shaft output power $P_{\text{out}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Air-Gap Power $P_{ag}$, Rotor Copper Loss $s P_{ag}$, Converted Power $(1-s)P_{ag}$, Slip $s=(n_s-n_m)/n_s$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Air-Gap (or Pag). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating induction motor power flow: A $460\text{ V}, \ 60\text{ Hz}, \ 4\text{-pole}$ three-phase induction motor operates at full load speed $n_m = 1710\text{ RPM}$. The air-gap power is measured to be $P_{ag} = 25.0\text{ kW}$. Mechanical friction and windage losses are $P_{f,w} = 500\text{ W} = 0.50\text{ kW}$. What is the operating slip $s$, the rotor copper loss $P_{rcu}$, the converted mechanical power $P_{conv}$, and the net output power $P_{\text{out}}$? ($n_s = \frac{120(60)}{4} = \mathbf{1800\text{ RPM}}$; $s = \frac{1800 - 1710}{1800} = \frac{90}{1800} = \mathbf{0.050\text{ (or } 5.0\%)}$; $P_{rcu} = s \cdot P_{ag} = 0.050 \times 25.0\text{ kW} = \mathbf{1.25\text{ kW} = 1250\text{ W}}$; $P_{conv} = (1 - s) P_{ag} = (1 - 0.050) \times 25.0\text{ kW} = 0.95 \times 25.0\text{ kW} = \mathbf{23.75\text{ kW}}$; $P_{\text{out}} = P_{conv} - P_{f,w} = 23.75\text{ kW} - 0.50\text{ kW} = \mathbf{23.25\text{ kW} \approx 31.18\text{ HP}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "induction_motor_slip_equivalent_circuit_and_power_flow",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Induction Motor Power Flow \\& Slip Dynamics (Stephen Chapman)**\n• **Synchronous Speed \\& Slip Formulations:**\n$$\n\\mathbf{n_s = \\frac{120 f_e}{P} \\ [\\text{RPM}] \\quad \\Big| \\quad \\mathbf{s = \\frac{n_s - n_m}{n_s}} \\quad \\Big| \\quad \\mathbf{f_r = s \\cdot f_e}}\n$$\n• **The Master Power Flow Proportion Triple:**\n$$\n\\mathbf{P_{ag} : P_{rcu} : P_{conv} = 1 : s : (1 - s)}\n$$\n  - **Air-Gap Power:** $\\mathbf{P_{ag} = 3 (I_2')^2 \\frac{R_2'}{s}}$;\n  - **Rotor Copper Ohmic Loss:** $\\mathbf{P_{rcu} = s \\cdot P_{ag}}$;\n  - **Converted Mechanical Power:** $\\mathbf{P_{conv} = (1 - s) \\cdot P_{ag} = \\tau_{ind} \\cdot \\omega_m}$;\n  - **Net Shaft Output Power:** $\\mathbf{P_{\\text{out}} = P_{conv} - P_{f,w} - P_{\\text{misc}}}$\n• **The Rotor Efficiency Invariant:** Internal rotor efficiency is **strictly equal to $(1 - s)$**; operating at high slip converts massive fractions of input electrical power directly into destructive rotor heat!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the full power flow and shaft mechanical output of a 3-phase induction motor.",
      "orderItems": [
        "Calculate the stator synchronous magnetic field speed: ns = 120*f / P and the operating slip: s = (ns - nm) / ns",
        "Compute the air-gap power Pag transferred from the stator across the physical air gap into the rotor",
        "Calculate the rotor winding copper heat loss: P_rcu = s * Pag",
        "Calculate the converted electromechanical power: P_conv = (1 - s) * Pag",
        "Subtract mechanical friction, windage, and stray rotational losses to determine net shaft output power: P_out = P_conv - P_rot"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Induction Motor Power Stage to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Air-Gap Power (Pag)", "right": "Total electromagnetic power crossing the air gap from stator into rotor: Pag = 3*(I2')^2 * (R2'/s)" },
        { "left": "Rotor Copper Loss (Prcu)", "right": "Prcu = s * Pag, I^2*R heat dissipation in the squirrel-cage conductive rotor bars" },
        { "left": "Converted Power (Pconv)", "right": "Pconv = (1 - s) * Pag, electromechanical power driving shaft rotation" },
        { "left": "Rotor Electrical Slip (s)", "right": "s = (ns - nm) / ns, relative speed ratio governing rotor induced voltage and frequency fr = s*fe" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a three-phase induction motor, the power converted into rotor copper ohmic heat loss equals slip multiplied by ___ power.",
      "blankAnswer": "air-gap",
      "blankDistractors": ["shaft", "stator", "friction"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 460 V, 60 Hz, 4-pole three-phase induction motor operates at full-load speed nm = 1710 RPM. The air-gap power is Pag = 25.0 kW, and mechanical friction/windage loss is Pf,w = 0.50 kW (500 W). What is the slip s, rotor copper loss Prcu, converted power Pconv, and net output power Pout?",
      "options": [
        { "text": "s = 0.050 (5.0%), Prcu = 1.25 kW, Pconv = 23.75 kW, and Pout = 23.25 kW (ns = 120*60/4 = 1800 RPM; s = (1800-1710)/1800 = 0.050; Prcu = 0.050 * 25 kW = 1.25 kW; Pconv = 0.95 * 25 kW = 23.75 kW; Pout = 23.75 - 0.50 = 23.25 kW)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using induction motor power flow equations (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 6). 1. **Calculate Synchronous Speed ($n_s$):** $$n_s = \\frac{120 \\times f_e}{P} = \\frac{120 \\times 60\\text{ Hz}}{4} = \\mathbf{1800\\text{ RPM}}$$ 2. **Calculate Operating Slip ($s$):** $$s = \\frac{n_s - n_m}{n_s} = \\frac{1800\\text{ RPM} - 1710\\text{ RPM}}{1800\\text{ RPM}} = \\frac{90}{1800} = \\mathbf{0.050\\text{ (or } 5.0\\%)}$$ 3. **Calculate Rotor Copper Losses ($P_{rcu}$):** $$P_{rcu} = s \\times P_{ag} = 0.050 \\times 25.0\\text{ kW} = \\mathbf{1.250\\text{ kW} = 1250\\text{ W}}$$ 4. **Calculate Converted Mechanical Power ($P_{conv}$):** $$P_{conv} = (1 - s) \\times P_{ag} = (1 - 0.050) \\times 25.0\\text{ kW} = 0.950 \\times 25.0\\text{ kW} = \\mathbf{23.750\\text{ kW}}$$ 5. **Calculate Net Output Shaft Power ($P_{\\text{out}}$):** $$P_{\\text{out}} = P_{conv} - P_{f,w} = 23.750\\text{ kW} - 0.500\\text{ kW} = \\mathbf{23.250\\text{ kW}}$$ $$\\text{Output Horsepower} = \\frac{23.250\\text{ kW}}{0.7457\\text{ kW/HP}} \\approx \\mathbf{31.18\\text{ HP}}$$ Flawless induction motor power flow calculation!" },
        { "text": "s = 0.025 (2.5%), Prcu = 0.625 kW, Pconv = 24.38 kW, and Pout = 23.88 kW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "s = 0.050, Prcu = 2.50 kW, Pconv = 22.50 kW, and Pout = 22.00 kW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "s = 0.100, Prcu = 2.50 kW, Pconv = 22.50 kW, and Pout = 22.00 kW", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
