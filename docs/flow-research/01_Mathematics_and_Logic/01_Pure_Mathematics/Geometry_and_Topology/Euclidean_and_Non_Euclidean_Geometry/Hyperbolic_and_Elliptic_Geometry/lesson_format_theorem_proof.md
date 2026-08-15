# Duofy Reusable Lesson Format: Hyperbolic and Elliptic Geometry - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry / Hyperbolic_and_Elliptic_Geometry`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of **Girard's Theorem for Spherical Excess** ($\operatorname{Area}(\triangle) = R^2(\alpha + \beta + \gamma - \pi)$) via lune intersections, and derive the **Hyperbolic Area Formula via Gauss-Bonnet**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Girard's Spherical Triangle Area Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Lune Double-Covering Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Antipodal Triangle Pairing Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Hyperbolic Triangle Gauss-Bonnet Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Conformal Metric Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Girard's Theorem (1629): On a sphere of radius $R$, the area of a geodesic triangle $\triangle ABC$ with angles $\alpha, \beta, \gamma$ (in radians) is given by $\operatorname{Area}(\triangle ABC) = R^2(\alpha + \beta + \gamma - \pi) = R^2 E$.
2. **Slide 2 (`ordering`):** Provide 5 steps of Girard's proof using spherical lunes: (1) extend the 3 great circle sides of $\triangle ABC$ around the entire sphere, (2) observe that two great circles meeting at angle $\theta$ form a lune of area $2\theta R^2$, (3) sum the areas of the 3 pairs of antipodal lunes for angles $\alpha, \beta, \gamma$: $\sum \operatorname{Area}(\text{Lunes}) = 4 R^2(\alpha + \beta + \gamma)$, (4) note that the 3 lunes cover the entire sphere of area $4\pi R^2$, with $\triangle ABC$ and its antipodal triangle $\triangle A'B'C'$ covered 3 times each, (5) formulate the inclusion-exclusion equation: $4 R^2(\alpha + \beta + \gamma) = 4\pi R^2 + 4 \operatorname{Area}(\triangle ABC)$, solving to obtain $\operatorname{Area}(\triangle ABC) = R^2(\alpha + \beta + \gamma - \pi)$.
3. **Slide 3 (`quiz`):** Test why the antipodal triangle $\triangle A'B'C'$ has the exact same area as $\triangle ABC$ (by central symmetry inversion).
4. **Slide 4 (`proof`):** Interactive derivation of hyperbolic triangle area $\operatorname{Area}(\triangle) = \iint K dA = -1 \cdot (\alpha + \beta + \gamma - \pi) = \pi - (\alpha + \beta + \gamma)$ using local Gauss-Bonnet with geodesic curvature $k_g = 0$ along the boundary edges.
5. **Slide 5 (`one_word`):** Plain-text recall of the geometric term meaning angle-preserving (conformal).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Girard's Formula for Spherical Triangles**\nLet $\\triangle ABC$ be a geodesic triangle on a 2-sphere of radius $R$, with interior angles $\\alpha, \\beta, \\gamma$ measured in radians.\nThe surface area of the triangle is directly proportional to its **spherical excess** $E = \\alpha + \\beta + \\gamma - \\pi$:\n$$\n\\operatorname{Area}(\\triangle ABC) = R^2 (\\alpha + \\beta + \\gamma - \\pi)\n$$\n*(In hyperbolic space with $K = -1$, the sign flips: $\\operatorname{Area} = \\pi - (\\alpha + \\beta + \\gamma)$).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical steps of Girard's proof of spherical triangle area using lune decompositions.",
      "orderItems": [
        "Extend the three great circle edges of triangle ABC around the whole sphere, producing antipodal triangle A'B'C'",
        "Calculate the area of each pair of antipodal lunes corresponding to angles alpha, beta, gamma: Area = 2 * (2 theta R^2) = 4 theta R^2",
        "Sum the areas of the three pairs of lunes: Total = 4 R^2 (alpha + beta + gamma)",
        "Observe that the lunes cover the entire sphere (surface area 4 pi R^2), with triangle ABC and triangle A'B'C' each covered 3 times (2 excess overlaps each)",
        "Set up the balance: 4 R^2 (alpha + beta + gamma) = 4 pi R^2 + 4 Area(ABC), and divide by 4 to conclude Area(ABC) = R^2(alpha + beta + gamma - pi)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the antipodal triangle A'B'C' guaranteed to have the EXACT same surface area and angles as triangle ABC on the sphere?",
      "options": [
        { "text": "The spatial reflection map x -> -x is an isometry of the sphere mapping ABC directly onto A'B'C'", "isCorrect": true, "explanation": "Correct! Central inversion x -> -x preserves distances and angles, making the antipodal triangle congruent with identical area." },
        { "text": "Because all triangles on a sphere are congruent", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the sphere is flat", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the area of any triangle on a sphere is 4 pi R^2", "isCorrect": false, "explanation": "Incorrect: 4 pi R^2 is the area of the entire sphere." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Hyperbolic Triangle Area via Gauss-Bonnet",
      "interactiveSteps": [
        {
          "stepText": "Let T be a geodesic triangle in the hyperbolic plane H^2 (K = -1). By Gauss-Bonnet, iint_T K dA + sum (pi - alpha_i) = 2pi."
        },
        {
          "prompt": "Since K = -1, iint_T K dA = -Area(T). Substituting into -Area(T) + 3pi - (alpha + beta + gamma) = 2pi, what is Area(T)?",
          "options": [
            { "text": "Area(T) = pi - (alpha + beta + gamma)", "isCorrect": true },
            { "text": "Area(T) = alpha + beta + gamma - pi", "isCorrect": false },
            { "text": "Area(T) = 2pi", "isCorrect": false },
            { "text": "Area(T) = 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus Area(T) = pi - (alpha + beta + gamma), establishing the exact hyperbolic area defect formula."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What adjective describes a geometric projection or model (like the Poincaré Disk) that preserves angle measurements at all intersections?",
      "blankAnswer": "conformal"
    }
  ]
}
```
