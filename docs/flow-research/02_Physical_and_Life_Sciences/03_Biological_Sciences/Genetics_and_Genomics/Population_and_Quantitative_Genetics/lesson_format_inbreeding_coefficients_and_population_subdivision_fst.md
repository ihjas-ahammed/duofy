# Duofy Reusable Lesson Format: Inbreeding Coefficients and Population Subdivision (Fst)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Population_and_Quantitative_Genetics`  
**Lesson Format Type:** `inbreeding_coefficients_and_population_subdivision_fst`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantitative genetics and mathematical hierarchy of non-random mating and geographic population structure (Sewall Wright 1951, Gustave Malécot 1948): formulate the **Inbreeding Coefficient ($F$)** as the probability of two alleles being **Identical by Descent (IBD)** ($F = \frac{2pq - H_{\text{obs}}}{2pq}$), derive genotype frequencies under inbreeding ($p^2 + Fpq, 2pq(1-F), q^2 + Fpq$), master **Wright's Hierarchical $F$-Statistics ($F_{IS}, F_{IT}, F_{ST}$)** via the fundamental relationship:
$$(1 - F_{IT}) = (1 - F_{IS})(1 - F_{ST})$$
calculate **Wright's Fixation Index ($F_{ST} = \frac{\text{Var}(p)}{\bar{p}(1-\bar{p})} = \frac{H_T - \bar{H}_S}{H_T}$)** measuring genetic differentiation between subpopulations, analyze the **Wahlund Effect** (apparent deficit of heterozygotes caused by pooling subdivided populations), and calculate migration rates under the Island Model ($F_{ST} \approx \frac{1}{4 N_e m + 1}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Inbreeding $F$ & Wright's $F_{ST}$ Hierarchical Framework Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Two-Subpopulation $F_{ST}$ Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | $F$-Statistic Parameter / Genetic Phenomenon & Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Alleles Inherited from Common Ancestor Genetic Term Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Wright's FST and Gene Flow Migrant Number per Generation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Inbreeding Coefficients & Wright's $F$-Statistics:
   - **Inbreeding Coefficient ($F$, Malécot 1948):**
     - Probability that two homologous alleles in an individual are **Identical by Descent (IBD)** (inherited from a common ancestor).
     - Genotype Frequencies with Inbreeding $F$:
       $$f(AA) = p^2 + Fpq, \qquad f(Aa) = 2pq(1 - F), \qquad f(aa) = q^2 + Fpq$$
     - Calculation from observed heterozygosity: $\mathbf{F = \frac{H_{\text{exp}} - H_{\text{obs}}}{H_{\text{exp}}} = \frac{2pq - H_{\text{obs}}}{2pq}}$.
   - **Wright's Hierarchical $F$-Statistics ($I = \text{Individual}, S = \text{Subpopulation}, T = \text{Total}$):**
     $$\mathbf{(1 - F_{IT}) = (1 - F_{IS})(1 - F_{ST})}$$
     - **$F_{IS}$:** Inbreeding of individuals relative to their subpopulation.
     - **$F_{IT}$:** Total inbreeding of individuals relative to the entire population.
     - **$F_{ST}$ (Fixation Index / Genetic Differentiation):**
       $$\mathbf{F_{ST} = \frac{H_T - \bar{H}_S}{H_T} = \frac{\text{Var}(p)}{\bar{p}(1 - \bar{p})}}$$
       *(Measures allele frequency divergence among subpopulations: $F_{ST}=0 \implies$ No differentiation, $F_{ST}=1 \implies$ Complete fixation of alternate alleles).*
   - **Island Model of Migration (Sewall Wright):**
     $$F_{ST} \approx \frac{1}{4 N_e m + 1} \implies N_e m \approx \frac{1 - F_{ST}}{4 F_{ST}}$$
     *(Just $N_e m \ge 1$ migrant per generation prevents substantial divergence!).*
