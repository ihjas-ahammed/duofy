# Duofy Reusable Lesson Format: Clausius-Clapeyron Equation and Phase Equilibria

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Chemical_Thermodynamics_and_Equilibrium`  
**Lesson Format Type:** `clausius_clapeyron_equation_and_phase_equilibria`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid quantitative mastery of phase transitions and equilibrium coexistence curves on $P-T$ phase diagrams: derive the exact **Clapeyron Equation ($\frac{dP}{dT} = \frac{\Delta_{\text{trs}} S_m}{\Delta_{\text{trs}} V_m} = \frac{\Delta_{\text{trs}} H_m}{T \Delta_{\text{trs}} V_m}$)** from equality of chemical potentials ($\mu_\alpha(T,P) = \mu_\beta(T,P)$), derive the **Clausius-Clapeyron Equation ($\ln\frac{P_2}{P_1} = -\frac{\Delta_{\text{vap}} H_m}{R}(\frac{1}{T_2} - \frac{1}{T_1})$)** for liquid-vapor / solid-vapor transitions assuming ideal vapor ($V_{\text{vap}} \gg V_{\text{liq}}$), apply the **Gibbs Phase Rule ($F = C - P + 2$)**, explain the unique negative solid-liquid slope ($\frac{dP}{dT} < 0$) in water's phase diagram due to ice density anomaly ($\Delta V_{\text{fus}} < 0$), and interact with live $P-T$ phase diagram coexistence simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Phase Equilibria & Clausius-Clapeyron Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Phase Diagram Feature & Thermodynamic Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Vapor Pressure via Clausius-Clapeyron Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Gibbs Phase Rule Thermodynamic Degrees of Freedom Variable Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive P-T Phase Diagram & Boiling Point Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "clausius_clapeyron_equation_and_phase_equilibria",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the Clapeyron and Clausius-Clapeyron equations, and how does the Gibbs Phase Rule quantify phase coexistence?",
      "blankAnswer": "At any phase boundary between two phases alpha and beta, the chemical potentials are equal: mu_alpha(T,P) = mu_beta(T,P). Along the coexistence curve, d(mu_alpha) = d(mu_beta) -> -S_m,alpha dT + V_m,alpha dP = -S_m,beta dT + V_m,beta dP. This yields the exact Clapeyron Equation: dP/dT = Delta_trs S_m / Delta_trs V_m = Delta_trs H_m / (T * Delta_trs V_m). For liquid-vapor or solid-vapor transitions, assuming ideal vapor behavior and neglecting liquid volume (Delta_vap V_m ≈ V_m,gas = RT/P), substitution gives the Clausius-Clapeyron Equation: d(ln P)/dT = Delta_vap H_m / (R*T²) -> ln(P2 / P1) = -(Delta_vap H_m / R) * (1/T2 - 1/T1). The Gibbs Phase Rule states: F = C - P + 2 (Degrees of freedom F = Components C - Phases P + 2). At a single-component triple point (C=1, P=3), F = 1 - 3 + 2 = 0 (invariant point with fixed T and P)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each phase equilibrium concept to its thermodynamic formula or description.",
      "matchPairs": [
        { "left": "Exact Clapeyron Equation", "right": "dP/dT = Delta_trs H_m / (T * Delta_trs V_m) [exact slope of any phase boundary]" },
        { "left": "Integrated Clausius-Clapeyron Equation", "right": "ln(P2/P1) = -(Delta_vap H_m / R) * (1/T2 - 1/T1) [vapor pressure vs temperature]" },
        { "left": "Gibbs Phase Rule", "right": "F = C - P + 2 [governs thermodynamic degrees of freedom]" },
        { "left": "Negative Solid-Liquid Melting Slope for Water", "right": "dP/dT < 0 because ice is less dense than liquid water (Delta_fus V_m < 0)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Water has a standard enthalpy of vaporization Delta_vap H_m = 40.66 kJ/mol (40660 J/mol) and boils at P1 = 1.00 atm at T1 = 373.15 K (100°C). Using the Clausius-Clapeyron equation with R = 8.314 J/(mol K), calculate the vapor pressure P2 (in atm) of water at T2 = 353.15 K (80°C) (round to 2 decimal places).",
      "numericAnswer": 0.47,
      "numericTolerance": 0.05
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to the Gibbs phase rule F = C - P + 2, the number of thermodynamic degrees of freedom at the triple point of a pure substance is ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "2", "3"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive P-T Phase Boundary & Clausius-Clapeyron Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Clausius-Clapeyron Vapor Engine</h3><p>System: Pure Water | Atmospheric Altitude: $4000\\text{ m}$ ($P = 0.62\\text{ atm}$)</p><button id=\"ccpBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Reduced Boiling Temperature</button><div id=\"ccpOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('ccpBtn').onclick=()=>{document.getElementById('ccpOut').innerText='Thermodynamic Calculation: Using Clausius-Clapeyron with Delta_vap H = 40.66 kJ/mol: At P = 0.62 atm, 1/T_boil = 1/373.15 - (R/Delta H)*ln(0.62) -> T_boil = 359.8 K (86.7 °C). Water boils 13.3 °C lower than at sea level!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
