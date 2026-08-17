# Duofy Reusable Lesson Format: Diatomic Molecular Orbitals and Bond Order

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Quantum_Chemistry_and_Molecular_Orbital_Theory`  
**Lesson Format Type:** `diatomic_molecular_orbitals_and_bond_order`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid quantitative mastery of homonuclear and heteronuclear diatomic molecular orbital diagrams, electronic configurations, and magnetic states: construct MO energy levels for Period 2 diatomics ($\sigma_{2s}, \sigma_{2s}^*, \pi_{2p_x} = \pi_{2p_y}, \sigma_{2p_z}, \pi_{2p_x}^* = \pi_{2p_y}^*, \sigma_{2p_z}^*$), evaluate **$s-p$ Orbital Mixing** ($B_2, C_2, N_2$ with $\pi_{2p} < \sigma_{2p}$ vs $O_2, F_2$ with normal ordering $\sigma_{2p} < \pi_{2p}$), calculate **Bond Order ($\text{BO} = \frac{N_b - N_a}{2}$)**, explain the **Ground-State Paramagnetism of Dioxygen ($\text{O}_2$, triplet $^3\Sigma_g^-$ with 2 unpaired electrons in degenerate $\pi_{2p}^*$ orbitals)**, analyze heteronuclear diatomics ($\text{CO}$ Frontier MOs: carbon-centered HOMO $\sigma_{2s+2p_z}$ and $\pi^*$ LUMO), and interact with live diatomic MO orbital filling simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Diatomic MO Diagrams & Bond Order Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Diatomic Molecule & MO Bond Order / Magnetic State Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Dioxygen MO Bond Order Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Two Unpaired Electron Net Magnetic Property Descriptor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Diatomic MO Electron Filling & Bond Order Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "diatomic_molecular_orbitals_and_bond_order",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does Molecular Orbital (MO) Theory explain the bond order, s-p mixing, and paramagnetism of homonuclear diatomics like O2 and N2?",
      "blankAnswer": "Molecular orbitals for Period 2 diatomics are built from valence 2s and 2p atomic orbitals: (1) s-p Mixing (B2, C2, N2): Small 2s-2p energy gap causes strong mixing, pushing sigma_2p ABOVE pi_2p (Ordering: sigma_2s < sigma*_2s < pi_2p_x = pi_2p_y < sigma_2p_z < pi*_2p_x = pi*_2p_y < sigma*_2p_z). (2) Normal Ordering (O2, F2): Large 2s-2p energy gap eliminates mixing (Ordering: sigma_2s < sigma*_2s < sigma_2p_z < pi_2p_x = pi_2p_y < pi*_2p_x = pi*_2p_y < sigma*_2p_z). (3) Bond Order: BO = (N_bonding - N_antibonding) / 2 (e.g. N2 has BO = (8-2)/2 = 3, diamagnetic). (4) Paramagnetism of O2: O2 has 12 valence electrons -> (sigma_2s)² (sigma*_2s)² (sigma_2p_z)² (pi_2p)⁴ (pi*_2p_x)¹ (pi*_2p_y)¹. By Hund's rule, the 2 highest electrons enter degenerate pi* orbitals with parallel spins, creating a paramagnetic triplet ground state (³Sigma_g⁻) with Bond Order = (8-4)/2 = 2!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each diatomic species to its MO bond order and magnetic behavior.",
      "matchPairs": [
        { "left": "Dinitrogen Molecule (N2)", "right": "Bond Order = 3.0; diamagnetic closed shell with filled pi_2p and sigma_2p bonding orbitals" },
        { "left": "Dioxygen Molecule (O2)", "right": "Bond Order = 2.0; paramagnetic with 2 unpaired electrons in degenerate pi*_2p orbitals" },
        { "left": "Superoxide Anion (O2⁻)", "right": "Bond Order = 1.5; paramagnetic with 1 unpaired electron in pi*_2p (3 electrons in pi*)" },
        { "left": "Carbon Monoxide (CO)", "right": "Bond Order = 3.0; diamagnetic isoelectronic to N2 with carbon-polarized HOMO sigma-lone pair" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "In ground-state neutral dioxygen (O2), there are 8 valence bonding electrons and 4 valence antibonding electrons. Calculate its bond order: BO = (8 - 4) / 2 (enter the exact number).",
      "numericAnswer": 2,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because ground-state O2 possesses two unpaired electrons in degenerate pi* orbitals, liquid oxygen is strongly attracted to a magnetic field, exhibiting ___ behavior.",
      "blankAnswer": "paramagnetic",
      "blankDistractors": ["diamagnetic", "ferroelectric", "piezoelectric"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Diatomic MO Filling & Bond Order Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Diatomic Molecular Orbital Builder</h3><p>Diatomic System: $\\text{O}_2$ (12 Valence Electrons) | Energy Ordering: $\\sigma_{2p} < \\pi_{2p} < \\pi_{2p}^* < \\sigma_{2p}^*$</p><button id=\"moBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Fill 12 Valence Electrons via Aufbau & Hund</button><div id=\"moOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('moBtn').onclick=()=>{document.getElementById('moOut').innerText='Configuration: (sigma_2s)² (sigma*_2s)² (sigma_2p_z)² (pi_2p_x)² (pi_2p_y)² (pi*_2p_x)¹ (pi*_2p_y)¹\\nBonding Electrons = 8 | Antibonding Electrons = 4\\nBond Order = (8 - 4) / 2 = 2.0 (Double Bond)\\nMagnetic State: Paramagnetic (2 unpaired parallel electron spins; Triplet ground state ³Sigma_g⁻)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
