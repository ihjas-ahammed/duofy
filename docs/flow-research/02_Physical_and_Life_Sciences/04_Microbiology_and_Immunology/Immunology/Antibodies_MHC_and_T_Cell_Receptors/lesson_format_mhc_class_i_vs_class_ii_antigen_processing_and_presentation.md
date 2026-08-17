# Duofy Reusable Lesson Format: MHC Class I vs Class II Antigen Processing and Presentation

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Immunology / Antibodies_MHC_and_T_Cell_Receptors`  
**Lesson Format Type:** `mhc_class_i_vs_class_ii_antigen_processing_and_presentation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the cell biology, intracellular compartmentalization, and molecular chaperones of antigen processing and presentation (Rolf Zinkernagel & Peter Doherty, Nobel Prize in Physiology or Medicine 1996; Emil Unanue): contrast the **Endogenous MHC Class I Pathway** (cytosolic viral/tumor proteins degraded by the **Immunoproteasome**, pumped into ER lumen by **TAP1/TAP2**, loaded onto **HLA-A/B/C + $\beta_2$-microglobulin** with closed cleft holding **$8-10\text{ aa}$ peptides**, presented to **CD8+ Cytotoxic T Cells** on all nucleated cells) with the **Exogenous MHC Class II Pathway** (phagocytosed/endocytosed pathogens digested in endolysosomes, newly synthesized **HLA-DP/DQ/DR $\alpha\beta$ heterodimers** protected in ER by **Invariant Chain [Ii]**, endosomal cleavage leaving **CLIP**, **HLA-DM** catalyzing peptide exchange in open cleft holding **$13-25\text{ aa}$ peptides**, presented to **CD4+ Helper T Cells** on professional APCs), and analyze **Cross-Presentation by CD8$\alpha$+ Dendritic Cells**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | MHC Class I vs MHC Class II Pathways Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Exogenous MHC Class II Processing & CLIP Exchange Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Processing Molecule / Chaperone & Specific Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Transporter Associated with Antigen Processing Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Rule of 8 and Viral Immune Evasion via TAP Blockade Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State MHC Class I vs MHC Class II Antigen Presentation Pathways:
   - **The Dual-Pathway Architecture (1996 Nobel Prize):**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Feature} & \textbf{MHC Class I Pathway} & \textbf{MHC Class II Pathway} \\
     \hline
     \textbf{Source of Antigen} & \textbf{Endogenous} \text{ (Cytosolic viruses, tumors, intracellular)} & \textbf{Exogenous} \text{ (Phagocytosed extracellular microbes)} \\
     \textbf{Degradation Machinery} & \textbf{Immunoproteasome} \text{ in Cytosol} & \textbf{Endolysosomal Acid Proteases (Cathepsins)} \\
     \textbf{Peptide Transporter} & \mathbf{\text{TAP1 / TAP2}} \text{ (pumps peptides into ER)} & \text{None (Direct endosomal fusion)} \\
     \textbf{ER Chaperones} & \text{Calreticulin, Tapasin, ERp57} & \mathbf{\text{Invariant Chain (Ii) } \to \text{CLIP + HLA-DM}} \\
     \textbf{Polypeptide Structure} & \mathbf{\alpha_1, \alpha_2, \alpha_3 + \beta_2\text{-microglobulin}} & \mathbf{\alpha_1, \alpha_2 + \beta_1, \beta_2 \text{ heterodimer}} \\
     \textbf{Peptide Length / Cleft} & \mathbf{8-10\text{ amino acids}} \text{ (Closed ends)} & \mathbf{13-25\text{ amino acids}} \text{ (Open ends)} \\
     \textbf{Cellular Expression} & \textbf{All nucleated cells} \text{ (plus platelets)} & \textbf{Professional APCs only} \text{ (DCs, Macrophages, B cells)} \\
     \textbf{Target T Lymphocyte} & \mathbf{\text{CD8}^+ \text{ Cytotoxic T Cells}} \ (1 \times 8 = 8) & \mathbf{\text{CD4}^+ \text{ Helper T Cells}} \ (2 \times 4 = 8) \\
     \hline
     \end{array}$$
   - **Cross-Presentation:** Specialized dendritic cells (cDC1) ingest exogenous viral/tumor fragments and shunt them into the cytosol for MHC Class I loading to prime naive CD8+ T cells!
