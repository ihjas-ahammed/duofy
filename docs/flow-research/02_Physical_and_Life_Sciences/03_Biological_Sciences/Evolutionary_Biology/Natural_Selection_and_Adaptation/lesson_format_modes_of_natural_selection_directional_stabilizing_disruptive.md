# Duofy Reusable Lesson Format: Modes of Natural Selection (Directional, Stabilizing, and Disruptive)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Natural_Selection_and_Adaptation`  
**Lesson Format Type:** `modes_of_natural_selection_directional_stabilizing_disruptive`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantitative, graphical, and ecological dynamics of phenotypic selection operating on continuous traits in natural populations (Charles Darwin 1859; George Gaylord Simpson; Peter and Rosemary Grant): formulate the 3 primary modes of natural selection based on their mathematical impact on population mean ($\bar{z}$) and phenotypic variance ($\sigma^2$) (**Directional Selection**: shifts population mean toward one extreme; **Stabilizing Selection**: culls both extremes, preserving mean while narrowing variance; **Disruptive / Diversifying Selection**: culls intermediate phenotypes, increasing variance to form bimodal distributions and potential sympatric speciation), and evaluate classic field studies (medium ground finch *Geospiza fortis* beak depth after the 1977 Daphne Major drought, human infant birth weight mortality curves, and African seedcracker beak polymorphism).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Modes of Natural Selection Phenotypic Dynamics Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Directional Selection Beak Depth Drought Event Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Selection Mode & Population Statistical Shift Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Intermediate Phenotype Favoring Selection Mode Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Disruptive Selection Bimodal Divergence and Speciation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Modes of Natural Selection on Phenotypic Distributions:
   - **The 3 Canonical Modes of Phenotypic Selection:**
     $$\begin{array}{|c|c|c|l|}
     \hline
     \textbf{Selection Mode} & \textbf{Effect on Mean } (\bar{z}) & \textbf{Effect on Variance } (\sigma^2) & \textbf{Classic Biological Example} \\
     \hline
     \textbf{Directional} & \text{Shifts (Increases/Decreases)} & \text{Reduces / Maintains} & \text{Drought selects for deeper finch beaks; Antibiotic resistance} \\
     \textbf{Stabilizing} & \textbf{Unchanged} & \textbf{Sharply Reduced} & \text{Human infant birth weight (optimal } 3-4\text{ kg minimizes mortality)} \\
     \textbf{Disruptive} & \textbf{Unchanged} & \textbf{Substantially Increased} & \text{Seedcrackers with small (soft) or large (hard) beaks (bimodal)} \\
     \hline
     \end{array}$$
   - **Fitness Functions $w(z)$:**
     - **Directional:** Linear / Monotonic ($w(z) \propto \beta z$).
     - **Stabilizing:** Concave / Quadratic peak centered at the mean ($w(z) = w_{\text{max}} - \gamma (z - \bar{z})^2$).
     - **Disruptive:** Convex / U-shaped valley with highest fitness at both phenotypic tails ($w(z) = w_{\text{min}} + \gamma (z - \bar{z})^2$).
