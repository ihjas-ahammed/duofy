# Duofy Reusable Lesson Format: Woodward-Fieser Rules and Electronic Transitions

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Infrared_IR_and_UV_Vis_Spectroscopy`  
**Lesson Format Type:** `woodward_fieser_rules_and_electronic_transitions`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of electronic transitions and semi-empirical UV-Vis spectral prediction: classify molecular orbital electronic transitions ($\sigma \to \sigma^*$, $n \to \sigma^*$, $\pi \to \pi^*$, $n \to \pi^*$), define **Chromophores and Auxochromes**, analyze **Bathochromic (Red) vs Hypsochromic (Blue) shifts** and **Hyperchromic vs Hypochromic intensity changes**, calculate predicted wavelengths of maximum absorption ($\lambda_{\text{max}}$) for conjugated dienes and $\alpha,\beta$-unsaturated enones using the **Woodward-Fieser Rules (Robert Burns Woodward 1941, Louis Fieser 1959)**, and interact with live conjugated diene $\lambda_{\text{max}}$ calculation simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Electronic Transitions & Woodward-Fieser Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Spectral Shift Term & Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Conjugated Diene Woodward-Fieser Lambda_max Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Extended Conjugation Increment in Woodward-Fieser Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Woodward-Fieser Diene Lambda_max Calculator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "woodward_fieser_rules_and_electronic_transitions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the primary electronic transitions in UV-Vis spectroscopy, and how do the Woodward-Fieser Rules predict lambda_max?",
      "blankAnswer": "UV-Vis absorption excites valence electrons across molecular orbitals: (1) pi -> pi* (strong absorption, epsilon > 10,000, e.g. alkenes, aromatics), (2) n -> pi* (symmetry forbidden, weak epsilon ~ 10-100, e.g. carbonyl n-electrons). Conjugation compresses the HOMO-LUMO energy gap Delta E = hc/lambda, causing a Bathochromic (red) shift to longer wavelengths. The Woodward-Fieser Rules (1941-1959) calculate predicted lambda_max for conjugated dienes by summing incremental contributions: (1) Base Diene: Acyclic / Heteroannular = 214 nm, Homoannular (cisoid in one ring) = 253 nm. (2) Increments: Extended Conjugation (+30 nm per extra double bond), Alkyl substituent / Ring residue (+5 nm each), Exocyclic double bond (+5 nm), Polar auxochromes (-OCOCH3 = 0, -OR = +6, -SR = +30, -NR2 = +60 nm)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each spectroscopic shift term to its physical effect on UV-Vis absorption.",
      "matchPairs": [
        { "left": "Bathochromic Shift (Red Shift)", "right": "Shift of lambda_max to LONGER wavelength / lower energy (caused by extended conjugation)" },
        { "left": "Hypsochromic Shift (Blue Shift)", "right": "Shift of lambda_max to SHORTER wavelength / higher energy (e.g. protonation of aniline)" },
        { "left": "Hyperchromic Effect", "right": "INCREASE in molar absorptivity epsilon (taller absorption peak, e.g. DNA denaturation)" },
        { "left": "Hypochromic Effect", "right": "DECREASE in molar absorptivity epsilon (shorter absorption peak)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Using the Woodward-Fieser rules, calculate the predicted lambda_max (in nm) for 1,2-dimethylcyclohexadiene (a homoannular diene with base = 253 nm, containing 2 ring residues at +5 nm each, and 2 alkyl substituents at +5 nm each): lambda_max = 253 + 2*(5) + 2*(5) nm.",
      "numericAnswer": 273,
      "numericTolerance": 1
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Woodward-Fieser rules for conjugated polyenes, each additional double bond extending conjugation adds ___ nm to the base wavelength.",
      "blankAnswer": "30",
      "blankDistractors": ["15", "5", "50"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Woodward-Fieser UV-Vis Calculator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Woodward-Fieser Spectral Engine</h3><p>Compound: Ergosterol Derivative (Homoannular Diene with 1 Extended Double Bond)</p><button id=\"wfBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Predicted $\\lambda_{\\text{max}}$</button><div id=\"wfOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('wfBtn').onclick=()=>{document.getElementById('wfOut').innerText='Woodward-Fieser Summation: Base Homoannular = 253 nm + Extended Conjugation (+30 nm) + 3 Ring Residues (3 × 5 = +15 nm) + 1 Exocyclic Bond (+5 nm) = Predicted λ_max = 303 nm (Deep UV absorption). Matches experimental λ_max = 305 nm within 2 nm!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