2. **Slide 2 (`ordering`):** Provide 5 steps of the MHC Class II exogenous antigen presentation pathway: (1) an extracellular bacterium is engulfed by a dendritic cell via phagocytosis into an endosome, (2) in the ER, newly synthesized MHC Class II heterodimers assemble with the Invariant Chain (Ii), which inserts its CLIP region into the peptide-binding groove to prevent premature ER peptide binding, (3) the MHC II-Ii complex travels via the Golgi to the acidified late endosome/MIIC compartment, where cathepsins degrade the invariant chain, leaving only the short CLIP fragment in the groove, (4) the chaperone protein HLA-DM binds MHC Class II, dislodging CLIP and stabilizing the groove to allow high-affinity foreign bacterial peptides to bind, (5) the stable peptide-MHC Class II complex is transported to the plasma membrane to present the antigen to CD4+ Helper T cells!
3. **Slide 3 (`matching`):** Pair 4 antigen processing chaperones (TAP1/TAP2 Transporter, Invariant Chain Ii, CLIP Peptide, HLA-DM) with their molecular functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the ATP-dependent heterodimeric transporter that pumps cytosolic peptides into the ER lumen for MHC Class I loading is TAP. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on viral immune evasion targeting MHC Class I: Herpes Simplex Virus (HSV) produces the protein ICP47, which specifically blocks and inhibits the TAP1/TAP2 peptide transporter on the ER membrane. What is the immunological consequence of this viral strategy? (Without functional TAP, **cytosolic viral peptides cannot enter the ER lumen to be loaded onto MHC Class I molecules**, causing nascent MHC I to be degraded and preventing infected cells from displaying viral antigens on their surface, allowing the virus to hide from **CD8+ Cytotoxic T Cells**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mhc_class_i_vs_class_ii_antigen_processing_and_presentation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: MHC Class I vs. Class II Antigen Processing (1996 Nobel)**\n• **The Rule of 8:** $\\text{MHC I} \\times \\text{CD8} = 8$ and $\\text{MHC II} \\times \\text{CD4} = 8$.\n• **1. MHC Class I (Endogenous / Cytosolic Pathway):**\n  - **Antigen Source:** Intracellular viral/tumor proteins degraded by **Immunoproteasome**.\n  - **Loading:** **TAP1/2** pumps $8\\text{--}10\\text{ aa}$ peptides into ER $\\to$ Loaded on **$\\alpha + \\beta_2\\text{-microglobulin}$** $\\to$ Exported to **CD8+ Cytotoxic T Cells** on **all nucleated cells**.\n• **2. MHC Class II (Exogenous / Endosomal Pathway):**\n  - **Antigen Source:** Extracellular microbes digested by endolysosomal cathepsins.\n  - **Loading:** ER **Invariant Chain (Ii)** blocks groove $\\to$ Endosome degrades Ii to **CLIP** $\\to$ **HLA-DM** catalyzes CLIP exchange for $13\\text{--}25\\text{ aa}$ peptide $\\to$ Presented to **CD4+ Helper T Cells** on **Professional APCs**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the exogenous MHC Class II antigen presentation pathway.",
      "orderItems": [
        "A dendritic cell engulfs extracellular bacterial pathogens via receptor-mediated endocytosis into an acidified endosome",
        "In the ER, nascent MHC Class II alpha/beta heterodimers assemble with the Invariant Chain (Ii), which blocks the peptide cleft",
        "The MHC II-Ii complex routes to the late endosomal MIIC compartment, where cathepsins degrade Ii down to the residual CLIP fragment",
        "The non-classical chaperone HLA-DM catalyzes the release of CLIP, allowing high-affinity processed bacterial peptides to bind",
        "The stable peptide-MHC Class II complex is trafficked to the cell surface for presentation to CD4+ T-helper cells"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each antigen processing factor to its specific molecular role.",
      "matchPairs": [
        { "left": "TAP1 / TAP2 Transporter", "right": "ATP-dependent ER membrane transporter pumping proteasome-derived cytosolic peptides into the ER lumen" },
        { "left": "Invariant Chain (Ii / CD74)", "right": "Trimeric ER chaperone that targets MHC Class II to endosomes and prevents premature peptide binding in the ER" },
        { "left": "CLIP (Class II-associated Invariant Chain Peptide)", "right": "Residual peptide fragment occupying the MHC Class II groove following endosomal cathepsin cleavage" },
        { "left": "HLA-DM Chaperone", "right": "Catalytic endosomal protein that removes CLIP to facilitate loading of high-affinity exogenous peptides" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In MHC Class I antigen processing, the heterodimeric ABC transporter that pumps cytosolic peptides into the endoplasmic reticulum is ___.",
      "blankAnswer": "tap",
      "blankDistractors": ["clip", "mhc", "tcr"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Herpes Simplex Virus (HSV) synthesizes a virulence protein called ICP47 that binds and potently blocks the TAP1/TAP2 transporter in infected human cells. How does this promote viral survival?",
      "options": [
        { "text": "Blocking TAP prevents cytosolic viral peptides from entering the endoplasmic reticulum, halting MHC Class I peptide loading and cell-surface presentation, rendering the infected cell invisible to CD8+ Cytotoxic T Lymphocytes", "isCorrect": true, "explanation": "Correct! CD8+ cytotoxic T lymphocytes recognize and kill virus-infected cells by inspecting viral peptides displayed on cell-surface MHC Class I molecules. For MHC Class I to fold properly and traffic to the cell surface, it must bind an 8-10 amino acid peptide in the ER lumen. TAP1/TAP2 is the sole molecular pipeline pumping proteasome-generated cytosolic viral peptides into the ER. By producing ICP47 to block the cytosolic substrate-binding face of TAP, HSV prevents viral peptides from ever reaching MHC Class I. Empty MHC I is degraded in the ER, leaving the infected cell with virtually zero surface MHC I and effectively hiding the viral factory from CD8+ T-cell killing." },
        { "text": "It converts all viral RNA into human hemoglobin", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It forces the infected cell to produce bacterial peptidoglycan", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It causes all T cells in the body to dissolve", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
