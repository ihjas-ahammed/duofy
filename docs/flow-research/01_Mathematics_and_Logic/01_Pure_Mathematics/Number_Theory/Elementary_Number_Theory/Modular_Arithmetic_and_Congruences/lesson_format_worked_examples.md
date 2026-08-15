# Duofy Reusable Lesson Format: Modular Arithmetic and Congruences - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Modular_Arithmetic_and_Congruences`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly solve simultaneous systems of congruences via the constructive **Chinese Remainder Theorem** (e.g. $x \equiv 2 \pmod 3$, $x \equiv 3 \pmod 5$, $x \equiv 2 \pmod 7$), calculate Legendre symbols using Gauss's Law of Quadratic Reciprocity, and find modular inverses.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chinese Remainder Theorem System Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step CRT Construction Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Unique Modulo Product Range Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical CRT Solution Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Quadratic Reciprocity Legendre Evaluation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the problem: Solve the simultaneous system of linear congruences: $x \equiv 2 \pmod 3$, $x \equiv 3 \pmod 5$, and $x \equiv 2 \pmod 7$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) calculate total modulus $M = 3 \times 5 \times 7 = 105$, (2) compute partial moduli $M_1 = 105/3 = 35$, $M_2 = 105/5 = 21$, $M_3 = 105/7 = 15$, (3) find modular inverses $y_i$: $35 y_1 \equiv 2 y_1 \equiv 1 \pmod 3 \implies y_1 = 2$; $21 y_2 \equiv 1 y_2 \equiv 1 \pmod 5 \implies y_2 = 1$; $15 y_3 \equiv 1 y_3 \equiv 1 \pmod 7 \implies y_3 = 1$, (4) compute sum: $x = \sum a_i M_i y_i = 2(35)(2) + 3(21)(1) + 2(15)(1) = 140 + 63 + 30 = 233 \equiv 23 \pmod{105}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the Chinese Remainder Theorem produces a unique solution modulo the product of the moduli. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the smallest non-negative integer solution $x$ to the system ($x = 23.0$).
5. **Slide 5 (`quiz`):** Quiz calculating the Legendre symbol $\left(\frac{3}{11}\right)$: Since $3 \equiv 3 \pmod 4$ and $11 \equiv 3 \pmod 4$, Quadratic Reciprocity gives $\left(\frac{3}{11}\right) = -\left(\frac{11}{3}\right) = -\left(\frac{2}{3}\right) = -(-1) = +1$ (so 3 is a quadratic residue modulo 11, e.g. $5^2 = 25 \equiv 3 \pmod{11}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Solving a System of Congruences via the Chinese Remainder Theorem**\nFind the unique integer solution modulo $M = 3 \\times 5 \\times 7 = 105$ to:\n$$\n\\begin{aligned}\nx &\\equiv 2 \\pmod 3 \\\\\nx &\\equiv 3 \\pmod 5 \\\\\nx &\\equiv 2 \\pmod 7\n\\end{aligned}\n$$\nSince $\\gcd(3, 5) = \\gcd(5, 7) = \\gcd(3, 7) = 1$, the CRT guarantees a unique solution modulo $105$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Partial Moduli):** $M_1 = \\frac{105}{3} = 35$, $M_2 = \\frac{105}{5} = 21$, $M_3 = \\frac{105}{7} = 15$.\n• **Step 2 (Modular Inverses $y_i$):**\n  - $35 y_1 \\equiv 2 y_1 \\equiv 1 \\pmod 3 \\implies y_1 = 2$\n  - $21 y_2 \\equiv 1 y_2 \\equiv 1 \\pmod 5 \\implies y_2 = 1$\n  - $15 y_3 \\equiv 1 y_3 \\equiv 1 \\pmod 7 \\implies y_3 = 1$\n• **Step 3 (Assemble Formula):**\n  $$x = a_1 M_1 y_1 + a_2 M_2 y_2 + a_3 M_3 y_3 = 2(35)(2) + 3(21)(1) + 2(15)(1) = 140 + 63 + 30 = 233$$\n• **Step 4 (Reduce Modulo 105):** $x = 233 = 2(105) + 23 \\equiv 23 \\pmod{105}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The Chinese Remainder Theorem guarantees that the combined solution to a system of congruences with pairwise coprime moduli is unique modulo the ___ of the individual moduli.",
      "blankAnswer": "product",
      "blankDistractors": ["sum", "difference", "average"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the smallest non-negative integer solution x to the system x = 2 mod 3, x = 3 mod 5, and x = 2 mod 7?",
      "numericAnswer": 23.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Using the Law of Quadratic Reciprocity, what is the value of the Legendre symbol (3 / 11)?",
      "options": [
        { "text": "+1 (3 is a quadratic residue mod 11, since 5^2 = 25 = 3 mod 11)", "isCorrect": true, "explanation": "Correct! Since both 3 and 11 are 3 mod 4, (3/11) = -(11/3) = -(2/3) = -(-1) = +1." },
        { "text": "-1 (3 is a non-residue)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect: 11 does not divide 3." },
        { "text": "3", "isCorrect": false, "explanation": "Incorrect: Legendre symbol only takes values +-1 or 0." }
      ]
    }
  ]
}
```
