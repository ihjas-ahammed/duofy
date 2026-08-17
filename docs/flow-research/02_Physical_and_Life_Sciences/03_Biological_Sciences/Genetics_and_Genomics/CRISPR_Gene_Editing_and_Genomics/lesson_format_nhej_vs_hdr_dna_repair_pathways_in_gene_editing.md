# Duofy Reusable Lesson Format: NHEJ vs HDR DNA Repair Pathways in Gene Editing

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / CRISPR_Gene_Editing_and_Genomics`  
**Lesson Format Type:** `nhej_vs_hdr_dna_repair_pathways_in_gene_editing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the competing endogenous DNA repair pathways harnessed following targeted nuclease-induced Double-Strand Breaks (DSBs): contrast **Non-Homologous End Joining (NHEJ)** (error-prone direct end-ligation mediated by **Ku70/Ku80, DNA-PKcs, Artemis, and DNA Ligase IV/XRCC4**, active throughout all cell cycle phases, introducing stochastic insertions/deletions [**Indels**] causing frameshifts $\to$ **Functional Gene Knockout**) with **Homology-Directed Repair (HDR)** (high-fidelity template-dependent repair mediated by **MRE11-RAD50-NBS1 [MRN], CtIP end resection, RPA, RAD51 nucleoprotein filaments**, active strictly during **late $S / G_2$ phases**, using an exogenous **ssODN / dsDNA donor template** flanked by homology arms $\to$ **Precise Gene Knock-In / Correction**), and evaluate strategies to enhance HDR efficiency (cell synchronization, NHEJ inhibitors like SCR7).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | NHEJ vs HDR DNA Repair Paradigms Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step HDR-Mediated Precise Gene Knock-In Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Repair Pathway / Protein & Biological Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Precise Homology-Directed DNA Repair Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Cell Cycle Phase Restriction of Homology-Directed Repair Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State NHEJ vs HDR DNA Double-Strand Break Repair Pathways:
   - **The Post-Cleavage Cellular Choice:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Feature} & \textbf{NHEJ (Non-Homologous End Joining)} & \textbf{HDR (Homology-Directed Repair)} \\
     \hline
     \textbf{Fidelity} & \text{Error-Prone (stochastic Indels: }+1\text{ to }-20\text{ bp)} & \textbf{High-Fidelity / Error-Free} \\
     \textbf{Donor Template} & \textbf{None required} & \textbf{Requires Donor DNA (ssODN or plasmid)} \\
     \textbf{Cell Cycle Timing} & \textbf{Active throughout all phases ($G_1, S, G_2, M$)} & \textbf{Restricted strictly to late $S / G_2$ phases} \\
     \textbf{Key Machinery} & \text{Ku70/80, DNA-PKcs, Artemis, Ligase IV} & \text{MRN complex, CtIP, RPA, RAD51, DNA Pol } \delta \\
     \textbf{Gene Editing Goal} & \textbf{Gene Knockout (frameshift nonsense)} & \textbf{Gene Knock-In / Point Mutation Correction} \\
     \hline
     \end{array}$$
   - **Mechanism of Gene Knockout via NHEJ:**
     - Cas9 cuts $\to$ NHEJ ligates with insertion/deletion of 1–2 nucleotides $\to$ shifts open reading frame $\to$ introduces Premature Termination Codon (PTC) $\to$ **Nonsense-Mediated Decay (NMD)** degrades mRNA!
   - **Mechanism of Precise Editing via HDR:**
     - $5' \to 3'$ DNA end resection generates $3'$ single-stranded overhangs $\to$ **RAD51** coats ssDNA $\to$ strand invasion into exogenous donor template $\to$ DNA polymerase copies desired edit $\to$ ligation.
