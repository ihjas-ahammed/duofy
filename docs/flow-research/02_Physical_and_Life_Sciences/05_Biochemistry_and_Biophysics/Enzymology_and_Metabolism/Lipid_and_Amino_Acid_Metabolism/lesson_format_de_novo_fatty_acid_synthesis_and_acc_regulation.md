# Duofy Reusable Lesson Format: De Novo Fatty Acid Synthesis and ACC Regulation

**Target Topic:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Enzymology_and_Metabolism / Lipid_and_Amino_Acid_Metabolism`  
**Lesson Format Type:** `de_novo_fatty_acid_synthesis_and_acc_regulation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the cytoplasmic biochemistry, multi-enzyme complexes, and hormonal regulation of de novo lipogenesis (Feodor Lynen & Salih Wakil 1958; Ki-Han Kim): analyze the **Citrate Malate-Pyruvate Shuttle** exporting mitochondrial acetyl-CoA into the cytoplasm via **ATP-Citrate Lyase**, master the committed rate-limiting step catalyzed by **Acetyl-CoA Carboxylase (ACC)** (biotin-dependent carboxylation forming **Malonyl-CoA** under reciprocal hormonal control: activated by Insulin dephosphorylation and Citrate polymerization; inhibited by Glucagon/Epinephrine PKA phosphorylation, AMP-Activated Protein Kinase [AMPK], and Palmitoyl-CoA), trace the multi-domain homodimeric **Fatty Acid Synthase (FAS)** complex (Acyl Carrier Protein [**ACP**] with phosphopantetheine swinging arm, repeating **Condensation $\to$ Reduction [NADPH] $\to$ Dehydration $\to$ Reduction [NADPH]**), and calculate the NADPH requirement provided by the Malic Enzyme and the Pentose Phosphate Pathway.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | De Novo Lipogenesis & Allosteric ACC Control Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fatty Acid Synthase 4-Step Elongation Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Lipogenic Enzyme / Domain & Specific Catalytic Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Essential Reducing Equivalent Coenzyme Consumed by FAS Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Metformin AMPK Activation and ACC Phosphorylation Lipid Suppression Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State De Novo Fatty Acid Synthesis & ACC Regulation (1958/1964):
   - **The Citrate Shuttle (Mitochondria $\to$ Cytoplasm):**
     - Mitochondria: Excess Acetyl-CoA $+$ OAA $\xrightarrow{\text{Citrate Synthase}} \text{Citrate}$.
     - Cytosol: $\text{Citrate} + \text{CoA} + \text{ATP} \xrightarrow{\mathbf{\text{ATP-Citrate Lyase}}} \mathbf{\text{Acetyl-CoA}} + \text{Oxaloacetate} + \text{ADP} + \text{P}_i$.
   - **Acetyl-CoA Carboxylase (ACC - The Committed Step):**
     $$\mathbf{\text{Acetyl-CoA} + \text{HCO}_3^- + \text{ATP} \xrightarrow[\text{Biotin}]{\text{ACC}} \text{Malonyl-CoA} + \text{ADP} + \text{P}_i}$$
     - **Active Conformation:** Polymeric filaments. **Inactive Conformation:** Monomeric protomers.
     - **Hormonal / Allosteric Activators:** **Insulin** (activates protein phosphatase 2A $\to$ dephosphorylates ACC) and **Citrate** (promotes active polymerization).
     - **Inhibitors:** **Glucagon / Epinephrine** (PKA phosphorylation), **AMPK** (cellular energy depletion sensor), and **Palmitoyl-CoA** (end-product feedback).
   - **Fatty Acid Synthase (FAS) Multi-Domain Nanomachine:**
     - Homodimer containing 7 catalytic domains per subunit. Uses **Acyl Carrier Protein (ACP)** with a $4'$-phosphopantetheine prosthetic arm.
     - Repeating $4\text{-step}$ elongation cycle: $\mathbf{\text{Condensation } (\text{KS}) \to \text{Reduction } (\text{KR, consumes NADPH}) \to \text{Dehydration } (\text{DH}) \to \text{Reduction } (\text{ER, consumes NADPH})}$.
     - Overall for Palmitate ($16\text{C}$): Consumes $\mathbf{8\text{ Acetyl-CoA} + 7\text{ ATP} + 14\text{ NADPH}} \longrightarrow \mathbf{\text{Palmitate} + 14\text{ NADP}^+ + 8\text{ CoA} + 7\text{ ADP} + 7\text{ P}_i}$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the Fatty Acid Synthase (FAS) catalytic elongation cycle: (1) acetyl-CoA is transferred to the ACP domain by MAT and transferred to the Cys-SH of the beta-ketoacyl-ACP synthase (KS) domain, (2) malonyl-CoA is loaded onto the phosphopantetheine arm of ACP by MAT, (3) KS catalyzes condensation: the decarboxylation of malonyl-ACP drives nucleophilic attack on the acetyl group, forming acetoacetyl-ACP (4C) and releasing CO2, (4) beta-ketoacyl-ACP reductase (KR) reduces the beta-keto group to an alcohol consuming 1 NADPH, followed by dehydratase (DH) removing water to create a trans-double bond, (5) enoyl-ACP reductase (ER) reduces the double bond consuming a 2nd NADPH to generate a saturated 4-carbon acyl-ACP, ready for the next round of malonyl condensation!
