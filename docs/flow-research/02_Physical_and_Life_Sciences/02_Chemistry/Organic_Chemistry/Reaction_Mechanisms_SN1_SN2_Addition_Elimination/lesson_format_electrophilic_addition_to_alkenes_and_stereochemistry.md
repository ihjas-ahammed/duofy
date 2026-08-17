# Duofy Reusable Lesson Format: Electrophilic Addition to Alkenes and Stereochemistry

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Reaction_Mechanisms_SN1_SN2_Addition_Elimination`  
**Lesson Format Type:** `electrophilic_addition_to_alkenes_and_stereochemistry`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanisms, regioselectivity, and stereospecificity of electrophilic additions to alkenes: formulate **Markovnikov's Rule (Vladimir Markovnikov, 1870)** via carbocation stability ($\text{H}-\text{X}$ addition, carbocation rearrangements via hydride/alkyl shifts), contrast with **Anti-Markovnikov Regiochemistry** (Free radical addition of $\text{HBr} / \text{ROOR}$, and **Hydroboration-Oxidation** $\text{BH}_3\cdot\text{THF} \to \text{syn-alcohol}$), master **Halogenation Stereospecificity via Cyclic Bromonium / Chloronium Ions** enforcing **Strict *Anti*-Addition**, and evaluate ***Syn*-Dihydroxylation** using catalytic $\text{OsO}_4 / \text{NMO}$ or cold alkaline $\text{KMnO}_4$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Electrophilic Addition Regio- and Stereospecificity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Alkene Bromination Bromonium Ring Opening Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Alkene Addition Reagent & Stereochemical Outcome Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Hydroboration-Oxidation Regiochemical Outcome Category Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Bromination of Cyclohexene Trans-Stereoisomer Product Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Electrophilic Additions to Alkenes:
   - **Markovnikov's Rule (Carbocation Pathway):**
     - In the addition of an unsymmetrical protic acid ($\text{H}-\text{X}$) to an alkene, the electrophilic proton ($\text{H}^+$) adds to the carbon with more hydrogens, creating the **more substituted, more stable carbocation intermediate** ($3^\circ > 2^\circ > 1^\circ$).
     - Carbocation intermediates can undergo 1,2-hydride or 1,2-methyl shifts to gain tertiary resonance stability.
   - **Anti-Addition via Bridged Halonium Ions ($\text{Br}_2, \text{Cl}_2$):**
     - Electrophilic $\text{Br}^+$ is trapped by both carbons of the alkene $\pi$-bond to form a 3-membered cyclic **bromonium ion**.
     - Bromide nucleophile ($\text{Br}^-$) attacks the more substituted carbon from the **backside opposite the three-membered ring**, enforcing **$100\%$ *Anti*-Stereospecificity** (e.g. cyclopentene $+\ \text{Br}_2 \to \text{trans-1,2-dibromocyclopentane}$ enantiomeric pair).
   - **Syn-Additions:**
     - **Hydroboration-Oxidation ($\text{BH}_3\cdot\text{THF}$, then $\text{H}_2\text{O}_2/\text{NaOH}$):** Concerted 4-membered transition state adding $\text{B}$ and $\text{H}$ simultaneously to the same face $\implies$ **Anti-Markovnikov, *Syn*-Addition** of $\text{H}_2\text{O}$.
     - **Dihydroxylation ($\text{OsO}_4 / \text{NMO}$):** Forms cyclic osmate ester intermediate $\implies$ **1,2-*Syn*-Diol**.
2. **Slide 2 (`ordering`):** Provide 5 steps of the electrophilic bromination of an alkene: (1) nucleophilic $\pi$-electrons of the alkene attack the polarizable bromine molecule ($\text{Br}-\text{Br}$), displacing the distal bromide ion ($\text{Br}^-$), (2) the attacking bromine atom simultaneously uses its lone pair to bond back to the second alkene carbon, forming a cyclic 3-membered bromonium ion intermediate, (3) the positively charged 3-membered ring blocks one face of the molecule entirely, (4) the free bromide ion ($\text{Br}^-$) executes a backside $\text{S}_{\text{N}}2$-like attack on the more substituted carbon of the bromonium ion from the opposite face, (5) ring opening cleaves the $\text{C}-\text{Br}^+$ bond, yielding the *anti*-1,2-dibromoalkane product!
3. **Slide 3 (`matching`):** Pair 4 alkene addition reagents ($\text{Br}_2 / \text{CH}_2\text{Cl}_2$, $\text{BH}_3\cdot\text{THF}$ then $\text{H}_2\text{O}_2/\text{NaOH}$, $\text{OsO}_4 / \text{NMO}$, $\text{HBr} / \text{ROOR}$ peroxides) with their stereochemical and regiochemical outcomes (*Anti*-dihalogenation, *Anti*-Markovnikov *syn*-hydration, *Syn*-1,2-dihydroxylation, Radical *anti*-Markovnikov hydrobromination).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that hydroboration-oxidation of alkenes yields the anti-markovnikov alcohol product. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the stereochemical outcome of cyclohexene bromination: When pure cyclohexene is reacted with bromine ($\text{Br}_2$ in $\text{CCl}_4$), which stereoisomer is formed? (The **racemic mixture of (1R,2R)- and (1S,2S)-trans-1,2-dibromocyclohexane**; because bromination proceeds via a cyclic bromonium ion intermediate, backside nucleophilic attack by bromide ion strictly enforces *anti*-addition, making formation of *cis*-1,2-dibromocyclohexane impossible).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "electrophilic_addition_to_alkenes_and_stereochemistry",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Electrophilic Addition to Alkenes and Stereochemistry**\n• **Markovnikov Addition (Carbocation Route):**\n  - $\\text{H}^+$ adds to less substituted carbon to generate the **more stable carbocation** ($3^\\circ > 2^\\circ > 1^\\circ$).\n  - Subject to 1,2-hydride and 1,2-alkyl carbocation rearrangements.\n• **Anti-Addition via Bridged Halonium Ions ($\\text{Br}_2, \\text{Cl}_2$):**\n  - Forms a cyclic 3-membered **bromonium ion**.\n  - Nucleophilic $\\text{Br}^-$ attacks from the opposite face (backside opening) $\\implies$ **$100\\%$ *Anti*-Stereospecificity**.\n• **Syn-Addition Reactions:**\n  - **Hydroboration-Oxidation ($\\text{BH}_3$, $\\text{H}_2\\text{O}_2/\\text{OH}^-$):** **Anti-Markovnikov, *Syn*-Addition** of $\\text{H}$ and $\\text{OH}$.\n  - **Dihydroxylation ($\\text{OsO}_4$ / NMO):** Forms cyclic osmate ester $\\implies$ **1,2-*Syn*-Diol**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the mechanistic steps of electrophilic halogenation of an alkene with Br2.",
      "orderItems": [
        "The nucleophilic pi-electrons of the alkene attack the polarizable Br-Br bond, expelling bromide (Br⁻)",
        "The electrophilic bromine atom donates a lone pair back to the adjacent carbon to form a cyclic bromonium ion",
        "The bridged 3-membered positively charged bromonium ring completely blocks the top face of the alkene",
        "The free bromide ion attacks the more substituted carbon from the backside (opposite face) via S_N2-like ring opening",
        "Cleavage of the C-Br+ bond yields the racemic anti-1,2-dibromoalkane product with 100% trans-stereospecificity"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each alkene reaction to its stereochemical and regiochemical outcome.",
      "matchPairs": [
        { "left": "Bromination (Br2 in CH2Cl2)", "right": "Anti-addition of two bromine atoms via cyclic bromonium ion intermediate" },
        { "left": "Hydroboration-Oxidation (BH3, H2O2/NaOH)", "right": "Anti-Markovnikov syn-addition of H and OH to the double bond" },
        { "left": "Dihydroxylation with OsO4 / NMO", "right": "Syn-addition of two OH groups to form a 1,2-vicinal syn-diol" },
        { "left": "HBr addition with Peroxides (ROOR, heat)", "right": "Anti-Markovnikov hydrobromination via free radical chain mechanism" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Hydroboration-oxidation of an unsymmetrical alkene yields the ___-Markovnikov alcohol with syn-stereochemistry.",
      "blankAnswer": "anti",
      "blankDistractors": ["zaitsev", "hofmann", "walden"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When cyclohexene is reacted with Br2 in dichloromethane, which stereoisomer is formed?",
      "options": [
        { "text": "Racemic TRANS-1,2-dibromocyclohexane ((1R,2R) and (1S,2S)); because the reaction proceeds through a bridged bromonium ion, the incoming bromide ion must attack from the opposite face, strictly preventing formation of the cis-isomer", "isCorrect": true, "explanation": "Correct! Electrophilic bromination of alkenes is stereospecifically anti. Formation of the 3-membered bromonium ring blocks one face of the ring; the bromide nucleophile is forced to attack from the bottom face (diaxial opening in chair conformation), resulting exclusively in trans-1,2-dibromocyclohexane (as a racemic mixture of (1R,2R) and (1S,2S) enantiomers)." },
        { "text": "Pure cis-1,2-dibromocyclohexane", "isCorrect": false, "explanation": "Incorrect: Cis-addition does not occur in halogenation." },
        { "text": "1,1-Dibromocyclohexane", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Bromocyclohexane (mono-bromination only)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
