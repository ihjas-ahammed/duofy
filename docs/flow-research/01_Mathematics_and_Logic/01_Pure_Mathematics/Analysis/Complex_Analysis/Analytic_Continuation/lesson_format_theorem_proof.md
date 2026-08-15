# Duofy Reusable Lesson Format: Analytic Continuation - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Analytic_Continuation`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the statement and proof of the **Monodromy Theorem** and the **Schwarz Reflection Principle**, connecting path homotopy to single-valuedness and reflection symmetry across boundaries.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Monodromy Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Homotopy Continuation Step Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Homotopy Deformation Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Schwarz Reflection Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Reflection Formula Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Monodromy Theorem: Let $D \subseteq \mathbb{C}$ be simply connected, $z_0 \in D$, and $(f, D_0)$ a function element at $z_0$. If $(f, D_0)$ admits analytic continuation along every curve in $D$, the continuation defines a single-valued holomorphic function on all of $D$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) consider two homotopic paths $\gamma_0, \gamma_1$ with fixed endpoints, (2) let $H(s, t)$ be the continuous homotopy between them, (3) cover the compact square $[0, 1] \times [0, 1]$ with disks where continuation is locally possible, (4) use Lebesgue number to subdivide into small squares where continuation along paths is invariant, (5) conclude that the continuations along $\gamma_0$ and $\gamma_1$ arrive at the same function element at the target.
3. **Slide 3 (`quiz`):** Test why simply connected domains guarantee that all closed loops are homotopic to a point.
4. **Slide 4 (`proof`):** Interactive derivation of Schwarz Reflection $f(z) = \overline{f(\overline{z})}$ for $\text{Im}(z) < 0$ and checking Cauchy-Riemann equations.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the theorem (Monodromy).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Monodromy Theorem**\nLet $D \\subseteq \\mathbb{C}$ be a **simply connected** domain, $z_0 \\in D$, and $(f_0, D_0)$ a function element at $z_0$.\nIf $(f_0, D_0)$ can be analytically continued along every curve in $D$ starting at $z_0$, then:\n$$\nf(z) = \\text{Continuation along any path from } z_0 \\text{ to } z\n$$\nis **independent of the path**, defining a single-valued, holomorphic function on the entire domain $D$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps in proving the Monodromy Theorem for homotopic curves.",
      "orderItems": [
        "Let gamma_0 and gamma_1 be two homotopic paths from z_0 to z_1, with homotopy H : [0, 1] x [0, 1] -> D",
        "Pull back the domain D and use compactness of [0, 1]^2 to find a Lebesgue number delta > 0",
        "Subdivide [0, 1]^2 into a grid of small squares with diameter < delta",
        "Show that analytic continuation along the perimeter of any small square yields the identical function element",
        "Inductively replace path gamma_0 with gamma_1 square by square to prove both paths yield the exact same function element at z_1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is simple connectedness of the domain D an essential hypothesis in the Monodromy Theorem?",
      "options": [
        { "text": "In a non-simply connected domain (like C \\ {0}), paths can loop around branch points, creating distinct multi-valued branches", "isCorrect": true, "explanation": "Correct! Looping around a hole/singularity can produce non-homotopic paths that accumulate monodromy (e.g. ln(z) increasing by 2*pi*i)." },
        { "text": "Because non-simply connected domains cannot contain open disks", "isCorrect": false, "explanation": "Incorrect: All open sets contain disks." },
        { "text": "Because power series only converge on convex sets", "isCorrect": false, "explanation": "Incorrect: Power series converge on circular disks." },
        { "text": "Because the derivative of f must be zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Schwarz Reflection Principle",
      "interactiveSteps": [
        {
          "stepText": "Let f(z) = u(x, y) + i v(x, y) be holomorphic in the upper half plane {y > 0}, with v(x, 0) = 0 on the real axis."
        },
        {
          "prompt": "For z = x - i y with y > 0 (in the lower half-plane), how is the holomorphic extension F(z) defined?",
          "options": [
            { "text": "F(z) = conj(f(conj(z))) = u(x, -y) - i v(x, -y)", "isCorrect": true },
            { "text": "F(z) = f(-z)", "isCorrect": false },
            { "text": "F(z) = -f(z)", "isCorrect": false },
            { "text": "F(z) = 1 / f(z)", "isCorrect": false }
          ]
        },
        {
          "stepText": "Applying Cauchy-Riemann equations and Morera's Theorem confirms F(z) is holomorphic across the entire real axis."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What fundamental theorem guarantees that analytic continuation in a simply connected domain is path-independent?",
      "blankAnswer": "monodromy"
    }
  ]
}
```
