# Duofy Reusable Lesson Format: PID Control (Modes, Laplace Transforms, & Error Action)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Process_Control_and_Instrumentation / Feedback_Control_and_Process_Dynamics`  
**Lesson Format Type:** `pid_controller_modes_and_error_compensation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the core feedback mechanisms in industrial process automation, error definition ($e(t) = y_{\text{sp}}(t) - y(t)$ or $y(t) - y_{\text{sp}}(t)$), the three distinct control modes: **Proportional (P)**, **Integral (I)**, and **Derivative (D)**, the mathematical formulation of the ideal parallel **PID Controller**, Controller Gain ($K_c$), Integral Reset Time ($\tau_I$ in $\text{min}$ or Integral Gain $K_I = K_c / \tau_I$ in $\text{min}^{-1}$), Derivative Rate Time ($\tau_D$), steady-state offset elimination, and anti-reset windup protection (Dale E. Seborg *Process Dynamics and Control* 4th ed. Chapter 8; George Stephanopoulos *Chemical Process Control* Chapter 10): formulate the **Ideal Parallel PID Controller Master Time-Domain Formulation**:
$$\mathbf{u(t) = \bar{u} + K_c \left[ e(t) + \frac{1}{\tau_I} \int_0^t e(t') dt' + \tau_D \frac{de(t)}{dt} \right]}$$
take the Laplace transform to derive the **Parallel PID Transfer Function ($G_c(s)$)**:
$$\mathbf{G_c(s) = \frac{U(s)}{E(s)} = K_c \left( 1 + \frac{1}{\tau_I s} + \tau_D s \right) = K_c + \frac{K_I}{s} + K_D s \quad \left(K_I = \frac{K_c}{\tau_I}, \ K_D = K_c \tau_D\right)}$$
master the **Three-Mode Functional Anatomy**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{Control Mode} & \textbf{Mathematical Form} & \textbf{Primary Physical Function} & \textbf{Operational Tradeoff} \\
\hline
\mathbf{\text{Proportional (P)}} & K_c \cdot e(t) & \mathbf{\text{Immediate action on current error}} & \mathbf{\text{Leaves permanent steady-state offset }} (e_{\text{ss}} \ne 0) \\
\mathbf{\text{Integral (I)}} & \frac{K_c}{\tau_I} \int e dt & \mathbf{\text{Forces steady-state offset strictly to zero}} & \mathbf{\text{Adds } -90^\circ \text{ phase lag; destabilizes loop / windup}} \\
\mathbf{\text{Derivative (D)}} & K_c \tau_D \frac{de}{dt} & \mathbf{\text{Anticipates future error trajectory; adds damping}} & \mathbf{\text{Amplifies high-frequency measurement noise}} \\
\hline
\end{array}$$
(proving that integral action is the mandatory mathematical engine required to achieve zero steady-state tracking error in closed-loop chemical engineering systems).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PID Time Domain & Laplace Transfer Function ($G_c(s) = K_c(1 + \frac{1}{\tau_I s} + \tau_D s)$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Controller Output u(t) Following a Step Error for P, PI, and PID Modes Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | PID Controller Mode / Parameter & Technical Feedback Control Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Automatic Feedback Control, the Only Controller Mode Capable of Completely Eliminating Steady-State Offset Error Is the ___ Mode (Integral / Reset) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Process Control Problem: Calculating Controller Output for a Ramp Error Profile under Proportional and Integral Control Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State PID Controller Formulations (Seborg 2016; Stephanopoulos 1984):
   - **Controller Transfer Functions:**
     $$\mathbf{G_c(s) = K_c\left(1 + \frac{1}{\tau_I s} + \tau_D s\right) \quad \Big| \quad u(t) = \bar{u} + K_c e(t) + \frac{K_c}{\tau_I}\int_0^t e dt' + K_c \tau_D \frac{de}{dt} \quad \Big| \quad K_I = \frac{K_c}{\tau_I}}$$
   - **Controller Modes Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Controller Architecture} & \textbf{Transfer Function } G_c(s) & \textbf{Steady-State Offset} & \textbf{Typical Process Application} \\
     \hline
     \mathbf{\text{P-Only Control}} & K_c & \mathbf{\text{Always Present } (e_{\text{offset}} > 0)} & \text{Liquid level surge tanks (offset is acceptable)} \\
     \mathbf{\text{PI Control}} & \mathbf{K_c \left(1 + \frac{1}{\tau_I s}\right)} & \mathbf{\text{Strictly Zero } (e_{\text{offset}} = 0)} & \mathbf{\text{Flow loops, pressure loops, liquid levels}} \\
     \mathbf{\text{PID Control}} & \mathbf{K_c \left(1 + \frac{1}{\tau_I s} + \tau_D s\right)} & \mathbf{\text{Strictly Zero}} & \mathbf{\text{Slow temperature loops, jacketed reactors}} \\
     \hline
     \end{array}$$
   - **The Offset Elimination Invariant:** The integral term $\frac{K_c}{\tau_I} \int e(t) dt$ only reaches a constant steady state when **$e(t) \equiv 0$**; as long as any residual error exists, the integral ramps the valve position continuously until the process perfectly matches setpoint!
2. **Slide 2 (`ordering`):** Provide 5 steps of PID controller output calculation: (1) measure process error $e(t) = y_{\text{sp}}(t) - y(t)$ and base steady-state output $\bar{u}$, (2) calculate proportional contribution: $\Delta u_P = K_c \cdot e(t)$, (3) integrate error over time to calculate integral contribution: $\Delta u_I = \frac{K_c}{\tau_I} \int_0^t e(t') dt'$, (4) differentiate error to compute derivative action: $\Delta u_D = K_c \tau_D \frac{de(t)}{dt}$, (5) sum all contributions to set final actuator position: $u(t) = \bar{u} + \Delta u_P + \Delta u_I + \Delta u_D$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Proportional Gain $K_c$, Integral Reset Time $\tau_I$, Derivative Rate Time $\tau_D$, Reset Windup) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Integral (or Reset). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating PI controller response: A PI temperature controller with $K_c = 2.0\%/^\circ\text{C}$ and reset time $\tau_I = 5.0\text{ min}$ has initial bias $\bar{u} = 50.0\%$. At $t = 0$, a persistent step error of $e(t) = +3.0^\circ\text{C}$ occurs.
   - Proportional action: $\Delta u_P = K_c \cdot e = 2.0\%/^\circ\text{C} \times 3.0^\circ\text{C} = \mathbf{+6.0\%}$;
   - Instantaneous output at $t = 0^+$: $u(0^+) = \bar{u} + \Delta u_P = 50.0 + 6.0 = \mathbf{56.0\%}$;
   - At $t = 10.0\text{ min}$, integral contribution:
     $\Delta u_I = \frac{K_c}{\tau_I} \int_0^{10} e dt' = \frac{2.0}{5.0} \times (3.0 \times 10.0) = 0.40 \times 30.0 = \mathbf{+12.0\%}$;
   - Total controller output at $t = 10.0\text{ min}$:
     $u(10) = \bar{u} + \Delta u_P + \Delta u_I = 50.0 + 6.0 + 12.0 = \mathbf{68.0\%}$;
   - What is the controller output at $t = 0^+$ and at $t = 10.0\text{ min}$? ($u(0^+) = \mathbf{56.0\%}$ and $u(10) = \mathbf{68.0\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pid_controller_modes_and_error_compensation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: PID Controller Modes \\& Transfer Functions (Dale E. Seborg)**\n• **Ideal Parallel PID Controller Master Time-Domain Formulation:**\n$$\n\\mathbf{u(t) = \\bar{u} + K_c \\left[ e(t) + \\frac{1}{\\tau_I} \\int_0^t e(t') dt' + \\tau_D \\frac{de(t)}{dt} \\right]}\n$$\n  - **$K_c$:** Controller proportional gain ($\\Delta u / \\Delta e$);\n  - **$\\tau_I$:** Integral reset time ($\\text{min}$);\n  - **$\\tau_D$:** Derivative rate time ($\\text{min}$);\n• **Laplace Domain PID Transfer Function Formulation ($G_c(s)$):**\n$$\n\\mathbf{G_c(s) = \\frac{U(s)}{E(s)} = K_c \\left( 1 + \\frac{1}{\\tau_I s} + \\tau_D s \\right) = K_c + \\frac{K_I}{s} + K_D s}\n$$\n• **Three-Mode Control Characteristics:**\n  - **Proportional (P):** Acts on *present* error; fast response but leaves steady-state offset ($e_{\\text{ss}} > 0$);\n  - **Integral (I):** Acts on *accumulated past* error; **eliminates steady-state offset entirely ($e_{\\text{ss}} \\equiv 0$)**;\n  - **Derivative (D):** Acts on *future* error rate ($de/dt$); adds anticipatory damping to reduce overshoot;\n• **The Integral Action Invariant:** The integral term continues to ramp controller output as long as error exists; **steady state is achieved if and only if $e(t) = 0$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the total output of a PID controller responding to a process error profile.",
      "orderItems": [
        "Measure the current process error e(t) = y_sp(t) - y(t) and record baseline controller output \u016b",
        "Calculate the proportional step change: \u0394u_P = Kc * e(t)",
        "Integrate the continuous error history over time to calculate integral action: \u0394u_I = (Kc / \u03c4I) * \u222b e(t') dt'",
        "Calculate the rate of change of error to compute derivative action: \u0394u_D = Kc * \u03c4D * (de / dt)",
        "Sum all three control actions to update the final control element output: u(t) = \u016b + \u0394u_P + \u0394u_I + \u0394u_D"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each PID Control Mode / Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Proportional Gain (Kc)", "right": "Kc*e(t), instantaneous controller action proportional to the magnitude of current error" },
        { "left": "Integral Time (\u03c4I)", "right": "(Kc/\u03c4I)\u222be dt, reset parameter that accumulates past error to eliminate steady-state offset" },
        { "left": "Derivative Time (\u03c4D)", "right": "Kc*\u03c4D*(de/dt), rate parameter predicting future trajectory to damp system oscillations" },
        { "left": "Reset Windup", "right": "Saturation phenomenon where integral term continues accumulating error while valve is fully open" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In automatic feedback control, the only controller mode capable of completely eliminating steady-state offset error is the ___ mode.",
      "blankAnswer": "integral",
      "blankDistractors": ["proportional", "derivative", "feedforward"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A PI controller has Kc = 2.0 %/\u00b0C, \u03c4I = 5.0 min, and initial bias \u016b = 50.0%. At t = 0, a constant step error of e(t) = +3.0\u00b0C occurs. What is the controller output u(0^+) immediately after the step and the output u(10) at t = 10.0 min (\u0394u_P = 2*3 = 6.0%; \u0394u_I = (2/5)*(3*10) = 12.0%)?",
      "options": [
        { "text": "u(0^+) = 56.0% and u(10) = 68.0% (u(0^+) = 50.0 + 6.0 = 56.0%; at t = 10 min: u(10) = 50.0 + 6.0 + 12.0 = 68.0%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the ideal PI controller time-domain equation (Dale E. Seborg *Process Dynamics and Control* Chapter 8; George Stephanopoulos *Chemical Process Control* Chapter 10). 1. **Identify Controller Parameters \\& Input Error:** - Proportional gain: $K_c = 2.0\\%\\text{/}^\circ\\text{C}$. - Integral reset time: $\\tau_I = 5.0\\text{ min}$. - Controller initial bias: $\\bar{u} = 50.0\\%$. - Persistent step error: $e(t) = +3.0^\circ\\text{C}$ for all $t \\ge 0$. 2. **Calculate Output Immediately After Error Step ($t = 0^+$):** - Proportional action: $$\\Delta u_P = K_c \\cdot e(0^+) = 2.0\\%\\text{/}^\circ\\text{C} \\times 3.0^\circ\\text{C} = \\mathbf{+6.0\\%}$$ - Integral action at $t = 0^+$: $$\\Delta u_I(0^+) = \\frac{K_c}{\\tau_I} \\int_0^{0^+} e(t') dt' = \\mathbf{0.0\\%}$$ - Instantaneous controller output: $$u(0^+) = \\bar{u} + \\Delta u_P + \\Delta u_I(0^+) = 50.0\\% + 6.0\\% = \\mathbf{56.0\\%}$$ 3. **Calculate Output at $t = 10.0\\text{ min}$:** - Proportional action remains constant: $$\\Delta u_P = \\mathbf{+6.0\\%}$$ - Integral action accumulated over 10 minutes: $$\\Delta u_I(10) = \\frac{K_c}{\\tau_I} \\int_0^{10} e(t') dt' = \\left( \\frac{2.0\\%\\text{/}^\circ\\text{C}}{5.0\\text{ min}} \\right) \\times (3.0^\circ\\text{C} \\times 10.0\\text{ min})$$ $$\\Delta u_I(10) = 0.40\\%\\text{/min} \\times 30.0\\text{ min} = \\mathbf{+12.0\\%}$$ - Total controller output: $$u(10) = \\bar{u} + \\Delta u_P + \\Delta u_I(10) = 50.0\\% + 6.0\\% + 12.0\\% = \\mathbf{68.0\\%}$$ Flawless PI controller time-domain response derivation!" },
        { "text": "u(0^+) = 50.0% and u(10) = 62.0% (Forgot proportional action)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "u(0^+) = 56.0% and u(10) = 56.0% (Forgot integral action ramp)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "u(0^+) = 53.0% and u(10) = 65.0%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
