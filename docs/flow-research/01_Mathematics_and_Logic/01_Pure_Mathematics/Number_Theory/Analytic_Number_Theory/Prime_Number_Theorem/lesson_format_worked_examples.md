# Duofy Reusable Lesson Format: Prime Number Theorem - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory / Prime_Number_Theorem`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate prime counts $\pi(x)$ using both the PNT approximation $\frac{x}{\ln x}$ and the Logarithmic Integral $\operatorname{Li}(x)$, compute asymptotic relative errors, and evaluate Chebyshev sums $\psi(x)$ and $\theta(x)$ for small bounds.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Prime Estimation Comparison Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Numerical Asymptotics Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Relative Error Convergence Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical First Chebyshev Sum Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Logarithmic Integral Overestimation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the problem: Compare $\frac{x}{\ln x}$, $\operatorname{Li}(x)$, and actual $\pi(x)$ for $x = 10^6$ (where actual $\pi(10^6) = 78,498$).
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) evaluate $\ln(10^6) = 6 \ln 10 \approx 13.8155$, (2) compute PNT estimate: $x/\ln x = 10^6 / 13.8155 \approx 72,382$ (underestimate by $\approx 7.8\%$), (3) compute $\operatorname{Li}(10^6) \approx 78,627$ (overestimate by only $\approx 129$ primes, error $\approx 0.16\%$), (4) conclude that $\operatorname{Li}(x)$ is dramatically more accurate because it includes the secondary terms $x/(\ln x)^2 + \dots$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the relative error $|\pi(x) - x/\ln x| / \pi(x)$ approaches zero as x approaches infinity. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to calculate $\theta(10) = \ln(2) + \ln(3) + \ln(5) + \ln(7) = \ln(210) \approx 5.347$ (numeric answer 5.35).
5. **Slide 5 (`quiz`):** Quiz asking: For all computed small numbers $x$, $\operatorname{Li}(x) > \pi(x)$. Does $\operatorname{Li}(x) - \pi(x)$ eventually change sign for large $x$? (Yes, Littlewood proved in 1914 that $\pi(x) - \operatorname{Li}(x)$ changes sign infinitely often, with the first crossing below Skewes' number).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Estimating $\\pi(x)$ for $x = 10^6$ via PNT and $\\operatorname{Li}(x)$**\nActual number of primes up to one million: $\\pi(10^6) = 78,498$.\n• **PNT Formula:** $P(x) = \\frac{x}{\\ln x}$.\n• **Logarithmic Integral:** $\\operatorname{Li}(x) = \\int_2^x \\frac{dt}{\\ln t} \\approx \\frac{x}{\\ln x} + \\frac{x}{(\\ln x)^2} + \\frac{2x}{(\\ln x)^3} + \\dots$\nWe will compute both estimates and calculate their respective relative errors."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Compute $\\ln(10^6)$):** $\\ln(10^6) = 6 \\ln(10) \\approx 13.81551$.\n• **Step 2 (PNT Estimate):**\n  $$\\frac{10^6}{\\ln(10^6)} = \\frac{10^6}{13.81551} \\approx 72,382 \\quad (\\text{Error: } -6,116 \\text{ primes, } -7.79\\%)\n• **Step 3 (Logarithmic Integral Estimate):**\n  $$\\operatorname{Li}(10^6) \\approx 78,627 \\quad (\\text{Error: } +129 \\text{ primes, } +0.16\\%)\n• **Step 4 (Conclusion):** $\\operatorname{Li}(x)$ outperforms $x/\\ln x$ by nearly 50 times in precision for $x = 10^6$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The Prime Number Theorem asserts that the ratio pi(x) / (x / ln x) approaches ___ as x approaches infinity.",
      "blankAnswer": "one",
      "blankDistractors": ["zero", "infinity", "e"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Evaluate the first Chebyshev function theta(10) = ln(2) + ln(3) + ln(5) + ln(7) = ln(210) to two decimal places.",
      "numericAnswer": 5.35,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For all easily computable values of x, Li(x) > pi(x). Is Li(x) strictly greater than pi(x) for all real numbers x?",
      "options": [
        { "text": "No: Littlewood proved in 1914 that the difference pi(x) - Li(x) changes sign infinitely many times as x -> infty", "isCorrect": true, "explanation": "Correct! Littlewood proved pi(x) and Li(x) cross infinitely often, with the first crossing bounded by Skewes' number." },
        { "text": "Yes: Li(x) is always greater than pi(x) for all x", "isCorrect": false, "explanation": "Incorrect: Gauss and Riemann believed this, but Littlewood disproved it." },
        { "text": "pi(x) is always greater than Li(x)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They are equal for all even integers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
