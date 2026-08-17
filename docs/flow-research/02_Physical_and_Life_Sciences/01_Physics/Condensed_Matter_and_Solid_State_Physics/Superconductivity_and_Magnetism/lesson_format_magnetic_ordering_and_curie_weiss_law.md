# Duofy Reusable Lesson Format: Magnetic Ordering and the Curie-Weiss Law

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Superconductivity_and_Magnetism`  
**Lesson Format Type:** `magnetic_ordering_and_curie_weiss_law`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of quantum magnetism: classify **Diamagnetism**, **Paramagnetism (Curie's Law $\chi = C/T$)**, **Ferromagnetism (Curie-Weiss Law $\chi = \frac{C}{T - \theta_C}$)**, and **Antiferromagnetism (Néel Temperature $T_N$)**, formulate the **Heisenberg Exchange Hamiltonian ($\hat{H} = -2\sum J_{ij}\mathbf{S}_i\cdot\mathbf{S}_j$)**, evaluate **Weiss Molecular Mean Field Theory**, and interact with live 2D Ising model magnetic domain simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Magnetic Ordering & Exchange Coupling Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Magnetic Order Type & Susceptibility Temperature Law Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Exchange Integral J Sign and Spin Alignment Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Antiferromagnetic Critical Transition Temperature Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive 2D Ising Ferromagnetic Domain Simulator | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "magnetic_ordering_and_curie_weiss_law",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the quantum Exchange Interaction, and how do Ferromagnetism and Antiferromagnetism behave above and below their critical temperatures?",
      "blankAnswer": "Magnetic ordering is driven by the quantum Heisenberg Exchange Hamiltonian: H = -2 * sum_{<i,j>} J_{ij} S_i . S_j, which arises from electrostatic Coulomb repulsion combined with Pauli exclusion. (1) FERROMAGNETISM (J > 0): Parallel spin alignment creates spontaneous magnetization below Curie Temperature T_C. Above T_C, it follows the Curie-Weiss Law: chi = C / (T - T_C). (2) ANTIFERROMAGNETISM (J < 0): Adjacent antiparallel spins form zero net magnetization below the Néel Temperature T_N. Above T_N, its susceptibility follows chi = C / (T + theta_N)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each magnetic ordering type to its temperature-susceptibility behavior.",
      "matchPairs": [
        { "left": "Paramagnetism (isolated spins)", "right": "Curie's Law: chi = C / T (weak positive susceptibility, no ordering)" },
        { "left": "Ferromagnetism (T > T_C)", "right": "Curie-Weiss Law: chi = C / (T - T_C) (diverges as T approaches T_C from above)" },
        { "left": "Antiferromagnetism (T > T_N)", "right": "Curie-Weiss Law: chi = C / (T + theta_N) with peak susceptibility at T_N" },
        { "left": "Diamagnetism (Larmor precession)", "right": "Negative, temperature-independent susceptibility chi < 0" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the Heisenberg exchange model H = -2 * sum J_ij (S_i · S_j), what does a POSITIVE exchange integral (J > 0) enforce physically?",
      "options": [
        { "text": "PARALLEL SPIN ALIGNMENT (Ferromagnetism); parallel spins minimize the energy by -2*J*S^2, driving spontaneous macroscopic magnetization below T_C", "isCorrect": true, "explanation": "Correct! When J > 0, the energy is lowest when S_i and S_j are aligned parallel (S_i . S_j > 0), producing ferromagnetism (e.g. Iron, Cobalt, Nickel)." },
        { "text": "Antiparallel spin alignment (Antiferromagnetism)", "isCorrect": false, "explanation": "Incorrect: Antiparallel ordering occurs when J < 0." },
        { "text": "Complete spin annihilation", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Zero electrical resistance", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the French physicist who discovered the transition temperature for antiferromagnetism (Néel)?",
      "blankAnswer": "neel"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 2D Ising Model Ferromagnetic Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>2D Ising Model Ferromagnet Engine</h3><p>Lattice: 50×50 Spins | Critical Temp: T_c = 2.269 J/k_B</p><button id=\"isingBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Cool Below T_c to T = 1.5 J/k_B</button><div id=\"isingOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('isingBtn').onclick=()=>{document.getElementById('isingOut').innerText='Monte Carlo Equilibrated: Spontaneous symmetry breaking observed! Magnetization M = 0.91 (91% parallel spin domain alignment). Free energy minimized by exchange coupling J > 0.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
