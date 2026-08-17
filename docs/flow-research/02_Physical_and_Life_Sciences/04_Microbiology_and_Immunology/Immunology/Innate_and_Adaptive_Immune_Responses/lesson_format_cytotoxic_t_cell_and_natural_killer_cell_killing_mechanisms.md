# Duofy Reusable Lesson Format: Cytotoxic T-Cell and Natural Killer Cell Killing Mechanisms

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Immunology / Innate_and_Adaptive_Immune_Responses`  
**Lesson Format Type:** `cytotoxic_t_cell_and_natural_killer_cell_killing_mechanisms`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid molecular biophysical, cell biological, and immunological mastery of cell-mediated cytotoxicity (Gillian Griffiths; Klas Kärre for the "missing-self" hypothesis): contrast **CD8+ Cytotoxic T Lymphocyte (CTL)** antigen-specific MHC Class I-restricted recognition with **Natural Killer (NK) Cell** innate recognition via the balance of activating receptors (NKG2D, CD16 for ADCC) and **Inhibitory Receptors (KIRs)** binding self-MHC Class I, master the dual cytotoxic death machinery (**1. Directional Degranulation: Perforin polymerization creating membrane pores $\to$ Granzyme B entry cleaving pro-Caspase-3 and Bid $\to$ mitochondrial cytochrome c release and Apoptosis**; **2. Death Receptor Ligation: FasL/Fas and TRAIL** activating Caspase-8), and interact with live immunological synapse and cytotoxic killing simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CTL vs NK Cell Cytotoxic Mechanisms Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Cytotoxic Effector Molecule & Target Killing Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | NK Cell Missing-Self Hypothesis and Viral MHC-I Downregulation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Pore-Forming Cytotoxic Granule Protein Class Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Immunological Synapse Degranulation Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cytotoxic_t_cell_and_natural_killer_cell_killing_mechanisms",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do CD8+ Cytotoxic T Lymphocytes (CTLs) and Natural Killer (NK) cells recognize and kill virus-infected or malignant target cells?",
      "blankAnswer": "Cell-mediated cytotoxicity is mediated by two lymphocyte classes using identical killing weapons: (1) RECOGNITION STRATEGIES: (a) CD8+ CTLs: Antigen-specific; TCR recognizes specific foreign viral/tumor peptide presented on MHC Class I. (b) Natural Killer (NK) Cells: Innate 'Missing-Self' Recognition (Klas Kärre). NK cells express inhibitory receptors (KIRs) that bind healthy self-MHC Class I. If a virus or cancer cell downregulates MHC Class I to escape CTLs, the inhibitory signal is lost, activating killer receptors (NKG2D) to trigger degranulation! (2) THE DUAL KILLING WEAPONS: (a) Perforin-Granzyme Degranulation: The killer cell polarizes its microtubule organizing center (MTOC) toward the immunological synapse. PERFORIN molecules polymerize in the target plasma membrane to form cylindrical pores. GRANZYME B serine proteases enter the target cytoplasm, directly cleaving pro-caspase-3 and the BH3-only protein Bid (forming tBid), which ruptures mitochondria to release Cytochrome c, driving rapid, clean APOPTOSIS without inflammation! (b) Death Receptor Pathway: Surface Fas Ligand (FasL) binds target cell Fas (CD95), recruiting FADD to activate Caspase-8 directly!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each cytotoxic effector molecule to its precise molecular killing mechanism.",
      "matchPairs": [
        { "left": "Perforin Monomers", "right": "Calcium-dependent pore-forming protein that inserts into the target lipid bilayer to allow granzyme entry" },
        { "left": "Granzyme B Serine Protease", "right": "Cleaves pro-caspase-3 and Bid (generating tBid) to activate the intrinsic apoptotic cascade" },
        { "left": "Fas Ligand (FasL / CD178)", "right": "Trimeric surface ligand that binds target cell Fas (CD95) to activate the extrinsic Caspase-8 pathway" },
        { "left": "KIRs (Killer Inhibitory Receptors)", "right": "NK cell surface receptors that bind self-MHC Class I to deliver tyrosine phosphatase (SHP-1) inhibitory signals" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Cytomegalovirus (CMV) often evolves mechanisms to downregulate surface MHC Class I expression on host cells in order to escape destruction by CD8+ Cytotoxic T Cells. Why does this evolutionary strategy backfire in the presence of Natural Killer (NK) cells?",
      "options": [
        { "text": "NK cells operate on the 'MISSING-SELF' principle; normal healthy cells express MHC Class I that engages NK inhibitory receptors (KIRs) to block killing, but when CMV downregulates MHC Class I, the inhibitory signal is lost, allowing activating receptors to trigger NK degranulation and lyse the infected cell", "isCorrect": true, "explanation": "Correct! Natural Killer cells are governed by a dynamic balance of activating and inhibitory signals (the 'Missing-Self' hypothesis formulated by Klas Kärre). Healthy host cells display normal levels of self-MHC Class I, which continuously engage inhibitory Killer-cell Immunoglobulin-like Receptors (KIRs) bearing ITIM domains on NK cells, overriding any baseline activating signals. When viruses (like CMV or Adenovirus) downregulate MHC Class I to hide from CD8+ CTLs, the NK cell's inhibitory brake is released. Activating receptors (like NKG2D binding stress ligands MICA/MICB) take over, inducing polarized release of perforin and granzymes to destroy the infected cell." },
        { "text": "Because NK cells are converted into antibodies by CMV", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because MHC Class I downregulation makes the cell explode spontaneously", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because NK cells only kill cells that have extra MHC Class I", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The pore-forming protein stored in cytotoxic granules that polymerizes in target cell membranes in a calcium-dependent manner is ___.",
      "blankAnswer": "perforin",
      "blankDistractors": ["granzyme", "caspase", "fasl"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive CTL / NK Cell Immunological Synapse Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Cytotoxic Lymphocyte Degranulation Engine</h3><p>Target: Tumor Cell with Downregulated MHC Class I</p><button id=\"ctlBtn\" style=\"padding:8px 16px; margin:4px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Engage CD8+ CTL</button><button id=\"nkBtn\" style=\"padding:8px 16px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Engage Natural Killer (NK) Cell</button><div id=\"synOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Awaiting Effector Cell...</div><script>document.getElementById('ctlBtn').onclick=()=>{document.getElementById('synOut').innerText='CD8+ CTL: No MHC-I detected -> TCR cannot bind -> Target cell ESCAPES CTL killing!';}; document.getElementById('nkBtn').onclick=()=>{document.getElementById('synOut').innerText='NK Cell: No MHC-I detected (Missing-Self!) -> KIR inhibitory brake OFF -> Perforin pores formed + Granzyme B injected -> Target cell APOTOSIS EXECUTED!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
