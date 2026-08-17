# Duofy Reusable Lesson Format: Cyclin-CDK Regulation and Cell Cycle Checkpoints

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / Signal_Transduction_and_Cell_Cycle_Control`  
**Lesson Format Type:** `cyclin_cdk_regulation_and_cell_cycle_checkpoints`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the oscillatory biochemical engine and surveillance checkpoints governing the eukaryotic cell cycle (Leland Hartwell, Tim Hunt, Paul Nurse, Nobel Prize in Physiology or Medicine 2001): trace the sequential waves of **Cyclin-CDK Complexes (Cyclin D-CDK4/6 [$G_1$], Cyclin E-CDK2 [$G_1/S$], Cyclin A-CDK2 [$S$], Cyclin B-CDK1 [MPF, Mitosis])**, analyze the **$G_1/S$ Restriction Point Mechanism (Rb phosphorylation releasing E2F)**, evaluate the 3-enzyme post-translational regulation of CDK1 (**CAK** activating Thr161 phosphorylation, **Wee1 Kinase** inhibitory Tyr15 phosphorylation, **Cdc25 Phosphatase** removal of Tyr15 to trigger explosive mitotic entry), and formulate the **DNA Damage Checkpoint (ATM/ATR $\to$ Chk1/Chk2 $\to$ p53 $\to$ p21 CIP1/WAF1)** and **Spindle Assembly Checkpoint (SAC, Mad2/BubR1 $\to$ APC/C-Cdc20)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cyclin-CDK Oscillators & Checkpoint Network Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step $G_1 \to S$ Restriction Point Transition Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cell Cycle Regulator & Biochemical Control Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | p53-Induced Universal CDK Inhibitor Gene Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Wee1 Kinase Loss-of-Function Premature Mitosis Fission Yeast Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Cyclin-CDK Engine & Surveillance Checkpoints:
   - **The Cyclin-CDK Wave Architecture (Hunt, Nurse, Hartwell, 2001 Nobel):**
     $$\begin{array}{|c|c|c|l|}
     \hline
     \textbf{Phase} & \textbf{Cyclin} & \textbf{CDK Partner} & \textbf{Primary Function} \\
     \hline
     G_1 & \text{Cyclin D} & \text{CDK4 / CDK6} & \text{Initial phosphorylation of Rb; mitogen sensing} \\
     G_1/S & \text{Cyclin E} & \text{CDK2} & \text{Hyperphosphorylates Rb; passes Restriction Point} \\
     S & \text{Cyclin A} & \text{CDK2} & \text{Origin firing, blocks re-replication} \\
     M & \text{Cyclin B} & \text{CDK1 (MPF)} & \text{Nuclear envelope breakdown, spindle assembly} \\
     \hline
     \end{array}$$
   - **The $G_1/S$ Restriction Point (R-Point):**
     - In uncommitted $G_1$, **Retinoblastoma protein (Rb)** binds and silences **E2F** transcription factors.
     - Cyclin D-CDK4/6 and Cyclin E-CDK2 hyperphosphorylate Rb, releasing active E2F to transcribe $S$-phase genes (DNA polymerases, thymidine kinase, Cyclin A).
   - **The DNA Damage Checkpoint:**
     - DNA DSBs $\to$ **ATM / ATR kinases** $\to$ Phosphorylate **Chk2 / Chk1** $\to$ Phosphorylate and stabilize **p53** tumor suppressor (preventing Mdm2 ubiquitination) $\to$ p53 drives transcription of **p21 (CIP1/WAF1)** $\to$ p21 binds and arrests CDK4/6 and CDK2!
   - **The Spindle Assembly Checkpoint (SAC):**
     - Unattached kinetochores recruit **Mad2 / BubR1** to inhibit **APC/C-Cdc20**, preventing securin degradation until all chromosomes align at metaphase plate.
2. **Slide 2 (`ordering`):** Provide 5 steps of the $G_1$ to $S$ phase transition through the Restriction Point: (1) extracellular mitogens stimulate the Ras-MAPK cascade, inducing synthesis of Cyclin D, (2) Cyclin D binds CDK4/6, forming an active complex that hypophosphorylates the Retinoblastoma protein (Rb), (3) partial Rb phosphorylation releases a small amount of E2F, which transcribes the gene for Cyclin E, (4) Cyclin E binds CDK2 to form a positive feedback loop that hyperphosphorylates Rb on multiple serine/threonine residues, (5) fully hyperphosphorylated Rb dissociates completely from E2F, allowing unrestricted transcription of $S$-phase replication machinery and crossing the irreversible Restriction Point!
3. **Slide 3 (`matching`):** Pair 4 cell cycle regulators (Retinoblastoma Protein Rb, p21 CIP1/WAF1, Wee1 Kinase, Cdc25 Phosphatase) with their specific mechanistic actions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the universal CDK-inhibitor protein transcribed by p53 in response to DNA damage is p21. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the discovery of Wee1 kinase in fission yeast (*Schizosaccharomyces pombe*): In Paul Nurse's classic genetic screens, why do yeast cells bearing a loss-of-function mutation in the *wee1* gene divide at half their normal cell size ("wee" phenotype)? (Because **Wee1 is the inhibitory kinase that phosphorylates Tyr15 on CDK1 (Cdc2) to hold mitosis in check until cell growth is complete**; lacking Wee1 inhibition, Cyclin B-CDK1 becomes prematurely hyperactive, forcing cells to divide prematurely before reaching full size).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cyclin_cdk_regulation_and_cell_cycle_checkpoints",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cyclin-CDK Regulation and Cell Cycle Checkpoints**\n• **Cyclin-CDK Oscillatory Engine (2001 Nobel Prize):**\n  - **$G_1$:** Cyclin D + **CDK4/6** (phosphorylates Rb).\n  - **$G_1/S$:** Cyclin E + **CDK2** (hyperphosphorylates Rb $\\implies$ passes Restriction Point).\n  - **$S$:** Cyclin A + **CDK2** (fires DNA replication origins).\n  - **$M$:** Cyclin B + **CDK1** (MPF drives mitotic entry).\n• **The $G_1/S$ Restriction Point Gate:**\n$$\n\\text{Hypo-P Rb}\\cdot\\text{E2F (Silenced)} \\xrightarrow{\\text{Cyclin D/E-CDK}} \\mathbf{\\text{Hyper-P Rb}} + \\mathbf{\\text{Free E2F}} \\implies S\\text{-Phase Entry!}\n$$\n• **Surveillance Checkpoints:**\n  - **DNA Damage Checkpoint:** ATM/ATR $\\to$ Chk1/Chk2 $\\to$ Stabilizes **p53** $\\to$ Transcribes **p21 (CDK inhibitor)** $\\implies$ Cell Cycle Arrest.\n  - **Spindle Assembly Checkpoint (SAC):** Unattached kinetochores recruit **Mad2** to block **APC/C-Cdc20** until all chromosomes achieve amphitelic alignment."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential molecular steps crossing the G1/S Restriction Point into DNA synthesis.",
      "orderItems": [
        "Mitogenic growth factors activate the Ras-MAPK pathway to induce high-level transcription of Cyclin D",
        "Cyclin D-CDK4/6 complexes assemble and perform initial hypophosphorylation on the Retinoblastoma protein (Rb)",
        "Partially derepressed E2F transcribes the gene encoding Cyclin E, creating a positive feedback amplification loop",
        "Cyclin E-CDK2 complexes execute multi-site hyperphosphorylation of Rb, forcing complete Rb dissociation from E2F",
        "Free E2F transcribes S-phase replication genes (DNA polymerases, PCNA, Cyclin A), locking the cell irreversibly into S-phase"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each cell cycle regulatory protein to its precise biochemical function.",
      "matchPairs": [
        { "left": "Retinoblastoma Protein (Rb)", "right": "Tumor suppressor that binds and silences E2F transcription factors to prevent premature S-phase entry" },
        { "left": "p21 (CIP1 / WAF1)", "right": "Universal CDK-inhibitor protein induced by p53 that clamps CDK4/6 and CDK2 upon DNA damage" },
        { "left": "Wee1 Kinase", "right": "Inhibitory kinase that phosphorylates Tyr15 on CDK1 to prevent premature entry into mitosis" },
        { "left": "Cdc25 Phosphatase", "right": "Activating dual-specificity phosphatase that removes inhibitory Tyr15 phosphate from CDK1 to trigger mitosis" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In response to double-strand DNA breaks, the tumor suppressor p53 induces transcription of the universal CDK-inhibitor protein ___ (CIP1/WAF1).",
      "blankAnswer": "p21",
      "blankDistractors": ["p16", "p27", "p57"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Paul Nurse's pioneering yeast genetics, why do fission yeast cells carrying a loss-of-function mutation in the wee1 gene divide at half their normal cell size ('wee' mutant phenotype)?",
      "options": [
        { "text": "Wee1 is the inhibitory kinase that adds an inhibitory phosphate to Tyr15 of CDK1 (Cdc2) to delay mitosis until adequate cell growth is achieved; lacking Wee1, CDK1 becomes prematurely hyperactive and drives cells into division prematurely before normal growth", "isCorrect": true, "explanation": "Correct! CDK1 activity is tightly restrained during G2 by Wee1 kinase, which phosphorylates Tyr15 in the ATP-binding pocket of CDK1. This inhibitory brake gives the cell time to grow to full size. In wee1-deficient mutants, this negative regulation is lost, allowing Cyclin B-CDK1 to fire prematurely. The cells enter mitosis and divide at approximately half their normal size, giving rise to the classic 'wee' phenotype that helped Paul Nurse identify the universal engine of cell division." },
        { "text": "Because Wee1 makes yeast cell walls thick like wood", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because without Wee1, yeast cannot eat glucose", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Wee1 mutations cause DNA to disappear completely", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
