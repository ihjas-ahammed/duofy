# Duofy Reusable Lesson Format: Synchronous Machines (Power-Angle Curves & Stability)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Induction_and_Synchronous_Motors`  
**Lesson Format Type:** `synchronous_motor_power_angle_curves_and_static_stability`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through three-phase synchronous machines, cylindrical rotor electromagnetic field interactions, internal generated voltage ($E_A$), synchronous reactance ($X_s$), torque/power angle ($\delta$), the sinusoidal power-angle characteristic ($P = \frac{3 V_\phi E_A}{X_s} \sin\delta$), pullout torque limits, and the static stability margin in high-voltage power grids (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 5 & 7; A. E. Fitzgerald *Electric Machinery* Chapter 4 & 5): derive the **Cylindrical Rotor Synchronous Machine Power-Angle Formulation**:
$$\mathbf{P_{3\phi} = \frac{3 V_{\phi} E_A}{X_s} \sin\delta \Longleftrightarrow \mathbf{\tau_{ind} = \frac{3 V_{\phi} E_A}{\omega_s X_s} \sin\delta}}$$
where:
1. **$V_\phi$:** Stator phase terminal voltage;
2. **$E_A$:** Internal excitation back-EMF ($E_A = k \phi \omega_s \propto I_F$);
3. **$X_s$:** Synchronous reactance ($X_s = X_m + X_l$);
4. **$\delta$ (Torque / Power Angle):** Spatial displacement angle between rotor magnetic field ($B_R$) and net air-gap magnetic field ($B_{\text{net}}$);
derive the **Static Stability Limit & Pullout Torque**:
$$\mathbf{P_{\text{max}} = \frac{3 V_{\phi} E_A}{X_s} \quad (\text{Occurs at } \delta = 90^\circ) \implies \mathbf{\tau_{\text{pullout}} = \frac{P_{\text{max}}}{\omega_s} = \frac{3 V_{\phi} E_A}{\omega_s X_s}}}$$
(analyzing why attempting to load a synchronous machine beyond $\delta = 90^\circ$ causes the machine to "pull out of step", losing synchronization and triggering severe mechanical vibrations and electrical overcurrent trips).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Power-Angle Equation ($P = \frac{3 V_\phi E_A}{X_s} \sin\delta$), Pullout Torque ($\delta = 90^\circ$) & Static Stability Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Torque Angle \delta and Pullout Torque of a Synchronous Motor Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Synchronous Machine Variable / Operating State & Technical Electrical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Theoretical Maximum Power Limit and Static Stability Boundary of a Cylindrical Synchronous Machine Occurs at a Torque Angle of Exactly ___ Degrees (90 / Ninety) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Grid Substation Problem: Calculating Power Angle \delta and Pullout Torque for a 480V Synchronous Motor Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Synchronous Power-Angle Dynamics (Chapman 2012; Fitzgerald 2013):
   - **Power-Angle & Pullout Formulations:**
     $$\mathbf{P_{3\phi} = \frac{3 V_\phi E_A}{X_s} \sin\delta \quad \Big| \quad \tau_{ind} = \frac{3 V_\phi E_A}{\omega_s X_s} \sin\delta \quad \Big| \quad P_{\text{max}} = \frac{3 V_\phi E_A}{X_s} \ (\delta = 90^\circ)}$$
   - **Torque Angle Operating Spectrum Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Power Angle Range } \delta & \textbf{Machine Operating Mode} & \textbf{Real Power Flow } P & \textbf{Stability Status} \\
     \hline
     \mathbf{0^\circ < \delta < 90^\circ} & \mathbf{\text{Synchronous Motor (Motoring)}} & \mathbf{\text{Absorbs electrical } P > 0} & \mathbf{\text{Stable (Positive synchronizing torque)}} \\
     \mathbf{-90^\circ < \delta < 0^\circ} & \mathbf{\text{Synchronous Generator (Generating)}} & \mathbf{\text{Delivers electrical } P < 0} & \mathbf{\text{Stable (Rotor leads stator field)}} \\
     \mathbf{\delta = 90^\circ} & \text{Pullout Boundary} & P = P_{\text{max}} & \text{Marginal static stability threshold} \\
     \mathbf{\delta > 90^\circ} & \text{Loss of Synchronism} & dP/d\delta < 0 & \mathbf{\text{Dynamically Unstable (Pulls out of step)}} \\
     \hline
     \end{array}$$
   - **The Synchronizing Power Invariant:** The synchronizing power coefficient $\mathbf{P_{\text{syn}} = \frac{dP}{d\delta} = \frac{3 V_\phi E_A}{X_s} \cos\delta}$ must remain strictly positive ($> 0$, requiring $|\delta| < 90^\circ$) to restore rotor balance following transient load disturbances!
