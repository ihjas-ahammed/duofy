# Duofy Reusable Lesson Format: Damped Driven Oscillators and Resonance

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Kinematics_and_Newtonian_Dynamics`  
**Lesson Format Type:** `damped_driven_oscillators_and_resonance`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of harmonic oscillations: solve the differential equation for **Damped Driven Harmonic Oscillators** ($\ddot{x} + 2\gamma \dot{x} + \omega_0^2 x = \frac{F_0}{m}\cos(\omega t)$), evaluate the **Transient Solution** (underdamped, critically damped, overdamped) vs **Steady-State Response**, calculate the **Resonance Peak Frequency ($\omega_{\text{res}} = \sqrt{\omega_0^2 - 2\gamma^2}$)**, compute the **Quality Factor $Q = \frac{\omega_0}{2\gamma}$**, and interact with live resonance curve simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Damped Driven Oscillator & Resonance Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Damping Regime & Characteristic Roots Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Phase Lag Delta at Resonance Frequency Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Quality Factor Symbol Acronym Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Driven Oscillator Resonance Amplitude Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "damped_driven_oscillators_and_resonance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the steady-state amplitude A(omega) and resonance frequency of a damped driven harmonic oscillator: x'' + 2*gamma*x' + omega_0^2*x = (F_0/m)*cos(omega*t)?",
      "blankAnswer": "The steady-state solution is x_{ss}(t) = A(omega) * cos(omega*t - delta), where the amplitude is A(omega) = (F_0 / m) / sqrt((omega_0^2 - omega^2)^2 + 4*gamma^2*omega^2) and the phase lag is tan(delta) = 2*gamma*omega / (omega_0^2 - omega^2). Amplitude resonance occurs at frequency omega_{res} = sqrt(omega_0^2 - 2*gamma^2) (for light damping gamma < omega_0 / sqrt(2)). The sharpness of the resonance peak is measured by the Quality Factor Q = omega_0 / (2*gamma) = omega_0 / Delta omega_{FWHM}."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each damping regime to its characteristic roots and motion.",
      "matchPairs": [
        { "left": "Underdamped (gamma < omega_0)", "right": "Complex roots -gamma +/- i*omega_d; oscillates with exponentially decaying envelope e^{-gamma t}" },
        { "left": "Critically Damped (gamma = omega_0)", "right": "Repeated real root -gamma; returns to equilibrium in the FASTEST possible time without oscillating" },
        { "left": "Overdamped (gamma > omega_0)", "right": "Distinct negative real roots; sluggish non-oscillatory return to equilibrium dominated by slow decay" },
        { "left": "Undamped (gamma = 0)", "right": "Pure imaginary roots +/- i*omega_0; perpetual sinusoidal oscillation at natural frequency omega_0" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "When a driven harmonic oscillator is driven EXACTLY at its undamped natural frequency omega = omega_0, what is the phase lag delta between the driving force and the displacement response?",
      "options": [
        { "text": "delta = pi / 2 (90 degrees); displacement lags driving force by 90°, so velocity v(t) is exactly IN PHASE with the driving force, maximizing power absorption", "isCorrect": true, "explanation": "Correct! At omega = omega_0, tan(delta) = 2*gamma*omega_0 / 0 = infinity => delta = pi/2. Because velocity leads displacement by 90°, velocity is completely in phase with the driver (F . v is always positive), maximizing energy transfer." },
        { "text": "delta = 0 degrees (completely in phase)", "isCorrect": false, "explanation": "Incorrect: Occurs only as omega -> 0." },
        { "text": "delta = pi (180 degrees)", "isCorrect": false, "explanation": "Incorrect: Occurs as omega -> infinity." },
        { "text": "delta = 45 degrees", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What single letter represents the dimensionless Quality factor measuring resonance sharpness (Q)?",
      "blankAnswer": "q"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Driven Oscillator Resonance Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Driven Oscillator Resonance Curve</h3><p>Natural Freq: ω₀ = 10 rad/s | Damping: γ = 1.0 s⁻¹ (Q = 5.0)</p><button id=\"resBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Sweep Driving Frequency ω = 0 → 20 rad/s</button><div id=\"resOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('resBtn').onclick=()=>{document.getElementById('resOut').innerText='Peak Resonance: Maximum amplitude A_max = 5.05 cm reached at ω_res = √(100 - 2) = 9.90 rad/s! Phase lag δ = 90° at ω = 10 rad/s. Quality factor Q = 5.0 matches FWHM bandwidth Δω = 2.0 rad/s.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
