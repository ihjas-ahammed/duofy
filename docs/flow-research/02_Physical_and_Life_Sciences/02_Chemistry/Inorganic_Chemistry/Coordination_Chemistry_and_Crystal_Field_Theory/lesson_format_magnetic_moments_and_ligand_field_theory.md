# Duofy Reusable Lesson Format: Magnetic Moments and Ligand Field Theory

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Coordination_Chemistry_and_Crystal_Field_Theory`  
**Lesson Format Type:** `magnetic_moments_and_ligand_field_theory`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of coordination complex magnetism and optical spectroscopy: formulate the **Spin-Only Magnetic Moment Formula ($\mu_{\text{eff}} = \sqrt{n(n+2)}\ \mu_{\text{B}}$)** where $n$ is the number of unpaired electrons and $\mu_{\text{B}} = \frac{e\hbar}{2m_e}$ is the Bohr Magneton ($9.274 \times 10^{-24}\text{ J/T}$), distinguish between **Paramagnetism, Diamagnetism, Ferromagnetism, and Antiferromagnetism**, apply the Gouy balance and Evans NMR method, evaluate the **Laporte Parity Selection Rule ($\Delta l = \pm 1$, $g \not\to g$)** and **Spin Selection Rule ($\Delta S = 0$)**, and interact with live Gouy balance magnetic susceptibility simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Magnetic Moments & Optical Selection Rules Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Unpaired Electron Count n & Spin-Only Magnetic Moment Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Spin-Only Magnetic Moment Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Centrosymmetric d-to-d Transition Laporte Rule Status Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Gouy Balance Magnetic Susceptibility Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "magnetic_moments_and_ligand_field_theory",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Spin-Only Magnetic Moment formula, and why are d-d optical transitions Laporte forbidden?",
      "blankAnswer": "For 3d transition metal complexes where orbital angular momentum is largely quenched by the crystal field, the effective magnetic moment is given by the Spin-Only formula: mu_eff = sqrt(n * [n + 2]) mu_B (Bohr Magnetons, where n is the number of unpaired electrons; e.g. n=1 -> 1.73 mu_B, n=2 -> 2.83 mu_B, n=3 -> 3.87 mu_B, n=4 -> 4.90 mu_B, n=5 -> 5.92 mu_B). Optical d-d transitions in octahedral (centrosymmetric) complexes are governed by selection rules: (1) Spin Rule (Delta S = 0; spin-forbidden transitions have eps < 1), and (2) Laporte Parity Rule (Delta l = +/- 1; g -> g transitions are Laporte forbidden, keeping molar absorptivity weak, eps ~ 1-50, relaxed slightly by vibronic coupling)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each number of unpaired electrons n to its exact spin-only magnetic moment in Bohr Magnetons (mu_B).",
      "matchPairs": [
        { "left": "n = 1 unpaired electron (e.g. Cu2+ d9, Ti3+ d1)", "right": "1.73 mu_B [sqrt(1 * 3)]" },
        { "left": "n = 2 unpaired electrons (e.g. Ni2+ d8, V3+ d2)", "right": "2.83 mu_B [sqrt(2 * 4)]" },
        { "left": "n = 3 unpaired electrons (e.g. Cr3+ d3)", "right": "3.87 mu_B [sqrt(3 * 5)]" },
        { "left": "n = 5 unpaired electrons (e.g. High-spin Fe3+ / Mn2+ d5)", "right": "5.92 mu_B [sqrt(5 * 7)]" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Calculate the theoretical spin-only magnetic moment mu_eff (in Bohr Magnetons, mu_B) for a high-spin octahedral Cr(II) complex (d4, n = 4 unpaired electrons): mu_eff = sqrt(4 * (4 + 2)) = sqrt(24) (round to 2 decimal places).",
      "numericAnswer": 4.90,
      "numericTolerance": 0.05
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In centrosymmetric octahedral complexes, pure d-to-d electronic transitions are Laporte-___ because the initial and final states have the same parity (g to g).",
      "blankAnswer": "forbidden",
      "blankDistractors": ["allowed", "infinite", "instantaneous"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Gouy Balance Magnetic Susceptibility Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Gouy Balance Magnetic Engine</h3><p>Sample: High-spin $[\\text{Fe}(\\text{H}_2\\text{O})_6]^{2+}$ ($d^6, n = 4\\text{ unpaired } e^-$)</p><button id=\"gbBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Strong Magnetic Field Gradient ($B_0 = 1.5\\text{ T}$)</button><div id=\"gbOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('gbBtn').onclick=()=>{document.getElementById('gbOut').innerText='Paramagnetic Attraction Detected: Sample pulled strongly into magnetic field gradient! Measured apparent mass increase Delta m = +142.5 mg. Calculated molar susceptibility chi_m = 1.25 × 10⁻² cm³/mol. Effective magnetic moment: mu_eff = 4.92 mu_B (Confirms high-spin d6 configuration with n = 4 unpaired electrons).'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
