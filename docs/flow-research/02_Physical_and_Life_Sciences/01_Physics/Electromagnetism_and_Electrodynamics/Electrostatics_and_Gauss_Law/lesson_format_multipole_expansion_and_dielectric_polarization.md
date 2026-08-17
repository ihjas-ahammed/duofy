# Duofy Reusable Lesson Format: Multipole Expansion and Dielectric Polarization

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Electrostatics_and_Gauss_Law`  
**Lesson Format Type:** `multipole_expansion_and_dielectric_polarization`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of electrostatics in matter: formulate the **Multipole Expansion** ($V(\mathbf{r}) = \frac{1}{4\pi\epsilon_0}\left[\frac{Q}{r} + \frac{\mathbf{p}\cdot\hat{\mathbf{r}}}{r^2} + \frac{Q_{ij}\hat{r}_i\hat{r}_j}{2r^3} + \dots\right]$), compute **Electric Dipole Moments $\mathbf{p} = \sum q_i \mathbf{r}_i$**, evaluate dipole torque $\mathbf{N} = \mathbf{p} \times \mathbf{E}$ and potential energy $U = -\mathbf{p}\cdot\mathbf{E}$, analyze **Dielectric Polarization $\mathbf{P}$**, compute bound charges ($\rho_b = -\nabla\cdot\mathbf{P}, \sigma_b = \mathbf{P}\cdot\hat{\mathbf{n}}$), formulate the **Electric Displacement Field $\mathbf{D} = \epsilon_0 \mathbf{E} + \mathbf{P} = \epsilon \mathbf{E}$**, and interact with live dielectric capacitor polarization simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Multipole Expansion & Dielectrics Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Multipole Term Order & Radial Distance Decay Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Electric Dipole Moment Origin Independence Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Volume Bound Charge Density Divergence Formula Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Dielectric Slab Polarization & D Field Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "multipole_expansion_and_dielectric_polarization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Multipole Expansion of electrostatic potential, and what are Bound Charges and the Electric Displacement field D in dielectrics?",
      "blankAnswer": "The Multipole Expansion expresses potential at large distances (r >> r') in powers of 1/r: V(r) = (1 / 4 pi eps_0) * [ Q / r + (p . r_hat) / r^2 + sum Q_ij r_hat_i r_hat_j / (2 r^3) + ... ], where Q is monopole total charge, p = sum q_i r_i' is the dipole moment, and Q_ij is the quadrupole tensor. In a Dielectric with polarization P(r) (dipole moment per volume), internal microscopic charge alignment creates: (1) Volume Bound Charge rho_b = -div(P), and (2) Surface Bound Charge sigma_b = P . n_hat. Gauss's Law in matter is written using the Electric Displacement D = eps_0 * E + P = eps * E, where div(D) = rho_free (depends ONLY on free charges!)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each multipole term to its potential V(r) and electric field E(r) radial distance scaling.",
      "matchPairs": [
        { "left": "Monopole Term (Net Charge Q != 0)", "right": "Potential V(r) proportional to 1/r; Field E(r) proportional to 1/r^2" },
        { "left": "Pure Electric Dipole (Moment p)", "right": "Potential V(r) proportional to 1/r^2; Field E(r) proportional to 1/r^3" },
        { "left": "Electric Quadrupole (Tensor Q_ij)", "right": "Potential V(r) proportional to 1/r^3; Field E(r) proportional to 1/r^4" },
        { "left": "Electric Octupole", "right": "Potential V(r) proportional to 1/r^4; Field E(r) proportional to 1/r^5" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Under what condition is the calculated electric dipole moment p = sum q_i r_i' of a charge distribution STRICTLY INDEPENDENT of the choice of coordinate origin?",
      "options": [
        { "text": "If and only if the TOTAL NET CHARGE of the system is ZERO (Q_total = sum q_i = 0)", "isCorrect": true, "explanation": "Correct! Shifting origin by vector a transforms the dipole moment to p' = sum q_i (r_i - a) = sum q_i r_i - a * (sum q_i) = p - a * Q_total. Thus p' = p for all shift vectors a if and only if Q_total = 0." },
        { "text": "For every charge distribution regardless of net charge", "isCorrect": false, "explanation": "Incorrect: If Q != 0, shifting origin changes p." },
        { "text": "Only when all charges are positive", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Only at absolute zero temperature", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a polarized dielectric, the volume bound charge density rho_b equals negative ___ of polarization P (rho_b = -div(P)).",
      "blankAnswer": "divergence",
      "blankDistractors": ["curl", "gradient", "laplacian"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Dielectric Polarization Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Dielectric Slab Polarization Engine</h3><p>Free Charge Density: σ_free = 10 μC/m² | Dielectric Constant: ε_r = 4.0</p><button id=\"dielBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate D, E, and Bound Charge σ_b</button><div id=\"dielOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('dielBtn').onclick=()=>{document.getElementById('dielOut').innerText='Results: D = σ_free = 10 μC/m²; E = D / (ε₀ ε_r) = 282.3 kV/m (screened by 75%!). Induced bound surface charge: σ_b = σ_free * (1 - 1/ε_r) = 7.5 μC/m². Net internal field reduced!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