2. **Slide 2 (`ordering`):** Provide 5 steps of synchronous motor power-angle analysis: (1) calculate stator phase voltage $V_\phi$ and synchronous speed $\omega_s = 2\pi n_s / 60$, (2) express per-phase equivalent circuit phasor equation: $\mathbf{E_A} = \mathbf{V_\phi} - j X_s \mathbf{I_A}$, (3) determine magnitude $|E_A|$ and power angle $\delta = \angle E_A$, (4) compute real converted mechanical power $P = \frac{3 V_\phi E_A}{X_s} \sin\delta$, (5) calculate maximum static pullout limit by setting $\delta = 90^\circ$: $P_{\text{max}} = \frac{3 V_\phi E_A}{X_s}$ and $\tau_{\text{pullout}} = P_{\text{max}} / \omega_s$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Power Angle $\delta$, Pullout Torque $\tau_{\text{pullout}}$, Synchronous Reactance $X_s$, Synchronizing Power Coefficient $dP/d\delta$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 90 (or Ninety). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating power angle and pullout torque: A $480\text{ V}$ (line-to-line), $60\text{ Hz}$, $4\text{-pole}$ ($n_s = 1800\text{ RPM}, \ \omega_s = 188.5\text{ rad/s}$), Wye-connected cylindrical synchronous motor has synchronous reactance $X_s = 1.50\ \Omega$ per phase (armature resistance $R_A \approx 0$). The field excitation is adjusted so that the internal back EMF is $E_A = 277\text{ V}$. The motor is delivering $P_{3\phi} = 50.0\text{ kW}$ of mechanical power. What is the power angle $\delta$, the maximum static power limit $P_{\text{max}}$, and the pullout torque $\tau_{\text{pullout}}$? ($V_\phi = \frac{480}{\sqrt{3}} = \mathbf{277.13\text{ V} \approx 277\text{ V}}$; $P_{\text{max}} = \frac{3 V_\phi E_A}{X_s} = \frac{3(277)(277)}{1.50} = \frac{3(76729)}{1.50} = \frac{230187}{1.50} = \mathbf{153.46\text{ kW}}$; $P = P_{\text{max}} \sin\delta \implies 50.0\text{ kW} = 153.46\text{ kW} \sin\delta \implies \sin\delta = \frac{50.0}{153.46} = 0.3258 \implies \delta = \arcsin(0.3258) = \mathbf{19.01^\circ \approx 19.0^\circ}$; $\tau_{\text{pullout}} = \frac{P_{\text{max}}}{\omega_s} = \frac{153460\text{ W}}{188.5\text{ rad/s}} = \mathbf{814.1\text{ N}\cdot\text{m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "synchronous_motor_power_angle_curves_and_static_stability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Synchronous Motor Power-Angle Dynamics (Stephen Chapman)**\n• **Cylindrical Rotor Power-Angle Formulation ($R_A \\approx 0$):**\n$$\n\\mathbf{P_{3\\phi} = \\frac{3 V_{\\phi} E_A}{X_s} \\sin\\delta \\Longleftrightarrow \\mathbf{\\tau_{ind} = \\frac{3 V_{\\phi} E_A}{\\omega_s X_s} \\sin\\delta}}\n$$\n• **Static Stability Limit \\& Maximum Pullout Torque (at $\\delta = 90^\\circ$):**\n$$\n\\mathbf{P_{\\text{max}} = \\frac{3 V_{\\phi} E_A}{X_s} \\quad \\Big| \\quad \\mathbf{\\tau_{\\text{pullout}} = \\frac{P_{\\text{max}}}{\\omega_s} = \\frac{3 V_{\\phi} E_A}{\\omega_s X_s}}}\n$$\n• **Synchronizing Power Stiffness Coefficient ($P_{\\text{syn}}$):**\n$$\n\\mathbf{P_{\\text{syn}} = \\frac{dP}{d\\delta} = \\frac{3 V_{\\phi} E_A}{X_s} \\cos\\delta > 0 \\quad (\\text{Guarantees Dynamic Stability for } |\\delta| < 90^\\circ)}\n$$\n• **The Pullout Invariant:** If shaft mechanical load exceeds $P_{\\text{max}}$ (forcing $\\delta > 90^\\circ$), the motor **pulls out of synchronism**, stalling violently with massive acoustic noise and tripping overcurrent circuit breakers!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the operating power angle \u03b4 and maximum pullout torque of a synchronous motor.",
      "orderItems": [
        "Calculate the per-phase terminal voltage: V_\u03c6 = V_L / \u221a3 for a Wye-connected stator and synchronous speed \u03c9s",
        "Record the internal back-EMF excitation voltage magnitude |EA| and synchronous reactance Xs",
        "Compute the maximum theoretical static power limit: P_max = (3 * V_\u03c6 * EA) / Xs occurring at \u03b4 = 90\u00b0",
        "Calculate the operating power angle: \u03b4 = arcsin(P_actual / P_max) for the given shaft power load",
        "Compute the maximum pullout torque: \u03c4_pullout = P_max / \u03c9s"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Synchronous Machine Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Power Angle (\u03b4)", "right": "Spatial displacement angle between the rotor magnetic field and the stator resultant air-gap field" },
        { "left": "Pullout Torque (\u03c4pullout)", "right": "\u03c4_pullout = (3*V\u03c6*EA) / (\u03c9s*Xs), maximum sustainable torque developed at \u03b4 = 90\u00b0 before loss of synchronism" },
        { "left": "Synchronizing Power (dP/d\u03b4)", "right": "Electromagnetic spring stiffness restoring the rotor to equilibrium following sudden load steps" },
        { "left": "Static Stability Limit", "right": "\u03b4 = 90\u00b0 boundary beyond which synchronizing power becomes negative, causing pole-slipping" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The theoretical maximum power limit and static stability boundary of a cylindrical synchronous motor occurs at a power angle of exactly ___ degrees.",
      "blankAnswer": "90",
      "blankDistractors": ["45", "60", "180"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 480 V (line-to-line), 60 Hz, 4-pole Wye-connected synchronous motor (\u03c9s = 188.5 rad/s) has Xs = 1.50 \u03a9 per phase. Field current is set such that EA = 277 V (equal to per-phase terminal voltage V\u03c6 = 277 V). The motor delivers P = 50.0 kW. What is the power angle \u03b4, maximum power Pmax, and pullout torque \u03c4_pullout?",
      "options": [
        { "text": "Pmax = 153.5 kW, \u03b4 = 19.0\u00b0, and \u03c4_pullout = 814.1 N\u00b7m (Pmax = 3*(277*277)/1.5 = 153.46 kW; \u03b4 = arcsin(50/153.46) = 19.01\u00b0; \u03c4_pullout = 153460 / 188.5 = 814.1 N\u00b7m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the synchronous motor power-angle formulation (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 5). 1. **Calculate Per-Phase Terminal Voltage ($V_\\phi$):** $$V_\\phi = \\frac{V_L}{\\sqrt{3}} = \\frac{480\\text{ V}}{\\sqrt{3}} = \\mathbf{277.13\\text{ V} \\approx 277\\text{ V}}$$ 2. **Calculate Maximum Theoretical Power Limit ($P_{\\text{max}}$):** - Occurs when power angle $\\delta = 90^\\circ$ (where $\\sin 90^\\circ = 1.0$): $$P_{\\text{max}} = \\frac{3 \\times V_\\phi \\times E_A}{X_s} = \\frac{3 \\times (277.13\\text{ V}) \\times (277.0\\text{ V})}{1.50\\ \\Omega} = \\frac{230,295}{1.50} = \\mathbf{153,463\\text{ W} = 153.46\\text{ kW}}$$ 3. **Calculate Operating Power Angle ($\\delta$) at $P = 50.0\\text{ kW}$:** $$P = P_{\\text{max}} \\sin\\delta \\implies 50.0\\text{ kW} = 153.46\\text{ kW} \\times \\sin\\delta$$ $$\\sin\\delta = \\frac{50.0\\text{ kW}}{153.46\\text{ kW}} = 0.32582$$ $$\\delta = \\arcsin(0.32582) = \\mathbf{19.014^\\circ \\approx 19.0^\\circ}$$ 4. **Calculate Maximum Pullout Torque ($\\tau_{\\text{pullout}}$):** $$\\tau_{\\text{pullout}} = \\frac{P_{\\text{max}}}{\\omega_s} = \\frac{153,463\\text{ W}}{188.5\\text{ rad/s}} = \\mathbf{814.13\\text{ N}\\cdot\\text{m} \\approx 814.1\\text{ N}\\cdot\\text{m}}$$ Flawless synchronous power-angle and pullout torque derivation!" },
        { "text": "Pmax = 50.0 kW, \u03b4 = 90.0\u00b0, and \u03c4_pullout = 265.3 N\u00b7m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pmax = 300.0 kW, \u03b4 = 9.59\u00b0, and \u03c4_pullout = 1591.5 N\u00b7m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pmax = 153.5 kW, \u03b4 = 45.0\u00b0, and \u03c4_pullout = 575.6 N\u00b7m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
