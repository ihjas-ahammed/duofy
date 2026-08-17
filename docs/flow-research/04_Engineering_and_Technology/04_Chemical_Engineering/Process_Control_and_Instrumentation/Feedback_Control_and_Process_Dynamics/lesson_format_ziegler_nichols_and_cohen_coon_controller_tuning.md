# Duofy Reusable Lesson Format: Controller Tuning (Ziegler-Nichols & Cohen-Coon Rules)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Process_Control_and_Instrumentation / Feedback_Control_and_Process_Dynamics`  
**Lesson Format Type:** `ziegler_nichols_and_cohen_coon_controller_tuning`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the tuning algorithms for industrial feedback loops, J. G. Ziegler and N. B. Nichols' 1942 **Continuous Cycling / Ultimate Gain Closed-Loop Tuning Method**, finding Ultimate Gain ($K_u$) and Ultimate Period of sustained oscillation ($P_u$), the **Quarter Decay Ratio ($DR = 1/4 = 0.25$)** performance objective, Ziegler-Nichols open-loop process reaction curve tuning ($K_p, \tau_p, \theta_d$), Cohen-Coon tuning rules for large dead time systems ($\theta_d / \tau_p > 0.5$), and gain detuning for robust stability (Dale E. Seborg *Process Dynamics and Control* 4th ed. Chapter 12; J. G. Ziegler & N. B. Nichols 1942; G. H. Cohen & G. A. Coon 1953): formulate the **Ziegler-Nichols Closed-Loop Ultimate Gain Tuning Master Matrix**:
$$\begin{array}{|l|c|c|c|l|}
\hline
\textbf{Controller Type} & \textbf{Controller Gain } K_c & \textbf{Integral Time } \tau_I & \textbf{Derivative Time } \tau_D & \textbf{Tuned Closed-Loop Objective} \\
\hline
\mathbf{\text{P-Only Control}} & \mathbf{0.50 \cdot K_u} & \infty & 0 & \text{Moderate gain margin (Gain Margin } GM = 2.0) \\
\mathbf{\text{PI Control}} & \mathbf{0.45 \cdot K_u} & \mathbf{\frac{P_u}{1.2} = 0.833 P_u} & 0 & \text{Zero offset, slightly oscillatory} \\
\mathbf{\text{PID Control}} & \mathbf{0.60 \cdot K_u} & \mathbf{\frac{P_u}{2.0} = 0.500 P_u} & \mathbf{\frac{P_u}{8.0} = 0.125 P_u} & \mathbf{\text{Quarter Decay Ratio } (DR = 0.25), \text{ fast recovery}} \\
\hline
\end{array}$$
derive the **Ziegler-Nichols Open-Loop Reaction Curve Tuning Rules ($K_p, \tau_p, \theta_d$)**:
$$\mathbf{\text{PID: } K_c = \frac{1.20 \cdot \tau_p}{K_p \cdot \theta_d} \quad \Big| \quad \tau_I = 2.00 \cdot \theta_d \quad \Big| \quad \tau_D = 0.50 \cdot \theta_d}$$
derive the **Quarter Decay Ratio ($DR$) Definition**:
$$\mathbf{DR = \frac{a_2}{a_1} = \exp\left( -\frac{2 \pi \zeta}{\sqrt{1 - \zeta^2}} \right) = \left( \text{Overshoot} \right)^2 \approx \mathbf{0.25} \quad (\text{Damping factor } \zeta \approx 0.215)}$$
and interact with live FOPDT step-response generator, PID controller mode comparator, Closed-loop servo/regulatory pole-zero map, and Ziegler-Nichols continuous cycling simulation studio widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ziegler-Nichols Closed-Loop Tuning Table ($K_u, P_u$), Open-Loop Rules & Quarter Decay Ratio ($DR = 0.25$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Perform a Continuous Cycling Test and Calculate PID Tuning Parameters Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Controller Tuning Parameter / Performance Metric & Technical Control Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Ziegler-Nichols Closed-Loop Ultimate Gain Tuning for a Full PID Controller, the Recommended Proportional Gain $K_c$ Equals Exactly ___ Times the Ultimate Gain $K_u$ (0.60 / 0.6 / Sixty Percent) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Process Control & Dynamics Studio: FOPDT Response, PID Modes, Closed Loops & Z-N Tuning Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ziegler_nichols_and_cohen_coon_controller_tuning",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Ziegler-Nichols continuous cycling method, and what are the tuning formulas for a PID controller?",
      "blankAnswer": "Ziegler-Nichols Controller Tuning Mechanics (Ziegler & Nichols 1942): (1) CONTINUOUS CYCLING METHOD: Switch controller to P-only mode (\u03c4I \u2192 \u221e, \u03c4D = 0). Increase gain Kc until the closed loop oscillates with sustained, constant amplitude. (2) CRITICAL VALUES: Record Ultimate Gain Ku and Ultimate Period Pu (time between oscillation peaks). (3) Z-N PID TUNING FORMULAS: Kc = 0.60 * Ku, \u03c4I = Pu / 2.0 = 0.50 * Pu, \u03c4D = Pu / 8.0 = 0.125 * Pu. (4) DESIGN OBJECTIVE: Targets Quarter Decay Ratio (DR = 1/4 = 0.25), meaning each successive overshoot peak is 1/4th the height of the preceding peak!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform a closed-loop Ziegler-Nichols continuous cycling tuning test on an industrial feedback control loop.",
      "orderItems": [
        "Disable integral and derivative actions by setting integral reset time \u03c4I to infinity and derivative rate time \u03c4D to zero",
        "Place controller in automatic mode and gradually increase proportional gain Kc while introducing small setpoint changes",
        "Identify the Ultimate Gain Ku where the controlled variable oscillates with sustained, constant-amplitude sinusoids",
        "Measure the Ultimate Period Pu as the time elapsed between adjacent crests of the sustained oscillation",
        "Calculate PID tuning parameters from Z-N rules: Kc = 0.60*Ku, \u03c4I = Pu / 2.0, \u03c4D = Pu / 8.0 and load into DCS"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Controller Tuning Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Ultimate Gain (Ku)", "right": "Proportional controller gain at which the closed-loop feedback system sits exactly on the margin of stability" },
        { "left": "Ultimate Period (Pu)", "right": "Natural period of sustained oscillation observed when the feedback loop is energized at ultimate gain Ku" },
        { "left": "Quarter Decay Ratio (DR = 0.25)", "right": "Transient damping criterion where the amplitude of the second overshoot peak is exactly 25% of the first peak" },
        { "left": "Cohen-Coon Tuning", "right": "Open-loop reaction curve tuning rules designed specifically for processes with large dead time ratios (\u03b8d/\u03c4p > 0.5)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Ziegler-Nichols closed-loop ultimate gain tuning for a full PID controller, the recommended proportional gain Kc equals exactly ___ times the ultimate gain Ku.",
      "blankAnswer": "0.60",
      "blankDistractors": ["0.50", "0.45", "1.00"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Process Control & Dynamic Feedback Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Process Control & Feedback Dynamics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">FOPDT Dynamics, PID Modes, Closed Loops & Z-N Tuning</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnFopdt\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. FOPDT (Kp=4.0, \u03c4=6min, \u03b8=2min)</button><button id=\"btnPid\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. PI Action (u(0+)=56%, u(10)=68%)</button><button id=\"btnZn\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Closed Loop & Z-N (DR = 0.25)</button></div><div id=\"ctlLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate FOPDT step response...</div><script>document.getElementById('btnFopdt').onclick=()=>{document.getElementById('ctlLog').innerHTML='<b>1. FOPDT PROCESS DYNAMICS:</b><br>• Gp(s) = Kp*exp(-\\u03b8d*s) / (\\u03c4p*s + 1)<br>• Gain: Kp = \\u0394y/\\u0394u = 20\u00b0C / 5% = <b style=\"color:#10b981;\">4.0 \u00b0C/%!</b><br>• <b style=\"color:#38bdf8;\">Dead Time: \\u03b8d = 2.0 min, Time Constant: \\u03c4p = 6.0 min!</b>';}; document.getElementById('btnPid').onclick=()=>{document.getElementById('ctlLog').innerHTML='<b>2. IDEAL PARALLEL PID CONTROLLER:</b><br>• Gc(s) = Kc * (1 + 1/(\\u03c4I*s) + \\u03c4D*s)<br>• Proportional: \\u0394u_P = 2*3 = +6% &rarr; u(0\u207a) = <b style=\"color:#10b981;\">56.0%!</b><br>• <b style=\"color:#38bdf8;\">Integral: \\u0394u_I(10min) = +12% &rarr; u(10) = 68.0%! (Zero Offset)</b>';}; document.getElementById('btnZn').onclick=()=>{document.getElementById('ctlLog').innerHTML='<b>3. CLOSED LOOP \\& ZIEGLER-NICHOLS TUNING:</b><br>• Servo: Y/Ysp = (Gc*Gv*Gp) / (1 + G_OL) = <b style=\"color:#10b981;\">8.0 / (5.0s + 9.0)!</b><br>• Z-N PID Rules: Kc = 0.60*Ku, \\u03c4I = Pu/2.0, \\u03c4D = Pu/8.0<br>• <b style=\"color:#38bdf8;\">Targets Quarter Decay Ratio (DR = 0.25)!</b><br>🏆 <b style=\"color:#10b981;\">04_Chemical_Engineering (ALL 5 SUBDISCIPLINES / ALL 5 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
