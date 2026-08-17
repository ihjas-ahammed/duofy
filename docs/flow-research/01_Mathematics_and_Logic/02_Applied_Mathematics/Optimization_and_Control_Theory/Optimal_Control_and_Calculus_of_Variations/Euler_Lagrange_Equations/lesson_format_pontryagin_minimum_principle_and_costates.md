# Duofy Reusable Lesson Format: Pontryagin's Minimum Principle and Costate Dynamics

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Optimal_Control_and_Calculus_of_Variations / Euler_Lagrange_Equations`  
**Lesson Format Type:** `pontryagin_minimum_principle_and_costates`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Pontryagin's Minimum (Maximum) Principle (1956)** in optimal control theory, formulate the control **Hamiltonian** $H(x, u, \lambda) = L(x, u) + \lambda^T f(x, u)$, establish the canonical **Costate Dynamics** $\dot{\lambda} = -\nabla_x H$, derive **Bang-Bang Control Laws** for bounded actuators ($u \in [-1, 1]$), and interact with live double-integrator time-optimal switching curve simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Pontryagin Minimum Principle & Control Hamiltonian Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Optimal Control Problem & Transversality Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Bang-Bang Actuator Saturation Control Law Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Costate Adjoint Derivative Minus Sign Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Time-Optimal Double Integrator Bang-Bang Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pontryagin_minimum_principle_and_costates",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Pontryagin's Minimum Principle (PMP, 1956) for optimal control problems with bounded input constraints u(t) in U?",
      "blankAnswer": "To minimize cost J = Phi(x(t_f)) + int_0^{t_f} L(x, u) dt subject to state dynamics x_dot = f(x, u) and bounded control u(t) in U, define the control Hamiltonian H(x, u, lambda) = L(x, u) + lambda^T f(x, u). An optimal control u*(t) must POINTWISE MINIMIZE the Hamiltonian over the entire admissible set U at almost every instant of time: u*(t) = argmin_{u in U} H(x*(t), u, lambda*(t)), while the costate lambda(t) satisfies the adjoint ODE lambda_dot = -partial H / partial x with transversality lambda(t_f) = partial Phi / partial x."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each optimal control equation to its physical and mathematical role.",
      "matchPairs": [
        { "left": "State Equation", "right": "x_dot = partial H / partial lambda = f(x, u) (governs physical system trajectory)" },
        { "left": "Costate (Adjoint) Equation", "right": "lambda_dot = -partial H / partial x (propagates sensitivity shadow prices backward in time)" },
        { "left": "Hamiltonian Minimization", "right": "u*(t) = argmin_{u in U} H(x*(t), u, lambda*(t)) (determines instantaneous optimal control)" },
        { "left": "Terminal Transversality Condition", "right": "lambda(t_f) = partial Phi / partial x(t_f) (sets boundary condition for adjoint ODE)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In time-optimal control of a double integrator (x_ddot = u) with bounded thrust u in [-1, +1], the Hamiltonian is H = 1 + lambda_1 x_2 + lambda_2 u. What is the resulting optimal control law u*(t)?",
      "options": [
        { "text": "Bang-Bang control: u*(t) = -sign(lambda_2(t)), switching instantaneously between maximum positive (+1) and maximum negative (-1) control limits", "isCorrect": true, "explanation": "Correct! Because H is linear in u (H = ... + lambda_2 u), minimizing H over u in [-1, 1] forces u* to sit at the extremes: u* = -1 when lambda_2 > 0, and u* = +1 when lambda_2 < 0." },
        { "text": "Linear proportional control u*(t) = -k x", "isCorrect": false, "explanation": "Incorrect: Bang-bang control is discontinuous." },
        { "text": "Zero control u*(t) = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Sinusoidal oscillation u*(t) = sin(t)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "In Pontryagin's costate differential equation lambda_dot = -partial H / partial x, what mathematical sign precedes the gradient?",
      "blankAnswer": "negative"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Time-Optimal Bang-Bang Control Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Pontryagin Bang-Bang Time-Optimal Control</h3><p>System: ẍ = u, |u| ≤ 1.0 | Initial state: x(0) = 4, ẋ(0) = 0</p><button id=\"bangBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Execute Optimal Trajectory</button><div id=\"bangOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('bangBtn').onclick=()=>{document.getElementById('bangOut').innerText='Optimal Bang-Bang Trajectory: Accelerate with u = -1.0 for t ∈ [0, 2.0s], switch exactly at switching curve, decelerate with u = +1.0 for t ∈ [2.0s, 4.0s]. Origin reached in minimum time T* = 4.0s!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
