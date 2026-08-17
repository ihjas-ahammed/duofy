# Duofy Reusable Lesson Format: Wilkinson's Catalyst and Alkene Hydrogenation

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Organometallic_Chemistry_and_Catalysis`  
**Lesson Format Type:** `wilkinsons_catalyst_and_alkene_hydrogenation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the homogeneous catalytic hydrogenation of alkenes using **Wilkinson's Catalyst (Sir Geoffrey Wilkinson, Nobel Prize 1973)**: formulate the structure and electron count of chlorotris(triphenylphosphine)rhodium(I) ($[\text{RhCl}(\text{PPh}_3)_3]$, $16e^-, d^8$, square planar), trace the complete catalytic cycle (phosphorus ligand dissociation to $14e^-$, concerted **Oxidative Addition of $\text{H}_2$** to $16e^-$ dihydride $\text{Rh}^{\text{III}}$, alkene $\eta^2$-coordination to $18e^-$, **1,2-Migratory Insertion** to $16e^-$ alkyl-hydride, and **Reductive Elimination of Alkane** to regenerate the catalyst), and evaluate steric selectivity (terminal unhindered alkenes hydrogenated vastly faster than internal/tetrasubstituted alkenes).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Wilkinson's Complex & Catalytic Hydrogenation Cycle Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Wilkinson Hydrogenation Catalytic Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Catalytic Intermediate & Electron / Oxidation State Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Wilkinson Catalyst Central Transition Metal Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Steric Substrate Selectivity Hierarchy in Wilkinson Hydrogenation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Wilkinson's Catalyst & The Hydrogenation Cycle:
   - **Wilkinson's Catalyst (1965):**
     $$[\text{RhCl}(\text{PPh}_3)_3] \qquad (\text{Rhodium(I)}, \ d^8, \text{ Square Planar, } 16\text{ Valence Electrons})$$
   - **The Catalytic Cycle Steps:**
     1. **Pre-Equilibrium Dissociation:** $[\text{RhCl}(\text{PPh}_3)_3] \rightleftharpoons [\text{RhCl}(\text{PPh}_3)_2] + \text{PPh}_3$ ($16e^- \to 14e^-$, generates open site).
     2. **Oxidative Addition of $\text{H}_2$:** $[\text{RhCl}(\text{PPh}_3)_2] + \text{H}_2 \longrightarrow [\text{RhCl}(\text{H})_2(\text{PPh}_3)_2]$ ($14e^- \to 16e^-$, $\text{Rh}^{\text{I}} \to \text{Rh}^{\text{III}}$, *cis*-dihydride).
     3. **Alkene Coordination:** Alkene binds to open site $\longrightarrow [\text{RhCl}(\text{H})_2(\text{alkene})(\text{PPh}_3)_2]$ ($16e^- \to 18e^-$).
     4. **1,2-Migratory Insertion:** Hydride migrates onto alkene $\longrightarrow [\text{RhCl}(\text{H})(\text{alkyl})(\text{PPh}_3)_2]$ ($18e^- \to 16e^-$, creates open site).
     5. **Reductive Elimination:** Alkyl and remaining hydride eliminate *cis* $\longrightarrow \text{Alkane product} + [\text{RhCl}(\text{PPh}_3)_2]$ ($16e^- \to 14e^-$, $\text{Rh}^{\text{III}} \to \text{Rh}^{\text{I}}$).
   - **Steric Selectivity:** Terminal alkenes ($-\text{CH}=\text{CH}_2$) $\gg$ internal disubstituted $>$ trisubstituted $\gg$ tetrasubstituted (unreactive).