3. **Slide 3 (`matching`):** Pair 4 lipogenic enzymes/domains (ATP-Citrate Lyase, Acetyl-CoA Carboxylase ACC, Acyl Carrier Protein ACP, Thioesterase TE) with their biochemical functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the reducing equivalent cofactor consumed in two reduction steps during each round of fatty acid synthesis is NADPH. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how Metformin suppresses hepatic de novo lipogenesis: Metformin activates AMP-Activated Protein Kinase (AMPK) in human hepatocytes. What direct biochemical effect does activated AMPK have on Acetyl-CoA Carboxylase (ACC) and hepatic lipid synthesis? (AMPK **phosphorylates ACC, converting it into an inactive monomeric form that halts the production of Malonyl-CoA**, shutting down de novo fatty acid synthesis and relieving the inhibition on CPT-I to stimulate fatty acid oxidation).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "de_novo_fatty_acid_synthesis_and_acc_regulation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: De Novo Fatty Acid Synthesis & ACC Regulation (1958/1964)**\n• **The Cytoplasmic Citrate Shuttle:**\n  - $\\text{Citrate (exported from matrix)} + \\text{CoA} + \\text{ATP} \\xrightarrow{\\mathbf{\\text{ATP-Citrate Lyase}}} \\mathbf{\\text{Acetyl-CoA (cytosol)}} + \\text{OAA}$.\n• **Acetyl-CoA Carboxylase (ACC - The Committed Pacemaker):**\n$$\n\\mathbf{\\text{Acetyl-CoA} + \\text{HCO}_3^- + \\text{ATP} \\xrightarrow[\\text{Biotin}]{\\text{ACC}} \\text{Malonyl-CoA} + \\text{ADP} + \\text{P}_i}\n$$\n  - **Activators:** **Insulin** (PP2A dephosphorylation) & **Citrate** (allosteric polymerization into active filaments).\n  - **Inhibitors:** **Glucagon / PKA**, **AMPK** (phosphorylation), and **Palmitoyl-CoA** (feedback).\n• **Fatty Acid Synthase (FAS):** Uses **Acyl Carrier Protein (ACP)** with $4'$-phosphopantetheine arm.\n  - 4-Step Cycle: $\\mathbf{\\text{Condensation } (\\text{KS}) \\to \\text{Reduction (NADPH)} \\to \\text{Dehydration } (\\text{DH}) \\to \\text{Reduction (NADPH)}} \\implies$ Consumes **$14\\text{ NADPH}$ per Palmitate**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential enzymatic reactions of a 2-carbon elongation cycle on Fatty Acid Synthase (FAS).",
      "orderItems": [
        "Malonyl/Acetyl Transferase (MAT) primes the complex by loading an Acetyl group onto KS and a Malonyl group onto ACP",
        "Beta-Ketoacyl Synthase (KS) catalyzes condensation: decarboxylation of malonyl-ACP drives attack on the acetyl group (releases CO2)",
        "Beta-Ketoacyl Reductase (KR) reduces the beta-keto group into an alcohol, consuming one molecule of NADPH",
        "Beta-Hydroxyacyl Dehydratase (DH) removes a molecule of water to create a trans-delta-2 double bond",
        "Enoyl-ACP Reductase (ER) reduces the double bond, consuming a second NADPH to complete the saturated elongated chain"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each lipogenic component to its exact biochemical role.",
      "matchPairs": [
        { "left": "Acetyl-CoA Carboxylase (ACC)", "right": "Biotin-dependent rate-limiting enzyme that synthesizes Malonyl-CoA; activated by Insulin and Citrate" },
        { "left": "ATP-Citrate Lyase", "right": "Cytoplasmic enzyme that cleaves exported mitochondrial Citrate into Acetyl-CoA and Oxaloacetate" },
        { "left": "Acyl Carrier Protein (ACP)", "right": "FAS domain possessing a flexible 4'-phosphopantetheine prosthetic arm that shuttles growing acyl chains" },
        { "left": "Thioesterase (TE Domain)", "right": "Terminal FAS catalytic domain that selectively hydrolyzes the thioester bond to release free Palmitate (16C)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "During de novo fatty acid synthesis on FAS, the essential reducing equivalent cofactor consumed in two reduction steps per cycle is ___.",
      "blankAnswer": "nadph",
      "blankDistractors": ["nadh", "fadh2", "atp"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Metformin is a first-line drug for type 2 diabetes that activates AMP-Activated Protein Kinase (AMPK) in hepatocytes. What is the molecular mechanism by which activated AMPK reduces hepatic lipid accumulation and fatty liver disease (steatosis)?",
      "options": [
        { "text": "AMPK directly phosphorylates Acetyl-CoA Carboxylase (ACC), converting it into an inactive monomeric conformation that halts Malonyl-CoA synthesis, shutting down de novo fatty acid synthesis and relieving the inhibition on CPT-I to stimulate fatty acid oxidation", "isCorrect": true, "explanation": "Correct! AMP-Activated Protein Kinase (AMPK) is the master cellular energy sensor that is activated when AMP/ATP ratios rise (low energy charge). When Metformin activates AMPK in the liver, AMPK directly phosphorylates specific serine residues on Acetyl-CoA Carboxylase (ACC). Phosphorylated ACC dissociates into an inactive monomer, shutting off the conversion of Acetyl-CoA to Malonyl-CoA. This immediately halts de novo lipogenesis and triglyceride accumulation (reducing hepatic steatosis). Furthermore, because Malonyl-CoA levels drop, the allosteric brake on Carnitine Palmitoyltransferase-I (CPT-I) is removed, promoting mitochondrial fatty acid uptake and beta-oxidation." },
        { "text": "AMPK converts all lipids directly into carbon dioxide gas in the stomach", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "AMPK increases insulin resistance in adipose tissue", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "AMPK destroys the cell membrane of liver cells", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
