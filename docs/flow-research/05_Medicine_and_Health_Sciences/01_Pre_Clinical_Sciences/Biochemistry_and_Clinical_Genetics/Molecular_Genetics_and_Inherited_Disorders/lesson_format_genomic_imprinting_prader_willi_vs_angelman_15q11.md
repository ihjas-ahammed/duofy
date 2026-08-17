# Duofy Reusable Lesson Format: Epigenetic Genetics (Prader-Willi vs Angelman 15q11)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Biochemistry_and_Clinical_Genetics / Molecular_Genetics_and_Inherited_Disorders`  
**Lesson Format Type:** `genomic_imprinting_prader_willi_vs_angelman_15q11`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the epigenetic mechanisms and parent-of-origin inheritance of **Genomic Imprinting**, the differential methylation of parental alleles during gametogenesis resulting in monoallelic gene expression, the 15q11.2-q13 critical chromosomal region, the definitive contrast between **Prader-Willi Syndrome (PWS)** and **Angelman Syndrome (AS)**, the three molecular etiologies for each syndrome (1: microdeletion of the active parental allele $\approx 70\%$, 2: Uniparental Disomy UPD $\approx 25\%$, 3: imprinting center defect or point mutation $\approx 5\%$), **Prader-Willi Syndrome** (loss of active **Paternal** alleles on 15q11-q13 due to paternal 15q microdeletion or **Maternal Uniparental Disomy [Maternal UPD: 2 maternal copies, 0 paternal copies]** $\implies$ neonatal hypotonia and poor feeding, followed by insatiable hyperphagia, morbid obesity, short stature, hypogonadism, small hands/feet, and intellectual disability), **Angelman Syndrome** (loss of active **Maternal** *UBE3A* ubiquitin ligase on 15q11-q13 due to maternal 15q microdeletion, **Paternal UPD [2 paternal copies, 0 maternal copies]**, or *UBE3A* loss-of-function mutation $\implies$ inappropriate paroxysms of laughter [*"Happy Puppet"*], profound intellectual disability, severe ataxia, epilepsy/seizures, and microcephaly), and molecular diagnostic testing using methylation-specific PCR (Robert L. Nussbaum et al. *Thompson & Thompson Genetics in Medicine* 8th ed. Chapter 7; Bruce Alberts et al. *Molecular Biology of the Cell* 7th ed.): formulate the **15q11-q13 Genomic Imprinting Master Matrix**:
$$\begin{array}{|l|l|l|l|l|}
\hline
\textbf{Clinical Syndrome} & \textbf{Parental Active Loss} & \textbf{Primary Genetic Cause (70\%)} & \textbf{Uniparental Disomy Cause (25\%)} & \textbf{Hallmark Phenotype} \\
\hline
\mathbf{\text{Prader-Willi (PWS)}} & \mathbf{\text{PATERNAL Active Allele}} & \mathbf{\text{Paternal 15q11-q13 Microdeletion}} & \mathbf{\text{Maternal UPD (2 Maternal Chr 15)}} & \mathbf{\text{Neonatal hypotonia } \to \text{ Hyperphagia, Obesity, Hypogonadism}} \\
\mathbf{\text{Angelman (AS)}} & \mathbf{\text{MATERNAL Active UBE3A}} & \mathbf{\text{Maternal 15q11-q13 Microdeletion}} & \mathbf{\text{Paternal UPD (2 Paternal Chr 15)}} & \mathbf{\text{Inappropriate laughter (\"Happy Puppet\"), Ataxia, Seizures}} \\
\hline
\end{array}$$
master the **Imprinting Parent-of-Origin Mnemonic**:
$$\mathbf{\mathbf{P}\text{rader-Willi } \implies \mathbf{P}\text{aternal gene deleted (or Maternal UPD)} \quad \Big| \quad \mathbf{M}\text{other's gene deleted (or Paternal UPD) } \implies \text{Angel}\mathbf{M}\text{an Syndrome}}$$
(proving that although the underlying DNA sequence at 15q11-q13 is identical, the epigenetic methylation mark placed during male vs female gametogenesis dictates which gene products are expressed, resulting in completely different clinical phenotypes when either parental chromosome is lost).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Genomic Imprinting Principles, 15q11-q13 Architecture, PWS vs AS Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Methylation Analysis and Determine UPD vs Microdeletion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Genomic Imprinting Disorder / Molecular Lesion & Technical Diagnostic Finding Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Neurodevelopmental Disorder Caused by Loss of Maternal Expression of the $UBE3A$ Gene on Chromosome 15q11-q13 Leading to Inappropriate Laughter, Severe Ataxia, and Seizures Is ___ Syndrome (Angelman / Angelman Syndrome) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Genetics & Pediatrics Problem: Differentiating Maternal Uniparental Disomy from Paternal Deletion in Prader-Willi Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State 15q11-q13 Genomic Imprinting & Disease Mechanisms (Nussbaum 2016; Alberts 2022):
   - **Imprinting Duality Formulations:**
     $$\mathbf{\text{PWS: Loss of Paternal 15q11-q13 (Paternal Deletion OR Maternal UPD)} \implies \text{Hyperphagia, Obesity, Hypogonadism}}$$
     $$\mathbf{\text{AS: Loss of Maternal 15q11-q13 UBE3A (Maternal Deletion OR Paternal UPD)} \implies \text{Inappropriate Laughter, Ataxia, Seizures}}$$
   - **The Methylation Invariant:**
     - Maternal chromosome 15 is normally methylated (silenced) at the PWS locus;
     - Paternal chromosome 15 is normally methylated (silenced) at the *UBE3A* locus;
     - Loss of the single active paternal copy produces PWS; loss of the single active maternal copy produces Angelman!
2. **Slide 2 (`ordering`):** Provide 5 steps of the molecular genetic evaluation of an infant with severe hypotonia suspected of Prader-Willi Syndrome: (1) infant presents with severe neonatal hypotonia, weak cry, and poor suckling requiring tube feeding, (2) peripheral blood sample is collected for initial Methylation-Specific PCR (MS-PCR) analysis at the SNRPN locus, (3) MS-PCR reveals only maternally methylated alleles with complete absence of the unmethylated paternal allele, confirming an imprinting defect, (4) chromosomal microarray or FISH testing is performed to determine if a 15q11.2-q13 paternal microdeletion is present (70% of cases), (5) if no microdeletion is detected, microsatellite marker analysis confirms Maternal Uniparental Disomy (Maternal UPD: two maternal copies of chromosome 15)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Prader-Willi Syndrome, Angelman Syndrome, Maternal Uniparental Disomy, Paternal Uniparental Disomy) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Angelman (or Angelman Syndrome). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Prader-Willi genetics: A 4-year-old boy presents with severe hyperphagia, morbid obesity, short stature, small hands and feet, and mild intellectual disability. High-resolution chromosomal microarray shows normal diploid chromosome 15 copy number with NO microdeletions. However, methylation-specific PCR demonstrates a 100% maternal methylation pattern across the 15q11-q13 region, with zero paternal expression. What is the molecular mechanism of Prader-Willi syndrome in this patient?
   - Normal chromosome 15 copy number (no deletion) + 100% maternal methylation (zero paternal contribution) $\implies$ **Maternal Uniparental Disomy (Maternal UPD)**;
   - Child inherited two copies of maternal chromosome 15 and zero copies of paternal chromosome 15;
   - What is the mechanism? (**Maternal Uniparental Disomy (Maternal UPD)** for chromosome 15).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "genomic_imprinting_prader_willi_vs_angelman_15q11",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Genomic Imprinting \\& 15q11-q13 Syndromes (Robert L. Nussbaum)**\n• **Chromosome 15q11.2-q13 Imprinting Dual System:**\n$$\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Clinical Syndrome} & \\textbf{Active Gene Lost} & \\textbf{Molecular Mechanism} & \\textbf{Hallmark Clinical Features} \\\\\n\\hline\n\\mathbf{\\text{Prader-Willi (PWS)}} & \\mathbf{\\text{Paternal 15q11-q13 (SNRPN/snoRNAs)}} & \\mathbf{\\begin{cases} \\text{Paternal Deletion (70\\%)} \\\\ \\text{Maternal UPD (25\\%)} \\end{cases}} & \\mathbf{\\text{Neonatal hypotonia } \\to \\text{ Hyperphagia, Obesity, Hypogonadism}} \\\\\n\\mathbf{\\text{Angelman (AS)}} & \\mathbf{\\text{Maternal 15q11-q13 (UBE3A)}} & \\mathbf{\\begin{cases} \\text{Maternal Deletion (70\\%)} \\\\ \\text{Paternal UPD (5\\%)} \\\\ \\text{UBE3A Mutation (10\\%)} \\end{cases}} & \\mathbf{\\text{Inappropriate laughter (\"Happy Puppet\"), Ataxia, Seizures}} \\\\\n\\hline\n\\end{array}$$\n• **The Epigenetic Imprinting Invariant:** In normal individuals, maternal PWS genes are silenced (methylated) while maternal *UBE3A* is active; loss of the single **active paternal allele causes Prader-Willi**, whereas loss of the single **active maternal allele causes Angelman**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential diagnostic steps to evaluate an infant with severe hypotonia for Prader-Willi Syndrome and establish the exact molecular etiology.",
      "orderItems": [
        "Neonate presents with severe generalized hypotonia, poor suckling, and feeding difficulties",
        "Perform Methylation-Specific PCR (MS-PCR) at the 15q11.2 SNRPN locus on peripheral blood DNA",
        "Demonstrate complete absence of the unmethylated paternal allele, confirming an imprinting diagnostic abnormality",
        "Perform chromosomal microarray (CMA) or FISH to test for a 15q11-q13 paternal microdeletion",
        "If CMA is normal (no deletion), perform polymorphic microsatellite marker analysis to confirm Maternal Uniparental Disomy"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Imprinting Mechanism to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Prader-Willi (Paternal Deletion)", "right": "70% of PWS cases resulting from de novo deletion of the unmethylated active paternal 15q11-q13 region" },
        { "left": "Prader-Willi (Maternal UPD)", "right": "25% of PWS cases where the child inherits two copies of maternal chromosome 15 and zero paternal copies" },
        { "left": "Angelman Syndrome (AS)", "right": "Loss of active maternal UBE3A expression resulting in paroxysms of laughter, severe ataxia, and seizures" },
        { "left": "Methylation-Specific PCR", "right": "Primary diagnostic gold standard distinguishing methylated maternal alleles from unmethylated paternal alleles" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The neurodevelopmental disorder caused by loss of maternal expression of the UBE3A gene on chromosome 15q11-q13 leading to inappropriate laughter, severe ataxia, and seizures is ___ syndrome.",
      "blankAnswer": "Angelman",
      "blankDistractors": ["Prader-Willi", "Rett", "Fragile X"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 4-year-old child presents with insatiable hyperphagia, rapid morbid obesity, short stature, and small hands and feet. Chromosomal microarray analysis shows two intact copies of chromosome 15 with NO microdeletions. However, methylation testing reveals a 100% maternal methylation pattern with total absence of paternal expression at 15q11-q13. What is the exact genetic mechanism of Prader-Willi syndrome in this patient?",
      "options": [
        { "text": "Maternal Uniparental Disomy (Maternal UPD: inheritance of two maternal copies of chromosome 15 and zero paternal copies)", "isCorrect": true, "explanation": "Correct! Let's analyze the molecular genetics and diagnostic testing of Prader-Willi Syndrome (Robert L. Nussbaum *Thompson & Thompson Genetics in Medicine* Chapter 7; Bruce Alberts *Molecular Biology of the Cell* Chapter 8). 1. **Genomic Imprinting on 15q11-q13:** - Under normal physiological conditions, the maternal copy of the 15q11-q13 PWS critical region is **epigenetically silenced (methylated)**, while the paternal copy is **unmethylated and transcriptionally active**. 2. **Evaluation of the Diagnostic Data:** - The patient exhibits the classic clinical phenotype of **Prader-Willi Syndrome** (neonatal hypotonia progressing to insatiable appetite / hyperphagia, obesity, hypogonadism, short stature, small hands/feet). - **Chromosomal Microarray:** Shows normal diploid copy number (2 copies of chromosome 15), ruling out a 15q11-q13 microdeletion (which accounts for $\\sim 70\\%$ of cases). - **Methylation-Specific PCR:** Shows $100\\%$ maternal methylation and $0\\%$ paternal unmethylated alleles. 3. **Conclusion (Maternal UPD):** - Because the child has two intact copies of chromosome 15 and both carry the maternal methylation mark, the child inherited **both copies of chromosome 15 from the mother and zero copies from the father**. - This represents **Maternal Uniparental Disomy (Maternal UPD)**, which accounts for $\\sim 25\\%$ of all Prader-Willi syndrome cases! Flawless genomic imprinting and uniparental disomy derivation!" },
        { "text": "Paternal microdeletion of chromosome 15q11-q13", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Paternal Uniparental Disomy (Paternal UPD produces Angelman syndrome, not Prader-Willi)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Loss-of-function mutation in the maternal UBE3A ubiquitin ligase gene", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
