# Duofy Reusable Lesson Format: Hyperbolic and Elliptic Geometry - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry / Hyperbolic_and_Elliptic_Geometry`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Constant Curvature Geometries (Euclidean $K=0$, Elliptic/Spherical $K>0$, Hyperbolic $K<0$), the Poincaré Disk and Upper Half-Plane models, the Angle Defect/Excess Area Formulas ($\operatorname{Area} = |\pi - \sum \alpha_i|$), and Ideal Hyperbolic Triangles.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Curvature Triad & Non-Euclidean Geometries Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Poincaré Disk & Spherical Excess Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Geometry System & Triangle Angle Sum Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Hyperbolic Area Defect Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Ideal Hyperbolic Triangle Area Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the comparison between Euclidean ($K=0$, parallel unique), Hyperbolic ($K=-1$, infinite parallels, $\sum \alpha_i < \pi$), and Elliptic ($K=+1$, no parallels, $\sum \alpha_i > \pi$).
2. **Slide 2 (`concept_pieces`):** Deconstruct Poincaré Disk conformal metric $ds^2 = \frac{4|dz|^2}{(1-|z|^2)^2}$, geodesics as orthogonal circular arcs, hyperbolic area defect $\text{Area} = \pi - (\alpha+\beta+\gamma)$, and Girard's spherical excess $\text{Area} = R^2(\alpha+\beta+\gamma - \pi)$.
3. **Slide 3 (`matching`):** Pair 4 geometry systems (Hyperbolic Plane $\mathbb{H}^2$, Sphere $S^2$, Euclidean Plane $\mathbb{E}^2$, Projective Plane $\mathbb{RP}^2$) with their parallel line properties and curvature.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the area of a hyperbolic triangle is directly proportional to its angle defect. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking what the area of an ideal hyperbolic triangle is (vertices at infinity where all angles are $0^\circ \implies \text{Area} = \pi - 0 = \pi$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Non-Euclidean Geometries of Constant Curvature**\n• **Euclidean Geometry ($K = 0$):** Exactly one parallel line through a point; triangle angle sum $\\sum \\alpha_i = 180^\\circ = \\pi$.\n• **Hyperbolic Geometry ($K = -1$):** Infinitely many parallel lines through a point; triangle angle sum $\\sum \\alpha_i < \\pi$.\n  $$\\operatorname{Area}(\\triangle ABC) = \\pi - (\\alpha + \\beta + \\gamma) \\quad \\text{(Hyperbolic Defect)}$$\n• **Elliptic/Spherical Geometry ($K = +1/R^2$):** No parallel lines (all lines intersect); triangle angle sum $\\sum \\alpha_i > \\pi$.\n  $$\\operatorname{Area}(\\triangle ABC) = R^2 (\\alpha + \\beta + \\gamma - \\pi) \\quad \\text{(Spherical Excess)}$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Poincaré Disk Model:** Conformal metric $ds = \\frac{2|dz|}{1 - |z|^2}$ inside unit disk $|z| < 1$. Geodesics are diameters and circular arcs orthogonal to the boundary circle.\n• **Exponential Space Growth:** Circumference of a hyperbolic circle $C(r) = 2\\pi \\sinh(r)$ grows exponentially with radius.\n• **No Similar Triangles:** In hyperbolic and elliptic geometries, angle sum uniquely determines the size (area) of a triangle (AAA congruence is true congruence!).\n• **Ideal Triangles:** Triangles with vertices on the boundary horizon have angles $(0, 0, 0)$ and finite maximal area $\\pi$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each geometric space to its parallel line and curvature signature.",
      "matchPairs": [
        { "left": "Hyperbolic Plane H^2", "right": "K = -1 with infinitely many parallel lines through any exterior point" },
        { "left": "Spherical Surface S^2", "right": "K > 0 with zero parallel lines (any two great circles meet twice)" },
        { "left": "Euclidean Plane R^2", "right": "K = 0 with a unique parallel line through any exterior point" },
        { "left": "Real Projective Plane RP^2", "right": "K > 0 with zero parallel lines (any two lines meet exactly once)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By the Gauss-Bonnet theorem in the hyperbolic plane, the area of any geodesic triangle is exactly equal to its angular ___ from pi.",
      "blankAnswer": "defect",
      "blankDistractors": ["excess", "dilation", "perimeter"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the exact hyperbolic area of an 'ideal triangle' whose three vertices all lie on the boundary horizon circle (each vertex angle = 0)?",
      "options": [
        { "text": "pi (approximately 3.14159), because Area = pi - (0 + 0 + 0) = pi", "isCorrect": true, "explanation": "Correct! Ideal triangles have zero interior angles, giving the maximal possible area for any hyperbolic triangle: pi." },
        { "text": "Infinity", "isCorrect": false, "explanation": "Incorrect: Although its perimeter is infinite, its hyperbolic area is strictly finite and equals pi." },
        { "text": "2 pi", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
