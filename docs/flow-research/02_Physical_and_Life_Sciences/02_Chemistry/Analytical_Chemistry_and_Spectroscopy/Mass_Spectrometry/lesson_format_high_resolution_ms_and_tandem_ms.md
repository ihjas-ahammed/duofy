# Duofy Reusable Lesson Format: High-Resolution MS and Tandem MS

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Mass_Spectrometry`  
**Lesson Format Type:** `high_resolution_ms_and_tandem_ms`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of high-precision molecular mass determination and structural sequencing: formulate **Mass Resolving Power ($R = \frac{m}{\Delta m_{\text{FWHM}}}$)** in **High-Resolution Mass Spectrometry (HRMS)** (Orbitrap, FT-ICR), distinguish isobaric molecular formulas via **Exact Isotopic Mass Defect ($\Delta M = M_{\text{exact}} - A$)**, calculate mass accuracy in parts per million ($\text{ppm} = \frac{|M_{\text{obs}} - M_{\text{calc}}|}{M_{\text{calc}}} \times 10^6 \le 5\text{ ppm}$), formulate **Tandem Mass Spectrometry (MS/MS or $\text{MS}^n$)** with **Collision-Induced Dissociation (CID)** in triple quadrupoles (QqQ, Multiple Reaction Monitoring MRM) and ion traps, and interact with live isobaric compound resolution and peptide sequencing simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | HRMS & Tandem MS/MS Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Tandem MS Scan Mode & Analytical Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical HRMS Mass Accuracy in Parts Per Million Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Exact Mass Standard Reference Carbon-12 Isotope Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive HRMS Isobaric Separation & Mass Defect Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "high_resolution_ms_and_tandem_ms",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is High-Resolution Mass Spectrometry (HRMS), and how does Tandem MS (MS/MS) achieve trace quantification and sequencing?",
      "blankAnswer": "High-Resolution Mass Spectrometry (HRMS; e.g. Orbitrap, FT-ICR, Q-TOF) provides mass resolving power R = m / Delta m > 50,000 - 1,000,000, measuring m/z to 4-5 decimal places. Because each element has a unique nuclear Mass Defect (e.g. 1H = 1.00783 Da, 12C = 12.00000 Da, 14N = 14.00307 Da, 16O = 15.99491 Da), HRMS unambiguously distinguishes ISOBARIC compounds with identical nominal mass (e.g. CO = 27.9944 Da vs N2 = 28.0061 Da vs C2H4 = 28.0313 Da; Delta = 0.0369 Da!). Tandem MS (MS/MS, such as Triple Quadrupole QqQ) uses Collision-Induced Dissociation (CID): Q1 selects a precursor ion, Q2 fragments it with inert gas (Ar/N2), and Q3 detects specific product ions (Multiple Reaction Monitoring MRM), achieving sub-picogram quantification in biological fluids!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Tandem MS (MS/MS) scan mode to its operational mechanism.",
      "matchPairs": [
        { "left": "Product Ion Scan (MS2)", "right": "Q1 fixes precursor ion, collision cell fragments it, Q3 scans all resulting product ions" },
        { "left": "Precursor Ion Scan", "right": "Q1 scans all parent ions, collision cell fragments them, Q3 fixes on one specific diagnostic fragment" },
        { "left": "Selected / Multiple Reaction Monitoring (SRM/MRM)", "right": "Q1 fixes on precursor and Q3 fixes on product ion (maximum sensitivity and speed for drug quantitation)" },
        { "left": "Neutral Loss Scan", "right": "Q1 and Q3 scan simultaneously with a fixed mass offset Delta m (detects common losses like -18 H2O or -80 HPO3)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "An unknown pharmaceutical compound with theoretical exact formula mass M_calc = 345.1472 Da is measured on an Orbitrap HRMS, giving an observed experimental mass M_obs = 345.1481 Da. Calculate the mass measurement error in parts per million (ppm): ppm = (|M_obs - M_calc| / M_calc) * 10^6 (round to 1 decimal place).",
      "numericAnswer": 2.6,
      "numericTolerance": 0.2
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By international IUPAC definition, the atomic mass scale is anchored to the carbon-___ isotope having an exact mass of exactly 12.000000 Da.",
      "blankAnswer": "12",
      "blankDistractors": ["14", "13", "1"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive HRMS Isobaric Separation Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>High-Resolution MS Mass Defect Engine</h3><p>Nominal Mass: $m/z = 28$ (Isobaric Mixture of $\\text{N}_2$, $\\text{CO}$, and $\\text{C}_2\\text{H}_4$)</p><button id=\"hrmsBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Increase Orbitrap Resolving Power to R = 100,000</button><div id=\"hrmsOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('hrmsBtn').onclick=()=>{document.getElementById('hrmsOut').innerText='Ultra-High Resolution Achieved: Single nominal peak at m/z = 28 cleanly resolved into 3 distinct baseline peaks: (1) Carbon Monoxide CO = 27.9944 Da, (2) Nitrogen Gas N2 = 28.0061 Da, (3) Ethylene C2H4 = 28.0313 Da. Molecular formulas uniquely assigned via nuclear mass defects!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
