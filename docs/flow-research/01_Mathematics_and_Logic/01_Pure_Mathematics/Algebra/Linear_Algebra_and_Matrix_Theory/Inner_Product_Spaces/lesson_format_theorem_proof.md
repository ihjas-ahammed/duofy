# Duofy Reusable Lesson Format: Inner Product Spaces - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Inner_Product_Spaces`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through fundamental inner product proofs: Cauchy-Schwarz Inequality, Triangle Inequality ($\|\mathbf{u} + \mathbf{v}\| \le \|\mathbf{u}\| + \|\mathbf{v}\|$), and the Pythagorean Theorem in inner product spaces.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cauchy-Schwarz Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Quadratic Discriminant Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Quadratic Discriminant Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Derivation Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Pythagorean Theorem Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Cauchy-Schwarz Inequality**\nLet $V$ be an inner product space. For any vectors $\\mathbf{u}, \\mathbf{v} \\in V$:\n$$\n|\\langle \\mathbf{u}, \\mathbf{v} \\rangle| \\le \\|\\mathbf{u}\\| \\|\\mathbf{v}\\|\n$$\nEquality holds if and only if $\\mathbf{u}$ and $\\mathbf{v}$ are linearly dependent."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Cauchy-Schwarz Inequality.",
      "orderItems": [
        "If v = 0, the inequality 0 <= 0 holds trivially.",
        "Assuming v != 0, construct quadratic function P(t) = ||u + t v||^2 >= 0 for all real t.",
        "Expand P(t) = <u + t v, u + t v> = ||u||^2 + 2t <u,v> + t^2 ||v||^2 >= 0.",
        "Since P(t) >= 0 for all t, its quadratic discriminant B^2 - 4AC must be <= 0.",
        "Substitute A = ||v||^2, B = 2<u,v>, C = ||u||^2 into B^2 - 4AC <= 0 to get 4<u,v>^2 - 4||u||^2 ||v||^2 <= 0.",
        "Divide by 4 and take square roots to yield |<u, v>| <= ||u|| ||v||."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In proving the Triangle Inequality $\|\mathbf{u} + \mathbf{v}\|^2 = \|\mathbf{u}\|^2 + 2\langle \mathbf{u}, \mathbf{v} \rangle + \|\mathbf{v}\|^2$, where is Cauchy-Schwarz used?",
      "options": [
        { "text": "To bound 2<u, v> <= 2 ||u|| ||v||, completing the square (||u|| + ||v||)^2", "isCorrect": true, "explanation": "Correct! Cauchy-Schwarz replaces <u,v> with ||u|| ||v|| to yield (||u|| + ||v||)²." },
        { "text": "To show vectors are orthogonal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "To divide by zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "To prove linear dependence", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Derivation: Generalized Pythagorean Theorem",
      "interactiveSteps": [
        { "stepText": "Let $\\mathbf{u}, \\mathbf{v}$ be orthogonal vectors ($\\langle \\mathbf{u}, \\mathbf{v} \\rangle = 0$). Expand $\|\\mathbf{u} + \\mathbf{v}\|^2 = \\langle \\mathbf{u} + \\mathbf{v}, \\mathbf{u} + \\mathbf{v} \\rangle$." },
        {
          "prompt": "Using linearity and symmetry, what is $\\langle \\mathbf{u} + \\mathbf{v}, \\mathbf{u} + \\mathbf{v} \\rangle$ when $\\langle \\mathbf{u}, \\mathbf{v} \\rangle = 0$?",
          "options": [
            { "text": "||u||^2 + ||v||^2", "isCorrect": true },
            { "text": "||u||^2 - ||v||^2", "isCorrect": false },
            { "text": "2||u|| ||v||", "isCorrect": false },
            { "text": "0", "isCorrect": false }
          ]
        },
        { "stepText": "Thus $\|\\mathbf{u} + \\mathbf{v}\|^2 = \\|\\mathbf{u}\\|^2 + \\|\\mathbf{v}\\|^2$, proving the Pythagorean Theorem for any inner product space." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What inequality states that the norm of the sum of two vectors is less than or equal to the sum of their norms?",
      "blankAnswer": "triangle"
    }
  ]
}
```
