# Duofy Reusable Lesson Format: Tracking Accuracy (Steady-State Errors & System Types)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / Transfer_Functions_and_Block_Diagrams`  
**Lesson Format Type:** `steady_state_error_constants_and_system_type_classification`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify steady-state tracking error analysis, the Final Value Theorem error formulation, open-loop system Type classification (number of pure origin integrators $1/s^N$), and the three static error constants: Positional Error Constant ($K_p$), Velocity Error Constant ($K_v$), and Acceleration Error Constant ($K_a$) in unity feedback control systems (Katsuhiko Ogata *Modern Control Engineering* Chapter 5; Norman S. Nise *Control Systems Engineering* Chapter 7): formulate the **General Steady-State Error ($e_{ss}$)**:
$$\mathbf{e_{ss} = \lim_{t\to\infty} e(t) = \lim_{s\to 0} s E(s) = \lim_{s\to 0} \frac{s R(s)}{1 + G(s)} \quad (\text{Unity Feedback } H(s) = 1)}$$
derive the **Static Error Constants**:
$$\mathbf{K_p = \lim_{s\to 0} G(s) \quad \Big| \quad K_v = \lim_{s\to 0} s G(s) \quad \Big| \quad K_a = \lim_{s\to 0} s^2 G(s)}$$
master the **System Type vs Input Signal Steady-State Error Matrix**:
$$\begin{array}{|c|c|c|c|}
\hline
\textbf{System Classification} & \textbf{Unit Step Input } R(s) = 1/s & \textbf{Unit Ramp Input } R(s) = 1/s^2 & \textbf{Unit Parabolic } R(s) = 1/s^3 \\
\hline
\mathbf{\text{Type 0 } (N = 0)} & \mathbf{e_{ss} = \frac{1}{1 + K_p}} & \infty & \infty \\
\mathbf{\text{Type 1 } (N = 1)} & \mathbf{0 \ (\text{Zero Tracking Error})} & \mathbf{e_{ss} = \frac{1}{K_v}} & \infty \\
\mathbf{\text{Type 2 } (N = 2)} & \mathbf{0} & \mathbf{0} & \mathbf{e_{ss} = \frac{1}{K_a}} \\
\hline
\end{array}$$
and interact with live Mason's Gain Formula solver, 2nd-order transient step animator, Routh-Hurwitz stability boundary tester, and System Type steady-state error calculator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Error Constants ($K_p, K_v, K_a$), System Type & Steady-State Error ($e_{ss} = \frac{1}{K_v}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | System Type / Input Combination & Resulting Steady-State Error ($e_{ss}$) Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Type 0 Systems Exhibit a Finite Non-Zero Steady-State Error to a Step Input While Type 1 Systems Have Zero Error Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Static Error Constant Evaluated as the Limit of s*G(s) as s Approaches Zero Is the ___ Error Constant (Velocity / Kv) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Control Systems Studio: Mason's Rule, 2nd-Order Transient, Routh Array & Tracking Errors Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "steady_state_error_constants_and_system_type_classification",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are System Types, Static Error Constants (Kp, Kv, Ka), and how do they determine steady-state tracking error?",
      "blankAnswer": "Steady-State Error & System Types (Ogata; Nise): (1) GENERAL ERROR FORMULA: ess = lim(s \u2192 0) [s * R(s) / (1 + G(s))]. (2) STATIC ERROR CONSTANTS: Positional Kp = lim G(s); Velocity Kv = lim s*G(s); Acceleration Ka = lim s^2*G(s). (3) SYSTEM TYPE: Number of pure integrators (poles at s = 0) in open-loop G(s). (4) TRACKING RULES: Type 0 has finite error ess = 1/(1+Kp) for steps, \u221e for ramps. Type 1 has ZERO error for steps, finite ess = 1/Kv for ramps, \u221e for parabolas. Type 2 has ZERO error for steps and ramps, finite ess = 1/Ka for parabolas!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each System Type and Input Combination to its exact Steady-State Error.",
      "matchPairs": [
        { "left": "Type 0 with Unit Step Input", "right": "ess = 1 / (1 + Kp), finite constant error proportional to open-loop DC gain Kp" },
        { "left": "Type 1 with Unit Ramp Input", "right": "ess = 1 / Kv, finite constant lag error where output velocity tracks input velocity" },
        { "left": "Type 1 with Unit Step Input", "right": "ess = 0, exact zero steady-state tracking error achieved by the internal integrator pole" },
        { "left": "Type 2 with Unit Parabolic Input", "right": "ess = 1 / Ka, finite constant acceleration error enabled by two pure integrator poles" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In a feedback servomechanism, why does a Type 0 system exhibit a permanent non-zero steady-state tracking error to a constant step command (ess = 1/(1+Kp)), whereas a Type 1 system achieves perfect zero steady-state error (ess = 0)?",
      "options": [
        { "text": "A Type 1 system has an open-loop integrator pole at s = 0 (G(s) ~ K/s); as s \u2192 0, the open-loop DC gain becomes infinite (Kp = \u221e), which drives the steady-state error ess = 1/(1 + Kp) = 1/(1 + \u221e) = 0; physically, the internal integrator continually accumulates any non-zero error over time and builds up a finite control signal until the tracking error is driven precisely to zero", "isCorrect": true, "explanation": "Correct! This is Norman Nise and Katsuhiko Ogata's fundamental physical explanation for the Internal Model Principle (*Control Systems Engineering* Chapter 7; *Modern Control Engineering* Chapter 5). 1. **Mathematical Derivation:** - Positional error: $$e_{ss} = \\frac{1}{1 + K_p} \\quad \\text{where } K_p = \\lim_{s\\to 0} G(s)$$ - For a **Type 0 system** ($G(s) = \\frac{K}{(s+p_1)(s+p_2)}$): $$K_p = \\frac{K}{p_1 p_2} < \\infty \\implies e_{ss} = \\frac{1}{1 + K_p} > 0 \\quad (\\text{Permanent offset!})$$ - For a **Type 1 system** ($G(s) = \\frac{K}{s(s+p_1)}$): $$K_p = \\lim_{s\\to 0} \\frac{K}{s(s+p_1)} = \\infty \\implies e_{ss} = \\frac{1}{1 + \\infty} = \\mathbf{0.0}$$ 2. **Physical Control Intuition:** - An integrator performs time integration: $u(t) = K_I \\int e(t) dt$. - Even if the error $e(t)$ is minuscule ($0.001\\text{ V}$), the integrator will keep accumulating area, increasing control output $u(t)$ until the motor reaches the exact setpoint, at which point $e(t) = 0$ and the integrator output holds steady!" },
        { "text": "Because Type 0 systems cannot be connected to power supplies", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Type 1 systems eliminate all friction in mechanical gears", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because step inputs only work on odd-numbered systems", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The static error constant evaluated as the limit of s*G(s) as s approaches zero is the ___ error constant.",
      "blankAnswer": "velocity",
      "blankDistractors": ["position", "acceleration", "damping"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Control Systems Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Control Systems Modeling Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Mason's Rule, 2nd-Order Transient, Routh Array & Tracking Errors</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnMas\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Mason's Gain Rule (T(s))</button><button id=\"btnTra\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. 2nd-Order Transient (%Mp=9.5%)</button><button id=\"btnRou\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Routh Array & Error Constants</button></div><div id=\"ctrlLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Mason's rule...</div><script>document.getElementById('btnMas').onclick=()=>{document.getElementById('ctrlLog').innerHTML='<b>1. MASON\\\'S GAIN FORMULA:</b><br>• T(s) = \\u2211 Pk*\\u0394k / \\u0394<br>• \\u0394 = 1 - \\u2211L1 + \\u2211L2 - ...<br>• <b style=\"color:#10b981;\">Non-touching: \\u2211L2 = L1*L2!</b>';}; document.getElementById('btnTra').onclick=()=>{document.getElementById('ctrlLog').innerHTML='<b>2. 2ND-ORDER TRANSIENT SPECS:</b><br>• T(s) = 100 / (s^2 + 12s + 100) &rarr; \\u03c9n = 10 rad/s, \\u03b6 = 0.60<br>• <b style=\"color:#38bdf8;\">%Mp = 9.48%, \\u03c9d = 8.0 rad/s, ts(2%) = 0.67 s!</b>';}; document.getElementById('btnRou').onclick=()=>{document.getElementById('ctrlLog').innerHTML='<b>3. ROUTH STABILITY \\& TRACKING ERRORS:</b><br>• Routh Array: 0 < K < 48 (Marginal \\u03c9_osc = 2.83 rad/s @ K=48)<br>• Steady-State: Type 1 &rarr; ess = 0 (Step), ess = 1/Kv (Ramp)<br>🏆 <b style=\"color:#10b981;\">Transfer_Functions_and_Block_Diagrams 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
