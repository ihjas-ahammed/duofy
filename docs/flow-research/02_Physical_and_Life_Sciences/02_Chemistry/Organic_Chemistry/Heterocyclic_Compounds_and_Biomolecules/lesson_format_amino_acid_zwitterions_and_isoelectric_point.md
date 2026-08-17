# Duofy Reusable Lesson Format: Amino Acid Zwitterions and Isoelectric Point

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Heterocyclic_Compounds_and_Biomolecules`  
**Lesson Format Type:** `amino_acid_zwitterions_and_isoelectric_point`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid quantitative mastery of amino acid acid-base equilibria, zwitterionic chemistry, and electrophoresis: formulate the **Zwitterion Dipolar Ion ($^+\text{H}_3\text{N}-\text{CHR}-\text{COO}^-$)**, calculate the **Isoelectric Point ($\text{pI}$)** for neutral, acidic (Asp, Glu), and basic (Lys, Arg, His) amino acids by averaging the two $\text{p}K_a$ values that bracket the net-neutral species, evaluate **Gel Electrophoresis Migration Direction** ($\text{pH} < \text{pI} \implies$ net $+1$ cation moving toward negative cathode; $\text{pH} > \text{pI} \implies$ net $-1$ anion moving toward positive anode), and interact with live amino acid titration and isoelectric focusing simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Amino Acid Zwitterions & Isoelectric Point Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Amino Acid Class & pI Calculation Method Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Glutamic Acid Isoelectric Point Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Gel Electrophoresis Low pH Cation Migration Electrode Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Amino Acid Titration & Electrophoresis Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "amino_acid_zwitterions_and_isoelectric_point",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is an amino acid zwitterion, and how do you calculate the Isoelectric Point (pI) for neutral, acidic, and basic amino acids?",
      "blankAnswer": "At physiological pH (~7.4), an amino acid exists as a dipolar Zwitterion (+H3N-CHR-COO-) with a positively charged ammonium group and a negatively charged carboxylate, giving zero net charge. The Isoelectric Point (pI) is the precise pH at which the average net charge of the amino acid is exactly ZERO: (1) Neutral Amino Acids (Alanine, Glycine): pI = (pK_a1[alpha-COOH] + pK_a2[alpha-NH3+]) / 2 (typically pI ≈ 5.5 - 6.0). (2) Acidic Amino Acids (Aspartate, Glutamate): pI = (pK_a1[alpha-COOH] + pK_aR[sidechain-COOH]) / 2 (average of the TWO LOWEST pKa values; pI ≈ 2.8 - 3.2). (3) Basic Amino Acids (Lysine, Arginine, Histidine): pI = (pK_aR[sidechain-NH3+] + pK_a2[alpha-NH3+]) / 2 (average of the TWO HIGHEST pKa values; pI ≈ 7.6 - 10.8)! In electrophoresis, when pH < pI, the molecule is a cation (+) migrating to the cathode (-); when pH > pI, it is an anion (-) migrating to the anode (+)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each amino acid category to its correct Isoelectric Point (pI) formula.",
      "matchPairs": [
        { "left": "Neutral Amino Acid (e.g. Alanine)", "right": "pI = (pK_a1 + pK_a2) / 2 [average of alpha-COOH and alpha-NH3+]" },
        { "left": "Acidic Amino Acid (e.g. Aspartate, Glutamate)", "right": "pI = (pK_a1 + pK_aR) / 2 [average of the two carboxylic acid pKa's]" },
        { "left": "Basic Amino Acid (e.g. Lysine, Arginine)", "right": "pI = (pK_a2 + pK_aR) / 2 [average of the two amino pKa's]" },
        { "left": "Isoelectric State (pH = pI)", "right": "Zero net electrical charge; stationary in an electric field / minimum solubility" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Glutamic acid (an acidic amino acid) has three pKa values: pK_a1(alpha-COOH) = 2.19, pK_aR(sidechain-COOH) = 4.25, and pK_a2(alpha-NH3+) = 9.67. Calculate its isoelectric point pI: pI = (2.19 + 4.25) / 2 (round to 2 decimal places).",
      "numericAnswer": 3.22,
      "numericTolerance": 0.05
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In gel electrophoresis at a buffer pH lower than its isoelectric point (pH < pI), a protonated cationic amino acid migrates toward the negative ___.",
      "blankAnswer": "cathode",
      "blankDistractors": ["anode", "solvent", "vacuum"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Amino Acid Titration & Electrophoresis Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Amino Acid Electrophoresis Engine</h3><p>Peptide: Lysine ($\\text{pI} = 9.74$) | Buffer $\\text{pH} = 7.0$ (Neutral)</p><button id=\"aaBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Electric Field Across Gel ($100\\text{ V}$)</button><div id=\"aaOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('aaBtn').onclick=()=>{document.getElementById('aaOut').innerText='Electrophoresis Migration: At pH 7.0 < pI (9.74), both the alpha-amino (pKa 9.0) and epsilon-amino sidechain (pKa 10.5) are protonated (+NH3+), while alpha-COOH is deprotonated (-COO⁻). Net Charge = +1 (Cation). Lysine migrates rapidly toward the negative CATHODE (-) electrode!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