2. **Slide 2 (`ordering`):** Provide 5 steps of directional selection during the 1977 Daphne Major drought (Peter & Rosemary Grant): (1) normal rainfall supports abundant small, soft seeds and large, hard *Tribulus* seeds, maintaining a baseline distribution of beak depths ($\bar{z} = 9.5\text{ mm}$), (2) a severe drought strikes the island, halting small seed production and leaving only large, tough-cased *Tribulus cistoides* seeds, (3) finches with shallow beaks are physically unable to crack *Tribulus* seeds and suffer high mortality, while deep-beaked birds survive, (4) surviving breeders possess a significantly larger mean beak depth ($\bar{z}_s = 10.1\text{ mm}$, selection differential $S = +0.6\text{ mm}$), (5) because beak depth is highly heritable ($h^2 \approx 0.74$), offspring in 1978 inherit deeper beaks ($\bar{z}' = 9.9\text{ mm}$), demonstrating an evolutionary response to directional selection!
3. **Slide 3 (`matching`):** Pair 4 biological scenarios (Galapagos finch beak depth after drought, Human birth weight mortality U-curve, Black-bellied seedcracker bimodality, Industrial melanism in peppered moths) with their selection modes.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that natural selection acting against both phenotypic extremes to preserve the intermediate mean is called stabilizing selection. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the evolutionary consequences of disruptive selection: In the African black-bellied seedcracker (*Pyrenestes ostrinus*), birds possess either small bills (specialized for soft sedge seeds) or exceptionally large bills (specialized for hard seeds), while intermediate-billed birds suffer high juvenile mortality because they are inefficient on both seed types. How does disruptive selection maintain this pattern? (Disruptive selection **creates two distinct adaptive fitness peaks by selecting against intermediate phenotypes**, maintaining a bimodal phenotypic distribution that can promote assortative mating and sympatric speciation).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "modes_of_natural_selection_directional_stabilizing_disruptive",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Modes of Natural Selection on Phenotypic Distributions**\n• **1. Directional Selection:**\n  - Favors one extreme phenotype $\\implies$ **Shifts population mean ($\\bar{z}$)** in that direction (e.g. finch beak depth increases after drought).\n• **2. Stabilizing Selection:**\n  - Favors intermediate phenotypes against both extremes $\\implies$ **Maintains mean ($\\bar{z}$)** while **sharply reducing phenotypic variance ($\\sigma^2$)** (e.g. human birth weight centered at $3.5\\text{ kg}$).\n• **3. Disruptive (Diversifying) Selection:**\n  - Favors both extreme phenotypes over intermediate forms $\\implies$ **Increases variance ($\\sigma^2$)** to generate a **bimodal distribution**, driving ecological niche specialization and sympatric speciation (e.g. seedcracker bill sizes)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the chronological events of directional selection on Darwin's finch beak depth during the 1977 Galapagos drought.",
      "orderItems": [
        "A baseline population of Geospiza fortis exhibits normal bell-curve variation in beak depth (mean = 9.5 mm)",
        "Severe drought halts plant reproduction, eliminating small soft seeds and leaving only large, hard-shelled Tribulus seeds",
        "Finches with small, shallow beaks cannot crack Tribulus seeds and suffer high mortality, while large-beaked birds survive",
        "The surviving breeding cohort has a significantly higher average beak depth (selection differential S = +0.6 mm)",
        "Because beak depth is highly heritable (h² ≈ 0.74), the 1978 offspring generation exhibits an evolutionary shift toward deeper beaks"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each natural scenario to its corresponding mode of phenotypic selection.",
      "matchPairs": [
        { "left": "Bacterial population exposed to penicillin", "right": "Directional Selection (shifts population toward high antibiotic resistance)" },
        { "left": "Human infant birth weight vs neonatal mortality", "right": "Stabilizing Selection (intermediate 3-4 kg infants exhibit highest survival)" },
        { "left": "African seedcracker bill size (small vs large)", "right": "Disruptive Selection (intermediate bills are inefficient on both hard and soft seeds)" },
        { "left": "Goldenrod gall fly gall size (parasitoid vs bird predation)", "right": "Stabilizing Selection (small galls killed by wasps, large galls eaten by woodpeckers)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mode of natural selection that acts against both phenotypic extremes to narrow variance around an intermediate optimal trait value is called ___ selection.",
      "blankAnswer": "stabilizing",
      "blankDistractors": ["directional", "disruptive", "sexual"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In the African seedcracker Pyrenestes ostrinus, birds possess either small beaks (adapted for soft sedge seeds) or giant beaks (adapted for rock-hard seeds), while birds with intermediate beaks suffer near 100% juvenile mortality. What mode of selection does this demonstrate?",
      "options": [
        { "text": "DISRUPTIVE SELECTION; fitness is highest at both extreme ends of the phenotypic spectrum and lowest for intermediate phenotypes, splitting the population into a bimodal distribution and promoting ecological divergence", "isCorrect": true, "explanation": "Correct! Disruptive (or diversifying) selection occurs when intermediate phenotypes have lower fitness than either extreme. In seedcrackers, intermediate beaks are too small to efficiently crack hard seeds and too large to handle small seeds rapidly, creating an adaptive valley between two fitness peaks. This maintains distinct morphs and can lead to sympatric speciation if accompanied by assortative mating." },
        { "text": "Stabilizing selection favoring medium beaks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Genetic drift with zero natural selection", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Directional selection making all birds beakless", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
