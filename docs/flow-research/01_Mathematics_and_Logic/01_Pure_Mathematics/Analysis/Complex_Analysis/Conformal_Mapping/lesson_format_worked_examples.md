# Duofy Reusable Lesson Format: Conformal Mapping - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Conformal_Mapping`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly construct unique Möbius transformations mapping three given points $(z_1, z_2, z_3)$ to three targets $(w_1, w_2, w_3)$ using the cross-ratio formula, map the upper half-plane to the unit disk, and find the image of geometric regions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cross-Ratio Construction Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Möbius Map Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Boundary Orientation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Fixed Point Evaluation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Cayley Transform Image Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Cross-Ratio formula: $\frac{(w - w_1)(w_2 - w_3)}{(w - w_3)(w_2 - w_1)} = \frac{(z - z_1)(z_2 - z_3)}{(z - z_3)(z_2 - z_1)}$ for finding the unique transformation sending $(z_1, z_2, z_3) \mapsto (w_1, w_2, w_3)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps of constructing the map sending $(0, 1, \infty) \mapsto (-1, -i, 1)$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that conformal maps preserve the left-hand orientation of regions with respect to boundary paths. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to find the fixed points $f(z) = z$ of the inversion $f(z) = \frac{1}{z}$ (positive fixed point: $z = 1.0$).
5. **Slide 5 (`quiz`):** Quiz testing the image of the point $z = i$ under the Cayley transform $w = \frac{z - i}{z + i}$ ($w(i) = 0$, the origin of the unit disk).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Constructing Möbius Transformations via Cross-Ratio**\nThe unique Möbius transformation mapping $(z_1, z_2, z_3) \\mapsto (w_1, w_2, w_3)$ is obtained by equating cross-ratios:\n$$\n\\frac{(w - w_1)(w_2 - w_3)}{(w - w_3)(w_2 - w_1)} = \\frac{(z - z_1)(z_2 - z_3)}{(z - z_3)(z_2 - z_1)}\n$$\nIf any point is $\\infty$, replace terms involving $\\infty$ by $1$ (taking limits)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Setup Cross-Ratio):** Map $(z_1, z_2, z_3) = (1, i, -1) \\mapsto (w_1, w_2, w_3) = (0, 1, \\infty)$.\n• **Step 2 (Evaluate $w$-Side):** With $w_3 = \\infty$, $\\frac{w - 0}{1 - 0} = w$.\n• **Step 3 (Evaluate $z$-Side):** $\\frac{(z - 1)(i - (-1))}{(z - (-1))(i - 1)} = \\frac{(z - 1)(i + 1)}{(z + 1)(i - 1)} = \\frac{(z - 1)(i)}{z + 1} = -i \\frac{z - 1}{z + 1}$.\n• **Step 4 (Solve for $w$):** $w = f(z) = -i \\frac{z - 1}{z + 1} = \\frac{-i z + i}{z + 1}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "When mapping boundaries conformally, a point traveling along the boundary keeps the interior domain to its ___ on both the domain and target sides.",
      "blankAnswer": "left",
      "blankDistractors": ["right", "origin", "infinity"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the positive real fixed point of the transformation f(z) = 1/z, found by solving z = 1/z?",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Where does the Cayley transform f(z) = (z - i)/(z + i) map the imaginary point z = i?",
      "options": [
        { "text": "w = 0 (the center of the unit disk)", "isCorrect": true, "explanation": "Correct! f(i) = (i - i)/(i + i) = 0/2i = 0." },
        { "text": "w = 1 (on the unit circle)", "isCorrect": false, "explanation": "Incorrect: Real numbers map to the unit circle, but z = i is inside the upper half-plane." },
        { "text": "w = -1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "w = infinity", "isCorrect": false, "explanation": "Incorrect: z = -i maps to infinity, not z = +i." }
      ]
    }
  ]
}
```
