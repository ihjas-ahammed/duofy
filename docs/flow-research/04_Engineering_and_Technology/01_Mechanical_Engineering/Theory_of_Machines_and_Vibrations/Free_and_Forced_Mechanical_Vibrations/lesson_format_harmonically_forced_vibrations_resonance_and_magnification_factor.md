# Duofy Reusable Lesson Format: Forced Vibrations (Resonance & Magnification Factor)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Free_and_Forced_Mechanical_Vibrations`  
**Lesson Format Type:** `harmonically_forced_vibrations_resonance_and_magnification_factor`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through harmonically excited SDOF systems, steady-state frequency responses, dynamic amplification, and the physics of catastrophic resonance in mechanical structures (Singiresu S. Rao *Mechanical Vibrations* Chapter 3; William T. Thomson *Theory of Vibration with Applications* Chapter 3): formulate the **Non-Homogeneous Equation of Motion**:
$$\mathbf{m \ddot{x} + c \dot{x} + k x = F_0 \sin(\omega t)}$$
derive the **Steady-State Response Amplitude ($\mathbf{X}$)** and **Phase Lag ($\mathbf{\phi}$)**:
$$\mathbf{X = \frac{F_0 / k}{\sqrt{(1 - r^2)^2 + (2\zeta r)^2}} = X_{\text{static}} \cdot MF \quad \Big| \quad \tan\phi = \frac{2\zeta r}{1 - r^2} \quad \left(r = \frac{\omega}{\omega_n}\right)}$$
master the **Dynamic Magnification Factor ($\mathbf{MF}$)** across the 3 operational regimes:
1. **Low Frequency Zone ($r \ll 1$):** $MF \approx 1$, motion is **Stiffness-Controlled**, displacement is in phase with force ($\phi \approx 0^\circ$);
2. **Resonant Zone ($r \approx 1$):** $MF_{\text{res}} = \frac{1}{2\zeta}$, motion is **Damping-Controlled**, force leads displacement by **exactly $\mathbf{\phi = 90^\circ}$** (meaning input force aligns perfectly in phase with velocity $\dot{x}$, maximizing net power injection into the system);
3. **High Frequency Zone ($r \gg 1$):** $MF \to 0$, motion is **Mass-Controlled / Inertia-Dominated**, displacement is in complete opposite phase ($\phi \approx 180^\circ$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Harmonically Forced Equation, Dynamic Magnification Factor ($MF = \frac{1}{\sqrt{(1-r^2)^2+(2\zeta r)^2}}$) & Phase Lag $\phi$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Steady-State Amplitude and Phase Lag for a Harmonically Excited Machine Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Frequency Ratio Regime / Vibration Feature & Physical Dynamic Control Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | At Pure Resonance (r = 1.0), the Phase Lag Angle Between the Harmonic Excitation Force and System Displacement Is Strictly ___ Degrees (90 / Ninety) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Structural Dynamics Problem: Calculating the Resonant Peak Amplitude of a Machine Foundation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Forced Vibrations & Magnification (Rao 2018; Thomson 2013):
   - **Forced Vibration Formulations:**
     $$\mathbf{X = X_0 \cdot MF \quad \Big| \quad MF = \frac{1}{\sqrt{(1 - r^2)^2 + (2\zeta r)^2}} \quad \Big| \quad \tan\phi = \frac{2\zeta r}{1 - r^2} \quad \left(r = \frac{\omega}{\omega_n}\right)}$$
   - **Frequency Response Regimes Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Frequency Regime} & \textbf{Ratio } r & \textbf{Magnification Factor } MF & \textbf{Phase Lag } \phi & \textbf{Governing Dynamic Regime} \\
     \hline
     \mathbf{\text{Low Frequency}} & r \ll 1 & MF \approx 1 & \phi \to 0^\circ & \mathbf{\text{Stiffness-Controlled } (k x \approx F_0)} \\
     \mathbf{\text{Resonant Peak}} & \mathbf{r = 1.0} & \mathbf{MF = \frac{1}{2\zeta}} & \mathbf{\phi = 90^\circ} & \mathbf{\text{Damping-Controlled } (c \dot{x} = F_0)} \\
     \mathbf{\text{High Frequency}} & r \gg 1 & MF \approx 1/r^2 \to 0 & \phi \to 180^\circ & \mathbf{\text{Mass-Controlled } (m \ddot{x} \approx -F_0)} \\
     \hline
     \end{array}$$
   - **The 90-Degree Phase Invariant:** At resonance ($r = 1$), $\phi = 90^\circ \implies$ force is **100% in phase with velocity $\dot{x}$**, pumping maximum mechanical energy into the vibrating mass!
