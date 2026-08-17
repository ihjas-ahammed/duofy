# Duofy Reusable Lesson Format: Time-Dependent Perturbation Theory and Fermi's Golden Rule

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Perturbation_Theory_Time_Dependent_and_Independent`  
**Lesson Format Type:** `time_dependent_perturbation_and_fermis_golden_rule`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of quantum dynamics and transition rates: formulate the **Time-Dependent Interaction Picture**, expand state transitions in the Dyson series ($c_f^{(1)}(t) = -\frac{i}{\hbar}\int_0^t \langle f | \hat{H}'(t') | i \rangle e^{i\omega_{fi}t'} dt'$), evaluate sinusoidal / harmonic perturbations ($\hat{H}'(t) = \hat{V} e^{-i\omega t} + \hat{V}^\dagger e^{i\omega t}$), derive **Fermi's Golden Rule ($\Gamma_{i \to f} = \frac{2\pi}{\hbar} |\langle f | \hat{V} | i \rangle|^2 \rho(E_f)$)** for transitions into a continuum of states, and interact with live quantum Rabi oscillation and Fermi transition rate simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Time-Dependent Perturbations & Fermi's Golden Rule Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Dynamic Transition Concept & Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Harmonic Perturbation Sinc-Squared Transition Rate Integral Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Constant Factor in Fermi's Golden Rule Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Rabi Oscillation & Fermi Golden Rule Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "time_dependent_perturbation_and_fermis_golden_rule",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Time-Dependent Perturbation Theory, and what is Fermi's Golden Rule for transition rates into a continuum?",
      "blankAnswer": "Time-Dependent Perturbation Theory calculates the probability of transitions between unperturbed stationary states induced by a time-varying potential H'(t): the first-order amplitude is c_f^(1)(t) = -(i/hbar) * int_0^t <f| H'(t') |i> exp(i omega_fi t') dt'. For a constant or harmonic perturbation V acting over time t, the transition probability to a discrete state exhibits sinc^2 peak behavior: P_{i->f}(t) = (4 |V_fi|^2 / [hbar^2 (omega_fi - omega)^2]) * sin^2((omega_fi - omega)t / 2). For transitions into a continuous band of states (like atomic ionization or radioactive decay), taking the limit t -> infinity yields Fermi's Golden Rule (1927): Gamma_{i->f} = (2 pi / hbar) * |<f| V |i>|^2 * rho(E_f), where rho(E_f) is the final density of states!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each time-dependent quantum dynamical quantity to its formula.",
      "matchPairs": [
        { "left": "First-Order Transition Amplitude c_f(t)", "right": "-(i / hbar) * int_0^t <f| H'(t') |i> exp(i omega_fi t') dt'" },
        { "left": "Fermi's Golden Rule Transition Rate Gamma", "right": "Gamma = (2 pi / hbar) * |<f| V |i>|^2 * rho(E_f)" },
        { "left": "Bohr Transition Frequency omega_fi", "right": "omega_fi = (E_f - E_i) / hbar" },
        { "left": "Resonant Two-Level Rabi Frequency", "right": "Omega_R = |<1| V |2>| / hbar (coherent population exchange rate)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the derivation of Fermi's Golden Rule, how does the function [sin²((omega_fi - omega)t / 2) / (omega_fi - omega)²] behave as time t -> infinity?",
      "options": [
        { "text": "It approaches a DIRAC DELTA FUNCTION: (pi * t / 2) * delta(omega_fi - omega) = (pi * hbar * t / 2) * delta(E_f - E_i - hbar*omega), enforcing strict energy conservation in the long-time limit", "isCorrect": true, "explanation": "Correct! As t -> infinity, the central sinc^2 peak narrows and sharpens into a Dirac delta function: lim_{t->inf} [sin^2(x t / 2) / (x^2 t)] = (pi/2) delta(x). Dividing by time t converts the total probability into a constant, time-independent transition rate per unit time." },
        { "text": "It diverges to infinity everywhere", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It drops to zero everywhere", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It turns into an exponential decay", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Fermi's Golden Rule Gamma = (___ * pi / hbar) * |V_fi|^2 * rho(E), the numerical prefactor in the numerator is 2.",
      "blankAnswer": "2",
      "blankDistractors": ["4", "1", "8"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Quantum Rabi Oscillation & Decay Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Quantum Dynamics Engine</h3><p>Coupling: $\\Omega_R = 10\\text{ MHz}$ | Transition: $|g\\rangle \\leftrightarrow |e\\rangle$</p><button id=\"rabiBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Coherent $\\pi$-Pulse</button><div id=\"rabiOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('rabiBtn').onclick=()=>{document.getElementById('rabiOut').innerText='Pulse Applied: Pulse duration t = π / Ω_R = 50 ns. Inversion complete: P_e = sin²(Ω_R t / 2) = sin²(π/2) = 1.00 (100% excited state population!). Fermi continuum decay active with rate Γ = 2π/ℏ |V|² ρ(E).'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
