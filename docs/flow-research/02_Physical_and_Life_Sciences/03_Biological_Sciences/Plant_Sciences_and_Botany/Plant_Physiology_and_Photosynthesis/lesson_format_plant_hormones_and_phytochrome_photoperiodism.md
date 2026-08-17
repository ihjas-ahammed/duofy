# Duofy Reusable Lesson Format: Plant Hormones and Phytochrome Photoperiodism

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Plant_Sciences_and_Botany / Plant_Physiology_and_Photosynthesis`  
**Lesson Format Type:** `plant_hormones_and_phytochrome_photoperiodism`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid biochemical, molecular signaling, and photobiological mastery of classical phytohormones and light-sensing networks (Went & Thimann; Harry Borthwick & Sterling Hendricks 1952): analyze the **Acid Growth Hypothesis of Auxin (IAA)** (polar transport by PIN carriers $\to$ plasma membrane $\text{H}^+\text{-ATPase}$ activation lowering wall pH to $4.5 \to$ activating **Expansins** to loosen cellulose microfibrils), contrast the major phytohormone families (**Auxins, Cytokinins, Gibberellins [GA / DELLA degradation], Abscisic Acid [ABA / PYR-RCAR stomatal closure], and Ethylene [Triple Response]**), master **Phytochrome Photoperiodism** (reversible **$P_r$ [inactive, red $660\text{ nm}$] $\rightleftharpoons$ $P_{fr}$ [active, far-red $730\text{ nm}$]** molecular switch), evaluate short-day vs long-day flowering control by **CONSTANS (CO) and Florigen (FT protein)**, and interact with live phytochrome red/far-red light pulse simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Phytohormones & Phytochrome Photoreceptors Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Phytohormone & Physiological Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Short-Day Plant Night-Break Red/Far-Red Light Flash Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Acid Growth Cell Wall Loosening Protein Class Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Phytochrome Pr/Pfr Photoperiodic Flowering Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "plant_hormones_and_phytochrome_photoperiodism",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do Auxin and Phytochrome regulate cell elongation and photoperiodic flowering in plants?",
      "blankAnswer": "Plant growth and developmental timing are governed by hormonal and photoreceptor signaling: (1) AUXIN (IAA) & ACID GROWTH HYPOTHESIS: Auxin is transported directionally (polar transport) via basal PIN efflux carriers. In the shoot elongation zone, Auxin binds TIR1/AFB receptors (stimulating Aux/IAA repressor degradation via the 26S proteasome) and stimulates plasma membrane H+-ATPases. Protons are pumped into the cell wall apoplast, lowering pH to ~4.5. This acidic pH activates EXPANSIN proteins, which break non-covalent hydrogen bonds between cellulose microfibrils and xyloglucan cross-links. Turgor pressure then drives rapid irreversible cell wall expansion and stem bending (phototropism)! (2) PHYTOCHROME PHOTOPERIODIC SWITCH: Phytochromes are homodimeric chromoproteins that exist in two interconvertible conformations: (a) Pr (Inactive form; absorbs Red light at 660 nm and is converted to active Pfr). (b) Pfr (Active form; absorbs Far-Red light at 730 nm and is converted back to Pr). In daylight (high Red:Far-Red ratio), Pr is rapidly converted to active Pfr, which translocates into the nucleus to regulate gene expression. In Short-Day (Long-Night) plants, flowering requires a long uninterrupted night where Pfr reverts to Pr; a brief flash of red light in the middle of the night converts Pr back to Pfr, completely inhibiting flowering (which can be reversed by an immediate flash of far-red light)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each plant hormone to its primary physiological function.",
      "matchPairs": [
        { "left": "Auxin (Indole-3-Acetic Acid)", "right": "Drives apical dominance, phototropism, and cell elongation via the Acid Growth Hypothesis" },
        { "left": "Abscisic Acid (ABA)", "right": "Mediates drought response by activating guard cell anion efflux (SLAC1) to trigger stomatal closure" },
        { "left": "Gibberellins (GA)", "right": "Triggers DELLA protein degradation to promote seed germination and stem bolting" },
        { "left": "Ethylene Gas", "right": "Promotes fruit ripening, leaf abscission, and the classic seedling 'Triple Response'" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A Short-Day (Long-Night) plant requires an uninterrupted dark period of at least 14 hours to flower. If this 14-hour dark period is interrupted at midnight by a 1-minute flash of Red light (660 nm) followed immediately by a 1-minute flash of Far-Red light (730 nm), what will be the flowering response of the plant?",
      "options": [
        { "text": "THE PLANT WILL FLOWER NORMALLY; the final flash of Far-Red light converts active Pfr back into inactive Pr, neutralizing the inhibitory effect of the red flash and restoring the perception of an uninterrupted long night", "isCorrect": true, "explanation": "Correct! Phytochromes act as reversible photochromic molecular switches. Red light (660 nm) converts inactive Pr into active Pfr (which inhibits flowering in short-day plants). Far-red light (730 nm) converts Pfr back into inactive Pr. In classic photoperiodic experiments (Borthwick & Hendricks, 1952), the flowering response is determined strictly by the wavelength of the FINAL light flash in the sequence. Because the final flash was Far-Red, the phytochrome pool ends up in the inactive Pr state, allowing the short-day plant to flower as if the night had never been interrupted." },
        { "text": "The plant will explode", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The plant will completely stop flowering permanently", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The plant will turn into a long-day plant", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the auxin-mediated acid growth hypothesis, the cell-wall loosening proteins activated at pH 4.5 that disrupt cellulose-xyloglucan cross-links are called ___.",
      "blankAnswer": "expansins",
      "blankDistractors": ["cellulases", "kinases", "ligases"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Phytochrome Red/Far-Red Switch Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Phytochrome Pr/Pfr Photoperiod Engine</h3><p>Photoperiod Regime: Short-Day Plant (14-Hour Critical Dark Period)</p><button id=\"prBtn\" style=\"padding:8px 16px; margin:4px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Flash Red Light (660 nm)</button><button id=\"pfrBtn\" style=\"padding:8px 16px; margin:4px; background:#7c3aed; color:white; border:none; border-radius:6px; cursor:pointer;\">Flash Far-Red Light (730 nm)</button><div id=\"phyOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\">Current State: Inactive Pr (Flowering ON)</div><script>let state='Pr'; document.getElementById('prBtn').onclick=()=>{state='Pfr'; document.getElementById('phyOut').innerText='Phytochrome: Active Pfr (Night broken -> Flowering INHIBITED / OFF)';}; document.getElementById('pfrBtn').onclick=()=>{state='Pr'; document.getElementById('phyOut').innerText='Phytochrome: Inactive Pr (Night restored -> Flowering PERMITTED / ON!)'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
