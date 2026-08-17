# Duofy Reusable Lesson Format: Apoptosis Pathways (Caspase Cascade and Bcl-2 Family)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / Signal_Transduction_and_Cell_Cycle_Control`  
**Lesson Format Type:** `apoptosis_pathways_caspase_cascade_and_bcl2`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid molecular, biochemical, and structural mastery of programmed cell death (Sydney Brenner, H. Robert Horvitz, John Sulston, Nobel Prize in Physiology or Medicine 2002): contrast the **Intrinsic (Mitochondrial) Pathway** (DNA damage/stress $\to$ BH3-only proteins [Bim, Puma, Bad] activate **Bax / Bak** $\to$ **MOMP [Mitochondrial Outer Membrane Permeabilization]** $\to$ **Cytochrome c** release $\to$ **Apaf-1 heptameric Apoptosome** assembly $\to$ **Initiator Caspase-9** activation) with the **Extrinsic (Death Receptor) Pathway** (FasL/TNF $\to$ Fas/TNFR $\to$ **DISC complex / FADD** $\to$ **Initiator Caspase-8**), trace downstream cleavage of **Executioner Caspases-3 and 7** dismantling the cell (ICAD/CAD DNA fragmentation, PARP cleavage), and evaluate anti-apoptotic **Bcl-2 / Bcl-xL** oncogenic overexpression.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Intrinsic vs Extrinsic Apoptosis & Caspases Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Apoptotic Protein / Complex & Mechanistic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Caspase Cysteine Protease Active Site Cleavage Specificity Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Heptameric Cytochrome c and Apaf-1 Caspase-9 Activating Complex Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Apoptosis Cascade & Mitochondrial MOMP Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "apoptosis_pathways_caspase_cascade_and_bcl2",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do the Intrinsic and Extrinsic apoptosis pathways activate initiator and executioner caspases to execute programmed cell death?",
      "blankAnswer": "Apoptosis (programmed cell death; 2002 Nobel Prize) operates through two converging proteolytic cascades: (1) Intrinsic (Mitochondrial) Pathway: Triggered by severe DNA damage or developmental cues. Pro-apoptotic BH3-only proteins (Bim, Puma, Bid) inhibit anti-apoptotic Bcl-2/Bcl-xL and directly activate pore-forming effectors Bax and Bak on the outer mitochondrial membrane, causing MOMP (Mitochondrial Outer Membrane Permeabilization). Cytochrome c leaks into the cytosol and binds Apaf-1 in the presence of dATP to assemble the wheel-like, heptameric Apoptosome. The apoptosome recruits and activates Initiator Caspase-9. (2) Extrinsic (Death Receptor) Pathway: Extracellular death ligands (FasL, TNF-alpha) bind trimeric death receptors (Fas/CD95, TNFR1), recruiting the adaptor FADD to assemble the Death-Inducing Signaling Complex (DISC), which cleaves and activates Initiator Caspase-8. (Bid connects extrinsic to intrinsic by cleavage to tBid). (3) Execution Phase: Both initiator caspases (9 and 8) cleave and activate Executioner Caspases-3 and 7, which systematically cleave ICAD (liberating CAD endonuclease to fragment DNA into 180-bp nucleosomal ladders), dismantle lamins, and chew actin to orchestrate neat, non-inflammatory apoptotic packaging!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each apoptotic regulator to its exact biological role.",
      "matchPairs": [
        { "left": "Bax / Bak Proteins", "right": "Pro-apoptotic pore-forming effectors that oligomerize to form MOMP channels in the mitochondrial membrane" },
        { "left": "Bcl-2 / Bcl-xL", "right": "Anti-apoptotic guardians that sequester Bax/Bak to prevent cytochrome c leakage and preserve mitochondrial integrity" },
        { "left": "Apoptosome (Heptameric Apaf-1 + Cytochrome c)", "right": "Wheel-like multiprotein catalytic platform that recruits and activates initiator Caspase-9 via CARD domains" },
        { "left": "Executioner Caspase-3 / Caspase-7", "right": "Downstream cysteine proteases that cleave vital cellular substrates (ICAD, PARP, Lamin) to dismantle the cell" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the biochemical defining feature of the Caspase enzyme family (Cysteine-Aspartic Proteases)?",
      "options": [
        { "text": "They utilize a catalytic CYSTEINE residue in their active site to execute nucleophilic cleavage strictly after specific ASPARTIC ACID residues in substrate proteins", "isCorrect": true, "explanation": "Correct! The name 'Caspase' is an acronym for Cysteine Aspartate-specific Protease. Their active site features a catalytic Cys-His dyad where the nucleophilic cysteine thiolate attacks peptide bonds exclusively on the C-terminal side of aspartic acid residues (e.g. at D-X-X-D motifs), ensuring extraordinarily precise and targeted substrate cleavage during apoptosis." },
        { "text": "They phosphorylate glucose into glycogen", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They synthesize ATP from nitrogen gas", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They digest only lipid bilayers and ignore proteins", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the intrinsic apoptotic pathway, cytosolic Cytochrome c binds Apaf-1 and dATP to assemble the wheel-shaped, heptameric molecular platform called the ___.",
      "blankAnswer": "apoptosome",
      "blankDistractors": ["proteasome", "spliceosome", "ribosome"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Apoptosis Execution Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Programmed Cell Death (Apoptosis) Engine</h3><p>Trigger: Severe Unrepairable DNA Damage (p53 Activation)</p><button id=\"apopBtn\" style=\"padding:8px 20px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Trigger Intrinsic Mitochondrial Apoptosis</button><div id=\"apopOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('apopBtn').onclick=()=>{document.getElementById('apopOut').innerText='Apoptotic Cascade: (1) p53 induces Puma/Noxa -> Activates Bax/Bak. (2) MOMP pore forms -> Cytochrome c released from mitochondria. (3) Apaf-1 + Cytochrome c assemble 7-spoke Apoptosome. (4) Initiator Caspase-9 cleaved -> Activates Executioner Caspase-3. (5) ICAD cleaved -> CAD endonuclease digests DNA into 180-bp ladder! Cell quietly packaged into apoptotic bodies.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
