# Duofy Reusable Lesson Format: Protein Targeting and the Signal Hypothesis (SRP and Sec61)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / Organelles_and_Membrane_Transport`  
**Lesson Format Type:** `protein_targeting_and_signal_hypothesis_srp_sec61`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular mechanics of intracellular protein sorting and topogenesis (Günter Blobel, Nobel Prize in Physiology or Medicine 1999): master the **Signal Hypothesis** of co-translational translocation into the Rough Endoplasmic Reticulum (N-terminal hydrophobic **Signal Peptide** $\to$ **Signal Recognition Particle [SRP]** binding and translational elongation arrest $\to$ docking to membrane-bound **SRP Receptor** $\to$ ribosome handover to the **Sec61 Heterotrimeric Translocon Channel** $\to$ **Signal Peptidase** cleavage $\to$ lumenal folding mediated by **BiP / GRP78** chaperone), contrast post-translational import into **Mitochondria (TOM/TIM complexes, mitochondrial Hsp70, and $\Delta \Psi_m$)** and **Peroxisomes (Pex5 receptor recognizing C-terminal PTS1 SKL tripeptide)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Signal Hypothesis & Co-Translational Translocation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step ER Co-Translational Translocation Cascade Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Organelle Targeting Signal & Cellular Destination Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | ER Membrane Core Protein Translocating Channel Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Signal Sequence Mutation and Translocation Failure Consequence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Signal Hypothesis & Protein Topogenesis (Günter Blobel, 1975; 1999 Nobel):
   - **The Co-Translational ER Import Cascade:**
     $$\text{Ribosome} \longrightarrow \text{N-terminal Signal Peptide (Hydrophobic Core)} \longrightarrow \text{SRP Binding} \longrightarrow \text{Elongation Arrest}$$
     $$\xrightarrow{\text{GTP-dependent Docking}} \text{SRP Receptor} \longrightarrow \text{Sec61 Translocon Opening} \longrightarrow \text{Signal Peptidase Cleavage}$$
   - **Key Molecular Machinery:**
     1. **Signal Recognition Particle (SRP):** Ribonucleoprotein (7SL RNA + 6 proteins) with a methionine-rich hydrophobic groove that binds hydrophobic signal peptides ($15-30$ residues) as they emerge from the ribosomal exit tunnel, halting translation.
     2. **SRP Receptor (SR):** Heterodimeric GTPase on the cytosolic face of the rough ER membrane.
     3. **Sec61 Translocon:** Aqueous heterotrimeric channel ($\alpha, \beta, \gamma$) with an hourglass constriction and a dynamic **lateral gate** that opens to release hydrophobic transmembrane stop-transfer sequences into the lipid bilayer.
     4. **Signal Peptidase:** Luminal protease that cleaves off the signal peptide, liberating soluble proteins into the ER lumen where **BiP (Hsp70 chaperone)** pulls the chain forward and assists in folding.
   - **Alternative Organellar Targeting Signals:**
     - **Mitochondria:** Amphipathic $\alpha$-helix with basic residues on one side $\to$ **TOM / TIM23** translocons.
     - **Peroxisomes:** C-terminal **PTS1 tripeptide (Ser-Lys-Leu / SKL)** $\to$ cytosolic **Pex5** receptor.
