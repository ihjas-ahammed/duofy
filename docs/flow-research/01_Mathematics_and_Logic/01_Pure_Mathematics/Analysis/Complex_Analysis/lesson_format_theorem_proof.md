# Duofy Reusable Lesson Format: Complex Analysis - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Cauchy's foundational complex analysis proofs: Cauchy's Theorem, Cauchy's Integral Formula, Liouville's Theorem, and the Residue Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Residue / Cauchy Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Contour Deformation Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Liouville / Fundamental Theorem Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Integral Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Residue Factor Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Cauchy's Residue Theorem**\nLet $f$ be holomorphic inside and on a positively oriented simple closed contour $\\gamma$, except for a finite number of isolated singularities $z_1, \\dots, z_k$ inside $\\gamma$.\n$$\n\\oint_\\gamma f(z) \\, dz = 2\\pi i \\sum_{j=1}^k \\text{Res}(f, z_j)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Cauchy's Residue Theorem.",
      "orderItems": [
        "Enclose each singularity z_j in a small non-overlapping circle C_j inside contour γ.",
        "Apply Cauchy's Theorem to multiply-connected region between γ and circles C_j.",
        "Deform contour: ∮_γ f(z) dz = ∑ ∮_{C_j} f(z) dz.",
        "Substitute Laurent series of f around z_j into each small circle integral.",
        "Evaluate ∮_{C_j} (z - z_j)^n dz = 2πi for n = -1, and 0 for n ≠ -1.",
        "Sum 2πi * a_(-1) over all poles to yield 2πi ∑ Res(f, z_j)."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How does Liouville's Theorem (every bounded entire function is constant) prove the Fundamental Theorem of Algebra?",
      "options": [
        { "text": "If polynomial P(z) has no roots, 1/P(z) is bounded and entire, hence constant—a contradiction", "isCorrect": true, "explanation": "Correct! 1/P(z) would be bounded and entire, forcing P(z) to be constant." },
        { "text": "Because P(z) has degree n", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because residues at infinity equal 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because C is algebraically closed", "isCorrect": false, "explanation": "Incorrect: That is what is being proven!" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Derivation: Cauchy's Integral Formula for $f(z_0)$",
      "interactiveSteps": [
        { "stepText": "Consider $\\oint_\\gamma \\frac{f(z)}{z - z_0} dz$ where $f$ is holomorphic on and inside $\\gamma$." },
        {
          "prompt": "Deforming $\\gamma$ to a tiny circle $C_r(z_0)$ of radius $r \\to 0$, what does $\\frac{f(z)}{z - z_0}$ approach?",
          "options": [
            { "text": "f(z₀) / (z - z₀)", "isCorrect": true },
            { "text": "0", "isCorrect": false },
            { "text": "f'(z₀)", "isCorrect": false },
            { "text": "1", "isCorrect": false }
          ]
        },
        { "stepText": "Since $\\oint_{C_r} \\frac{dz}{z - z_0} = 2\\pi i$, taking limits yields $\\oint_\\gamma \\frac{f(z)}{z - z_0} dz = 2\\pi i f(z_0)$." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What complex analysis factor multiplies the sum of residues in Cauchy's Residue Theorem (2pi * ___)?",
      "blankAnswer": "i"
    }
  ]
}
```
