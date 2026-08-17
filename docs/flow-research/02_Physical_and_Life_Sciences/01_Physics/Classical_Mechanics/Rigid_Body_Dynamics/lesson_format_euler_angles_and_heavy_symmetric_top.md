# Duofy Reusable Lesson Format: Euler Angles and the Heavy Symmetric Top

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Rigid_Body_Dynamics`  
**Lesson Format Type:** `euler_angles_and_heavy_symmetric_top`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of 3D gyroscope mechanics: formulate **Euler Angles ($\phi, \theta, \psi$ in $z\text{-}x'\text{-}z''$ convention)**, construct the Lagrangian of the **Heavy Symmetric Top ($I_1 = I_2 \ne I_3$)** in a gravitational field, identify conserved conjugate momenta ($p_\phi, p_\psi$), derive the 1D effective potential $V_{\text{eff}}(u)$ for **Nutation (nodding)** and **Precession (sweeping)**, and interact with live spinning top precession simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler Angles & Heavy Symmetric Top Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Euler Angle & Physical Rotational Motion Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Fast Top Steady Precession Angular Frequency Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Periodic Nodding Tilt Oscillation Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Heavy Gyroscope Precession & Nutation Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "euler_angles_and_heavy_symmetric_top",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the 3 Euler Angles (phi, theta, psi), and what is the Lagrangian and motion of a Heavy Symmetric Top?",
      "blankAnswer": "Euler Angles parameterize 3D rigid body orientation via 3 successive rotations: (1) Precession phi around space Z-axis, (2) Nutation theta around line of nodes x', (3) Intrinsic Spin psi around body symmetry axis z''. For a Heavy Symmetric Top with pivot at distance R under gravity, the Lagrangian is: L = (1/2)*I_1*(theta_dot^2 + phi_dot^2 * sin^2(theta)) + (1/2)*I_3*(psi_dot + phi_dot*cos(theta))^2 - M*g*R*cos(theta). Because phi and psi are CYCLIC, their conjugate momenta p_phi (vertical angular momentum L_Z) and p_psi (spin momentum L_z) are strictly conserved. The tilt angle theta oscillates (NUTATES) between turning points theta_min and theta_max while precessing around the vertical axis!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Euler angle to its physical rotational motion.",
      "matchPairs": [
        { "left": "Precession Angle phi", "right": "Rotation of the top's axis around the vertical space-fixed Z-axis" },
        { "left": "Nutation Angle theta", "right": "Tilt angle of the symmetry axis relative to the vertical Z-axis (nodding up and down)" },
        { "left": "Intrinsic Spin Angle psi", "right": "High-speed rotation of the top around its own body symmetry axis z''" },
        { "left": "Sleeping Top State", "right": "Stable vertical rotation at theta = 0 with zero nutation and zero precession" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For a fast-spinning heavy symmetric top (I_3 * omega_3 >> sqrt(4 * I_1 * M * g * R)), what is the steady precession angular frequency Omega_p around the vertical axis?",
      "options": [
        { "text": "Omega_p ≈ M * g * R / (I_3 * omega_3); the top precesses slowly at a rate inversely proportional to its spin speed omega_3", "isCorrect": true, "explanation": "Correct! Balancing the gravitational torque N = M g R sin(theta) against the required rate of change of angular momentum dL/dt = Omega_p x L_spin = Omega_p (I_3 omega_3) sin(theta) yields Omega_p = M g R / (I_3 omega_3). Spinning faster makes the top precess slower." },
        { "text": "Omega_p = I_3 * omega_3 / (M * g * R)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Omega_p = 0", "isCorrect": false, "explanation": "Incorrect: Gravity forces precession." },
        { "text": "Omega_p = sqrt(g / R)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the term for the periodic up-and-down bobbing / nodding of a spinning top's tilt angle theta between limits (nutation)?",
      "blankAnswer": "nutation"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Gyroscopic Precession & Nutation Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Heavy Gyroscope Precession Engine</h3><p>Spin: ω₃ = 300 rad/s | Torque: τ = 0.50 N·m</p><button id=\"gyroBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Precession Rate Ω_p & Nutation Bounds</button><div id=\"gyroOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('gyroBtn').onclick=()=>{document.getElementById('gyroOut').innerText='Precession Velocity: Ω_p = τ / (I₃ · ω₃) = 0.50 / (0.01 × 300) = 0.167 rad/s (9.55°/sec). Nutation oscillation bounds: θ_min = 28.5° to θ_max = 32.1°. Gyroscopic stability condition satisfied (I₃²ω₃² > 4I₁MgR)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
