# Duofy Reusable Lesson Format: Frontier Molecular Orbitals and Woodward-Hoffmann Rules

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Quantum_Chemistry_and_Molecular_Orbital_Theory`  
**Lesson Format Type:** `frontier_molecular_orbitals_and_woodward_hoffmann_rules`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantum symmetry principles governing pericyclic reactions: master **Frontier Molecular Orbital (FMO) Theory (Kenichi Fukui, Nobel Prize 1981)** analyzing interactions between the **HOMO (Highest Occupied Molecular Orbital)** and **LUMO (Lowest Unoccupied Molecular Orbital)**, apply the **Woodward-Hoffmann Rules (R.B. Woodward & Roald Hoffmann, Nobel Prize 1981)** for the **Conservation of Orbital Symmetry**, evaluate **$[4\pi_s + 2\pi_s]$ Diels-Alder Cycloadditions** (thermally allowed via constructive in-phase terminal orbital overlap), and contrast stereochemical outcomes in **Electrocyclic Ring Closures** ($4n\ \pi$-electrons: thermal conrotatory vs photochemical disrotatory; $4n+2\ \pi$-electrons: thermal disrotatory vs photochemical conrotatory).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | FMO Theory & Woodward-Hoffmann Pericyclic Rules Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Diels-Alder FMO Phase Matching Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pericyclic System & Woodward-Hoffmann Selection Rule Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Highest Occupied Molecular Orbital Standard Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Thermal vs Photochemical Butadiene Ring Closure Stereospecificity Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Frontier Molecular Orbital (FMO) Theory & Woodward-Hoffmann Rules:
   - **The FMO Principle (Kenichi Fukui, 1952):**
     - Chemical reactivity and reaction trajectories are dominated by the energetic proximity and orbital symmetry match between the **HOMO** of the electron donor and the **LUMO** of the electron acceptor.
   - **The Woodward-Hoffmann Rules (1965):**
     - A pericyclic reaction is **thermally allowed** if the total number of $(4q+2)_s$ and $(4r)_a$ components is **ODD**.
   - **Classification of Pericyclic Classes:**
     1. **Cycloadditions:**
        - **Diels-Alder $[4\pi_s + 2\pi_s]$:** Diene $\psi_2$ (HOMO, terminal lobes in-phase with $C_2$ symmetry) overlaps constructively with Dienophile $\pi^*$ (LUMO) $\implies$ **Thermally Allowed, Suprafacial-Suprafacial**.
        - **$[2\pi_s + 2\pi_s]$ Cycloaddition:** Thermally forbidden (destructive phase clash); **Photochemically Allowed** ($h\nu$).
     2. **Electrocyclic Ring Closures:**
        - **$4n\ \pi$-Electrons (e.g. Butadiene, $4\pi$):**
          - Thermal ($\Delta$): **Conrotatory** (HOMO $\psi_2$ has $C_2$ symmetry; both termini rotate in same direction).
          - Photochemical ($h\nu$): **Disrotatory** (HOMO $\psi_3^*$ has mirror plane $m$ symmetry).
        - **$4n+2\ \pi$-Electrons (e.g. Hexatriene, $6\pi$):**
          - Thermal ($\Delta$): **Disrotatory** (HOMO $\psi_3$ has mirror plane $m$ symmetry; termini rotate opposite).
          - Photochemical ($h\nu$): **Conrotatory** (HOMO $\psi_4^*$ has $C_2$ symmetry).
2. **Slide 2 (`ordering`):** Provide 5 steps analyzing the orbital symmetry of the Diels-Alder $[4\pi_s + 2\pi_s]$ reaction: (1) identify the diene (1,3-butadiene, $4\pi$) and dienophile (ethylene, $2\pi$), (2) determine the relevant frontier orbitals: Diene $\text{HOMO} = \psi_2$ (one internal node, antisymmetric terminal lobes) and Dienophile $\text{LUMO} = \pi^*$ (one node, opposite phase lobes), (3) align the diene in the reactive $s\text{-cis}$ conformation beneath the dienophile, (4) evaluate the phase overlap at both newly forming $\sigma$-bonds (C1-C6 and C4-C5), observing simultaneous in-phase constructive bonding overlap at both termini, (5) conclude that the reaction proceeds with suprafacial-suprafacial stereospecificity via a concerted, thermally allowed 6-electron aromatic transition state!
3. **Slide 3 (`matching`):** Pair 4 pericyclic reactions ($[4\pi_s + 2\pi_s]$ Diels-Alder, Thermal $4\pi$ Butadiene electrocyclization, Thermal $6\pi$ Hexatriene electrocyclization, $[2\pi_s + 2\pi_s]$ Ethylene dimerization) with their Woodward-Hoffmann allowed modes (Thermally allowed suprafacial, Thermal conrotatory, Thermal disrotatory, Photochemically allowed).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the acronym HOMO stands for the highest occupied molecular orbital. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on electrocyclic stereospecificity: When $(2E,4E)$-hexa-2,4-diene ($4\pi$ electron system) is heated ($\Delta$), it undergoes electrocyclic ring closure to form exclusively *trans*-3,4-dimethylcyclobutene. When irradiated with ultraviolet light ($h\nu$), it yields *cis*-3,4-dimethylcyclobutene. Why? (Under thermal conditions, the reaction is governed by the ground-state HOMO ($\psi_2$), which has $C_2$ orbital symmetry requiring a **conrotatory** ring closure that rotates both methyl groups in the same direction, yielding the *trans* isomer; UV excitation promotes an electron to $\psi_3^*$, whose mirror plane ($m$) symmetry mandates a **disrotatory** closure, rotating methyl groups toward each other to give the *cis* isomer).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "frontier_molecular_orbitals_and_woodward_hoffmann_rules",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Frontier Molecular Orbitals and Woodward-Hoffmann Rules**\n• **The FMO Principle (Kenichi Fukui, 1981 Nobel Prize):**\n  - Reaction barriers and stereochemistry are determined by symmetry and overlap between the **HOMO** of the nucleophile/diene and the **LUMO** of the electrophile/dienophile.\n• **Woodward-Hoffmann Selection Rules for Pericyclic Reactions:**\n  - **Diels-Alder $[4\\pi_s + 2\\pi_s]$:** Diene $\\psi_2$ (HOMO) overlaps in-phase with Dienophile $\\pi^*$ (LUMO) $\\implies$ **Thermally Allowed** (Concerted $6e^-$ aromatic transition state).\n  - **Electrocyclic Ring Closures:**\n    - **$4n\\ \\pi$-Electrons (Butadiene):**\n      - **Thermal ($\\Delta$):** **Conrotatory** (HOMO $\\psi_2$, $C_2$ symmetry).\n      - **Photochemical ($h\\nu$):** **Disrotatory** (HOMO $\\psi_3^*$, mirror plane $m$).\n    - **$4n+2\\ \\pi$-Electrons (Hexatriene):**\n      - **Thermal ($\\Delta$):** **Disrotatory** (HOMO $\\psi_3$, mirror plane $m$).\n      - **Photochemical ($h\\nu$):** **Conrotatory** (HOMO $\\psi_4^*$, $C_2$ symmetry)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps verifying orbital symmetry conservation in the [4+2] Diels-Alder cycloaddition.",
      "orderItems": [
        "Identify the two reacting components: electron-rich diene (4 pi-electrons) and electron-poor dienophile (2 pi-electrons)",
        "Determine the relevant frontier molecular orbitals: Diene HOMO (psi_2) and Dienophile LUMO (pi*)",
        "Adopt the mandatory s-cis planar conformation of the diene facing the approaching dienophile",
        "Inspect terminal orbital lobe signs: observe constructive in-phase (+ to + and - to -) overlap at both bond-forming termini",
        "Confirm that the reaction proceeds via a thermally allowed, concerted suprafacial-suprafacial pericyclic transition state"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each pericyclic transformation to its Woodward-Hoffmann allowed mode.",
      "matchPairs": [
        { "left": "Diels-Alder [4pi + 2pi] Cycloaddition", "right": "Thermally allowed suprafacial-suprafacial (6 pi-electron aromatic transition state)" },
        { "left": "Thermal 4pi-Electrocyclization (e.g. Butadiene)", "right": "Conrotatory motion (HOMO psi_2 has C2 symmetry; both ends rotate same way)" },
        { "left": "Thermal 6pi-Electrocyclization (e.g. Hexatriene)", "right": "Disrotatory motion (HOMO psi_3 has mirror symmetry; ends rotate opposite ways)" },
        { "left": "[2pi + 2pi] Alkene Dimerization", "right": "Thermally forbidden / Photochemically allowed (under UV irradiation)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Frontier Molecular Orbital theory, the acronym HOMO stands for the highest occupied ___ orbital.",
      "blankAnswer": "molecular",
      "blankDistractors": ["atomic", "magnetic", "nuclear"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When (2E,4E)-hexa-2,4-diene (a 4 pi-electron system) is heated thermally (Delta), it closes to trans-3,4-dimethylcyclobutene, but under UV light (h nu), it closes to cis-3,4-dimethylcyclobutene. What quantum principle explains this reversal?",
      "options": [
        { "text": "Thermal closure is governed by ground-state HOMO psi_2 (C2 symmetry), which requires CONROTATORY rotation (yielding trans); UV light excites an electron to psi_3* (mirror plane symmetry), which requires DISROTATORY rotation (yielding cis)", "isCorrect": true, "explanation": "Correct! In the ground state of a 4pi system, the HOMO (psi_2) has C2 rotational symmetry, so constructive orbital overlap requires the terminal carbons to rotate in the same direction (conrotatory), moving one methyl up and one down (trans). Upon photochemical excitation, an electron is promoted to psi_3*, which has mirror plane (m) symmetry, forcing the terminal carbons to rotate in opposite directions (disrotatory), swinging both methyls up to give the cis isomer." },
        { "text": "UV light destroys the methyl groups permanently", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Thermal energy converts cyclobutene into benzene", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Woodward-Hoffmann rules only apply in the dark", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
