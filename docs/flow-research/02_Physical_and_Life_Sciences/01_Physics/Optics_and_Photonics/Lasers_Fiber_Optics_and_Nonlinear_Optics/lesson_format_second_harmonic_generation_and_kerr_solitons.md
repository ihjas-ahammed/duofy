# Duofy Reusable Lesson Format: Second Harmonic Generation and Kerr Solitons

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Optics_and_Photonics / Lasers_Fiber_Optics_and_Nonlinear_Optics`  
**Lesson Format Type:** `second_harmonic_generation_and_kerr_solitons`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of high-intensity nonlinear optical phenomena: formulate the **Nonlinear Polarization Expansion ($P = \epsilon_0[\chi^{(1)}E + \chi^{(2)}E^2 + \chi^{(3)}E^3 + \dots]$)**, analyze **Second Harmonic Generation (SHG / Frequency Doubling)** in non-centrosymmetric crystals, evaluate the **Phase-Matching Condition ($\Delta k = k_{2\omega} - 2k_\omega = 0$)** and conversion efficiency $\eta \propto \operatorname{sinc}^2(\Delta k L / 2)$, explain **Birefringent Angle Tuning** and **Quasi-Phase Matching (Periodic Poling)**, evaluate the **Optical Kerr Effect ($n(I) = n_0 + n_2 I$)**, formulate the **Nonlinear Schrödinger Equation (NLSE)**, and explain the formation of shape-preserving **Fundamental Optical Solitons** balancing anomalous Group Velocity Dispersion (GVD) with Self-Phase Modulation (SPM).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nonlinear Susceptibility & Soliton Physics Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Nonlinear Optical Effect & Susceptibility Order Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Second Harmonic Generation Phase Mismatch Intensity Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Second-Order Nonlinearity Vanishing in Centrosymmetric Media Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Nonlinear Frequency Doubling (SHG) Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "second_harmonic_generation_and_kerr_solitons",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Second Harmonic Generation (SHG), why is Phase Matching required, and what is an Optical Soliton?",
      "blankAnswer": "Second Harmonic Generation (SHG) is a second-order nonlinear optical process (chi^(2)) where two photons of frequency omega combine in a non-centrosymmetric crystal (like BBO or KDP) to create a single photon of doubled frequency 2*omega. Efficient power transfer requires Phase Matching (Delta k = k_{2omega} - 2*k_omega = 0); without phase matching, chromatic dispersion causes generated waves to destructively interfere with conversion efficiency scaling as sinc^2(Delta k * L / 2). The Optical Kerr Effect (chi^(3)) makes refractive index intensity-dependent: n(I) = n_0 + n_2 * I. An Optical Soliton is a light pulse that propagates over thousands of kilometers in an optical fiber with ZERO shape distortion, created by the exact cancellation between anomalous Group Velocity Dispersion (GVD, beta_2 < 0) and nonlinear Self-Phase Modulation (SPM, n_2 > 0)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each nonlinear optical effect to its underlying susceptibility order.",
      "matchPairs": [
        { "left": "Second Harmonic Generation (SHG)", "right": "Second-order chi^(2) process doubling optical frequency: omega + omega -> 2omega (requires non-centrosymmetric crystal)" },
        { "left": "Optical Kerr Effect / Self-Phase Modulation", "right": "Third-order chi^(3) process producing intensity-dependent refractive index: n(I) = n_0 + n_2 * I" },
        { "left": "Fundamental Optical Soliton", "right": "NLSE hyperbolic secant pulse: exact balance between anomalous GVD (beta_2 < 0) and SPM (gamma > 0)" },
        { "left": "Quasi-Phase Matching (QPM)", "right": "Periodic domain inversion (poling) every coherence length L_c = pi / Delta k to maintain monotonic power growth" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In Second Harmonic Generation (SHG), what happens if the phase mismatch Delta k = k_{2omega} - 2 k_omega is NON-ZERO (Delta k != 0)?",
      "options": [
        { "text": "The generated second-harmonic power does not grow monotonically, but instead OSCILLATES sinusoidally back and forth between fundamental and second-harmonic frequencies over the Coherence Length L_c = pi / |Delta k|, severely suppressing conversion efficiency", "isCorrect": true, "explanation": "Correct! Because of phase mismatch Delta k != 0, the second-harmonic wave generated at one point slips out of phase with previously generated waves after traveling distance L_c = pi/|Delta k|. Beyond L_c, destructive interference occurs, transferring power back into the fundamental wave (governed by sinc^2(Delta k * L / 2))." },
        { "text": "The laser beam frequency turns into audio sound", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The crystal explodes immediately", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Light speed becomes infinite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In materials possessing inversion symmetry (centrosymmetric media like isotropic glass or liquids), the second-order nonlinear susceptibility chi^(2) equals ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "infinity", "-1"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Second Harmonic Generation (SHG) Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Nonlinear SHG Frequency Doubling Engine</h3><p>Fundamental Laser: Nd:YAG λ = 1064 nm (Infrared) | Crystal: BBO</p><button id=\"shgBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Tune Crystal Angle to Phase Match (Δk = 0)</button><div id=\"shgOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('shgBtn').onclick=()=>{document.getElementById('shgOut').innerText='Birefringent Phase Matching Achieved: θ_pm = 22.8°. Δk = 0. Output Wavelength: λ = 532 nm (Vivid Emerald Green Light!). Second-Harmonic conversion efficiency η = 74.5%. Coherent frequency doubling active!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
