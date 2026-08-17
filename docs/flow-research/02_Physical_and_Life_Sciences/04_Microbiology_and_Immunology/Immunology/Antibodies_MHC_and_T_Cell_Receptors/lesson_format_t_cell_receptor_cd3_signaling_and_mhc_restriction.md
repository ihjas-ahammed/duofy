# Duofy Reusable Lesson Format: T-Cell Receptor CD3 Signaling and MHC Restriction

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Immunology / Antibodies_MHC_and_T_Cell_Receptors`  
**Lesson Format Type:** `t_cell_receptor_cd3_signaling_and_mhc_restriction`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular structural immunology, immunological synapse assembly, and signal transduction cascades of T lymphocytes (Rolf Zinkernagel & Peter Doherty, Nobel Prize in Physiology or Medicine 1996 for MHC restriction; Arthur Weiss): formulate the **TCR-CD3 Multi-Protein Complex** (clonotypic $\alpha\beta$ heterodimer coupled to invariant **$\text{CD3}\gamma\epsilon, \text{CD3}\delta\epsilon$, and $\text{CD3}\zeta\zeta$ dimers** containing **ITAMs [Immunoreceptor Tyrosine-based Activation Motifs]**), trace the downstream activation cascade (**Lck kinase phosphorylating ITAMs $\to$ ZAP-70 recruitment $\to$ LAT signalosome $\to$ PLC$\gamma 1 \to$ NFAT, NF-$\kappa$B, and AP-1 transcription factors**), master the concept of **MHC Restriction** learned via thymic positive selection, and evaluate the mandatory **Two-Signal Model of T-Cell Activation (Signal 1: TCR-MHC vs Signal 2: CD28-B7 costimulation; lack of Signal 2 causes Anergy)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TCR-CD3 Complex & Signal Transduction Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step TCR Lck to NFAT Nuclear Translocation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Signaling Molecule / Coreceptor & Biochemical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Tyrosine-Based Activation Motif Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Signal 1 Without Signal 2 Costimulation T-Cell Anergy Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State TCR-CD3 Signal Transduction & MHC Restriction (1996 Nobel):
   - **The TCR-CD3 Octameric Complex:**
     - **TCR $\alpha\beta$ Heterodimer:** Contains hypervariable CDR loops recognizing peptide-MHC. Short cytoplasmic tail (no intrinsic signaling ability).
     - **CD3 Signaling Subunits:** Invariant $\text{CD3}\gamma\epsilon$ heterodimer, $\text{CD3}\delta\epsilon$ heterodimer, and $\text{CD3}\zeta\zeta$ homodimer. Contain a total of **10 ITAMs** (Immunoreceptor Tyrosine-based Activation Motifs).
   - **The 3-Signal Model of T-Cell Activation:**
     1. **Signal 1 (Antigenic Specificity):** TCR $+\text{ CD4/CD8}$ binds peptide-MHC complex.
     2. **Signal 2 (Costimulation):** **CD28** on T cell binds **B7-1 (CD80) / B7-2 (CD86)** on professional APC. *(Without Signal 2 $\implies$ **Clonal Anergy / Immune Tolerance**!)*
     3. **Signal 3 (Cytokine Differentiation):** $\text{IL-12, IL-4, TGF-}\beta, \text{IL-6}$ directing Th1, Th2, Th17, or Treg polarization.
   - **The Intracellular Kinase Relay:**
     - Coreceptor-associated **Lck kinase** phosphorylates dual tyrosines on CD3 ITAMs.
     - **ZAP-70 kinase** binds phospho-ITAMs via twin SH2 domains and is activated by Lck.
     - ZAP-70 phosphorylates transmembrane adaptor **LAT** (Linker for Activation of T cells) and **SLP-76**, assembling a signalosome that activates **PLC$\gamma 1$**:
       - $\text{IP}_3 \to \text{Ca}^{2+} \to \text{Calcineurin} \to \mathbf{\text{NFAT}}$ (Nuclear Factor of Activated T Cells).
       - $\text{DAG} \to \text{PKC}\theta \to \mathbf{\text{NF-}\kappa\text{B}}$.
       - $\text{Ras-MAPK} \to \mathbf{\text{AP-1}}$ (Fos/Jun).
       - Drives high-level transcription of **IL-2** (T-cell growth factor)!
2. **Slide 2 (`ordering`):** Provide 5 steps of TCR activation from surface binding to IL-2 gene transcription: (1) TCR and CD4/CD8 coreceptor bind the cognate foreign peptide presented on MHC by an APC, (2) the coreceptor-tethered tyrosine kinase Lck phosphorylates ITAM motifs on the cytoplasmic tails of CD3 zeta chains, (3) the cytosolic kinase ZAP-70 docks onto phosphorylated ITAMs via its tandem SH2 domains and is phosphorylated/activated by Lck, (4) active ZAP-70 phosphorylates the scaffolding protein LAT, recruiting and activating Phospholipase C-gamma 1 (PLC-gamma 1), (5) PLC-gamma 1 generates IP3 to release calcium and activate calcineurin, dephosphorylating NFAT to allow its nuclear entry and transcription of the IL-2 gene!
3. **Slide 3 (`matching`):** Pair 4 T-cell activation components (Lck Kinase, CD3 ITAMs, CD28 Costimulatory Receptor, ZAP-70 Kinase) with their specific biochemical actions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the conserved tyrosine-containing signaling motifs found in CD3 cytoplasmic tails are called ITAMs. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the two-signal model and T-cell clonal anergy: What occurs when a naive CD4+ or CD8+ T lymphocyte's TCR engages its specific peptide-MHC complex (Signal 1) on a non-professional tissue cell that completely lacks B7-1/B7-2 costimulatory molecules (lacking Signal 2)? (The T-cell fails to activate and enters a state of **CLONAL ANERGY (functional unresponsiveness)**, where it becomes permanently refractory to subsequent antigen stimulation, serving as a vital peripheral tolerance mechanism to prevent autoimmunity against healthy tissue antigens).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "t_cell_receptor_cd3_signaling_and_mhc_restriction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: TCR-CD3 Signaling & The Two-Signal Model**\n• **The Octameric TCR Complex:**\n  - **TCR $\\alpha\\beta$:** Binds peptide-MHC (conveys specificity; no signaling tails).\n  - **CD3 Dimers ($\\gamma\\epsilon, \\delta\\epsilon, \\zeta\\zeta$):** Transduce signals via **10 cytoplasmic ITAMs**.\n• **The Intracellular Phosphorylation Cascade:**\n$$\n\\text{TCR-MHC} \\xrightarrow{\\text{Lck}} \\mathbf{\\text{Phosphorylates ITAMs}} \\xrightarrow{\\text{Recruits}} \\mathbf{\\text{ZAP-70}} \\xrightarrow{\\text{Phosphorylates}} \\text{LAT} \\to \\text{PLC}\\gamma 1 \\to \\mathbf{\\text{NFAT, NF-}\\kappa\\text{B, AP-1}}\n$$\n• **The Essential 2-Signal Paradigm:**\n  - **Signal 1:** TCR engages peptide-MHC.\n  - **Signal 2:** **CD28** binds **B7-1 (CD80) / B7-2 (CD86)** on professional APC.\n  - **Critical Rule:** $\\mathbf{\\text{Signal 1 WITHOUT Signal 2}} \\implies \\mathbf{\\text{CLONAL ANERGY}}$ (Permanent immune tolerance!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential intracellular signaling steps of T-cell receptor activation leading to IL-2 transcription.",
      "orderItems": [
        "TCR and coreceptor (CD4 or CD8) bind the cognate peptide-MHC complex presented by an APC",
        "Coreceptor-associated Lck tyrosine kinase phosphorylates ITAM motifs on the cytoplasmic tails of CD3 zeta chains",
        "ZAP-70 kinase docks onto double-phosphorylated ITAMs via its twin SH2 domains and is activated by Lck",
        "Active ZAP-70 phosphorylates the membrane adaptor LAT, nucleating a signalosome that activates PLC-gamma 1",
        "PLC-gamma 1 generates IP3 to release intracellular Ca²⁺, activating calcineurin phosphatase to dephosphorylate NFAT for nuclear translocation"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each T-cell signaling component to its specific biochemical function.",
      "matchPairs": [
        { "left": "Lck Tyrosine Kinase", "right": "Src-family kinase associated with CD4/CD8 coreceptors that phosphorylates CD3 ITAM motifs" },
        { "left": "ZAP-70 Kinase", "right": "Syk-family kinase that binds phospho-ITAMs via tandem SH2 domains to phosphorylate LAT and SLP-76" },
        { "left": "CD28 Receptor", "right": "Essential costimulatory receptor on T cells that binds APC B7 ligands to deliver mandatory Signal 2" },
        { "left": "ITAMs (Immunoreceptor Tyrosine Motifs)", "right": "Conserved dual-tyrosine signaling motifs in CD3 tails that recruit SH2-domain signaling kinases" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The conserved signaling motifs located in the cytoplasmic tails of CD3 chains that are phosphorylated by Lck are termed ___ (Immunoreceptor Tyrosine-based Activation Motifs).",
      "blankAnswer": "itams",
      "blankDistractors": ["itims", "sh2", "cd28"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What happens if a naive T lymphocyte recognizes its specific peptide-MHC antigen (Signal 1) on a non-professional tissue cell that does NOT express B7 costimulatory molecules (Signal 2 absent)?",
      "options": [
        { "text": "THE T CELL ENTERS A STATE OF CLONAL ANERGY; it becomes functionally inactivated and unresponsive to all future encounters with that antigen, serving as an essential peripheral tolerance safeguard against autoimmune self-destruction", "isCorrect": true, "explanation": "Correct! Full activation and clonal expansion of naive T lymphocytes strictly requires two independent signals: Signal 1 (TCR recognition of peptide-MHC) and Signal 2 (CD28 costimulatory receptor binding to B7-1/CD80 or B7-2/CD86 on professional APCs). When a T cell encounters its specific antigen on normal peripheral tissue cells (which lack B7 molecules), Signal 1 in the absence of Signal 2 activates the E3 ubiquitin ligases GRAIL and Cbl-b. This permanently paralyzes the TCR signaling machinery, inducing 'Clonal Anergy' (functional dormancy) to ensure the immune system does not attack healthy self tissues." },
        { "text": "The T cell immediately multiplies into 10 million cells", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The T cell transforms into an antibody-secreting plasma cell", "isCorrect": false, "explanation": "Incorrect: That is a B-cell function." },
        { "text": "The T cell destroys the entire organ in 10 seconds", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
