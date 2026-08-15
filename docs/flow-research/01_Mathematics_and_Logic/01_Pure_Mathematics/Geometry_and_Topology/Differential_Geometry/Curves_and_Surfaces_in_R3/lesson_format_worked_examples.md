# Duofy Reusable Lesson Format: Curves and Surfaces in R3 - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry / Curves_and_Surfaces_in_R3`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the First ($I$) and Second ($II$) Fundamental Forms, Gaussian Curvature $K$, and Mean Curvature $H$ for a standard surface of revolution (e.g. the standard Torus $\mathbf{r}(u, v) = ((R + r\cos u)\cos v, (R + r\cos u)\sin v, r\sin u)$), and identify its parabolic/hyperbolic regions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Torus Parametrization & Metric Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fundamental Forms Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Gaussian Curvature Sign Transition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Total Curvature Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Circular Helix Torsion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the parametrization of the torus of revolution: $\mathbf{r}(u, v) = ((R + r \cos u)\cos v, (R + r \cos u)\sin v, r \sin u)$ for $u, v \in [0, 2\pi)$ ($R > r > 0$).
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) tangent vectors $\mathbf{r}_u, \mathbf{r}_v$, (2) First Fundamental Form: $E = r^2, F = 0, G = (R + r \cos u)^2$, (3) Second Fundamental Form: $e = r, f = 0, g = (R + r \cos u)\cos u$, (4) Curvatures: $K = \frac{eg - f^2}{EG - F^2} = \frac{r(R + r\cos u)\cos u}{r^2(R + r\cos u)^2} = \frac{\cos u}{r(R + r \cos u)}$, $H = \frac{R + 2r\cos u}{2r(R + r\cos u)}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that for $u \in (\pi/2, 3\pi/2)$ on the inner tube, $\cos u < 0$, so the Gaussian curvature is negative. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the total integral of Gaussian curvature $\iint_{T^2} K dA = 2\pi \chi(T^2) = 2\pi(0) = 0.0$.
5. **Slide 5 (`quiz`):** Quiz calculating the constant curvature and torsion of a circular helix $\alpha(t) = (a\cos t, a\sin t, bt)$: $\kappa = \frac{a}{a^2 + b^2}, \tau = \frac{b}{a^2 + b^2}$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Curvatures of the Torus of Revolution**\nParametrize the torus $T^2$ in $\\mathbb{R}^3$ with major radius $R$ and minor radius $r$ ($R > r > 0$):\n$$\n\\mathbf{r}(u, v) = \\big( (R + r \\cos u)\\cos v, \\; (R + r \\cos u)\\sin v, \\; r \\sin u \\big), \\quad u, v \\in [0, 2\\pi)\n$$\nWe will compute the First and Second Fundamental Forms and find Gaussian curvature $K(u, v)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (First Form $I$):** Tangent vectors are orthogonal ($F = \\mathbf{r}_u \\cdot \\mathbf{r}_v = 0$). $E = \\|\\mathbf{r}_u\\|^2 = r^2$, $G = \\|\\mathbf{r}_v\\|^2 = (R + r \\cos u)^2$.\n• **Step 2 (Second Form $II$):** Unit normal $\\mathbf{n} = -(\\cos u \\cos v, \\cos u \\sin v, \\sin u)$. Coefficients are $e = r$, $f = 0$, $g = (R + r \\cos u)\\cos u$.\n• **Step 3 (Gaussian Curvature $K$):**\n  $$K(u) = \\frac{eg - f^2}{EG - F^2} = \\frac{r(R + r \\cos u)\\cos u}{r^2(R + r \\cos u)^2} = \\frac{\\cos u}{r(R + r \\cos u)}$$\n• **Step 4 (Geometric Regions):** $K > 0$ on outer equator ($-\\pi/2 < u < \\pi/2$), $K = 0$ on top/bottom circles ($u = \\pm \\pi/2$), and $K < 0$ on inner equator ($\\pi/2 < u < 3\\pi/2$)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "On the inner equator of the torus (where cos u is negative), the Gaussian curvature K is strictly ___.",
      "blankAnswer": "negative",
      "blankDistractors": ["positive", "zero", "infinite"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Using the Gauss-Bonnet theorem, compute the exact total Gaussian curvature iint_{T^2} K dA over the entire torus surface.",
      "numericAnswer": 0.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For the circular helix alpha(t) = (a cos t, a sin t, b t), what are its curvature kappa and torsion tau?",
      "options": [
        { "text": "kappa = a / (a^2 + b^2) and tau = b / (a^2 + b^2) (both strictly constant)", "isCorrect": true, "explanation": "Correct! Arc length speed is c = sqrt(a^2 + b^2). Second derivative gives kappa = a/c^2, and third derivative gives tau = b/c^2." },
        { "text": "kappa = a and tau = b", "isCorrect": false, "explanation": "Incorrect: Arc length reparametrization introduces the denominator a^2 + b^2." },
        { "text": "kappa = 1/a and tau = 0", "isCorrect": false, "explanation": "Incorrect: tau = 0 would imply a planar circle." },
        { "text": "kappa = 0 and tau = 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
