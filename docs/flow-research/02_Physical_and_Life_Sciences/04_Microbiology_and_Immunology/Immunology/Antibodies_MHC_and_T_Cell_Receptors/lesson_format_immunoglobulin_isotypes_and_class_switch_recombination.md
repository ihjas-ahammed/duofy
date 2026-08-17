# Duofy Reusable Lesson Format: Immunoglobulin Isotypes and Class Switch Recombination

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Immunology / Antibodies_MHC_and_T_Cell_Receptors`  
**Lesson Format Type:** `immunoglobulin_isotypes_and_class_switch_recombination`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid structural, genetic, and clinical mastery of antibody constant region diversity and isotype switching (Tasuku Honjo, Nobel Prize in Physiology or Medicine 2018 for AID / Checkpoint discovery): contrast the physiological functions and structural quaternary states of the 5 Immunoglobulin Isotypes (**IgM [pentamer, complement], IgD, IgG [opsonin, crosses placenta via FcRn, ADCC], IgA [secretory dimer, mucosal immunity], IgE [Fc$\epsilon$RI binding, mast cell degranulation, parasites]**), trace the molecular mechanics of **Class Switch Recombination (CSR)** and **Somatic Hypermutation (SHM)** initiated by **Activation-Induced Cytidine Deaminase (AID)** deaminating cytosine to uracil at repetitive **Switch ($S$) Regions**, and analyze **Hyper-IgM Syndrome** resulting from CD40L or AID mutations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Antibody Isotypes & Class Switch Genetics Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Immunoglobulin Isotype & Specific Effector Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Activation-Induced Cytidine Deaminase AID CSR/SHM Mechanism Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Maternal Antibody Class That Crosses Human Placenta Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Immunoglobulin Class Switch & Affinity Maturation Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "immunoglobulin_isotypes_and_class_switch_recombination",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the distinct functions of the 5 Immunoglobulin isotypes (IgM, IgD, IgG, IgA, IgE), and how does Class Switch Recombination work?",
      "blankAnswer": "Antibody Heavy Chain Constant (C_H) regions dictate effector biology: (1) IgM: Monomer on naive B cells; Pentamer with J-chain in serum; primary immune response workhorse and most potent activator of the classical complement cascade (C1q binding). (2) IgD: Co-expressed with IgM on naive mature B cells via alternative RNA splicing; acts as an antigen receptor. (3) IgG (IgG1-4): Main serum antibody (~80%); crosses human placenta via neonatal Fc receptor (FcRn) to confer passive fetal immunity; potent opsonin (Fc_gamma_R binding on macrophages) and mediator of Antibody-Dependent Cellular Cytotoxicity (ADCC by NK cells). (4) IgA: Monomer in serum; Dimer joined by J-chain and Secretory Component in mucosal secretions (saliva, tears, colostrum, gut lining). (5) IgE: Binds with ultra-high affinity to Fc_epsilon_RI on mast cells and basophils; triggers immediate degranulation (histamine) upon allergen cross-linking, defending against parasitic helminths. (6) CLASS SWITCH RECOMBINATION (CSR; Honjo 2018 Nobel): T-follicular helper cells provide CD40L and cytokines (IL-4 for IgE, IFN-gamma for IgG, TGF-beta for IgA), inducing Activation-Induced Cytidine Deaminase (AID). AID deaminates cytosines into uracils at repetitive Switch (S) regions upstream of constant genes. Uracil DNA glycosylase (UNG) and APE1 excise the uracils, creating double-strand breaks. Non-homologous end joining (NHEJ) splices the rearranged VDJ variable exon onto the new downstream constant region (e.g. C_gamma, C_alpha, or C_epsilon), altering effector class while PRESERVING EXACT ANTIGEN SPECIFICITY!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each immunoglobulin isotype to its primary physiological function.",
      "matchPairs": [
        { "left": "Immunoglobulin G (IgG)", "right": "Dominant serum antibody that crosses the placenta via FcRn to provide passive fetal protection" },
        { "left": "Immunoglobulin A (IgA)", "right": "Dimeric mucosal antibody with secretory component neutralizing pathogens in gut and respiratory tracts" },
        { "left": "Immunoglobulin E (IgE)", "right": "Binds high-affinity Fc_epsilon_RI on mast cells to trigger histamine release in allergy and helminth defense" },
        { "left": "Immunoglobulin M (IgM)", "right": "Secreted as a high-avidity pentamer that serves as the premier activator of classical complement" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In patients with Hyper-IgM Syndrome caused by an inherited genetic defect in Activation-Induced Cytidine Deaminase (AID), why are serum levels of IgG, IgA, and IgE virtually undetectable despite high or normal levels of IgM?",
      "options": [
        { "text": "AID is the mandatory initiator enzyme that deaminates cytosines to uracils at repetitive Switch (S) regions upstream of heavy chain constant genes to generate the double-strand breaks required for Class Switch Recombination (CSR); without AID, B cells cannot undergo CSR and are permanently trapped producing only IgM", "isCorrect": true, "explanation": "Correct! Activation-Induced Cytidine Deaminase (AID; discovered by Tasuku Honjo) is exclusively expressed in germinal center B cells. AID converts cytosine to uracil in DNA. During CSR, AID targets the guanine-rich, repetitive Switch (S) regions located 5' of each C_H gene. The resulting uracils are recognized by base excision repair (UNG) and mismatch repair enzymes to generate double-strand DNA breaks. Recombination between S_mu and a downstream S_gamma, S_alpha, or S_epsilon region cuts out intervening DNA and joins the VDJ region to the new constant gene. In AID deficiency (Autosomal Recessive Hyper-IgM Type 2), CSR cannot occur, trapping all B cells in IgM production and leaving the patient severely immunocompromised due to the total absence of IgG, IgA, and IgE." },
        { "text": "Because AID is the structural gene that encodes the heavy chain of IgG", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because IgM destroys all other antibodies in the blood", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AID is required for mitochondrial respiration in B cells", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The only major class of human maternal immunoglobulin capable of crossing the placenta to provide passive immunity to the fetus is Ig___.",
      "blankAnswer": "g",
      "blankDistractors": ["m", "a", "e"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Class Switch Recombination Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>B-Cell Class Switch Recombination (CSR) Engine</h3><p>Germinal Center: Naive B Cell ($VDJ\\text{-}C_\\mu$)</p><button id=\"csrBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Add T-Helper Signals (CD40L + IL-4)</button><div id=\"csrOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('csrBtn').onclick=()=>{document.getElementById('csrOut').innerText='Molecular Switch: (1) CD40L + IL-4 induce AID enzyme. (2) AID attacks S_mu and S_epsilon switch regions (C -> U). (3) UNG + APE1 create double-strand breaks. (4) Intervening DNA looped out and excised. (5) VDJ ligated to C_epsilon exon! Isotype switched to IgE (Antigen specificity 100% preserved)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
