# Duofy Reusable Lesson Format: Torque-Speed Curve (Breakdown Torque & Rotor Resistance)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Induction_and_Synchronous_Motors`  
**Lesson Format Type:** `induction_motor_torque_speed_characteristics_and_breakdown_torque`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanical torque-speed characteristic curve of three-phase induction motors, Thevenin equivalent circuit simplification of stator impedance ($V_{th}, Z_{th}$), analytical derivation of induced torque ($\tau_{ind}$), pullout / maximum breakdown torque ($\tau_{\text{max}}$), and the role of rotor resistance ($R_2'$) in shifting breakdown slip ($s_{\text{max}}$) for high-starting-torque cranes and hoists (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 6; A. E. Fitzgerald *Electric Machinery* Chapter 5): derive the **Induced Torque Equation (Thevenin Model)**:
$$\mathbf{\tau_{ind} = \frac{P_{ag}}{\omega_s} = \frac{3 V_{th}^2 \left( \frac{R_2'}{s} \right)}{\omega_s \left[ \left( R_{th} + \frac{R_2'}{s} \right)^2 + (X_{th} + X_2')^2 \right]}}$$
derive the **Slip at Maximum Torque ($s_{\text{max}}$)**:
$$\mathbf{s_{\text{max}} = \frac{R_2'}{\sqrt{R_{th}^2 + (X_{th} + X_2')^2}}}$$
derive the **Maximum Breakdown / Pullout Torque ($\tau_{\text{max}}$)**:
$$\mathbf{\tau_{\text{max}} = \frac{3 V_{th}^2}{2 \omega_s \left[ R_{th} + \sqrt{R_{th}^2 + (X_{th} + X_2')^2} \right]}}$$
master the **Rotor Resistance Invariant Theorem**:
- Maximum breakdown torque $\tau_{\text{max}}$ is **COMPLETELY INDEPENDENT of rotor resistance $R_2'$**;
- Increasing rotor resistance $R_2'$ (e.g. inserting external resistors in a wound-rotor induction motor or using NEMA Class D deep-bar rotors) shifts the peak breakdown point to higher slip ($s_{\text{max}} \propto R_2'$), dramatically boosting starting torque at standstill ($s = 1.0$) while keeping $\tau_{\text{max}}$ constant.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Torque Equation ($\tau_{ind}$), Slip at Max Torque ($s_{\text{max}} \propto R_2'$) & Breakdown Torque ($\tau_{\text{max}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Starting Torque and Pullout Breakdown Torque Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | NEMA Motor Design Class / Torque Region & Technical Operational Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Increasing the Rotor Resistance R2 in a Wound-Rotor Induction Motor Shifts the Peak Breakdown Point Toward Higher Slip but Leaves Maximum Torque Strictly ___ (Unchanged / Constant) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Drives Problem: Calculating s_max, Maximum Torque \tau_max, and Starting Torque \tau_start Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Induction Torque Mechanics (Chapman 2012; Fitzgerald 2013):
   - **Torque & Slip Formulations:**
     $$\mathbf{\tau_{ind} = \frac{3 V_{th}^2 (R_2'/s)}{\omega_s [(R_{th} + R_2'/s)^2 + (X_{th}+X_2')^2]} \quad \Big| \quad \mathbf{s_{\text{max}} = \frac{R_2'}{\sqrt{R_{th}^2 + (X_{th}+X_2')^2}}} \quad \Big| \quad \mathbf{\tau_{\text{max}} = \frac{3 V_{th}^2}{2\omega_s [R_{th} + \sqrt{R_{th}^2 + (X_{th}+X_2')^2}]}}}$$
   - **Torque-Speed Operating Regimes Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Operating Region} & \textbf{Slip Range } s & \textbf{Rotor Speed } n_m & \textbf{Machine Behavior} \\
     \hline
     \mathbf{\text{Motoring Region}} & \mathbf{0 < s < 1} & \mathbf{0 < n_m < n_s} & \mathbf{\text{Converts electrical power to mechanical torque}} \\
     \mathbf{\text{Generating Region}} & s < 0 & n_m > n_s & \text{Supersynchronous: Supplies power back to grid} \\
     \mathbf{\text{Plugging / Braking}} & s > 1 & n_m < 0 \ (\text{Reverse}) & \text{Rapid dynamic braking; dissipates kinetic energy} \\
     \hline
     \end{array}$$
   - **The Rotor Resistance Invariant:** $R_2'$ appears in the numerator and denominator of the maximum torque derivation such that it **cancels out completely**; altering $R_2'$ alters the *speed* at which peak torque occurs, NOT its magnitude!
2. **Slide 2 (`ordering`):** Provide 5 steps of torque-speed analysis: (1) calculate Thevenin equivalent parameters $V_{th}, R_{th}, X_{th}$ from stator and magnetizing impedances, (2) compute slip at maximum breakdown torque: $s_{\text{max}} = \frac{R_2'}{\sqrt{R_{th}^2 + (X_{th} + X_2')^2}}$, (3) calculate pullout maximum breakdown torque $\tau_{\text{max}}$, (4) evaluate starting torque at standstill by substituting $s = 1.0$ into torque equation: $\tau_{\text{start}} = \tau_{ind}(s = 1.0)$, (5) design external rotor resistance $R_{\text{ext}}$ to force $s_{\text{max}} = 1.0$ for maximum starting torque on cranes!
3. **Slide 3 (`matching`):** Pair 4 concepts (Breakdown Torque $\tau_{\text{max}}$, Slip at Max Torque $s_{\text{max}}$, Starting Torque $s=1$, NEMA Class D High-Slip Motor) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Unchanged (or Constant). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating breakdown torque and starting torque: A 3-phase, 4-pole, $60\text{ Hz}$ induction motor has synchronous speed $\omega_s = 188.5\text{ rad/s}$ ($1800\text{ RPM}$). The Thevenin stator voltage is $V_{th} = 220\text{ V}$, $R_{th} = 0.50\ \Omega$, $X_{th} + X_2' = 4.00\ \Omega$, and rotor resistance is $R_2' = 0.40\ \Omega$. What is the slip at maximum torque $s_{\text{max}}$ and the maximum breakdown torque $\tau_{\text{max}}$? ($s_{\text{max}} = \frac{R_2'}{\sqrt{R_{th}^2 + (X_{th} + X_2')^2}} = \frac{0.40}{\sqrt{(0.50)^2 + (4.00)^2}} = \frac{0.40}{\sqrt{0.25 + 16.0}} = \frac{0.40}{\sqrt{16.25}} = \frac{0.40}{4.031} = \mathbf{0.0992 \approx 0.099\text{ (or } 9.9\%)}$; $\tau_{\text{max}} = \frac{3 V_{th}^2}{2\omega_s [R_{th} + \sqrt{R_{th}^2 + (X_{th} + X_2')^2}]} = \frac{3 (220)^2}{2(188.5) [0.50 + 4.031]} = \frac{3 (48400)}{377.0 \times 4.531} = \frac{145200}{1708.2} = \mathbf{85.00\text{ N}\cdot\text{m} \approx 85.0\text{ N}\cdot\text{m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "induction_motor_torque_speed_characteristics_and_breakdown_torque",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Induction Motor Torque \\& Breakdown Mechanics (Stephen Chapman)**\n• **Induced Torque Equation (Stator Thevenin Model):**\n$$\n\\mathbf{\\tau_{ind} = \\frac{3 V_{th}^2 \\left(\\frac{R_2'}{s}\\right)}{\\omega_s \\left[ \\left(R_{th} + \\frac{R_2'}{s}\\right)^2 + (X_{th} + X_2')^2 \\right]}}\n$$\n• **Slip at Maximum (Breakdown) Torque ($s_{\\text{max}}$):**\n$$\n\\mathbf{s_{\\text{max}} = \\frac{R_2'}{\\sqrt{R_{th}^2 + (X_{th} + X_2')^2}}}\n$$\n• **Maximum Breakdown / Pullout Torque ($\\tau_{\\text{max}}$):**\n$$\n\\mathbf{\\tau_{\\text{max}} = \\frac{3 V_{th}^2}{2 \\omega_s \\left[ R_{th} + \\sqrt{R_{th}^2 + (X_{th} + X_2')^2} \\right]}}\n$$\n• **The Rotor Resistance Invariant:** Maximum torque $\\tau_{\\text{max}}$ is **STRICTLY INDEPENDENT of rotor resistance $R_2'$**; adding resistance shifts the torque peak along the speed axis toward higher slip ($s_{\\text{max}} \\propto R_2'$), enabling maximum torque at standstill ($s=1$) for heavy crane starting!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the breakdown torque and torque-speed profile of a 3-phase induction motor.",
      "orderItems": [
        "Calculate the stator Thevenin equivalent parameters: V_th, R_th, and X_th from motor equivalent circuit data",
        "Compute the slip at maximum breakdown torque: s_max = R2' / \u221a(R_th^2 + (X_th + X2')^2)",
        "Calculate the maximum breakdown pullout torque: \u03c4_max using the Chapman closed-form formula",
        "Evaluate the starting torque developed at standstill by setting s = 1.0 in the general torque equation: \u03c4_start = \u03c4_ind(s = 1.0)",
        "Determine the external resistance needed in a wound rotor to force s_max = 1.0 for maximum starting torque"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Induction Motor Torque Characteristic to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Breakdown Torque (\u03c4max)", "right": "Maximum possible torque developed before the motor stalls into the unstable high-slip region" },
        { "left": "Breakdown Slip (s_max)", "right": "s_max = R2' / \u221a(Rth^2 + (Xth+X2')^2), slip point where peak mechanical torque occurs" },
        { "left": "Starting Torque (\u03c4start)", "right": "\u03c4_ind evaluated at s = 1.0, torque available to accelerate heavy inertial loads from standstill" },
        { "left": "Wound-Rotor External Resistor", "right": "Shifts s_max to 1.0 to maximize starting torque without reducing the magnitude of \u03c4max" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Increasing rotor resistance in a wound-rotor induction motor shifts the breakdown point toward higher slip but leaves the maximum torque magnitude strictly ___.",
      "blankAnswer": "unchanged",
      "blankDistractors": ["increased", "decreased", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 3-phase, 4-pole, 60 Hz induction motor operates at synchronous speed \u03c9s = 188.5 rad/s (1800 RPM). Thevenin parameters are Vth = 220 V, Rth = 0.50 \u03a9, Xth + X2' = 4.00 \u03a9, and R2' = 0.40 \u03a9. What is the slip at maximum torque s_max and the maximum breakdown torque \u03c4_max?",
      "options": [
        { "text": "s_max = 0.099 (9.9% slip) and \u03c4_max = 85.0 N\u00b7m (s_max = 0.40 / \u221a(0.5^2 + 4.0^2) = 0.40 / 4.031 = 0.0992; \u03c4_max = 3*(220^2) / [2*188.5 * (0.50 + 4.031)] = 145200 / 1708.2 = 85.00 N\u00b7m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using induction motor breakdown torque formulas (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 6). 1. **Calculate the Thevenin Series Impedance Magnitude:** $$Z_{\\text{series}} = \\sqrt{R_{th}^2 + (X_{th} + X_2')^2} = \\sqrt{(0.50)^2 + (4.00)^2} = \\sqrt{0.25 + 16.00} = \\sqrt{16.25} = \\mathbf{4.0311\\ \\Omega}$$ 2. **Calculate Slip at Maximum Torque ($s_{\\text{max}}$):** $$s_{\\text{max}} = \\frac{R_2'}{\\sqrt{R_{th}^2 + (X_{th} + X_2')^2}} = \\frac{0.40\\ \\Omega}{4.0311\\ \\Omega} = \\mathbf{0.09923 \\approx 0.099\\text{ (or } 9.92\\%\\text{ slip)}}$$ - Operating mechanical speed at peak torque: $$n_{m,\\text{max}} = (1 - s_{\\text{max}}) \\times 1800 = (1 - 0.09923) \\times 1800 = \\mathbf{1621.4\\text{ RPM}}$$ 3. **Calculate Maximum Breakdown Torque ($\\tau_{\\text{max}}$):** $$\\tau_{\\text{max}} = \\frac{3 V_{th}^2}{2 \\omega_s \\left[ R_{th} + \\sqrt{R_{th}^2 + (X_{th} + X_2')^2} \\right]}$$ $$\\tau_{\\text{max}} = \\frac{3 \\times (220\\text{ V})^2}{2 \\times (188.5\\text{ rad/s}) \\times [0.50\\ \\Omega + 4.0311\\ \\Omega]} = \\frac{3 \\times 48400}{377.0 \\times 4.5311} = \\frac{145,200}{1708.22} = \\mathbf{85.00\\text{ N}\\cdot\\text{m}}$$ Flawless induction motor breakdown torque analysis!" },
        { "text": "s_max = 0.200 and \u03c4_max = 120.0 N\u00b7m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "s_max = 0.099 and \u03c4_max = 42.5 N\u00b7m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "s_max = 0.500 and \u03c4_max = 85.0 N\u00b7m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
