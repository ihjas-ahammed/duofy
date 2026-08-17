# Duofy Reusable Lesson Format: T-Helper Cell Polarization (Th1, Th2, Th17, and Treg)

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Immunology / Innate_and_Adaptive_Immune_Responses`  
**Lesson Format Type:** `t_helper_cell_polarization_th1_th2_th17_and_treg`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the epigenetic programming, master transcription factors, cytokine feedback loops, and pathogen-clearing specializations of CD4+ T-helper lymphocyte lineages (Robert Coffman & Tim Mosmann 1986; Shimon Sakaguchi): contrast **Th1** (induced by **IL-12/IFN-$\gamma$**, master factor **T-bet**, secreting **IFN-$\gamma$** to activate M1 macrophages against intracellular bacteria/viruses like *M. tuberculosis*), **Th2** (induced by **IL-4**, master factor **GATA-3**, secreting **IL-4, IL-5, IL-13** to activate eosinophils, mast cells, and IgE against helminths and allergens), **Th17** (induced by **IL-6/TGF-$\beta$/IL-23**, master factor **ROR$\gamma$t**, secreting **IL-17A/F, IL-22** to recruit neutrophils against mucosal fungi and extracellular bacteria), and **Treg** (induced by **TGF-$\beta$/IL-2**, master factor **FoxP3**, expressing **CD25**, secreting **IL-10/TGF-$\beta$** for peripheral tolerance), and evaluate **IPEX Syndrome** caused by *FOXP3* mutations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 4 CD4+ T-Helper Lineages Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Naive CD4+ T Cell Th1 Differentiation and Macrophage Activation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | T-Helper Subset & Master Transcription Factor / Target Pathogen Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Th1 Lineage Master Lineage-Defining Transcription Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | FoxP3 Loss-of-Function Mutation and IPEX Autoimmune Syndrome Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CD4+ T-Helper Cell Lineage Polarization (Mosmann & Coffman 1986; Sakaguchi):
   - **The 4 Canonical Subsets:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Lineage} & \textbf{Inducing Signal} & \textbf{Master TF} & \textbf{Effector Cytokines} & \textbf{Immunological Mission} \\
     \hline
     \textbf{Th1} & \text{IL-12 (DCs), IFN-}\gamma & \mathbf{\text{T-bet}} \ (\text{STAT4}) & \mathbf{\text{IFN-}\gamma, \text{TNF-}\beta} & \text{Intracellular pathogens (*Mycobacterium*, viruses), M1 Macrophages} \\
     \textbf{Th2} & \text{IL-4, IL-2} & \mathbf{\text{GATA-3}} \ (\text{STAT6}) & \mathbf{\text{IL-4, IL-5, IL-13}} & \text{Helminth parasites, Eosinophils, IgE class switching, Asthma/Allergy} \\
     \textbf{Th17} & \text{IL-6, TGF-}\beta, \text{IL-23} & \mathbf{\text{ROR}\gamma\text{t}} \ (\text{STAT3}) & \mathbf{\text{IL-17A, IL-17F, IL-22}} & \text{Extracellular bacteria/fungi (*Candida*), Neutrophil recruitment} \\
     \textbf{Treg} & \text{TGF-}\beta, \text{IL-2} & \mathbf{\text{FoxP3}} \ (\text{STAT5}) & \mathbf{\text{IL-10, TGF-}\beta, \text{IL-35}} & \text{Peripheral tolerance, suppression of self-reactive T cells} \\
     \hline
     \end{array}$$
   - **Mutual Cross-Regulation / Antagonism:**
     - IFN-$\gamma$ (Th1) inhibits Th2 and Th17 proliferation.
     - IL-4 (Th2) inhibits Th1 and Th17 differentiation.
     - IL-10 / TGF-$\beta$ (Treg) suppresses Th1, Th2, and Th17 effector functions.
2. **Slide 2 (`ordering`):** Provide 5 steps of the Th1 polarization and cell-mediated immunity pathway: (1) a naive CD4+ T cell's TCR engages a foreign bacterial peptide presented on MHC Class II by an infected dendritic cell, (2) the dendritic cell secretes IL-12, activating STAT4 in the T cell, (3) STAT4 induces high-level expression of the master transcription factor T-bet, (4) T-bet directs chromatin remodeling to transcribe and secrete large amounts of Interferon-gamma (IFN-gamma), (5) IFN-gamma binds receptors on macrophages, activating classical M1 macrophage bactericidal killing (inducible nitric oxide synthase iNOS and reactive oxygen species) to destroy intracellular pathogens!
3. **Slide 3 (`matching`):** Pair 4 T-helper subsets (Th1, Th2, Th17, Treg) with their master transcription factors (T-bet, GATA-3, ROR-gamma-t, FoxP3).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the master transcription factor that commits naive T cells to the Th1 lineage is T-bet. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the clinical genetics of *FOXP3* mutations: A male infant presents with intractable diarrhea, type 1 diabetes, severe eczematous dermatitis, and massive multi-organ autoimmune lymphoproliferation (IPEX syndrome). What is the primary molecular etiology? (Mutations in the **FOXP3** gene, which prevents the development and function of **$\text{CD4}^+\text{CD25}^+\text{FoxP3}^+$ Regulatory T cells (Tregs)**, abolishing peripheral immune tolerance and permitting uninhibited, lethal autoimmune attack by self-reactive effector T cells).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "t_helper_cell_polarization_th1_th2_th17_and_treg",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CD4+ T-Helper Lineage Polarization**\n• **The 4 Master Lineages:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Subset} & \\textbf{Master TF} & \\textbf{Effector Cytokines} & \\textbf{Primary Target} \\\\\n\\hline\n\\textbf{Th1} & \\mathbf{\\text{T-bet}} & \\mathbf{\\text{IFN-}\\gamma, \\text{TNF-}\\beta} & \\text{Intracellular bugs (*M. tb*), M1 Macrophages} \\\\\n\\textbf{Th2} & \\mathbf{\\text{GATA-3}} & \\mathbf{\\text{IL-4, IL-5, IL-13}} & \\text{Parasitic Helminths, Eosinophils, IgE} \\\\\n\\textbf{Th17} & \\mathbf{\\text{ROR}\\gamma\\text{t}} & \\mathbf{\\text{IL-17A, IL-17F, IL-22}} & \\text{Mucosal Fungi (*Candida*), Neutrophils} \\\\\n\\textbf{Treg} & \\mathbf{\\text{FoxP3}} & \\mathbf{\\text{IL-10, TGF-}\\beta} & \\text{Immune Tolerance, Autoimmune Suppression} \\\\\n\\hline\n\\end{array}\n$$\n• **Mutual Antagonism:** IFN-$\\gamma$ (Th1) blocks Th2/Th17; IL-4 (Th2) blocks Th1/Th17; FoxP3+ Tregs suppress all effector arms to maintain self-tolerance!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Th1 lineage commitment and cell-mediated macrophage activation.",
      "orderItems": [
        "A naive CD4+ T cell recognizes bacterial peptide-MHC II on a dendritic cell that has sensed intracellular bacteria",
        "The dendritic cell releases IL-12, which binds its receptor on the naive T cell to activate STAT4 phosphorylation",
        "Phosphorylated STAT4 drives the transcription of the master lineage-defining transcription factor T-bet",
        "T-bet commits the cell to the Th1 fate and drives high-level production of Interferon-gamma (IFN-gamma)",
        "IFN-gamma binds macrophage receptors to upregulate iNOS and NADPH oxidase, destroying intracellular pathogens"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CD4+ T-helper subset to its master transcription factor.",
      "matchPairs": [
        { "left": "Th1 T-Helper Lineage", "right": "T-bet (STAT4-dependent; drives IFN-gamma production for intracellular pathogen defense)" },
        { "left": "Th2 T-Helper Lineage", "right": "GATA-3 (STAT6-dependent; drives IL-4/IL-5/IL-13 production for anti-helminth defense)" },
        { "left": "Th17 T-Helper Lineage", "right": "ROR-gamma-t (STAT3-dependent; drives IL-17/IL-22 production for neutrophil recruitment)" },
        { "left": "Regulatory T Cell (Treg)", "right": "FoxP3 (STAT5-dependent; drives IL-10/TGF-beta production to maintain immune tolerance)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The master lineage-defining transcription factor responsible for polarizing naive CD4+ T cells into the IFN-gamma-secreting Th1 lineage is ___-bet.",
      "blankAnswer": "t",
      "blankDistractors": ["gata", "ror", "fox"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the molecular and immunological mechanism underlying IPEX syndrome (Immune Dysregulation, Polyendocrinopathy, Enteropathy, X-linked) in affected infants?",
      "options": [
        { "text": "Loss-of-function mutations in the FOXP3 gene prevent the development and function of CD4+CD25+ regulatory T cells (Tregs), completely abolishing peripheral immune tolerance and permitting uncontrolled multi-organ autoimmune destruction by autoreactive T cells", "isCorrect": true, "explanation": "Correct! FOXP3 is the master transcription factor that programs the development and immunosuppressive identity of Regulatory T cells (Tregs). In peripheral tissues, Tregs continuously suppress self-reactive T cells that escaped negative selection in the thymus using inhibitory cytokines (IL-10, TGF-beta) and CTLA-4. In IPEX syndrome (caused by hemizygous FOXP3 mutations on the X chromosome), Tregs fail to develop. Without Treg suppression, self-reactive CD4+ and CD8+ effector T cells attack host endocrine tissues, intestinal mucosa, and skin, causing fatal autoimmune polyendocrinopathy (Type 1 diabetes, thyroiditis) and severe enteropathy unless treated by bone marrow transplantation." },
        { "text": "Excessive production of antibodies by hyperactive B cells only", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Total absence of neutrophils in the blood", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Viral destruction of the thymus gland at birth", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
