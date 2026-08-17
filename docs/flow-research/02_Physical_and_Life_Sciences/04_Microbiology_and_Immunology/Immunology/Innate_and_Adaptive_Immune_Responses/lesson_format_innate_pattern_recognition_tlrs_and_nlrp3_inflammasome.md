# Duofy Reusable Lesson Format: Innate Pattern Recognition (TLRs and the NLRP3 Inflammasome)

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Immunology / Innate_and_Adaptive_Immune_Responses`  
**Lesson Format Type:** `innate_pattern_recognition_tlrs_and_nlrp3_inflammasome`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular biophysics, receptor topologies, and inflammatory signaling cascades of innate pattern recognition (Charles Janeway; Jules Hoffmann & Bruce Beutler, Nobel Prize in Physiology or Medicine 2011; Jurg Tschopp): contrast cell-surface Toll-Like Receptors (**TLR4/MD-2 recognizing bacterial LPS**, **TLR2/1 & TLR2/6 recognizing lipopeptides**, **TLR5 recognizing flagellin**) with endosomal nucleic acid sensors (**TLR3 [dsRNA], TLR7/8 [ssRNA], TLR9 [CpG DNA]**), master the **Two-Signal Activation of the NLRP3 Inflammasome** (**Signal 1 Priming: NF-$\kappa$B upregulating pro-IL-1$\beta$ / NLRP3**; **Signal 2 Trigger: $\text{K}^+$ efflux / crystals assembling the NLRP3-ASC-pro-Caspase-1 wheel**), and evaluate **Gasdermin D (GSDMD)** cleavage driving **Pyroptotic Lytic Cell Death**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PRRs, TLR Topologies & Inflammasome Pyroptosis Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Two-Signal NLRP3 Inflammasome Activation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pattern Recognition Receptor / Adaptor & Ligand Specificity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Inflammasome Pore-Forming Pyroptotic Executioner Protein Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Endosomal TLR9 Unmethylated CpG Dinucleotide Recognition Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Innate Pattern Recognition & The NLRP3 Inflammasome (2011 Nobel):
   - **Toll-Like Receptor (TLR) Topologies & Ligands:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Receptor} & \textbf{Cellular Location} & \textbf{Primary Ligand (PAMP)} & \textbf{Adaptor / Output} \\
     \hline
     \textbf{TLR4 / MD-2} & \text{Plasma Membrane} & \text{Gram-Negative LPS (Lipid A)} & \text{MyD88 + TRIF } \implies \text{NF-}\kappa\text{B + Type I IFNs} \\
     \textbf{TLR2 / TLR1/6} & \text{Plasma Membrane} & \text{Bacterial Lipopeptides, Teichoic acid} & \text{MyD88 } \implies \text{NF-}\kappa\text{B (Pro-inflammatory)} \\
     \textbf{TLR5} & \text{Plasma Membrane} & \text{Bacterial Flagellin} & \text{MyD88 } \implies \text{NF-}\kappa\text{B} \\
     \textbf{TLR3} & \text{Endosome} & \text{Viral Double-Stranded RNA (dsRNA)} & \mathbf{\text{TRIF } \implies \text{IRF3 (Type I IFN-}\beta\text{)}} \\
     \textbf{TLR7 / TLR8} & \text{Endosome} & \text{Viral Single-Stranded RNA (ssRNA)} & \text{MyD88 } \implies \text{IRF7 / NF-}\kappa\text{B} \\
     \textbf{TLR9} & \text{Endosome} & \mathbf{\text{Unmethylated CpG DNA}} & \text{MyD88 } \implies \text{Type I IFNs + Cytokines} \\
     \hline
     \end{array}$$
   - **The NLRP3 Inflammasome & Pyroptosis (Tschopp 2002):**
     - **Signal 1 (Priming):** PRR activation $\to$ NF-$\kappa$B nuclear translocation $\to$ transcribes **pro-IL-1$\beta$, pro-IL-18, and NLRP3**.
     - **Signal 2 (Activation Trigger):** Potassium ($\text{K}^+$) efflux, ATP (P2X7 receptor), uric acid crystals (gout), or particulate matter $\to$ triggers NLRP3 oligomerization with **ASC adaptor** and **pro-Caspase-1**.
     - **Execution:** Active **Caspase-1** processes **pro-IL-1$\beta \to \mathbf{\text{IL-1}\beta}$** and **pro-IL-18 $\to \mathbf{\text{IL-18}}$**, and cleaves **Gasdermin D (GSDMD)** $\implies$ GSDMD N-terminal domain oligomerizes into giant $18\text{-nm}$ membrane pores $\implies$ **Pyroptosis** (inflammatory lytic burst)!
2. **Slide 2 (`ordering`):** Provide 5 steps of the two-signal NLRP3 inflammasome activation pathway: (1) bacterial LPS binds cell-surface TLR4, delivering Signal 1 (priming) to activate NF-kappa B, (2) NF-kappa B drives high-level transcription of pro-IL-1 beta, pro-IL-18, and NLRP3, (3) extracellular ATP binds the purinergic P2X7 receptor, delivering Signal 2 by triggering rapid potassium (K+) efflux from the cytosol, (4) low intracellular potassium prompts NLRP3 to assemble with the ASC adaptor protein and pro-Caspase-1 into the wheel-like inflammasome complex, (5) active Caspase-1 cleaves pro-IL-1 beta into mature IL-1 beta and cleaves Gasdermin D to form lytic membrane pores, executing inflammatory pyroptosis!
3. **Slide 3 (`matching`):** Pair 4 innate immune sensors (TLR4/MD-2, TLR3, TLR9, NLRP3 Inflammasome) with their molecular ligands (Bacterial Lipopolysaccharide, Viral Double-Stranded RNA, Unmethylated CpG DNA, Intracellular Potassium Efflux / Crystals).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the pore-forming executioner protein cleaved by Caspase-1 during pyroptosis is Gasdermin D (GSDMD). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how endosomal TLR9 selectively distinguishes microbial DNA from host mammalian DNA: How does the innate pattern recognition receptor TLR9 recognize viral and bacterial DNA inside endosomes while avoiding activation by self human genomic DNA? (TLR9 specifically recognizes **unmethylated cytosine-phosphate-guanine (CpG) dinucleotide motifs**, which are abundant and unmethylated in bacterial and viral genomes, but are **heavily suppressed in frequency and methylated (5-methylcytosine) in mammalian genomic DNA**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "innate_pattern_recognition_tlrs_and_nlrp3_inflammasome",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Innate Pattern Recognition (TLRs & Inflammasome)**\n• **Toll-Like Receptor (TLR) Topologies:**\n  - **Cell Surface (Bacterial):**\n    - **TLR4 / MD-2:** Gram-negative LPS (Lipid A) $\\implies$ MyD88/TRIF $\\to$ NF-$\\kappa$B.\n    - **TLR2/1 & TLR2/6:** Bacterial Lipopeptides / Teichoic acids.\n    - **TLR5:** Bacterial Flagellin.\n  - **Endosomal (Viral Nucleic Acids):**\n    - **TLR3:** Viral **dsRNA** $\\implies$ **TRIF $\\to$ IRF3 (Type I IFN-$\\beta$)**.\n    - **TLR7/8:** Viral **ssRNA**.\n    - **TLR9:** **Unmethylated CpG DNA**.\n• **The NLRP3 Inflammasome & Pyroptosis:**\n  - **Signal 1 (Priming):** TLR $\\to$ NF-$\\kappa$B synthesizes pro-IL-1$\\beta$ + NLRP3.\n  - **Signal 2 (Trigger):** $\\text{K}^+$ efflux / ATP / Crystals $\\implies$ Assembles **NLRP3-ASC-Caspase-1**.\n  - **Execution:** Caspase-1 activates **IL-1$\\beta$ & IL-18** + Cleaves **Gasdermin D (GSDMD)** $\\implies$ **Pyroptotic Cell Lysis**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential molecular steps of the two-signal NLRP3 inflammasome pathway.",
      "orderItems": [
        "Signal 1 (Priming): Microbial PAMPs engage surface TLRs to activate NF-kappa B nuclear translocation",
        "NF-kappa B upregulates transcription of pro-IL-1beta, pro-IL-18, and the NLRP3 sensor protein",
        "Signal 2 (Trigger): Extracellular ATP or crystalline particulates trigger massive intracellular potassium (K+) efflux",
        "NLRP3 oligomerizes with the ASC adaptor and recruits pro-Caspase-1 into the wheel-like inflammasome complex",
        "Active Caspase-1 cleaves pro-IL-1beta into mature IL-1beta and cleaves Gasdermin D to form lytic membrane pores (pyroptosis)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each innate pattern recognition receptor to its cognate molecular ligand.",
      "matchPairs": [
        { "left": "TLR4 / MD-2 Receptor", "right": "Lipopolysaccharide (Lipid A endotoxin) on outer membrane of Gram-negative bacteria" },
        { "left": "Endosomal TLR3", "right": "Viral double-stranded RNA (dsRNA) generated during viral replication intermediates" },
        { "left": "Endosomal TLR9", "right": "Unmethylated CpG dinucleotide motifs in bacterial and viral DNA genomes" },
        { "left": "NLRP3 Inflammasome", "right": "Cytosolic danger sensor activated by potassium efflux, ATP, and crystalline particulates (urate/asbestos)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The pore-forming executioner protein cleaved by Caspase-1 that oligomerizes in the plasma membrane to execute inflammatory pyroptotic cell lysis is ___ D.",
      "blankAnswer": "gasdermin",
      "blankDistractors": ["perforin", "granzyme", "caspase"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does the endosomal pattern recognition receptor TLR9 distinguish microbial DNA from host human genomic DNA without causing autoimmune self-destruction?",
      "options": [
        { "text": "TLR9 specifically recognizes UNMETHYLATED CpG DINUCLEOTIDES; in bacterial and viral DNA, CpG motifs occur frequently and remain unmethylated, whereas in mammalian genomic DNA, CpG motifs are severely suppressed in frequency and heavily methylated (5-methylcytosine), which prevents TLR9 activation", "isCorrect": true, "explanation": "Correct! In vertebrate genomes, the dinucleotide CpG is subject to evolutionary 'CpG suppression' (occurring at ~20% of expected frequency) and roughly 70-80% of all cytosines in mammalian CpG sites are covalently methylated into 5-methylcytosine. In contrast, bacterial and viral DNA contains unmethylated CpG motifs at high, unsuppressed frequencies. Endosomal TLR9 possesses an acidic binding pocket tailored specifically to recognize unmethylated CpG motifs. When bacterial or viral DNA is delivered to the endolysosome, TLR9 binds the unmethylated CpG motifs, firing MyD88-dependent signaling to produce Type I interferons and inflammatory cytokines while ignoring methylated host DNA." },
        { "text": "Human DNA cannot enter endosomes under any circumstances", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Bacterial DNA is made of triple-stranded RNA", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "TLR9 destroys all DNA using laser beams", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
