# Duofy Reusable Lesson Format: Genetic Drift, Effective Population Size, and the Coalescent

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Population_and_Quantitative_Genetics`  
**Lesson Format Type:** `genetic_drift_effective_population_size_and_coalescent`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the stochastic population dynamics of random genetic drift, demographic modeling, and coalescent genealogies (Sewall Wright & R.A. Fisher; John Kingman 1982): calculate the sampling variance of allele frequency shifts ($\sigma_{\Delta p}^2 = \frac{p(1-p)}{2N_e}$), compute **Effective Population Size ($N_e$)** under sex ratio distortions ($N_e = \frac{4N_m N_f}{N_m + N_f}$) and generational population bottlenecks using the **Harmonic Mean ($\frac{1}{N_e} = \frac{1}{t}\sum \frac{1}{N_i}$)**, master **Kingman's Coalescent Theory** tracing genealogical lineages backward in time (pairwise coalescent rate $\frac{1}{2N_e}$, expected Time to Most Recent Common Ancestor [TMRCA] for 2 lineages $= 2N_e$ generations), and evaluate genetic diversity loss ($\Delta H = -\frac{1}{2N_e}H$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Genetic Drift, $N_e$, & Coalescent Theory Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Unequal Sex Ratio $N_e$ Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Population Parameter & Demographic Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Mean Formula Used to Calculate Ne Across Fluctuating Generations Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Extreme Harem Sex Ratio Effective Population Size Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Genetic Drift, $N_e$, and Kingman's Coalescent:
   - **Genetic Drift (Wright-Fisher Model):**
     - Random binomial sampling of gametes in finite populations causes stochastic fluctuations in allele frequencies.
     - Per-generation variance: $\sigma_{\Delta p}^2 = \frac{p(1-p)}{2 N_e}$.
     - Loss of heterozygosity per generation: $H_{t+1} = H_t \left(1 - \frac{1}{2N_e}\right)$.
   - **Effective Population Size ($N_e$):**
     - Size of an idealized panmictic population that loses heterozygosity at the same rate as the actual population ($N$).
     - **Unequal Sex Ratio ($N_m$ breeding males, $N_f$ breeding females):**
       $$\mathbf{N_e = \frac{4 N_m N_f}{N_m + N_f}}$$
     - **Fluctuating Population Size Across Generations (Harmonic Mean):**
       $$\mathbf{\frac{1}{N_e} = \frac{1}{t} \sum_{i=1}^t \frac{1}{N_i}} \implies N_e \text{ is heavily skewed toward the smallest bottleneck generation!}$$
   - **Kingman's Coalescent (John Kingman, 1982):**
     - Models genealogies backward in time. In a sample of $k$ lineages, the probability that any two coalesce in the previous generation is $\binom{k}{2} / (2N_e)$.
     - **Expected TMRCA for 2 alleles:** $2 N_e\text{ generations}$.
     - **Expected TMRCA for sample of $n$ alleles:** $4 N_e \left(1 - \frac{1}{n}\right)\text{ generations}$.
2. **Slide 2 (`ordering`):** Provide 5 steps calculating $N_e$ for a breeding population with 5 breeding males and 95 breeding females (total census $N = 100$): (1) identify the number of breeding males ($N_m = 5$) and breeding females ($N_f = 95$), (2) multiply $4 \times N_m \times N_f = 4 \times 5 \times 95 = 1,900$, (3) sum the number of breeding adults: $N_m + N_f = 5 + 95 = 100$, (4) divide the product by the sum: $N_e = 1,900 / 100 = 19$, (5) recognize that despite a total census size of 100 animals, the effective population size is only 19, meaning the population experiences severe genetic drift equivalent to an idealized herd of just 19 individuals!
3. **Slide 3 (`matching`):** Pair 4 demographic parameters ($N_e$ Sex Ratio formula, $N_e$ Harmonic Mean formula, Pairwise Coalescence rate, Heterozygosity Decay $\Delta H$) with their mathematical expressions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that effective population size across generations of fluctuating census size is determined by the harmonic mean. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on bottleneck and sex ratio effects on $N_e$: An elephant seal population on an island consists of 2 dominant harem master bulls ($N_m = 2$) that monopolize mating with all 198 adult females ($N_f = 198$), for a total census size of $N = 200$. What is the effective population size ($N_e$) of this population? ($N_e = \frac{4 \times 2 \times 198}{2 + 198} = \frac{1,584}{200} = \mathbf{7.92 \approx 8\text{ individuals}}$; because $N_e$ is severely constrained by the bottlenecked sex, genetic drift will deplete genetic diversity as rapidly as if only 8 total animals existed).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "genetic_drift_effective_population_size_and_coalescent",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Genetic Drift, Effective Population Size, and the Coalescent**\n• **Wright-Fisher Drift & Heterozygosity Loss:**\n$$\n\\sigma_{\\Delta p}^2 = \\frac{p(1-p)}{2 N_e}, \\qquad H_{t} = H_0 \\left(1 - \\frac{1}{2 N_e}\\right)^t\n$$\n• **Effective Population Size ($N_e$):**\n  - **Unequal Sex Ratio ($N_m$ males, $N_f$ females):**\n$$\n\\mathbf{N_e = \\frac{4 N_m N_f}{N_m + N_f}}\n$$\n  - **Fluctuating Sizes (Harmonic Mean):** $\\frac{1}{N_e} = \\frac{1}{t}\\sum \\frac{1}{N_i}$ (dominated by smallest bottleneck!).\n• **Kingman's Coalescent (1982):**\n  - Tracing lineages backward: pairwise coalescence probability $= \\frac{1}{2N_e}$.\n  - **Expected Time to MRCA (2 lineages):** $\\mathbf{2 N_e\\text{ generations}}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the mathematical steps calculating effective population size for an unequal sex ratio (5 males, 95 females).",
      "orderItems": [
        "Identify the number of actively breeding males (N_m = 5) and breeding females (N_f = 95)",
        "Compute the numerator of Wright's formula by multiplying 4 * N_m * N_f = 4 * 5 * 95 = 1,900",
        "Compute the denominator by summing total breeding individuals: N_m + N_f = 5 + 95 = 100",
        "Divide the numerator by the denominator: N_e = 1,900 / 100 = 19",
        "Interpret the result: despite 100 total animals, genetic drift acts at the rate of an ideal population of only 19 individuals"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each population genetics concept to its exact mathematical representation.",
      "matchPairs": [
        { "left": "Effective Population Size (Sex Ratio)", "right": "N_e = (4 * N_m * N_f) / (N_m + N_f)" },
        { "left": "Effective Population Size (Harmonic Mean)", "right": "1 / N_e = (1 / t) * Sum[ 1 / N_i ] (dominated by smallest bottleneck year)" },
        { "left": "Kingman's Pairwise Coalescence Probability", "right": "P(coalesce) = 1 / (2 * N_e) per generation backward in time" },
        { "left": "Expected TMRCA for 2 Sampled Alleles", "right": "E[T_MRCA] = 2 * N_e generations" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When population census size fluctuates dramatically across successive generations, the long-term effective population size N_e is calculated using the ___ mean.",
      "blankAnswer": "harmonic",
      "blankDistractors": ["arithmetic", "geometric", "quadratic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In an elephant seal colony, 2 alpha bulls (N_m = 2) mate with all 198 females (N_f = 198) in the rookery (total adult census N = 200). What is the effective population size (N_e) of this colony?",
      "options": [
        { "text": "N_e = 7.92 (approximately 8 individuals); applying Wright's sex-ratio formula: N_e = (4 * 2 * 198) / (2 + 198) = 1,584 / 200 = 7.92. Genetic diversity will be lost via drift at the rate of an ideal population of only 8 animals", "isCorrect": true, "explanation": "Correct! When one sex is severely limited in number, that sex forms a tight genetic bottleneck for the entire population. Using Wright's formula: N_e = (4 * N_m * N_f) / (N_m + N_f) = (4 * 2 * 198) / (2 + 198) = 1,584 / 200 = 7.92. Even though there are 200 adult seals present, half of all nuclear genes in the next generation will originate from just 2 males, causing extreme genetic drift and rapid inbreeding equivalent to a total population of ~8 individuals." },
        { "text": "N_e = 200 (census size)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "N_e = 100 (arithmetic average)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "N_e = 50", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
