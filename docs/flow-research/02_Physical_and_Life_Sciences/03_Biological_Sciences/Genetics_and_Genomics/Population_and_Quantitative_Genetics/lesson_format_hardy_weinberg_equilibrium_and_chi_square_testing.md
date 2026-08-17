# Duofy Reusable Lesson Format: Hardy-Weinberg Equilibrium and Chi-Square Testing

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Population_and_Quantitative_Genetics`  
**Lesson Format Type:** `hardy_weinberg_equilibrium_and_chi_square_testing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical derivations, null hypothesis assumptions, and goodness-of-fit statistical validation of the Hardy-Weinberg Principle (Godfrey Hardy & Wilhelm Weinberg, 1908; Karl Pearson): derive allele frequencies ($p = f(AA) + \frac{1}{2}f(Aa)$, $q = f(aa) + \frac{1}{2}f(Aa)$), formulate the binomial genotype expansion ($p^2 + 2pq + q^2 = 1$), calculate expected genotype counts in sample cohorts, execute the **Chi-Square Goodness-of-Fit Test ($\chi^2 = \sum \frac{(O-E)^2}{E}$)**, master why testing a bi-allelic locus has **exactly 1 degree of freedom ($df = k - 1 - m = 3 - 1 - 1 = 1$)**, and evaluate evolutionary causes for HWE departure (assortative mating, natural selection, Wahlund effect).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hardy-Weinberg Law & Statistical Chi-Square Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step HWE Allele Frequency & Chi-Square Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Population Parameter & Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Degrees of Freedom for Bi-Allelic HWE Chi-Square Test Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Population Allele Frequency and Carrier Probability Calculation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hardy-Weinberg Principle & Chi-Square Goodness-of-Fit:
   - **The HWE Theorem (Hardy & Weinberg, 1908):**
     - In an infinitely large, randomly mating population free from mutation, migration, and natural selection, allele frequencies remain constant, and genotype frequencies stabilize in one generation to:
       $$p^2 + 2pq + q^2 = 1 \qquad (\text{where } p = f(A), q = f(a), p+q=1)$$
   - **Calculating Allele Frequencies from Sample Data ($N$ total individuals):**
     $$p = \frac{2 N_{AA} + N_{Aa}}{2 N}, \qquad q = \frac{2 N_{aa} + N_{Aa}}{2 N}$$
   - **Chi-Square ($\chi^2$) Goodness-of-Fit Test:**
     - Expected counts: $E_{AA} = p^2 N$, $E_{Aa} = 2pq N$, $E_{aa} = q^2 N$.
     - Test statistic:
       $$\chi^2 = \sum \frac{(O - E)^2}{E} = \frac{(N_{AA} - E_{AA})^2}{E_{AA}} + \frac{(N_{Aa} - E_{Aa})^2}{E_{Aa}} + \frac{(N_{aa} - E_{aa})^2}{E_{aa}}$$
     - **Degrees of Freedom ($df$):**
       $$df = \text{Number of Genotypic Classes } (k) - 1 - \text{Estimated Parameters } (m) = 3 - 1 - 1 = \mathbf{1\text{ degree of freedom}}!$$
     - *(Critical value for $\alpha = 0.05$ at $1\ df$ is $\mathbf{\chi_{\text{crit}}^2 = 3.841}$. If $\chi^2 > 3.841$, reject HWE!).*
