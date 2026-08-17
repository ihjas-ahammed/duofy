# Duofy Reusable Lesson Format: Crystal Field Splitting and CFSE Calculation

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Coordination_Chemistry_and_Crystal_Field_Theory`  
**Lesson Format Type:** `crystal_field_splitting_and_cfse_calculation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the electrostatic foundations and quantitative energetics of Crystal Field Theory (CFT): derive **Octahedral d-Orbital Splitting** ($e_g$ set at $+0.6\Delta_o$, $t_{2g}$ set at $-0.4\Delta_o$ around the barycenter), formulate the **Crystal Field Stabilization Energy ($\text{CFSE} = (-0.4 n_{t_{2g}} + 0.6 n_{e_g})\Delta_o + m P$)**, compare with **Tetrahedral Splitting ($\Delta_t = \frac{4}{9}\Delta_o$)**, and calculate net CFSE for high-spin and low-spin $d^1-d^{10}$ coordination complexes.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Octahedral CFT Splitting & CFSE Formula Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Low-Spin d6 CFSE Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | d-Electron Configuration & Octahedral CFSE Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Tetrahedral to Octahedral Splitting Energy Ratio Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High-Spin vs Low-Spin d5 CFSE Comparison Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Crystal Field Splitting & CFSE:
   - **The Octahedral Field ($O_h$):**
     - Six ligand point charges approach along the $\pm x, \pm y, \pm z$ axes.
     - **$e_g$ Orbitals ($d_{z^2}, d_{x^2-y^2}$):** Point directly at ligands $\implies$ strong electrostatic repulsion $\implies$ raised by **$+0.6 \Delta_o$** ($+6\text{ Dq}$).
     - **$t_{2g}$ Orbitals ($d_{xy}, d_{yz}, d_{xz}$):** Point between the axes $\implies$ lower repulsion $\implies$ stabilized by **$-0.4 \Delta_o$** ($-4\text{ Dq}$).
   - **Crystal Field Stabilization Energy (CFSE):**
     $$\text{CFSE} = \left( -0.4\, n_{t_{2g}} + 0.6\, n_{e_g} \right) \Delta_o + m P$$
     where $n_{t_{2g}}$ and $n_{e_g}$ are electron counts, $P$ is pairing energy, and $m$ is the net number of extra paired electron sets relative to the free gaseous ion.
   - **Tetrahedral Field ($T_d$):**
     $$\Delta_t = \frac{4}{9} \Delta_o \qquad (e \text{ lower by } -0.6\Delta_t, \quad t_2 \text{ higher by } +0.4\Delta_t)$$
     *(Because $\Delta_t < P$ always, all tetrahedral complexes are strictly HIGH-SPIN!).*
