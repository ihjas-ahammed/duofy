# Duofy Reusable Lesson Format: The Baltimore Classification and Viral Replication Strategies

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Bacteriology_and_Virology / Viral_Replication_Vectors_and_Antivirals`  
**Lesson Format Type:** `baltimore_classification_and_viral_replication_strategies`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the genomic architectures, transcription pathways, and replication enzymes of the 7 Baltimore Viral Classes (David Baltimore, Nobel Prize in Physiology or Medicine 1975): master the unifying rule that **all viral genomes must produce positive-sense (+)mRNA to be translated by host ribosomes**, contrast the replication enzymes and structural requirements of **Group I (dsDNA)**, **Group II (ssDNA)**, **Group III (dsRNA)**, **Group IV ((+)ssRNA: naked genome is directly infectious without virion polymerase)**, **Group V ((-)ssRNA: virion must package an active RNA-dependent RNA polymerase [RdRP])**, **Group VI (ssRNA-RT Retroviruses: Reverse Transcriptase $+$ Integrase)**, and **Group VII (dsDNA-RT Hepadnaviruses: pre-genomic RNA intermediate)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 7 Baltimore Groups & mRNA Synthesis Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Retroviral (Group VI) Reverse Transcription and Integration Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Baltimore Group & Genome Type / Clinical Example Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Universal Positive-Sense Messenger RNA Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Negative-Sense RNA Virus Mandatory Virion Polymerase Packaging Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Baltimore Classification Scheme (David Baltimore, 1971):
   - **The 7 Baltimore Classes:**
     $$\begin{array}{|c|l|l|l|}
     \hline
     \textbf{Group} & \textbf{Genome Configuration} & \textbf{mRNA Synthesis Pathway} & \textbf{Classic Viruses} \\
     \hline
     \textbf{I} & \text{Double-Stranded DNA (dsDNA)} & \text{dsDNA} \to \mathbf{(+)\text{mRNA}} & \text{Herpes Simplex, Adenovirus, Poxvirus} \\
     \textbf{II} & \text{Single-Stranded DNA (ssDNA)} & \text{ssDNA} \to \text{dsDNA intermediate} \to \mathbf{(+)\text{mRNA}} & \text{Parvovirus B19} \\
     \textbf{III} & \text{Double-Stranded RNA (dsRNA)} & \text{dsRNA} \xrightarrow{\text{Viral RdRP}} \mathbf{(+)\text{mRNA}} & \text{Rotavirus (Reoviridae)} \\
     \textbf{IV} & \mathbf{\text{Positive-Sense ssRNA ((+)ssRNA)}} & \mathbf{\text{Genome IS mRNA (Directly Translated)}} & \text{Poliovirus, SARS-CoV-2, HCV, Dengue} \\
     \textbf{V} & \mathbf{\text{Negative-Sense ssRNA ((-)ssRNA)}} & \text{(-)ssRNA} \xrightarrow{\mathbf{\text{Packaged RdRP}}} \mathbf{(+)\text{mRNA}} & \text{Influenza, Rabies, Measles, Ebola} \\
     \textbf{VI} & \text{Single-Stranded RNA with RT (ssRNA-RT)} & \text{ssRNA} \xrightarrow{\mathbf{\text{RT}}} \text{dsDNA} \xrightarrow{\text{Integrase}} \text{Host Genome} & \text{HIV-1, HIV-2, HTLV-1} \\
     \textbf{VII} & \text{Double-Stranded DNA with RT (dsDNA-RT)} & \text{dsDNA} \to \text{pgRNA} \xrightarrow{\mathbf{\text{RT}}} \text{Gapped dsDNA} & \text{Hepatitis B Virus (HBV)} \\
     \hline
     \end{array}$$
   - **The Golden Polymerase Rules:**
     - **Group IV ((+)ssRNA):** Naked genomic RNA purified from virions is **inherently infectious** when injected into host cells (host ribosomes immediately translate viral RdRP).
     - **Group V ((-)ssRNA):** Naked genomic RNA is **NOT infectious** on its own, because eukaryotic host cells possess zero RNA-dependent RNA polymerases; the virion **MUST package viral RdRP inside the capsid**!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Group VI retroviral replication cycle: (1) HIV gp120/gp41 envelope glycoproteins bind host CD4 and CCR5/CXCR4 coreceptors, mediating viral membrane fusion, (2) the viral capsid uncoats in the cytoplasm, releasing two copies of (+)ssRNA and viral enzymes, (3) viral Reverse Transcriptase copies the RNA genome into a linear double-stranded complementary DNA (cDNA) molecule with Long Terminal Repeats (LTRs), (4) viral Integrase tethers the viral dsDNA, translocates into the nucleus, and permanently inserts it into the host chromosome as a provirus, (5) host RNA Polymerase II transcribes the integrated provirus into viral mRNAs and genomic RNAs for polyprotein translation and new virion budding!
3. **Slide 3 (`matching`):** Pair 4 Baltimore groups (Group I dsDNA, Group IV (+)ssRNA, Group V (-)ssRNA, Group VI ssRNA-RT) with their representative viruses (Herpesvirus, SARS-CoV-2 / Polio, Influenza / Rabies, HIV-1).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the universal nucleic acid intermediate that all 7 Baltimore groups must synthesize to translate proteins is messenger RNA (abbreviated mRNA). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the infectivity of purified viral RNA: Why is purified, protein-free genomic RNA isolated from a positive-sense RNA virus (like Poliovirus or SARS-CoV-2) capable of initiating an infection when transfected into a permissive host cell, whereas purified genomic RNA from a negative-sense RNA virus (like Influenza or Rabies) is completely non-infectious? (Because **positive-sense viral RNA has the exact same polarity and structure as eukaryotic cellular mRNA**, allowing host ribosomes to immediately translate it into viral RdRP; whereas **negative-sense RNA cannot be translated by host ribosomes and requires a pre-packaged viral RdRP enzyme**, which is absent in pure RNA preparations).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "baltimore_classification_and_viral_replication_strategies",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Baltimore Classification of Viruses (1975 Nobel)**\n• **The Central Hub:** All viral classes converge on generating **positive-sense (+)mRNA** for host ribosome translation!\n• **The 7 Baltimore Classes:**\n  - **Group I (dsDNA):** dsDNA $\\to$ (+)mRNA (*Herpesvirus, Adenovirus*).\n  - **Group II (ssDNA):** ssDNA $\\to$ dsDNA $\\to$ (+)mRNA (*Parvovirus B19*).\n  - **Group III (dsRNA):** dsRNA $\\xrightarrow{\\text{RdRP}}$ (+)mRNA (*Rotavirus*).\n  - **Group IV ((+)ssRNA):** **Genome IS (+)mRNA (directly translated)** (*Poliovirus, SARS-CoV-2, HCV*).\n  - **Group V ((-)ssRNA):** **MUST package viral RdRP in virion** (*Influenza, Rabies, Ebola*).\n  - **Group VI (ssRNA-RT):** ssRNA $\\xrightarrow{\\text{RT}}$ dsDNA $\\xrightarrow{\\text{Integrase}}$ Host Chromosome (*HIV-1*).\n  - **Group VII (dsDNA-RT):** dsDNA $\\to$ pregenomic RNA $\\xrightarrow{\\text{RT}}$ dsDNA (*Hepatitis B*)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the Group VI Retroviral (HIV) replication cycle.",
      "orderItems": [
        "Viral envelope glycoproteins bind host cell CD4 receptors and chemokine coreceptors (CCR5/CXCR4) to mediate membrane fusion",
        "The viral capsid uncoats in the cytoplasm, releasing (+)ssRNA genomes, Reverse Transcriptase, and Integrase",
        "Reverse Transcriptase synthesizes a double-stranded cDNA copy from the single-stranded viral RNA template",
        "Viral Integrase transports the cDNA into the nucleus and catalyzes covalent insertion into the host genomic chromosome (provirus)",
        "Host RNA Polymerase II transcribes the provirus into viral mRNAs and genomic RNAs for assembly and budding"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Baltimore classification group to its prototypical viral family.",
      "matchPairs": [
        { "left": "Group I (Double-Stranded DNA)", "right": "Herpesviridae (HSV-1, Epstein-Barr Virus) and Adenoviridae" },
        { "left": "Group IV (Positive-Sense Single-Stranded RNA)", "right": "Coronaviridae (SARS-CoV-2) and Picornaviridae (Poliovirus)" },
        { "left": "Group V (Negative-Sense Single-Stranded RNA)", "right": "Orthomyxoviridae (Influenza A) and Rhabdoviridae (Rabies Virus)" },
        { "left": "Group VI (Single-Stranded RNA with Reverse Transcriptase)", "right": "Retroviridae (Human Immunodeficiency Virus / HIV-1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Baltimore classification system, all viral genomes must produce translatable positive-sense ___ (mRNA) to synthesize viral proteins.",
      "blankAnswer": "mrna",
      "blankDistractors": ["trna", "rrna", "cdna"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If you transfect pure, protein-free genomic RNA isolated from a positive-sense RNA virus (Poliovirus) into a human cell culture, it produces infectious viral particles. If you do the exact same experiment with pure genomic RNA from a negative-sense RNA virus (Rabies virus), zero virus is produced. Why?",
      "options": [
        { "text": "Positive-sense RNA functions directly as mRNA and is immediately translated by host ribosomes into viral RNA-dependent RNA polymerase (RdRP); whereas negative-sense RNA cannot be read by host ribosomes and requires a viral RdRP enzyme pre-packaged inside the virion to synthesize (+)mRNA, which is absent in pure RNA", "isCorrect": true, "explanation": "Correct! Group IV (+)ssRNA has the same 5'-to-3' orientation as cellular mRNA. When it enters a host cell, host ribosomes instantly bind and translate the viral polyprotein, which includes the viral RdRP needed to replicate the genome. In contrast, Group V (-)ssRNA is complementary to mRNA and cannot be translated. Because eukaryotic host cells possess no endogenous RNA-dependent RNA polymerases, naked (-)ssRNA is completely inert and degraded by nucleases unless accompanied by the pre-packaged viral RdRP protein that normally resides inside the virion core." },
        { "text": "Because negative-sense RNA is destroyed by ultraviolet light", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because positive-sense RNA turns into double-stranded DNA spontaneously", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because human cells refuse to take up negative-sense RNA", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
