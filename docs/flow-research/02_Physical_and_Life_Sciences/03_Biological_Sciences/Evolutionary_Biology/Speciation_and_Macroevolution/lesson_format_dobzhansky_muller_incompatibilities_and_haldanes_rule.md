# Duofy Reusable Lesson Format: Dobzhansky-Muller Incompatibilities and Haldane's Rule

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Speciation_and_Macroevolution`  
**Lesson Format Type:** `dobzhansky_muller_incompatibilities_and_haldanes_rule`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the genetic architecture and chromosomal mechanisms of postzygotic reproductive isolation (Theodosius Dobzhansky 1936, Hermann Muller 1942, J.B.S. Haldane 1922, H. Allen Orr 1993): formulate the **Dobzhansky-Muller Incompatibility (DMI) Two-Locus Epistatic Model** proving how postzygotic hybrid sterility and inviability evolve through neutral or adaptive substitutions in allopatry **without ever traversing an intermediate adaptive fitness valley**, master **Haldane's Rule (1922)** stating that in interspecific crosses the **heterogametic sex ($XY$ males in mammals/Drosophila; $ZW$ females in birds/Lepidoptera) is selectively sterile or inviable**, and explain the **Dominance Theory of Haldane's Rule** (unmasking of partially recessive X-linked incompatibility alleles in the hemizygous sex).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DMI Two-Locus Epistasis & Haldane's Rule Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Dobzhansky-Muller Two-Locus Divergence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hybrid Incompatibility Concept & Genetic Explanation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Interspecific Hybrid Sex Sterility Rule Formulating Geneticist Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Haldane's Rule Application to Avian ZW Hybrid Crosses Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Dobzhansky-Muller Incompatibilities & Haldane's Rule:
   - **The Darwinian Paradox of Postzygotic Isolation:**
     - How can natural selection favor a gene that causes hybrid sterility or death? (It doesn't; isolation is an accidental pleiotropic byproduct of independent divergence!).
   - **The Dobzhansky-Muller Model (1936, 1942):**
     $$\begin{array}{ccc}
     & \text{Ancestral Population } (a_0 a_0 \ b_0 b_0) & \\
     & \swarrow \qquad \searrow & \\
     \text{Lineage 1: } A a_0 \ b_0 b_0 \to \mathbf{A A \ b_0 b_0} & & \text{Lineage 2: } a_0 a_0 \ B b_0 \to \mathbf{a_0 a_0 \ B B} \\
     & \searrow \qquad \swarrow & \\
     & \mathbf{F_1\text{ Hybrid: } A a_0 \ B b_0 \implies \text{DELETERIOUS EPISTASIS!}} &
     \end{array}$$
     - In Lineage 1, derived allele $A$ works harmoniously with $b_0$. In Lineage 2, derived allele $B$ works harmoniously with $a_0$.
     - When lineages hybridize, alleles $A$ and $B$ encounter each other for the first time in evolutionary history, clashing with negative epistasis to cause hybrid sterility or death **without either lineage ever crossing a fitness valley!**
   - **Haldane's Rule (J.B.S. Haldane, 1922):**
     - *"When in the $F_1$ offspring of two different animal races one sex is absent, rare, or sterile, that sex is the heterogametic sex."*
     - **Mammals & Drosophila ($XY$ males):** Hybrid **males** are sterile/inviable.
     - **Birds & Butterflies ($ZW$ females):** Hybrid **females** are sterile/inviable.
   - **The Dominance Theory of Haldane's Rule (Muller 1940; Orr 1993):**
     - DMI alleles on sex chromosomes are typically partially recessive ($h < 0.5$).
     - In the homogametic sex ($XX$ or $ZZ$), the recessive incompatibility is masked by the other chromosome.
     - In the heterogametic sex ($XY$ or $ZW$), the hemizygous sex chromosome has no partner, fully unmasking the deleterious DMI alleles!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Dobzhansky-Muller incompatibility mechanism: (1) an ancestral population with genotype $aabb$ splits into two geographically isolated allopatric daughter populations, (2) in population 1, a new mutation $A$ arises and fixes ($AAbb$), functioning flawlessly with the ancestral $b$ allele, (3) in population 2, a new mutation $B$ arises and fixes ($aaBB$), functioning flawlessly with the ancestral $a$ allele, (4) secondary contact occurs and the two populations interbreed to produce $F_1$ hybrid offspring bearing genotype $AaBb$, (5) the derived $A$ and $B$ alleles, which have never been tested together by natural selection, exhibit negative epistatic interference, causing developmental disruption and hybrid sterility/inviability!
3. **Slide 3 (`matching`):** Pair 4 hybrid genetics concepts (Dobzhansky-Muller Incompatibility, Haldane's Rule in Mammals, Haldane's Rule in Birds, Dominance Theory) with their biological definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the rule stating the heterogametic sex is preferentially sterile or inviable in interspecies hybrids is Haldane's rule. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on applying Haldane's rule to avian hybridization: When a male Golden Pheasant is crossed with a female Lady Amherst's Pheasant, the $F_1$ hybrid male offspring are fully viable and fertile, but the $F_1$ hybrid female offspring are completely sterile and exhibit high embryonic mortality. What genetic rule and sex-determination system explains this outcome? (This is a direct application of **Haldane's Rule**; in birds, females are the **heterogametic sex ($ZW$)**, so recessive X/Z-linked Dobzhansky-Muller incompatibility alleles are unmasked in hemizygous females, causing female-specific sterility and inviability).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dobzhansky_muller_incompatibilities_and_haldanes_rule",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Dobzhansky-Muller Incompatibilities and Haldane's Rule**\n• **The Dobzhansky-Muller Model (1936, 1942):**\n$$\n\\text{Ancestral: } (a_0 a_0\\ b_0 b_0) \\implies \\text{Lineage 1: } (AA\\ b_0 b_0) \\quad \\& \\quad \\text{Lineage 2: } (a_0 a_0\\ BB)\n$$\n$$\n\\mathbf{F_1\\text{ Hybrid: } (A a_0\\ B b_0) \\implies \\text{Negative Epistatic Clash (Hybrid Sterility/Inviability)!}}\n$$\n  - **Key Insight:** Speciation occurs as a neutral/adaptive byproduct **without any population ever crossing an adaptive fitness valley**!\n• **Haldane's Rule (1922):**\n  - In interspecific hybrids, if one sex is sterile or inviable, it is the **Heterogametic Sex** ($XY$ or $ZW$).\n  - **Mammals / Flies ($XY$ Males):** Hybrid males suffer sterility first.\n  - **Birds / Butterflies ($ZW$ Females):** Hybrid females suffer sterility first.\n• **Dominance Theory:** Recessive X/Z-linked DMI alleles are **unmasked in the hemizygous sex**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the genetic events of the Dobzhansky-Muller model leading to hybrid breakdown.",
      "orderItems": [
        "An ancestral interbreeding population possesses the compatible baseline genotype aabb",
        "Geographic isolation splits the population into two allopatric daughter lineages",
        "Lineage 1 fixes a new beneficial mutation A (genotype AAbb), maintaining perfect internal compatibility",
        "Lineage 2 independently fixes a new beneficial mutation B (genotype aaBB), maintaining internal compatibility",
        "Secondary hybridization produces AaBb offspring where untested alleles A and B clash epistasis-wise, causing hybrid sterility"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each hybrid incompatibility concept to its genetic mechanism.",
      "matchPairs": [
        { "left": "Dobzhansky-Muller Incompatibility (DMI)", "right": "Deleterious negative epistasis between derived alleles that arose independently in isolated lineages" },
        { "left": "Haldane's Rule in Mammals & Drosophila", "right": "Heterogametic XY hybrid males suffer sterility or inviability much more severely than XX females" },
        { "left": "Haldane's Rule in Birds & Lepidoptera", "right": "Heterogametic ZW hybrid females suffer sterility or inviability much more severely than ZZ males" },
        { "left": "Dominance Theory of Haldane's Rule", "right": "Partially recessive incompatibility alleles on sex chromosomes are unmasked in the hemizygous sex" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The famous biological observation that the heterogametic sex is preferentially sterile or inviable in interspecies hybrids is known as ___'s rule.",
      "blankAnswer": "haldane",
      "blankDistractors": ["dobzhansky", "muller", "darwin"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When two closely related species of birds (such as Mallard and Pintail ducks) are hybridized in captivity, the male F1 hybrids are healthy and fertile, while the female F1 hybrids are completely sterile or die during embryonic development. What explains this female-specific defect?",
      "options": [
        { "text": "HALDANE'S RULE; in avian genetics, females are the heterogametic sex (ZW), so recessive Z-linked Dobzhansky-Muller incompatibility alleles are completely unmasked in hemizygous females, whereas homogametic males (ZZ) are protected by dominant wild-type alleles on their second Z chromosome", "isCorrect": true, "explanation": "Correct! Birds utilize the ZW sex-determination system where males are homogametic (ZZ) and females are heterogametic (ZW). By Haldane's rule, the heterogametic sex suffers hybrid breakdown first. Under the Dominance Theory, many DMI alleles that accumulated on the Z chromosome are partially recessive. Male hybrids receive two Z chromosomes (one from each parent species), so healthy dominant alleles mask the incompatibility. Female hybrids receive only one Z chromosome (from the father), fully unmasking all recessive incompatibilities and causing female-specific sterility or death." },
        { "text": "Female birds have no mitochondria and cannot make ATP", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Male ducks destroy female eggs deliberately", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Avian hybridization violates all laws of Mendelian genetics", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
