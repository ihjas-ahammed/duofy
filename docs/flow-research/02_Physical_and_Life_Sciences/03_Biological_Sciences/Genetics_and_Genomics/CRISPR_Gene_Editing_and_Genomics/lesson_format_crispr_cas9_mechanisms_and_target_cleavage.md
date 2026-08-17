# Duofy Reusable Lesson Format: CRISPR-Cas9 Mechanisms and Target Cleavage

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / CRISPR_Gene_Editing_and_Genomics`  
**Lesson Format Type:** `crispr_cas9_mechanisms_and_target_cleavage`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular biophysics, structural domains, and target DNA cleavage mechanisms of the RNA-guided CRISPR-Cas9 endonuclease (Jennifer Doudna & Emmanuelle Charpentier, Nobel Prize in Chemistry 2020; Feng Zhang 2013): formulate the architecture of **Single Guide RNA (sgRNA, $20\text{ nt}$ spacer $+$ scaffold)**, analyze the strict requirement for **Protospacer Adjacent Motif (PAM: $5'\text{-NGG-}3'$ in *S. pyogenes* SpCas9)** in initial DNA binding and R-loop unwinding, trace the dual nuclease cleavage mechanism (**HNH domain** cleaving target strand, **RuvC domain** cleaving non-target strand generating a blunt double-strand break $3\text{ bp}$ upstream of PAM), and evaluate off-target mismatch kinetics in the seed region.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CRISPR-Cas9 Structural Anatomy & Cleavage Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Cas9 Search, PAM Interrogation, and Cleavage Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | CRISPR Component / Domain & Molecular Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Streptococcus pyogenes Cas9 Canonical PAM Triplet Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | PAM Absence Binding and R-Loop Failure Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CRISPR-Cas9 Structural Mechanics & Endonuclease Action:
   - **The Dual-Component Ribonucleoprotein (RNP) Machine:**
     - **Cas9 Protein (*Streptococcus pyogenes* SpCas9, $160\text{ kDa}$):** Bilobed enzyme composed of Recognition (REC) lobe and Nuclease (NUC) lobe.
     - **Single Guide RNA (sgRNA):** Synthetic chimeric fusion of target-specifying crRNA ($20\text{ nt}$ guide spacer) and structural scaffold tracrRNA.
   - **Target Recognition & Cleavage Sequence:**
     1. **PAM Interrogation:** Cas9 samples DNA via 3D diffusion and binds the **Protospacer Adjacent Motif (PAM: $5'\text{-NGG-}3'$)** using its C-terminal PAM-interacting (PI) domain (Arg1333/Arg1335).
     2. **R-Loop Formation:** PAM binding triggers local melting of double-stranded DNA, initiating directional base-pairing between sgRNA and target strand from the $8-10\text{ nt}$ proximal **Seed Region** to the distal end.
     3. **Dual-Domain Cleavage:**
        - **HNH Nuclease Domain:** Cleaves the target DNA strand complementary to the guide RNA.
        - **RuvC Nuclease Domain:** Cleaves the non-target DNA strand.
     4. **The Break:** Produces a clean, predominantly blunt **Double-Strand Break (DSB)** exactly **$3\text{ base pairs}$ upstream of the PAM motif**!
2. **Slide 2 (`ordering`):** Provide 5 steps of the CRISPR-Cas9 targeting mechanism: (1) Cas9 protein loads the sgRNA, adopting an active search-competent ribonucleoprotein conformation, (2) the Cas9-sgRNA complex scans genomic DNA, binding to $5'\text{-NGG-}3'$ PAM motifs via its PAM-interacting domain, (3) PAM recognition destabilizes adjacent DNA duplex, allowing the $20\text{-nt}$ sgRNA guide to base-pair with the complementary target strand, forming an R-loop, (4) extensive base-pairing across the seed region triggers an allosteric conformational shift, swinging the HNH and RuvC catalytic domains into active position, (5) HNH cleaves the target strand and RuvC cleaves the non-target strand, generating a double-strand break $3\text{ bp}$ upstream of PAM!
3. **Slide 3 (`matching`):** Pair 4 Cas9 components (HNH Domain, RuvC Domain, PAM-Interacting Domain, sgRNA Seed Region) with their biochemical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the canonical PAM motif for Streptococcus pyogenes Cas9 is 5'-NGG-3'. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the absolute necessity of the PAM sequence: If a researcher designs an sgRNA with $100\%$ perfect sequence complementarity to a $20\text{-nt}$ genomic target sequence, but the adjacent downstream DNA lacks the canonical $5'\text{-NGG-}3'$ PAM motif (e.g. it is $5'\text{-AAT-}3'$), what will happen? (Cas9 will **fail to bind and fail to cleave the DNA**; because PAM binding is the mandatory structural trigger that unzips the double helix to initiate R-loop guide-strand base pairing).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "crispr_cas9_mechanisms_and_target_cleavage",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CRISPR-Cas9 Mechanisms and Target Cleavage (2020 Nobel)**\n• **The Engineered RNP Complex:**\n  - **SpCas9 Protein:** Bilobed endonuclease (REC lobe + NUC lobe).\n  - **sgRNA (Single Guide RNA):** $20\\text{ nt}$ spacer sequence complementary to genomic protospacer + structural tracrRNA loop.\n• **The 3-Step Cleavage Cascade:**\n  1. **PAM Recognition:** Binds **$5'\\text{-NGG-}3'$** PAM motif using C-terminal PI domain.\n  2. **R-Loop Unwinding:** Local melting enables $20\\text{ nt}$ RNA-DNA hybrid formation starting at proximal **Seed Region** ($8\\text{--}10\\text{ nt}$). \n  3. **Dual-Strand Cleavage:**\n    - **HNH Domain:** Cleaves the target strand (complementary to sgRNA).\n    - **RuvC Domain:** Cleaves the non-target strand.\n• **The Cut:** Produces a blunt **Double-Strand Break (DSB)** exactly **$3\\text{ bp}$ upstream of PAM**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential biophysical steps of CRISPR-Cas9 genome targeting and DNA double-strand cleavage.",
      "orderItems": [
        "Cas9 endonuclease binds the single guide RNA (sgRNA) to form an active surveillance ribonucleoprotein complex",
        "The Cas9-sgRNA complex scans genomic DNA via 3D diffusion, interrogating 5'-NGG-3' PAM motifs",
        "PAM engagement induces local DNA duplex unwinding, allowing the sgRNA to initiate base-pairing along the seed sequence",
        "Full 20-nt guide-target hybridization completes R-loop formation and triggers allosteric activation of both nuclease domains",
        "The HNH domain cleaves the target strand and RuvC cleaves the non-target strand, creating a DSB 3 bp upstream of the PAM"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CRISPR-Cas9 structural component to its specific biochemical mechanism.",
      "matchPairs": [
        { "left": "HNH Catalytic Domain", "right": "Endonuclease domain that specifically cleaves the target DNA strand complementary to sgRNA" },
        { "left": "RuvC Catalytic Domain", "right": "Endonuclease domain that specifically cleaves the displaced non-target DNA strand" },
        { "left": "PAM-Interacting (PI) Domain", "right": "C-terminal domain that reads 5'-NGG-3' motifs via major/minor groove contacts (Arg1333/Arg1335)" },
        { "left": "sgRNA Seed Region (8-10 nt adjacent to PAM)", "right": "High-fidelity nucleation zone where base mismatches completely abolish Cas9 activation" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The canonical protospacer adjacent motif required for Streptococcus pyogenes Cas9 target binding is 5'-___-3' (where N is any nucleotide).",
      "blankAnswer": "ngg",
      "blankDistractors": ["taa", "ccc", "ttg"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What happens if a genomic DNA target has 100% perfect sequence identity to a 20-nt sgRNA spacer, but lacks a 5'-NGG-3' PAM sequence immediately adjacent to its 3' boundary?",
      "options": [
        { "text": "Cas9 will COMPLETELY FAIL TO BIND AND CUT THE DNA; because initial PAM recognition by the PI domain is the mandatory physical trigger required to melt the DNA duplex and allow sgRNA strand invasion", "isCorrect": true, "explanation": "Correct! Cas9 does not scan DNA by attempting to base-pair along the double helix; it exclusively samples 5'-NGG-3' PAM motifs. Interaction with the PAM sequence is the structural prerequisite that causes Cas9 to bend the DNA and locally melt the duplex, exposing the target bases for R-loop guide pairing. In the absence of a correct PAM, Cas9 cannot initiate strand separation and dissociates immediately, leaving the target intact regardless of guide RNA complementarity." },
        { "text": "Cas9 cuts the entire chromosome into small fragments randomly", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Cas9 converts the DNA into single-stranded RNA", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Cas9 will cut 10,000 base pairs away from the site", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
