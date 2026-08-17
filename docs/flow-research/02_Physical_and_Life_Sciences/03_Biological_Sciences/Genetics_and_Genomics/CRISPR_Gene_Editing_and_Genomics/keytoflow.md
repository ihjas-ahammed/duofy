# Key to Flow: CRISPR Gene Editing and Genomics (Genetics & Biotechnology)

**Subject Area:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / CRISPR_Gene_Editing_and_Genomics`

---

## 📌 Core Concept & Mental Model
**CRISPR Genome Editing, Precision Genetic Surgery, and High-Throughput Genomics** revolutionize biotechnology, medicine, and evolutionary functional genomics (Nobel Prize in Chemistry 2020 to Emmanuelle Charpentier & Jennifer Doudna; Feng Zhang; David Liu):
* **CRISPR-Cas9 Biology & Targeted DNA Cleavage:**
  - **Bacterial Type II CRISPR System (*Streptococcus pyogenes* SpCas9):**
    - **Single Guide RNA (sgRNA):** Engineered fusion of target-specific crRNA ($20\text{ nt}$ spacer matching genomic protospacer) and structural trans-activating crRNA (tracrRNA).
    - **Protospacer Adjacent Motif (PAM):** $5'\text{-NGG-}3'$ immediately downstream of target sequence. Cas9 interrogates DNA via PAM-first sampling; without PAM binding, DNA unwinding and R-loop formation cannot occur!
    - **Dual Endonuclease Catalytic Domains:**
      - **HNH Domain:** Cleaves the target DNA strand (complementary to sgRNA).
      - **RuvC Domain:** Cleaves the non-target DNA strand.
      - Produces a clean **Targeted Double-Strand Break (DSB)** exactly $3\text{ bp}$ upstream of the PAM site.
* **Cellular DNA Repair Outcomes:**
  - **Non-Homologous End Joining (NHEJ, Error-Prone):** Active throughout entire cell cycle ($G_1, S, G_2, M$). Ku70/Ku80 $+$ DNA-PKcs direct end-joining, introducing stochastic insertions/deletions (**Indels** $\implies$ Frameshift mutations $\implies$ Premature Stop Codons $\implies$ **Gene Knockout**).
  - **Homology-Directed Repair (HDR, High-Fidelity):** Active strictly during late $S / G_2$ phases using sister chromatid or an **exogenous double-stranded/single-stranded DNA donor template (ssODN)** flanked by homology arms $\implies$ Precise base substitution, tag insertion, or **Gene Knock-in**.
* **Next-Generation Precision Editing (Double-Strand-Break-Free):**
  - **Base Editing (David Liu, 2016-2017):** Catalytically impaired Cas9 nickase (Cas9n D10A) fused to a deaminase enzyme:
    - **Cytosine Base Editor (CBE):** Cytidine deaminase (APOBEC/rAPOBEC1) deaminates $\text{C} \to \text{U}$, converted by DNA replication to **$\text{C}\cdot\text{G} \to \text{T}\cdot\text{A}$ transition**.
    - **Adenine Base Editor (ABE):** Evolved TadA deaminase deaminates $\text{A} \to \text{I}$ (Inosine), converted to **$\text{A}\cdot\text{T} \to \text{G}\cdot\text{C}$ transition**.
    - No DSBs $\implies$ Zero random indel indels or chromosomal translocations!
  - **Prime Editing (David Liu, 2019):** Cas9 nickase (H840A) fused to an engineered M-MLV Reverse Transcriptase (RT) using a **Prime Editing Guide RNA (pegRNA)** containing an RT template and primer binding site (PBS) $\implies$ Can write **all 12 possible base transitions/transversions, precise small insertions, and deletions** without DSB or donor DNA!
  - **Epigenome Editing:** Catalytically dead Cas9 (**dCas9**) fused to KRAB repressor (**CRISPRi**) or VP64/VPR transcriptional activator (**CRISPRa**).
* **Next-Generation & Long-Read Sequencing (Genomics):**
  - **Illumina Sequencing-by-Synthesis (SBS):** Flow-cell bridge amplification (clusters), fluorescent reversible terminators ($150-300\text{ bp}$ short reads, $>99.9\%$ accuracy).
  - **Oxford Nanopore Sequencing (ONT):** Measures ionic current disruptions as native single-stranded DNA translocates through a protein nanopore ($>100\text{ kb}$ ultra-long reads, direct epigenetic methylation detection 5mC/6mA).
  - **Pacific Biosciences (PacBio HiFi):** Single Molecule Real-Time (SMRT) circular consensus sequencing ($15-20\text{ kb}$ reads with $>99.9\%$ accuracy).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The DSB vs Search-and-Replace Workflow
* Distinguish classic Cas9 (creates DSB $\to$ NHEJ knockout or HDR knock-in) from advanced Base/Prime Editing (nicks single strand $\to$ writes transition or pegRNA template without DSBs).

### 2. Top Recommended Resources
* **The CRISPR Story:** *A Crack in Creation: Gene Editing and the Unthinkable Power to Control Evolution* by Jennifer Doudna & Samuel Sternberg.
* **Genomic Architecture:** *Genomes 4* by T.A. Brown (Garland Science).
* **Practical Genome Science:** *A Primer of Genome Science* by Greg Gibson & Spencer V. Muse.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you design an sgRNA targeting a gene given the $5'\text{-NGG-}3'$ PAM sequence orientation?
- [ ] Can you predict the phenotypic outcome of Cas9 cleavage repaired by NHEJ vs HDR with donor template?
- [ ] Can you determine whether a target pathogenic point mutation can be repaired by a CBE, ABE, or Prime Editor?
- [ ] Can you contrast Illumina short-read accuracy with Nanopore long-read structural variant resolution?
