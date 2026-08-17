# Duofy Reusable Lesson Format: Eukaryotic Transcription and mRNA Processing/Splicing

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / DNA_Replication_Transcription_Translation`  
**Lesson Format Type:** `eukaryotic_transcription_and_mrna_processing_splicing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular transcription cycle of RNA Polymerase II and the three coordinated post-transcriptional co-transcriptional processing events (Roger Kornberg, Nobel Prize in Chemistry 2006; Phillip Sharp & Richard Roberts, Nobel Prize in Physiology or Medicine 1993): formulate pre-initiation complex assembly (TATA Box $\to$ **TFIID / TBP** $\to$ **TFIIH helicase/kinase** CTD Ser5 phosphorylation $\to$ promoter escape), trace the 3-step mRNA maturation cascade (**$5'$ 7-methylguanosine $m^7\text{G}$ Cap**, **$3'$ Cleavage & Polyadenylation $\text{AAUAAA}$**, and **Nuclear Pre-mRNA Splicing** via the dynamic **Spliceosome [U1, U2, U4, U5, U6 snRNPs]**), and evaluate the two transesterification reactions generating the excised **Intron Lariat**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Transcription Cycle & mRNA Processing Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 2-Step Transesterification Splicing Cascade Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | RNA Processing Machine & Chemical Modification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Splicing Branch Point Nucleotide 2-Prime Reactive Group Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Alternative Splicing and Proteomic Diversity Expansion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Eukaryotic Transcription & mRNA Processing:
   - **RNA Polymerase II Transcription Cycle:**
     - **Promoter Recognition:** TATA Box ($-25$ to $-30\text{ bp}$) binds **TBP** (TATA-Binding Protein, subunit of **TFIID**).
     - **Pre-Initiation Complex (PIC):** Assembly of TFIIA, TFIIB, TFIIF, TFIIE, and **TFIIH** (possesses ATP-dependent DNA helicase and kinase activities).
     - **Promoter Escape:** TFIIH phosphorylates Serine 5 on the Pol II C-Terminal Domain (CTD heptapeptide repeat $\text{YSPTSPS}$).
   - **The 3 Co-Transcriptional mRNA Maturation Steps:**
     1. **$5'$ Capping:** Guanylyltransferase adds a **7-methylguanosine ($m^7\text{G}$)** cap via an atypical $5'\text{-to-}5'$ triphosphate linkage (protects against $5' \to 3'$ exonucleases and recruits ribosome).
     2. **$3'$ Polyadenylation:** Cleavage at poly-A signal ($\text{AAUAAA}$) by CPSF/CstF; **Poly-A Polymerase (PAP)** adds $200-250$ adenines without a template.
     3. **Pre-mRNA Splicing (The Spliceosome):**
        - Composed of 5 snRNPs (U1, U2, U4, U5, U6) and $>100$ proteins.
        - **$1^{\text{st}}$ Transesterification:** The $2'\text{-OH}$ of the branch point **Adenosine (A)** nucleophilically attacks the $5'$ splice site ($\text{GU}$), forming a $2'\text{-}5'$ phosphodiester bond (**Lariat Intermediate**).
        - **$2^{\text{nd}}$ Transesterification:** The free $3'\text{-OH}$ of the upstream exon attacks the $3'$ splice site ($\text{AG}$), ligating exons and releasing the lariat intron.
