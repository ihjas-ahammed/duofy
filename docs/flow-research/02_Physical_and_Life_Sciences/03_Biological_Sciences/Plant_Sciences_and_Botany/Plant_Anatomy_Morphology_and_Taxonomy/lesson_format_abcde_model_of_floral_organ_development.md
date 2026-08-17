# Duofy Reusable Lesson Format: The ABCDE Model of Floral Organ Development

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Plant_Sciences_and_Botany / Plant_Anatomy_Morphology_and_Taxonomy`  
**Lesson Format Type:** `abcde_model_of_floral_organ_development`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the combinatorial genetics and homeotic MADS-box transcription factor quartets that pattern the four concentric whorls of angiosperm flowers (Elliot Meyerowitz & Enrico Coen, 1991): master the canonical combinatorial code (**Whorl 1: Class A $\to$ Sepals**; **Whorl 2: Class A + Class B $\to$ Petals**; **Whorl 3: Class B + Class C $\to$ Stamens**; **Whorl 4: Class C $\to$ Carpels**; with Class E **SEPALLATA** required for all floral organs), analyze the strict mutual antagonism between Class A and Class C genes, and solve classic homeotic mutant phenotypes in *Arabidopsis thaliana* (e.g. *agamous* [C-mutant: double flowers with repeating sepals-petals-petals-sepals], *apetala2* [A-mutant: carpels-stamens-stamens-carpels], and *apetala3 / pistillata* [B-mutant: sepals-sepals-carpels-carpels]).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The ABCDE Combinatorial Model & Mutual Antagonism Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Outer-to-Inner Floral Whorl Identity Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Homeotic Mutant / Floral Whorl & Resulting Organ Identity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Universal Floral Class E Gene Family Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Agamous C-Function Loss-of-Function Floral Transformation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The ABCDE Model of Floral Organ Identity (Coen & Meyerowitz, 1991):
   - **The 4 Concentric Whorls & Combinatorial Logic:**
     $$\begin{array}{|c|c|c|l|}
     \hline
     \textbf{Floral Whorl} & \textbf{Organ Identity} & \textbf{Active Classes} & \textbf{Arabidopsis MADS-Box Genes} \\
     \hline
     \text{Whorl 1 (Outer)} & \textbf{Sepals (Calyx)} & \mathbf{A + E} & APETALA1 (AP1), AP2 + SEPALLATA (SEP) \\
     \text{Whorl 2} & \textbf{Petals (Corolla)} & \mathbf{A + B + E} & AP1, AP2 + AP3, PISTILLATA (PI) + SEP \\
     \text{Whorl 3} & \textbf{Stamens (Androecium)} & \mathbf{B + C + E} & AP3, PI + AGAMOUS (AG) + SEP \\
     \text{Whorl 4 (Inner)} & \textbf{Carpels (Gynoecium)} & \mathbf{C + E} & AGAMOUS (AG) + SEP \\
     \hline
     \end{array}$$
   - **Mutual Antagonism Principle:**
     - Class A and Class C genes mutually repress each other's expression.
     - If Class A is mutated $\implies$ Class C activity expands into all 4 whorls.
     - If Class C is mutated $\implies$ Class A activity expands into all 4 whorls.
   - **The Class E Requirement (SEPALLATA 1-4):**
     - Class E proteins form obligate tetrameric complexes with ABC proteins; loss of all 4 *SEP* genes converts all floral organs into vegetative green leaves!
2. **Slide 2 (`ordering`):** Provide 5 steps mapping the concentric floral whorls from outermost to innermost in wild-type Arabidopsis: (1) outermost Whorl 1 expresses Class A and E genes to specify green sepals, (2) Whorl 2 expresses Class A, B, and E genes to specify colorful petals, (3) Whorl 3 expresses Class B, C, and E genes to specify pollen-producing male stamens, (4) innermost Whorl 4 expresses Class C and E genes to specify the ovule-bearing female carpels, (5) Class C activity enforces floral determinacy, terminating the floral meristem so no further whorls develop inside the carpels!
3. **Slide 3 (`matching`):** Pair 4 Arabidopsis mutant genotypes (Class A mutant *ap2*, Class B mutant *ap3/pi*, Class C mutant *agamous*, Class E quadruple *sep* mutant) with their resulting floral organ phenotypes.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Class E MADS-box genes required for the formation of all floral organs belong to the SEPALLATA gene family. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the homeotic phenotype of the *agamous* (*ag*) mutation in *Arabidopsis thaliana*: In the classic *agamous* mutant, what floral organ pattern develops in place of the normal four whorls (sepals, petals, stamens, carpels)? (Due to the loss of Class C, **Class A expands into whorls 3 and 4**, converting stamens into petals and carpels into sepals, while losing determinacy to produce an indeterminate, repeating "double flower" phenotype of **sepals-petals-petals-sepals-petals-petals...**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "abcde_model_of_floral_organ_development",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The ABCDE Model of Floral Organ Identity (1991)**\n• **The Combinatorial Whorl Map:**\n$$\n\\begin{array}{|c|c|c|l|}\n\\hline\n\\textbf{Whorl} & \\textbf{Organ} & \\textbf{Classes} & \\textbf{Arabidopsis Genes} \\\\\n\\hline\n\\text{Whorl 1} & \\textbf{Sepals} & \\mathbf{A + E} & AP1, AP2 + SEP \\\\\n\\text{Whorl 2} & \\textbf{Petals} & \\mathbf{A + B + E} & AP1/2 + AP3/PI + SEP \\\\\n\\text{Whorl 3} & \\textbf{Stamens} & \\mathbf{B + C + E} & AP3/PI + AGAMOUS + SEP \\\\\n\\text{Whorl 4} & \\textbf{Carpels} & \\mathbf{C + E} & AGAMOUS + SEP \\\\\n\\hline\n\\end{array}\n$$\n• **Class A $\\iff$ Class C Mutual Antagonism:**\n  - Loss of Class A $\\implies$ Class C expands into whorls 1 & 2.\n  - Loss of Class C $\\implies$ Class A expands into whorls 3 & 4.\n• **Class E (SEPALLATA):** Essential co-factor; quadruple *sep1/2/3/4* mutants convert all floral whorls into **vegetative green leaves**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the floral whorls from outermost to innermost in a wild-type eudicot flower.",
      "orderItems": [
        "Whorl 1 (Outermost): Class A + E genes specify the protective green calyx of sepals",
        "Whorl 2: Class A + B + E genes specify the pigmented corolla of petals for pollinator attraction",
        "Whorl 3: Class B + C + E genes specify the pollen-bearing male stamens (androecium)",
        "Whorl 4 (Innermost): Class C + E genes specify the ovule-bearing female carpels (gynoecium)",
        "Class C gene activity imposes floral determinacy, terminating the meristem to complete flower architecture"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Arabidopsis floral homeotic mutant to its organ transformation phenotype.",
      "matchPairs": [
        { "left": "Class A Mutant (apetala2 / ap2)", "right": "Carpels - Stamens - Stamens - Carpels (Class C expands into whorls 1 & 2)" },
        { "left": "Class B Mutant (apetala3 / pistillata)", "right": "Sepals - Sepals - Carpels - Carpels (Loss of B prevents petal and stamen identity)" },
        { "left": "Class C Mutant (agamous / ag)", "right": "Sepals - Petals - Petals - Sepals... (Indeterminate double-flower; Class A expands into whorls 3 & 4)" },
        { "left": "Class E Quadruple Mutant (sep1 sep2 sep3 sep4)", "right": "Leaves - Leaves - Leaves - Leaves (All four floral whorls revert to vegetative foliage leaves)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Class E MADS-box transcription factors required as universal tetrameric partners for all floral organ development are encoded by the ___ gene family.",
      "blankAnswer": "sepallata",
      "blankDistractors": ["agamous", "apetala", "pistillata"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In an Arabidopsis thaliana mutant lacking functional AGAMOUS (Class C gene), what is the resulting floral phenotype and why?",
      "options": [
        { "text": "SEPALS - PETALS - PETALS - SEPALS (with loss of determinacy, generating a nested 'double flower' of repeating petals and sepals); because without Class C repression, Class A expands into whorls 3 and 4, converting stamens into petals and carpels into sepals", "isCorrect": true, "explanation": "Correct! AGAMOUS provides the Class C function and normally represses Class A in whorls 3 and 4 while also terminating the floral stem cell niche (determinacy). When AGAMOUS is mutated (ag), Class A expands across all four whorls. Whorl 3 (now A+B) becomes petals instead of stamens. Whorl 4 (now A alone) becomes sepals instead of carpels. Because determinacy is lost, a new flower bud continuously emerges inside whorl 4, creating the prized horticultural 'double flower' phenotype with dozens of extra petals." },
        { "text": "The entire plant turns into a mushroom", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "All four whorls become carpels", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The plant produces only giant thorns", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
