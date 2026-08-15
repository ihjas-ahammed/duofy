# Duofy Reusable Lesson Format: Banach and Hilbert Spaces - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Banach_and_Hilbert_Spaces`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Riesz Representation Theorem** on Hilbert spaces and the **Hahn-Banach Extension Theorem** on normed vector spaces.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Riesz Representation Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Orthogonal Kernel Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Representing Vector Uniqueness Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Hahn-Banach Extension Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Functional Analysis Core Pillar Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Riesz Representation Theorem: For every continuous linear functional $\phi \in H^*$, there exists a unique $y \in H$ such that $\phi(x) = \langle x, y \rangle$ and $\|\phi\| = \|y\|$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) if $\phi = 0$, pick $y = 0$, (2) if $\phi \ne 0$, let $M = \ker(\phi)$, a closed proper subspace of $H$, (3) choose non-zero $z_0 \in M^\perp$ by the projection theorem, (4) for any $x \in H$, show $x - \frac{\phi(x)}{\phi(z_0)}z_0 \in M$, (5) deduce $\langle x, z_0 \rangle = \frac{\phi(x)}{\phi(z_0)}\|z_0\|^2$, setting $y = \frac{\overline{\phi(z_0)}}{\|z_0\|^2} z_0$.
3. **Slide 3 (`quiz`):** Test why the kernel $M = \ker(\phi)$ is guaranteed to be a closed subspace of $H$.
4. **Slide 4 (`proof`):** Interactive derivation showing norm equality $\|\phi\|_{H^*} = \|y\|_H$ via Cauchy-Schwarz inequality.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the representation theorem (Riesz).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Riesz Representation Theorem**\nLet $H$ be a complex Hilbert space.\nFor every continuous linear functional $\\phi \\in H^*$, there exists a **unique vector** $y \\in H$ such that:\n$$\n\\phi(x) = \\langle x, y \\rangle \\quad \\text{for all } x \\in H\n$$\nMoreover, the operator norm of $\\phi$ equals the Hilbert norm of $y$:\n$$\n\\|\\phi\\|_{H^*} = \\|y\\|_H\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps constructing the Riesz representing vector y.",
      "orderItems": [
        "If phi = 0, choose y = 0. Otherwise, let M = ker(phi), which is a closed proper subspace of H since phi is continuous",
        "By the Projection Theorem, M^perp is non-trivial; choose a non-zero vector z_0 in M^perp",
        "For any x in H, express x = (x - [phi(x)/phi(z_0)] z_0) + [phi(x)/phi(z_0)] z_0, noting the first term is in M",
        "Take inner product with z_0: <x, z_0> = 0 + [phi(x)/phi(z_0)] ||z_0||^2",
        "Solve for phi(x) = <x, y> where y = [conj(phi(z_0)) / ||z_0||^2] z_0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the null space M = ker(phi) guaranteed to be a closed subspace of the Hilbert space H?",
      "options": [
        { "text": "M is the inverse image of the closed set {0} under the continuous function phi (M = phi^{-1}({0}))", "isCorrect": true, "explanation": "Correct! Continuous preimages of closed sets are closed in topological spaces." },
        { "text": "Because H is finite-dimensional", "isCorrect": false, "explanation": "Incorrect: H can be infinite-dimensional." },
        { "text": "Because phi is a linear operator", "isCorrect": false, "explanation": "Incorrect: Linearity alone does not guarantee a closed kernel; continuity is required." },
        { "text": "Because M contains all orthonormal basis elements", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Norm Equality ||phi|| = ||y||",
      "interactiveSteps": [
        {
          "stepText": "By Cauchy-Schwarz, |phi(x)| = |<x, y>| <= ||x|| ||y||, which implies ||phi|| <= ||y||."
        },
        {
          "prompt": "Evaluating phi on the specific unit-norm vector x_0 = y / ||y|| (for y != 0), what value does phi(x_0) yield?",
          "options": [
            { "text": "phi(x_0) = <y / ||y||, y> = ||y||^2 / ||y|| = ||y||", "isCorrect": true },
            { "text": "phi(x_0) = 0", "isCorrect": false },
            { "text": "phi(x_0) = 1", "isCorrect": false },
            { "text": "phi(x_0) = ||y||^2", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since |phi(x_0)| = ||y|| for a unit vector, ||phi|| = sup_{||x||=1} |phi(x)| >= ||y||, confirming ||phi|| = ||y||."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What Hungarian mathematician proved the fundamental duality theorem representing functionals on Hilbert spaces as inner products?",
      "blankAnswer": "riesz"
    }
  ]
}
```
