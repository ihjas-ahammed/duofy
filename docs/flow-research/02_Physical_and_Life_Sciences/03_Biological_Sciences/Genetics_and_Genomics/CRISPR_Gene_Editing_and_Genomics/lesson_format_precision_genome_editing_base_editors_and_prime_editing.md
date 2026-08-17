# Duofy Reusable Lesson Format: Precision Genome Editing (Base Editors and Prime Editing)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / CRISPR_Gene_Editing_and_Genomics`  
**Lesson Format Type:** `precision_genome_editing_base_editors_and_prime_editing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the breakthrough generation of double-strand-break-free precision genomic surgery (David R. Liu, Broad Institute / Harvard University): contrast **Cytosine Base Editors (CBE: Cas9n-D10A + APOBEC cytidine deaminase + UGI**, catalyzing direct $\text{C}\cdot\text{G} \to \text{T}\cdot\text{A}$ transition) and **Adenine Base Editors (ABE: Cas9n-D10A + evolved TadA deoxyadenosine deaminase**, catalyzing direct $\text{A}\cdot\text{T} \to \text{G}\cdot\text{C}$ transition), master the "search-and-replace" mechanics of **Prime Editing (PE2 / PE3: Cas9n-H840A + engineered M-MLV Reverse Transcriptase + pegRNA [Prime Editing Guide RNA]** containing RT template and Primer Binding Site [PBS]), and evaluate the profound clinical advantages: **zero double-strand breaks, minimal indel generation ($<1\%$), and zero requirement for donor DNA templates**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Base Editing & Prime Editing Engineering Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Prime Editing Search-and-Replace Cascade Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Precision Editor / Machine & Editing Capability Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Cytosine Base Editor Transition Product Pair Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | DSB-Free Editing vs Standard Cas9 Double-Strand Cleavage Advantage Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Precision Genome Editing Technologies (David R. Liu, 2016, 2017, 2019):
   - **The Problem with Standard Cas9:** Creating double-strand breaks (DSBs) triggers uncontrolled insertions/deletions (indels), large chromosome deletions, p53 activation, and chromosomal translocations.
   - **1. Base Editing (David Liu, 2016-2017):**
     - Uses **Cas9 Nickase (Cas9n D10A)** fused to a deaminase enzyme that edits within a $4-5\text{ nt}$ activity window:
       - **CBE (Cytosine Base Editor):** Cytidine deaminase (APOBEC) converts $\text{Cytosine (C)} \to \text{Uracil (U)}$. Uracil DNA Glycosylase Inhibitor (UGI) prevents base excision repair $\implies$ Cellular replication converts $\mathbf{\text{C}\cdot\text{G} \to \text{T}\cdot\text{A}}$.
       - **ABE (Adenine Base Editor):** Laboratory-evolved TadA converts $\text{Adenine (A)} \to \text{Inosine (I)} \implies$ Polymerase reads as $\text{G} \implies$ Converts $\mathbf{\text{A}\cdot\text{T} \to \text{G}\cdot\text{C}}$.
   - **2. Prime Editing (David Liu, 2019 - "Search-and-Replace"):**
     - **Fusion Machine:** Cas9 Nickase (H840A) fused to an engineered **M-MLV Reverse Transcriptase (RT)**.
     - **pegRNA (Prime Editing Guide RNA):** Dual-function RNA with (1) $20\text{-nt}$ guide spacer, (2) Primer Binding Site (PBS), and (3) Reverse Transcriptase Template (RTT) harboring the desired genetic edit.
     - **Capabilities:** Can write **ALL 12 possible base substitutions (transitions & transversions)**, precise insertions ($1-50\text{ bp}$), and precise deletions without DSBs or donor DNA!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Prime Editing molecular mechanism: (1) the pegRNA directs the Cas9 nickase-RT fusion protein to the genomic target site, (2) Cas9 nickase (H840A) cleaves the non-target DNA strand $3\text{ bp}$ upstream of PAM, generating a free $3'\text{-OH}$ flap, (3) the Primer Binding Site (PBS) on the pegRNA hybridizes with the exposed $3'$ genomic DNA single strand, (4) the tethered reverse transcriptase extends from the $3'\text{-OH}$ primer using the pegRNA RT template, directly synthesizing a new $3'$ DNA flap carrying the desired genetic edit, (5) the newly edited $3'$ flap invades and hybridizes to the target DNA, while the unedited $5'$ flap is excised by cellular endonucleases, permanently copying the edit into the genome!
3. **Slide 3 (`matching`):** Pair 4 precision editing platforms (Cytosine Base Editor CBE, Adenine Base Editor ABE, Prime Editor PE, CRISPRi/dCas9-KRAB) with their molecular mechanisms and conversion capabilities.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Cytosine Base Editors convert target C-G base pairs into T-A base pairs. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the primary safety advantage of Base Editing and Prime Editing over traditional Cas9 in human clinical therapeutics: Why are Base Editors and Prime Editors vastly safer for human gene therapy applications (e.g. treating sickle cell anemia or Progeria) compared to wild-type Cas9 nucleases? (Because they **nick only a single DNA strand instead of creating double-strand breaks (DSBs)**, virtually eliminating the risk of uncontrolled random indels, large pathogenic chromosomal deletions, chromothripsis, interchromosomal translocations, and p53-mediated cell death).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "precision_genome_editing_base_editors_and_prime_editing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Precision Genome Editing (David Liu, 2016-2019)**\n• **1. Base Editing (DSB-Free Single Base Surgery):**\n  - **CBE (Cytosine Base Editor):** Cas9n (D10A) + APOBEC cytidine deaminase + UGI $\\implies$ Converts $\\mathbf{\\text{C}\\cdot\\text{G} \\to \\text{T}\\cdot\\text{A}}$.\n  - **ABE (Adenine Base Editor):** Cas9n (D10A) + Evolved TadA deaminase $\\implies$ Converts $\\mathbf{\\text{A}\\cdot\\text{T} \\to \\text{G}\\cdot\\text{C}}$.\n  - Directly corrects $\\approx 60\\%$ of all known human pathogenic point mutations!\n• **2. Prime Editing (Search-and-Replace Molecular Word Processor):**\n  - **Architecture:** Cas9n (H840A) fused to **M-MLV Reverse Transcriptase**.\n  - **pegRNA:** Carries target spacer + Primer Binding Site (PBS) + RT Template with desired edit.\n  - **Versatility:** Writes **all 12 base-to-base transitions/transversions**, precise insertions, and deletions without DSBs or donor DNA!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential biochemical steps of Prime Editing search-and-replace gene modification.",
      "orderItems": [
        "The pegRNA-guided Cas9n-Reverse Transcriptase fusion protein binds the complementary genomic target site",
        "Cas9 nickase cleaves the non-target DNA strand, releasing a free single-stranded 3'-OH genomic DNA flap",
        "The 3' Primer Binding Site (PBS) of the pegRNA hybridizes with the newly freed single-stranded 3'-OH DNA tail",
        "The tethered Reverse Transcriptase uses the pegRNA RT template to polymerize new DNA extending directly from the 3'-OH flap",
        "Flap equilibration and 5'-flap excision by cellular nucleases ligate the newly edited 3'-flap into the genomic locus"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each precision genome editing platform to its specific genetic capability.",
      "matchPairs": [
        { "left": "Cytosine Base Editor (CBE)", "right": "Deaminates cytosine to uracil, catalyzing clean C.G to T.A transitions without double-strand breaks" },
        { "left": "Adenine Base Editor (ABE)", "right": "Deaminates adenine to inosine (read as guanine), catalyzing clean A.T to G.C transitions" },
        { "left": "Prime Editor (PE2 / PE3)", "right": "Writes all 12 base substitutions, small insertions, and deletions via pegRNA-templated reverse transcription" },
        { "left": "CRISPRi (dCas9-KRAB)", "right": "Sterically silences gene transcription without altering the underlying genomic DNA sequence" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Cytosine Base Editors (CBE) utilize cytidine deaminases to directly convert target C-G base pairs into ___-A base pairs without double-strand breaks.",
      "blankAnswer": "t",
      "blankDistractors": ["g", "c", "u"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the primary therapeutic safety advantage of Base Editing and Prime Editing over traditional Cas9 nuclease cutting in clinical gene therapy?",
      "options": [
        { "text": "They NICK ONLY A SINGLE STRAND instead of creating dangerous double-strand breaks (DSBs), virtually eliminating uncontrolled random indel mutations, large chromosomal deletions, and oncogenic translocations", "isCorrect": true, "explanation": "Correct! Traditional Cas9 creates double-strand breaks, which activate the p53 DNA damage response and trigger error-prone NHEJ that generates random insertions and deletions, large kilobase-scale deletions, or even chromosomal rearrangements. By using Cas9 nickases to modify single bases (Base Editing) or directly write new genetic sequences via reverse transcription (Prime Editing), these precision tools avoid DSBs, achieving ultra-high precision with indel rates typically <1% and zero risk of chromosomal translocation." },
        { "text": "They convert DNA into gold inside the patient's blood", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They work without any RNA guides", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They can only be used on plants and bacteria", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
