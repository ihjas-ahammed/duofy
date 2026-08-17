# Duofy Reusable Lesson Format: Escape Trajectories (Escape Velocity & Hyperbolic Flybys)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Avionics_and_Spacecraft_Dynamics / Orbital_Mechanics_and_Keplerian_Orbits`  
**Lesson Format Type:** `escape_velocity_and_hyperbolic_trajectories`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the mechanics of unbound orbital escape trajectories, the transition from closed elliptical orbits ($\mathcal{E} < 0, 0 \le e < 1$) to parabolic escape ($\mathcal{E} = 0, e = 1.0$) and hyperbolic interplanetary trajectories ($\mathcal{E} > 0, e > 1.0$), analytical derivation of **Escape Velocity ($v_{\text{esc}} = \sqrt{\frac{2\mu}{r}} = \sqrt{2} v_{\text{circ}}$)**, hyperbolic excess speed ($v_\infty = \sqrt{2\mathcal{E}} = \sqrt{v_{\text{burn}}^2 - v_{\text{esc}}^2}$), turning angle ($\delta = 2 \arcsin(1/e)$), and gravity assist flybys (Howard D. Curtis *Orbital Mechanics for Engineering Students* 4th ed. Chapter 2 & 8; David A. Vallado *Fundamentals of Astrodynamics* Chapter 3): formulate the **Escape Velocity Master Formulation**:
$$\mathbf{v_{\text{esc}} = \sqrt{\frac{2\mu}{r}} = \sqrt{2} \cdot v_{\text{circ}} \approx 1.4142 \cdot \sqrt{\frac{\mu}{r}} \quad \left[\frac{\text{km}}{\text{s}}\right]}$$
where:
1. **$v_{\text{esc}}$:** Minimum speed required at radius $r$ to break free from gravitational attraction ($\mathcal{E} = 0$);
2. **$\mu = GM$:** Primary body gravitational parameter ($398,600\text{ km}^3\text{/s}^2$ for Earth $\implies v_{\text{esc,surface}} = \mathbf{11.186\text{ km/s}}$);
3. **$r$:** Radial distance from planetary center;
derive the **Hyperbolic Excess Velocity ($v_\infty$) Formulation**:
$$\mathbf{v_\infty = \sqrt{2\mathcal{E}} = \sqrt{-\frac{\mu}{a_{\text{hyp}}}} = \sqrt{v_p^2 - v_{\text{esc}}^2} \Longleftrightarrow \mathbf{v_p = \sqrt{v_{\text{esc}}^2 + v_\infty^2}}}$$
derive the **Hyperbolic Flyby Turning Angle ($\delta$)**:
$$\mathbf{\sin\left( \frac{\delta}{2} \right) = \frac{1}{e} = \frac{1}{1 + \frac{r_p \cdot v_\infty^2}{\mu}} \Longleftrightarrow \mathbf{\delta = 2 \arcsin\left( \frac{1}{1 + \frac{r_p \cdot v_\infty^2}{\mu}} \right)}}$$
and interact with live Vis-Viva energy calculator, Keplerian orbit visualizer, Hohmann transfer $\Delta v$ solver, and Hyperbolic escape trajectory simulation studio widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Escape Velocity ($v_{\text{esc}} = \sqrt{2} v_{\text{circ}}$), Hyperbolic Excess ($v_\infty = \sqrt{v_p^2 - v_{\text{esc}}^2}$) & Turning Angle ($\delta$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Required Perigee Burn Speed to Achieve a Target Interplanetary Excess Velocity Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Orbital Escape Trajectory Entity / Conic Parameter & Technical Astrodynamic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Escape Velocity from Any Point in a Gravitational Field Is Strictly Equal to the Square Root of Two ($\sqrt{2} \approx 1.414$) Times the Local ___ Orbital Velocity (Circular / Circular Orbit) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Astrodynamics Studio: Vis-Viva Energy, Kepler's Laws, Hohmann Transfers & Escape Trajectories Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "escape_velocity_and_hyperbolic_trajectories",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is escape velocity, and how is it related to local circular speed and hyperbolic excess velocity v\u221e?",
      "blankAnswer": "Orbital Escape Mechanics (Curtis 2020): (1) ESCAPE VELOCITY: v_esc = \u221a(2\u03bc/r) = \u221a2 * v_circ \u2248 1.414 * \u221a(\u03bc/r), speed at which specific orbital energy \u03b5 = 0 and orbit opens into a parabola (e=1). (2) HYPERBOLIC EXCESS VELOCITY: v\u221e = \u221a(v_p^2 - v_esc^2) = \u221a(2\u03b5), residual asymptotic speed when spacecraft leaves planetary sphere of influence. (3) PERIGEE INJECTION SPEED: v_p = \u221a(v_esc^2 + v\u221e^2). (4) TURNING ANGLE: \u03b4 = 2*arcsin(1/e), fundamental geometric deflection angle enabling planetary gravity assists!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the required departure burn \u0394v to inject a spacecraft into an interplanetary hyperbolic escape trajectory.",
      "orderItems": [
        "Determine the target hyperbolic excess speed v\u221e required to reach the destination planet",
        "Calculate the circular orbital speed in the parking orbit: v_circ = \u221a(\u03bc / r_p)",
        "Calculate the parabolic escape velocity at the parking orbit radius: v_esc = \u221a2 * v_circ = \u221a(2*\u03bc / r_p)",
        "Calculate the required perigee speed on the hyperbolic escape trajectory: v_p = \u221a(v_esc^2 + v\u221e^2)",
        "Compute the required departure impulse: \u0394v_inj = v_p - v_circ"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Escape Trajectory Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Escape Velocity (v_esc)", "right": "v_esc = \u221a(2\u03bc/r), minimum speed required to break free from gravitational bound state to infinity with zero residual energy" },
        { "left": "Hyperbolic Excess (v\u221e)", "right": "v\u221e = \u221a(2*\u03b5), asymptotic residual velocity relative to central body at the edge of the sphere of influence" },
        { "left": "Turning Angle (\u03b4)", "right": "\u03b4 = 2*arcsin(1/e), angular deflection of spacecraft trajectory during an unpowered planetary gravity assist flyby" },
        { "left": "Specific Energy Invariant (\u03b5 = 0)", "right": "Boundary thermodynamic condition separating bound closed ellipses from open unbound escape conics" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The escape velocity from any point in a gravitational field is strictly equal to the square root of two (\\sqrt{2} \u2248 1.414) times the local ___ orbital velocity.",
      "blankAnswer": "circular",
      "blankDistractors": ["elliptical", "parabolic", "hyperbolic"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Astrodynamics & Spacecraft Dynamics Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Astrodynamics & Spacecraft Dynamics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Vis-Viva Energy, Kepler's Laws, Hohmann Transfers & Escape Velocity</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnVis\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Vis-Viva (vp=9.55, va=2.39 km/s)</button><button id=\"btnKep\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Kepler Laws (LEO T=93min, GEO=24h)</button><button id=\"btnHoh\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Hohmann (\u0394v=3.39 km/s) & Escape v_esc</button></div><div id=\"orbLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Vis-Viva orbital energy...</div><script>document.getElementById('btnVis').onclick=()=>{document.getElementById('orbLog').innerHTML='<b>1. VIS-VIVA ORBITAL VELOCITY \\& SPECIFIC ENERGY:</b><br>• v\u00b2 = \\u03bc*(2/r - 1/a) | Specific Energy: \\u03b5 = -\\u03bc / (2a)<br>• Perigee: v_p = \\u221a[398,600*(2/7000 - 1/17500)] = <b style=\"color:#10b981;\">9.55 km/s!</b><br>• <b style=\"color:#38bdf8;\">Apogee: v_a = \\u221a[398,600*(2/28000 - 1/17500)] = 2.39 km/s!</b>';}; document.getElementById('btnKep').onclick=()=>{document.getElementById('orbLog').innerHTML='<b>2. KEPLER\\'S THREE LAWS OF PLANETARY MOTION:</b><br>• Harmonic Law: T = 2\\u03c0*\\u221a(a\u00b3/\\u03bc)<br>• LEO (r=6800 km) &rarr; <b style=\"color:#10b981;\">T = 5581 s = 93.0 minutes!</b><br>• <b style=\"color:#38bdf8;\">GEO (T = 86,164 s) &rarr; a_GEO = 42,164 km (Altitude = 35,786 km)!</b>';}; document.getElementById('btnHoh').onclick=()=>{document.getElementById('orbLog').innerHTML='<b>3. HOHMANN TRANSFERS \\& ESCAPE TRAJECTORIES:</b><br>• Hohmann (r1=7000 &rarr; r2=28,000 km): \\u0394v1 = 2.00 km/s, \\u0394v2 = 1.39 km/s<br>• <b style=\"color:#10b981;\">Total Mission Budget: \\u0394v_total = 3.39 km/s!</b><br>• Escape Speed: v_esc = \\u221a(2\\u03bc/r) = \\u221a2 * v_circ = <b style=\"color:#38bdf8;\">11.19 km/s (at Earth surface)!</b><br>🏆 <b style=\"color:#10b981;\">Avionics_and_Spacecraft_Dynamics 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