2. **Slide 2 (`ordering`):** Provide 5 steps testing a natural population for Hardy-Weinberg Equilibrium: (1) count the observed numbers of individuals for all three genotypes ($N_{AA}, N_{Aa}, N_{aa}$) in a sample of size $N$, (2) directly calculate allele frequencies $p$ and $q$ by gene counting, (3) calculate expected genotype frequencies ($p^2, 2pq, q^2$) and multiply by $N$ to obtain expected counts ($E_{AA}, E_{Aa}, E_{aa}$), (4) compute the chi-square test statistic: $\chi^2 = \sum \frac{(O-E)^2}{E}$, (5) compare the calculated $\chi^2$ value against the critical value ($3.841$ at $df = 1, \alpha = 0.05$) to determine if the population deviates significantly from HWE!
3. **Slide 3 (`matching`):** Pair 4 population genetics formulas ($p^2 + 2pq + q^2 = 1$, $p = (2N_{AA} + N_{Aa})/(2N)$, $\chi^2 = \sum(O-E)^2/E$, $df = k - 1 - m = 1$) with their statistical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the number of degrees of freedom for a Chi-square test of Hardy-Weinberg equilibrium at a two-allele locus is exactly 1. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on human population genetics problem: In a human population in Hardy-Weinberg equilibrium, cystic fibrosis (an autosomal recessive condition) affects $1$ in $2,500$ newborns ($q^2 = 1/2,500 = 0.0004$). What is the carrier frequency (heterozygote frequency $2pq$) in this population? ($q = \sqrt{0.0004} = 0.02$. $p = 1 - 0.02 = 0.98$. Heterozygote frequency $2pq = 2 \times 0.98 \times 0.02 = 0.0392 \approx \mathbf{1\text{ in } 25.5\text{ (or } 3.92\%\text{)}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hardy_weinberg_equilibrium_and_chi_square_testing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hardy-Weinberg Equilibrium and Chi-Square Testing (1908)**\n• **The HWE Null Model:**\n  - Under random mating without selection, drift, mutation, or migration:\n$$\n\\mathbf{p^2 + 2pq + q^2 = 1} \\qquad (p = f(A), \\ q = f(a), \\ p + q = 1)\n$$\n• **Allele Frequencies by Gene Counting:**\n$$\np = \\frac{2 N_{AA} + N_{Aa}}{2 N}, \\qquad q = \\frac{2 N_{aa} + N_{Aa}}{2 N}\n$$\n• **Goodness-of-Fit $\\chi^2$ Test:**\n$$\n\\chi^2 = \\sum \\frac{(O - E)^2}{E}, \\qquad \\mathbf{df = 3 - 1 - 1 = 1\\text{ degree of freedom}}\n$$\n  - Critical value ($\\alpha = 0.05$): $\\mathbf{\\chi_{\\text{crit}}^2 = 3.841}$. If $\\chi^2 > 3.841$, reject HWE!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the analytical steps for testing Hardy-Weinberg Equilibrium in a natural population.",
      "orderItems": [
        "Record the observed counts of homozygous dominant (N_AA), heterozygous (N_Aa), and homozygous recessive (N_aa) individuals",
        "Calculate the sample allele frequencies p and q directly by the gene counting method",
        "Compute the expected genotype numbers under HWE: E_AA = p² * N, E_Aa = 2pq * N, and E_aa = q² * N",
        "Calculate the Chi-Square test statistic across all three genotype classes: Chi² = Sum[(O - E)² / E]",
        "Evaluate the Chi-Square statistic against the critical value at df = 1 (critical threshold = 3.841 at alpha = 0.05)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each population genetics term to its exact mathematical formula.",
      "matchPairs": [
        { "left": "HWE Genotype Distribution", "right": "p² (AA) + 2pq (Aa) + q² (aa) = 1" },
        { "left": "Allele Frequency p (Gene Counting)", "right": "(2 * N_AA + N_Aa) / (2 * N)" },
        { "left": "Chi-Square Goodness-of-Fit Statistic", "right": "Sum[ (Observed - Expected)² / Expected ]" },
        { "left": "Degrees of Freedom for 2-Allele HWE", "right": "df = k - 1 - m = 3 - 1 - 1 = 1 (1 degree of freedom)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When testing a two-allele genetic locus for Hardy-Weinberg equilibrium using a Chi-square goodness-of-fit test, the number of degrees of freedom is exactly ___.",
      "blankAnswer": "1",
      "blankDistractors": ["2", "3", "0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a human population in Hardy-Weinberg equilibrium, the incidence of cystic fibrosis (an autosomal recessive condition, genotype aa) is 1 in 2,500 newborns (q² = 0.0004). What is the carrier frequency (heterozygote Aa frequency) in this population?",
      "options": [
        { "text": "3.92% (approximately 1 in 25.5 people); recessive allele frequency q = sqrt(0.0004) = 0.02. Dominant allele frequency p = 1 - 0.02 = 0.98. Carrier frequency 2pq = 2 * 0.98 * 0.02 = 0.0392", "isCorrect": true, "explanation": "Correct! First, determine the recessive allele frequency: q = sqrt(0.0004) = 0.02 (2%). Next, find the dominant allele frequency: p = 1 - q = 1 - 0.02 = 0.98 (98%). Finally, calculate the heterozygous carrier frequency: 2pq = 2 * 0.98 * 0.02 = 0.0392, or 3.92% (approximately 1 out of every 25.5 individuals in the population is an unaffected healthy carrier)." },
        { "text": "0.04%", "isCorrect": false, "explanation": "Incorrect: That is the disease frequency." },
        { "text": "2.00%", "isCorrect": false, "explanation": "Incorrect: That is the allele frequency q." },
        { "text": "50.0%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
