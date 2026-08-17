# Duofy Reusable Lesson Format: Fresnel Equations and Skin Depth in Conductors

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Maxwell_Equations_and_Electromagnetic_Waves`  
**Lesson Format Type:** `fresnel_equations_and_skin_depth_in_conductors`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of electromagnetic waves in matter and across boundaries: formulate the **Fresnel Equations (Augustin-Jean Fresnel, 1823)** for s-polarized (TE) and p-polarized (TM) light at dielectric interfaces, calculate **Brewster's Polarization Angle ($\tan\theta_B = \frac{n_2}{n_1}$)** and **Total Internal Reflection Critical Angle ($\sin\theta_c = \frac{n_2}{n_1}$)**, solve wave propagation in Ohmic conductors ($\mathbf{J} = \sigma\mathbf{E}$), derive the **Skin Depth ($\delta = \sqrt{\frac{2}{\mu\sigma\omega}}$)**, and interact with live Fresnel reflectance and skin depth simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fresnel Equations & Skin Depth Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Optical Interface Phenomenon & Governing Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Brewster's Angle Calculation for Glass (n=1.5) | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Perfect TM Polarization Transmission Angle Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Fresnel Reflection & Conductor Skin Depth Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fresnel_equations_and_skin_depth_in_conductors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the Fresnel Equations, Brewster's Angle, and the Skin Depth in Ohmic conductors?",
      "blankAnswer": "The Fresnel Equations (1823) calculate reflection and transmission amplitude coefficients (r_s, r_p, t_s, t_p) for polarized light across a dielectric interface: for TM/p-polarization, reflection vanishes completely (r_p = 0) at Brewster's Angle tan(theta_B) = n_2 / n_1, producing 100% polarized reflected light. In an Ohmic conductor with conductivity sigma (J = sigma*E), the wavevector becomes complex k_c = k_R + i*k_I, causing the electromagnetic wave amplitude to attenuate exponentially as E(z) = E_0 * e^{-z / delta} * cos(k_R*z - omega*t), where the characteristic penetration distance is the Skin Depth: delta = sqrt(2 / (mu * sigma * omega))."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each boundary/wave phenomenon to its physical formula.",
      "matchPairs": [
        { "left": "Brewster's Polarizing Angle theta_B", "right": "tan(theta_B) = n_2 / n_1 (reflected ray is 100% s-polarized; reflected and transmitted rays are at 90°)" },
        { "left": "Critical Angle for Total Internal Reflection", "right": "sin(theta_c) = n_2 / n_1 (occurs only when n_1 > n_2)" },
        { "left": "Conductor Skin Depth delta", "right": "delta = sqrt(2 / (mu * sigma * omega)) (depth where amplitude drops to 1/e)" },
        { "left": "Normal Incidence Reflectance R", "right": "R = |(n_1 - n_2) / (n_1 + n_2)|^2" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Calculate Brewster's angle theta_B (in degrees) for light incident from air (n_1 = 1.0) onto crown glass (n_2 = 1.50): theta_B = arctan(1.50 / 1.00) (round to nearest whole degree).",
      "numericAnswer": 56,
      "numericTolerance": 1
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the Scottish physicist who discovered the angle of zero reflection for p-polarized light (Brewster)?",
      "blankAnswer": "brewster"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Fresnel & Conductor Skin Depth Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Electrodynamics Interface Engine</h3><p>Medium: Copper (σ = 5.96 × 10⁷ S/m) | Frequency: f = 1.0 GHz</p><button id=\"emBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Skin Depth & Brewster Angle</button><div id=\"emOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('emBtn').onclick=()=>{document.getElementById('emOut').innerText='Results: Skin Depth δ = √(2 / [μ₀ σ 2π f]) = 2.06 μm (microns!). EM microwave power is 99.9% absorbed/reflected within top 6 μm. For glass (n = 1.5), Brewster Angle θ_B = 56.31°.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
