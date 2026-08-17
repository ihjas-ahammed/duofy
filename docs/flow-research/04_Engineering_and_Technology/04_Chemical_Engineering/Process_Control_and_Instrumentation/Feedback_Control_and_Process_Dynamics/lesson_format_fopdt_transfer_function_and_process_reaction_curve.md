# Duofy Reusable Lesson Format: Process Dynamics (FOPDT Transfer Functions & Reaction Curves)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Process_Control_and_Instrumentation / Feedback_Control_and_Process_Dynamics`  
**Lesson Format Type:** `fopdt_transfer_function_and_process_reaction_curve`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through empirical chemical process dynamic modeling, deviation variables ($X(t) = x(t) - \bar{x}$), Laplace transform conversion ($s$-domain), the **First-Order Plus Dead Time (FOPDT)** transfer function, steady-state process gain ($K_p = \Delta y_{\infty} / \Delta u$), process time constant ($\tau_p$), apparent transportation dead time ($\theta_d$), the **Process Reaction Curve (Step Test)**, the classic **63.2% Response Method**, and the 28.3% / 63.2% two-point tangent calibration (Dale E. Seborg *Process Dynamics and Control* 4th ed. Chapters 4 & 7; George Stephanopoulos *Chemical Process Control* Chapter 9): formulate the **FOPDT Transfer Function Master Formulation**:
$$\mathbf{G_p(s) = \frac{Y(s)}{U(s)} = \frac{K_p \cdot e^{-\theta_d s}}{\tau_p s + 1}}$$
where:
1. **$K_p$:** Steady-state process gain ($\mathbf{K_p = \frac{\Delta y(\infty)}{\Delta u}}$ in engineering output units per input unit);
2. **$\tau_p$:** Process time constant measuring dynamic thermal/hydraulic inertia (in minutes or seconds);
3. **$\theta_d$:** Apparent dead time or transport delay (in minutes or seconds);
derive the **Time-Domain Analytical Step Response Equation ($u(t) = \Delta u \cdot S(t)$)**:
$$\mathbf{y(t) = \begin{cases} 0 & \text{for } t < \theta_d \\ K_p \cdot \Delta u \left[ 1 - \exp\left( -\frac{t - \theta_d}{\tau_p} \right) \right] & \text{for } t \ge \theta_d \end{cases}}$$
master the **Two-Point Calibration Heuristic**:
- At $t_1 = \theta_d + \frac{\tau_p}{3} \implies y(t_1) = 0.283 \cdot \Delta y_{\infty}$ ($28.3\%$ of final response);
- At $t_2 = \theta_d + \tau_p \implies y(t_2) = (1 - e^{-1}) \cdot \Delta y_{\infty} = \mathbf{0.632 \cdot \Delta y_{\infty}}$ ($63.2\%$ of final response);
$$\mathbf{\tau_p = 1.50 \left( t_2 - t_1 \right) \quad \Big| \quad \theta_d = t_2 - \tau_p}$$
(proving that over $90\%$ of chemical engineering unit operations—heat exchangers, stirred tanks, pipelines—can be accurately modeled by these three intuitive physical parameters).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | FOPDT Transfer Function ($G_p(s) = \frac{K_p e^{-\theta_d s}}{\tau_p s + 1}$) & 63.2% Step Response Rule Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Extract FOPDT Model Parameters ($K_p, \tau_p, \theta_d$) from a Step Reaction Curve Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | FOPDT Dynamic Parameter / Curve Feature & Technical Control Engineering Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a First-Order Process Subjected to a Step Input, the Time Elapsed for the Output to Reach Exactly 63.2% of its Ultimate Steady-State Change After Dead Time Equals the Process ___ Constant $\tau_p$ (Time / Time Constant) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Process Dynamics Problem: Extracting K_p, tau_p, and theta_d from an Exothermic CSTR Temperature Step Test Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State FOPDT Transfer Function Mechanics (Seborg 2016; Stephanopoulos 1984):
   - **Dynamic Formulations:**
     $$\mathbf{G_p(s) = \frac{K_p e^{-\theta_d s}}{\tau_p s + 1} \quad \Big| \quad y(t) = K_p \Delta u \left[1 - e^{-(t - \theta_d)/\tau_p}\right] \quad \Big| \quad K_p = \frac{\Delta y_\infty}{\Delta u}}$$
   - **Response Milestone Times Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Elapsed Time } t & \textbf{Fractional Response } y(t)/\Delta y_\infty & \textbf{Physical System State} \\
     \hline
     \mathbf{t < \theta_d} & \mathbf{0.0\%} & \text{Dead time / pure transportation lag; no output change} \\
     \mathbf{t = \theta_d + \tau_p} & \mathbf{63.2\%} & \mathbf{1 - e^{-1} = 0.6321 \ (\text{Standard time constant benchmark})} \\
     t = \theta_d + 2\tau_p & 86.5\% & 1 - e^{-2} = 0.8647 \\
     t = \theta_d + 3\tau_p & 95.0\% & 1 - e^{-3} = 0.9502 \ (\text{Settling time threshold}) \\
     \mathbf{t = \theta_d + 4\tau_p} & \mathbf{98.2\%} & \mathbf{1 - e^{-4} = 0.9817 \ (\text{Practical steady state reached})} \\
     \hline
     \end{array}$$
   - **The Asymptotic Inertia Invariant:** The process time constant $\tau_p$ reflects **capacitive thermal/fluid storage capacity divided by flow conductance ($\tau = R \cdot C$)**; large jacketed reactors exhibit slow time constants ($\tau \approx 30\text{ min}$), while thermocouple sensors respond rapidly ($\tau \approx 2\text{ s}$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of FOPDT parameter estimation: (1) introduce a known step change $\Delta u$ in the manipulated variable (e.g. cooling water valve $+10\%$), (2) record the process output reaction curve $y(t)$ until a new steady state is reached, (3) calculate steady-state gain: $K_p = \frac{y_{\text{final}} - y_{\text{initial}}}{\Delta u}$, (4) identify dead time $\theta_d$ as the time before initial deflection occurs, (5) measure time $t_{63.2}$ where response reaches $63.2\%$ of $\Delta y_\infty$ and compute time constant $\tau_p = t_{63.2} - \theta_d$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Process Gain $K_p$, Time Constant $\tau_p$, Dead Time $\theta_d$, Deviation Variable) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Time (or Time Constant). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on extracting FOPDT parameters: A step change in steam valve opening of $\Delta u = +5.0\%$ is applied to a heat exchanger. The outlet temperature was initially $50.0^\circ\text{C}$ and settles at a new steady state of $70.0^\circ\text{C}$ ($\Delta y_\infty = 70.0 - 50.0 = 20.0^\circ\text{C}$). The temperature starts moving at $t = 2.0\text{ min}$ (Dead time $\theta_d = 2.0\text{ min}$). The temperature reaches $63.2\%$ of its total rise ($50.0 + 0.632 \times 20.0 = 62.64^\circ\text{C}$) at $t = 8.0\text{ min}$.
   - Process gain: $K_p = \frac{\Delta y_\infty}{\Delta u} = \frac{20.0^\circ\text{C}}{5.0\%} = \mathbf{4.00^\circ\text{C}/\%}$;
   - Time constant: $\tau_p = t_{63.2} - \theta_d = 8.0\text{ min} - 2.0\text{ min} = \mathbf{6.00\text{ min}}$;
   - Dead time: $\theta_d = \mathbf{2.00\text{ min}}$;
   - Transfer function: $G_p(s) = \frac{4.0 e^{-2.0 s}}{6.0 s + 1}$;
   - What are the FOPDT parameters $K_p, \tau_p, \text{ and } \theta_d$? ($K_p = \mathbf{4.0^\circ\text{C}/\%}, \tau_p = \mathbf{6.0\text{ min}}, \theta_d = \mathbf{2.0\text{ min}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fopdt_transfer_function_and_process_reaction_curve",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: First-Order Plus Dead Time Dynamics (Seborg \\& Edgar)**\n• **FOPDT Transfer Function Master Formulation:**\n$$\n\\mathbf{G_p(s) = \\frac{Y(s)}{U(s)} = \\frac{K_p \\cdot e^{-\\theta_d s}}{\\tau_p s + 1}}\n$$\n  - **$K_p = \\frac{\\Delta y(\\infty)}{\\Delta u}$:** Steady-state process gain;\n  - **$\\tau_p$:** Process time constant measuring dynamic inertia;\n  - **$\\theta_d$:** Apparent dead time or transport delay;\n• **Time-Domain Analytical Step Response:**\n$$\n\\mathbf{y(t) = K_p \\cdot \\Delta u \\left[ 1 - \\exp\\left( -\\frac{t - \\theta_d}{\\tau_p} \\right) \\right] \\cdot S(t - \\theta_d)}\n$$\n• **The 63.2% Reaction Curve Rule:**\n  - At $t = \\theta_d + \\tau_p \\implies y(t) = (1 - e^{-1}) \\cdot \\Delta y_\\infty = \\mathbf{0.632 \\cdot \\Delta y_\\infty}$;\n  - At $t = \\theta_d + 4\\tau_p \\implies y(t) = 0.982 \\cdot \\Delta y_\\infty$ (Practical steady-state reached);\n• **The Dynamic Inertia Invariant:** Over $90\\%$ of continuous chemical processes are accurately modeled by FOPDT; **time constant $\\tau_p$ dictates how long energy/mass accumulates** before reaching full steady-state equilibrium!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to extract FOPDT model parameters (Kp, \u03c4p, \u03b8d) from an open-loop step test reaction curve.",
      "orderItems": [
        "Introduce a sudden step change \u0394u in the manipulated input variable while the process operates at steady state",
        "Record the transient process response curve y(t) until the output settles at a new steady state y_final",
        "Calculate the steady-state process gain: Kp = (y_final - y_initial) / \u0394u",
        "Identify the transportation dead time \u03b8d as the time lag before the initial detectable change in output occurs",
        "Locate the time t_63.2 when the response reaches 63.2% of its total rise and compute time constant: \u03c4p = t_63.2 - \u03b8d"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Process Dynamics Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Process Gain (Kp)", "right": "Kp = \u0394y_\u221e / \u0394u, sensitivity factor measuring how much steady-state output changes per unit step input" },
        { "left": "Time Constant (\u03c4p)", "right": "Characteristic time required for the process to achieve 63.2% of its total output change after dead time" },
        { "left": "Dead Time (\u03b8d)", "right": "Pure transportation or measurement delay during which the process output exhibits zero response" },
        { "left": "Deviation Variable", "right": "X(t) = x(t) - x_ss, transformation defining process variables relative to their initial steady-state baseline" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a first-order process subjected to a step input, the time elapsed for the output to reach exactly 63.2% of its ultimate steady-state change after dead time equals the process ___ constant \u03c4p.",
      "blankAnswer": "time",
      "blankDistractors": ["gain", "damping", "frequency"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A step test of \u0394u = +5.0% is applied to a heat exchanger. Temperature rises from 50.0\u00b0C to 70.0\u00b0C (\u0394y_\u221e = 20.0\u00b0C). The response starts moving at t = 2.0 min and reaches 63.2% of total rise (62.64\u00b0C) at t = 8.0 min. What are the FOPDT parameters Kp, \u03c4p, and \u03b8d?",
      "options": [
        { "text": "Kp = 4.0\u00b0C/%, \u03c4p = 6.0 min, and \u03b8d = 2.0 min (Kp = 20.0 / 5.0 = 4.0\u00b0C/%; \u03b8d = 2.0 min; \u03c4p = 8.0 - 2.0 = 6.0 min)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the standard 63.2% process reaction curve method (Dale E. Seborg *Process Dynamics and Control* Chapter 4 & 7). 1. **Calculate Steady-State Process Gain ($K_p$):** - Input step size: $\\Delta u = +5.0\\%$. - Total steady-state output change: $$\\Delta y_\\infty = y_{\\text{final}} - y_{\\text{initial}} = 70.0^\\circ\\text{C} - 50.0^\\circ\\text{C} = \\mathbf{20.0^\\circ\\text{C}}$$ - Process gain: $$K_p = \\frac{\\Delta y_\\infty}{\\Delta u} = \\frac{20.0^\\circ\\text{C}}{5.0\\%} = \\mathbf{4.00^\\circ\\text{C}/\\%}$$ 2. **Extract Transportation Dead Time ($\\theta_d$):** - The temperature remains unchanged until $t = 2.0\\text{ min}$. - Therefore: $$\\theta_d = \\mathbf{2.00\\text{ min}}$$ 3. **Calculate Process Time Constant ($\\tau_p$):** - The output reaches $63.2\\%$ of its ultimate rise at time $t_{63.2} = 8.0\\text{ min}$. - By definition of a first-order response: $$t_{63.2} = \\theta_d + \\tau_p \\Longleftrightarrow \\tau_p = t_{63.2} - \\theta_d$$ $$\\tau_p = 8.0\\text{ min} - 2.0\\text{ min} = \\mathbf{6.00\\text{ min}}$$ 4. **Formulate Resulting Transfer Function:** $$G_p(s) = \\frac{4.00 \\cdot e^{-2.00 s}}{6.00 s + 1}$$ Flawless FOPDT process dynamic parameter extraction!" },
        { "text": "Kp = 4.0\u00b0C/%, \u03c4p = 8.0 min, and \u03b8d = 2.0 min (Forgot to subtract dead time from t_63.2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Kp = 20.0\u00b0C/%, \u03c4p = 6.0 min, and \u03b8d = 2.0 min", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Kp = 4.0\u00b0C/%, \u03c4p = 3.0 min, and \u03b8d = 1.0 min", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
