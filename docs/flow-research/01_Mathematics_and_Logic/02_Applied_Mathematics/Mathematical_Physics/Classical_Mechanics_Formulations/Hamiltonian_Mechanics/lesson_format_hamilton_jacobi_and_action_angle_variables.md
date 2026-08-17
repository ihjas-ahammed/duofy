# Duofy Reusable Lesson Format: Hamilton-Jacobi Theory and Action-Angle Variables

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Classical_Mechanics_Formulations / Hamiltonian_Mechanics`  
**Lesson Format Type:** `hamilton_jacobi_and_action_angle_variables`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Hamilton-Jacobi Equation** ($H(q, \nabla S, t) + \partial_t S = 0$), the **Liouville-Arnol'd Integrability Theorem** (completely integrable systems on invariant tori $\mathbb{T}^n$), action variables $I_k = \frac{1}{2\pi}\oint p_k dq_k$, angle variables $\theta_k = \omega_k t + \delta_k$, and interact with live invariant torus phase portraits.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hamilton-Jacobi Equation & Action-Angle Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Integrable System Concept & Action-Angle Dual Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Liouville-Arnol'd Invariant Tori Invariant Count Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Action Variable Integral Pre-Factor Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive 2D Invariant Torus Orbit Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hamilton_jacobi_and_action_angle_variables",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Hamilton-Jacobi partial differential equation for Hamilton's principal function S(q, P, t)?",
      "blankAnswer": "H(q_1, ..., q_n, partial S/partial q_1, ..., partial S/partial q_n, t) + partial S / partial t = 0. It transforms the dynamics into trivial equilibrium coordinates where all new momenta P_k are constants of motion."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Hamilton-Jacobi and integrability concept to its mathematical definition.",
      "matchPairs": [
        { "left": "Action Variable I_k", "right": "(1 / 2pi) oint p_k dq_k (invariant adiabatic action around closed orbit)" },
        { "left": "Angle Variable theta_k", "right": "omega_k t + delta_k where omega_k = partial H / partial I_k (linear phase flow on torus)" },
        { "left": "Liouville-Arnol'd Invariant Torus T^n", "right": "Compact connected level set {I_1 = c_1, ..., I_n = c_n} in phase space" },
        { "left": "Hamilton's Characteristic Function W(q)", "right": "S(q, t) = W(q) - E t (time-independent separation for conservative systems)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "By the Liouville-Arnol'd theorem, how many independent Poisson-commuting constants of motion {F_j, F_k} = 0 are required for a classical Hamiltonian system with n degrees of freedom to be COMPLETELY INTEGRABLE?",
      "options": [
        { "text": "Exactly n independent constants of motion in involution ({F_j, F_k} = 0 for all 1 <= j, k <= n)", "isCorrect": true, "explanation": "Correct! An n-DOF system is completely integrable if and only if it possesses n functionally independent first integrals in involution, guaranteeing regular quasiperiodic motion on n-tori." },
        { "text": "1 constant (energy only)", "isCorrect": false, "explanation": "Incorrect: 1 constant is sufficient only for 1-DOF systems." },
        { "text": "2n constants", "isCorrect": false, "explanation": "Incorrect: 2n constants would fix the entire trajectory to a single point." },
        { "text": "Infinitely many", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the geometric manifold topology of the compact, connected phase space level sets of a completely integrable Hamiltonian system (Arnold's theorem)?",
      "blankAnswer": "torus"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Action-Angle Torus Orbit Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Liouville-Arnol'd Invariant Torus (T²)</h3><p>Frequencies: ω₁ = 1.000 rad/s | ω₂ = 1.414 (Irrational Ratio √2)</p><button id=\"torusBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Evolve Trajectory on Torus</button><div id=\"torusOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('torusBtn').onclick=()=>{document.getElementById('torusOut').innerText='Quasiperiodic motion! Because ω₁/ω₂ is irrational, the trajectory never closes and densely covers the entire 2D invariant torus T².'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
