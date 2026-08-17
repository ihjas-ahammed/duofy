# Duofy Reusable Lesson Format: Central Tolerance (AIRE) and Hypersensitivity Reactions

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Immunology / Vaccines_Immunotherapy_and_Autoimmunity`  
**Lesson Format Type:** `central_tolerance_aire_and_hypersensitivity_reactions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid genetic, cellular, and clinical mastery of central immune tolerance mechanisms and immunopathological hypersensitivity reactions (Frank Macfarlane Burnet 1960 Nobel; Robin Coombs & Philip Gell 1963): analyze the **AIRE (Autoimmune Regulator)** transcription factor in **Medullary Thymic Epithelial Cells (mTECs)** driving ectopic expression of tissue-restricted self-antigens (TRAs) to purge self-reactive thymocytes via **Negative Selection (Clonal Deletion)**, contrast with **Peripheral Tolerance** (FoxP3+ Tregs, Anergy, CTLA-4), classify the **4 Coombs and Gell Hypersensitivity Reactions (Type I: IgE/Mast Cell Immediate; Type II: IgG/IgM Cytotoxic; Type III: Immune Complex Vasculitis; Type IV: Delayed-Type Hypersensitivity T-Cell Mediated)**, and interact with live Coombs & Gell diagnostic classification simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Central Tolerance AIRE & Coombs-Gell Hypersensitivities Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Coombs & Gell Hypersensitivity Type & Prototypical Clinical Disease Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | AIRE Gene Mutation and Medullary Thymic Negative Selection Defect Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Delayed-Type Hypersensitivity Coombs-Gell Roman Numeral Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Coombs & Gell Hypersensitivity Diagnostic Analyzer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "central_tolerance_aire_and_hypersensitivity_reactions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does the AIRE gene enforce central thymic tolerance, and how are the 4 Coombs and Gell hypersensitivity reactions categorized?",
      "blankAnswer": "Tolerance and immunopathology are governed by: (1) THYMIC CENTRAL TOLERANCE & AIRE: In the thymic medulla, Medullary Thymic Epithelial Cells (mTECs) express the AIRE (Autoimmune Regulator) transcription factor. AIRE promotes 'promiscuous' ectopic transcription of thousands of tissue-restricted self-antigens (TRAs: insulin, thyroglobulin, myelin basic protein). Developing thymocytes whose TCRs bind self-peptide-MHC with high affinity undergo APOPTOSIS (Negative Selection / Clonal Deletion). Inactivating AIRE mutations cause APECED / APS-1 (Autoimmune Polyendocrinopathy-Candidiasis-Ectodermal Dystrophy). (2) THE 4 COOMBS & GELL HYPERSENSITIVITY REACTIONS: (a) Type I (Immediate / Allergic): IgE-mediated cross-linking on mast cells/basophils -> rapid histamine release (Anaphylaxis, Allergic Rhinitis, Asthma). (b) Type II (Antibody-Mediated Cytotoxic): IgG/IgM bind fixed tissue/cell surface antigens -> complement-mediated lysis or phagocytosis (Goodpasture syndrome, Myasthenia Gravis, Rheumatic Fever). (c) Type III (Immune Complex): Soluble antigen-antibody complexes deposit in microvasculature -> complement activation and neutrophil infiltration (Systemic Lupus Erythematosus / SLE, Serum Sickness, Post-streptococcal Glomerulonephritis). (d) Type IV (Delayed-Type Hypersensitivity / Cell-Mediated): T cells (Th1, Th17, CD8+ CTLs) secrete cytokines and activate macrophages 24-72 hours post-exposure (Contact Dermatitis [Poison Ivy], Mantoux PPD Tuberculin Test, Multiple Sclerosis, Type 1 Diabetes)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Coombs and Gell hypersensitivity type to its classic clinical pathology.",
      "matchPairs": [
        { "left": "Type I Hypersensitivity (IgE-Mediated)", "right": "Anaphylaxis and allergic asthma driven by mast cell and basophil histamine degranulation" },
        { "left": "Type II Hypersensitivity (Cytotoxic Antibody)", "right": "Goodpasture syndrome and Myasthenia Gravis caused by IgG/IgM binding fixed tissue antigens" },
        { "left": "Type III Hypersensitivity (Immune Complex)", "right": "Systemic Lupus Erythematosus (SLE) and serum sickness caused by circulating Ag-Ab vascular deposition" },
        { "left": "Type IV Hypersensitivity (Cell-Mediated DTH)", "right": "Poison ivy contact dermatitis and Mantoux tuberculin skin test mediated by sensitized T cells" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the primary immunological mechanism that causes multi-organ endocrine autoimmune destruction (APECED / APS-1) in patients carrying loss-of-function mutations in the AIRE gene?",
      "options": [
        { "text": "Medullary Thymic Epithelial Cells (mTECs) fail to express tissue-restricted peripheral self-antigens (such as insulin and adrenal enzymes) in the thymus, preventing negative selection and allowing self-reactive T-cell clones to escape into the peripheral circulation", "isCorrect": true, "explanation": "Correct! The Autoimmune Regulator (AIRE) is a nuclear chromatin-binding protein expressed in medullary thymic epithelial cells (mTECs). AIRE enables the promiscuous, non-tissue-specific expression of thousands of peripheral tissue-restricted antigens (TRAs) inside the thymus. This presents developing thymocytes with a complete 'molecular preview' of the body's peripheral self-antigens. Thymocytes bearing TCRs with high affinity for these self-antigens receive apoptotic death signals (negative selection). In the absence of functional AIRE (in APECED/APS-1 patients), peripheral antigens are never expressed in the thymus. Developing T cells specific for endocrine organs (adrenals, parathyroids, thyroid, pancreas) mature without undergoing clonal deletion and migrate to the periphery, where they attack self-tissues." },
        { "text": "Because AIRE is a virus that infects the pancreas directly", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AIRE mutations cause total destruction of B-cell antibodies", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because patients lose all neutrophil granulocytes from birth", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Coombs and Gell classification, cell-mediated Delayed-Type Hypersensitivity (such as the Mantoux tuberculin skin reaction) is classified as Type ___ hypersensitivity.",
      "blankAnswer": "iv",
      "blankDistractors": ["i", "ii", "iii"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Coombs & Gell Hypersensitivity Classifier",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Coombs & Gell Hypersensitivity Diagnostic Engine</h3><p>Select Clinical Presentation:</p><button id=\"t1Btn\" style=\"padding:8px 14px; margin:4px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Bee Sting Anaphylaxis</button><button id=\"t2Btn\" style=\"padding:8px 14px; margin:4px; background:#3b82f6; color:white; border:none; border-radius:6px; cursor:pointer;\">Goodpasture (Anti-GBM)</button><button id=\"t3Btn\" style=\"padding:8px 14px; margin:4px; background:#f59e0b; color:white; border:none; border-radius:6px; cursor:pointer;\">Lupus Nephritis (SLE)</button><button id=\"t4Btn\" style=\"padding:8px 14px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Poison Ivy Contact Dermatitis</button><div id=\"cgOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select an option above to classify...</div><script>document.getElementById('t1Btn').onclick=()=>{document.getElementById('cgOut').innerText='Classification: TYPE I (Immediate) -> IgE cross-linking on mast cells -> Histamine release!';}; document.getElementById('t2Btn').onclick=()=>{document.getElementById('cgOut').innerText='Classification: TYPE II (Cytotoxic) -> IgG against type IV collagen -> Complement activation!';}; document.getElementById('t3Btn').onclick=()=>{document.getElementById('cgOut').innerText='Classification: TYPE III (Immune Complex) -> Soluble anti-dsDNA complexes lodge in glomeruli!';}; document.getElementById('t4Btn').onclick=()=>{document.getElementById('cgOut').innerText='Classification: TYPE IV (Delayed-Type / T-Cell) -> Urushiol hapten -> Sensitized Th1 cells -> Macrophage activation (24-72 hr peak)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
