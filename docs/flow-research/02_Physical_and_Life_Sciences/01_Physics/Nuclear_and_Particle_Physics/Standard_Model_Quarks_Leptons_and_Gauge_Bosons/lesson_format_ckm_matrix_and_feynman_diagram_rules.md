# Duofy Reusable Lesson Format: CKM Matrix and Feynman Diagram Rules

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Nuclear_and_Particle_Physics / Standard_Model_Quarks_Leptons_and_Gauge_Bosons`  
**Lesson Format Type:** `ckm_matrix_and_feynman_diagram_rules`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of flavor physics and Feynman diagram computations: formulate the **Cabibbo-Kobayashi-Maskawa (CKM) Quark Mixing Matrix (1973)** ($\mathbf{V}_{\text{CKM}}$), analyze the **Wolfenstein Parametrization** ($\lambda, A, \rho, \eta$), calculate the **Unitarity Triangle** and CP-violating phase $\delta_{CP}$, draw tree-level Feynman diagrams for **Muon Decay ($\mu^- \to e^- \bar{\nu}_e \nu_\mu$)**, **Beta Decay ($n \to p e^- \bar{\nu}_e$)**, and **Neutron-Antineutron / Meson Box Diagrams**, and interact with live Feynman diagram and CKM quark vertex simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CKM Matrix & Feynman Diagram Rules Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Particle Process & Feynman Propagator / Vertex Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | CKM Matrix Minimum Quark Generations for CP Violation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | CKM Diagonal Element V_ud Magnitude Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Feynman Vertex & CKM Transition Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ckm_matrix_and_feynman_diagram_rules",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the CKM Matrix, and how do Feynman Diagram rules govern Weak Charged Current quark flavor changes?",
      "blankAnswer": "The Cabibbo-Kobayashi-Maskawa (CKM) Matrix is a 3x3 unitary matrix relating the quark mass eigenstates (d, s, b) to their weak interaction eigenstates (d', s', b'): [d', s', b']^T = V_CKM * [d, s, b]^T. The charged weak current W+- couples to quarks with vertex factor -i*(g / sqrt(2)) * gamma^mu * (1/2)(1 - gamma^5) * V_{ij}. In Feynman diagrams, W+- exchange allows flavor-changing transitions between up-type quarks (u, c, t) and down-type quarks (d, s, b). The 3 generations allow 1 irreducible complex CP-violating phase delta_CP, providing the microscopic origin for CP violation in K and B meson systems!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each particle decay process to its mediating Feynman propagator.",
      "matchPairs": [
        { "left": "Beta Decay (d -> u + e- + anti-nu_e)", "right": "Virtual W- boson exchange coupling to left-handed (u,d) with CKM factor V_ud ≈ 0.974" },
        { "left": "Muon Decay (mu- -> e- + anti-nu_e + nu_mu)", "right": "Pure leptonic W- boson exchange with Fermi coupling constant G_F / (hbar*c)^3 ≈ 1.166 × 10^-5 GeV^-2" },
        { "left": "B0 - anti-B0 Neutral Meson Mixing", "right": "Second-order weak 4-point Box Diagram with internal top quarks and W bosons" },
        { "left": "Electron-Muon Scattering (e- mu- -> e- mu-)", "right": "Tree-level virtual photon (gamma) exchange in QED with coupling e" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why are at least THREE GENERATIONS OF QUARKS strictly necessary for the CKM matrix to explain CP VIOLATION?",
      "options": [
        { "text": "An NxN unitary matrix has (N-1)(N-2)/2 physical complex phases after rephasing 2N quark fields; for N = 2 (Cabibbo model), there are 0 complex phases (no CP violation), whereas for N = 3 (Kobayashi-Maskawa), there is EXACTLY 1 physical complex phase delta_CP that enables CP violation", "isCorrect": true, "explanation": "Correct! Makoto Kobayashi and Toshihide Maskawa predicted the 3rd generation of quarks in 1973 (Nobel Prize 2008) because a 2x2 quark mixing matrix is purely real, while a 3x3 matrix has one irreducible complex phase that breaks CP symmetry." },
        { "text": "Because 2 generations cannot form hadrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Higgs field requires 3 particles", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because quarks have 3 color charges", "isCorrect": false, "explanation": "Incorrect: Color is SU(3)_C, unrelated to flavor phase counting." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The dominant diagonal element V_ud of the CKM matrix (governing standard nuclear beta decay) equals approximately 0.___ (round to 2 decimal places).",
      "blankAnswer": "97",
      "blankDistractors": ["22", "50", "05"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive CKM Matrix and Feynman Vertex Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>CKM Weak Transition Engine</h3><p>Select Quark Flavor Transition: <span id=\"currTrans\">Top -> Bottom (t -> b + W⁺)</span></p><button id=\"ckmBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Evaluate CKM Coupling Amplitude</button><div id=\"ckmOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('ckmBtn').onclick=()=>{document.getElementById('ckmOut').innerText='Vertex: W⁺-t-b | CKM Element: |V_tb| = 0.999 ± 0.001 (Dominant ~100% branching ratio!). Top quark lifetime τ ≈ 5×10⁻²⁵ s. Decays before hadronization occurs!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
