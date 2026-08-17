# Duofy Reusable Lesson Format: Nucleophilic Acyl Substitution (Addition-Elimination)

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Reaction_Mechanisms_SN1_SN2_Addition_Elimination`  
**Lesson Format Type:** `nucleophilic_acyl_substitution_addition_elimination`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid mastery of the addition-elimination ($B_{\text{Ac}}2$) pathway across carboxylic acid derivatives: trace the two-step mechanism (**1. Nucleophilic Addition to form $s p^3$ Tetrahedral Intermediate**, **2. Collapse of Tetrahedral Intermediate with Leaving Group Elimination**), rank derivative reactivity based on leaving group basicity / resonance stabilization (**Acid Chloride $>$ Anhydride $>$ Ester $\approx$ Carboxylic Acid $>$ Amide $\gg$ Carboxylate**), evaluate base-catalyzed ester hydrolysis (**Saponification**, irreversible driven by carboxylate resonance stabilization) vs acid-catalyzed **Fischer Esterification** (reversible equilibrium), and interact with live tetrahedral intermediate collapse simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nucleophilic Acyl Substitution & Reactivity Hierarchy Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Carboxylic Acid Derivative & Relative Reactivity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Ester Saponification Irreversibility Driving Force Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Addition-Elimination Key Hybridization State Intermediate Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Tetrahedral Intermediate Addition-Elimination Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nucleophilic_acyl_substitution_addition_elimination",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the mechanism of Nucleophilic Acyl Substitution (Addition-Elimination), and what governs the reactivity hierarchy of carboxylic acid derivatives?",
      "blankAnswer": "Nucleophilic Acyl Substitution (B_Ac2) proceeds via a two-step Addition-Elimination pathway: (1) Addition: Nucleophile attacks the electrophilic carbonyl carbon (sp2 -> sp3), forming a tetrahedral alkoxide intermediate. (2) Elimination: The alkoxide lone pair reforms the strong C=O pi-bond (sp3 -> sp2), expelling the best leaving group (weakest base / lowest pKa of conjugate acid). The fundamental reactivity hierarchy is: Acyl Chloride (R-COCl) > Acid Anhydride (R-CO-O-COR) > Ester (R-COOR') ≈ Carboxylic Acid (R-COOH) > Amide (R-CONH2) >> Carboxylate (R-COO⁻). More reactive derivatives can be converted into any less reactive derivative directly, but the reverse requires activation (e.g. converting carboxylic acids to acyl chlorides with SOCl2 or oxalyl chloride)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each carboxylic acid derivative to its reactivity ranking and leaving group quality.",
      "matchPairs": [
        { "left": "Acyl Chloride (R-COCl)", "right": "Most reactive derivative; chloride (Cl⁻) is a superb, weakly basic leaving group (pKa of HCl = -7)" },
        { "left": "Acid Anhydride (R-CO-O-COR)", "right": "High reactivity; carboxylate (RCOO⁻) is a resonance-stabilized moderate leaving group" },
        { "left": "Aliphatic Ester (R-COOR')", "right": "Moderate reactivity; alkoxide (RO⁻) is a moderately poor leaving group" },
        { "left": "Amide (R-CONH2)", "right": "Least reactive neutral derivative; amide anion (NH2⁻) is a very poor, strongly basic leaving group" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is base-promoted ester hydrolysis (Saponification with aqueous NaOH) completely IRREVERSIBLE, whereas acid-catalyzed Fischer esterification is an equilibrium?",
      "options": [
        { "text": "After hydroxide attacks and alkoxide (RO⁻) is expelled, the strongly basic alkoxide immediately and irreversibly deprotonates the formed carboxylic acid to yield a resonance-stabilized, unreactive carboxylate anion (R-COO⁻), which cannot undergo nucleophilic attack", "isCorrect": true, "explanation": "Correct! In saponification, the immediate product of elimination is a carboxylic acid (RCOOH) and alkoxide base (RO⁻). Because carboxylic acids are acidic (pKa ~ 4.8) and alcohols are weak acids (pKa ~ 16), an irreversible exothermic proton transfer occurs, generating carboxylate (R-COO⁻). The negative charge on carboxylate shields it from nucleophilic attack, making the reaction 100% irreversible." },
        { "text": "Because the ester evaporates from the reaction flask", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hydroxide turns into metallic sodium", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the reaction creates an unbreakable carbon-carbon bond", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In nucleophilic acyl substitution, attack of the nucleophile on the planar carbonyl carbon converts it into an sp3-hybridized ___ intermediate.",
      "blankAnswer": "tetrahedral",
      "blankDistractors": ["trigonal", "linear", "octahedral"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Nucleophilic Acyl Substitution Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Addition-Elimination Acyl Engine</h3><p>Reaction: Acetyl Chloride ($\text{CH}_3\text{COCl}$) $+$ Methanol ($\text{CH}_3\text{OH}$)</p><button id=\"nasBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Execute Nucleophilic Attack & Tetrahedral Collapse</button><div id=\"nasOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('nasBtn').onclick=()=>{document.getElementById('nasOut').innerText='Mechanism Complete: (1) Addition: MeOH attacks carbonyl -> sp3 tetrahedral intermediate forms. (2) Elimination: Alkoxide lone pair reforms C=O pi-bond, expelling Cl⁻ (pKa of HCl = -7, far better leaving group than MeO⁻). (3) Deprotonation yields Methyl Acetate in 99% isolated yield!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
