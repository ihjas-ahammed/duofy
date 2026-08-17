# Duofy Reusable Lesson Format: Big Bang Nucleosynthesis and Cosmic Inflation

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Astrophysics_and_Relativity / Cosmology_Big_Bang_and_Dark_Energy`  
**Lesson Format Type:** `big_bang_nucleosynthesis_and_cosmic_inflation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of early-universe physics: master **Cosmic Inflation (Alan Guth, 1981)** (exponential expansion solving the Horizon, Flatness, and Monopole problems), trace **Big Bang Nucleosynthesis (BBN, $t \sim 10\text{ s} - 20\text{ min}$)** (neutron-proton freezeout $n/p \approx 1/6 \to 1/7$ and primordial mass fractions: $75\% \, ^1\text{H}$, $25\% \, ^4\text{He}$, $\text{D}, ^3\text{He}, ^7\text{Li}$), and interact with live BBN primordial abundance simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Inflation & Primordial Nucleosynthesis Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Early Universe Epoch & Physical Event Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Primordial Helium-4 Mass Fraction Calculation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Inflationary Problem Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Big Bang Primordial Abundance Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "big_bang_nucleosynthesis_and_cosmic_inflation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Cosmic Inflation, and what are the primary products and mass fractions of Big Bang Nucleosynthesis (BBN)?",
      "blankAnswer": "Cosmic Inflation (Alan Guth, 1981) is an epoch of exponential spacetime expansion (a(t) ~ e^{Ht}) at t ~ 10^{-36} s driven by an inflaton scalar field, solving the Horizon Problem (causal thermal equilibrium of CMB), Flatness Problem (driving Omega -> 1), and Monopole Problem. Big Bang Nucleosynthesis (BBN) occurred between t ~ 10 s and 20 min when temperatures cooled to ~10^9 K, fusing primordial protons and neutrons into ~75% Hydrogen-1, ~25% Helium-4 by mass, with trace amounts of Deuterium (10^{-5}), Helium-3, and Lithium-7."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each early universe epoch to its key physical transition.",
      "matchPairs": [
        { "left": "Inflation Epoch (t ~ 10^{-36} s)", "right": "Exponential expansion stretches quantum fluctuations into large-scale cosmic structure seeds" },
        { "left": "Electroweak Phase Transition (t ~ 10^{-11} s)", "right": "Higgs mechanism gives mass to W and Z bosons and fundamental fermions" },
        { "left": "Neutron-Proton Freezeout (t ~ 1 s)", "right": "Weak interactions freeze out at T ~ 0.8 MeV, fixing the n/p ratio at ~ 1/6" },
        { "left": "BBN Helium Synthesis (t ~ 3 min)", "right": "Deuterium bottleneck breaks, locking virtually all free neutrons into Helium-4 nuclei" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If the neutron-to-proton ratio at the onset of Big Bang Nucleosynthesis is n/p = 1/7, why is the resulting primordial Helium-4 mass fraction Y_p approximately 25%?",
      "options": [
        { "text": "Every Helium-4 nucleus requires 2 neutrons and 2 protons (mass = 4). For 2 neutrons and 14 protons (total mass = 16), 1 He-4 nucleus forms from 4 nucleons, giving mass fraction Y_p = 4 / 16 = 25%", "isCorrect": true, "explanation": "Correct! Because free neutrons are locked almost exclusively into He-4, the mass fraction is given by Y_p = 2(n/p) / (1 + n/p) = 2(1/7) / (1 + 1/7) = (2/7) / (8/7) = 2/8 = 25%." },
        { "text": "Because stars fused 25% of all gas", "isCorrect": false, "explanation": "Incorrect: Stellar nucleosynthesis accounts for less than 2% of helium." },
        { "text": "Because hydrogen has 4 neutrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the universe was 25% dark matter", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What cosmological problem regarding why causally disconnected regions of the CMB share the exact same temperature was solved by inflation (horizon)?",
      "blankAnswer": "horizon"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Primordial BBN Abundance Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>BBN Primordial Nucleosynthesis Engine</h3><p>Baryon-to-Photon Ratio: η = 6.1 × 10⁻¹⁰ (Planck 2018)</p><button id=\"bbnBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Simulate BBN Primordial Yields</button><div id=\"bbnOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('bbnBtn').onclick=()=>{document.getElementById('bbnOut').innerText='BBN Results: ⁴He mass fraction Y_p = 0.247 (24.7%), D/H = 2.54 × 10⁻⁵, ³He/H = 1.0 × 10⁻⁵, ⁷Li/H = 4.7 × 10⁻¹⁰. High agreement with spectroscopic observations of pristine metal-poor gas clouds!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
