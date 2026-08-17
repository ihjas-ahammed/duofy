# Duofy Reusable Lesson Format: Mendelian Laws and Dihybrid Crosses

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Mendelian_and_Non_Mendelian_Inheritance`  
**Lesson Format Type:** `mendelian_laws_and_dihybrid_crosses`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the foundational probabilistic principles of classical transmission genetics (Gregor Mendel, 1865; Reginald Punnett 1905): master **Mendel's First Law of Segregation** (equal separation of alleles during anaphase I yielding $3:1$ phenotypic and $1:2:1$ genotypic ratios in monohybrid crosses), master **Mendel's Second Law of Independent Assortment** (random orientation of non-homologous chromosome bivalents at metaphase I plate yielding $9:3:3:1$ phenotypic ratios in dihybrid crosses), evaluate **Testcrosses ($AaBb \times aabb \to 1:1:1:1$)** to determine unknown parental genotypes, and apply the **Product and Sum Probability Rules** to solve multi-locus genetic problems.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mendel's Laws & Dihybrid Cross Architecture Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Dihybrid Cross Multi-Locus Probability Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Genetic Cross Type & Expected Phenotypic Ratio Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Standard Dihybrid Heterozygous F2 Phenotypic Major Class Fraction Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Trihybrid Heterozygous Cross Phenotype Probability Calculation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Mendel's Two Laws & Cross Calculations:
   - **Mendel's First Law (Law of Segregation):**
     - The two alleles for a heritable character segregate during meiosis I anaphase so that each gamete receives only one allele.
     - **Monohybrid Cross ($Aa \times Aa$):**
       - Genotypes: $1/4\ AA : 1/2\ Aa : 1/4\ aa$ ($1:2:1$).
       - Phenotypes: $3/4\ \text{Dominant} : 1/4\ \text{Recessive}$ ($3:1$).
   - **Mendel's Second Law (Law of Independent Assortment):**
     - Alleles at different, unlinked gene loci assort independently during gamete formation (metaphase I random alignment).
     - **Dihybrid Cross ($AaBb \times AaBb$):**
       - Phenotypic Ratio: $\mathbf{9/16\ A\_B\_ : 3/16\ A\_bb : 3/16\ aaB\_ : 1/16\ aabb}$ ($\mathbf{9:3:3:1}$).
     - **Dihybrid Testcross ($AaBb \times aabb$):**
       - Phenotypic Ratio: $\mathbf{1:1:1:1}$ ($1/4\ AaBb : 1/4\ Aabb : 1/4\ aaBb : 1/4\ aabb$).
   - **Probability Rules:**
     - **Multiplication (Product) Rule:** $P(A \text{ and } B) = P(A) \times P(B)$ (for independent events).
     - **Addition (Sum) Rule:** $P(A \text{ or } B) = P(A) + P(B)$ (for mutually exclusive events).
2. **Slide 2 (`ordering`):** Provide 5 steps calculating the probability of obtaining an $AAbbCc$ offspring from a trihybrid cross ($AaBbCc \times AaBbCc$): (1) treat each unlinked gene locus as an independent monohybrid cross, (2) compute the probability of obtaining homozygous dominant $AA$ from $Aa \times Aa$: $P(AA) = 1/4$, (3) compute the probability of obtaining homozygous recessive $bb$ from $Bb \times Bb$: $P(bb) = 1/4$, (4) compute the probability of obtaining heterozygous $Cc$ from $Cc \times Cc$: $P(Cc) = 2/4 = 1/2$, (5) multiply the independent probabilities using the product rule: $P(AAbbCc) = 1/4 \times 1/4 \times 1/2 = \mathbf{1/32}$!
3. **Slide 3 (`matching`):** Pair 4 classical genetic crosses ($Aa \times Aa$ Monohybrid, $AaBb \times AaBb$ Dihybrid, $AaBb \times aabb$ Dihybrid Testcross, $Aa \times aa$ Monohybrid Testcross) with their expected phenotypic ratios ($3:1$, $9:3:3:1$, $1:1:1:1$, $1:1$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in a standard dihybrid cross between two heterozygous parents (AaBb x AaBb), the expected fraction of offspring exhibiting both dominant traits (A_B_) is 9/16. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on probability in trihybrid inheritance: In a cross between two individuals with genotypes $AaBbCc \times AaBbCc$, what is the exact probability of producing an offspring that displays the dominant phenotype for all three traits ($A\_B\_C\_$)? ($P(A\_) = 3/4$, $P(B\_) = 3/4$, $P(C\_) = 3/4$. By the product rule: $P(A\_B\_C\_) = 3/4 \times 3/4 \times 3/4 = \mathbf{27/64}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mendelian_laws_and_dihybrid_crosses",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Mendelian Laws and Dihybrid Crosses (1865)**\n• **Mendel's 1ˢᵗ Law (Segregation):**\n  - Allele pairs separate during Anaphase I of meiosis.\n  - **Monohybrid ($Aa \\times Aa$):** Phenotypic ratio **$3:1$** ($3/4\\ A\\_ : 1/4\\ aa$), Genotypic ratio **$1:2:1$**.\n• **Mendel's 2ⁿᵈ Law (Independent Assortment):**\n  - Non-homologous chromosome pairs align randomly at Metaphase I.\n  - **Dihybrid Cross ($AaBb \\times AaBb$):**\n$$\n\\mathbf{9/16\\ A\\_B\\_ : 3/16\\ A\\_bb : 3/16\\ aaB\\_ : 1/16\\ aabb} \\qquad (\\mathbf{9:3:3:1})\n$$\n  - **Dihybrid Testcross ($AaBb \\times aabb$):** Phenotypic ratio **$1:1:1:1$**.\n• **Product Rule:** $P(A \\cap B) = P(A) \\times P(B)$ for independent loci."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps calculating the exact probability of an AAbbCc genotype from a trihybrid AaBbCc x AaBbCc cross.",
      "orderItems": [
        "Deconstruct the trihybrid cross into three independent single-locus monohybrid crosses (Aa x Aa, Bb x Bb, Cc x Cc)",
        "Determine the probability of obtaining the homozygous dominant genotype AA from Aa x Aa: P(AA) = 1/4",
        "Determine the probability of obtaining the homozygous recessive genotype bb from Bb x Bb: P(bb) = 1/4",
        "Determine the probability of obtaining the heterozygous genotype Cc from Cc x Cc: P(Cc) = 2/4 = 1/2",
        "Apply the product probability rule across independent loci: P(AAbbCc) = 1/4 * 1/4 * 1/2 = 1/32"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each classical Mendelian genetic cross to its expected phenotypic ratio.",
      "matchPairs": [
        { "left": "Dihybrid Heterozygous Cross (AaBb x AaBb)", "right": "9 : 3 : 3 : 1 phenotypic ratio (4 distinct phenotypic classes)" },
        { "left": "Dihybrid Testcross (AaBb x aabb)", "right": "1 : 1 : 1 : 1 phenotypic ratio (identifies parental gamete frequencies)" },
        { "left": "Monohybrid Heterozygous Cross (Aa x Aa)", "right": "3 : 1 phenotypic ratio (3/4 dominant : 1/4 recessive)" },
        { "left": "Monohybrid Testcross (Aa x aa)", "right": "1 : 1 phenotypic ratio (1/2 dominant : 1/2 recessive)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a standard dihybrid cross between two heterozygous parents (AaBb x AaBb), the expected fraction of offspring expressing both dominant traits (A_B_) is ___/16.",
      "blankAnswer": "9",
      "blankDistractors": ["3", "1", "12"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a cross between two pea plants with genotypes AaBbCc x AaBbCc (where all three gene loci assort independently), what is the probability of producing an offspring displaying the dominant phenotype for all three traits (A_B_C_)?",
      "options": [
        { "text": "27/64; by the product rule, P(A_) = 3/4, P(B_) = 3/4, and P(C_) = 3/4. Multiplying independent probabilities yields: (3/4) * (3/4) * (3/4) = 27/64", "isCorrect": true, "explanation": "Correct! Because the three gene loci assort independently on different chromosomes, we treat each gene as an independent event. For a monohybrid cross Aa x Aa, the probability of showing the dominant phenotype A_ is 3/4. Doing the same for Bb x Bb gives P(B_) = 3/4, and for Cc x Cc gives P(C_) = 3/4. Applying the multiplication rule for independent events: P(A_B_C_) = (3/4) * (3/4) * (3/4) = 27/64 (or 42.1875%)." },
        { "text": "9/64", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1/64", "isCorrect": false, "explanation": "Incorrect: That is the probability of aabbcc." },
        { "text": "3/64", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
