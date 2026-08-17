# Duofy Reusable Lesson Format: Hamilton's Rule and Inclusive Fitness

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Animal_Sciences_and_Zoology / Animal_Behavior_Ethology`  
**Lesson Format Type:** `hamiltons_rule_and_inclusive_fitness`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical genetics and evolutionary logic of kin selection and altruism (W.D. Hamilton, 1964; J.B.S. Haldane): formulate **Hamilton's Rule ($r B > C$)**, calculate coefficients of genetic relatedness ($r$) across genealogical pedigrees ($r_{\text{parent-offspring}} = 0.5$, $r_{\text{full siblings}} = 0.5$, $r_{\text{half siblings}} = 0.25$, $r_{\text{cousins}} = 0.125$), decompose **Inclusive Fitness** into direct vs indirect components, explain the evolution of **Eusociality in Haplodiploid Hymenoptera** (ants, bees, wasps: full sister-sister relatedness $r = 0.75 > r_{\text{mother-daughter}} = 0.5$), and analyze alarm-calling behavior in Belding's ground squirrels.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hamilton's Rule & Inclusive Fitness Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Kin Selection Altruistic Decision Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Kin Relationship & Coefficient of Relatedness (r) Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Haplodiploid Full Sister Genetic Relatedness Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Belding Ground Squirrel Female Alarm Calling Kin Selection Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hamilton's Rule & Inclusive Fitness (W.D. Hamilton, 1964):
   - **Hamilton's Rule for Kin Selection:**
     An altruistic gene will increase in frequency in a population if:
     $$r B > C$$
     where:
     - $r$: **Coefficient of Genetic Relatedness** (probability that a gene in the actor is identical by descent in the recipient).
     - $B$: **Fitness Benefit to Recipient** (extra offspring produced by recipient as a result of altruistic act).
     - $C$: **Fitness Cost to Actor** (offspring foregone / risk of death by altruist).
   - **Decomposition of Inclusive Fitness:**
     $$\text{Inclusive Fitness} = \text{Direct Fitness (Own Offspring)} + \text{Indirect Fitness (Related Kin Offspring Aided } \times r)$$
   - **Standard Diploid Relatedness Values ($r$):**
     - Parent $\leftrightarrow$ Offspring: $r = 0.5$
     - Full Siblings: $r = 0.5$
     - Half Siblings: $r = 0.25$
     - First Cousins: $r = 0.125$ ($1/8$; *"I would lay down my life for two brothers or eight cousins!"* — J.B.S. Haldane)
   - **The Haplodiploidy Asymmetry (Hymenoptera: Ants, Bees, Wasps):**
     - Males are haploid (develop from unfertilized eggs; $100\%$ paternal genes passed on).
     - Females are diploid.
     - Full sisters inherit $100\%$ identical genes from father ($0.50$) $+ 50\%$ from mother ($0.25$) $\implies$ **$r_{\text{sister-sister}} = 0.75$**!
     - A female worker is more closely related to her sisters ($r = 0.75$) than to her own potential daughters ($r = 0.50$), genetically predisposing the evolution of sterile worker castes.
2. **Slide 2 (`ordering`):** Provide 5 steps evaluating whether a bird should forfeit raising 1 own offspring ($C = 1$) to help its parents raise 3 additional full siblings ($B = 3$): (1) identify the direct fitness cost to the helper: forfeiting 1 offspring with relatedness $r_{\text{offspring}} = 0.5 \implies \text{Direct Cost} = 1 \times 0.5 = 0.5$, (2) identify the indirect fitness benefit: helping raise 3 additional full siblings with relatedness $r_{\text{full sib}} = 0.5 \implies \text{Indirect Benefit} = 3 \times 0.5 = 1.5$, (3) set up Hamilton's rule inequality: $r B > C \implies (0.5)(3) > 1 \implies 1.5 > 1.0$, (4) compute the net inclusive fitness payoff: $\Delta W_{\text{inclusive}} = 1.5 - 0.5 = +1.0$, (5) conclude that natural selection will strongly favor the evolution of cooperative breeding / helper-at-the-nest behavior!
3. **Slide 3 (`matching`):** Pair 4 kin relationships (Full siblings, First cousins, Haplodiploid full sisters, Clonal identical twins) with their coefficients of relatedness ($r = 0.50$, $r = 0.125$, $r = 0.75$, $r = 1.00$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in haplodiploid insects (ants, bees), full sisters share a genetic relatedness coefficient of 0.75. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on female-biased alarm calling in Belding's ground squirrels (*Urocitellus beldingi*): In Belding's ground squirrels, females remain in their natal colonies (female philopatry) while males disperse. When a terrestrial predator (coyote/badger) approaches, why do adult females give predatory alarm trills vastly more frequently than males, despite the alarm call doubling the caller's risk of being attacked? (Because female philopatry means an adult female is surrounded by close genetic relatives (daughters, sisters, mother, nieces); by Hamilton's rule ($rB > C$), the **indirect fitness gain from warning multiple genetic kin outweighs the direct mortality risk to the caller**, whereas dispersing males are surrounded by unrelated individuals ($r \approx 0$) and gain zero indirect fitness from calling).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hamiltons_rule_and_inclusive_fitness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hamilton's Rule and Inclusive Fitness (1964)**\n• **Hamilton's Inequality for Kin Selection:**\n$$\nr B > C\n$$\n  - $r$: **Coefficient of Relatedness** (probability of sharing an allele identical by descent).\n  - $B$: **Benefit to Recipient** (extra offspring produced due to altruism).\n  - $C$: **Cost to Actor** (own offspring foregone / risk of mortality).\n• **Inclusive Fitness Framework:**\n$$\n\\text{Inclusive Fitness} = \\text{Direct Fitness (Own Offspring)} + \\sum (r_i \\times B_i) \\text{ [Indirect Fitness]}\n$$\n• **Diploid Relatedness Coefficients ($r$):**\n  - Parent-Offspring: $r = 0.50$ | Full Siblings: $r = 0.50$\n  - Half-Siblings / Aunt-Niece: $r = 0.25$ | First Cousins: $r = 0.125$\n• **Haplodiploidy Asymmetry (Ants, Bees, Wasps):**\n  - Haploid fathers pass $100\\%$ genes to daughters.\n  - **$r_{\\text{sister-sister}} = 0.75$** ($> r_{\\text{mother-daughter}} = 0.50$), favoring sterile worker castes!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps calculating whether helper altruism in cooperative breeding is favored by Hamilton's rule.",
      "orderItems": [
        "Quantify the direct fitness cost: helper bird forfeits raising 1 of its own offspring (C = 1, r_offspring = 0.5)",
        "Quantify the indirect benefit: helper enables parents to successfully fledge 3 additional full siblings (B = 3)",
        "Determine the genetic coefficient of relatedness to full siblings: r_sibling = 0.50",
        "Evaluate Hamilton's rule inequality: r * B = 0.50 * 3 = 1.5 > C = 1.0",
        "Confirm that net inclusive fitness increases (+0.5 units), demonstrating that cooperative breeding is evolutionary favored"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each genealogical relationship to its exact coefficient of genetic relatedness (r).",
      "matchPairs": [
        { "left": "Haplodiploid Full Sisters (Worker Bees)", "right": "r = 0.75 (3/4 of genes identical by descent due to haploid father)" },
        { "left": "Diploid Full Siblings (Humans / Birds)", "right": "r = 0.50 (1/2 of genes shared from common parents)" },
        { "left": "Half-Siblings / Grandparent-Grandchild", "right": "r = 0.25 (1/4 of genes shared through single lineage)" },
        { "left": "First Cousins (Diploid)", "right": "r = 0.125 (1/8 of genes shared through common grandparents)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In haplodiploid insects like honeybees and ants, full sisters share a genetic relatedness coefficient r of ___.",
      "blankAnswer": "0.75",
      "blankDistractors": ["0.50", "0.25", "1.00"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Belding's ground squirrels, females remain in their natal colony while males disperse far away. Why do adult females give warning alarm calls to terrestrial predators significantly more often than adult males?",
      "options": [
        { "text": "Females are surrounded by close genetic relatives (daughters, sisters, mother); by Hamilton's rule (rB > C), the indirect fitness gained by warning related kin outweighs the direct risk to the caller, whereas dispersing males are surrounded by non-relatives (r ≈ 0)", "isCorrect": true, "explanation": "Correct! Because females exhibit natal philopatry (stay in their birthplace), an adult female's neighbors are primarily her genetic kin (r = 0.5 or 0.25). Her alarm call warns multiple close relatives, providing a large indirect fitness benefit that satisfies Hamilton's rule. In contrast, males disperse and live among unrelated squirrels (r ≈ 0), so warning calls provide zero indirect fitness gain while carrying personal mortality cost." },
        { "text": "Females can run faster than males and cannot be caught", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Males are completely deaf to predators", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Predators refuse to eat female ground squirrels", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
