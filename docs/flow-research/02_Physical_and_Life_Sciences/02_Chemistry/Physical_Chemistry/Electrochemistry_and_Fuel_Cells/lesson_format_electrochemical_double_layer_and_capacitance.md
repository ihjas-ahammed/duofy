# Duofy Reusable Lesson Format: Electrochemical Double Layer and Capacitance

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Electrochemistry_and_Fuel_Cells`  
**Lesson Format Type:** `electrochemical_double_layer_and_capacitance`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid conceptual, mathematical, and model-based mastery of the electrified interface and the electrochemical double layer (EDL): trace the historical evolution of EDL models (**Helmholtz Model**: rigid parallel-plate capacitor with differential capacitance $C_H = \frac{\varepsilon_r \varepsilon_0}{d}$; **Gouy-Chapman Model**: diffuse thermal ion cloud with potential decay $\phi(x) = \phi_0 e^{-\kappa x}$ and Debye length $\kappa^{-1} = \sqrt{\frac{\varepsilon_r \varepsilon_0 RT}{2 F^2 I}}$; **Stern-Grahame Model**: series combination of compact Inner/Outer Helmholtz Planes (IHP, OHP) and diffuse layer with $\frac{1}{C_{\text{total}}} = \frac{1}{C_H} + \frac{1}{C_{\text{diff}}}$), formulate the **Potential of Zero Charge (PZC)**, evaluate supercapacitor energy storage ($E = \frac{1}{2} C V^2$), and interact with live double-layer potential profile simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Electrochemical Double Layer Models Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Double Layer Model & Physical Feature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Debye Screening Length in Electrolyte Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Point of Zero Net Interfacial Electrode Charge Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Electrochemical Double Layer Potential Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "electrochemical_double_layer_and_capacitance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do the Helmholtz, Gouy-Chapman, and Stern models describe the structure and capacitance of the Electrochemical Double Layer (EDL)?",
      "blankAnswer": "When an electrode is immersed in an electrolyte, excess surface charge is electrostatically counterbalanced by ions in solution, creating the Electrochemical Double Layer (EDL): (1) Helmholtz Model (1853): Assumes a rigid monolayer of solvated counter-ions at distance d (Outer Helmholtz Plane, OHP), behaving like a parallel-plate capacitor with constant capacitance C_H = (epsilon_r * epsilon_0) / d (~10-40 uF/cm²). (2) Gouy-Chapman Model (1910): Incorporates thermal motion, creating a diffuse exponential ion atmosphere with Debye screening length kappa^-1 = sqrt(epsilon_r*epsilon_0*RT / (2*F²*I)), giving a V-shaped capacitance minimum at the Potential of Zero Charge (PZC). (3) Stern-Grahame Model (1924, 1947): Combines both! A rigid compact Helmholtz layer (IHP with specifically adsorbed ions + OHP) is in SERIES with the diffuse Gouy-Chapman layer: 1/C_total = 1/C_H + 1/C_diff. In concentrated solutions (> 0.1 M), C_diff is huge, so C_total ≈ C_H!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Electrochemical Double Layer model to its physical description.",
      "matchPairs": [
        { "left": "Helmholtz Model", "right": "Rigid parallel-plate capacitor of solvated counter-ions at distance d; constant capacitance C_H" },
        { "left": "Gouy-Chapman Model", "right": "Diffuse thermal ion cloud with exponential potential decay governed by Debye length kappa^-1" },
        { "left": "Stern-Grahame Model", "right": "Series combination of compact inner/outer Helmholtz planes (IHP/OHP) and diffuse layer: 1/C = 1/C_H + 1/C_diff" },
        { "left": "Potential of Zero Charge (PZC)", "right": "Electrode potential at which the excess surface charge density q_electrode is exactly zero" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "In an aqueous 1:1 electrolyte (such as NaCl) at 298 K, the Debye screening length is given by kappa^-1 = 0.304 / sqrt(I) nanometers, where I is ionic strength in mol/L. Calculate the Debye length kappa^-1 (in nanometers) for a 0.010 M NaCl solution: kappa^-1 = 0.304 / sqrt(0.010) (round to 2 decimal places).",
      "numericAnswer": 3.04,
      "numericTolerance": 0.05
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The specific electrode potential at which the excess electrical charge on the metal surface is exactly zero is called the potential of zero ___ (PZC).",
      "blankAnswer": "charge",
      "blankDistractors": ["mass", "entropy", "diffusion"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Electrochemical Double Layer Potential Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Electrochemical Double Layer (EDL) Engine</h3><p>Electrolyte: $0.10\\text{ M KCl}$ in $\\text{H}_2\\text{O}$ | Applied Electrode Potential: $+0.30\\text{ V}$ vs PZC</p><button id=\"edlBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute Stern Double Layer Profile</button><div id=\"edlOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('edlBtn').onclick=()=>{document.getElementById('edlOut').innerText='EDL Solution: (1) Compact Helmholtz Layer (OHP at d = 3.5 Å): Potential drops linearly from +0.30 V to +0.08 V (C_H = 20.0 uF/cm²). (2) Diffuse Gouy-Chapman Layer (Debye length = 0.96 nm): Potential decays exponentially from +0.08 V to 0.00 V in bulk solution. Total Interfacial Capacitance C_total = 18.2 uF/cm²!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
