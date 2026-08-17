# Duofy Reusable Lesson Format: RNA Interference and MicroRNA Gene Silencing

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Molecular_Genetics_and_Gene_Regulation`  
**Lesson Format Type:** `rna_interference_and_microrna_gene_silencing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular biogenesis, enzymatic machinery, and post-transcriptional silencing mechanisms of RNA Interference (RNAi) and microRNAs (Andrew Fire & Craig Mello, Nobel Prize in Physiology or Medicine 2006; Victor Ambros & Gary Ruvkun, Lasker Award / Nobel Prize in Physiology or Medicine 2024 for miRNA discovery): trace the pathway from primary transcript (**pri-miRNA**) through nuclear cleavage by the **Microprocessor Complex (Drosha + DGCR8/Pasha)** into **pre-miRNA hairpin**, nuclear export via **Exportin-5 / Ran-GTP**, cytoplasmic processing by **Dicer (RNase III enzyme)** into $\approx 22\text{-nt}$ duplex, guide strand loading into the **RISC (RNA-Induced Silencing Complex)** containing catalytic **Argonaute (Ago2)**, analyze target $3'\text{ UTR}$ recognition via the $2-8\text{ nt}$ **Seed Sequence**, and contrast siRNA-mediated endonucleolytic slicing with miRNA-mediated translational repression and CCR4-NOT deadenylation.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | microRNA Biogenesis & RISC Slicing Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step miRNA pri-mRNA to 3' UTR Silencing Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | RNAi Machinery Enzyme & Molecular Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Cytoplasmic RNase III Enzyme That Cuts Pre-miRNA Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | microRNA 2-8 nt Seed Region Mismatch Dynamics and Slicing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State RNA Interference & microRNA Biogenesis (2006 Nobel Prize; 2024 Nobel Prize):
   - **The miRNA Biogenesis Pipeline:**
     1. **Transcription:** RNA Pol II transcribes capped, polyadenylated **primary miRNA (pri-miRNA)** containing stem-loop hairpins.
     2. **Nuclear Processing (Microprocessor):** The **Drosha** (RNase III) + **DGCR8** complex cleaves the basal stem, releasing a $\approx 65-70\text{-nt}$ **precursor hairpin (pre-miRNA)** with a $2\text{-nt } 3'\text{ overhang}$.
     3. **Nuclear Export:** **Exportin-5** (in complex with Ran-GTP) shuttles pre-miRNA into the cytoplasm.
     4. **Cytoplasmic Cleavage:** **Dicer** (RNase III endonuclease) cleaves off the loop, generating a mature $\mathbf{\approx 21-23\text{-nt}}$ **miRNA duplex**.
     5. **RISC Assembly:** One strand (the **guide strand**, chosen by lower $5'$ thermodynamic end stability) is loaded into the **RISC (RNA-Induced Silencing Complex)** containing **Argonaute (Ago1-4, specifically Ago2)**; the passenger strand is discarded.
   - **Mechanism of Target Silencing:**
     - The **Seed Sequence** ($2-8\text{ nt}$ at the $5'$ end of guide RNA) pairs with complementary motifs in the **$3'\text{ UTR}$ of target mRNAs**.
     - **Extensive / Perfect Complementarity (typical of siRNAs / plants):** Ago2 catalytically slices target mRNA (endonucleolytic cleavage).
     - **Partial Complementarity (typical of animal miRNAs):** RISC recruits the **GW182** and **CCR4-NOT deadenylase complex**, triggering translation repression, poly(A) tail removal, and mRNA decay.
2. **Slide 2 (`ordering`):** Provide 5 steps of the microRNA gene regulation pathway: (1) RNA Polymerase II transcribes a long primary microRNA transcript (pri-miRNA) in the nucleus, (2) the Drosha-DGCR8 Microprocessor complex cleaves the pri-miRNA into a 70-nt pre-miRNA hairpin with a 2-nt 3' overhang, (3) Exportin-5 and Ran-GTP transport the pre-miRNA through the nuclear pore into the cytoplasm, (4) Dicer endonuclease cleaves the terminal loop, yielding a 22-nucleotide double-stranded miRNA duplex, (5) the mature guide strand is loaded into the Argonaute-containing RISC complex, which binds the 3' UTR of target mRNAs to repress translation and accelerate mRNA degradation!
3. **Slide 3 (`matching`):** Pair 4 RNAi processing factors (Drosha / DGCR8, Dicer Endonuclease, Argonaute 2 / Ago2, Exportin-5) with their specific molecular functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the cytoplasmic RNase III endonuclease that cuts pre-miRNA hairpins into mature 22-nt duplexes is Dicer. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the functional role of the microRNA seed sequence: What is the biological significance of the "seed sequence" (nucleotides 2 through 8 at the 5' end of a mature microRNA)? (The seed sequence is the **critical Watson-Crick targeting determinant that must base-pair with near-perfect complementarity to target sequences in the $3'\text{ UTR}$ of mRNAs**, allowing a single microRNA family to coordinate the post-transcriptional repression of hundreds of distinct downstream target mRNAs sharing that binding site).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rna_interference_and_microrna_gene_silencing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: RNA Interference and MicroRNA Gene Silencing (2006 & 2024 Nobel)**\n• **miRNA Biogenesis Flow:**\n$$\n\\text{pri-miRNA (Pol II)} \\xrightarrow{\\text{Drosha / DGCR8}} \\text{pre-miRNA (Hairpin)} \\xrightarrow{\\text{Exportin-5}} \\text{Cytoplasm} \\xrightarrow{\\mathbf{\\text{Dicer}}} \\mathbf{\\text{Mature miRNA Duplex (22 nt)}}\n$$\n• **RISC Loading & Target Repression:**\n  - Guide strand loaded into **RISC** with **Argonaute (Ago2)** catalytic core.\n  - **Seed Sequence (nt 2–8):** High-affinity pairing to **$3'\\text{ UTR}$** of target mRNAs.\n• **Silencing Outcomes:**\n  - **Perfect Complementarity (siRNA / Plants):** Ago2 **endonucleolytic slicing** of mRNA.\n  - **Partial Complementarity (Animal miRNAs):** GW182 + **CCR4-NOT deadenylation** $\\implies$ Translational arrest & mRNA decay!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the chronological molecular events of microRNA processing and gene silencing.",
      "orderItems": [
        "RNA Polymerase II transcribes the primary microRNA (pri-miRNA) transcript in the nucleus",
        "The Drosha-DGCR8 Microprocessor complex excises the hairpin to release a ~70-nt pre-miRNA with a 2-nt 3' overhang",
        "Exportin-5 binds the pre-miRNA in a Ran-GTP-dependent manner and shuttles it into the cytoplasm",
        "Dicer endonuclease cleaves off the terminal loop to produce a ~22-nt double-stranded miRNA intermediate",
        "The guide strand is loaded into the Argonaute-containing RISC complex, which pairs via its seed region to target mRNA 3' UTRs to silence translation"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each RNA interference enzyme/factor to its exact molecular role.",
      "matchPairs": [
        { "left": "Drosha / DGCR8 Microprocessor", "right": "Nuclear RNase III complex that cleaves pri-miRNA into ~70-nt pre-miRNA hairpins" },
        { "left": "Dicer Endonuclease", "right": "Cytoplasmic RNase III enzyme that measures and cuts pre-miRNA hairpins into 21-23 nt mature duplexes" },
        { "left": "Argonaute (Ago2) Protein", "right": "Catalytic core of the RISC complex harboring the RNase H-like PIWI domain for RNA slicing" },
        { "left": "Exportin-5 / Ran-GTP", "right": "Nuclear karyopherin transporter that exports pre-miRNA hairpins through the nuclear pore complex" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The cytoplasmic RNase III endonuclease that cleaves the terminal loop off pre-miRNA hairpins to generate mature 22-nt RNA duplexes is ___.",
      "blankAnswer": "dicer",
      "blankDistractors": ["drosha", "argonaute", "helicase"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the biological importance of the 5' 'Seed Region' (nucleotides 2 through 8) of a mature microRNA guide strand?",
      "options": [
        { "text": "It provides the critical, high-affinity Watson-Crick base-pairing recognition sequence that docks onto complementary motifs in the 3' UTR of target mRNAs, allowing a single microRNA to simultaneously regulate hundreds of different target transcripts", "isCorrect": true, "explanation": "Correct! The 'seed sequence' consists of nucleotides 2 to 8 at the 5' end of the mature microRNA. Because of how the guide RNA is structurally pre-organized by the Argonaute protein, these 7 nucleotides are held in a rigid helical conformation ready to sample target RNAs. Perfect or near-perfect Watson-Crick complementarity between the seed region and the 3' UTR of an mRNA is both necessary and sufficient for target recognition and recruitment of the silencing machinery." },
        { "text": "It encodes the start codon for translating the microRNA into protein", "isCorrect": false, "explanation": "Incorrect: miRNAs are non-coding RNAs." },
        { "text": "It serves as a promoter for mitochondrial DNA replication", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It destroys ribosomal rRNAs inside nucleoli", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
