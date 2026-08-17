# Duofy Reusable Lesson Format: Prokaryotic Operons (Lac and Trp Regulation)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Molecular_Genetics_and_Gene_Regulation`  
**Lesson Format Type:** `prokaryotic_operons_lac_and_trp_regulation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the logic gates, feedback loops, and allosteric mechanisms of bacterial gene regulation (François Jacob & Jacques Monod, Nobel Prize in Physiology or Medicine 1965; Charles Yanofsky): analyze the dual-sensor logic of the **E. coli *lac* Operon** (negative control via **LacI repressor & allolactose inducer** at operator $O$, positive control via **cAMP-CAP catabolite activator** responding to glucose starvation), evaluate the **4 Environmental Combinations** of glucose and lactose, master the **E. coli *trp* Operon** (co-repressor TrpR + **Ribosome-Mediated Attenuation: 2-3 antiterminator hairpin** under low tryptophan vs **3-4 Rho-independent transcription terminator hairpin** under abundant tryptophan), and solve regulatory mutant phenotypes ($I^-, I^s, O^c$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | *lac* and *trp* Operon Logic Circuits Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step *trp* Operon High-Tryptophan Attenuation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Environmental Metabolic State & *lac* Operon Output Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Lac Operon Physiological Inducer Disaccharide Molecule Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Lac Operon Super-Repressor $I^s$ vs Constitutive Operator $O^c$ Mutation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Prokaryotic Operon Regulatory Mechanisms:
   - **The *lac* Operon (Jacob & Monod 1961):**
     - **Negative Control:** **LacI repressor** tetramer binds operator DNA ($O$), sterically blocking RNA polymerase. **Allolactose** (isomer of lactose synthesized by $\beta$-galactosidase) binds LacI $\implies$ allosteric change releases LacI from operator.
     - **Positive Control (Catabolite Repression):** Glucose inhibits Adenylyl Cyclase. When glucose is LOW $\implies$ $[\text{cAMP}]$ rises $\implies$ **cAMP-CAP (Catabolite Activator Protein)** binds upstream CAP site, bending DNA to recruit RNA Polymerase.
     - **Transcription Logic Matrix:**
       $$\begin{array}{|c|c|c|c|l|}
       \hline
       \textbf{Glucose} & \textbf{Lactose} & \textbf{LacI Repressor} & \textbf{CAP-cAMP} & \textbf{Operon Expression} \\
       \hline
       + & - & \text{Bound} & \text{Inactive} & \textbf{No Transcription (OFF)} \\
       + & + & \text{Released} & \text{Inactive} & \textbf{Low / Basal Expression} \\
       - & - & \text{Bound} & \text{Bound} & \textbf{No Transcription (OFF)} \\
       \mathbf{-} & \mathbf{+} & \mathbf{\text{Released}} & \mathbf{\text{Bound}} & \mathbf{\text{HIGH TRANSCRIPTION (FULL ON)}} \\
       \hline
       \end{array}$$
   - **The *trp* Operon Attenuation (Yanofsky):**
     - When tryptophan is low $\implies$ Ribosome stalls at tandem Trp codons in leader peptide $\implies$ Segment 2 pairs with 3 (**2-3 Antiterminator loop**) $\implies$ RNA polymerase transcribes entire operon!
     - When tryptophan is high $\implies$ Ribosome translates past Trp codons to stop codon, covering segment 2 $\implies$ Segment 3 pairs with 4 (**3-4 Terminator loop + poly-U tract**) $\implies$ Transcription terminates prematurely!
2. **Slide 2 (`ordering`):** Provide 5 steps of *trp* operon attenuation under abundant tryptophan: (1) RNA polymerase initiates transcription from the *trp* promoter and synthesizes the leader mRNA ($trpL$), (2) a bacterial ribosome immediately binds the nascent transcript and begins translating the 14-amino acid leader peptide, (3) because charged Trp-tRNA is abundant, the ribosome moves rapidly across the tandem Trp codons without pausing, (4) the rapidly moving ribosome reaches the leader stop codon, physically occluding RNA segment 2, (5) RNA segment 3 base-pairs with segment 4 to form a stable 3-4 GC-rich hairpin followed by a poly-U tract, which functions as an intrinsic Rho-independent terminator that knocks RNA polymerase off the DNA before it can reach the structural genes!
3. **Slide 3 (`matching`):** Pair 4 environmental conditions (+Glucose -Lactose, -Glucose +Lactose, +Glucose +Lactose, -Glucose -Lactose) with their resulting *lac* operon transcription states.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the natural physiological inducer molecule that binds and inactivates the LacI repressor is allolactose. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on *lac* operon regulatory genetics: In *E. coli*, an $I^s$ ("super-repressor") mutation alters the allosteric allolactose-binding pocket of the LacI repressor protein so that it cannot bind allolactose, while retaining its normal DNA-binding domain. What is the phenotypic consequence in a partial diploid $I^s O^+ Z^+ / I^+ O^+ Z^+$ cell grown in medium containing lactose and zero glucose? (The *lac* operon will be **PERMANENTLY REPRESSED (NON-INDUCIBLE / OFF)**; because the mutant $I^s$ super-repressor protein is *trans*-dominant and binds to all operators in the cell, and since it cannot be inactivated by allolactose, it permanently blocks transcription even in the presence of lactose).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "prokaryotic_operons_lac_and_trp_regulation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Prokaryotic Operon Gene Regulation (1965 Nobel)**\n• **The *lac* Operon Dual-Sensor Circuit:**\n  - **Lactose Sensor (Negative Control):** **LacI Repressor** binds operator ($O$). **Allolactose** inducer binds LacI $\\implies$ releases repressor.\n  - **Glucose Sensor (Positive Control):** Low glucose $\\implies$ High cAMP $\\implies$ **cAMP-CAP** binds CAP site $\\implies$ recruits RNA Pol.\n$$\n\\begin{array}{|c|c|c|c|l|}\n\\hline\n\\textbf{Glucose} & \\textbf{Lactose} & \\textbf{Repressor} & \\textbf{CAP} & \\textbf{Expression Level} \\\\\n\\hline\n+ & - & \\text{Bound} & \\text{Off} & \\textbf{Zero Transcription} \\\\\n+ & + & \\text{Released} & \\text{Off} & \\textbf{Low / Basal Transcription} \\\\\n- & - & \\text{Bound} & \\text{On} & \\textbf{Zero Transcription} \\\\\n\\mathbf{-} & \\mathbf{+} & \\mathbf{\\text{Released}} & \\mathbf{\\text{On}} & \\mathbf{\\text{MAXIMUM TRANSCRIPTION (ON)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The *trp* Operon Attenuation:**\n  - **Low Tryptophan:** Ribosome stalls at Trp codons $\\implies$ **2-3 Antiterminator** forms $\\implies$ Full operon transcribed.\n  - **High Tryptophan:** Ribosome advances $\\implies$ **3-4 Terminator hairpin** forms $\\implies$ Transcription halts prematurely!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of trp operon transcriptional attenuation in the presence of abundant tryptophan.",
      "orderItems": [
        "RNA polymerase initiates transcription at the trp promoter and synthesizes the trpL leader mRNA",
        "A ribosome immediately couples to the nascent transcript and begins translating the 14-amino acid leader peptide",
        "Abundant charged Trp-tRNAs allow the ribosome to translate smoothly across the tandem Trp codons without pausing",
        "The moving ribosome covers RNA segment 2, preventing it from base-pairing with RNA segment 3",
        "RNA segment 3 pairs with segment 4 to assemble a 3-4 Rho-independent terminator hairpin that dislodges RNA polymerase"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each environmental nutrient state to its corresponding lac operon expression profile.",
      "matchPairs": [
        { "left": "High Lactose, Low Glucose", "right": "Maximum (High) Transcription: LacI repressor released from operator and cAMP-CAP activator bound" },
        { "left": "High Lactose, High Glucose", "right": "Basal (Low) Transcription: LacI repressor released, but CAP is inactive due to low cAMP" },
        { "left": "No Lactose, High Glucose", "right": "Zero Transcription: LacI repressor firmly bound to operator and CAP is inactive" },
        { "left": "No Lactose, Low Glucose", "right": "Zero Transcription: LacI repressor blocks operator despite active cAMP-CAP binding" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The physiological inducer molecule that binds and allosterically inactivates the LacI repressor protein in E. coli is ___.",
      "blankAnswer": "allolactose",
      "blankDistractors": ["galactose", "glucose", "maltose"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In an E. coli strain harboring a super-repressor mutation (Iˢ) that destroys the allolactose-binding site of LacI while leaving its DNA-binding domain intact, what will be the expression phenotype of the lac operon in the presence of lactose and absence of glucose?",
      "options": [
        { "text": "PERMANENTLY UNINDUCIBLE (TRANSCRIPTION OFF); the mutant Iˢ repressor protein can bind the operator DNA with high affinity but cannot bind allolactose, so it remains permanently locked to the operator, constitutively blocking RNA polymerase", "isCorrect": true, "explanation": "Correct! The Iˢ mutation alters the inducer-binding pocket of the LacI repressor so that allolactose can no longer bind and trigger the conformational change needed for operator release. Because the DNA-binding domain remains functional, the mutant Iˢ repressor binds the operator and never lets go. Furthermore, because LacI is a diffusible trans-acting tetramer, Iˢ is trans-dominant over wild-type I⁺, keeping the operon completely repressed under all growth conditions." },
        { "text": "Constitutively active at 1,000% rate", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It converts lactose into nitrogen gas", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Operon operates normally with zero defects", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
