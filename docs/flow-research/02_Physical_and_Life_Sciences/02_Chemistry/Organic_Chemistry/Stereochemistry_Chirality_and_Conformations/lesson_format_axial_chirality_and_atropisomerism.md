# Duofy Reusable Lesson Format: Axial Chirality and Atropisomerism

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Stereochemistry_Chirality_and_Conformations`  
**Lesson Format Type:** `axial_chirality_and_atropisomerism`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the stereochemistry of non-centrosymmetric molecules exhibiting chirality without asymmetric carbon centers: formulate **Atropisomerism (Richard Kuhn, 1933)** as conformational stereoisomerism arising from **Restricted Rotation around a Single Biaryl Bond** ($\Delta G^\ddagger > 100\text{ kJ/mol}$, $t_{1/2} > 1000\text{ s}$ at room temperature) due to bulky *ortho*-substituents (e.g. $(R)\text{-BINAP}$ and $(S)\text{-BINAP}$, 6,6'-dinitrobiphenyl-2,2'-dicarboxylic acid), master **Axial Chirality in Allenes ($\text{R}_1\text{R}_2\text{C}=\text{C}=\text{CR}_3\text{R}_4$)** with orthogonal $\pi$-systems, and assign **$(R_a)/(S_a)$ or $(P)/(M)$ Helical / Axial Descriptors** using modified CIP viewing rules along the chiral axis.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Axial Chirality & Biaryl Atropisomerism Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step BINAP Axial Configuration (Ra vs Sa) Assignment Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Chiral Motif Class & Classic Molecular Example Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Restricted Rotation Stereoisomerism Term Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Allene Orthogonal Orbital Chirality Requirement Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Non-Centrosymmetric Axial Chirality & Atropisomerism:
   - **Atropisomerism (Axial Chirality in Biaryls):**
     - Conformational stereoisomerism arising when rotation about a formal $\text{C}-\text{C}$ single bond is restricted by steric clash between bulky *ortho*-substituents.
     - **Isolation Criterion (Oki, 1983):** Rotational energy barrier $\Delta G^\ddagger \ge 100\text{ kJ/mol}$ at room temperature, giving a half-life of racemization $t_{1/2} > 1000\text{ seconds}$ (stable, resolvable enantiomers like $\text{BINAP}$ and substituted biphenyls).
   - **Axial Chirality in Allenes ($\text{C}_1=\text{C}_2=\text{C}_3$):**
     - Central $s p$-carbon uses perpendicular $p_y$ and $p_z$ orbitals to form adjacent $\pi$-bonds.
     - The substituents at $\text{C}_1$ and $\text{C}_3$ lie in **perpendicular, mutually orthogonal planes** ($90^\circ$).
     - If $\text{R}_1 \ne \text{R}_2$ on $\text{C}_1$ and $\text{R}_3 \ne \text{R}_4$ on $\text{C}_3$, the allene lacks planes of symmetry and is **chiral**!
   - **Assigning Axial Configuration ($(R_a) / (S_a)$ or $(P) / (M)$):**
     - View the molecule along the chiral bond axis.
     - Front groups take absolute priority over rear groups:
       - Front substituents ranked #1 and #2.
       - Rear substituents ranked #3 and #4.
     - Trace $1 \to 2 \to 3$: Clockwise $\implies (R_a) / (P)$; Counterclockwise $\implies (S_a) / (M)$.
2. **Slide 2 (`ordering`):** Provide 5 steps assigning $(R_a)$ vs $(S_a)$ to a chiral allene ($\text{Me}(\text{H})\text{C}=\text{C}=\text{C}(\text{Me})\text{H}$): (1) view along the linear $\text{C}=\text{C}=\text{C}$ axis from the front carbon ($\text{C}_1$) to the rear carbon ($\text{C}_3$), (2) prioritize the two front substituents using CIP rules: $-\text{CH}_3$ is #1, $-\text{H}$ is #2, (3) prioritize the two rear substituents: $-\text{CH}_3$ is #3, $-\text{H}$ is #4, (4) project all 4 substituents onto a flat disc with front groups vertical and rear groups horizontal, (5) trace the trajectory $1 (\text{front-Me}) \to 2 (\text{front-H}) \to 3 (\text{rear-Me})$: determine whether the circular path is clockwise ($(R_a)$) or counterclockwise ($(S_a)$)!
3. **Slide 3 (`matching`):** Pair 4 chiral systems (BINAP biaryl, Penta-2,3-diene allene, Planar chiral Ferrocene derivative, Helical Helicene) with their specific non-central chirality type (Axial chirality / atropisomerism, Axial chirality from orthogonal $\pi$-systems, Planar chirality, Helical chirality).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that stereoisomerism resulting from restricted rotation around a single bond is called atropisomerism. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on allene chirality requirements: Which of the following allenes is CHIRAL and exists as a pair of resolvable enantiomers? (A. $\text{CH}_2=\text{C}=\text{CH}_2$, B. $\text{CH}_3(\text{H})\text{C}=\text{C}=\text{CH}_2$, C. $\text{CH}_3(\text{H})\text{C}=\text{C}=\text{C}(\text{CH}_3)\text{H}$, D. $(\text{CH}_3)_2\text{C}=\text{C}=\text{C}(\text{CH}_3)_2$). (Option C: $\text{CH}_3(\text{H})\text{C}=\text{C}=\text{C}(\text{CH}_3)\text{H}$ (Penta-2,3-diene); because each terminal $s p^2$ carbon bears two DIFFERENT groups ($-\text{CH}_3 \ne -\text{H}$), the orthogonal planes create a $C_2$-symmetric chiral structure devoid of any internal mirror plane $\sigma$ or inversion center $i$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "axial_chirality_and_atropisomerism",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Axial Chirality and Atropisomerism**\n• **Atropisomerism (Kuhn, 1933):**\n  - Stereoisomerism caused by **restricted rotation around a single bond** (rotational barrier $\\Delta G^\\ddagger > 100\\text{ kJ/mol}$, $t_{1/2} > 1000\\text{ s}$).\n  - Bulky *ortho*-substituents create severe steric clash preventing planar transition states (e.g. $(R)$- and $(S)$-BINAP catalysts in asymmetric synthesis).\n• **Axial Chirality in Allenes ($\\text{R}_1\\text{R}_2\\text{C}=\\text{C}=\\text{CR}_3\\text{R}_4$):**\n  - Central $sp$-carbon forms 2 mutually **perpendicular $\\pi$-bonds** ($90^\\circ$ orthogonal planes).\n  - Chiral if both ends bear two different groups: $\\text{R}_1 \\ne \\text{R}_2$ AND $\\text{R}_3 \\ne \\text{R}_4$.\n• **Assigning Axial Configuration ($(R_a)/(S_a)$):**\n  - View along chiral axis; **Front substituents (1, 2) take absolute priority over Rear substituents (3, 4)**.\n  - Trace $1 \\to 2 \\to 3$: Clockwise $\\implies (R_a)$; Counterclockwise $\\implies (S_a)$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps assigning the axial (Ra)/(Sa) configuration to (2R_a)-penta-2,3-diene.",
      "orderItems": [
        "Align the line of sight directly along the linear C1=C2=C3 allene axis from the front to the back carbon",
        "Rank the two substituents on the FRONT carbon by CIP rules: -CH3 is Priority 1, -H is Priority 2",
        "Rank the two substituents on the REAR carbon by CIP rules: -CH3 is Priority 3, -H is Priority 4",
        "Project the four substituents onto a 2D planar disc with front groups vertical and rear groups horizontal",
        "Trace the circular trajectory 1 -> 2 -> 3: a clockwise circle assigns the (R_a) axial configuration"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each non-centrosymmetric molecule to its specific type of chirality.",
      "matchPairs": [
        { "left": "BINAP (2,2'-bis(diphenylphosphino)-1,1'-binaphthyl)", "right": "Atropisomerism (axial chirality from hindered rotation around biaryl C-C bond)" },
        { "left": "Penta-2,3-diene (Me-CH=C=CH-Me)", "right": "Axial chirality (enantiomerism from perpendicular orthogonal pi systems)" },
        { "left": "[6]Helicene (Benzene rings in corkscrew spiral)", "right": "Helical chirality (inherent screw-sense handedness, P vs M)" },
        { "left": "Planar chiral substituted Ferrocene", "right": "Planar chirality (two non-equivalent faces on sandwich ring)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Conformational stereoisomerism arising from severely restricted rotation around a single bond is called ___.",
      "blankAnswer": "atropisomerism",
      "blankDistractors": ["tautomerism", "mutarotation", "epimerization"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Which of the following substituted allenes is CHIRAL and can be resolved into a pair of stable enantiomers?",
      "options": [
        { "text": "CH3(H)C=C=C(CH3)H (Penta-2,3-diene); because each terminal sp² carbon is bonded to two DIFFERENT groups (methyl ≠ hydrogen), the perpendicular geometry destroys all internal planes of symmetry (sigma) and inversion centers (i), creating a chiral C2-symmetric molecule", "isCorrect": true, "explanation": "Correct! An allene is chiral if and only if neither terminal carbon has two identical groups (i.e. C1 has A ≠ B and C3 has C ≠ D). In penta-2,3-diene, C1 has H and Me, and C3 has H and Me. Because the two ends lie in perpendicular planes (at 90°), the molecule has a C2 axis but lacks any mirror planes (sigma) or inversion centers (i), making it chiral." },
        { "text": "CH2=C=CH2 (Propadiene)", "isCorrect": false, "explanation": "Incorrect: Achiral (two identical hydrogens on each end)." },
        { "text": "CH3(H)C=C=CH2 (Buta-1,2-diene)", "isCorrect": false, "explanation": "Incorrect: Achiral (the CH2 end has two identical hydrogens, giving an internal mirror plane)." },
        { "text": "(CH3)2C=C=C(CH3)2 (Tetramethylallene)", "isCorrect": false, "explanation": "Incorrect: Achiral (two identical methyl groups on each end)." }
      ]
    }
  ]
}
```
