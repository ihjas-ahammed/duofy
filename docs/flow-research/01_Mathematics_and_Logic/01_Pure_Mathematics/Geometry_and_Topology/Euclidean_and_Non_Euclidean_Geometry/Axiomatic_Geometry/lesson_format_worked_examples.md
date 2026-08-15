# Duofy Reusable Lesson Format: Axiomatic Geometry - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry / Axiomatic_Geometry`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate and prove statements in Neutral Geometry (e.g. proving that the existence of a single rectangle with 4 right angles implies Euclid's Parallel Postulate, and calculating the angle defect $\delta(\triangle) = 180^\circ - (\alpha + \beta + \gamma)$ of triangles and quadrilaterals).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Rectangle Implies Parallel Postulate Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Rectangle Tiling Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Triangle Defect Non-Negativity Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Quadrilateral Defect Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Hilbert Incidence Axiom Line Intersection Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the theorem: In neutral geometry, if there exists a single rectangle (a quadrilateral with four right angles), then the sum of angles of *every* triangle is $180^\circ$, which is equivalent to Euclid's Parallel Postulate.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) splitting the rectangle along a diagonal creates two right triangles with angle sum $180^\circ$, (2) by pasting congruent copies, arbitrarily large right triangles with angle sum $180^\circ$ can be constructed, (3) any right triangle can be embedded inside a large rectangle, showing its defect $\delta = 0$, (4) any general triangle decomposes into two right triangles by dropping an altitude, proving $\delta(\triangle ABC) = \delta_1 + \delta_2 = 0 + 0 = 0 \implies \sigma(\triangle ABC) = 180^\circ$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the angle defect $\delta(\triangle) = 180^\circ - \sigma(\triangle)$ is strictly additive when a triangle is subdivided. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the angle defect of a hyperbolic quadrilateral $ABCD$ whose interior angles are all $80^\circ$: $\delta(ABCD) = 360^\circ - (4 \times 80^\circ) = 360 - 320 = 40.0^\circ$.
5. **Slide 5 (`quiz`):** Quiz testing the incidence axiom: Prove from Hilbert's incidence axioms that two distinct lines $\ell, m$ can intersect in at most one point (if they intersected at two distinct points $P, Q$, then two distinct lines would pass through $P$ and $Q$, contradicting Axiom I.1).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Equivalence: Existence of a Rectangle Implies Euclid's Parallel Postulate**\nIn Neutral Geometry, a **rectangle** is defined as a quadrilateral with four right angles ($90^\\circ$).\n• **Theorem (Clairaut / Saccheri):** If there exists a *single* rectangle in neutral geometry, then Euclid's 5th Postulate holds, and *every* triangle has angle sum exactly $180^\\circ$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Right Triangle):** Splitting the given rectangle across its diagonal produces two congruent right triangles, each with angle sum $90^\\circ + 90^\\circ = 180^\\circ$ (defect $\\delta = 0$).\n• **Step 2 (Tiling Larger Rectangles):** Pasting identical rectangles creates arbitrarily large rectangles, generating arbitrarily large right triangles with angle sum $180^\\circ$.\n• **Step 3 (Any Right Triangle):** Any given right triangle can be embedded inside a larger rectangle, proving its angle sum must also be exactly $180^\\circ$.\n• **Step 4 (General Triangles):** Dropping an altitude decomposes any general triangle into two right triangles: $\\sigma(\\triangle ABC) = \\sigma_1 + \\sigma_2 - 180^\\circ = 180^\\circ + 180^\\circ - 180^\\circ = 180^\\circ$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "When a triangle is divided into two smaller triangles by an altitude, the total angle defect of the large triangle is strictly ___ to the sum of the defects of the two smaller triangles.",
      "blankAnswer": "equal",
      "blankDistractors": ["opposite", "double", "orthogonal"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the angle defect delta(Q) = 360 - sum(angles) in degrees for a hyperbolic quadrilateral whose four angles each measure exactly 80 degrees.",
      "numericAnswer": 40.0,
      "numericTolerance": 0.1
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Using only Hilbert's Incidence Axiom I.1 ('For any two distinct points A and B, there exists a unique line containing both'), why can two distinct lines l and m intersect in at most ONE point?",
      "options": [
        { "text": "If l and m intersected at two distinct points P and Q, both l and m would be lines containing P and Q, which violates the uniqueness of the line through P and Q", "isCorrect": true, "explanation": "Correct! If |l intersect m| >= 2, uniqueness of the line through two points is contradicted." },
        { "text": "Because lines are parallel", "isCorrect": false, "explanation": "Incorrect: Intersecting lines are not parallel." },
        { "text": "Because lines are 1-dimensional", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all angles must be 90 degrees", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
