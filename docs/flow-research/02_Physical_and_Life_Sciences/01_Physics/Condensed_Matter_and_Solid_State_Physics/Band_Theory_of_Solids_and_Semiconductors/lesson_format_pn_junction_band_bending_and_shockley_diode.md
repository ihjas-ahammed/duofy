# Duofy Reusable Lesson Format: P-N Junction Band Bending and the Shockley Diode

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Band_Theory_of_Solids_and_Semiconductors`  
**Lesson Format Type:** `pn_junction_band_bending_and_shockley_diode`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of semiconductor device physics: formulate **P-N Junction Equilibrium** and **Fermi Level Alignment**, analyze **Band Bending** and the **Space Charge Depletion Region**, derive the **Built-in Potential ($V_{bi} = \frac{k_BT}{q}\ln\frac{N_A N_D}{n_i^2}$)**, evaluate the **Shockley Ideal Diode Equation ($I = I_s(e^{qV/k_BT} - 1)$)**, and interact with live p-n junction forward/reverse bias band diagram simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | P-N Junction & Band Bending Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | P-N Junction Bias State & Barrier Height Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Forward Bias Diode Current Conduction Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Insulating Fixed-Ion Interface Zone Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive P-N Junction Band Bending & I-V Diode Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pn_junction_band_bending_and_shockley_diode",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is band bending and built-in potential in a P-N Junction, and what is the Shockley Diode Equation?",
      "blankAnswer": "When p-type and n-type semiconductors contact, electrons diffuse from n to p and holes diffuse from p to n, leaving uncompensated ionized donors (N_D+) and acceptors (N_A-) that create a DEPLETION REGION with an internal electric field. At equilibrium, the Fermi level E_F must be flat (constant throughout), bending the conduction and valence bands by the Built-in Potential: V_{bi} = (k_B*T / q) * ln(N_A * N_D / n_i^2) ≈ 0.7 V for Silicon. Under applied bias V, the barrier becomes q(V_{bi} - V), yielding the Shockley Ideal Diode Equation: I = I_s * [exp(q*V / (k_B*T)) - 1]."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each P-N junction bias state to its depletion region and barrier behavior.",
      "matchPairs": [
        { "left": "Thermal Equilibrium (V = 0)", "right": "Depletion width W_0, potential barrier q*V_{bi}, zero net current (diffusion balances drift)" },
        { "left": "Forward Bias (V > 0 on p-side)", "right": "Barrier lowers to q*(V_{bi} - V), depletion region NARROWS, exponential current injection" },
        { "left": "Reverse Bias (V < 0 on p-side)", "right": "Barrier increases to q*(V_{bi} + |V|), depletion region WIDENS, tiny reverse saturation current -I_s" },
        { "left": "Zener / Avalanche Breakdown", "right": "Large reverse voltage causes quantum tunneling or impact ionization avalanche multiplication" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does a P-N junction diode conduct large exponential electric current under forward bias (positive voltage applied to the p-type anode)?",
      "options": [
        { "text": "Forward bias LOWERS the built-in potential barrier from q*V_{bi} to q*(V_{bi} - V), allowing abundant majority carriers (electrons in n-side, holes in p-side) to overcome the barrier and diffuse across the junction exponentially: I ∝ exp(qV / k_B T)", "isCorrect": true, "explanation": "Correct! Applying positive potential to p-side opposes the built-in electric field, reducing the barrier height and narrowing the depletion region so that majority carriers easily diffuse across." },
        { "text": "Forward bias turns silicon into copper", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It removes all electrons from the crystal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The band gap expands to infinity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the two-word term for the insulating region stripped of free mobile carriers near the p-n metallurgical interface (depletion region)?",
      "blankAnswer": "depletion region"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive P-N Junction Band Bending & I-V Diode Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Silicon P-N Junction Diode Engine</h3><p>Doping: N_A = 10¹⁷ cm⁻³, N_D = 10¹⁶ cm⁻³ | V_{bi} = 0.75 V</p><button id=\"diodeBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Forward Bias V = +0.65 V</button><div id=\"diodeOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('diodeBtn').onclick=()=>{document.getElementById('diodeOut').innerText='Forward Bias Result: Barrier reduced to q(0.75 - 0.65) = 0.10 eV! Depletion width narrowed from 320 nm to 117 nm. Forward injection current I = 1.25 mA. Diode is actively ON.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
