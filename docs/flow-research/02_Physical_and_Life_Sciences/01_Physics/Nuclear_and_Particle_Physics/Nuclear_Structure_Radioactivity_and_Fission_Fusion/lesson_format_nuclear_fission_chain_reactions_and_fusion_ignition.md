# Duofy Reusable Lesson Format: Nuclear Fission Chain Reactions and Fusion Ignition

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Nuclear_and_Particle_Physics / Nuclear_Structure_Radioactivity_and_Fission_Fusion`  
**Lesson Format Type:** `nuclear_fission_chain_reactions_and_fusion_ignition`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of nuclear energy reactions: evaluate thermal neutron-induced **Nuclear Fission ($^{235}\text{U} + n \to \text{fragments} + 2.5 n + 200\text{ MeV}$)**, calculate the **Neutron Multiplication Factor $k$** (subcritical $k < 1$, critical $k = 1$, supercritical $k > 1$), analyze the role of **Delayed Neutrons ($\beta \approx 0.65\%$)** in nuclear reactor control, evaluate thermonuclear **Fusion Reactions** (D-T fusion: $^{2}\text{H} + \,^{3}\text{H} \to \,^{4}\text{He} + n + 17.6\text{ MeV}$), formulate the **Lawson Criterion for Fusion Ignition ($n T \tau_E \ge 3 \times 10^{21}\text{ keV}\cdot\text{s/m}^3$)**, and interact with live nuclear reactor control rod / fusion plasma simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fission Chain Reactions & Fusion Ignition Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Nuclear Reaction / Parameter & Physical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical D-T Fusion Energy Release Calculation in MeV | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Fusion Reactor Power Breakeven Ignition Criteria Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Nuclear Reactor Control Rod Criticality Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nuclear_fission_chain_reactions_and_fusion_ignition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do Nuclear Fission Chain Reactions sustain power, and what is the Lawson Criterion for Thermonuclear Fusion ignition?",
      "blankAnswer": "In Nuclear Fission, a thermal neutron splits a fissile nucleus (like U-235), releasing ~200 MeV and ~2.5 prompt neutrons. The chain reaction is governed by the effective neutron multiplication factor k: k < 1 (subcritical), k = 1 (critical, steady state), k > 1 (supercritical). Nuclear reactors are safely controlled on delayed neutrons (emitted seconds later by fission fragments). In Thermonuclear Fusion, light isotopes fuse at temperatures >100 million K (e.g. Deuterium-Tritium: 2H + 3H -> 4He (3.5 MeV) + n (14.1 MeV) + 17.6 MeV). Ignition occurs when alpha particle self-heating exceeds all plasma losses, governed by the Lawson Criterion: n * T * tau_E >= 3 * 10^21 keV * s / m^3!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each nuclear energy parameter to its physical role.",
      "matchPairs": [
        { "left": "Neutron Multiplication Factor k = 1.000", "right": "Critical state where fission rate and reactor power output remain perfectly constant" },
        { "left": "Delayed Neutrons (beta ≈ 0.65%)", "right": "Provides a ~10-second response window allowing mechanical control rods to safely regulate reactors" },
        { "left": "D-T Fusion Energy Release (17.6 MeV)", "right": "High-yield reaction between Deuterium and Tritium producing 4He + 14.1 MeV fast neutron" },
        { "left": "Triple Product n * T * tau_E", "right": "Lawson criterion parameter combining plasma density, temperature, and energy confinement time" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "In a single Deuterium-Tritium (D-T) fusion reaction (2H + 3H -> 4He + n), the total energy released is 17.6 MeV. By conservation of momentum, the lighter neutron receives what fraction of the energy? Calculate the neutron kinetic energy in MeV (round to 1 decimal place).",
      "numericAnswer": 14.1,
      "numericTolerance": 0.2
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the British physicist who formulated the triple-product criterion for fusion energy breakeven (Lawson)?",
      "blankAnswer": "lawson"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Nuclear Reactor Criticality Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Nuclear Reactor Core Criticality Engine</h3><p>Fuel: UO₂ (3.5% U-235) | Moderator: Light Water | Target: k_eff = 1.000</p><button id=\"fissBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Adjust Control Rods to Criticality</button><div id=\"fissOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('fissBtn').onclick=()=>{document.getElementById('fissOut').innerText='Reactor Status: Control rods positioned at 62% insertion. k_eff = 1.0000 ± 0.0002. Delayed neutron fraction β = 0.0065 active. Thermal power stable at 3,000 MWth (1,000 MWe output). Steady-state operation achieved!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
