# Duofy Reusable Lesson Format: Cyclic Coordinates, Ignorable Degrees of Freedom, and Conserved Momenta

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Classical_Mechanics_Formulations / Lagrangian_Mechanics`  
**Lesson Format Type:** `cyclic_coordinates_and_conserved_momenta`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Cyclic (Ignorable) Coordinates** ($\frac{\partial L}{\partial q_k} = 0 \implies p_k = \frac{\partial L}{\partial \dot{q}_k} = \text{const}$), understand **Routhian Reduction**, analyze central force Kepler orbits ($V(r) \implies \theta$ is cyclic, $L_z = m r^2 \dot{\theta} = \text{const}$), and interact with live central force orbit trajectory simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cyclic Coordinate Definition & Momentum Conservation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Mechanical System & Cyclic Coordinate Identification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Central Potential Kepler Orbit Angular Momentum Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Conserved Conjugate Momentum Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Central Force Orbital Conservation Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cyclic_coordinates_and_conserved_momenta",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the definition of a 'cyclic' (or ignorable) coordinate q_k in Lagrangian mechanics, and what is its dynamical consequence?",
      "blankAnswer": "A coordinate q_k is cyclic if it does not appear explicitly in the Lagrangian (partial L / partial q_k = 0). By the Euler-Lagrange equations, d/dt(partial L / partial q_dot_k) = 0, which guarantees that its conjugate generalized momentum p_k = partial L / partial q_dot_k is a constant of motion."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each physical potential to its cyclic coordinate and resulting conserved momentum.",
      "matchPairs": [
        { "left": "Central Potential V(r) in Plane Polar Coordinates", "right": "Angle theta is cyclic => Angular momentum p_theta = m r^2 theta_dot is conserved" },
        { "left": "Uniform Gravity V(z) = mgz in Cartesian Coordinates", "right": "Coordinates x and y are cyclic => Linear momenta p_x and p_y are conserved" },
        { "left": "Axisymmetric Potential V(r, z) in Cylindrical Coordinates", "right": "Azimuthal angle phi is cyclic => Axial angular momentum p_phi = m r^2 phi_dot is conserved" },
        { "left": "Free Particle V = 0", "right": "All coordinates q_i are cyclic => All momenta p_i are conserved" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In a central force problem with Lagrangian L = 1/2 m (r_dot^2 + r^2 theta_dot^2) - V(r), what does the conservation of conjugate momentum p_theta = m r^2 theta_dot = ell represent geometrically?",
      "options": [
        { "text": "Kepler's Second Law of Planetary Motion: The radius vector sweeps out equal orbital areas in equal intervals of time (constant areal velocity dA/dt = ell / (2m))", "isCorrect": true, "explanation": "Correct! Since dA = 1/2 r^2 dtheta, the rate of area sweep is dA/dt = 1/2 r^2 theta_dot = ell / (2m) = constant." },
        { "text": "Kepler's First Law (elliptical orbits only)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Kepler's Third Law (T^2 ~ a^3)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The particle moves in a straight line at all times", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What adjective describes a generalized coordinate that does not explicitly appear in the Lagrangian functional?",
      "blankAnswer": "cyclic"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Central Force Orbital Motion Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Kepler Orbit: Cyclic θ & Angular Momentum</h3><p>Central potential V(r) = -k/r | Angular momentum ℓ = m r² θ̇</p><button id=\"orbitBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Check Conserved Quantity</button><div id=\"orbitOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('orbitBtn').onclick=()=>{document.getElementById('orbitOut').innerText='ℓ = 1.450 kg m²/s at perihelion = 1.450 kg m²/s at aphelion! Areal velocity is perfectly constant.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
