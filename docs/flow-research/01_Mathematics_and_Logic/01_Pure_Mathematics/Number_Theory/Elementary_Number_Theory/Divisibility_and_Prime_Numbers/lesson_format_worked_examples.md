# Duofy Reusable Lesson Format: Divisibility and Prime Numbers - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Divisibility_and_Prime_Numbers`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly execute the **Extended Euclidean Algorithm** to find $\gcd(a, b)$ and solve the Linear Diophantine Equation $a x + b y = \gcd(a, b)$ (e.g. for $a = 252$ and $b = 198$), compute arithmetic functions $\tau(n), \sigma(n), \phi(n)$, and find general solutions $(x, y) = (x_0 + \frac{b}{d}k, y_0 - \frac{a}{d}k)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Extended Euclidean Algorithm Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Back-Substitution Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Bézout GCD Linear Combination Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Euler Totient Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Linear Diophantine Equation Solvability Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the problem: Find $\gcd(252, 198)$ and find integer solutions $(x, y)$ to $252x + 198y = \gcd(252, 198)$ via the Extended Euclidean Algorithm.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) forward divisions: $252 = 1 \cdot 198 + 54$, $198 = 3 \cdot 54 + 36$, $54 = 1 \cdot 36 + 18$, $36 = 2 \cdot 18 + 0 \implies \gcd(252, 198) = 18$, (2) back-substitution: $18 = 54 - 1 \cdot 36$, (3) substitute $36 = 198 - 3 \cdot 54 \implies 18 = 4 \cdot 54 - 1 \cdot 198$, (4) substitute $54 = 252 - 1 \cdot 198 \implies 18 = 4(252 - 198) - 198 = 4(252) - 5(198)$, so $x_0 = 4, y_0 = -5$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the greatest common divisor of two integers divides any integer linear combination of those numbers. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute Euler's Totient $\phi(72) = 72 (1 - 1/2)(1 - 1/3) = 72 (1/2)(2/3) = 24.0$.
5. **Slide 5 (`quiz`):** Quiz asking: For what values of $c$ does the Diophantine equation $14x + 21y = c$ have integer solutions $(x, y)$? (Only when $c$ is a multiple of $\gcd(14, 21) = 7$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Extended Euclidean Algorithm for $\\gcd(252, 198)$**\nWe compute $d = \\gcd(252, 198)$ and find integers $x, y$ such that $252x + 198y = d$.\n• **Forward Divisions:**\n$$\n\\begin{aligned}\n252 &= 1 \\cdot 198 + 54 \\\\\n198 &= 3 \\cdot 54 + 36 \\\\\n54 &= 1 \\cdot 36 + 18 \\\\\n36 &= 2 \\cdot 18 + 0 \\quad \\implies \\quad \\gcd(252, 198) = 18\n\\end{aligned}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Isolate Last Non-zero Remainder):** $18 = 54 - 1 \\cdot 36$.\n• **Step 2 (Substitute $36 = 198 - 3 \\cdot 54$):**\n  $$18 = 54 - 1(198 - 3 \\cdot 54) = 4 \\cdot 54 - 1 \\cdot 198$$\n• **Step 3 (Substitute $54 = 252 - 1 \\cdot 198$):**\n  $$18 = 4(252 - 1 \\cdot 198) - 198 = 4(252) - 5(198)$$\n• **Step 4 (Bézout Solution):** $x_0 = 4$ and $y_0 = -5$. General solution: $x = 4 + 11k$, $y = -5 - 14k$ for $k \\in \\mathbb{Z}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "A linear Diophantine equation ax + by = c has integer solutions if and only if the integer c is a multiple of the greatest common ___ of a and b.",
      "blankAnswer": "divisor",
      "blankDistractors": ["multiple", "prime", "exponent"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the value of Euler's totient function phi(72) where 72 = 2^3 * 3^2.",
      "numericAnswer": 24.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the linear Diophantine equation 14x + 21y = 35 HAVE integer solutions, while 14x + 21y = 36 has NO integer solutions?",
      "options": [
        { "text": "gcd(14, 21) = 7 divides 35 (35 = 7 * 5), but 7 does NOT divide 36", "isCorrect": true, "explanation": "Correct! Any linear combination 14x + 21y = 7(2x + 3y) is always a multiple of 7, so it can only equal integers divisible by 7." },
        { "text": "Because 35 is odd and 36 is even", "isCorrect": false, "explanation": "Incorrect: Parity alone does not govern solvability." },
        { "text": "Because 14 is smaller than 21", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 21 is a prime number", "isCorrect": false, "explanation": "Incorrect: 21 = 3 * 7 is composite." }
      ]
    }
  ]
}
```
