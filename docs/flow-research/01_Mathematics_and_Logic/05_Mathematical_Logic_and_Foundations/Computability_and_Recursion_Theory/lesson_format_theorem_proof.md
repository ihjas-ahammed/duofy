# Duofy Reusable Lesson Format: Computability Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Computability_and_Recursion_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through landmark proofs in computability theory: Undecidability of the Halting Problem via Diagonalization, Proof of Rice's Theorem via Reduction from $K$, and Kleene's Recursion Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Halting Problem Undecidability Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Diagonal Machine Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Rice's Theorem Reduction Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Kleene Quine Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Turing Jump Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Proof of the Undecidability of the Halting Problem**\nAssume for contradiction that there exists a decision Turing Machine $H(e, x)$ such that:\n$$\nH(e, x) = \\begin{cases} 1 & \\text{if } \\phi_e(x) \\downarrow \\text{ (halts)} \\\\ 0 & \\text{if } \\phi_e(x) \\uparrow \\text{ (loops forever)} \\end{cases}\n$$\nConstruct diagonal machine $D(x)$: If $H(x, x) = 1$, loop forever; if $H(x, x) = 0$, halt immediately."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to complete the proof of the Halting Problem undecidability.",
      "orderItems": [
        "Assume total computable decision machine H(e, x) decides if TM e halts on input x.",
        "Construct diagonal machine D(x) which calls H(x, x).",
        "Define D(x): If H(x, x) = 1 (halts), D enters an infinite loop. If H(x, x) = 0 (loops), D halts immediately.",
        "Let d be the index (Gödel number) of machine D, so ϕ_d(x) = D(x).",
        "Evaluate D(d): If D(d) halts, H(d, d) = 1, so D(d) loops (contradiction!). If D(d) loops, H(d, d) = 0, so D(d) halts (contradiction!). Conclude H cannot exist!"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How does the proof of **Rice's Theorem** proceed to show undecidability of property $\\mathcal{P}$?",
      "options": [
        { "text": "By reducing the Halting Problem K to property P using S_{m,n} theorem", "isCorrect": true, "explanation": "Correct! Given input (e, x), construct TM f(w) that runs e(x) first, reducing K to P." },
        { "text": "By counting all Turing machines", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "By executing the program infinitely many times", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "By matrix inversion", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Kleene's Recursion Theorem (Self-Printing Programs / Quines)",
      "interactiveSteps": [
        { "stepText": "Kleene's Recursion Theorem states for any total computable $f$, there exists index $e$ such that $\\phi_e(x) = \\phi_{f(e)}(x)$." },
        {
          "prompt": "What self-referential program capability does Kleene's theorem guarantee?",
          "options": [
            { "text": "A program can obtain and operate on its own source code index 'e'", "isCorrect": true },
            { "text": "A program can solve the halting problem", "isCorrect": false },
            { "text": "A program can run in 0 steps", "isCorrect": false },
            { "text": "A program can erase all memory", "isCorrect": false }
          ]
        },
        { "stepText": "This guarantees the existence of **Quines**—programs that take no input and output an exact copy of their own source code!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What proof technique constructs diagonal machine D(x) opposite to H(x, x) to derive a contradiction?",
      "blankAnswer": "diagonalization"
    }
  ]
}
```
