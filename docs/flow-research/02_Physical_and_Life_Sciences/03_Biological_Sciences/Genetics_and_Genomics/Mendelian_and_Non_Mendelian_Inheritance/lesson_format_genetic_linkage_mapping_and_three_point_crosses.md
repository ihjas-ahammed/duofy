# Duofy Reusable Lesson Format: Genetic Linkage Mapping and Three-Point Crosses

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Mendelian_and_Non_Mendelian_Inheritance`  
**Lesson Format Type:** `genetic_linkage_mapping_and_three_point_crosses`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantitative mechanics, gene ordering algorithms, and interference calculations of genetic linkage and chromosome mapping (Thomas Hunt Morgan, Nobel Prize in Physiology or Medicine 1933; Alfred Sturtevant 1913): calculate **Recombination Frequency (RF)** in centimorgans ($1\text{ cM} = 1\%\text{ recombination} = 1\text{ map unit [m.u.]}$), solve **Three-Point Testcrosses ($AaBbCc \times aabbcc$)** by identifying the two most abundant **Parental non-crossover classes** and the two rarest **Double Crossover (DCO) classes**, deduce the **linear gene order** by determining which single marker flips between parentals and DCOs, calculate intergenic map distances ($d_{A-B} = \text{SCO}_1 + \text{DCO}$, $d_{B-C} = \text{SCO}_2 + \text{DCO}$), and compute the **Coefficient of Coincidence ($C = \frac{\text{Observed DCO}}{\text{Expected DCO}}$)** and **Genetic Interference ($I = 1 - C$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Genetic Linkage & Three-Point Mapping Theory Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 3-Point Testcross Gene Order & Distance Algorithm Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Mapping Parameter / Class & Mathematical Formulation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Chromosome Map Distance Unit Named After Morgan Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Three-Point Cross Gene Order and Map Distance Calculation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Genetic Linkage & Three-Point Mapping Principles:
   - **Chromosomal Linkage & Recombination:**
     - Syntenic genes located physically close on the same chromosome do not assort independently ($RF < 50\%$).
     - **Recombination Frequency (RF):**
       $$\text{RF} = \frac{\text{Total Recombinant Progeny}}{\text{Total Progeny}} \times 100\% \implies 1\%\text{ RF} = 1\text{ centimorgan (cM)} = 1\text{ map unit (m.u.)}$$
   - **The Three-Point Testcross Strategy ($AaBbCc \times aabbcc$):**
     1. **Parentals (NCO):** The two highest-frequency offspring classes ($>70-90\%$).
     2. **Double Crossovers (DCO):** The two lowest-frequency offspring classes ($<1-5\%$).
     3. **Gene Order Rule:** Compare the parental alleles with the DCO alleles. The single gene locus whose allele state is **swapped (inverted) relative to the other two markers is the MIDDLE GENE**!
     4. **Map Distances:**
        $$\text{Distance}(1-2) = \frac{\text{SCO}_{1-2} + \text{DCO}}{\text{Total}} \times 100\text{ cM}, \quad \text{Distance}(2-3) = \frac{\text{SCO}_{2-3} + \text{DCO}}{\text{Total}} \times 100\text{ cM}$$
   - **Interference & Coefficient of Coincidence:**
     $$\text{Expected DCO} = \text{Freq}(1-2) \times \text{Freq}(2-3) \times \text{Total}, \quad C = \frac{\text{Observed DCO}}{\text{Expected DCO}}, \quad \mathbf{\text{Interference } I = 1 - C}$$
     *(Positive interference $I > 0$: a crossover in interval 1 physically inhibits a crossover in interval 2!).*
2. **Slide 2 (`ordering`):** Provide 5 steps of the three-point cross analysis: (1) inspect the 8 phenotypic classes resulting from a trihybrid testcross and identify the two most frequent classes as non-crossover parentals, (2) identify the two rarest phenotypic classes as double crossovers (DCOs), (3) compare parental and DCO genotypes to identify which single allele has changed its linkage phase, placing that locus as the middle gene, (4) classify the remaining 4 classes into single crossover 1 (SCO1) and single crossover 2 (SCO2) events, (5) calculate recombinant frequencies for each interval by summing relevant SCO and DCO counts, dividing by total progeny to build the linear chromosome map!
3. **Slide 3 (`matching`):** Pair 4 linkage parameters (Recombination Frequency RF, Centimorgan cM, Coefficient of Coincidence C, Genetic Interference I) with their formulas and definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the unit of genetic map distance representing 1% recombination frequency is the centimorgan (cM). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on three-point mapping problem: In a testcross of female Drosophila heterozygous for three linked genes $v, w, z$ with a homozygous recessive male, the parental classes are $v^+ w^+ z^+$ ($420$) and $v\ w\ z$ ($410$). The double crossover classes are $v^+\ w\ z^+$ ($5$) and $v\ w^+\ z$ ($5$). Total progeny $= 1,000$. Which gene is in the middle? (Compare parentals $v^+ w^+ z^+$ with DCO $v^+ w\ z^+$. The $v$ and $z$ alleles are unchanged, but the **$w$ allele has flipped from $w^+$ to $w$**; therefore, **gene $w$ is in the middle**, giving gene order $v - w - z$ or $z - w - v$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "genetic_linkage_mapping_and_three_point_crosses",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Genetic Linkage Mapping and Three-Point Crosses**\n• **Recombination Frequency (RF & cM):**\n$$\n\\text{RF} = \\frac{\\text{Recombinant Progeny}}{\\text{Total Progeny}} \\times 100\\% \\implies 1\\%\\text{ Recombination} = 1\\text{ centimorgan (cM)}\n$$\n• **Three-Point Testcross ($AaBbCc \\times aabbcc$):**\n  1. **Parentals (NCO):** The 2 most frequent offspring classes.\n  2. **Double Crossovers (DCO):** The 2 rarest offspring classes.\n  3. **Gene Order Rule:** The allele that **flips/swaps** between Parentals and DCOs is the **MIDDLE GENE**!\n  4. **Interval Distance:** $\\text{Dist}(A-B) = \\frac{\\text{SCO}_{A-B} + \\text{DCO}}{\\text{Total}} \\times 100\\text{ cM}$.\n• **Genetic Interference ($I$):**\n$$\nC = \\frac{\\text{Observed DCO}}{\\text{Expected DCO}}, \\qquad \\mathbf{I = 1 - C}\n$$\n  *(A crossover in one interval physically suppresses crossing over in an adjacent interval!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the analytical steps for mapping genes from a three-point testcross dataset.",
      "orderItems": [
        "Examine the 8 progeny phenotypic classes and identify the two most abundant classes as parental (non-crossover) genotypes",
        "Identify the two least abundant progeny classes as double crossover (DCO) genotypes",
        "Compare parental and DCO genotypes: determine which single gene has switched its linkage phase to establish the middle gene",
        "Group the remaining four intermediate classes into Single Crossover 1 (SCO1) and Single Crossover 2 (SCO2) categories",
        "Calculate map distances in centimorgans for both intervals by summing (SCO + DCO) / Total * 100 to build the genetic map"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each genetic mapping term to its mathematical definition.",
      "matchPairs": [
        { "left": "Centimorgan (cM / Map Unit)", "right": "Distance between genes corresponding to a 1% recombination frequency" },
        { "left": "Double Crossover (DCO) Classes", "right": "The two rarest offspring phenotypic classes resulting from two simultaneous crossing-over events" },
        { "left": "Coefficient of Coincidence (C)", "right": "Ratio of observed double crossovers to expected double crossovers: Obs_DCO / Exp_DCO" },
        { "left": "Genetic Interference (I = 1 - C)", "right": "Measure of the degree to which a crossover in one region inhibits crossovers in adjacent regions" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In chromosome mapping, the unit of genetic distance corresponding to 1% recombination frequency is the ___ (cM).",
      "blankAnswer": "centimorgan",
      "blankDistractors": ["angstrom", "nanometer", "dalton"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a three-point testcross in Drosophila, the parental classes are v+ w+ z+ (420) and v w z (410). The rarest double crossover classes are v+ w z+ (5) and v w+ z (5). Out of 1,000 total progeny, which gene is located in the middle?",
      "options": [
        { "text": "GENE w IS IN THE MIDDLE; comparing parental (v+ w+ z+) with DCO (v+ w z+), alleles v+ and z+ remain linked together while allele w+ has switched to w, proving that locus w lies between loci v and z (order: v - w - z)", "isCorrect": true, "explanation": "Correct! In a double crossover, the two outer flanking markers retain their parental association, but the middle marker undergoes two flanking exchanges and appears inverted relative to the outer markers. Comparing parental (v+ w+ z+) with DCO (v+ w z+), we see v+ and z+ are together, but w+ was swapped for w. Therefore, gene w is in the middle, and the linear chromosomal gene order is v - w - z (or z - w - v)." },
        { "text": "Gene v is in the middle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Gene z is in the middle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "All three genes are located on different chromosomes", "isCorrect": false, "explanation": "Incorrect: They are linked." }
      ]
    }
  ]
}
```
