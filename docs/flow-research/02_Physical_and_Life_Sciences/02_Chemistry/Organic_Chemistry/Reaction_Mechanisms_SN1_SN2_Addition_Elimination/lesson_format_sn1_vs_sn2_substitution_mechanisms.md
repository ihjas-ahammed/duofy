# Duofy Reusable Lesson Format: SN1 vs SN2 Substitution Mechanisms

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Reaction_Mechanisms_SN1_SN2_Addition_Elimination`  
**Lesson Format Type:** `sn1_vs_sn2_substitution_mechanisms`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the kinetic, electronic, stereochemical, and solvent distinctions between unimolecular and bimolecular nucleophilic substitution: compare **$\text{S}_{\text{N}}2$ (Bimolecular, concerted, single transition state, rate $= k[\text{R-X}][\text{Nu}^-]$, Walden Inversion of configuration via backside attack into $\sigma_{\text{C}-\text{LG}}^*$ LUMO, substrate order $\text{Me} > 1^\circ > 2^\circ \gg 3^\circ$, favored by polar aprotic solvents like DMF/DMSO)** with **$\text{S}_{\text{N}}1$ (Unimolecular, stepwise, rate $= k[\text{R-X}]$, planar carbocation intermediate, Racemization with partial net inversion, substrate order $3^\circ > 2^\circ \gg 1^\circ/\text{Me}$, favored by polar protic solvents like $\text{H}_2\text{O}/\text{EtOH}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SN1 vs SN2 Kinetic & Stereochemical Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chiral (R)-2-Bromobutane SN2 Inversion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Substitution Factor & Mechanistic Pathway Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | SN2 Concerted Stereochemical Inversion Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Neopentyl Bromide Extreme SN2 Sluggishness Origin Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State $\text{S}_{\text{N}}1$ vs $\text{S}_{\text{N}}2$ Mechanistic Theory (Hughes & Ingold, 1935):
   - **$\text{S}_{\text{N}}2$ (Substitution Nucleophilic Bimolecular):**
     - **Rate Law:** $\text{Rate} = k [\text{Substrate}] [\text{Nu}^-]$ (Second-order).
     - **Mechanism:** One-step concerted backside attack into the $\sigma_{\text{C}-\text{X}}^*$ antibonding orbital.
     - **Stereochemistry:** **$100\%$ Walden Inversion** (umbrella flip at chiral carbon: $(R) \to (S)$).
     - **Substrate Order:** $\text{Methyl} > 1^\circ > 2^\circ \gg 3^\circ$ (tertiary completely unreactive due to steric crowding).
     - **Optimal Solvent:** **Polar Aprotic** ($\text{DMSO}, \text{DMF}, \text{Acetone}, \text{MeCN}$) — does not hydrogen-bond to nucleophile, enhancing its nucleophilicity.
   - **$\text{S}_{\text{N}}1$ (Substitution Nucleophilic Unimolecular):**
     - **Rate Law:** $\text{Rate} = k [\text{Substrate}]$ (First-order; nucleophile concentration has NO effect on rate).
     - **Mechanism:** Two-step stepwise; rate-determining loss of leaving group to form a planar $s p^2$ carbocation.
     - **Stereochemistry:** **Racemization** (attack from top and bottom faces equally; slight excess inversion from intimate ion pairing).
     - **Substrate Order:** $3^\circ > 2^\circ \gg 1^\circ / \text{Methyl}$ (governed by carbocation stability via hyperconjugation).
     - **Optimal Solvent:** **Polar Protic** ($\text{H}_2\text{O}, \text{MeOH}, \text{EtOH}$) — stabilizes both the carbocation and the leaving group anion.
2. **Slide 2 (`ordering`):** Provide 5 steps of the $\text{S}_{\text{N}}2$ reaction of $(R)$-2-bromobutane with sodium cyanide ($\text{NaCN}$) in DMF: (1) nucleophilic cyanide anion ($^-\text{C}\equiv\text{N}$) approaches the chiral secondary carbon from the trajectory directly opposite the $\text{C}-\text{Br}$ bond ($180^\circ$ backside attack), (2) cyanide lone pair donates into the empty $\sigma_{\text{C}-\text{Br}}^*$ antibonding orbital, (3) reach the pentacoordinate trigonal bipyramidal transition state with partial $\text{C}\cdots\text{CN}$ bond formation and partial $\text{C}\cdots\text{Br}$ bond cleavage, (4) bromide leaving group ($\text{Br}^-$) departs as the three non-reacting substituents flip through the plane like an umbrella in a gale, (5) isolate pure $(S)$-2-methylbutanenitrile with complete $100\%$ inversion of stereochemistry!
3. **Slide 3 (`matching`):** Pair 4 reaction conditions ($1^\circ$ alkyl bromide $+$ $\text{NaN}_3$ in DMSO, $3^\circ$ alkyl chloride $+$ $\text{H}_2\text{O}$ in acetone, $(S)$-2-iodooctane $+$ $\text{NaSMe}$, $t$-butyl bromide $+$ $\text{MeOH}$) with their mechanism and stereochemical outcome.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the complete inversion of stereochemistry at a chiral center during an SN2 reaction is called a Walden inversion. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the extreme unreactivity of neopentyl halides in $\text{S}_{\text{N}}2$: Why is neopentyl bromide ($(\text{CH}_3)_3\text{C}-\text{CH}_2\text{Br}$, a primary alkyl halide) over $100,000$ times slower in $\text{S}_{\text{N}}2$ substitution reactions than ethyl bromide ($\text{CH}_3\text{CH}_2\text{Br}$), despite both being primary substrates? (Because the bulky $t$-butyl group attached directly to the $\beta$-carbon projects methyl groups that **severely sterically shield the backside trajectory of the $\sigma_{\text{C}-\text{Br}}^*$ orbital**, physically preventing the nucleophile from attacking the $\alpha$-carbon).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sn1_vs_sn2_substitution_mechanisms",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: S_N1 vs S_N2 Nucleophilic Substitution**\n• **S_N2 (Bimolecular Concerted):**\n  - **Rate Law:** $\\text{Rate} = k [\\text{Substrate}][\\text{Nu}^-]$\n  - **Mechanism:** 1-step backside attack into $\\sigma_{\\text{C}-\\text{LG}}^*$.\n  - **Stereochemistry:** **$100\\%$ Walden Inversion** ($(R) \\to (S)$).\n  - **Substrate Hierarchy:** $\\text{Methyl} > 1^\\circ > 2^\\circ \\gg 3^\\circ$ (Sterics dominate!).\n  - **Solvent:** **Polar Aprotic** (DMSO, DMF, Acetone, MeCN).\n• **S_N1 (Unimolecular Stepwise):**\n  - **Rate Law:** $\\text{Rate} = k [\\text{Substrate}]$\n  - **Mechanism:** 2-step; rate-limiting carbocation formation.\n  - **Stereochemistry:** **Racemization** (planar $sp^2$ carbocation).\n  - **Substrate Hierarchy:** $3^\\circ > 2^\\circ \\gg 1^\\circ$ (Hyperconjugation dominates!).\n  - **Solvent:** **Polar Protic** ($\\text{H}_2\\text{O}, \\text{MeOH}, \\text{EtOH}$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps of S_N2 substitution on (R)-2-bromobutane with sodium cyanide in DMF.",
      "orderItems": [
        "Cyanide anion (NC⁻) approaches the chiral carbon from the 180° backside trajectory opposite the C-Br bond",
        "Cyanide lone pair electron density overlaps directly with the empty C-Br sigma* antibonding orbital",
        "Pass through the pentacoordinate trigonal bipyramidal transition state with partial C-CN and C-Br bonds",
        "Bromide ion departs with the bonding pair as the three non-reacting substituents flip through the plane",
        "Isolate (S)-2-methylbutanenitrile exhibiting complete 100% Walden inversion of stereochemical configuration"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each reaction condition to its mechanistic pathway and stereochemical outcome.",
      "matchPairs": [
        { "left": "1-Bromobutane + NaI in Acetone (Finkelstein)", "right": "S_N2 pathway; rapid bimolecular displacement in polar aprotic solvent" },
        { "left": "(R)-2-Bromooctane + NaSCH3 in DMF", "right": "S_N2 pathway; yields (S)-product with complete stereochemical inversion" },
        { "left": "tert-Butyl bromide + H2O / Heat (Solvolysis)", "right": "S_N1 pathway; carbocation intermediate yielding tert-butanol" },
        { "left": "Chiral 3° alkyl halide + EtOH", "right": "S_N1 pathway; planar carbocation intermediate yields racemic mixture" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The complete stereochemical inversion of configuration at a chiral center during an S_N2 reaction is termed a ___ inversion.",
      "blankAnswer": "walden",
      "blankDistractors": ["hofmann", "zaitsev", "markovnikov"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is neopentyl bromide ((CH3)3C-CH2Br, a 1° alkyl halide) over 100,000 times SLOWER in S_N2 substitution than ethyl bromide (CH3CH2Br)?",
      "options": [
        { "text": "Steric hindrance from the beta-carbon: The three bulky methyl groups of the tert-butyl group create severe steric congestion that physically blocks the backside attack trajectory of the nucleophile into the sigma* orbital of the alpha-carbon", "isCorrect": true, "explanation": "Correct! Even though neopentyl bromide is a primary alkyl halide (the C-Br carbon is attached to only one carbon), that attached beta-carbon is quaternary (tert-butyl). The three bulky methyl groups create massive steric hindrance around the backside of the C-Br bond, making nucleophilic approach in the transition state virtually impossible." },
        { "text": "Because neopentyl bromide is an aromatic molecule", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the C-Br bond in neopentyl bromide is ionic", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because bromide cannot leave from a neopentyl system", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
