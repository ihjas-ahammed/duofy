# Duofy Reusable Lesson Format: Bravais Lattices and Miller Indices

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Crystal_Lattices_and_X_Ray_Diffraction`  
**Lesson Format Type:** `bravais_lattices_and_miller_indices`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through real-space crystallography: formulate the **14 3D Bravais Lattices** across the **7 Crystal Systems**, define **Primitive Unit Cells** and the **Wigner-Seitz Cell**, determine **Miller Indices $(hkl)$** from coordinate axis intercepts, compute the **Interplanar Spacing $d_{hkl} = \frac{a}{\sqrt{h^2+k^2+l^2}}$** for cubic systems, and analyze packing efficiencies (SC $52\%$, BCC $68\%$, FCC/HCP $74\%$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bravais Lattices & Miller Indices Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Miller Indices (hkl) Determination Algorithm Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cubic Crystal Structure & Atomic Packing Fraction Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Number of 3D Bravais Lattices Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interplanar Spacing Calculation for (111) Plane Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Crystal Definition: $\text{Crystal Structure} = \text{Bravais Lattice} + \text{Basis}$.
   - **The 14 3D Bravais Lattices (Auguste Bravais, 1850):** Classified into 7 crystal systems: Cubic ($a=b=c, \alpha=\beta=\gamma=90^\circ$), Tetragonal, Orthorhombic, Hexagonal, Rhombohedral, Monoclinic, Triclinic.
   - **Wigner-Seitz Primitive Cell:** The region of space closer to a given lattice point than to any other lattice point.
   - **Miller Indices $(hkl)$:** Notation for a family of parallel lattice planes.
   - **Cubic Interplanar Spacing Formula:**
     $$d_{hkl} = \frac{a}{\sqrt{h^2 + k^2 + l^2}}$$
   - **Atomic Packing Fraction (APF):** $\text{SC} = \frac{\pi}{6} \approx 52\%$, $\text{BCC} = \frac{\sqrt{3}\pi}{8} \approx 68\%$, $\text{FCC/HCP} = \frac{\pi}{3\sqrt{2}} \approx 74\%$ (maximum sphere packing!).
2. **Slide 2 (`ordering`):** Provide 5 steps for finding Miller indices $(hkl)$ of a crystal plane: (1) identify the fractional coordinate intercepts of the plane along the three crystal axes $(x_1 a, x_2 b, x_3 c)$, (2) take the reciprocal of each fractional intercept $(1/x_1, 1/x_2, 1/x_3)$ (planes parallel to an axis intercept at $\infty \implies$ reciprocal is 0), (3) clear fractions by multiplying by the lowest common denominator, (4) reduce to the smallest set of coprime integers $(h, k, l)$, (5) enclose the resulting triplet in round parentheses as $(hkl)$ (negative integers denoted with overbars $\bar{h}$)!
3. **Slide 3 (`matching`):** Pair 4 crystal lattices (Simple Cubic (SC), Body-Centered Cubic (BCC), Face-Centered Cubic (FCC), Hexagonal Close-Packed (HCP)) with their coordination numbers ($6$, $8$, $12$, $12$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that there are exactly 14 unique Bravais lattices in three dimensions. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing interplanar spacing: For an FCC Aluminum crystal with lattice parameter $a = 4.05\text{ \AA}$, what is the interplanar spacing $d_{111}$ between $(111)$ planes? ($d_{111} = \frac{a}{\sqrt{1^2 + 1^2 + 1^2}} = \frac{4.05}{\sqrt{3}} = \frac{4.05}{1.732} \approx 2.34\text{ \AA}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bravais_lattices_and_miller_indices",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bravais Lattices and Miller Indices**\n• **Crystallographic Foundation:** $\\text{Crystal Structure} = \\text{Bravais Lattice} + \\text{Basis}$.\n• **14 Bravais Lattices in 7 Systems:** Cubic, Tetragonal, Orthorhombic, Hexagonal, Rhombohedral, Monoclinic, Triclinic.\n• **Miller Indices $(hkl)$:** Coordinates identifying families of parallel atomic planes.\n• **Cubic Interplanar Spacing $d_{hkl}$:**\n$$\nd_{hkl} = \\frac{a}{\\sqrt{h^2 + k^2 + l^2}}\n$$\n• **Atomic Packing Factor (APF):**\n  - **Simple Cubic (SC):** $\\text{APF} \\approx 52\\%$ (Coordination number = 6).\n  - **Body-Centered Cubic (BCC):** $\\text{APF} \\approx 68\\%$ (Coordination number = 8).\n  - **Face-Centered Cubic (FCC):** $\\text{APF} \\approx 74\\%$ (Coordination number = 12, Close-Packed!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the algorithmic steps to determine the Miller indices (hkl) of a crystal plane.",
      "orderItems": [
        "Determine the fractional intercepts of the plane along lattice axes a, b, c as (x1, x2, x3)",
        "Take the mathematical reciprocals of each intercept: (1/x1, 1/x2, 1/x3) with 1/infinity = 0 for parallel axes",
        "Clear all fractions by multiplying by the lowest common denominator",
        "Reduce the numbers to the smallest coprime integer triplet h, k, l",
        "Enclose the final integers in round parentheses as (hkl), writing negative values with an overbar"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each cubic lattice to its nearest-neighbor coordination number.",
      "matchPairs": [
        { "left": "Simple Cubic (SC)", "right": "Coordination Number = 6 (nearest neighbors along +/- x, +/- y, +/- z)" },
        { "left": "Body-Centered Cubic (BCC)", "right": "Coordination Number = 8 (touching along body diagonals)" },
        { "left": "Face-Centered Cubic (FCC)", "right": "Coordination Number = 12 (touching along face diagonals, close-packed)" },
        { "left": "Diamond Cubic Structure", "right": "Coordination Number = 4 (tetrahedrally bonded with 2-atom FCC basis)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In 3-dimensional space, there are exactly ___ distinct Bravais lattices distributed across 7 crystal systems.",
      "blankAnswer": "14",
      "blankDistractors": ["7", "32", "230"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For a cubic crystal with lattice constant a = 4.05 Å, what is the interplanar spacing d_111 for the (111) family of planes?",
      "options": [
        { "text": "d_111 = a / sqrt(1^2 + 1^2 + 1^2) = 4.05 / sqrt(3) ≈ 2.34 Å", "isCorrect": true, "explanation": "Correct! Using d_{hkl} = a / sqrt(h^2 + k^2 + l^2), d_111 = 4.05 / 1.732 = 2.338 Å." },
        { "text": "d_111 = 4.05 Å", "isCorrect": false, "explanation": "Incorrect: That is d_100." },
        { "text": "d_111 = 4.05 / 2 = 2.025 Å", "isCorrect": false, "explanation": "Incorrect: That is d_200." },
        { "text": "d_111 = 4.05 * sqrt(3) ≈ 7.01 Å", "isCorrect": false, "explanation": "Incorrect: Spacing is divided by sqrt(h^2+k^2+l^2)." }
      ]
    }
  ]
}
```
