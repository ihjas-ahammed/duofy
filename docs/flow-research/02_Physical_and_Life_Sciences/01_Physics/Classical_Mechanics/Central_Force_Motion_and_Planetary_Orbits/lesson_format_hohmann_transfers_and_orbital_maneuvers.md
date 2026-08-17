# Duofy Reusable Lesson Format: Hohmann Transfers and Orbital Maneuvers

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Central_Force_Motion_and_Planetary_Orbits`  
**Lesson Format Type:** `hohmann_transfers_and_orbital_maneuvers`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of orbital mechanics & astrodynamics: formulate the **Vis-Viva Orbital Energy Equation ($v^2 = GM\left(\frac{2}{r} - \frac{1}{a}\right)$)**, evaluate the two-impulse **Hohmann Transfer Orbit (Walter Hohmann, 1925)** between coplanar circular orbits $r_1 \to r_2$, calculate $\Delta v_1$ and $\Delta v_2$ velocity burns, analyze **Bi-elliptic transfers**, and interact with live Hohmann orbital transfer simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hohmann Transfer & Vis-Viva Equation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Orbital Maneuver Type & Trajectory Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Vis-Viva Velocity Comparison at Periapsis vs Apoapsis Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Minimum Energy Orbital Transfer Author Surname | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Two-Burn Hohmann Orbital Transfer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hohmann_transfers_and_orbital_maneuvers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Vis-Viva Equation, and how does a two-impulse Hohmann Transfer Orbit work between circular orbits r_1 and r_2?",
      "blankAnswer": "The Vis-Viva Equation computes orbital speed at any radius r: v^2 = mu * (2/r - 1/a), where mu = GM and a is the semimajor axis. A Hohmann Transfer (Walter Hohmann, 1925) is the most fuel-efficient two-impulse coplanar orbital transfer between circular orbits r_1 and r_2 via an intermediate elliptical transfer orbit with semimajor axis a_{tx} = (r_1 + r_2)/2. Burn 1 at periapsis r_1 accelerates Delta v_1 = sqrt(mu/r_1) * [sqrt(2*r_2 / (r_1 + r_2)) - 1]; Burn 2 at apoapsis r_2 recircularizes Delta v_2 = sqrt(mu/r_2) * [1 - sqrt(2*r_1 / (r_1 + r_2))]."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each orbital maneuver to its astrodynamical mechanism.",
      "matchPairs": [
        { "left": "Hohmann Transfer Orbit", "right": "Two-burn tangential impulse transfer utilizing an ellipse with a_{tx} = (r_1 + r_2)/2" },
        { "left": "Bi-Elliptic Transfer", "right": "Three-burn maneuver that is more fuel-efficient than Hohmann when ratio r_2 / r_1 > 11.94" },
        { "left": "Gravity Assist / Slingshot", "right": "Hyperbolic flyby exchanging momentum with a planet to alter heliocentric energy with zero fuel" },
        { "left": "Plane Change Maneuver", "right": "Thrust applied perpendicular to orbital plane to alter inclination i: Delta v = 2 v sin(Delta i / 2)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Using the Vis-Viva equation v² = GM(2/r - 1/a), where does a satellite in an elliptical orbit travel at its MAXIMUM speed?",
      "options": [
        { "text": "At PERIAPSIS (closest approach, minimum radius r = r_min), where potential energy is lowest and kinetic energy is highest", "isCorrect": true, "explanation": "Correct! As r decreases, 2/r reaches its maximum value, making orbital velocity v maximum at periapsis and minimum at apoapsis." },
        { "text": "At apoapsis (farthest point)", "isCorrect": false, "explanation": "Incorrect: Velocity is lowest at apoapsis." },
        { "text": "Speed is constant at all points", "isCorrect": false, "explanation": "Incorrect: Speed varies along an ellipse." },
        { "text": "At the semiminor axis endpoints", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the German engineer who developed the two-burn minimum energy transfer orbit in 1925 (Hohmann)?",
      "blankAnswer": "hohmann"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hohmann Transfer Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Hohmann Orbit Transfer: LEO to GEO</h3><p>LEO: r₁ = 6,700 km | GEO: r₂ = 42,164 km</p><button id=\"hohBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Execute 2-Impulse Hohmann Transfer</button><div id=\"hohOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('hohBtn').onclick=()=>{document.getElementById('hohOut').innerText='Burn 1 (LEO Perigee): Δv₁ = 2.42 km/s into transfer ellipse (a = 24,432 km). Coast time = 5.26 hours. Burn 2 (GEO Apogee): Δv₂ = 1.46 km/s circularizing at r₂. Total Δv = 3.88 km/s! Transfer Successful.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
