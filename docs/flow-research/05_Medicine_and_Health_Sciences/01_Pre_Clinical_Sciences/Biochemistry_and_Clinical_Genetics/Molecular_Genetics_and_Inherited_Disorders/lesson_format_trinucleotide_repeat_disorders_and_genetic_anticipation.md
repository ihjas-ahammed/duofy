# Duofy Reusable Lesson Format: Dynamic Mutations (Trinucleotide Repeats & Anticipation)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Biochemistry_and_Clinical_Genetics / Molecular_Genetics_and_Inherited_Disorders`  
**Lesson Format Type:** `trinucleotide_repeat_disorders_and_genetic_anticipation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the molecular genetics and neurodegenerative phenotypes of the four major **Trinucleotide Repeat Expansion Disorders**, dynamic mutations, replication slippage during gametogenesis, the clinical phenomenon of **Genetic Anticipation** (progressive increase in trinucleotide repeat tract length in successive generations leading to earlier disease onset and greater phenotypic severity), **Huntington Disease** (autosomal dominant $(\text{CAG})_n$ expansion in the coding region of the *HTT* gene on chromosome 4p $\to$ toxic polyglutamine tract causing bilateral caudate and putamen atrophy, chorea, and dementia; expands during paternal transmission), **Fragile X Syndrome** (X-linked dominant $(\text{CGG})_n$ expansion in the 5' UTR of the *FMR1* gene $\to$ promoter hypermethylation and transcriptional silencing; intellectual disability, macroorchidism, long face, large everted ears, mitral valve prolapse; expands during maternal transmission), **Friedreich Ataxia** (autosomal recessive $(\text{GAA})_n$ expansion in intron 1 of the *FXN* frataxin gene on chromosome 9q $\to$ mitochondrial iron overload, spinocerebellar degeneration, sensory neuropathy, hypertrophic cardiomyopathy, diabetes), and **Myotonic Dystrophy Type 1 (DM1)** (autosomal dominant $(\text{CTG})_n$ expansion in the 3' UTR of the *DMPK* gene on chromosome 19q $\to$ toxic RNA nuclear foci trapping muscleblind-like MBNL1 splicing factors causing aberrant alternative splicing; sustained muscle myotonia, cataracts, frontal balding, gonadal atrophy) (Robert L. Nussbaum et al. *Thompson & Thompson Genetics in Medicine* 8th ed. Chapter 7; Bruce Alberts et al. *Molecular Biology of the Cell* 7th ed.): formulate the **Trinucleotide Repeat Disorders Comparative Master Matrix**:
$$\begin{array}{|l|c|l|l|l|}
\hline
\textbf{Disorder Name} & \textbf{Codon Repeat} & \textbf{Gene / Chromosome} & \textbf{Molecular Location / Mechanism} & \textbf{High-Yield Clinical Mnemonic} \\
\hline
\mathbf{\text{Huntington Disease}} & \mathbf{(\text{CAG})_n} & \mathbf{\text{HTT / Chr 4p}} & \mathbf{\text{Exon (Coding): Polyglutamine tract}} & \mathbf{\text{Caudate } \mathbf{C}\text{AG, Chorea, Cognitive loss}} \\
\mathbf{\text{Fragile X Syndrome}} & \mathbf{(\text{CGG})_n} & \mathbf{\text{FMR1 / Chr Xq27.3}} & \mathbf{\text{5' UTR: Promoter Hypermethylation}} & \mathbf{\text{Chin (large), Giant Gonads, } \mathbf{C}\text{GG}} \\
\mathbf{\text{Friedreich Ataxia}} & \mathbf{(\text{GAA})_n} & \mathbf{\text{FXN / Chr 9q21}} & \mathbf{\text{Intron 1: Transcriptional interference}} & \mathbf{\text{Gait Ataxia Array, Cardiomyopathy, } \mathbf{G}\text{AA}} \\
\mathbf{\text{Myotonic Dystrophy}} & \mathbf{(\text{CTG})_n} & \mathbf{\text{DMPK / Chr 19q13}} & \mathbf{\text{3' UTR: Toxic RNA splicing entrapment}} & \mathbf{\text{Cataracts, Toupee, Gonadal atrophy, } \mathbf{C}\text{TG}} \\
\hline
\end{array}$$
master the **Genetic Anticipation Gametogenesis Invariant**:
$$\mathbf{\text{Repeat Tract Expansion} \xrightarrow[\text{Slippage}]{\text{Replication}} \text{Successive Generations inherit longer repeats} \implies \mathbf{\text{Earlier Age of Onset} + \text{Increased Clinical Severity}}}$$
(proving that coding CAG repeats produce toxic gain-of-function polyglutamine proteins, 5' UTR CGG repeats cause epigenetic silencing, intronic GAA repeats reduce mitochondrial frataxin, and 3' UTR CTG repeats cause toxic RNA-mediated spliceopathy).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Trinucleotide Repeat Codons (CAG, CGG, GAA, CTG), Genomic Locations & Anticipation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Repeat Tract Expansion and Multi-Generational Anticipation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Trinucleotide Repeat Disorder / 3-Letter Codon & Technical Pathophysiological Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Common Genetic Phenomenon Whereby an Inherited Disorder Manifests with Progressively Earlier Age of Onset and Increased Clinical Severity in Successive Generations Is Termed Genetic ___ (Anticipation / Genetic Anticipation) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Genetics & Neurology Problem: Diagnosing Myotonic Dystrophy from Delayed Muscle Relaxation and CTG Repeat Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Trinucleotide Repeat Expansion & Anticipation (Nussbaum 2016; Lehninger 2021):
   - **Disorder Formulations:**
     $$\mathbf{\text{Huntington: } (\text{CAG})_n \text{ on Chr 4p} \quad \Big| \quad \text{Fragile X: } (\text{CGG})_n \text{ on Chr Xq}}$$
     $$\mathbf{\text{Friedreich Ataxia: } (\text{GAA})_n \text{ on Chr 9q} \quad \Big| \quad \text{Myotonic Dystrophy: } (\text{CTG})_n \text{ on Chr 19q}}$$
   - **The Expansion Location Invariant:**
     - Huntington: **Coding Exon** (Polyglutamine);
     - Fragile X: **5' UTR** (Hypermethylation silencing);
     - Friedreich: **Intron 1** (Impaired frataxin transcription);
     - Myotonic Dystrophy: **3' UTR** (Toxic RNA mis-splicing)!
2. **Slide 2 (`ordering`):** Provide 5 steps of the genetic anticipation mechanism in Huntington disease: (1) grandfather carries a premutation range of 32 CAG repeats in the HTT gene and remains asymptomatic, (2) during spermatogenesis, replication slippage of DNA polymerase causes the unstable repeat tract to expand into the pathogenic range (44 CAG repeats), (3) the father inherits 44 repeats and develops adult-onset chorea and cognitive decline at age 48, (4) during the father's spermatogenesis, further massive meiotic expansion yields a 72 CAG repeat tract, (5) his son inherits 72 repeats and presents with severe juvenile Huntington disease with rigidity and seizures at age 12 (genetic anticipation)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Huntington CAG, Fragile X CGG, Friedreich GAA, Myotonic Dystrophy CTG) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Anticipation (or Genetic Anticipation). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Myotonic Dystrophy: A 32-year-old male presents with difficulty releasing his grip after shaking hands, bilateral early-onset cataracts, frontal balding, and testicular atrophy. His mother had mild cataracts in her late 50s, while his newborn daughter is born with severe hypotonia, respiratory distress, and clubfoot. Genetic testing reveals an expansion of a CTG trinucleotide repeat in the 3' UTR of the *DMPK* gene. What is the diagnosis, and what explains the progressive worsening across the three generations?
   - Inability to release grip (myotonia) + Cataracts + Toupee + Gonadal atrophy + CTG repeat in 3' UTR of *DMPK* $\implies$ **Myotonic Dystrophy Type 1**;
   - Progressive worsening across generations $\implies$ **Genetic Anticipation**;
   - What is the diagnosis and mechanism? (**Myotonic Dystrophy Type 1** exhibiting **Genetic Anticipation** due to trinucleotide repeat expansion).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "trinucleotide_repeat_disorders_and_genetic_anticipation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Trinucleotide Repeat Expansion Disorders (Robert L. Nussbaum)**\n• **Trinucleotide Repeat Master Classification Table:**\n$$\\begin{array}{|l|c|l|l|}\n\\hline\n\\textbf{Disorder} & \\textbf{Repeat Motif} & \\textbf{Gene / Chr Location} & \\textbf{Molecular Mechanism \\& Clinical Manifestations} \\\\\n\\hline\n\\mathbf{\\text{Huntington Disease}} & \\mathbf{(\\text{CAG})_n} & \\mathbf{\\text{HTT / Chr 4p}} & \\mathbf{\\text{Coding polyglutamine tract } \\to \\text{ Caudate atrophy, Chorea, Dementia}} \\\\\n\\mathbf{\\text{Fragile X Syndrome}} & \\mathbf{(\\text{CGG})_n} & \\mathbf{\\text{FMR1 / Chr Xq}} & \\mathbf{\\text{5' UTR hypermethylation silencing } \\to \\text{ Macroorchidism, Long face}} \\\\\n\\mathbf{\\text{Friedreich Ataxia}} & \\mathbf{(\\text{GAA})_n} & \\mathbf{\\text{FXN / Chr 9q}} & \\mathbf{\\text{Intronic frataxin loss } \\to \\text{ Spinocerebellar ataxia, Cardiomyopathy}} \\\\\n\\mathbf{\\text{Myotonic Dystrophy}} & \\mathbf{(\\text{CTG})_n} & \\mathbf{\\text{DMPK / Chr 19q}} & \\mathbf{\\text{3' UTR toxic RNA splicing } \\to \\text{ Myotonia, Cataracts, Toupee, Gonadal atrophy}} \\\\\n\\hline\n\\end{array}$$\n• **The Genetic Anticipation Invariant:** Dynamic trinucleotide repeats are unstable during gametogenesis; replication slippage causes **progressive expansion of repeat copy numbers in successive generations**, resulting in **earlier age of onset and greater clinical severity**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential multi-generational genetic events demonstrating Genetic Anticipation in a family with Huntington Disease.",
      "orderItems": [
        "Asymptomatic grandfather carries an intermediate premutation allele of 32 CAG repeats in the HTT gene",
        "Replication slippage during paternal spermatogenesis expands the repeat tract to a pathogenic 44 CAG repeats",
        "Father inherits 44 repeats and develops adult-onset choreic movements and executive dementia at age 48",
        "During the father's meiotic gametogenesis, further dramatic dynamic expansion yields a 72 CAG repeat allele",
        "His child inherits the 72 CAG repeat allele and presents with severe juvenile Huntington disease at age 12"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Trinucleotide Repeat Disorder to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Huntington Disease (CAG)", "right": "Autosomal dominant coding polyglutamine expansion on chromosome 4p causing caudate atrophy and chorea" },
        { "left": "Fragile X Syndrome (CGG)", "right": "X-linked 5' UTR promoter hypermethylation silencing FMR1 causing intellectual disability and macroorchidism" },
        { "left": "Friedreich Ataxia (GAA)", "right": "Autosomal recessive intronic expansion on chromosome 9q causing mitochondrial iron toxicity and ataxia" },
        { "left": "Myotonic Dystrophy (CTG)", "right": "Autosomal dominant 3' UTR toxic RNA expansion on chromosome 19q causing myotonia and early cataracts" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The common genetic phenomenon whereby an inherited disorder manifests with progressively earlier age of onset and increased clinical severity in successive generations is termed genetic ___.",
      "blankAnswer": "anticipation",
      "blankDistractors": ["penetrance", "expressivity", "pleiotropy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 32-year-old man presents with inability to rapidly release his grip after shaking hands (myotonia), bilateral cataracts, frontal balding, and testicular atrophy. His mother had mild cataracts in her late 50s, while his newborn daughter has severe congenital hypotonia and clubfoot. DNA testing shows a CTG repeat expansion in the 3' UTR of the DMPK gene. What is the diagnosis and the mechanism explaining the worsening across generations?",
      "options": [
        { "text": "Myotonic Dystrophy Type 1 (DM1) displaying Genetic Anticipation due to expanding trinucleotide repeats (CTG repeat in DMPK 3' UTR expands across generations)", "isCorrect": true, "explanation": "Correct! Let's analyze the molecular genetics and clinical features of Myotonic Dystrophy (Robert L. Nussbaum *Thompson & Thompson Genetics in Medicine* Chapter 7; Bruce Alberts *Molecular Biology of the Cell* Chapter 8). 1. **Clinical Spectrum of Myotonic Dystrophy Type 1 (DM1):** - Autosomal dominant multisystem disorder characterized by **Myotonia** (delayed relaxation of skeletal muscle after voluntary contraction, such as difficulty releasing a doorknob or handshake). - Associated features: **Early-onset cataracts, Frontal balding (Toupee), Gonadal atrophy / primary hypogonadism, Cardiac conduction abnormalities**, and insulin resistance. 2. **Molecular Pathophysiology:** - Caused by an unstable expansion of a **$(\\text{CTG})_n$ trinucleotide repeat** located in the **3' untranslated region (3' UTR)** of the **DMPK gene** (Dystrophia Myotonica Protein Kinase) on chromosome 19q13. - Transcribed mutant mRNA containing expanded CUG repeats forms toxic hairpin foci in the nucleus, sequestering **MBNL1 splicing regulators** and driving aberrant alternative splicing of downstream transcripts (e.g. ClC-1 chloride channels causing myotonia, insulin receptor causing resistance). 3. **Genetic Anticipation:** - The CTG repeat tract is highly unstable during maternal and paternal transmission. - As the repeat number expands from normal ($< 37$) to mild ($50-100$ in the grandmother) to classic ($100-1000$ in the patient) to congenital ($> 1000$ in the daughter), the disease manifests with progressively **earlier onset and catastrophic severity (Genetic Anticipation)**! Flawless dynamic mutation and anticipation derivation!" },
        { "text": "Huntington Disease exhibiting genomic imprinting with paternal deletion", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Fragile X Syndrome displaying complete penetrance with CGG repeats", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Friedreich Ataxia displaying incomplete dominance with GAA repeats", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
