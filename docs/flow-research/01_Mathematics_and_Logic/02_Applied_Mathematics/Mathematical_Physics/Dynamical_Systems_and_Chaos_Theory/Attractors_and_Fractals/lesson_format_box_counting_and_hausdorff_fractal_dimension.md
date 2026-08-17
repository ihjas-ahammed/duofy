# Duofy Reusable Lesson Format: Box-Counting and Hausdorff Fractal Dimension

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Dynamical_Systems_and_Chaos_Theory / Attractors_and_Fractals`  
**Lesson Format Type:** `box_counting_and_hausdorff_fractal_dimension`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute the **Box-Counting (Capacity) Dimension** $D_0 = \lim_{\epsilon\to 0} \frac{\ln N(\epsilon)}{\ln(1/\epsilon)}$ and **Similarity Dimension** $D = \frac{\ln N}{\ln(1/r)}$ for self-similar fractals (Cantor Set, Sierpiński Gasket, Koch Snowflake, Menger Sponge), and understand Hausdorff measure $\mathcal{H}^d$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Box-Counting & Similarity Dimension Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Sierpiński Gasket Dimension Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Fractal Geometry & Exact Dimension Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Cantor Set Dimension Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Koch Snowflake Infinite Perimeter Finite Area Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of Box-Counting Dimension: Let $N(\epsilon)$ be the minimum number of boxes of side length $\epsilon$ required to cover a compact set $F \subset \mathbb{R}^n$. The box-counting (capacity) dimension is $D_0 = \lim_{\epsilon \to 0} \frac{\ln N(\epsilon)}{\ln(1/\epsilon)}$. For a strictly self-similar fractal composed of $N$ copies scaled by factor $r \in (0, 1)$, the similarity dimension is $D = \frac{\ln N}{\ln(1/r)}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct computing the dimension of the Sierpiński Triangle (Gasket): (1) start with an equilateral triangle of side length 1, (2) remove the central inverted sub-triangle, leaving $N = 3$ identical sub-triangles, (3) each sub-triangle has side length scaled down by $r = 1/2$, (4) compute similarity dimension: $D = \frac{\ln 3}{\ln(1 / (1/2))} = \frac{\ln 3}{\ln 2} \approx \frac{1.0986}{0.6931} \approx 1.5850$, (5) intermediate nature: strictly greater than a 1D line ($D=1$) and strictly less than a 2D surface ($D=2$).
3. **Slide 3 (`matching`):** Pair 4 fractals (Cantor Set, Koch Curve, Sierpiński Carpet, Menger Sponge) with their exact scaling parameters $(N, r)$ and dimensions.
4. **Slide 4 (`numerical`):** Ask student to compute the fractal dimension of the middle-thirds Cantor set $D = \frac{\ln 2}{\ln 3}$ to two decimal places (numeric answer: $0.6931 / 1.0986 = 0.63$).
5. **Slide 5 (`quiz`):** Quiz calculating the boundary and area properties of the Koch Snowflake: What is the perimeter and area of the Koch snowflake after infinitely many iterations? (The perimeter diverges to infinity $L_n = 3 L_0 (4/3)^n \to \infty$, while the enclosed area remains strictly finite $A_\infty = \frac{8}{5} A_0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "box_counting_and_hausdorff_fractal_dimension",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Box-Counting and Similarity Fractal Dimension**\n• **Box-Counting (Capacity) Dimension $D_0$:** Let $N(\\epsilon)$ be the minimum number of mesh boxes of size $\\epsilon$ needed to cover set $F$:\n$$\nD_0 = \\lim_{\\epsilon \\to 0} \\frac{\\ln N(\\epsilon)}{\\ln(1/\\epsilon)}\n$$\n• **Similarity Dimension for Self-Similar Fractals:** If a fractal consists of $N$ self-similar pieces, each scaled down by a factor $r < 1$:\n$$\nN \\cdot r^D = 1 \\implies D = \\frac{\\ln N}{\\ln(1/r)}\n$$\n• **Hausdorff Dimension $D_H$:** Defined via the infimum of coverings by open sets of diameter $\\le \\delta$, satisfying $D_H \\le D_0$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Sierpiński Triangle (Gasket) Construction:**\n• **Step 1 (Base Element):** Start with an equilateral solid triangle of side 1.\n• **Step 2 (Removal):** Cut out the central inverted triangle.\n• **Step 3 (Count & Scale):** Exactly $N = 3$ self-similar triangles remain, each with side length reduced by half ($r = 1/2$).\n• **Step 4 (Dimension Evaluation):**\n  $$D = \\frac{\\ln 3}{\\ln(1 / (1/2))} = \\frac{\\ln 3}{\\ln 2} \\approx 1.5850$$\n  It is strictly greater than a 1D line ($D=1$) and less than a 2D plane ($D=2$)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each fractal to its exact self-similarity parameters (N, r) and fractal dimension.",
      "matchPairs": [
        { "left": "Middle-Thirds Cantor Set", "right": "N = 2, r = 1/3 => D = ln(2)/ln(3) approx 0.6309" },
        { "left": "Koch Snowflake Curve", "right": "N = 4, r = 1/3 => D = ln(4)/ln(3) approx 1.2619" },
        { "left": "Sierpiński Carpet", "right": "N = 8, r = 1/3 => D = ln(8)/ln(3) approx 1.8928" },
        { "left": "Menger Sponge (3D)", "right": "N = 20, r = 1/3 => D = ln(20)/ln(3) approx 2.7268" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the fractal dimension of the middle-thirds Cantor set D = ln(2) / ln(3) rounded to two decimal places.",
      "numericAnswer": 0.63,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the remarkable geometric paradox exhibited by the Koch Snowflake after infinitely many recursive iterations?",
      "options": [
        { "text": "Its perimeter diverges to INFINITY (L_n = 3 * (4/3)^n -> infty) while enclosing a strictly FINITE bounded area (A_infty = (8/5) * A_0)", "isCorrect": true, "explanation": "Correct! At each step, every edge is replaced by 4 edges of length 1/3, multiplying perimeter by 4/3 -> infty, while all triangles stay strictly inside the original circumscribed circle." },
        { "text": "Both perimeter and area diverge to infinity", "isCorrect": false, "explanation": "Incorrect: Area is strictly finite." },
        { "text": "Both perimeter and area converge to zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Perimeter is finite and area is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
