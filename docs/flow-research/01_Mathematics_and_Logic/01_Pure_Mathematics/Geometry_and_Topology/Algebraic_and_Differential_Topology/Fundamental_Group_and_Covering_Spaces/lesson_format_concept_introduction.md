# Duofy Reusable Lesson Format: Fundamental Group and Covering Spaces - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology / Fundamental_Group_and_Covering_Spaces`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the Fundamental Group $\pi_1(X, x_0)$ via homotopy classes of loops, the definition of a Covering Space $p: \tilde{X} \to X$ with evenly covered neighborhoods, and the Galois Correspondence classifying covering spaces by subgroups of $\pi_1(X)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fundamental Group & Covering Space Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Loop Unwrapping Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Topological Space & $\pi_1$ Group Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Universal Cover Triviality Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Van Kampen Wedge Sum Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the fundamental group $\pi_1(X, x_0)$ (loop homotopy equivalence classes with concatenation $[\gamma_1] \cdot [\gamma_2]$) and covering space $p: \tilde{X} \to X$ where every point has an evenly covered neighborhood $p^{-1}(U) = \bigsqcup V_\alpha$.
2. **Slide 2 (`concept_pieces`):** Deconstruct loop concatenation, path lifting property, Galois correspondence (subgroups $H \le \pi_1(X) \leftrightarrow$ covering spaces), and Van Kampen amalgamation.
3. **Slide 3 (`matching`):** Pair 4 spaces ($S^1$, $T^2$, $S^1 \vee S^1$, $\mathbb{RP}^2$) with their fundamental groups ($\mathbb{Z}$, $\mathbb{Z} \times \mathbb{Z}$, $\mathbb{Z} * \mathbb{Z}$, $\mathbb{Z}_2$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the universal covering space is simply connected with trivial fundamental group. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking what the fundamental group of the figure-eight space $S^1 \vee S^1$ is by Van Kampen's theorem (Free group on 2 generators, $F_2 \cong \mathbb{Z} * \mathbb{Z}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Fundamental Group and Covering Spaces**\n• The **Fundamental Group** $\\pi_1(X, x_0)$ is the set of homotopy classes $[\\gamma]$ of loops based at $x_0$, with group operation given by loop concatenation:\n$$\n(\\gamma_1 \\cdot \\gamma_2)(t) = \\begin{cases} \\gamma_1(2t) & 0 \\le t \\le 1/2 \\\\ \\gamma_2(2t - 1) & 1/2 \\le t \\le 1 \\end{cases}\n$$\n• A **Covering Space** $p: \\tilde{X} \\to X$ is a continuous map where every $x \\in X$ has an open neighborhood $U$ that is **evenly covered**: $p^{-1}(U) = \\bigsqcup V_\\alpha$ with $p|_{V_\\alpha}: V_\\alpha \\to U$ a homeomorphism."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Path Lifting:** Any path $\\gamma$ in $X$ lifts uniquely to a path $\\tilde{\\gamma}$ in $\\tilde{X}$ starting at any chosen basepoint in the fiber $p^{-1}(\\gamma(0))$.\n• **Galois Correspondence:** Connected covering spaces of $X$ correspond bijectively to conjugacy classes of subgroups $H \\le \\pi_1(X, x_0)$.\n• **Universal Cover:** The unique simply connected covering space $\\tilde{X}$ (with $\\pi_1(\\tilde{X}) = \\{1\\}$), corresponding to the trivial subgroup.\n• **Van Kampen's Theorem:** Computes $\\pi_1(A \\cup B) \\cong \\pi_1(A) *_{\\pi_1(A \\cap B)} \\pi_1(B)$ via amalgamated free products."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each topological space to its fundamental group pi_1.",
      "matchPairs": [
        { "left": "Circle S^1", "right": "Z (The infinite cyclic group of integers)" },
        { "left": "Torus T^2 = S^1 x S^1", "right": "Z x Z (Free abelian group of rank 2)" },
        { "left": "Figure-Eight Space S^1 v S^1", "right": "Z * Z = F_2 (Free non-abelian group on 2 generators)" },
        { "left": "Real Projective Plane RP^2", "right": "Z_2 (Cyclic group of order 2)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The universal covering space of a path-connected topological space is unique up to isomorphism and is strictly ___ connected.",
      "blankAnswer": "simply",
      "blankDistractors": ["locally", "path", "compactly"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "By Van Kampen's Theorem, what is the fundamental group of the wedge sum of two circles X = S^1 v S^1 joined at a single point?",
      "options": [
        { "text": "The free group on two generators F_2 = <a, b | > (isomorphic to Z * Z)", "isCorrect": true, "explanation": "Correct! Van Kampen with contractible intersection A intersect B = {x_0} gives pi_1(S^1) *_{1} pi_1(S^1) = Z * Z = F_2." },
        { "text": "Z x Z", "isCorrect": false, "explanation": "Incorrect: Z x Z is the fundamental group of the Torus T^2 where loops commute." },
        { "text": "Z_2", "isCorrect": false, "explanation": "Incorrect: Z_2 is for RP^2." },
        { "text": "Trivial group {1}", "isCorrect": false, "explanation": "Incorrect: Figure-eight has non-contractible loops." }
      ]
    }
  ]
}
```
