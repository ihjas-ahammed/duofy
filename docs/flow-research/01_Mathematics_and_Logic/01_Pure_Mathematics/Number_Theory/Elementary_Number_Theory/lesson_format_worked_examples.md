# Duofy Reusable Lesson Format: Elementary Number Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to execute the Extended Euclidean Algorithm for $a x + b y = \gcd(a, b)$, solve modular linear congruences $a x \equiv b \pmod n$, and compute Chinese Remainder Theorem system solutions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Extended Euclidean Algorithm Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Back-Substitution Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Modular Inverse Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative System Solution Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Modular Inverse Existence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Extended Euclidean Algorithm for Inverse $a^{-1} \\pmod n$**\nTo solve $a x \\equiv 1 \\pmod n$, apply Euclidean division $a x + n y = 1$:\n$$\n\\gcd(a, n) = 1 \\iff a^{-1} \\pmod n \\text{ exists}\n$$\nBack-substitute division steps to express $1 = a x + n y$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Find inverse of $7 \\pmod{26}$. Division: $26 = 3(7) + 5$.\n• **Step 2:** $7 = 1(5) + 2$.\n• **Step 3:** $5 = 2(2) + 1 \\implies \\gcd(7, 26) = 1$.\n• **Step 4:** Back-substitute: $1 = 5 - 2(2) = 5 - 2(7 - 5) = 3(5) - 2(7) = 3(26 - 3 \\cdot 7) - 2(7) = 3(26) - 11(7)$.\n• **Step 5:** $-11(7) \\equiv 1 \\pmod{26} \\implies 7^{-1} \\equiv -11 \\equiv 15 \\pmod{26}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "A modular inverse a^(-1) modulo n exists if and only if the greatest common divisor gcd(a, n) equals ___.",
      "blankAnswer": "1",
      "blankDistractors": ["0", "n", "a"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Solve the system $x \\equiv 2 \\pmod 3$ and $x \\equiv 3 \\pmod 5$. What is the smallest positive integer solution $x$?",
      "numericAnswer": 8.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is $2^{100} \\pmod 3$ according to Fermat's Little Theorem?",
      "options": [
        { "text": "1 (since 2^(3-1) = 2² ≡ 1 mod 3, so (2²)^50 ≡ 1^50 = 1)", "isCorrect": true, "explanation": "Correct! Fermat's Little Theorem gives 2² ≡ 1 mod 3." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "100", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
