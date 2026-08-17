# Duofy Reusable Lesson Format: QTL Mapping and Genome-Wide Association Studies (GWAS)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Population_and_Quantitative_Genetics`  
**Lesson Format Type:** `qtl_mapping_and_genome_wide_association_studies_gwas`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid quantitative, bioinformatic, and statistical mastery of complex polygenic trait dissection (Eric Lander & David Botstein 1989; Peter Visscher 2008): contrast **Quantitative Trait Locus (QTL) Mapping** (biparental $F_2$ crosses, recombinant inbred lines, interval mapping, logarithm of odds [**LOD Score $\ge 3.0$** threshold]) with **Genome-Wide Association Studies (GWAS)** (large cohorts of unrelated individuals, millions of dense Single Nucleotide Polymorphism [SNP] microarrays/WGS, linkage disequilibrium $r^2$), interpret **Manhattan Plots ($-\log_{10}(p\text{-value})$ vs genomic chromosomal coordinates, standard significance threshold $\mathbf{p < 5 \times 10^{-8}}$** via Bonferroni correction for $10^6$ independent tests), evaluate **Quantile-Quantile (QQ) Plots and Genomic Inflation ($\lambda_{\text{GC}}$)** to control for population stratification, and interact with live GWAS Manhattan plot engines.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | QTL Mapping vs GWAS Architectures Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Quantitative Genomic Tool / Metric & Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | GWAS Genome-Wide Statistical Significance Threshold Bonferroni Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | QTL Mapping Statistical Score Acronym Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive GWAS Manhattan Plot & SNP Association Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "qtl_mapping_and_genome_wide_association_studies_gwas",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do QTL Mapping and Genome-Wide Association Studies (GWAS) identify genetic loci underlying complex polygenic traits?",
      "blankAnswer": "Dissecting the genetic architecture of continuous, polygenic traits (e.g. human height, diabetes, crop yield) relies on two complementary approaches: (1) QTL MAPPING (Quantitative Trait Loci; Lander & Botstein, 1989): Uses controlled experimental crosses between inbred parental strains differing in a phenotype (e.g. F2 or Recombinant Inbred Lines). Tracks co-segregation of genetic markers with phenotype values using Interval Mapping. Evaluated via the Logarithm of Odds (LOD) score: LOD = log10 [ L(QTL present at position x) / L(no QTL) ]. A LOD score >= 3.0 (1,000-to-1 odds in favor of linkage) is the standard significance threshold. Has high statistical power but coarse genomic resolution (~10-20 cM; hundreds of genes). (2) GWAS (Genome-Wide Association Studies; Visscher, 2008): Uses hundreds of thousands of UNRELATED natural individuals genotyped at millions of dense Single Nucleotide Polymorphisms (SNPs). Exploits historical Linkage Disequilibrium (LD) accumulated over thousands of generations. Visualized using a MANHATTAN PLOT (-log10(p) vs genomic coordinates). Stringent Bonferroni-corrected significance threshold is p < 5 x 10⁻⁸ (-log10 p ~ 7.3) to prevent false positives across 10⁶ tests. QQ plots and genomic inflation factor lambda_GC ensure population stratification is controlled!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each quantitative genomics tool or statistic to its precise function.",
      "matchPairs": [
        { "left": "Manhattan Plot", "right": "Scatter plot displaying -log10(p-value) of SNP associations across chromosomes, highlighting significant 'skyscrapers'" },
        { "left": "LOD Score (Logarithm of Odds)", "right": "Statistical metric in QTL linkage mapping comparing likelihood of linkage vs independent assortment (threshold >= 3.0)" },
        { "left": "Quantile-Quantile (QQ) Plot", "right": "Compares observed vs expected p-value distributions to detect confounding population stratification or true polygenicity" },
        { "left": "Linkage Disequilibrium (LD, r²)", "right": "Non-random association of alleles at different loci across a population used to tag causal variants in GWAS" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the standard statistical significance threshold in modern human Genome-Wide Association Studies (GWAS) set to the extraordinarily stringent value of p < 5 × 10⁻⁸?",
      "options": [
        { "text": "It applies a rigorous BONFERRONI MULTIPLE-TESTING CORRECTION (alpha = 0.05 / 1,000,000 independent genomic tests ≈ 5 x 10⁻⁸) to control the family-wise false positive error rate when testing ~1 million tag SNPs simultaneously across the entire genome", "isCorrect": true, "explanation": "Correct! In GWAS, an association test is run for every single SNP across the entire genome (typically 1 to 2 million tag SNPs). If a standard p-value of 0.05 were used, testing 1,000,000 SNPs would produce 50,000 false-positive associations by pure chance. To maintain a global false positive rate of alpha = 0.05, the Bonferroni correction divides 0.05 by approximately 1,000,000 independent haplotype blocks, establishing the universal genome-wide significance threshold of p < 5 x 10⁻⁸ (-log10 p > 7.3)." },
        { "text": "Because DNA polymerases fail if p-values are above 0.001", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because human height has only one single gene", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because computers cannot store numbers larger than 10⁻⁸", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In QTL linkage analysis, the statistical test statistic representing the base-10 logarithm of the odds ratio for linkage is the ___ score.",
      "blankAnswer": "lod",
      "blankDistractors": ["z", "t", "f"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive GWAS Manhattan Plot Analyzer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>GWAS Manhattan Plot & Association Engine</h3><p>Cohort: $N = 100,000$ Patients | Trait: Type 2 Diabetes</p><button id=\"gwasBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Scan 1,000,000 SNPs Across Chromosomes</button><div id=\"gwasOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('gwasBtn').onclick=()=>{document.getElementById('gwasOut').innerText='GWAS Results: (1) Chromosome 11p15 (TCF7L2 locus) -> Peak -log10(p) = 28.4 (p = 4.0 x 10⁻²⁹, massive genome-wide significance!). (2) Chromosome 6p21 (HLA region) -> Peak -log10(p) = 14.1. (3) QQ plot shows lambda_GC = 1.02 (zero population stratification bias). Robust causal loci confirmed!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
