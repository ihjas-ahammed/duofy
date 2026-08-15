# Duofy Reusable Lesson Format: Affine and Projective Varieties - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_Geometry / Affine_and_Projective_Varieties`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute projective closures of affine curves by homogenization (e.g. $y^2 = x^3 - x \implies y^2 z = x^3 - x z^2$), find their points at infinity on the line $z = 0$, and compute intersection points via Bézout's theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Projective Homogenization Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Point at Infinity Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Bézout Product Count Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Bézout Intersection Count | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Singularity of Cuspidal Cubic Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the homogenization procedure: For $f(x, y) \in k[x, y]$ of degree $d$, its homogenization in $\mathbb{P}^2$ is $F(x, y, z) = z^d f(x/z, y/z)$. For the elliptic curve $y^2 = x^3 - x$, $F(x, y, z) = y^2 z - x^3 + x z^2 = 0$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps of finding points at infinity: (1) set line at infinity $z = 0$, (2) substitute into $F(x, y, 0) = -x^3 = 0 \implies x = 0$, (3) projective coordinates $[x:y:z] = [0:y:0] = [0:1:0]$, (4) conclude there is a single point at infinity $[0:1:0]$ (the flex point of the cubic).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that two projective plane curves of degrees 2 and 3 intersect at exactly six points counted with multiplicity. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the number of intersection points in $\mathbb{P}^2$ between a conic (degree 2) and a quartic (degree 4) by Bézout's theorem ($2 \times 4 = 8.0$).
5. **Slide 5 (`quiz`):** Quiz testing the singularity of the affine cuspidal curve $V(y^2 - x^3)$ at the origin $(0, 0)$ via Jacobian matrix $\nabla f = (-3x^2, 2y) = (0, 0)$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Homogenization and Points at Infinity**\nFor an affine plane curve $f(x, y) = 0$ of degree $d$, its **projective closure** in $\\mathbb{P}^2$ with homogeneous coordinates $[x:y:z]$ is:\n$$\nF(x, y, z) = z^d f\\left(\\frac{x}{z}, \\frac{y}{z}\\right) = 0\n$$\nFor the affine curve $y^2 = x^3 - x$ ($d = 3$):\n$$\nF(x, y, z) = z^3 \\left[ \\left(\\frac{y}{z}\\right)^2 - \\left(\\frac{x}{z}\\right)^3 + \\frac{x}{z} \\right] = y^2 z - x^3 + x z^2 = 0\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Set Line at Infinity):** The line at infinity in the chart $\\mathbb{A}^2 \\hookrightarrow \\mathbb{P}^2$ is given by $z = 0$.\n• **Step 2 (Intersect with Curve):** Substitute $z = 0$ into $F(x, y, z) = y^2(0) - x^3 + x(0)^2 = 0 \\implies -x^3 = 0 \\implies x = 0$.\n• **Step 3 (Determine Projective Coordinates):** With $x = 0$ and $z = 0$, $y$ must be non-zero (since $[0:0:0]$ is not in $\\mathbb{P}^2$). Normalizing gives $[0:1:0]$.\n• **Step 4 (Conclusion):** The cubic curve has exactly **one point at infinity**, namely $\\mathcal{O} = [0:1:0]$ (the neutral element for the elliptic curve group law)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "By Bézout's Theorem, a projective conic curve (degree 2) and a projective cubic curve (degree 3) with no shared components intersect at exactly ___ points counted with multiplicity.",
      "blankAnswer": "six",
      "blankDistractors": ["five", "nine", "three"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Using Bézout's Theorem, compute the total number of intersection points in P^2 between a smooth conic (degree 2) and a quartic curve (degree 4).",
      "numericAnswer": 8.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the origin (0, 0) a singular point of the affine cuspidal cubic curve C = V(y^2 - x^3) in A^2?",
      "options": [
        { "text": "Both partial derivatives vanish at the origin: df/dx = -3x^2 = 0 and df/dy = 2y = 0 at (0, 0)", "isCorrect": true, "explanation": "Correct! A point p on V(f) is singular if the gradient vector grad(f)(p) = (0, 0), which occurs at the cusp (0, 0)." },
        { "text": "Because the curve is not continuous at (0, 0)", "isCorrect": false, "explanation": "Incorrect: The polynomial function is continuous everywhere." },
        { "text": "Because y^2 - x^3 is not irreducible", "isCorrect": false, "explanation": "Incorrect: y^2 - x^3 is irreducible in k[x, y]." },
        { "text": "Because the origin is a point at infinity", "isCorrect": false, "explanation": "Incorrect: (0, 0) is an affine point." }
      ]
    }
  ]
}
```
