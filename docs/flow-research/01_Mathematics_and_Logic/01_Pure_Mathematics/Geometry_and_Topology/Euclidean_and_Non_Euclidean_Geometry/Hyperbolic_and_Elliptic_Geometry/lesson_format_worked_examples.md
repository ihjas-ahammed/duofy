# Duofy Reusable Lesson Format: Hyperbolic and Elliptic Geometry - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry/Hyperbolic_and_Elliptic_Geometry`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the hyperbolic area of triangles given their interior angles (e.g. an equilateral hyperbolic triangle with angles $\pi/4, \pi/4, \pi/4$), evaluate spherical triangle areas on Earth's surface via Girard's theorem, and calculate distance in the Poincaré Upper Half Plane $d_{\mathbb{H}}(z_1, z_2) = \operatorname{arcosh}\left(1 + \frac{|z_1 - z_2|^2}{2 y_1 y_2}\right)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hyperbolic Equilateral Triangle Area Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Angle Defect Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Maximal Area Bound Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Hyperbolic Area Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Poincaré Half Plane Distance Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the worked problem: Compute the area of an equilateral triangle $\triangle ABC$ in the hyperbolic plane $\mathbb{H}^2$ where each interior angle is $\alpha = \beta = \gamma = 45^\circ = \pi/4$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) sum of interior angles: $\sigma = \pi/4 + \pi/4 + \pi/4 = 3\pi/4$, (2) evaluate angle defect: $\delta = \pi - \sigma = \pi - 3\pi/4 = \pi/4$, (3) apply area formula: $\operatorname{Area}(\triangle ABC) = \delta = \pi/4 \approx 0.7854$, (4) compare to Euclidean ($0$ defect, unconstrained size) and spherical ($>180^\circ$).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the maximal possible area of any triangle in the hyperbolic plane is strictly bounded above by pi. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the exact area of the equilateral hyperbolic triangle with angles $\pi/4$ ($\pi/4 \approx 0.7854$, answer 0.79).
5. **Slide 5 (`quiz`):** Quiz calculating the hyperbolic distance between $z_1 = 2i$ and $z_2 = 8i$ along the imaginary axis in $\mathbb{H}^2$: $d = \int_2^8 \frac{dy}{y} = \ln(8/2) = \ln(4) = 2\ln 2$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing the Area of a Hyperbolic Triangle**\nIn the Hyperbolic Plane $\\mathbb{H}^2$ ($K = -1$):\n• The area of any geodesic triangle is uniquely determined by its **angular defect**:\n$$\n\\operatorname{Area}(\\triangle ABC) = \\pi - (\\alpha + \\beta + \\gamma)\n$$\nLet $\\triangle ABC$ be an equilateral hyperbolic triangle with interior angles $\\alpha = \\beta = \\gamma = 45^\\circ = \\frac{\\pi}{4}$ radians."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Sum Angles):** $\\Sigma = \\alpha + \\beta + \\gamma = \\frac{\\pi}{4} + \\frac{\\pi}{4} + \\frac{\\pi}{4} = \\frac{3\\pi}{4}$ radians ($135^\\circ$).\n• **Step 2 (Compute Defect):** $\\delta = \\pi - \\frac{3\\pi}{4} = \\frac{\\pi}{4}$ radians ($45^\\circ$).\n• **Step 3 (Hyperbolic Area):** $\\operatorname{Area}(\\triangle ABC) = \\frac{\\pi}{4} \\approx 0.7854$.\n• **Step 4 (Size Uniqueness):** Unlike Euclidean geometry where equilateral triangles can have any size, in hyperbolic geometry an equilateral triangle with angles $45^\\circ$ has one unique, fixed size!"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In the hyperbolic plane of Gaussian curvature K = -1, the area of any triangle is strictly bounded from above by ___.",
      "blankAnswer": "pi",
      "blankDistractors": ["2pi", "infinity", "one"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the area of the hyperbolic equilateral triangle with interior angles alpha = beta = gamma = pi/4 (to two decimal places).",
      "numericAnswer": 0.79,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In the Poincaré Upper Half Plane H^2 with metric ds = dy/y along the imaginary axis, what is the hyperbolic distance between z_1 = 2i and z_2 = 8i?",
      "options": [
        { "text": "ln(4) = 2 ln(2) (approx 1.386)", "isCorrect": true, "explanation": "Correct! Distance along the vertical geodesic is int_2^8 (1/y) dy = ln(8) - ln(2) = ln(8/2) = ln(4)." },
        { "text": "6 (Euclidean distance 8 - 2)", "isCorrect": false, "explanation": "Incorrect: Euclidean distance ignores the 1/y metric scaling." },
        { "text": "16", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "4", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
