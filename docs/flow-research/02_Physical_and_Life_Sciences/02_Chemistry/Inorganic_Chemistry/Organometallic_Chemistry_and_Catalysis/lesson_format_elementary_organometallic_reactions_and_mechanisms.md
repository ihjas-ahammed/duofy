# Duofy Reusable Lesson Format: Elementary Organometallic Reactions and Mechanisms

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Organometallic_Chemistry_and_Catalysis`  
**Lesson Format Type:** `elementary_organometallic_reactions_and_mechanisms`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fundamental elementary reaction steps of homogeneous organotransition metal catalysis: contrast **Oxidative Addition ($\Delta\text{OS} = +2, \Delta e^- = +2, \Delta\text{CN} = +2$)** with **Reductive Elimination ($\Delta\text{OS} = -2, \Delta e^- = -2, \Delta\text{CN} = -2$)**, analyze **Migratory Insertion (1,1-CO insertion vs 1,2-alkene insertion, $\Delta\text{OS} = 0, \Delta e^- = -2$, generates open coordination site $\square$)**, evaluate **$\beta$-Hydride Elimination** (requires coplanar $\text{M}-\text{C}_\alpha-\text{C}_\beta-\text{H}$ geometry and adjacent vacant site), and track formal electron counts and oxidation states throughout reaction steps.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Elementary Organometallic Reaction Mechanisms Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Migratory Insertion & CO Coordination Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Elementary Step & Parameter Changes Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Stereochemical Requirement for Reductive Elimination Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Beta-Hydride Elimination Geometric and Electronic Requirements Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 4 Core Elementary Organometallic Reaction Steps:
   - **1. Oxidative Addition:**
     $$\text{L}_n\text{M}^m + \text{X}-\text{Y} \longrightarrow \text{L}_n\text{M}^{m+2}(\text{X})(\text{Y}) \qquad (\Delta\text{OS} = +2, \ \Delta e^- = +2, \ \Delta\text{CN} = +2)$$
     - Favored by electron-rich, low-valent metals with open coordination sites ($\text{Pd}^0, \text{Rh}^{\text{I}}, \text{Ir}^{\text{I}}$).
   - **2. Reductive Elimination:**
     $$\text{L}_n\text{M}^{m+2}(\text{X})(\text{Y}) \longrightarrow \text{L}_n\text{M}^m + \text{X}-\text{Y} \qquad (\Delta\text{OS} = -2, \ \Delta e^- = -2, \ \Delta\text{CN} = -2)$$
     - **Strict Stereochemical Rule:** Eliminating ligands $\text{X}$ and $\text{Y}$ **MUST BE MUTUALLY *CIS***! Favored by electron-deficient metals and bulky phosphine ligands.
   - **3. Migratory Insertion:**
     - **1,1-Insertion (Carbonyl):** $\text{M}(\text{CO})(\text{R}) \longrightarrow \text{M}(\text{COR})(\square)$ ($\Delta\text{OS} = 0, \Delta e^- = -2$, creates empty site $\square$).
     - **1,2-Insertion (Alkene):** $\text{M}(\eta^2-\text{CH}_2=\text{CH}_2)(\text{R}) \longrightarrow \text{M}-\text{CH}_2\text{CH}_2\text{R}(\square)$.
   - **4. $\beta$-Hydride Elimination:**
     $$\text{M}-\text{CH}_2\text{CH}_2\text{R} \longrightarrow \text{M}(\text{H})(\eta^2-\text{CH}_2=\text{CHR}) \qquad (\Delta\text{OS} = 0, \ \Delta e^- = +2)$$
     - Requires a $\beta$-hydrogen, coplanar $\text{M}-\text{C}_\alpha-\text{C}_\beta-\text{H}$ dihedral angle ($0^\circ$), and an **adjacent vacant coordination site**.
2. **Slide 2 (`ordering`):** Provide 5 steps of carbonyl migratory insertion followed by trapping: (1) start with an 18-electron octahedral complex $[\text{CH}_3-\text{Mn}(\text{CO})_5]$, (2) methyl group migrates intramolecularly onto an adjacent *cis* carbonyl ligand, (3) form a 16-electron acyl complex $[\text{CH}_3\text{C}(=\text{O})-\text{Mn}(\text{CO})_4(\square)]$ containing a vacant coordination site, (4) incoming external phosphine ligand ($\text{PPh}_3$) traps the vacant site, (5) yield the stable 18-electron substituted acyl product $[\text{CH}_3\text{C}(=\text{O})-\text{Mn}(\text{CO})_4(\text{PPh}_3)]$!
3. **Slide 3 (`matching`):** Pair 4 elementary steps (Oxidative Addition, Reductive Elimination, Migratory Insertion, $\beta$-Hydride Elimination) with their changes in metal oxidation state and electron count.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that reductive elimination strictly requires the two eliminating ligands to be mutually cis to each other. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on preventing $\beta$-hydride elimination: Why are transition metal alkyl complexes containing neopentyl ($-\text{CH}_2\text{C}(\text{CH}_3)_3$) or benzyl ($-\text{CH}_2\text{Ph}$) ligands dramatically more stable against thermal decomposition than ethyl ($-\text{CH}_2\text{CH}_3$) or butyl alkyls? (Because neopentyl and benzyl ligands have **ZERO hydrogens on the $\beta$-carbon** ($\beta$-H absent), making $\beta$-hydride elimination chemically impossible).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "elementary_organometallic_reactions_and_mechanisms",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Elementary Organometallic Reactions and Mechanisms**\n• **1. Oxidative Addition:**\n$$\n\\text{L}_n\\text{M}^m + \\text{X}-\\text{Y} \\longrightarrow \\text{L}_n\\text{M}^{m+2}(\\text{X})(\\text{Y}) \\qquad (\\Delta\\text{OS} = +2, \\ \\Delta e^- = +2, \\ \\Delta\\text{CN} = +2)\n$$\n• **2. Reductive Elimination (The Reverse Step):**\n$$\n\\text{L}_n\\text{M}^{m+2}(\\text{X})(\\text{Y}) \\longrightarrow \\text{L}_n\\text{M}^m + \\text{X}-\\text{Y} \\qquad (\\Delta\\text{OS} = -2, \\ \\Delta e^- = -2, \\ \\Delta\\text{CN} = -2)\n$$\n  *(Strict Rule: Eliminating groups **MUST BE MUTUALLY CIS**!).*\n• **3. Migratory Insertion (1,1-CO or 1,2-Alkene):**\n$$\n\\text{M}(\\text{CO})(\\text{R}) \\longrightarrow \\text{M}(\\text{COR})(\\square) \\qquad (\\Delta\\text{OS} = 0, \\ \\Delta e^- = -2, \\text{ generates open site } \\square)\n$$\n• **4. $\\beta$-Hydride Elimination:**\n$$\n\\text{M}-\\text{CH}_2\\text{CH}_2\\text{R} \\longrightarrow \\text{M}(\\text{H})(\\eta^2\\text{-alkene}) \\qquad (\\text{Requires } \\beta\\text{-H and open site } \\square).\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the reaction steps of carbonyl migratory insertion and ligand trapping in [CH3-Mn(CO)5].",
      "orderItems": [
        "Begin with the saturated 18-electron octahedral complex [CH_3-Mn(CO)_5]",
        "The methyl group migrates intramolecularly onto a mutually cis carbonyl ligand",
        "Generate a coordinatively unsaturated 16-electron acetyl intermediate [CH_3CO-Mn(CO)_4(open site)]",
        "An external Lewis base ligand (PPh_3) attacks and coordinates to the vacant coordination site",
        "Isolate the final stable 18-electron acyl substitution complex [CH_3CO-Mn(CO)_4(PPh_3)]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each elementary organometallic reaction step to its exact parameter changes.",
      "matchPairs": [
        { "left": "Oxidative Addition", "right": "Oxidation state +2, Electron count +2, Coordination number +2" },
        { "left": "Reductive Elimination", "right": "Oxidation state -2, Electron count -2, Coordination number -2" },
        { "left": "Migratory Insertion (1,1 or 1,2)", "right": "Oxidation state UNCHANGED (0), Electron count -2, Creates vacant site" },
        { "left": "Beta-Hydride Elimination", "right": "Oxidation state UNCHANGED (0), Electron count +2, Cleaves M-C to form M-H + alkene" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In organometallic catalysis, two ligands can undergo concerted reductive elimination only if they are positioned mutually ___ to each other.",
      "blankAnswer": "cis",
      "blankDistractors": ["trans", "orthogonal", "axial"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why are transition metal neopentyl complexes (M-CH2-C(CH3)3) and benzyl complexes (M-CH2-Ph) exceptionally thermally stable compared to ethyl complexes (M-CH2-CH3)?",
      "options": [
        { "text": "Neopentyl and benzyl ligands possess ZERO hydrogens on the beta-carbon (beta-H is absent); this completely blocks the low-energy beta-hydride elimination decomposition pathway, rendering the metal-carbon bond thermally robust", "isCorrect": true, "explanation": "Correct! Beta-hydride elimination is the primary thermal decomposition pathway for transition metal alkyls. In ethyl ligands (-CH2-CH3), the beta-carbon has 3 hydrogens and easily undergoes beta-elimination to yield M-H + ethylene. In neopentyl (-CH2-C(CH3)3), the beta-carbon is bonded to 3 methyl carbons and has zero hydrogens, making beta-elimination geometrically impossible." },
        { "text": "Because neopentyl is an alkali metal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because benzyl complexes have no carbon atoms", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because neopentyl complexes have 30 valence electrons", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
