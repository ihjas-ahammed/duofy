# Duofy Reusable Lesson Format: Cyclohexane Chair Conformations and A-Values

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Organic_Chemistry / Stereochemistry_Chirality_and_Conformations`  
**Lesson Format Type:** `cyclohexane_chair_conformations_and_a_values`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid quantitative mastery of conformational analysis and chair flips in substituted cyclohexanes: draw the **Ideal Chair Conformation** (free of angle strain at $109.5^\circ$ and free of torsional strain with all bonds staggered), differentiate **Axial vs Equatorial Positions** and their inversion during a **Chair Flip**, calculate conformational equilibria using **A-Values (Conformational Free Energies, $\Delta G^\circ = -A\text{-value} = -RT\ln K_{\text{eq}}$)** for 1,3-diaxial steric interactions ($-\text{CH}_3$: $7.3\text{ kJ/mol}$, $-\text{Et}$: $7.5\text{ kJ/mol}$, $-i\text{-Pr}$: $9.2\text{ kJ/mol}$, $-t\text{-Bu}$: $20.0\text{ kJ/mol}$ as a rigid conformational anchor), analyze *cis* vs *trans* 1,2-, 1,3-, and 1,4-disubstituted cyclohexanes, and interact with live chair flip 3D energy simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cyclohexane Chair Conformations & A-Values Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Substituted Cyclohexane Isomer & Most Stable Chair Conformation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Chair Flip Equilibrium Constant from A-Value Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Bulky Conformationally Locking Alkyl Group Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Cyclohexane Chair Flip & 1,3-Diaxial Energy Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cyclohexane_chair_conformations_and_a_values",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are A-Values in cyclohexane conformational analysis, and how do they quantify the equilibrium between chair conformers?",
      "blankAnswer": "The chair conformation of cyclohexane is completely free of angle strain (all C-C-C angles are 109.5°) and torsional strain (all adjacent C-H bonds are perfectly staggered). During a Chair Flip, all axial bonds become equatorial, and all equatorial bonds become axial (while 'up' stays 'up' and 'down' stays 'down'). The A-Value represents the conformational Gibbs Free Energy difference (Delta G° = -A in kJ/mol or kcal/mol) for a substituent preferring the EQUATORIAL position over the AXIAL position, caused by relieving 1,3-diaxial steric clash with axial hydrogens: (1) -CH3: A = 7.3 kJ/mol (1.74 kcal/mol; ~95% equatorial at 298 K). (2) -Et: A = 7.5 kJ/mol. (3) -iPr: A = 9.2 kJ/mol (2.2 kcal/mol). (4) -t-Bu: A = 20.0 kJ/mol (4.9 kcal/mol; >99.99% equatorial; acts as a rigid conformational locking group)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each disubstituted cyclohexane isomer to its most stable chair conformational description.",
      "matchPairs": [
        { "left": "trans-1,2-Dimethylcyclohexane", "right": "Diequatorial conformer (1e, 2e) is vastly favored over diaxial (1a, 2a)" },
        { "left": "cis-1,3-Dimethylcyclohexane", "right": "Diequatorial conformer (1e, 3e) is vastly favored over diaxial (1a, 3a with severe syn-1,3-diaxial clash)" },
        { "left": "trans-1,4-Dimethylcyclohexane", "right": "Diequatorial conformer (1e, 4e) is the dominant ground state" },
        { "left": "cis-1,2-Dimethylcyclohexane", "right": "Equilibrium of two degenerate chair conformers, each with one axial and one equatorial methyl (1a, 2e <-> 1e, 2a)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "For methylcyclohexane at T = 298 K, the A-value for a methyl group is Delta G° = -7.3 kJ/mol (-7300 J/mol) for the axial-to-equatorial transition. Calculate the equilibrium constant K_eq = [equatorial] / [axial] using K_eq = exp(-Delta G° / RT) with R = 8.314 J/(mol K) (round to nearest whole integer).",
      "numericAnswer": 19,
      "numericTolerance": 2
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The tert-___ group has an A-value of ~20 kJ/mol, making it an effective conformational locking group that forces itself 99.99% into the equatorial chair position.",
      "blankAnswer": "butyl",
      "blankDistractors": ["methyl", "ethyl", "propyl"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Cyclohexane Chair Flip & A-Value Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Cyclohexane Conformational Energy Engine</h3><p>Substrate: 1-tert-Butyl-4-methylcyclohexane (trans isomer) | $\\Delta G^\\circ = -12.7\\text{ kJ/mol}$</p><button id=\"cfBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Perform Chair Ring Flip</button><div id=\"cfOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('cfBtn').onclick=()=>{document.getElementById('cfOut').innerText='Chair Flip Evaluated: Chair A (t-Bu equatorial, Me equatorial) has Total Strain = 0.0 kJ/mol. Chair B (t-Bu axial, Me axial) has Total Strain = 20.0 (t-Bu) + 7.3 (Me) = 27.3 kJ/mol! At equilibrium, Chair A accounts for > 99.999% of the molecular population.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
