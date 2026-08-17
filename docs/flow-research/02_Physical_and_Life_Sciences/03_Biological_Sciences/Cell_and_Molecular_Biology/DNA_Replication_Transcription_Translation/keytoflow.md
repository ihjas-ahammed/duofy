# Key to Flow: DNA Replication, Transcription, and Translation (Molecular Biology)

**Subject Area:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / DNA_Replication_Transcription_Translation`

---

## 📌 Core Concept & Mental Model
**The Central Dogma of Molecular Biology (Francis Crick, 1958)** details the flow of genetic information: $\text{DNA} \xrightarrow{\text{Replication}} \text{DNA} \xrightarrow{\text{Transcription}} \text{RNA} \xrightarrow{\text{Translation}} \text{Protein}$:
* **DNA Replication & The Replisome (Semi-Conservative, Meselson & Stahl 1958):**
  - **Replication Fork Architecture:**
    - **Helicase (DnaB / MCM2-7):** Unwinds double helix ($5' \to 3'$ in bacteria; $3' \to 5'$ in eukaryotes).
    - **Topoisomerase / DNA Gyrase:** Relieves positive supercoiling ahead of the fork via transient phosphodiester cleavage.
    - **Single-Stranded Binding Proteins (SSB / RPA):** Prevent hairpin re-annealing and nuclease degradation.
    - **Primase (DnaG / Pol $\alpha$-primase):** Synthesizes $10-12\text{ nt}$ RNA primers to provide free $3'\text{-OH}$ groups.
    - **Leading Strand:** Synthesized continuously $5' \to 3'$ toward the replication fork by **DNA Pol III / Pol $\varepsilon$**.
    - **Lagging Strand:** Synthesized discontinuously as $1000-2000\text{ nt}$ (prokaryotic) or $100-200\text{ nt}$ (eukaryotic) **Okazaki Fragments** by **DNA Pol III / Pol $\delta$**.
    - **Primer Removal & Ligation:** DNA Pol I / FEN1 removes RNA primers via $5' \to 3'$ exonuclease; **DNA Ligase** seals nicks using $\text{NAD}^+$ (bacteria) or $\text{ATP}$ (eukaryotes).
    - **Telomerase (Elizabeth Blackburn & Carol Greider, Nobel Prize 2009):** Reverse transcriptase with internal RNA template solving the eukaryotic **End-Replication Problem** by adding $\text{TTAGGG}$ hexamer repeats to $3'$ chromosome overhangs.
* **Transcription & Post-Transcriptional Processing:**
  - **Prokaryotic Transcription:** Core RNA Polymerase ($\alpha_2 \beta \beta' \omega$) $+$ **$\sigma^{70}$ factor** recognizing $-10$ (Pribnow box: $\text{TATAAT}$) and $-35$ ($\text{TTGACA}$) promoter motifs. Termination: **Intrinsic (Rho-independent, GC-hairpin $+$ poly-U tract)** vs **Rho-dependent ($\rho$ hexameric ATPase translocating to rut site)**.
  - **Eukaryotic RNA Polymerases:**
    - **RNA Pol I:** $28\text{S}, 18\text{S}, 5.8\text{S}$ rRNA in nucleolus.
    - **RNA Pol II:** mRNA, snRNA, miRNA (TATA box $\to$ TFIID/TBP $\to$ TFIIH helicase/kinase CTD phosphorylation).
    - **RNA Pol III:** tRNA, 5S rRNA.
  - **Co-Transcriptional mRNA Maturation (Eukaryotes):**
    1. **$5'$ Capping:** 7-methylguanosine ($m^7\text{G}$) cap via $5'\text{-}5'$ triphosphate linkage.
    2. **$3'$ Cleavage & Polyadenylation:** AAUAAA polyadenylation signal $\to$ Poly-A Polymerase adds $200-250$ adenines.
    3. **Pre-mRNA Splicing by Spliceosome (snRNPs U1, U2, U4, U5, U6):**
       - $5'$ splice site ($\text{GU}$), branch point adenosine ($2'\text{-OH}$), $3'$ splice site ($\text{AG}$).
       - Two sequential transesterification reactions forming a **Lariat Intermediate** to excise introns.
* **Translation & The Ribosomal Ribozyme (Ada Yonath, Venki Ramakrishnan, Thomas Steitz, Nobel 2009):**
  - **Ribosome Subunits:** Prokaryote $70\text{S}$ ($50\text{S} + 30\text{S}$) vs Eukaryote $80\text{S}$ ($60\text{S} + 40\text{S}$).
  - **Three Ribosomal Sites:** **A (Aminoacyl)** $\to$ **P (Peptidyl)** $\to$ **E (Exit)**.
  - **Peptidyl Transferase Center (PTC):** Fully catalytic **$23\text{S} / 28\text{S}$ rRNA** ribozyme; forms peptide bonds with no protein enzymes within $18\text{ \AA}$!
  - **The Genetic Code & Wobble Hypothesis (Francis Crick, 1966):**
    - Universal, non-overlapping, degenerate (64 codons for 20 amino acids; AUG start, UAA/UAG/UGA stop).
    - **$3'$ Codon Wobble:** Inosine (I) at tRNA $5'$ anticodon wobble position pairs with $\text{A, C, or U}$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Chemical Polarity & Energy Tracking Principle
* Remember: Polymerases **always read $3' \to 5'$ and synthesize $5' \to 3'$**!
* Track high-energy nucleotide triphosphates ($\text{dNTPs}$ and $\text{rNTPs}$) providing their own thermodynamic driving force via pyrophosphate hydrolysis ($\text{PP}_i \to 2\text{P}_i$).

### 2. Top Recommended Resources
* **The Master Cell Text:** *Molecular Biology of the Cell* by Bruce Alberts et al. (Garland Science).
* **The Molecular Bible:** *Molecular Cell Biology* by Harvey Lodish et al. (Macmillan).
* **Structural Basis:** *Molecular Biology of the Gene* by James D. Watson et al.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you identify leading vs lagging strands, Okazaki fragments, and replication fork polarity?
- [ ] Can you trace the 2 transesterification reactions of spliceosome-mediated intron removal?
- [ ] Can you predict the amino acid sequence from a given mRNA transcript using the genetic code table?
- [ ] Can you explain why the catalytic core of the ribosome is a ribozyme (rRNA) and not a protein enzyme?
