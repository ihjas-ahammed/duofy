# Duofy Reusable Lesson Format: Receptor Tyrosine Kinases and the Ras-MAPK Cascade

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / Signal_Transduction_and_Cell_Cycle_Control`  
**Lesson Format Type:** `receptor_tyrosine_kinases_and_ras_mapk_cascade`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular activation, adaptor protein recruitment, and kinase relay cascades of Receptor Tyrosine Kinases (Tony Hunter, Joseph Schlessinger, Tony Pawson): formulate growth factor-induced **RTK Dimerization and Trans-Autophosphorylation** creating phosphotyrosine docking sites for **SH2 domains (Grb2)**, trace the assembly of the **Grb2-SOS complex** driving GDP-to-GTP exchange on membrane-anchored **Ras GTPase**, master the 3-tiered **Mitogen-Activated Protein Kinase (MAPK) Cascade (Ras-GTP $\to$ Raf [MAPKKK] $\to$ MEK [MAPKK] $\to$ ERK [MAPK])**, examine nuclear translocation of ERK to activate transcription factors (**c-Myc, c-Fos, c-Jun**), and evaluate oncogenic **Ras mutations (e.g. G12V/G12D)** that abolish GAP-mediated GTP hydrolysis.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RTK Activation & Ras-MAPK Cascade Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step RTK Ligand Binding to ERK Nuclear Translocation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Signaling Molecule & Cascade Tier / Biochemical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Phosphotyrosine-Binding Protein Domain Standard Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Oncogenic Ras G12V Mutation GTPase Defect Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State RTK Dimerization & The Ras-MAPK Kinase Relay:
   - **RTK Activation (e.g. EGFR, FGFR, PDGFR):**
     - Ligand (EGF) binds extracellular domain $\to$ RTK forms homodimer / heterodimer.
     - Dimerization stimulates intrinsic tyrosine kinase domains to catalyze **Trans-Autophosphorylation** on cytoplasmic tyrosine residues.
     - Phosphotyrosines act as high-affinity docking sites for **SH2 (Src Homology 2)** and **PTB** domains.
   - **The Adaptor Relay (Grb2 & SOS):**
     - **Grb2** binds phosphotyrosines via its **SH2 domain**, and recruits the exchange factor **SOS (Son of Sevenless)** via its **SH3 domains**.
     - **SOS (Ras-GEF)** stimulates membrane-anchored **Ras** to discard GDP and bind GTP ($\text{Ras-GDP} \to \mathbf{\text{Ras-GTP}}$).
   - **The 3-Tiered MAPK Cascade (Signal Amplification):**
     $$\mathbf{Ras\text{-}GTP} \longrightarrow \mathbf{Raf\text{ (MAPKKK, Ser/Thr kinase)}} \xrightarrow{\text{Phosphorylates}} \mathbf{MEK1/2\text{ (MAPKK, Dual-specificity)}} \xrightarrow{\text{Phosphorylates}} \mathbf{ERK1/2\text{ (MAPK)}}$$
   - **Nuclear Action:** Phosphorylated ERK dimerizes and translocates into the nucleus, activating transcription factors (**c-Fos, c-Jun, c-Myc**) that upregulate **Cyclin D** to drive cell cycle entry.
2. **Slide 2 (`ordering`):** Provide 5 steps of the RTK-Ras-MAPK cascade: (1) epidermal growth factor (EGF) binds the extracellular domain of the EGFR monomer, inducing receptor dimerization, (2) the paired cytoplasmic kinase domains perform reciprocal trans-autophosphorylation on specific tyrosine residues, (3) the adaptor protein Grb2 docks onto phosphotyrosines via its SH2 domain and uses its SH3 domains to recruit SOS (Ras-GEF), (4) SOS stimulates membrane-bound Ras to exchange GDP for GTP, activating Ras, (5) Ras-GTP recruits and activates Raf kinase (MAPKKK), which sequentially phosphorylates and activates MEK (MAPKK) and then ERK (MAPK), allowing ERK to enter the nucleus to induce transcription!
3. **Slide 3 (`matching`):** Pair 4 components of the cascade (Grb2 Adaptor, SOS Protein, Raf Kinase, MEK1/2 Kinase) with their specific biochemical actions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that protein domains that specifically recognize and bind phosphorylated tyrosine residues are termed SH2 domains. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on oncogenic Ras mutations in human cancers: In approximately $30\%$ of all human tumors (including $>90\%$ of pancreatic cancers), the *KRAS* gene carries point mutations at codon 12 (e.g. G12V or G12D). How does this single amino acid substitution drive continuous, uncontrolled cell proliferation? (The mutation **locks the Ras catalytic pocket, preventing GTPase-Activating Proteins (GAPs) from stimulating GTP hydrolysis, permanently freezing Ras in the active GTP-bound state** and driving constitutive, growth-factor-independent MAPK signaling).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "receptor_tyrosine_kinases_and_ras_mapk_cascade",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Receptor Tyrosine Kinases and the Ras-MAPK Cascade**\n• **RTK Activation & Autophosphorylation:**\n  - Growth Factor binding $\\to$ RTK Dimerization $\\to$ Trans-Autophosphorylation on Tyrosines.\n  - Phosphotyrosines recruit **SH2-domain** adaptors (**Grb2**).\n• **Ras Activation:**\n  - **Grb2** (SH2/SH3) recruits **SOS (Ras-GEF)** $\\to$ Exchanges $\\text{GDP} \\to \\text{GTP}$ on membrane-bound **Ras**.\n• **The 3-Tiered MAPK Phosphorylation Cascade:**\n$$\n\\mathbf{Ras\\text{-}GTP} \\longrightarrow \\mathbf{Raf\\text{ (MAPKKK)}} \\xrightarrow{\\text{Phosphorylates}} \\mathbf{MEK\\text{ (MAPKK)}} \\xrightarrow{\\text{Phosphorylates}} \\mathbf{ERK\\text{ (MAPK)}}\n$$\n• **Nuclear Response:**\n  - Phosphorylated **ERK** enters nucleus $\\implies$ Activates **Myc, Fos, Jun** $\\implies$ Upregulates **Cyclin D** to drive $G_1 \\to S$ cell cycle progression!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential molecular steps of the RTK-Ras-MAPK signaling cascade.",
      "orderItems": [
        "Growth factor binding induces receptor dimerization and reciprocal trans-autophosphorylation on cytoplasmic tyrosine residues",
        "The adaptor protein Grb2 binds phosphotyrosines via its SH2 domain and recruits the exchange factor SOS via its SH3 domains",
        "SOS stimulates membrane-anchored Ras to exchange GDP for GTP, converting Ras into its active GTP-bound conformation",
        "Ras-GTP recruits and activates Raf kinase (MAPKKK) at the plasma membrane",
        "Raf phosphorylates MEK (MAPKK), which phosphorylates ERK (MAPK), prompting ERK to translocate into the nucleus to activate transcription"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each signaling component to its specific biochemical classification.",
      "matchPairs": [
        { "left": "Grb2 Adaptor Protein", "right": "Bridges phosphotyrosine (via SH2 domain) to proline-rich SOS exchange factor (via SH3 domains)" },
        { "left": "SOS (Son of Sevenless)", "right": "Guanine nucleotide exchange factor (GEF) that activates Ras by accelerating GDP dissociation" },
        { "left": "Raf Kinase (MAPKKK)", "right": "Serine/threonine kinase directly activated by binding to membrane-anchored Ras-GTP" },
        { "left": "MEK1/2 Kinase (MAPKK)", "right": "Dual-specificity kinase that phosphorylates both threonine and tyrosine residues on ERK" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Modular protein domains that specifically recognize and dock onto phosphorylated tyrosine residues on activated RTKs are termed ___ domains (Src Homology 2).",
      "blankAnswer": "sh2",
      "blankDistractors": ["sh3", "ph", "c2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why do oncogenic point mutations at codon 12 of the Ras protein (e.g. KRAS G12V or G12D) cause relentless, growth-factor-independent tumor cell proliferation?",
      "options": [
        { "text": "The mutation physically blocks the catalytic binding of Ras-GAPs, preventing GTP hydrolysis and locking Ras PERMANENTLY IN THE ACTIVE GTP-BOUND STATE, generating a continuous downstream Raf-MEK-ERK proliferative signal even in the total absence of growth factors", "isCorrect": true, "explanation": "Correct! Normally, Ras acts as a brief molecular switch: it is turned on by GEFs (SOS) and rapidly turned off by GTPase-Activating Proteins (GAPs), which accelerate Ras's slow intrinsic GTPase activity by over 100,000-fold. Oncogenic mutations at Gly12 (G12V/G12D) introduce bulky side chains that obstruct the catalytic 'arginine finger' of GAP. Unable to hydrolyze GTP to GDP, Ras remains permanently switched ON, constitutively driving cell division and cancer." },
        { "text": "The mutation converts Ras into a DNA polymerase", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The mutation destroys all lysosomes in the cell", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The mutation makes Ras soluble in water", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
