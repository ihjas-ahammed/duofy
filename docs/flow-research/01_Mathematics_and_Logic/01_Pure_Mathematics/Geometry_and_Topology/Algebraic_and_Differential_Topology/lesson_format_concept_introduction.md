# Duofy Reusable Lesson Format: Algebraic & Differential Topology - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the Fundamental Group $\pi_1(X, x_0)$, Homology Groups $H_k(X) = \frac{\text{Ker }\partial_k}{\text{Im }\partial_{k+1}}$ ($\partial^2 = 0$), Betti Numbers $b_k$, and Homotopy Equivalences.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fundamental Group & Homology Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Chain Complex & Boundary Operator Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Space & Fundamental Group Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Boundary Operator Square Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Simply Connected Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Fundamental Group & Homology**\n1. The **Fundamental Group** $\\pi_1(X, x_0)$ consists of homotopy classes $[\\gamma]$ of loops based at $x_0$ under concatenation.\n2. **Homology Group $H_k(X)$:** Chain complex $C_k$ with boundary operator $\\partial_k: C_k \\to C_{k-1}$ satisfying $\\partial_{k-1} \\circ \\partial_k = 0$:\n$$\nH_k(X) = \\frac{\\text{Ker}(\\partial_k)}{\\text{Im}(\\partial_{k+1})} = \\frac{k\\text{-Cycles}}{k\\text{-Boundaries}}\n$$\nBetti number $b_k = \\text{rank}(H_k(X))$ counts $k$-dimensional voids."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Boundary of Boundary is Zero:** $\\partial^2 = 0$ is the foundational identity of all homology and cohomology theories.\n• **Betti Numbers:** $b_0$ = connected components, $b_1$ = 1D loops/tunnels, $b_2$ = 2D enclosed voids.\n• **Homotopy Invariance:** If spaces $X$ and $Y$ are homotopy equivalent ($X \\simeq Y$), then $\\pi_1(X) \\cong \\pi_1(Y)$ and $H_k(X) \\cong H_k(Y)$.\n• **Deformation Retract:** A sub-space $A \\subset X$ to which $X$ continuously shrinks preserves all homology groups."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each topological space to its exact Fundamental Group π₁.",
      "matchPairs": [
        { "left": "Circle S^1", "right": "Z (Infinite cyclic group)" },
        { "left": "Torus T^2 = S^1 × S^1", "right": "Z × Z (Free abelian of rank 2)" },
        { "left": "Sphere S^2", "right": "{0} (Trivial group / Simply connected)" },
        { "left": "Figure Eight (S^1 ∨ S^1)", "right": "F₂ (Free non-abelian group on 2 generators)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The central property of chain complex boundary operators states that applying partial twice yields ___ (∂^2 = 0).",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "identity", "dimension"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What are the Betti numbers $(b_0, b_1, b_2)$ for the 2-dimensional Torus $T^2$?",
      "options": [
        { "text": "(1, 2, 1) — 1 component, 2 independent 1D loops, 1 enclosed 2D cavity", "isCorrect": true, "explanation": "Correct! H₀(T²) ≅ Z, H₁(T²) ≅ Z², H₂(T²) ≅ Z." },
        { "text": "(1, 0, 1)", "isCorrect": false, "explanation": "Incorrect: That describes the 2-sphere S²." },
        { "text": "(1, 1, 0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "(2, 1, 1)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
