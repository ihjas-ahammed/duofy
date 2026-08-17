# Duofy Reusable Lesson Format: Hydrogen Energy Spectrum and Orbital Degeneracy

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Quantum_Harmonic_Oscillator_and_Hydrogen_Atom`  
**Lesson Format Type:** `hydrogen_energy_spectrum_and_orbital_degeneracy`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the hydrogenic bound-state spectrum: formulate the **Bohr / Rydberg Energy Formula ($E_n = -\frac{13.606\text{ eV}}{n^2}$)**, calculate spectral emission series (**Lyman**, **Balmer**, **Paschen**, **Brackett** via the Rydberg equation $\frac{1}{\lambda} = R_H \left(\frac{1}{n_1^2} - \frac{1}{n_2^2}\right)$), derive the **Orbital Degeneracy ($g_n = \sum_{l=0}^{n-1}(2l+1) = n^2$)**, explain the accidental $l$-degeneracy arising from the **Laplace-Runge-Lenz vector $SO(4)$ symmetry**, and interact with live hydrogen emission spectral series simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hydrogenic Energy Levels & Degeneracy Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Spectral Series & Transition Level Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Hydrogen Ground State Binding Energy Ionization Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Spectral Emission Constant Discoverer Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Hydrogen Spectral Series & Photon Wavelength Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hydrogen_energy_spectrum_and_orbital_degeneracy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the energy eigenvalue spectrum of the Hydrogen Atom, and what is the physical origin of its n² orbital degeneracy?",
      "blankAnswer": "The bound-state energy eigenvalues of hydrogen depend ONLY on the principal quantum number n (Niels Bohr 1913, Erwin Schrödinger 1926): E_n = -m_e e^4 / (32 pi^2 eps_0^2 hbar^2 n^2) = -13.606 eV / n^2 (n = 1, 2, 3...). For a given energy level n, the orbital angular momentum takes values l = 0, 1, ..., n-1, each with 2l+1 magnetic sub-states m = -l, ..., +l. The total orbital degeneracy is g_n = sum_{l=0}^{n-1} (2l+1) = n^2 (or 2n^2 including electron spin). The 'accidental' degeneracy where energy is independent of l arises from the conservation of the quantum Laplace-Runge-Lenz (LRL) vector, reflecting a hidden 4D rotation symmetry SO(4) of the 1/r Coulomb potential!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each hydrogen emission spectral series to its lower transition level n_1 and wavelength regime.",
      "matchPairs": [
        { "left": "Lyman Series (n_1 = 1)", "right": "Transitions to ground state n=1 (Ultraviolet UV photons, e.g. Ly-alpha = 121.6 nm)" },
        { "left": "Balmer Series (n_1 = 2)", "right": "Transitions to n=2 (Visible light spectrum, e.g. H-alpha = 656.3 nm red line)" },
        { "left": "Paschen Series (n_1 = 3)", "right": "Transitions to n=3 (Near-Infrared NIR spectrum)" },
        { "left": "Brackett Series (n_1 = 4)", "right": "Transitions to n=4 (Mid-Infrared MIR spectrum)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Calculate the wavelength (in nanometers) of the famous red Balmer-alpha (H-alpha) line corresponding to the n = 3 to n = 2 transition in hydrogen: 1/lambda = R_H * (1/4 - 1/9) where R_H = 1.097 × 10^7 m^-1 (round to 1 decimal place).",
      "numericAnswer": 656.3,
      "numericTolerance": 1.0
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the Swedish physicist who formulated the empirical formula for atomic spectral line wavelengths (Rydberg)?",
      "blankAnswer": "rydberg"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hydrogen Emission Spectra Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Hydrogen Spectral Series Engine</h3><p>Transition: $n_2 = 3 \\longrightarrow n_1 = 2$ (Balmer $\\text{H}_\\alpha$)</p><button id=\"hydBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Photon Energy & Emission Wavelength</button><div id=\"hydOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('hydBtn').onclick=()=>{document.getElementById('hydOut').innerText='Photon Emitted: ΔE = 13.606 eV * (1/4 - 1/9) = 1.889 eV. Wavelength λ = hc / ΔE = 656.3 nm. Observed Color: Vivid Crimson Red (H-alpha line in stellar spectroscopy!). Degeneracy of n=3 shell: g_3 = 3² = 9 states (18 with spin).'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
