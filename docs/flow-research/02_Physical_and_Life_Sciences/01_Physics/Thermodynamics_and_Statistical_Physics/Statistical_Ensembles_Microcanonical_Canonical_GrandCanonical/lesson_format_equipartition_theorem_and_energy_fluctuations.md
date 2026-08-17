# Duofy Reusable Lesson Format: Equipartition Theorem and Energy Fluctuations

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Thermodynamics_and_Statistical_Physics / Statistical_Ensembles_Microcanonical_Canonical_GrandCanonical`  
**Lesson Format Type:** `equipartition_theorem_and_energy_fluctuations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of energy equipartition and canonical fluctuations: formulate the **Classical Equipartition Theorem ($\langle x_i \frac{\partial H}{\partial x_j} \rangle = \delta_{ij} k_B T$)** yielding $\frac{1}{2}k_B T$ mean energy per quadratic degree of freedom, derive the **Canonical Energy Variance ($\sigma_E^2 \equiv \langle E^2 \rangle - \langle E \rangle^2 = k_B T^2 C_V$)**, prove that relative energy fluctuations $\frac{\sigma_E}{\langle E \rangle} \propto \frac{1}{\sqrt{N}}$ vanish in the thermodynamic limit, evaluate quantum rotational and vibrational freezing of degrees of freedom, and interact with live energy fluctuation and degree-of-freedom partition simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Equipartition Theorem & Energy Variance Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Molecular Gas Degree of Freedom & Heat Capacity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Ideal Monatomic Gas Internal Energy Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Mean Energy per Quadratic Degree of Freedom Fractional Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Molecular Degrees of Freedom & Heat Capacity Freezing Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "equipartition_theorem_and_energy_fluctuations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Classical Equipartition Theorem, and how are canonical energy fluctuations related to Heat Capacity C_V?",
      "blankAnswer": "The Classical Equipartition Theorem (James Clerk Maxwell, Ludwig Boltzmann) states that for any classical system in thermal equilibrium at temperature T, every independent quadratic term in the Hamiltonian contributes exactly (1/2) * k_B * T to the mean internal energy: <E> = (f / 2) * N * k_B * T (where f is the number of quadratic degrees of freedom). In the Canonical Ensemble, energy is not fixed but fluctuates around <E>. The exact energy variance is directly proportional to the constant-volume heat capacity: sigma_E^2 = <(E - <E>)^2> = k_B * T^2 * C_V. Consequently, the relative root-mean-square energy fluctuation scales as sigma_E / <E> = sqrt(k_B * T^2 * C_V) / <E> ~ (1 / sqrt(N)). For macroscopic systems (N ~ 10^23), relative fluctuations are ~10^-11.5, proving that energy is virtually constant!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each gas model to its active quadratic degrees of freedom f and molar heat capacity C_V,m.",
      "matchPairs": [
        { "left": "Monatomic Ideal Gas (He, Ar)", "right": "f = 3 (translational only) -> C_V,m = (3/2) * R" },
        { "left": "Diatomic Gas at Room Temp (N_2, O_2)", "right": "f = 5 (3 trans + 2 rot; vib frozen) -> C_V,m = (5/2) * R" },
        { "left": "Diatomic Gas at High Temp (T > 1000 K)", "right": "f = 7 (3 trans + 2 rot + 2 vib [kinetic+potential]) -> C_V,m = (7/2) * R" },
        { "left": "Classical 3D Crystalline Solid (Dulong-Petit)", "right": "f = 6 (3 kinetic + 3 potential harmonic) -> C_V,m = 3 * R" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Calculate the total thermal internal energy (in Joules) of 2.0 moles of an ideal monatomic gas at room temperature T = 300 K: U = (3/2) * n * R * T with R = 8.314 J/(mol K) (round to nearest whole integer).",
      "numericAnswer": 7483,
      "numericTolerance": 10
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to the classical equipartition theorem, each independent quadratic degree of freedom contributes ___ / 2 * k_B * T to the average energy.",
      "blankAnswer": "1",
      "blankDistractors": ["3", "2", "5"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Equipartition & Quantum Freezing Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Molecular Degrees of Freedom Engine</h3><p>Molecule: Diatomic Hydrogen ($H_2$) | Temperature: $T = 50\\text{ K}$ (Cryogenic)</p><button id=\"eqBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Heat Gas to Room Temp ($T = 300\\text{ K}$)</button><div id=\"eqOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('eqBtn').onclick=()=>{document.getElementById('eqOut').innerText='Quantum Rotational Unfreezing: At 50 K, k_B T << ℏ²/2I (rotations frozen, f = 3, C_V = 3/2 R). At 300 K, rotational states populate! f = 5 (3 trans + 2 rot), C_V = 5/2 R = 20.78 J/(mol·K). Canonical RMS energy fluctuation: σ_E / <E> ≈ 10⁻¹¹.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
