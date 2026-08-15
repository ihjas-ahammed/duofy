# Duofy Reusable Lesson Format: Algebraic Number Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Algebraic_Number_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to determine rings of integers $\mathcal{O}_K$, compute field discriminants $d_K$, evaluate Minkowski bounds $M_K$, and calculate class numbers $h_K$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Quadratic Field Discriminant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Ring of Integers Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Discriminant Modulo Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Minkowski Bound Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Class Number Computation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Ring of Integers & Discriminant of Quadratic Field $K = \\mathbb{Q}(\\sqrt{d})$**\nFor square-free $d \\in \\mathbb{Z}$:\n$$\n\\mathcal{O}_K = \\begin{cases} \\mathbb{Z}[\\sqrt{d}] & \\text{if } d \\equiv 2, 3 \\pmod 4 \\\\ \\mathbb{Z}\\left[\\frac{1 + \\sqrt{d}}{2}\\right] & \\text{if } d \\equiv 1 \\pmod 4 \\end{cases}, \\quad d_K = \\begin{cases} 4d & \\text{if } d \\equiv 2, 3 \\pmod 4 \\\\ d & \\text{if } d \\equiv 1 \\pmod 4 \\end{cases}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider $K = \\mathbb{Q}(\\sqrt{-5})$. Here $d = -5 \\equiv 3 \\pmod 4$.\n• **Step 2:** $\\mathcal{O}_K = \\mathbb{Z}[\\sqrt{-5}]$ and discriminant $d_K = 4(-5) = -20$.\n• **Step 3:** Compute Minkowski bound $M_K = \\frac{2!}{\\pi} \\sqrt{20} = \\frac{4.472}{\\pi / 2} \\approx 2.84$.\n• **Step 4:** Only prime $p \\le 2$ is $p=2$. $2 \\mathcal{O}_K = \\mathfrak{p}_2^2$ with $\\mathfrak{p}_2 = \\langle 2, 1+\\sqrt{-5} \\rangle$ non-principal. Class number $h_{\\mathbb{Q}(\\sqrt{-5})} = 2$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "For a quadratic field Q(sqrt(d)) with d ≡ 1 mod 4, the field discriminant d_K equals ___.",
      "blankAnswer": "d",
      "blankDistractors": ["4d", "2d", "d^2"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate Minkowski's bound $M_K = \\frac{2}{\\pi} \\sqrt{|d_K|}$ for imaginary quadratic field $K = \\mathbb{Q}(\\sqrt{-3})$ with $d_K = -3$.",
      "numericAnswer": 1.1026,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the class number $h_K$ of the Gaussian integers $K = \\mathbb{Q}(i)$?",
      "options": [
        { "text": "1 (since Z[i] is a Euclidean domain and PID)", "isCorrect": true, "explanation": "Correct! Z[i] has division algorithm, making it a PID with h_K = 1." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect: That describes Z[√-5]." },
        { "text": "3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