2. **Slide 2 (`ordering`):** Provide 5 steps of the spliceosome reaction mechanism: (1) U1 snRNP binds the $5'$ splice site ($\text{GU}$) and U2 snRNP binds the branch point sequence containing the branch point adenosine, (2) the U4/U6-U5 tri-snRNP complex joins, forming the inactive precatalytic spliceosome B complex, (3) ATP-dependent conformational rearrangement expels U1 and U4 snRNPs, creating the catalytically active core containing U2, U6, and U5 snRNAs, (4) the $2'\text{-OH}$ group of the branch point adenosine attacks the phosphodiester bond at the $5'$ splice site, generating the branched lariat intermediate, (5) the newly exposed $3'\text{-OH}$ of exon 1 attacks the $3'$ splice site, covalently joining the two exons and releasing the excised intron lariat!
3. **Slide 3 (`matching`):** Pair 4 mRNA processing elements ($5'$ $m^7\text{G}$ Cap, $3'$ Poly-A Tail, U1/U2 snRNPs, Alternative Splicing) with their molecular functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in pre-mRNA splicing, the nucleophile that initiates the first transesterification is the 2'-OH group of the branch point adenosine. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how alternative splicing expands proteomic diversity: The human genome contains approximately 20,000 protein-coding genes, yet human cells produce over 100,000 distinct protein isoforms. What molecular mechanism primarily accounts for this massive proteomic expansion? (Because **Alternative Splicing allows pre-mRNAs to selectively include or exclude different combinations of exons**, producing multiple distinct mature mRNA transcripts—and therefore distinct functional protein isoforms—from a single genomic gene locus).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "eukaryotic_transcription_and_mrna_processing_splicing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Eukaryotic Transcription and mRNA Processing**\n• **RNA Polymerase II Initiation & CTD Tail:**\n  - **Promoter:** TATA Box bound by **TBP / TFIID**.\n  - **TFIIH:** Helicase unwinds DNA; Kinase phosphorylates Ser5 on Pol II CTD tail ($\\text{YSPTSPS}$) to launch elongation.\n• **Co-Transcriptional Processing Triad:**\n  1. **$5'$ 7-Methylguanosine Cap:** $5'\\text{-to-}5'$ triphosphate linkage; prevents degradation and binds eIF4E.\n  2. **$3'$ Polyadenylation:** $\\text{AAUAAA}$ signal cleaved; Poly-A Polymerase adds $200\\text{--}250$ adenines.\n  3. **Pre-mRNA Splicing (Spliceosome: U1, U2, U4, U5, U6 snRNPs):**\n    - **$1^{\\text{st}}$ Transesterification:** Branch point Adenosine $2'\\text{-OH}$ attacks $5'$ splice site ($\\text{GU}$) $\\implies$ **Lariat Loop** with $2'\\text{-}5'$ bond.\n    - **$2^{\\text{nd}}$ Transesterification:** Free $3'\\text{-OH}$ of Exon 1 attacks $3'$ splice site ($\\text{AG}$) $\\implies$ Exon ligation + Intron lariat excision!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential biochemical steps of pre-mRNA splicing by the spliceosome.",
      "orderItems": [
        "U1 snRNP base-pairs with the 5' splice site (GU) and U2 snRNP base-pairs with the branch point sequence",
        "The U4/U6.U5 tri-snRNP particle integrates into the complex to assemble the pre-catalytic spliceosome B complex",
        "ATP-dependent helicases discard U1 and U4 snRNPs, activating the catalytic core of U2, U6, and U5 snRNAs",
        "The 2'-OH group of the branch point adenosine attacks the 5' splice site, forming the characteristic intron lariat",
        "The free 3'-OH of the upstream exon attacks the 3' splice site (AG), ligating exons and releasing the excised lariat"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each eukaryotic mRNA processing feature to its primary cellular role.",
      "matchPairs": [
        { "left": "5' 7-Methylguanosine (m7G) Cap", "right": "Protects mRNA from 5' exonucleolytic degradation and recruits ribosome initiation factors" },
        { "left": "3' Poly-A Tail (200-250 Adenines)", "right": "Enhances mRNA stability, regulates translational efficiency, and facilitates nuclear export" },
        { "left": "Spliceosome (snRNP U1-U6 Complex)", "right": "Catalyzes two transesterification reactions to excise non-coding introns and splice coding exons" },
        { "left": "Alternative Splicing", "right": "Generates multiple unique mRNA/protein isoforms from a single primary gene transcript" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In pre-mRNA splicing, the initial transesterification reaction is carried out by the nucleophilic 2'-OH group of the branch point ___ (A).",
      "blankAnswer": "adenosine",
      "blankDistractors": ["cytosine", "guanine", "uracil"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How can the human genome of ~20,000 protein-coding genes produce over 100,000 distinct functional protein isoforms in different cell types?",
      "options": [
        { "text": "Through ALTERNATIVE SPLICING; pre-mRNAs can differentially include or skip specific exons (or use alternative splice sites), allowing a single gene locus to generate multiple distinct mature mRNA transcripts and protein isoforms with specialized tissue functions", "isCorrect": true, "explanation": "Correct! Alternative splicing is the primary mechanism expanding proteomic diversity in eukaryotes. By selectively retaining or removing alternative exons (e.g. cassette exons, mutually exclusive exons, alternative 5'/3' splice sites), a single pre-mRNA transcript can be processed into numerous distinct mRNA variants, each encoding a unique functional protein isoform tailored to specific cell types or developmental stages." },
        { "text": "By converting all introns into lipids and vitamins", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "By duplicating chromosomes 50 times in every cell", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Through spontaneous radioactive decay of DNA bases", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
