# Duofy Reusable Lesson Format: Liénard-Wiechert Potentials and Larmor Radiation

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Relativistic_Electrodynamics`  
**Lesson Format Type:** `lienard_wiechert_potentials_and_larmor_radiation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of radiation from accelerating relativistic point charges: formulate the **Retarded Time ($t_r = t - \frac{|\mathbf{r} - \mathbf{w}(t_r)|}{c}$)**, derive the **Liénard-Wiechert Potentials (Alfred-Marie Liénard 1898, Emil Wiechert 1900)** ($V = \frac{1}{4\pi\epsilon_0}\frac{q}{(r - \boldsymbol{r}\cdot\mathbf{v}/c)}$, $\mathbf{A} = \frac{\mathbf{v}}{c^2}V$), calculate velocity fields ($1/r^2$) and acceleration radiation fields ($1/r$), derive the **Relativistic Larmor Power Formula ($P = \frac{\mu_0 q^2 \gamma^6}{6\pi c} [a^2 - (\mathbf{v}\times\mathbf{a}/c)^2]$)**, and analyze **Synchrotron Radiation beaming**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Liénard-Wiechert Potentials & Larmor Radiation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Retarded Field Term & Distance Scaling Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Synchrotron Radiation Relativistic Forward Beaming Cone Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Retarded Time Causality Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Relativistic Synchrotron Beaming Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lienard_wiechert_potentials_and_larmor_radiation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the Liénard-Wiechert Potentials, and what is the Relativistic Larmor Formula for power radiated by an accelerating charge?",
      "blankAnswer": "The Liénard-Wiechert Potentials (1898-1900) give the exact electromagnetic potentials of a moving point charge q evaluated at the retarded time t_r = t - |r - w(t_r)| / c: V(r, t) = (1 / 4 pi eps_0) * q / [ script_r * (1 - r_hat . v/c) ], and A(r, t) = (v(t_r) / c^2) * V(r, t). Accelerating charges radiate electromagnetic power governed by the Relativistic Larmor Formula: P = (mu_0 * q^2 * gamma^6 / [6 pi c]) * [ a^2 - |v x a|^2 / c^2 ]. For ultra-relativistic circular motion (Synchrotron Radiation), radiation is beamed forward into a narrow cone of opening angle theta ~ 1/gamma!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each electric field component of a moving point charge to its property.",
      "matchPairs": [
        { "left": "Velocity Field (Generalized Coulomb)", "right": "Scales as 1/script_r^2; static near-field attached to charge; carries zero net radiated power to infinity" },
        { "left": "Acceleration Field (Radiation Field)", "right": "Scales as 1/script_r; transverse wave detachment carrying real electromagnetic power to infinity" },
        { "left": "Non-Relativistic Larmor Power", "right": "P = mu_0 * q^2 * a^2 / (6 pi c) (Joseph Larmor, 1897)" },
        { "left": "Synchrotron Radiation Angular Cone", "right": "Intense forward beaming within opening angle theta ≈ 1 / gamma" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is synchrotron radiation from an ultra-relativistic electron (gamma >> 1) in a circular storage ring beamed into an extremely narrow forward cone of angle theta ≈ 1/gamma?",
      "options": [
        { "text": "LORENTZ BOOSTING transforms the isotropic dipole radiation pattern in the electron's instantaneous rest frame into a narrow forward-directed beam in the laboratory frame with opening half-angle theta ≈ 1/gamma", "isCorrect": true, "explanation": "Correct! Relativistic aberration compresses radiation emitted in all forward directions into a narrow forward spotlight cone of angle 1/gamma. For a 3 GeV electron (gamma ≈ 6000), theta ≈ 0.17 milliradians!" },
        { "text": "Because the electron stops emitting light", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because magnetic fields destroy photons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because light travels at infinite speed", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The time t_r at which an electromagnetic signal was emitted by a moving source to reach an observer at time t is called the ___ time.",
      "blankAnswer": "retarded",
      "blankDistractors": ["advanced", "proper", "coordinate"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Synchrotron Radiation Beaming Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Relativistic Synchrotron Emission Engine</h3><p>Electron Energy: E = 3.0 GeV (γ = 5,870) | B = 1.5 Tesla</p><button id=\"synchBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Relativistic Radiation Beaming</button><div id=\"synchOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('synchBtn').onclick=()=>{document.getElementById('synchOut').innerText='Emission Output: Beaming Cone Angle θ ≈ 1/γ = 0.170 milliradians (0.0097°)! Radiated Power per electron P = 1.62 nW. Critical photon energy E_c = (3/2) ℏ γ³ (c / R) = 8.9 keV (Hard X-rays!).'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
