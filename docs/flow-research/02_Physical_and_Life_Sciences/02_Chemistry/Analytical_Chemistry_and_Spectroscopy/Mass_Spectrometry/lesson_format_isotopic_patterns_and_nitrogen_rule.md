# Duofy Reusable Lesson Format: Isotopic Patterns and the Nitrogen Rule

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Mass_Spectrometry`  
**Lesson Format Type:** `isotopic_patterns_and_nitrogen_rule`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through elemental formula deduction from isotopic cluster distributions: calculate carbon counts using the **$M+1$ Rule ($n_{\text{C}} \approx \frac{I_{M+1}}{0.011 \times I_M}$)**, diagnose halogen signatures using **$M+2$ Clusters** (Chlorine $^{35}\text{Cl} : ^{37}\text{Cl} \approx 3:1$, Bromine $^{79}\text{Br} : ^{81}\text{Br} \approx 1:1$, dibromo/dichloro binomial clusters), apply the **Nitrogen Rule** for odd vs even molecular ions, and calculate degrees of unsaturation / Index of Hydrogen Deficiency ($\text{IHD} = C - \frac{H}{2} - \frac{X}{2} + \frac{N}{2} + 1$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Isotopic Patterns & Nitrogen Rule Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Carbon Count M+1 Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Isotopic Signature / Rule & Elemental Composition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Bromine Monoisotopic M to M+2 Peak Height Ratio Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Dibromo M, M+2, M+4 Binomial Triplet Distribution Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Isotopic Signatures and Mass Spec Rules:
   - **$M+1$ Peak (Carbon Estimation):**
     $$n_{\text{C}} \approx \frac{I_{M+1}}{0.011 \times I_M}$$
     *(Based on natural $^{13}\text{C}$ abundance $= 1.08\% \approx 1.1\%$).*
   - **$M+2$ Halogen Fingerprints:**
     - **One Chlorine Atom ($^{35}\text{Cl} : ^{37}\text{Cl} \approx 3 : 1$):** $[M]$ at $100\%$, $[M+2]$ at $\sim 33\%$.
     - **One Bromine Atom ($^{79}\text{Br} : ^{81}\text{Br} \approx 1 : 1$):** Twin peaks of nearly equal intensity ($[M] : [M+2] \approx 100\% : 98\%$).
     - **One Sulfur Atom ($^{34}\text{S}$):** $[M+2] \approx 4.4\%$.
   - **The Nitrogen Rule:**
     - A neutral organic molecule with an **ODD nominal molecular mass** contains an **ODD number of Nitrogen atoms** ($1, 3, 5, \dots$).
     - A neutral organic molecule with an **EVEN nominal molecular mass** contains **ZERO or an EVEN number of Nitrogen atoms** ($0, 2, 4, \dots$).
   - **Index of Hydrogen Deficiency (IHD):** $\text{IHD} = C + 1 - \frac{H + X - N}{2}$.
2. **Slide 2 (`ordering`):** Provide 5 steps calculating the molecular formula from mass spec isotopic peaks: (1) determine nominal molecular ion mass $m/z$ and check parity against the Nitrogen Rule, (2) measure the relative intensity ratio of the $M+1$ peak to the $M$ peak: $\frac{I_{M+1}}{I_M}$, (3) divide by $0.011$ to calculate the number of carbon atoms: $n_{\text{C}} = \frac{I_{M+1}}{0.011 I_M}$, (4) inspect $M+2$ intensity for $\text{Cl}$ ($3:1$), $\text{Br}$ ($1:1$), or $\text{S}$ ($4\%$) signatures, (5) subtract known atomic masses ($C, N, Cl, Br, S$) from molecular mass to determine the remaining hydrogen atom count!
3. **Slide 3 (`matching`):** Pair 4 mass spec isotope patterns ($M : M+2 = 3 : 1$, $M : M+2 = 1 : 1$, $M : M+2 : M+4 = 1 : 2 : 1$, Odd Molecular Ion $[M]^{+\bullet} = 73$) with their structural meanings ($1\ \text{Cl}$ atom, $1\ \text{Br}$ atom, $2\ \text{Br}$ atoms, Odd number of nitrogens (e.g. $1\ \text{N}$)).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a molecule containing a single bromine atom exhibits twin M and M+2 peaks in an intensity ratio of approximately 1 to 1. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on multiple halogen isotopic binomial distributions: A compound containing TWO bromine atoms ($\text{Br}_2$) exhibits an isotopic cluster at $M$, $M+2$, and $M+4$. What is the relative peak intensity ratio of $[M] : [M+2] : [M+4]$? ($1 : 2 : 1$; expanding the binomial $(a + b)^2$ with $a(^{79}\text{Br}) = 0.50$ and $b(^{81}\text{Br}) = 0.50$ yields $a^2(^{79}\text{Br}_2) : 2ab(^{79}\text{Br}^{81}\text{Br}) : b^2(^{81}\text{Br}_2) = 0.25 : 0.50 : 0.25 = 1 : 2 : 1$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "isotopic_patterns_and_nitrogen_rule",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Isotopic Patterns and the Nitrogen Rule**\n• **$M+1$ Peak (Carbon Number Formula):**\n$$\nn_{\\text{C}} \\approx \\frac{I_{M+1}}{0.011 \\times I_M}\n$$\n• **$M+2$ Halogen Fingerprints:**\n  - **1 Chlorine ($^{35}\\text{Cl} : ^{37}\\text{Cl} \\approx 3 : 1$):** $[M] : [M+2] \\approx 100 : 33\\%$.\n  - **1 Bromine ($^{79}\\text{Br} : ^{81}\\text{Br} \\approx 1 : 1$):** Equal twin peaks $[M] : [M+2] \\approx 1 : 1$.\n  - **2 Bromines ($\\text{Br}_2$):** Binomial triplet $[M] : [M+2] : [M+4] = 1 : 2 : 1$.\n• **The Nitrogen Rule:**\n  - **ODD Nominal Molecular Mass $\\implies$ ODD number of Nitrogens** ($1, 3, 5\\dots$).\n  - **EVEN Nominal Molecular Mass $\\implies$ ZERO or EVEN Nitrogens** ($0, 2, 4\\dots$).\n• **Index of Hydrogen Deficiency:** $\\text{IHD} = C + 1 - \\frac{H + X - N}{2}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the analytical steps deducing a molecular formula from mass spec isotopic peaks.",
      "orderItems": [
        "Identify the molecular ion peak M+• and apply the Nitrogen Rule to check for odd vs even nitrogen atoms",
        "Measure the peak height percentage of the M+1 isotope peak relative to the monoisotopic M peak",
        "Calculate the estimated carbon atom count: n_C = (Intensity of M+1) / (0.011 * Intensity of M)",
        "Check the M+2 peak intensity to detect presence of Chlorine (3:1), Bromine (1:1), or Sulfur (4%)",
        "Subtract carbon, halogen, and heteroatom masses from total mass to deduce the exact hydrogen count"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each mass spec isotopic pattern to its underlying chemical composition.",
      "matchPairs": [
        { "left": "Peak Ratio [M] : [M+2] = 3 : 1", "right": "Presence of exactly ONE Chlorine atom (Cl-35 vs Cl-37)" },
        { "left": "Twin Peaks [M] : [M+2] = 1 : 1", "right": "Presence of exactly ONE Bromine atom (Br-79 vs Br-81)" },
        { "left": "Triplet [M] : [M+2] : [M+4] = 1 : 2 : 1", "right": "Presence of exactly TWO Bromine atoms (Br_2 binomial distribution)" },
        { "left": "Triplet [M] : [M+2] : [M+4] = 9 : 6 : 1", "right": "Presence of exactly TWO Chlorine atoms (Cl_2 binomial distribution)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A molecule containing a single bromine atom shows two molecular ion peaks [M] and [M+2] of approximately ___ height.",
      "blankAnswer": "equal",
      "blankDistractors": ["triple", "zero", "infinite"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A neutral organic compound exhibits a molecular ion peak at m/z = 73 (odd mass) with an M+1 peak that is 3.3% the height of M. What is the most probable molecular formula?",
      "options": [
        { "text": "C3 H7 N O (MW = 73 g/mol; n_C = 3.3 / 1.1 = 3 carbons; odd mass 73 requires an ODD number of nitrogens (1 N), perfectly matching dimethylformamide / propanamide)", "isCorrect": true, "explanation": "Correct! Applying n_C = 3.3 / 1.1 = 3 carbons (mass = 36). An odd molecular ion (m/z = 73) requires an odd number of nitrogens (1 N, mass = 14). Total mass 36 + 14 = 50. Remaining mass 73 - 50 = 23, which corresponds to 1 Oxygen (16) + 7 Hydrogens (7). Formula is C3H7NO." },
        { "text": "C4 H9 O (MW = 73)", "isCorrect": false, "explanation": "Incorrect: Violates Nitrogen Rule (odd mass cannot have zero nitrogens)." },
        { "text": "C5 H13 (MW = 73)", "isCorrect": false, "explanation": "Incorrect: Violates Nitrogen Rule." },
        { "text": "C2 H5 N2 (MW = 73)", "isCorrect": false, "explanation": "Incorrect: Contains 2 nitrogens (even count with odd mass violates rule)." }
      ]
    }
  ]
}
```
