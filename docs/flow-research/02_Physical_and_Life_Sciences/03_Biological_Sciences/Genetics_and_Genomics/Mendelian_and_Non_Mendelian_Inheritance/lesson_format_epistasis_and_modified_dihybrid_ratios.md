# Duofy Reusable Lesson Format: Epistasis and Modified Dihybrid Ratios

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Mendelian_and_Non_Mendelian_Inheritance`  
**Lesson Format Type:** `epistasis_and_modified_dihybrid_ratios`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the biochemical pathways, gene interactions, and mathematical ratio collapses of non-allelic epistatic gene interactions (William Bateson 1909, Lucien Cuénot): analyze how interactions between two independently assorting loci modify the standard $9:3:3:1$ dihybrid $F_2$ ratio into characteristic epistatic signatures: **Recessive Epistasis ($9:3:4$)** (e.g. Labrador retriever coat color, mouse coat color), **Dominant Epistasis ($12:3:1$)** (e.g. summer squash fruit color), **Duplicate Recessive / Complementary Epistasis ($9:7$)** (e.g. sweet pea flower color), **Duplicate Dominant Epistasis ($15:1$)** (e.g. shepherd's purse seed capsule shape), and **Dominant and Recessive Epistasis / Inhibitory ($13:3$)** (e.g. Malvidin production in primrose).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Epistasis Biochemical Paradigms & 16-Grid Collapse Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Labrador Retriever 9:3:4 Coat Color Pathway Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Epistatic Interaction Type & Modified $F_2$ Dihybrid Ratio Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Complementary Duplicate Recessive Epistasis F2 Ratio Sum String Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Labrador Retriever Coat Color Genotype to Phenotype Prediction Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Epistasis & Modified Dihybrid Ratios:
   - **The Definition of Epistasis:**
     - A non-allelic gene interaction where the genotype at one gene locus masks, inhibits, or alters the phenotypic expression of alleles at a second, independent gene locus.
   - **The 16-Square Grid Ratio Breakdown ($9/16\ A\_B\_, 3/16\ A\_bb, 3/16\ aaB\_, 1/16\ aabb$):**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Epistasis Type} & \textbf{Modified } F_2 \textbf{ Ratio} & \textbf{Biochemical Pathway Mechanism} \\
     \hline
     \textbf{Recessive Epistasis} & \mathbf{9 : 3 : 4} & \text{Homozygous } bb \text{ masks locus } A \ (9\ A\_B\_ : 3\ A\_bb : [3\ aaB\_ + 1\ aabb]) \\
     \textbf{Dominant Epistasis} & \mathbf{12 : 3 : 1} & \text{Dominant } A\_ \text{ masks locus } B \ ([9\ A\_B\_ + 3\ A\_bb] : 3\ aaB\_ : 1\ aabb) \\
     \textbf{Duplicate Recessive (Complementary)} & \mathbf{9 : 7} & \text{Both } A\_ \text{ and } B\_ \text{ required} \ (9\ A\_B\_ : [3\ A\_bb + 3\ aaB\_ + 1\ aabb]) \\
     \textbf{Duplicate Dominant} & \mathbf{15 : 1} & \text{Either } A\_ \text{ or } B\_ \text{ sufficient} \ ([9 + 3 + 3]\ A/\text{B present} : 1\ aabb) \\
     \textbf{Dominant & Recessive (Inhibitory)} & \mathbf{13 : 3} & A\_ \text{ suppresses dominant } B\_ \ ([9\ A\_B\_ + 3\ A\_bb + 1\ aabb] : 3\ aaB\_) \\
     \hline
     \end{array}$$
   - **Labrador Retriever Coat Color Example ($B$ and $E$ loci):**
     - $B$ (Black eumelanin) is dominant to $b$ (Brown/Chocolate).
     - $E$ locus controls pigment deposition into hair shafts: $E\_$ allows pigment deposition; $ee$ blocks all pigment deposition $\implies$ **Yellow Lab regardless of $B/b$ genotype** ($9\ B\_E\_ \text{ Black} : 3\ bbE\_ \text{ Brown} : 4\ \_\_ee \text{ Yellow}$).
2. **Slide 2 (`ordering`):** Provide 5 steps of the two-enzyme biochemical pigment synthesis pathway in Labrador retrievers: (1) metabolic precursor is converted into black eumelanin by the dominant $B$ allele (or chocolate brown by recessive $b$), (2) the $E$ gene encodes the melanocortin 1 receptor (MC1R) that licenses pigment deposition into hair follicles, (3) dogs with genotype $B\_E\_$ successfully deposit black eumelanin, producing a Black Labrador, (4) dogs with genotype $bbE\_$ successfully deposit brown eumelanin, producing a Chocolate Labrador, (5) dogs homozygous recessive for $ee$ fail to deposit any eumelanin into hair shafts, masking the $B/b$ genotype to produce a Yellow Labrador, establishing the $9:3:4$ recessive epistatic ratio!
3. **Slide 3 (`matching`):** Pair 4 epistatic ratio patterns ($9:3:4$, $12:3:1$, $9:7$, $15:1$) with their genetic names (Recessive Epistasis, Dominant Epistasis, Complementary / Duplicate Recessive Epistasis, Duplicate Dominant Epistasis).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in complementary duplicate recessive epistasis (such as sweet pea flower color), the modified F2 dihybrid phenotypic ratio is 9:7. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Labrador retriever epistasis problem: A male Black Labrador with genotype $BbEe$ is mated with a female Yellow Labrador with genotype $Bbee$. What is the probability of producing a Chocolate (brown) Labrador puppy from this cross? ($P(bb) = 1/2 \times 1/2 = 1/4$; $P(E\_) = 1/2$; applying the product rule: $P(bbE\_) = 1/4 \times 1/2 = \mathbf{1/8\ (12.5\%)}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "epistasis_and_modified_dihybrid_ratios",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Epistasis and Modified Dihybrid Ratios**\n• **Epistasis Concept:** Non-allelic gene interaction where one gene locus masks/alters the phenotype of a second locus.\n• **The 16-Square Ratio Transformations ($9 : 3 : 3 : 1$):**\n  - **Recessive Epistasis ($\\mathbf{9 : 3 : 4}$):** $ee$ masks $B/b$ locus (e.g. Labrador coat color: $9\\ B\\_E\\_ \\text{ Black} : 3\\ bbE\\_ \\text{ Brown} : 4\\ \\_\\_ee \\text{ Yellow}$).\n  - **Dominant Epistasis ($\\mathbf{12 : 3 : 1}$):** $A\\_$ masks $B/b$ (e.g. squash fruit color: $12\\ A\\_ \\text{ White} : 3\\ aaB\\_ \\text{ Yellow} : 1\\ aabb \\text{ Green}$).\n  - **Complementary / Duplicate Recessive ($\\mathbf{9 : 7}$):** Both $A\\_$ and $B\\_$ required for pigment ($9\\ A\\_B\\_ \\text{ Purple} : 7\\ \\text{White}$).\n  - **Duplicate Dominant ($\\mathbf{15 : 1}$):** Either $A\\_$ or $B\\_$ produces phenotype ($15\\ \\text{Triangular} : 1\\ \\text{Ovoid}$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the biochemical steps of pigment synthesis and hair deposition in Labrador retriever coat color genetics.",
      "orderItems": [
        "A color precursor molecule is converted into black eumelanin by the dominant B allele or brown eumelanin by the recessive b allele",
        "The separate E locus encodes the MC1R receptor required to deposit eumelanin pigment into growing hair shafts",
        "Dogs with genotype B_E_ produce black pigment and successfully deposit it into hair, yielding a Black Labrador",
        "Dogs with genotype bbE_ produce brown pigment and successfully deposit it into hair, yielding a Chocolate Labrador",
        "Dogs with homozygous recessive ee fail to deposit any eumelanin into hair, masking the B locus to produce a Yellow Labrador"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each modified F2 dihybrid phenotypic ratio to its epistatic mechanism.",
      "matchPairs": [
        { "left": "9 : 3 : 4 Phenotypic Ratio", "right": "Recessive Epistasis (homozygous recessive at one locus masks expression of both alleles at second locus)" },
        { "left": "12 : 3 : 1 Phenotypic Ratio", "right": "Dominant Epistasis (a dominant allele at one locus masks the phenotypic expression of the second locus)" },
        { "left": "9 : 7 Phenotypic Ratio", "right": "Complementary / Duplicate Recessive Epistasis (dominant alleles at BOTH loci are required for phenotype)" },
        { "left": "15 : 1 Phenotypic Ratio", "right": "Duplicate Dominant Epistasis (a dominant allele at EITHER locus produces the functional phenotype)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In sweet pea flower color genetics, complementary duplicate recessive epistasis alters the standard dihybrid ratio to 9:___.",
      "blankAnswer": "7",
      "blankDistractors": ["3", "4", "1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Labrador retrievers, coat color is governed by recessive epistasis (B_E_ Black, bbE_ Brown, __ee Yellow). A black male dog with genotype BbEe is crossed with a yellow female dog with genotype Bbee. What is the probability of obtaining a Chocolate (brown) puppy from this cross?",
      "options": [
        { "text": "1/8 (12.5%); for a chocolate puppy (bbE_), we need genotype bb from Bb x Bb (P = 1/4) and genotype E_ from Ee x ee (P = 1/2). By the product rule: P(bbE_) = (1/4) * (1/2) = 1/8", "isCorrect": true, "explanation": "Correct! Chocolate coat color requires the puppy to have genotype bb (homozygous brown) AND at least one dominant E allele (E_ for pigment deposition). For the B locus: Bb x Bb yields 1/4 BB, 1/2 Bb, 1/4 bb -> P(bb) = 1/4. For the E locus: Ee x ee yields 1/2 Ee, 1/2 ee -> P(E_) = 1/2. Multiplying the independent probabilities gives P(bbE_) = 1/4 * 1/2 = 1/8 (12.5%)." },
        { "text": "3/16", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1/2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "9/16", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