2. **Slide 2 (`ordering`):** Provide 5 steps of forced vibration analysis: (1) calculate natural frequency $\omega_n = \sqrt{k/m}$ and static deflection $X_{\text{static}} = F_0/k$, (2) determine excitation frequency $\omega$ and compute frequency ratio $r = \omega/\omega_n$, (3) evaluate damping ratio $\zeta = c / (2m\omega_n)$, (4) calculate dynamic magnification factor $MF = \frac{1}{\sqrt{(1-r^2)^2 + (2\zeta r)^2}}$ and phase lag $\phi = \tan^{-1}\left(\frac{2\zeta r}{1-r^2}\right)$, (5) compute steady-state vibration amplitude $X = X_{\text{static}} \cdot MF$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Stiffness-Controlled $r \ll 1$, Resonant Peak $r=1$, Mass-Controlled $r \gg 1$, Phase Angle $\phi=90^\circ$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 90 (or Ninety). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating resonant amplitude: A factory machine of mass $m = 500\text{ kg}$ is mounted on an elastic foundation with total stiffness $k = 2.0 \times 10^6\text{ N/m}$ and damping ratio $\zeta = 0.05$ ($5\%$ damping). An unbalanced motor produces a harmonic force of amplitude $F_0 = 1000\text{ N}$ rotating at the system's exact natural frequency ($r = \frac{\omega}{\omega_n} = 1.0$). What is the steady-state resonant vibration amplitude $X$ of the machine? ($X_{\text{static}} = \frac{F_0}{k} = \frac{1000\text{ N}}{2,000,000\text{ N/m}} = 0.0005\text{ m} = 0.50\text{ mm}$; At resonance ($r=1$), $MF = \frac{1}{2\zeta} = \frac{1}{2(0.05)} = \frac{1}{0.10} = \mathbf{10.0}$; Resonant amplitude $X = X_{\text{static}} \times MF = (0.50\text{ mm}) \times 10.0 = \mathbf{5.0\text{ mm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "harmonically_forced_vibrations_resonance_and_magnification_factor",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Harmonically Forced Vibrations \\& Dynamic Magnification (Singiresu S. Rao)**\n• **Non-Homogeneous Equation of Motion Formulation:**\n$$\n\\mathbf{m \\ddot{x} + c \\dot{x} + k x = F_0 \\sin(\\omega t)}\n$$\n• **Steady-State Amplitude \\& Magnification Formulations:**\n$$\n\\mathbf{X = X_{\\text{static}} \\cdot MF \\quad \\Big| \\quad X_{\\text{static}} = \\frac{F_0}{k} \\quad \\Big| \\quad MF = \\frac{1}{\\sqrt{(1 - r^2)^2 + (2\\zeta r)^2}} \\quad \\left(r = \\frac{\\omega}{\\omega_n}\\right)}\n$$\n• **Phase Lag Formulation:**\n$$\n\\mathbf{\\tan\\phi = \\frac{2\\zeta r}{1 - r^2}}\n$$\n• **The 3 Dynamic Control Regimes:**\n  - $\\mathbf{r \\ll 1}$ (Low-Freq): **Stiffness-Controlled** ($MF \\approx 1, \\phi \\approx 0^\\circ$);\n  - $\\mathbf{r = 1.0}$ (**Resonance**): **Damping-Controlled** ($\\mathbf{MF = \\frac{1}{2\\zeta}, \\ \\phi = 90^\\circ}$);\n  - $\\mathbf{r \\gg 1}$ (High-Freq): **Mass-Controlled** ($MF \\to 0, \\phi \\to 180^\\circ$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the steady-state displacement amplitude and phase lag of a harmonically excited mechanical system.",
      "orderItems": [
        "Compute natural frequency omega_n = sqrt(k / m) and evaluate the static deflection: X_static = F0 / k",
        "Calculate the frequency ratio r = omega / omega_n from the machine operating speed omega",
        "Determine the system damping ratio: zeta = c / (2 * m * omega_n)",
        "Evaluate the Dynamic Magnification Factor: MF = 1 / sqrt((1 - r^2)^2 + (2*zeta*r)^2)",
        "Calculate the steady-state vibration amplitude X = X_static * MF and phase lag angle phi = atan(2*zeta*r / (1 - r^2))"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Forced Vibration Operating Regime to its exact Physical Dynamic Mechanism.",
      "matchPairs": [
        { "left": "Stiffness-Controlled Zone (r << 1)", "right": "Response is governed purely by spring stiffness k with displacement in-phase with applied force (\u03c6 \u2248 0°)" },
        { "left": "Resonant Peak Condition (r = 1.0)", "right": "Response is limited solely by viscous damping c with force leading displacement by exactly \u03c6 = 90°" },
        { "left": "Mass-Controlled Zone (r >> 1)", "right": "Response is dominated by system inertia m with displacement completely out of phase (\u03c6 \u2248 180°)" },
        { "left": "Peak Resonant Magnification", "right": "MF_res = 1 / (2 * \u03b6), magnifying static deflection by the reciprocal of twice the damping ratio" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "At exact resonance (r = 1.0), the phase lag angle between the applied harmonic force and system displacement is strictly ___ degrees.",
      "blankAnswer": "90",
      "blankDistractors": ["0", "45", "180"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A factory machine of mass m = 500 kg is mounted on an elastic foundation of stiffness k = 2.0*10^6 N/m with damping ratio \u03b6 = 0.05. An unbalanced rotor produces a harmonic force of F0 = 1000 N at the exact natural frequency (r = \u03c9 / \u03c9n = 1.0). What is the steady-state resonant vibration amplitude X of the machine?",
      "options": [
        { "text": "X = 5.0 mm (X_static = 0.50 mm and resonant magnification factor MF = 1 / (2 * 0.05) = 10.0)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using forced harmonic resonance theory (Singiresu S. Rao *Mechanical Vibrations* Chapter 3). 1. **Calculate Static Deflection ($X_{\\text{static}}$):** $$X_{\\text{static}} = \\frac{F_0}{k} = \\frac{1000\\text{ N}}{2.0 \\times 10^6\\text{ N/m}} = 0.0005\\text{ m} = \\mathbf{0.50\\text{ mm}}$$ 2. **Calculate Dynamic Magnification Factor at Resonance ($r = 1.0$):** $$MF_{\\text{res}} = \\frac{1}{\\sqrt{(1 - 1^2)^2 + (2 \\times 0.05 \\times 1)^2}} = \\frac{1}{\\sqrt{0 + (0.10)^2}} = \\frac{1}{0.10} = \\mathbf{10.0}$$ 3. **Calculate Resonant Amplitude ($X$):** $$X = X_{\\text{static}} \\times MF_{\\text{res}} = (0.50\\text{ mm}) \\times 10.0 = \\mathbf{5.0\\text{ mm}}$$ 4. **Physical Interpretation:** At resonance, the small $1000\\text{ N}$ dynamic force amplifies the vibration by **ten-fold (10x)**, resulting in a large $5.0\\text{ mm}$ displacement oscillation that can crack foundations if damping is not enhanced!" },
        { "text": "X = 0.50 mm (Equal to static deflection)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "X = 2.5 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "X = 50.0 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