2. **Slide 2 (`ordering`):** Provide 5 steps calculating the CFSE of a low-spin $d^6$ octahedral complex $[\text{Fe}(\text{CN})_6]^{4-}$: (1) determine iron oxidation state $\text{Fe}^{\text{II}}$ and $d^6$ valence electron count, (2) recognize cyanide $\text{CN}^-$ as a strong-field ligand causing $\Delta_o > P$ (low-spin), (3) place all 6 electrons paired into the lower $t_{2g}$ orbitals: $t_{2g}^6 e_g^0$, (4) compute orbital stabilization energy: $6 \times (-0.4 \Delta_o) + 0 \times (0.6 \Delta_o) = -2.4 \Delta_o$, (5) add the 2 additional electron pairs forced together ($m=2$) to establish total CFSE: $\text{CFSE} = -2.4 \Delta_o + 2P$!
3. **Slide 3 (`matching`):** Pair 4 $d^n$ configurations ($d^3$ $O_h$, Low-spin $d^6$ $O_h$, High-spin $d^5$ $O_h$, $d^8$ $O_h$) with their CFSE values in units of $\Delta_o$ ($-1.2\Delta_o$, $-2.4\Delta_o$, $0\Delta_o$, $-1.2\Delta_o$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the crystal field splitting in a tetrahedral complex Delta_t is equal to 4/9 of the octahedral splitting Delta_o. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on High-spin vs Low-spin $d^5$ CFSE: For an octahedral $\text{Fe}^{\text{III}}$ ($d^5$) complex, what is the calculated CFSE for the high-spin complex $[\text{Fe}(\text{H}_2\text{O})_6]^{3+}$ versus the low-spin complex $[\text{Fe}(\text{CN})_6]^{3-}$? (High-spin is **$0\ \Delta_o$** ($t_{2g}^3 e_g^2 \implies 3(-0.4) + 2(+0.6) = 0$); Low-spin is **$-2.0\ \Delta_o + 2P$** ($t_{2g}^5 e_g^0 \implies 5(-0.4) = -2.0\Delta_o$ with 2 extra electron pairs)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "crystal_field_splitting_and_cfse_calculation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Crystal Field Splitting and CFSE Calculation**\n• **Octahedral ($O_h$) d-Orbital Splitting:**\n  - **$e_g$ Set ($d_{z^2}, d_{x^2-y^2}$):** Point along axes directly at ligands $\\implies$ destabilized by **$+0.6 \\Delta_o$**.\n  - **$t_{2g}$ Set ($d_{xy}, d_{yz}, d_{xz}$):** Point between Cartesian axes $\\implies$ stabilized by **$-0.4 \\Delta_o$**.\n• **Crystal Field Stabilization Energy (CFSE):**\n$$\n\\text{CFSE} = \\left( -0.4\\, n_{t_{2g}} + 0.6\\, n_{e_g} \\right) \\Delta_o + m P\n$$\n• **Tetrahedral ($T_d$) Inversion:**\n$$\n\\Delta_t = \\frac{4}{9} \\Delta_o \\qquad (e \\text{ set lower, } t_2 \\text{ set higher})\n$$\n  *(Because $\\Delta_t \\ll P$, tetrahedral complexes are exclusively **High-Spin**!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps calculating the CFSE of low-spin octahedral [Fe(CN)6]4- (Fe2+, d6).",
      "orderItems": [
        "Determine the iron oxidation state Fe(II) and assign the 3d^6 valence electron configuration",
        "Identify cyanide (CN-) as a strong-field ligand causing large splitting: Delta_o > P (Low-Spin)",
        "Populate the split d-orbitals: all 6 electrons pair in the lower t_2g set (t_2g^6 e_g^0)",
        "Calculate orbital energy contribution: 6 * (-0.4 Delta_o) + 0 * (+0.6 Delta_o) = -2.4 Delta_o",
        "Account for the two newly forced electron pairs to conclude: CFSE = -2.4 Delta_o + 2P"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each octahedral electron configuration to its exact CFSE (ignoring pairing energy).",
      "matchPairs": [
        { "left": "Octahedral d3 (t_2g^3 e_g^0)", "right": "-1.2 Delta_o (3 * -0.4)" },
        { "left": "High-Spin Octahedral d5 (t_2g^3 e_g^2)", "right": "0.0 Delta_o (3 * -0.4 + 2 * +0.6 = 0, spherically symmetric)" },
        { "left": "Low-Spin Octahedral d6 (t_2g^6 e_g^0)", "right": "-2.4 Delta_o (maximum ligand field stabilization)" },
        { "left": "Octahedral d8 (t_2g^6 e_g^2)", "right": "-1.2 Delta_o (6 * -0.4 + 2 * +0.6 = -1.2)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The crystal field splitting energy Delta_t in a tetrahedral complex is related to octahedral Delta_o by the fraction ___ / 9.",
      "blankAnswer": "4",
      "blankDistractors": ["2", "6", "8"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the CFSE of high-spin [Fe(H2O)6]3+ (Fe3+, d5) versus low-spin [Fe(CN)6]3-?",
      "options": [
        { "text": "High-spin CFSE is 0.0 Delta_o (t_2g³ e_g² has exactly equal stabilizing -1.2 and destabilizing +1.2 contributions); Low-spin CFSE is -2.0 Delta_o + 2P (t_2g⁵ e_g⁰)", "isCorrect": true, "explanation": "Correct! In high-spin d5 (t2g^3 eg^2), CFSE = 3*(-0.4) + 2*(+0.6) = -1.2 + 1.2 = 0. In low-spin d5 (t2g^5 eg^0), CFSE = 5*(-0.4) = -2.0 Delta_o + 2P. This gives the low-spin ferric complex huge extra stabilization." },
        { "text": "High-spin is -2.4 Delta_o, Low-spin is 0.0 Delta_o", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both have identical CFSE of -1.0 Delta_o", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "CFSE cannot be calculated for iron complexes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
