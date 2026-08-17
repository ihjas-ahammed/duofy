# Duofy Reusable Lesson Format: Two-Dimensional NMR (COSY, HSQC, and HMBC)

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Nuclear_Magnetic_Resonance_NMR_Spectroscopy`  
**Lesson Format Type:** `two_dimensional_nmr_cosy_hsqc_hmbc`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition and structural interpretation of 2D correlation NMR spectra: interpret **COSY ($^1\text{H}-^1\text{H}$ Correlation Spectroscopy)** by reading off-diagonal cross-peaks to establish adjacent proton scalar couplings (2–3 bonds), master **HSQC (Heteronuclear Single Quantum Coherence)** for direct 1-bond $^1\text{H}-^{13}\text{C}$ connectivity, analyze **HMBC (Heteronuclear Multiple Bond Correlation)** for long-range 2–3 bond correlations to bridge quaternary carbons and carbonyls, evaluate **NOESY (Nuclear Overhauser Effect Spectroscopy)** for through-space spatial proximity ($< 5\text{ Å}$), and interact with live 2D-NMR contour plot structural puzzle solvers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 2D-NMR Correlation Suite (COSY, HSQC, HMBC) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | 2D-NMR Experiment & Specific Correlation Type Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Direct 1-Bond vs Long-Range 2D Cross-Peak Discrimination Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Direct One-Bond Heteronuclear 2D Experiment Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive 2D-NMR Contour Plot (COSY/HSQC) Puzzle Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "two_dimensional_nmr_cosy_hsqc_hmbc",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the core 2D-NMR experiments (COSY, HSQC, HMBC, NOESY), and how do they establish total molecular connectivity?",
      "blankAnswer": "2D-NMR maps correlations across two frequency axes: (1) 1H-1H COSY: Homonuclear correlation where off-diagonal cross-peaks reveal scalar J-coupling between protons separated by 2-3 bonds (assembles adjacent C-H fragments). (2) 1H-13C HSQC: Heteronuclear single-quantum coherence revealing DIRECT ONE-BOND (1J_CH) connections between a proton and the exact carbon it is attached to (assigns all protonated carbons). (3) 1H-13C HMBC: Long-range heteronuclear multiple-bond correlation (2-3 bonds, 2J_CH and 3J_CH); detects cross-peaks to quaternary carbons (like C=O or aromatic ring fusion carbons), linking separate spin systems together across heteroatoms. (4) NOESY / ROESY: Uses dipole-dipole cross-relaxation to detect THROUGH-SPACE proximity (< 5 Å), establishing 3D stereochemical configurations regardless of chemical bonding!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each 2D-NMR experiment to its structural connectivity information.",
      "matchPairs": [
        { "left": "1H-1H COSY", "right": "Through-bond 1H-1H scalar coupling across 2 to 3 bonds (adjacent proton spin systems)" },
        { "left": "1H-13C HSQC", "right": "Direct 1-bond (1J_CH) heteronuclear correlation (pairs each proton to its parent carbon)" },
        { "left": "1H-13C HMBC", "right": "Long-range 2-to-3 bond (2J_CH, 3J_CH) coupling; bridges quaternary carbons and carbonyls" },
        { "left": "1H-1H NOESY", "right": "Through-space dipole cross-relaxation (< 5 Å distance); establishes 3D stereochemistry" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A chemist needs to determine which proton is located 3 bonds away from a quaternary ester carbonyl carbon (C=O at delta = 175 ppm). Which 2D-NMR experiment should be used?",
      "options": [
        { "text": "HMBC (Heteronuclear Multiple Bond Correlation); because HMBC is optimized for long-range 2-3 bond 1H-13C couplings, it detects cross-peaks between protons and quaternary carbons that have no directly attached protons", "isCorrect": true, "explanation": "Correct! HSQC only detects DIRECT 1-bond C-H pairs (and is blind to quaternary carbons like esters). HMBC uses a delay tuned to long-range coupling (2-3 bonds, ~8 Hz), allowing the ester carbonyl (C=O) to correlate with alpha and beta protons across the ester linkage." },
        { "text": "HSQC (Heteronuclear Single Quantum Coherence)", "isCorrect": false, "explanation": "Incorrect: HSQC only shows direct 1-bond C-H connections." },
        { "text": "1H-1H COSY", "isCorrect": false, "explanation": "Incorrect: COSY only correlates protons to other protons." },
        { "text": "DEPT-90", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The standard 2D-NMR experiment used to unambiguously correlate a proton to the exact carbon atom it is directly bonded to is ___.",
      "blankAnswer": "hsqc",
      "blankDistractors": ["cosy", "hmbc", "noesy"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 2D-NMR Structure Solver Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>2D-NMR Contour Correlation Engine</h3><p>Sample: Ethyl Acetate ($\\text{CH}_3\\text{COOCH}_2\\text{CH}_3$)</p><button id=\"nmr2dBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Overlay COSY, HSQC, and HMBC Cross-Peaks</button><div id=\"nmr2dOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('nmr2dBtn').onclick=()=>{document.getElementById('nmr2dOut').innerText='2D Correlation Complete: (1) COSY: δ 4.12 ppm (q, -OCH2-) correlates to δ 1.25 ppm (t, -CH3). (2) HSQC: δ 4.12 ppm correlates directly to C at 60.5 ppm. (3) HMBC: Both acetate methyl (δ 2.04 ppm) and ethoxy methylene (δ 4.12 ppm) show 3-bond cross-peaks to the quaternary carbonyl C=O at 171.0 ppm. Structure verified unambiguously!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
