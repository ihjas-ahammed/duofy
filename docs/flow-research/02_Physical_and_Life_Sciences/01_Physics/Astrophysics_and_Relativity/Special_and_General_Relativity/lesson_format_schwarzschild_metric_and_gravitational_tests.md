# Duofy Reusable Lesson Format: Schwarzschild Metric and Gravitational Tests

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Astrophysics_and_Relativity / Special_and_General_Relativity`  
**Lesson Format Type:** `schwarzschild_metric_and_gravitational_tests`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of exact curved spacetimes: formulate the **Schwarzschild Metric (Karl Schwarzschild, 1916)**, derive the **Schwarzschild Radius / Event Horizon $r_s = \frac{2GM}{c^2}$**, evaluate **Gravitational Time Dilation** ($d\tau = dt \sqrt{1 - r_s/r}$), analyze the 4 classical experimental tests of GR (**Mercury Perihelion Precession**, **Gravitational Deflection of Light**, **Pound-Rebka Gravitational Redshift**, and **LIGO Gravitational Waves**), and interact with live Schwarzschild light-bending / time dilation simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Schwarzschild Metric & Classical GR Tests Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Experimental Test of GR & Physical Phenomenon Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Sun Schwarzschild Radius Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Event Horizon Schwarzschild Boundary Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Gravitational Time Dilation & Lensing Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "schwarzschild_metric_and_gravitational_tests",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Schwarzschild Metric, and what are the 4 classical experimental tests of General Relativity?",
      "blankAnswer": "The Schwarzschild Metric (Karl Schwarzschild, 1916) is the unique spherically symmetric vacuum solution (T_{mu nu} = 0) of Einstein's field equations outside a static mass M: ds^2 = -(1 - r_s/r) c^2 dt^2 + (1 - r_s/r)^{-1} dr^2 + r^2 dOmega^2, where r_s = 2GM / c^2 is the Schwarzschild Radius (Event Horizon). The 4 classical experimental tests are: (1) Anomalous Perihelion Precession of Mercury (43 arcsec/century), (2) Gravitational Deflection of Starlight by the Sun (Delta theta = 4GM / (c^2 b) ≈ 1.75 arcsec, Eddington 1919), (3) Gravitational Redshift / Time Dilation (Pound-Rebka 1959), and (4) Gravitational Waves from binary black hole mergers (LIGO 2015)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each experimental test of General Relativity to its historical validation.",
      "matchPairs": [
        { "left": "Mercury Perihelion Advance (43''/century)", "right": "Solved 60-year-old Newtonian anomaly through spacetime curvature orbital precession" },
        { "left": "Eddington Solar Eclipse (1919)", "right": "Confirmed photon deflection angle Delta theta = 4GM / (c^2 R_sun) = 1.75 arcsec (twice the Newtonian prediction!)" },
        { "left": "Pound-Rebka Experiment (1959)", "right": "Measured gravitational redshift of gamma rays in Harvard tower: Delta nu / nu = g h / c^2" },
        { "left": "LIGO Detection GW150914 (2015)", "right": "Observed quadrupole gravitational waves from binary black hole merger 1.3 billion light years away" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Calculate the Schwarzschild radius r_s = 2GM / c^2 of the Sun (M = 1.989 × 10^30 kg, G = 6.674 × 10^-11, c = 3.0 × 10^8 m/s) in kilometers (round to nearest whole integer): r_s in km.",
      "numericAnswer": 3,
      "numericTolerance": 0.5
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the two-word term for the spherical boundary at r = r_s from within which not even light can escape (event horizon)?",
      "blankAnswer": "event horizon"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Schwarzschild Spacetime Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Schwarzschild Gravitational Time Dilation</h3><p>Mass: 10 M_☉ Black Hole (r_s = 29.5 km)</p><button id=\"grBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Clock Tick Rate at r = 1.5 r_s (44.3 km)</button><div id=\"grOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('grBtn').onclick=()=>{document.getElementById('grOut').innerText='Dilation Ratio: dτ/dt = √(1 - r_s/r) = √(1 - 1/1.5) = √(0.333) = 0.577. A stationary observer at 1.5 r_s ages at only 57.7% the rate of an observer far away at infinity! Redshift factor z = 0.732.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
