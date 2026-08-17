# Duofy Reusable Lesson Format: Minimum Viable Population and the 50/500 Rule

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Ecosystem_Dynamics_and_Conservation / Conservation_Biology_and_Biodiversity`  
**Lesson Format Type:** `minimum_viable_population_and_the_50_500_rule`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantitative conservation genetics, stochastic extinction risks, and population viability analysis (PVA) of endangered species (Mark L. Shaffer 1981; Ian R. Franklin 1980; Michael E. Soulé 1980): define **Minimum Viable Population (MVP)** (the smallest isolated population size having a $99\%$ probability of persisting for $1000\text{ years}$ despite demographic, environmental, and genetic stochasticity), formulate **Effective Population Size ($N_e = \frac{4 N_m N_f}{N_m + N_f}$)** accounting for unequal sex ratios and reproductive variance, master the foundational **50/500 Rule of Conservation Genetics** (**$N_e \ge 50$** to prevent lethal short-term inbreeding depression; **$N_e \ge 500$** to maintain long-term additive genetic variance against random genetic drift), and deconstruct the positive feedback mechanics of the **Extinction Vortex**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | MVP, Effective Population Size Ne, & 50/500 Rule Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Extinction Vortex Feedback Loop Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Conservation Genetics Parameter / Concept & Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Short-Term Inbreeding Threshold Effective Population Size Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Impact of Extreme Sex Ratio Skew on Effective Population Size Ne Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Minimum Viable Population & The 50/500 Rule (Franklin 1980; Soulé 1980; Shaffer 1981):
   - **Minimum Viable Population (MVP - Shaffer 1981):**
     - Smallest isolated wild population size that has a $>99\%$ probability of surviving for $\ge 1000\text{ years}$ without succumbing to:
       1. **Demographic Stochasticity** (random fluctuations in birth/death rates).
       2. **Environmental Stochasticity & Natural Catastrophes** (floods, fires, disease).
       3. **Genetic Stochasticity** (inbreeding depression and genetic drift).
   - **Effective Population Size ($N_e$):**
     $$\mathbf{N_e = \frac{4 N_m N_f}{N_m + N_f} \qquad (\text{where } N_m = \text{breeding males}, N_f = \text{breeding females})}$$
     - Typically, $N_e / N_{\text{census}} \approx 0.10 - 0.20$ in wild animal populations!
   - **The 50/500 Rule of Conservation Genetics:**
     - **$N_e \ge 50$ (Short-Term Threshold):** Limits rate of inbreeding to $\Delta F = \frac{1}{2N_e} \le 1\%$ per generation, preventing catastrophic expression of deleterious recessive alleles and inbreeding depression.
     - **$N_e \ge 500$ (Long-Term Evolutionary Threshold):** Balances loss of quantitative genetic variance from genetic drift ($V_d = V_g / 2N_e$) with the generation of new adaptive mutations ($V_m$).
2. **Slide 2 (`ordering`):** Provide 5 steps of the Extinction Vortex feedback cascade: (1) habitat destruction and poaching reduce a healthy wild population down to a critically small census size, (2) severe mate scarcity forces inbreeding and accelerates random loss of alleles through genetic drift, (3) elevated homozygosity leads to inbreeding depression, manifesting as reduced fertility, infant deformities, and immune collapse, (4) individual mortality increases and recruitment plummets, causing the population to shrink even further, (5) the tiny, genetically impoverished population is wiped out by a single stochastic disease epidemic or drought (Extinction)!
3. **Slide 3 (`matching`):** Pair 4 conservation genetics terms (Effective Population Size Ne, Inbreeding Depression, 50/500 Rule, Population Viability Analysis PVA) with their scientific definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the minimum effective population size required to avoid immediate inbreeding depression in the 50/500 rule is 50. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $N_e$ under extreme sex ratio skew: A critically endangered herd of rhinos contains 100 individuals: 2 adult breeding males and 98 adult breeding females. What is the effective population size ($N_e$) of this herd, and why is this dangerous? ($N_e = \frac{4 \times 2 \times 98}{2 + 98} = \frac{784}{100} = \mathbf{7.84 \approx 8\text{ individuals}}$; despite a census count of 100 animals, **the genetic effective size is only ~8**, falling far below the $N_e \ge 50$ threshold and causing rapid, severe inbreeding depression).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "minimum_viable_population_and_the_50_500_rule",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: MVP & The 50/500 Genetics Rule (1980/1981)**\n• **Minimum Viable Population (MVP):** Smallest population size ensuring $>99\\%$ survival for $1000\\text{ years}$ against demographic, environmental, and genetic stochasticity.\n• **Effective Population Size ($N_e$):**\n$$\n\\mathbf{N_e = \\frac{4 N_m N_f}{N_m + N_f} \\qquad (N_e / N_{\\text{census}} \\approx 0.10\\text{--}0.20 \\text{ in nature})}\n$$\n• **The 50/500 Rule of Conservation Genetics (Franklin \\& Soulé):**\n  - **$\\mathbf{N_e \\ge 50}$ (Short-Term):** Keeps inbreeding rate $\\Delta F \\le 1\\%/\\text{gen}$, preventing **Inbreeding Depression**!\n  - **$\\mathbf{N_e \\ge 500}$ (Long-Term):** Balances **Genetic Drift loss** against **new adaptive mutations** ($V_m = V_d$)!\n• **The Extinction Vortex:** Small $N \\to$ Inbreeding $\\to$ Low Fitness $\\to$ Higher Mortality $\\to$ Smaller $N$ (Extinction)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of an endangered population entering the Extinction Vortex.",
      "orderItems": [
        "Anthropogenic habitat fragmentation reduces a wild population to a critically small, isolated census size",
        "Severe mate scarcity forces close inbreeding and accelerates random loss of alleles via genetic drift",
        "Elevated homozygosity unmasks deleterious recessive mutations, causing severe inbreeding depression and low fertility",
        "Higher juvenile mortality and reproductive failure cause the population to contract to even smaller numbers",
        "The genetically uniform, weakened population is completely wiped out by a single stochastic environmental disease outbreak"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each conservation genetics concept to its precise definition.",
      "matchPairs": [
        { "left": "Effective Population Size (Ne)", "right": "Number of ideally breeding individuals in a theoretical population undergoing the same rate of genetic drift" },
        { "left": "The 50 Rule (Ne >= 50)", "right": "Minimum genetic threshold required to prevent acute short-term inbreeding depression (delta F <= 1%)" },
        { "left": "The 500 Rule (Ne >= 500)", "right": "Long-term evolutionary threshold required to maintain adaptive genetic variance against genetic drift" },
        { "left": "Population Viability Analysis (PVA)", "right": "Stochastic demographic simulation modeling extinction probabilities over centuries to establish MVP" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under the foundational 50/500 rule of conservation genetics, the minimum effective population size Ne needed to avoid acute inbreeding depression is ___.",
      "blankAnswer": "50",
      "blankDistractors": ["500", "5", "1000"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A wildlife reserve contains a population of 100 wild ungulates consisting of 2 breeding males and 98 breeding females. What is the true genetic effective population size (Ne) of this herd?",
      "options": [
        { "text": "Ne ≈ 8 individuals; calculated as Ne = (4 * Nm * Nf) / (Nm + Nf) = (4 * 2 * 98) / 100 = 7.84, revealing that severe sex-ratio skew reduces the genetic breeding pool to less than 10 animals, placing the herd in extreme danger of inbreeding depression despite a census count of 100", "isCorrect": true, "explanation": "Correct! Effective population size (Ne) measures the rate at which genetic diversity is lost. When sex ratios are unequal, the rarer sex forms a severe genetic bottleneck because every offspring must receive 50% of its nuclear genome from one of the very few individuals of that sex. Using the classic formula Ne = (4 * Nm * Nf) / (Nm + Nf): here Nm = 2, Nf = 98, so Ne = (4 × 2 × 98) / (2 + 98) = 784 / 100 = 7.84 ≈ 8 individuals. Even though park rangers count 100 living animals in the field (census population Nc = 100), the herd loses genetic diversity at the exact same rate as an idealized herd of only 8 individuals (4 males and 4 females). Because Ne = 7.84 is far below the critical threshold of Ne ≥ 50, inbreeding will surge by over 6% per generation (delta F = 1/(2*Ne) = 1/15.68 ≈ 6.4%), rapidly leading to severe inbreeding depression, deformed offspring, and population collapse unless new breeding males are translocated into the reserve." },
        { "text": "Ne = 100 individuals because every animal can reproduce", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ne = 50 individuals because you take the average of 2 and 98", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ne = 0 individuals because females cannot pass on genes without 50 males", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