2. **Slide 2 (`ordering`):** Provide 5 steps calculating $F_{ST}$ across two equal-sized subpopulations: (1) measure allele frequency $p$ in subpopulation 1 ($p_1 = 0.80$) and subpopulation 2 ($p_2 = 0.20$), (2) calculate expected heterozygosity in each subpopulation: $H_{S1} = 2(0.8)(0.2) = 0.32$, $H_{S2} = 2(0.2)(0.8) = 0.32$, giving mean subpopulation heterozygosity $\bar{H}_S = 0.32$, (3) calculate total metapopulation allele frequency: $\bar{p} = (0.8 + 0.2)/2 = 0.50$, (4) compute expected total heterozygosity under panmixia: $H_T = 2\bar{p}(1-\bar{p}) = 2(0.5)(0.5) = 0.50$, (5) compute Wright's fixation index: $F_{ST} = (H_T - \bar{H}_S) / H_T = (0.50 - 0.32) / 0.50 = \mathbf{0.36}$!
3. **Slide 3 (`matching`):** Pair 4 population structure parameters ($F_{IS}$, $F_{ST}$, $F_{IT}$, Wahlund Effect) with their exact definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that alleles sharing identical ancestry from a recent common ancestor are termed identical by descent (abbreviated IBD). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Wright's island model: In a population genetic survey of an endangered mountain goat species distributed across fragmented alpine peaks, researchers calculate an average $F_{ST} = 0.20$. Assuming an island model of migration at equilibrium ($F_{ST} \approx \frac{1}{4 N_e m + 1}$), how many effective migrants per generation ($N_e m$) move between peaks? ($4 N_e m + 1 = 1 / F_{ST} = 1 / 0.20 = 5 \implies 4 N_e m = 4 \implies \mathbf{N_e m = 1\text{ migrant per generation}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "inbreeding_coefficients_and_population_subdivision_fst",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Inbreeding Coefficients and Population Subdivision (Fst)**\n• **Inbreeding Coefficient ($F$):**\n  - Probability that two homologous alleles are **Identical by Descent (IBD)**:\n$$\nF = \\frac{2pq - H_{\\text{obs}}}{2pq} \\implies f(Aa) = 2pq(1 - F)\n$$\n• **Wright's Hierarchical $F$-Statistics (1951):**\n$$\n\\mathbf{(1 - F_{IT}) = (1 - F_{IS})(1 - F_{ST})}\n$$\n• **Wright's Fixation Index ($F_{ST}$ - Population Structure):**\n$$\n\\mathbf{F_{ST} = \\frac{H_T - \\bar{H}_S}{H_T} = \\frac{\\text{Var}(p)}{\\bar{p}(1 - \\bar{p})}}\n$$\n  - $F_{ST} = 0$: Complete panmixia (no genetic structure).\n  - $F_{ST} = 1$: Complete divergence (different alleles fixed in subpopulations).\n• **Island Model Migration:** $\\mathbf{F_{ST} \\approx \\frac{1}{4 N_e m + 1}} \\implies N_e m \\approx \\frac{1 - F_{ST}}{4 F_{ST}}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the mathematical steps calculating F_ST between two isolated subpopulations (p1 = 0.80, p2 = 0.20).",
      "orderItems": [
        "Measure the allele frequencies of p in subpopulation 1 (p1 = 0.80) and subpopulation 2 (p2 = 0.20)",
        "Calculate the expected heterozygosity in each subpopulation (H_S1 = 0.32, H_S2 = 0.32) and take their average: H_S_bar = 0.32",
        "Calculate the total mean allele frequency across both pooled subpopulations: p_bar = (0.80 + 0.20) / 2 = 0.50",
        "Compute the total expected heterozygosity of the pooled metapopulation: H_T = 2 * p_bar * (1 - p_bar) = 2 * 0.5 * 0.5 = 0.50",
        "Calculate Wright's fixation index using F_ST = (H_T - H_S_bar) / H_T = (0.50 - 0.32) / 0.50 = 0.36"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each population genetics metric to its exact biological interpretation.",
      "matchPairs": [
        { "left": "F_IS (Inbreeding within Subpopulations)", "right": "Measures reduction in heterozygosity within local demes due to non-random mating / inbreeding" },
        { "left": "F_ST (Fixation Index)", "right": "Measures the proportion of total genetic variance attributable to allele frequency divergence among subpopulations" },
        { "left": "F_IT (Total Inbreeding)", "right": "Total reduction in heterozygosity of an individual relative to the entire metapopulation" },
        { "left": "Wahlund Effect", "right": "Apparent reduction in heterozygotes observed when multiple genetically differentiated subpopulations are falsely pooled as one" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Two homologous alleles in an individual that are exact genetic copies derived from a single common ancestor are said to be identical by ___ (IBD).",
      "blankAnswer": "descent",
      "blankDistractors": ["state", "chance", "drift"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a fragmented population of endangered woodland caribou, genetic analysis reveals a moderate level of subpopulation differentiation with F_ST = 0.20. Under Wright's island model of migration at equilibrium (F_ST ≈ 1 / [4*N_e*m + 1]), how many effective migrants per generation (N_e*m) are exchanged between herds?",
      "options": [
        { "text": "N_e*m = 1.0 migrant per generation; solving 0.20 = 1 / (4*N_e*m + 1) gives 4*N_e*m + 1 = 5, which yields 4*N_e*m = 4, so N_e*m = 1.0", "isCorrect": true, "explanation": "Correct! Rearranging Wright's island model equation: 4*N_e*m + 1 = 1 / F_ST = 1 / 0.20 = 5. Subtracting 1 yields 4*N_e*m = 4, which gives N_e*m = 1.0 migrant per generation. This illustrates Sewall Wright's famous rule of thumb: an exchange of just one effective migrant per generation is sufficient to prevent subpopulations from fixing alternative alleles through genetic drift." },
        { "text": "N_e*m = 20 migrants per generation", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "N_e*m = 0.05 migrants per generation", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "N_e*m = 100 migrants per generation", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
