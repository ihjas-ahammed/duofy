# Duofy Reusable Lesson Format: Quantum Tunneling and Potential Barriers

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Schrodinger_Equation_and_Wavefunctions`  
**Lesson Format Type:** `quantum_tunneling_and_potential_barriers`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of quantum barrier penetration: formulate scattering across a **Rectangular Potential Barrier ($V(x) = V_0$ for $0 \le x \le a$, $0$ elsewhere)**, derive the **Exact Transmission Coefficient ($T = \frac{1}{1 + \frac{V_0^2}{4E(V_0-E)}\sinh^2(\kappa a)}$ where $\kappa = \frac{\sqrt{2m(V_0-E)}}{\hbar}$)** for $E < V_0$, evaluate the high/wide barrier exponential approximation ($T \approx 16 \frac{E}{V_0}(1 - \frac{E}{V_0}) e^{-2\kappa a}$), analyze the **WKB Barrier Penetration Formula ($T \approx e^{-2\int \kappa(x)dx}$)**, examine **Ramsauer-Townsend Transmission Resonances ($T = 1$ for $E > V_0$)**, and interact with live barrier tunneling and Scanning Tunneling Microscope (STM) simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Quantum Tunneling & Barrier Scattering Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Barrier Parameter & Tunneling Relation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Barrier Transmission Decay Exponential Scale Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Classically Forbidden Barrier Wavefunction Behavior Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Scanning Tunneling Microscope (STM) Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "quantum_tunneling_and_potential_barriers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Quantum Tunneling, and how is the Transmission Coefficient T through a potential barrier calculated?",
      "blankAnswer": "Quantum Tunneling is the non-zero probability for a microscopic particle with energy E to pass through a classically forbidden potential barrier V_0 > E. Inside the barrier of thickness a, the wavevector becomes imaginary k = i*kappa with attenuation constant kappa = sqrt(2m(V_0 - E)) / hbar, converting the oscillatory wave into a decaying evanescent wave. The exact transmission probability is: T = 1 / [ 1 + (V_0^2 / [4E(V_0 - E)]) * sinh^2(kappa * a) ]. For thick or high barriers (kappa*a >> 1), transmission decays exponentially: T ≈ 16 * (E/V_0) * (1 - E/V_0) * exp(-2*kappa*a). In generalized barriers, the WKB Approximation gives: T ≈ exp(-2 * int_{x_1}^{x_2} kappa(x) dx) (governs alpha decay, nuclear fusion in stars, and STM microscopy!)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each scattering regime to its physical formula.",
      "matchPairs": [
        { "left": "Exact Barrier Transmission (E < V_0)", "right": "T = 1 / [ 1 + (V_0^2 / [4E(V_0 - E)]) * sinh^2(kappa * a) ]" },
        { "left": "Thick Barrier Approximation (kappa*a >> 1)", "right": "T proportional to exp(-2 * kappa * a)" },
        { "left": "Transmission Resonance (E > V_0)", "right": "T = 1 when k' * a = n * pi (Ramsauer-Townsend effect)" },
        { "left": "WKB Tunneling Exponent", "right": "2 * int_{x_1}^{x_2} sqrt(2m[V(x) - E]) / hbar dx" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "An electron (m = 9.11 × 10^-31 kg) with energy E = 2.0 eV encounters a potential barrier of height V_0 = 5.0 eV and width a = 0.20 nm (2.0 Å). Calculate the barrier decay constant kappa in nm^-1: kappa = sqrt(2 * m * (V_0 - E) * 1.602e-19) / hbar (round to 1 decimal place).",
      "numericAnswer": 8.9,
      "numericTolerance": 0.3
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Inside a classically forbidden potential barrier (where E < V_0), the quantum wavefunction does not vanish abruptly but decays as an ___ function.",
      "blankAnswer": "exponential",
      "blankDistractors": ["linear", "sinusoidal", "logarithmic"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Scanning Tunneling Microscope (STM) Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Scanning Tunneling Microscope (STM) Engine</h3><p>Work Function: $\\Phi = 4.5\\text{ eV}$ | Initial Tip Gap: $d = 0.50\\text{ nm}$</p><button id=\"stmBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Retract STM Tip by 0.10 nm (1.0 Å)</button><div id=\"stmOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('stmBtn').onclick=()=>{document.getElementById('stmOut').innerText='Tunneling Current Response: Tip gap increased to d = 0.60 nm. Decay constant κ = 10.9 nm⁻¹. Tunneling current I ∝ exp(-2κd) drops by a factor of e^(-2.18) ≈ 8.85 (nearly 90% drop per Angstrom!). Atomic vertical resolution achieved!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