2. **Slide 2 (`ordering`):** Provide 5 steps of the Wilkinson hydrogenation catalytic cycle: (1) $[\text{RhCl}(\text{PPh}_3)_3]$ undergoes phosphine dissociation to generate the active 14-electron species $[\text{RhCl}(\text{PPh}_3)_2]$, (2) concerted oxidative addition of $\text{H}_2$ forms the 16-electron *cis*-dihydride $[\text{RhCl}(\text{H})_2(\text{PPh}_3)_2]$ with $\text{Rh}^{\text{III}}$, (3) alkene coordinates to the vacant site to produce the 18-electron intermediate $[\text{RhCl}(\text{H})_2(\text{alkene})(\text{PPh}_3)_2]$, (4) 1,2-migratory insertion of the alkene into an adjacent $\text{Rh}-\text{H}$ bond yields a 16-electron rhodium-alkyl hydride, (5) concerted reductive elimination releases the saturated alkane and regenerates the 14-electron rhodium(I) catalyst!
3. **Slide 3 (`matching`):** Pair 4 Wilkinson cycle intermediates ($[\text{RhCl}(\text{PPh}_3)_3]$, Active catalyst $[\text{RhCl}(\text{PPh}_3)_2]$, Dihydride intermediate $[\text{RhCl}(\text{H})_2(\text{PPh}_3)_2]$, Alkene-coordinated complex) with their electron counts and oxidation states ($16e^- \ \text{Rh}^{\text{I}}$, $14e^- \ \text{Rh}^{\text{I}}$, $16e^- \ \text{Rh}^{\text{III}}$, $18e^- \ \text{Rh}^{\text{III}}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the central transition metal in Wilkinson's catalyst is rhodium. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on substrate steric selectivity: A synthetic chemist has a steroid containing both an unhindered terminal alkene ($\text{R}-\text{CH}=\text{CH}_2$) and a tetrasubstituted internal alkene ($\text{R}_2\text{C}=\text{CR}_2$). When treated with 1 equivalent of $\text{H}_2$ and Wilkinson's catalyst, which alkene is selectively hydrogenated? (The **terminal alkene ($\text{R}-\text{CH}=\text{CH}_2$) is hydrogenated exclusively**, because bulky $\text{PPh}_3$ ligands around rhodium sterically prevent bulky tetrasubstituted alkenes from coordinating to the metal center).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "wilkinsons_catalyst_and_alkene_hydrogenation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Wilkinson's Catalyst and Alkene Hydrogenation**\n• **Wilkinson's Catalyst (1965):**\n$$\n[\\text{RhCl}(\\text{PPh}_3)_3] \\qquad (\\text{Rhodium(I)}, \\ d^8, \\text{ Square Planar, } 16e^-)\n$$\n• **The 5-Step Catalytic Hydrogenation Cycle:**\n  1. **Ligand Dissociation:** $[\\text{RhCl}(\\text{PPh}_3)_3] \\rightleftharpoons [\\text{RhCl}(\\text{PPh}_3)_2] + \\text{PPh}_3$ ($16e^- \\to 14e^-$, opens coordination site).\n  2. **Oxidative Addition of $\\text{H}_2$:** Generates *cis*-dihydride $[\\text{RhCl}(\\text{H})_2(\\text{PPh}_3)_2]$ ($14e^- \\to 16e^-$, $\\text{Rh}^{\\text{I}} \\to \\text{Rh}^{\\text{III}}$).\n  3. **Alkene $\\pi$-Coordination:** Alkene binds to open site ($16e^- \\to 18e^-$).\n  4. **1,2-Migratory Insertion:** Hydride migrates onto alkene $\\to$ Alkyl-hydride ($18e^- \\to 16e^-$).\n  5. **Reductive Elimination:** Alkane eliminates $\\to$ releases product and regenerates $14e^-$ catalyst.\n• **Steric Selectivity:** Terminal ($-\\text{CH}=\\text{CH}_2$) $\\gg$ Internal $>$ Trisubstituted $\\gg$ Tetrasubstituted (unreactive)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the chemical steps of the catalytic cycle of Wilkinson's catalyst during alkene hydrogenation.",
      "orderItems": [
        "Wilkinson's catalyst [RhCl(PPh_3)_3] (16e⁻) dissociates one PPh_3 ligand to generate the active 14e⁻ species [RhCl(PPh_3)_2]",
        "Concerted oxidative addition of H_2 forms the 16e⁻ cis-dihydride complex [RhCl(H)_2(PPh_3)_2] (Rh(I) -> Rh(III))",
        "The alkene substrate coordinates to the vacant site to produce the 18e⁻ intermediate [RhCl(H)_2(alkene)(PPh_3)_2]",
        "1,2-Migratory insertion of the alkene into an adjacent Rh-H bond yields the 16e⁻ rhodium-alkyl hydride intermediate",
        "Concerted reductive elimination expels the saturated alkane product and regenerates the 14e⁻ Rh(I) catalyst"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Wilkinson hydrogenation intermediate to its electron count and rhodium oxidation state.",
      "matchPairs": [
        { "left": "Wilkinson's Complex [RhCl(PPh_3)_3]", "right": "16 valence electrons, Rh(I) (d8 square planar resting state)" },
        { "left": "Active Catalyst [RhCl(PPh_3)_2]", "right": "14 valence electrons, Rh(I) (coordinatively unsaturated T-shaped species)" },
        { "left": "cis-Dihydride [RhCl(H)_2(PPh_3)_2]", "right": "16 valence electrons, Rh(III) (formed by oxidative addition of H2)" },
        { "left": "Alkene Complex [RhCl(H)_2(alkene)(PPh_3)_2]", "right": "18 valence electrons, Rh(III) (fully saturated coordination sphere)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The central transition metal in Wilkinson's homogeneous hydrogenation catalyst is ___.",
      "blankAnswer": "rhodium",
      "blankDistractors": ["palladium", "platinum", "ruthenium"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When a molecule containing both a terminal alkene (R-CH=CH2) and a tetrasubstituted internal alkene (R2C=CR2) is reacted with 1 eq H2 and Wilkinson's catalyst, which alkene reacts?",
      "options": [
        { "text": "The TERMINAL ALKENE is hydrogenated with near 100% chemoselectivity; because bulky PPh3 ligands surround the Rh center, bulky tetrasubstituted alkenes are sterically prevented from coordinating to the metal, whereas unhindered terminal alkenes bind and react rapidly", "isCorrect": true, "explanation": "Correct! Wilkinson's catalyst is famous for exquisite steric discrimination. Coordination of the alkene is the key rate-determining step. Due to the high steric bulk of the two triphenylphosphine ligands, terminal and monosubstituted alkenes coordinate and react easily, while tetrasubstituted alkenes are essentially unreactive." },
        { "text": "The tetrasubstituted alkene reacts first because it is more electron-rich", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both alkenes react at identical rates", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Neither alkene reacts (the catalyst is poisoned by double bonds)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
