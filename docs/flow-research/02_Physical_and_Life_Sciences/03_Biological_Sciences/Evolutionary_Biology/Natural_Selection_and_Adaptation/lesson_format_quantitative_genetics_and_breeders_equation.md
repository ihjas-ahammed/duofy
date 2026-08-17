# Duofy Reusable Lesson Format: Quantitative Genetics and the Breeder's Equation

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Natural_Selection_and_Adaptation`  
**Lesson Format Type:** `quantitative_genetics_and_breeders_equation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical framework of quantitative genetics and microevolutionary predictions (R.A. Fisher 1918; Jay Lush 1937; Douglas Falconer): decompose total phenotypic variance into additive genetic, dominance, epistatic, and environmental components ($V_P = V_A + V_D + V_I + V_E$), define **Narrow-Sense Heritability ($h^2 = V_A / V_P$)** as the proportion of phenotypic variation transmitted across generations, calculate the **Selection Differential ($S = \bar{z}_s - \bar{z}$)**, solve **The Breeder's Equation ($R = h^2 S$)** to compute the evolutionary response ($R = \bar{z}' - \bar{z}$), predict offspring mean phenotype ($\bar{z}' = \bar{z} + h^2(\bar{z}_s - \bar{z})$), and analyze regression to the mean when $h^2 < 1.0$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Breeder's Equation & Narrow-Sense Heritability Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Evolutionary Response Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Quantitative Genetic Parameter & Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Additive Genetic Variance Over Total Phenotypic Variance Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Numerical Evolutionary Response to Artificial Selection Calculation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Quantitative Genetics & The Breeder's Equation:
   - **Decomposition of Phenotypic Variance ($V_P$):**
     $$V_P = V_G + V_E = (V_A + V_D + V_I) + V_E$$
     - $V_A$: **Additive Genetic Variance** (alleles act additively; directly determines resemblance between parents and offspring).
     - $V_D$: Dominance genetic variance; $V_I$: Epistatic interaction variance; $V_E$: Environmental variance.
   - **Narrow-Sense Heritability ($h^2$):**
     $$h^2 = \frac{V_A}{V_P} = \frac{V_A}{V_A + V_D + V_I + V_E} \qquad (0 \le h^2 \le 1)$$
     *(Determined experimentally from the slope of mid-parent vs offspring regression!).*
   - **The Breeder's Equation (Jay Lush, 1937):**
     $$\mathbf{R = h^2 S}$$
     where:
     - $S = \bar{z}_s - \bar{z}$ is the **Selection Differential** (mean of selected parents minus total population mean).
     - $R = \bar{z}' - \bar{z}$ is the **Evolutionary Response to Selection** (mean of next-generation offspring minus original mean).
     - **Offspring Generation Mean:** $\bar{z}' = \bar{z} + R = \bar{z} + h^2 S$.
   - **Intuition:** $h^2$ acts as an evolutionary filter. If $h^2 = 1.0$, $R = S$ (perfect transmission). If $h^2 = 0$, $R = 0$ (no evolution; pure environmental variation).
2. **Slide 2 (`ordering`):** Provide 5 steps calculating the evolutionary response in body mass: (1) measure the base population mean body mass ($\bar{z} = 100\text{ g}$), (2) select a subset of large individuals to breed, measuring their mean mass ($\bar{z}_s = 120\text{ g}$), (3) compute the selection differential: $S = \bar{z}_s - \bar{z} = 120 - 100 = 20\text{ g}$, (4) multiply selection differential by narrow-sense heritability ($h^2 = 0.40$) using the Breeder's equation: $R = h^2 S = (0.40)(20\text{ g}) = 8\text{ g}$, (5) add response to original mean to calculate the next-generation offspring mean: $\bar{z}' = 100 + 8 = 108\text{ g}$!
3. **Slide 3 (`matching`):** Pair 4 quantitative genetic terms (Narrow-sense heritability $h^2$, Broad-sense heritability $H^2$, Selection differential $S$, Response to selection $R$) with their mathematical formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that narrow-sense heritability is defined as the ratio of additive genetic variance (VA) to total phenotypic variance (VP). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on quantitative problem solving: In a population of dairy cows, the mean milk yield is $8,000\text{ kg/year}$. A dairy farmer selects top-producing cows with an average yield of $10,000\text{ kg/year}$ to breed the next generation. If the narrow-sense heritability for milk yield is $h^2 = 0.35$, what is the predicted mean milk yield ($\bar{z}'$) of their daughters? (Selection differential $S = 10,000 - 8,000 = 2,000\text{ kg}$. Response $R = h^2 S = 0.35 \times 2,000 = 700\text{ kg}$. Daughters' mean yield $\bar{z}' = 8,000 + 700 = \mathbf{8,700\text{ kg/year}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "quantitative_genetics_and_breeders_equation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Quantitative Genetics and the Breeder's Equation**\n• **Phenotypic Variance ($V_P$):**\n$$\nV_P = V_A + V_D + V_I + V_E\n$$\n  - $V_A$: **Additive Genetic Variance** (determines parent-offspring phenotypic resemblance).\n• **Narrow-Sense Heritability ($h^2$):**\n$$\nh^2 = \\frac{V_A}{V_P} \\qquad (0 \\le h^2 \\le 1)\n$$\n  - Equals the slope ($\\beta$) of the midparent-offspring regression line!\n• **The Breeder's Equation (Jay Lush, 1937):**\n$$\n\\mathbf{R = h^2 S}\n$$\n  - $S = \\bar{z}_s - \\bar{z}$ (Selection Differential: Breeders mean minus original mean).\n  - $R = \\bar{z}' - \\bar{z}$ (Response to Selection: Offspring mean minus original mean).\n  - **Offspring Generation Mean:** $\\bar{z}' = \\bar{z} + h^2 S$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the mathematical steps calculating evolutionary response using the Breeder's equation.",
      "orderItems": [
        "Measure the phenotypic trait mean of the original unselected base population (z_bar)",
        "Select the elite breeding cohort and measure their mean phenotypic trait value (z_bar_s)",
        "Calculate the selection differential by subtraction: S = z_bar_s - z_bar",
        "Multiply the selection differential by narrow-sense heritability using the Breeder's equation: R = h² * S",
        "Add the evolutionary response R to the original population mean to establish the offspring generation mean: z_bar' = z_bar + R"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each quantitative genetics parameter to its exact mathematical definition.",
      "matchPairs": [
        { "left": "Narrow-Sense Heritability (h²)", "right": "V_A / V_P (proportion of phenotypic variance due exclusively to additive genetic variance)" },
        { "left": "Broad-Sense Heritability (H²)", "right": "V_G / V_P = (V_A + V_D + V_I) / V_P (total genetic variance over phenotypic variance)" },
        { "left": "Selection Differential (S)", "right": "z_bar_s - z_bar (phenotypic difference between selected parents and whole population)" },
        { "left": "Evolutionary Response (R)", "right": "z_bar' - z_bar = h² * S (actual cross-generational change in population mean)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In quantitative genetics, narrow-sense heritability h^2 is defined as the ratio of ___ genetic variance (V_A) to total phenotypic variance (V_P).",
      "blankAnswer": "additive",
      "blankDistractors": ["dominance", "epistatic", "environmental"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a dairy cattle herd, the mean milk production is 8,000 kg/year. A farmer selects cows with a mean production of 10,000 kg/year to breed the next generation. If the narrow-sense heritability of milk yield is h² = 0.35, what is the predicted mean milk yield of their daughters?",
      "options": [
        { "text": "8,700 kg/year; Selection Differential S = 10,000 - 8,000 = 2,000 kg/year. Applying the Breeder's equation R = h² * S = 0.35 * 2,000 = 700 kg/year. Daughter mean = 8,000 + 700 = 8,700 kg/year", "isCorrect": true, "explanation": "Correct! First compute the selection differential S = 10,000 kg - 8,000 kg = 2,000 kg. Next, apply the Breeder's equation R = h² * S = 0.35 * 2,000 kg = 700 kg. Finally, add the evolutionary response R to the baseline population mean: z' = 8,000 kg + 700 kg = 8,700 kg/year. The daughters regress toward the herd mean because 65% of the parental advantage was environmental or non-additive." },
        { "text": "10,000 kg/year (full inheritance)", "isCorrect": false, "explanation": "Incorrect: That would require h² = 1.0." },
        { "text": "8,000 kg/year (zero inheritance)", "isCorrect": false, "explanation": "Incorrect: That would require h² = 0." },
        { "text": "18,000 kg/year", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