2. **Slide 2 (`ordering`):** Provide 5 steps of the co-translational ER translocation pathway: (1) ribosome initiates translation in the cytosol, and an N-terminal hydrophobic signal peptide emerges from the ribosomal exit tunnel, (2) the Signal Recognition Particle (SRP) binds the signal peptide and wraps around the ribosome, temporarily arresting polypeptide elongation, (3) the ribosome-SRP complex docks to the membrane-bound SRP receptor on the rough ER, driven by GTP binding, (4) GTP hydrolysis stimulates SRP release and transfers the ribosome directly onto the Sec61 translocon pore, opening the translocon plug, (5) translation resumes, pushing the nascent polypeptide into the translocon pore where signal peptidase cleaves the signal peptide, releasing the mature protein into the ER lumen!
3. **Slide 3 (`matching`):** Pair 4 targeting signals (N-terminal 15-30 hydrophobic signal peptide, Amphipathic alpha-helix with basic residues, C-terminal -SKL tripeptide [PTS1], Polybasic sequence -PKKKRKV- [NLS]) with their organelle destinations (Endoplasmic Reticulum lumen, Mitochondrial matrix via TOM/TIM, Peroxisomal lumen via Pex5, Cell nucleus via Importin-alpha/beta).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the core heterotrimeric protein-conducting channel in the ER membrane is the Sec61 translocon. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on mutating the signal peptide: If genetic engineering mutates the hydrophobic core of the N-terminal signal sequence of human insulin into charged hydrophilic amino acids (e.g. replacing Leu/Val with Arg/Glu), where will the mutant insulin protein end up, and why? (The mutant protein will be **fully synthesized by free ribosomes and accumulate in the CYTOSOL (never entering the ER/secretory pathway)**; because SRP cannot recognize or bind hydrophilic sequences, the ribosome never docks to the ER membrane, preventing translocon engagement).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "protein_targeting_and_signal_hypothesis_srp_sec61",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Signal Hypothesis and Protein Targeting (Blobel, 1999 Nobel)**\n• **Co-Translational ER Translocation:**\n  - **Signal Peptide:** $15\\text{--}30$ amino acid N-terminal tag with a central **hydrophobic core**.\n  - **SRP (Signal Recognition Particle):** Binds signal peptide at ribosome exit tunnel $\\implies$ **Arrests elongation**.\n  - **Docking & Translocon:** SRP docks to **SRP Receptor** (GTP-driven); ribosome loads onto **Sec61 Translocon** pore.\n  - **Translocon Gating:** Sec61 plug displaces; **Signal Peptidase** cleaves signal peptide; **BiP chaperone** aids luminal folding.\n• **Alternative Organellar Targeting Zip Codes:**\n  - **Mitochondria:** Amphipathic basic $\\alpha$-helix $\\to$ **TOM / TIM23** complexes (needs $\\Delta \\Psi_m$).\n  - **Peroxisomes:** C-terminal **-SKL (PTS1)** $\\to$ cytosolic **Pex5** receptor.\n  - **Nucleus:** Basic **NLS (-PKKKRKV-)** $\\to$ **Importin-$\\alpha/\\beta$**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of co-translational protein targeting into the endoplasmic reticulum.",
      "orderItems": [
        "A cytosolic ribosome translates mRNA until a hydrophobic N-terminal signal peptide emerges from the exit tunnel",
        "The Signal Recognition Particle (SRP) binds the signal peptide and arrests further polypeptide elongation",
        "The ribosome-SRP complex diffuses to the rough ER and docks with the membrane-bound SRP receptor (SR)",
        "GTP hydrolysis triggers SRP release, docking the ribosome directly onto the aqueous Sec61 translocon pore",
        "Translation resumes, feeding the nascent chain through Sec61 as signal peptidase cleaves the signal peptide"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each organellar targeting signal to its final subcellular destination.",
      "matchPairs": [
        { "left": "N-terminal 15-30 aa Hydrophobic Signal Peptide", "right": "Endoplasmic Reticulum lumen / Secretory pathway (via SRP and Sec61)" },
        { "left": "Amphipathic alpha-helix with basic positive residues", "right": "Mitochondrial Matrix (via TOM/TIM translocase complexes)" },
        { "left": "C-terminal -Ser-Lys-Leu-COO⁻ (-SKL / PTS1)", "right": "Peroxisomal Matrix (recognized by cytosolic Pex5 receptor)" },
        { "left": "Basic Pro-Lys-Lys-Lys-Arg-Lys-Val (Classic NLS)", "right": "Nuclear Interior (transported through Nuclear Pore Complex by Importin)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the rough endoplasmic reticulum membrane, the heterotrimeric aqueous channel that conducts growing polypeptides into the lumen is the ___ translocon.",
      "blankAnswer": "sec61",
      "blankDistractors": ["tom40", "tim23", "pex14"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If recombinant DNA engineering replaces the hydrophobic core of the N-terminal signal sequence of insulin with charged hydrophilic residues (e.g. arginine and glutamate), where will the mutant insulin protein accumulate?",
      "options": [
        { "text": "In the CYTOSOL; without a hydrophobic core, the Signal Recognition Particle (SRP) cannot bind the emerging nascent chain, so translation completes in the cytoplasm without ER docking or entry into the secretory pathway", "isCorrect": true, "explanation": "Correct! The hydrophobic binding groove of the 54-kDa subunit of SRP specifically recognizes and binds hydrophobic segments of 8-15 nonpolar amino acids. If these are mutated into charged hydrophilic residues (Arg, Glu), SRP will fail to bind the nascent polypeptide. The ribosome will continue translating the protein entirely in the cytosol, and because the protein never enters the ER lumen, it will not be processed, folded, or secreted, remaining trapped in the cytoplasm." },
        { "text": "Inside the mitochondrial intermembrane space", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Inside the cell nucleus", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Inside the peroxisome", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
