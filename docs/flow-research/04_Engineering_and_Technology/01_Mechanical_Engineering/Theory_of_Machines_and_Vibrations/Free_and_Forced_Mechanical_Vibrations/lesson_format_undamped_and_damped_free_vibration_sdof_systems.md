# Duofy Reusable Lesson Format: SDOF Free Vibrations (Natural Frequency & Damping Regimes)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Free_and_Forced_Mechanical_Vibrations`  
**Lesson Format Type:** `undamped_and_damped_free_vibration_sdof_systems`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through single degree of freedom (SDOF) mass-spring-damper dynamics, characteristic root analysis, and free response behavior across the 3 fundamental damping regimes in mechanical engineering (Singiresu S. Rao *Mechanical Vibrations* Chapter 2; William T. Thomson *Theory of Vibration with Applications* Chapter 2): formulate the **Homogeneous Equation of Motion**:
$$\mathbf{m \ddot{x} + c \dot{x} + k x = 0 \Longleftrightarrow \mathbf{\ddot{x} + 2\zeta\omega_n \dot{x} + \omega_n^2 x = 0}}$$
where **Undamped Natural Frequency** is $\mathbf{\omega_n = \sqrt{\frac{k}{m}}}$ (rad/s), **Critical Damping Coefficient** is $\mathbf{c_c = 2 \sqrt{k m} = 2 m \omega_n}$, and **Damping Ratio** is $\mathbf{\zeta = \frac{c}{c_c}}$; master the **Three Damping Regimes**:
1. **Underdamped ($\mathbf{\zeta < 1}$):** Complex conjugate roots $s_{1,2} = -\zeta\omega_n \pm i \omega_d$; decaying sinusoidal oscillation at **Damped Natural Frequency $\mathbf{\omega_d = \omega_n \sqrt{1 - \zeta^2}}$** with envelope $X_0 e^{-\zeta\omega_n t}$;
2. **Critically Damped ($\mathbf{\zeta = 1}$):** Repeated real root $s_{1,2} = -\omega_n$; response $\mathbf{x(t) = (C_1 + C_2 t) e^{-\omega_n t}}$ (the **fastest possible return to equilibrium without experiencing overshoot or oscillation**, used in gun recoil mechanisms and vehicle shock absorbers);
3. **Overdamped ($\mathbf{\zeta > 1}$):** Distinct real negative roots; sluggish monotonic exponential creep back to equilibrium ($\mathbf{x(t) = C_1 e^{s_1 t} + C_2 e^{s_2 t}}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SDOF Equation ($\ddot{x} + 2\zeta\omega_n \dot{x} + \omega_n^2 x = 0$) & 3 Damping Regimes Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Natural Frequency, Critical Damping, and Damped Frequency Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Damping Ratio Regime / System Property & Time-Domain Dynamic Response Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Damping Condition That Returns a Displaced System to Equilibrium in the Shortest Possible Time Without Oscillation Is ___ Damping (Critical / Critically) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanical Vibrations Problem: Calculating the Damped Natural Frequency and Decay Envelope of an SDOF System Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SDOF Free Vibrations (Rao 2018; Thomson 2013):
   - **SDOF Formulations:**
     $$\mathbf{\ddot{x} + 2\zeta\omega_n \dot{x} + \omega_n^2 x = 0 \quad \Big| \quad \omega_n = \sqrt{\frac{k}{m}} \quad \Big| \quad c_c = 2\sqrt{km} = 2m\omega_n \quad \Big| \quad \zeta = \frac{c}{c_c}}$$
   - **Damping Regimes Matrix:**
     $$\begin{array}{|l|c|l|l|}
     \hline
     \textbf{Regime Name} & \textbf{Damping Ratio } \zeta & \textbf{Characteristic Roots } s_{1,2} & \textbf{Dynamic Motion Profile} \\
     \hline
     \mathbf{\text{Underdamped}} & \mathbf{\zeta < 1} & -\zeta\omega_n \pm i \omega_n\sqrt{1-\zeta^2} & \mathbf{\text{Oscillatory decay at } \omega_d = \omega_n \sqrt{1 - \zeta^2}} \\
     \mathbf{\text{Critically Damped}} & \mathbf{\zeta = 1} & -\omega_n \text{ (Repeated real)} & \mathbf{\text{Fastest return to 0 WITHOUT oscillation}} \\
     \mathbf{\text{Overdamped}} & \mathbf{\zeta > 1} & -\zeta\omega_n \pm \omega_n\sqrt{\zeta^2-1} & \text{Sluggish monotonic non-oscillatory decay} \\
     \hline
     \end{array}$$
   - **Damped Frequency Invariant:** In underdamped systems, damping **ALWAYS reduces the oscillation frequency ($\mathbf{\omega_d < \omega_n}$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of SDOF free vibration analysis: (1) determine equivalent mass $m$ and spring stiffness $k$ to compute undamped natural frequency $\omega_n = \sqrt{k/m}$, (2) calculate critical damping coefficient $c_c = 2 m \omega_n$, (3) evaluate damping ratio $\zeta = \frac{c}{c_c}$ from given viscous damper $c$, (4) verify regime: if $\zeta < 1$, calculate damped natural frequency $\omega_d = \omega_n \sqrt{1 - \zeta^2}$, (5) formulate full time response $x(t) = e^{-\zeta\omega_n t}(A \cos\omega_d t + B \sin\omega_d t)$ satisfying initial conditions $x(0) = x_0, \dot{x}(0) = v_0$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Underdamped $\zeta < 1$, Critically Damped $\zeta = 1$, Overdamped $\zeta > 1$, Damped Frequency $\omega_d$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Critical (or Critically). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating damped natural frequency: A mechanical suspension system has mass $m = 100\text{ kg}$, spring stiffness $k = 40,000\text{ N/m}$, and viscous damping coefficient $c = 800\text{ N}\cdot\text{s/m}$. What is the damped natural frequency $\omega_d$ of the system? ($\omega_n = \sqrt{\frac{k}{m}} = \sqrt{\frac{40,000}{100}} = \sqrt{400} = \mathbf{20.0\text{ rad/s}}$; $c_c = 2 m \omega_n = 2(100)(20) = \mathbf{4000\text{ N}\cdot\text{s/m}}$; $\zeta = \frac{c}{c_c} = \frac{800}{4000} = \mathbf{0.20} < 1$ (Underdamped!); $\omega_d = \omega_n \sqrt{1 - \zeta^2} = 20 \sqrt{1 - (0.2)^2} = 20 \sqrt{1 - 0.04} = 20 \sqrt{0.96} = 20 (0.979796) \approx \mathbf{19.60\text{ rad/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "undamped_and_damped_free_vibration_sdof_systems",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: SDOF Free Vibrations \\& Damping Regimes (Singiresu S. Rao)**\n• **Homogeneous Equation of Motion Formulation:**\n$$\n\\mathbf{\\ddot{x} + 2\\zeta\\omega_n \\dot{x} + \\omega_n^2 x = 0 \\quad \\Big| \\quad \\omega_n = \\sqrt{\\frac{k}{m}} \\quad \\Big| \\quad c_c = 2\\sqrt{km} = 2m\\omega_n \\quad \\Big| \\quad \\zeta = \\frac{c}{c_c}}\n$$\n• **The 3 Fundamental Damping Regimes:**\n$$\n\\begin{array}{|l|c|l|l|}\n\\hline\n\\textbf{Damping Regime} & \\textbf{Damping Ratio } \\zeta & \\textbf{Roots } s_{1,2} & \\textbf{Dynamic Physical Behavior} \\\\\n\\hline\n\\mathbf{\\text{Underdamped}} & \\mathbf{\\zeta < 1} & -\\zeta\\omega_n \\pm i \\omega_d & \\mathbf{\\text{Oscillatory decay at } \\omega_d = \\omega_n \\sqrt{1 - \\zeta^2}} \\\\\n\\mathbf{\\text{Critically Damped}} & \\mathbf{\\zeta = 1} & -\\omega_n \\text{ (Repeated)} & \\mathbf{\\text{Fastest return to 0 WITHOUT oscillation}} \\\\\n\\mathbf{\\text{Overdamped}} & \\mathbf{\\zeta > 1} & -\\zeta\\omega_n \\pm \\omega_n\\sqrt{\\zeta^2-1} & \\text{Sluggish monotonic exponential decay} \\\\\n\\hline\n\\end{array}\n$$\n• **Damped Frequency Invariant:** Viscous damping always lowers natural oscillation frequency: $\\mathbf{\\omega_d = \\omega_n \\sqrt{1 - \\zeta^2} < \\omega_n}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the damped natural frequency and analytical time response of a vibrating SDOF mass-spring-damper system.",
      "orderItems": [
        "Determine the equivalent mass m and spring stiffness k to evaluate undamped natural frequency omega_n = sqrt(k / m)",
        "Calculate the critical damping coefficient of the system: c_c = 2 * sqrt(k * m) = 2 * m * omega_n",
        "Compute the dimensionless damping ratio: zeta = c / c_c",
        "Verify that zeta < 1 and calculate the damped natural frequency: omega_d = omega_n * sqrt(1 - zeta^2)",
        "Construct the complete free response equation x(t) = exp(-zeta*omega_n*t) * (A*cos(omega_d*t) + B*sin(omega_d*t))"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Damping Characteristic to its exact Dynamic Motion Profile.",
      "matchPairs": [
        { "left": "Underdamped (\u03b6 < 1)", "right": "Oscillates with exponentially decaying amplitude envelope at frequency \u03c9d = \u03c9n*sqrt(1 - \u03b6^2)" },
        { "left": "Critically Damped (\u03b6 = 1)", "right": "Returns to equilibrium in the fastest possible time without crossing zero or oscillating" },
        { "left": "Overdamped (\u03b6 > 1)", "right": "Non-oscillatory motion characterized by slow, sluggish exponential creep back to neutral" },
        { "left": "Critical Damping (c_c)", "right": "c_c = 2 * m * \u03c9n, the exact damping threshold separating oscillatory from non-oscillatory motion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The damping condition that returns a displaced system to equilibrium in the shortest possible time without oscillation is ___ damping.",
      "blankAnswer": "critical",
      "blankDistractors": ["harmonic", "underdamped", "overdamped"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A mechanical system has mass m = 100 kg, spring stiffness k = 40,000 N/m, and viscous damping coefficient c = 800 N·s/m. What is the damped natural frequency \u03c9d of the system?",
      "options": [
        { "text": "\u03c9d = 19.60 rad/s (\u03c9n = 20.0 rad/s, c_c = 4000 N·s/m, \u03b6 = 0.20, and \u03c9d = 20 * sqrt(1 - 0.04) = 19.60 rad/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using SDOF vibration theory (Singiresu S. Rao *Mechanical Vibrations* Chapter 2). 1. **Calculate Undamped Natural Frequency ($\\omega_n$):** $$\\omega_n = \\sqrt{\\frac{k}{m}} = \\sqrt{\\frac{40,000\\text{ N/m}}{100\\text{ kg}}} = \\sqrt{400} = \\mathbf{20.0\\text{ rad/s}}$$ 2. **Calculate Critical Damping Coefficient ($c_c$):** $$c_c = 2 m \\omega_n = 2(100\\text{ kg})(20.0\\text{ rad/s}) = \\mathbf{4000\\text{ N}\\cdot\\text{s/m}}$$ 3. **Calculate Damping Ratio ($\\zeta$):** $$\\zeta = \\frac{c}{c_c} = \\frac{800\\text{ N}\\cdot\\text{s/m}}{4000\\text{ N}\\cdot\\text{s/m}} = \\mathbf{0.20}$$ - Since $\\zeta = 0.20 < 1.0$, the system is **underdamped and will oscillate**! 4. **Calculate Damped Natural Frequency ($\\omega_d$):** $$\\omega_d = \\omega_n \\sqrt{1 - \\zeta^2} = 20.0 \\sqrt{1 - (0.20)^2} = 20.0 \\sqrt{1 - 0.04} = 20.0 \\sqrt{0.96} = 20.0 (0.979796) \\approx \\mathbf{19.596\\text{ rad/s} \\approx 19.60\\text{ rad/s}}$$ Flawless damped natural frequency calculation!" },
        { "text": "\u03c9d = 20.00 rad/s (Undamped frequency)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c9d = 16.00 rad/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c9d = 4.00 rad/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