2. **Slide 2 (`ordering`):** Provide 5 steps of HDR-mediated precise gene knock-in: (1) Cas9-sgRNA creates a targeted double-strand break at the mutation site, (2) the MRN complex and CtIP nuclease perform $5' \to 3'$ resection of the broken DNA ends to expose long $3'$ single-stranded DNA tails, (3) RPA binds the single strands, followed by BRCA2-mediated loading of RAD51 recombinase to form a presynaptic nucleoprotein filament, (4) the RAD51 filament invades the co-delivered exogenous donor template DNA (ssODN) harboring the corrected sequence and homology arms, (5) DNA polymerase extends from the $3'$ invaded end copying the donor template edit, followed by Holliday junction resolution and ligation to complete high-fidelity knock-in!
3. **Slide 3 (`matching`):** Pair 4 DNA repair proteins (Ku70/Ku80 Heterodimer, RAD51 Recombinase, DNA Ligase IV / XRCC4, CtIP Endonuclease) with their specific repair functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the high-fidelity template-dependent DNA repair pathway utilized for gene knock-in is Homology-Directed Repair (abbreviated HDR). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on cell cycle restriction of HDR: Why is HDR-mediated gene editing notoriously inefficient in non-dividing, post-mitotic cells (such as adult neurons or cardiomyocytes), leaving NHEJ as the sole active pathway? (Because **HDR requires high levels of key homologous recombination machinery (such as RAD51, CtIP, and CDK1-mediated phosphorylation) that are expressed exclusively during the late $S$ and $G_2$ phases of the cell cycle** when sister chromatids are naturally present; in quiescent $G_0 / G_1$ cells, end resection is suppressed, leaving only NHEJ functional).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nhej_vs_hdr_dna_repair_pathways_in_gene_editing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: NHEJ vs. HDR DNA Repair in Genome Editing**\n• **1. Non-Homologous End Joining (NHEJ):**\n  - **Timing:** Active throughout the entire cell cycle ($G_0, G_1, S, G_2, M$).\n  - **Machinery:** Ku70/80 + DNA-PKcs + Artemis + DNA Ligase IV.\n  - **Outcome:** Direct end ligation with stochastic **Indels (Insertions/Deletions)** $\\implies$ Frameshift mutations $\\implies$ **Gene Knockout**.\n• **2. Homology-Directed Repair (HDR):**\n  - **Timing:** Restricted strictly to **late $S / G_2$ phases**.\n  - **Machinery:** MRN complex + CtIP ($5'\\to 3'$ resection) + **RAD51** + Polymerase $\\delta$.\n  - **Outcome:** Uses an exogenous **donor DNA template (ssODN)** flanked by homology arms $\\implies$ **High-Fidelity Gene Knock-In / Base Correction**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential molecular steps of HDR-mediated precise gene knock-in using a donor template.",
      "orderItems": [
        "Cas9 generates a targeted blunt double-strand break (DSB) at the designated genomic locus",
        "The MRN complex and CtIP nuclease execute 5' to 3' resection of the broken ends, exposing 3' single-stranded DNA overhangs",
        "RPA binds the ssDNA tails and is displaced by RAD51 recombinase to form a nucleoprotein filament",
        "The RAD51 filament catalyzes strand invasion into the co-delivered donor DNA template (ssODN) containing the desired edit",
        "DNA polymerase synthesizes the new sequence from the donor template, followed by resolution and ligation to complete precise knock-in"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each DNA repair protein to its specific biological function.",
      "matchPairs": [
        { "left": "Ku70 / Ku80 Heterodimer", "right": "Binds broken DNA ends with high affinity to initiate Non-Homologous End Joining (NHEJ)" },
        { "left": "RAD51 Recombinase", "right": "Forms nucleoprotein filaments on single-stranded DNA to drive homologous strand invasion during HDR" },
        { "left": "DNA Ligase IV / XRCC4 Complex", "right": "Executes direct covalent end ligation during classical NHEJ" },
        { "left": "CtIP Nuclease", "right": "Promotes 5' to 3' end resection at double-strand breaks to license homologous recombination in S/G2" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The high-fidelity, template-dependent DNA repair pathway utilized by researchers to perform precise gene knock-in is ___ (Homology-Directed Repair).",
      "blankAnswer": "hdr",
      "blankDistractors": ["nhej", "ber", "ner"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is precise HDR-mediated gene editing notoriously difficult and inefficient in post-mitotic, non-dividing human cells (such as adult neurons and skeletal muscle)?",
      "options": [
        { "text": "Essential homologous recombination proteins (such as RAD51 and active resection factors) are expressed and licensed exclusively during the late S and G2 phases of the cell cycle; in G0/G1 quiescent cells, HDR is shut down and NHEJ remains the only active repair pathway", "isCorrect": true, "explanation": "Correct! Homology-Directed Repair evolved to repair replication-associated double-strand breaks using the sister chromatid as a template, which is only present during the late S and G2 phases of the cell cycle. Key enzymes like CtIP and RAD51 require CDK-mediated phosphorylation that only occurs in dividing cells. In non-dividing (G0) post-mitotic cells like mature neurons, HDR activity is virtually zero, meaning Cas9 double-strand breaks are repaired almost exclusively by error-prone NHEJ." },
        { "text": "Because neurons do not contain genomic DNA", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because non-dividing cells destroy all RNA immediately", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Cas9 cannot enter the cytoplasm of adult cells", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
