# Duofy Reusable Lesson Format: Cahn-Ingold-Prelog Rules and R/S Assignment

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Stereochemistry_Chirality_and_Conformations`  
**Lesson Format Type:** `cahn_ingold_prelog_rules_and_r_s_assignment`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the rigorous application of the Cahn-Ingold-Prelog (CIP) priority rules for absolute stereochemical configuration: rank substituents by **Atomic Number**, execute **Chain Walking** at first point of difference, handle **Multiple Bonds as Phantom / Duplicate Dummy Atoms** (e.g. $-\text{CH}=\text{O} \to (\text{O}, \text{O}, \text{H})$ and $-\text{C}\equiv\text{N} \to (\text{N}, \text{N}, \text{N})$), orient lowest-priority group (#4) to project into the rear, and assign **$(R)$ (Rectus, Clockwise)** vs **$(S)$ (Sinister, Counterclockwise)** configurations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CIP Priority Rules & Absolute R/S Assignment Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Glyceraldehyde Chiral Assignment Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Functional Group & CIP Priority Ranking Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Clockwise Priority Path Absolute Configuration Descriptor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Multiple Bond Phantom Atom CIP Tie-Breaker Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Cahn-Ingold-Prelog (CIP) Priority System (1966):
   - **Rule 1 (Atomic Number):** Higher atomic number takes precedence:
     $$-\text{I}\ (53) > -\text{Br}\ (35) > -\text{Cl}\ (17) > -\text{SO}_3\text{H}\ (16) > -\text{F}\ (9) > -\text{OH}\ (8) > -\text{NH}_2\ (7) > -\text{CH}_3\ (6) > -\text{H}\ (1)$$
   - **Rule 2 (Chain Walking):** If directly attached atoms are identical (e.g. carbon vs carbon), compare the atoms attached to them in decreasing atomic number order until the **first point of difference**:
     $$-\text{CH}_2\text{OH}\ (\text{O}, \text{H}, \text{H}) > -\text{CH}_2\text{CH}_3\ (\text{C}, \text{H}, \text{H}) > -\text{CH}_3\ (\text{H}, \text{H}, \text{H})$$
   - **Rule 3 (Multiple Bonds):** Treat double and triple bonds as duplicate/triplicate bonds to virtual phantom atoms:
     - $-\text{CHO}$ (aldehyde) $\implies$ Carbon bonded to $(\text{O}, \text{O}, \text{H})$.
     - $-\text{COOH}$ (acid) $\implies$ Carbon bonded to $(\text{O}, \text{O}, \text{O})$.
     - $-\text{C}\equiv\text{CH}$ (alkyne) $\implies$ Carbon bonded to $(\text{C}, \text{C}, \text{C})$.
   - **Assignment of Configuration:**
     - Position the lowest priority group (#4) pointing **away from the viewer** (dashed bond).
     - Trace trajectory from priority $1 \to 2 \to 3$:
       - **Clockwise $\implies (R)$ (Rectus)**
       - **Counterclockwise $\implies (S)$ (Sinister)**
2. **Slide 2 (`ordering`):** Provide 5 steps assigning $(R)$ vs $(S)$ to (D)-glyceraldehyde ($\text{H}-\text{C}(\text{OH})(\text{CHO})-\text{CH}_2\text{OH}$): (1) identify the chiral center at carbon-2, (2) assign priority 1 to $-\text{OH}$ (oxygen, atomic number 8) and priority 4 to $-\text{H}$ (hydrogen, atomic number 1), (3) compare $-\text{CHO}$ $(\text{O}, \text{O}, \text{H})$ with $-\text{CH}_2\text{OH}$ $(\text{O}, \text{H}, \text{H})$; first point of difference gives $-\text{CHO}$ priority 2 and $-\text{CH}_2\text{OH}$ priority 3, (4) view along the $\text{C}-\text{H}$ bond with group #4 in the rear, (5) trace path $1 (-\text{OH}) \to 2 (-\text{CHO}) \to 3 (-\text{CH}_2\text{OH})$ which proceeds in a clockwise circle, confirming the $(R)$-configuration!
3. **Slide 3 (`matching`):** Pair 4 common organic groups ($-\text{COOH}$, $-\text{CHO}$, $-\text{CH}_2\text{OH}$, $-\text{CH}_3$) with their CIP phantom-atom representations and priorities.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that if tracing priority from 1 to 2 to 3 follows a clockwise path with group 4 in the rear, the configuration is assigned as R. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on CIP tie-breaking: Which group has higher CIP priority: an isopropyl group ($-\text{CH}(\text{CH}_3)_2$) or a vinyl group ($-\text{CH}=\text{CH}_2$)? (The **vinyl group ($-\text{CH}=\text{CH}_2$) has higher priority**; because the double bond is treated as two single bonds to carbon, the vinyl carbon is bonded to $(\text{C}, \text{C}, \text{C})$ [including the duplicate phantom carbon], whereas the isopropyl carbon is bonded to $(\text{C}, \text{C}, \text{H})$, giving vinyl the winning tie-breaker at the third atom).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cahn_ingold_prelog_rules_and_r_s_assignment",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Cahn-Ingold-Prelog (CIP) Priority System**\n• **Rule 1 (Atomic Number):** Highest atomic number $Z$ gets priority 1:\n$$\n-\\text{I} (53) > -\\text{Br} (35) > -\\text{Cl} (17) > -\\text{OH} (8) > -\\text{NH}_2 (7) > -\\text{CH}_3 (6) > -\\text{H} (1)\n$$\n• **Rule 2 (Chain Walking):** Compare atoms attached to tie atom in descending atomic number until first point of difference.\n• **Rule 3 (Multiple Bonds):** Replicate as duplicate single bonds to phantom atoms:\n  - $-\\text{CHO} \\implies (\\text{O}, \\text{O}, \\text{H})$\n  - $-\\text{COOH} \\implies (\\text{O}, \\text{O}, \\text{O})$\n  - $-\\text{C}\\equiv\\text{CH} \\implies (\\text{C}, \\text{C}, \\text{C})$\n• **Assigning Absolute Configuration:** Place group #4 in rear (dash). Trace $1 \\to 2 \\to 3$:\n  - **Clockwise $\\longrightarrow (R)$ (Rectus)**\n  - **Counterclockwise $\\longrightarrow (S)$ (Sinister)**"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps assigning the absolute (R)/(S) configuration to D-glyceraldehyde.",
      "orderItems": [
        "Identify carbon-2 as the chiral stereocenter bearing four different groups: -OH, -CHO, -CH_2OH, -H",
        "Assign Priority 1 to -OH (Oxygen Z=8) and Priority 4 to -H (Hydrogen Z=1)",
        "Apply Rule 3 to compare -CHO (O,O,H) against -CH_2OH (O,H,H) to assign Priority 2 to -CHO and Priority 3 to -CH_2OH",
        "Orient the molecular model so that lowest-priority group #4 (-H) points directly into the page (dashed)",
        "Trace the trajectory 1 (-OH) -> 2 (-CHO) -> 3 (-CH_2OH): the clockwise circle confirms the (R) configuration"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each carbon-based functional group to its CIP phantom-atom ranking set.",
      "matchPairs": [
        { "left": "Carboxylic Acid (-COOH)", "right": "(O, O, O) [highest priority carbonyl carbon]" },
        { "left": "Aldehyde (-CHO)", "right": "(O, O, H) [double bond to oxygen duplicates oxygen]" },
        { "left": "Hydroxymethyl (-CH_2OH)", "right": "(O, H, H) [single bond to oxygen]" },
        { "left": "Vinyl Alkene (-CH=CH_2)", "right": "(C, C, C) [double bond duplicates carbon atom]" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When viewing a stereocenter with priority group 4 in the rear, a clockwise 1 -> 2 -> 3 circle defines the (___) absolute configuration.",
      "blankAnswer": "r",
      "blankDistractors": ["s", "e", "z"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Which substituent has HIGHER priority under the Cahn-Ingold-Prelog (CIP) rules: an isopropyl group (-CH(CH3)2) or a vinyl group (-CH=CH2)?",
      "options": [
        { "text": "The VINYL group (-CH=CH2); the C=C double bond is treated as two single bonds to carbon, making the vinyl carbon bonded to (C, C, C) [including the phantom duplicate carbon], whereas the isopropyl carbon is bonded to (C, C, H), giving vinyl the winning tie-breaker", "isCorrect": true, "explanation": "Correct! In CIP rules, double bonds are expanded by adding phantom atoms. The vinyl carbon (-CH=CH2) is bonded to 1 real carbon, 1 duplicate carbon, and 1 real hydrogen; plus the second carbon is treated as bonded back to carbon, making the list of attached atoms (C, C, C). The isopropyl carbon (-CH(CH3)2) is bonded to 2 real carbons and 1 real hydrogen, making its list (C, C, H). Comparing the third atom in the list (C vs H), carbon wins, so vinyl has higher priority." },
        { "text": "The isopropyl group because it has 6 hydrogens", "isCorrect": false, "explanation": "Incorrect: Hydrogen count is irrelevant; highest atomic number at point of difference governs." },
        { "text": "Both have identical priority", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Priority depends on the temperature", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
