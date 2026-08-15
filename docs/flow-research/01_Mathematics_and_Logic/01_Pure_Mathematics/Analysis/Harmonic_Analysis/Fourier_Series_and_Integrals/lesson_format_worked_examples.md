# Duofy Reusable Lesson Format: Fourier Series and Integrals - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Fourier_Series_and_Integrals`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the Fourier series of piecewise smooth periodic functions (e.g. the square wave $f(x) = \text{sgn}(x)$ or triangle wave $f(x) = |x|$ on $[-\pi, \pi]$), and apply Parseval's identity to evaluate classical infinite series (e.g. the Basel problem $\sum_{n=1}^\infty \frac{1}{n^2} = \frac{\pi^2}{6}$ and $\sum_{n=1}^\infty \frac{1}{n^4} = \frac{\pi^4}{90}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Triangle Wave Fourier Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fourier Series Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Basel Problem Evaluation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Fourier Coefficient Evaluation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Gibbs Phenomenon Overshoot Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the worked example: Compute the Fourier series of $f(x) = |x|$ on $[-\pi, \pi]$ (even function, $b_n = 0$) and apply Parseval's identity.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) $a_0 = \frac{1}{\pi}\int_0^\pi x dx = \frac{\pi}{2}$, (2) $a_n = \frac{2}{\pi}\int_0^\pi x \cos(nx) dx = \frac{2}{\pi n^2}[(-1)^n - 1] = \begin{cases} -4/(\pi n^2) & n \text{ odd} \\ 0 & n \text{ even} \end{cases}$, (3) series $f(x) = \frac{\pi}{2} - \frac{4}{\pi}\sum_{k=0}^\infty \frac{\cos((2k+1)x)}{(2k+1)^2}$, (4) evaluate at $x = 0 \implies 0 = \frac{\pi}{2} - \frac{4}{\pi}\sum \frac{1}{(2k+1)^2} \implies \sum \frac{1}{(2k+1)^2} = \frac{\pi^2}{8}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that evaluating at $x = 0$ yields the sum of odd reciprocals squared equal to pi squared over eight. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the value of $\sum_{n=1}^\infty \frac{1}{n^2} = \frac{\pi^2}{6} \approx 1.6449$.
5. **Slide 5 (`quiz`):** Quiz testing the Gibbs phenomenon: What percentage overshoot occurs near a jump discontinuity when approximating a step function with Fourier partial sums $S_N(f)$? ($\approx 9\%$, or $\frac{1}{\pi}\int_0^\pi \frac{\sin t}{t} dt - \frac{1}{2} \approx 0.08949$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Fourier Series of Triangle Wave $f(x) = |x|$ on $[-\\pi, \\pi]$**\nBecause $f(x)$ is an even function, all sine coefficients vanish: $b_n = 0$.\nThe cosine coefficients are given by:\n$$\na_0 = \\frac{1}{\\pi} \\int_{-\\pi}^\\pi |x|\\,dx = \\frac{2}{\\pi} \\int_0^\\pi x\\,dx = \\pi\n$$\n$$\na_n = \\frac{2}{\\pi} \\int_0^\\pi x \\cos(nx)\\,dx = \\frac{2}{\\pi n^2} [(-1)^n - 1]\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Odd Harmonics Only):** For even $n$, $a_n = 0$. For odd $n = 2k+1$, $a_{2k+1} = -\\frac{4}{\\pi(2k+1)^2}$.\n• **Step 2 (Assemble Fourier Series):**\n  $$|x| = \\frac{\\pi}{2} - \\frac{4}{\\pi} \\sum_{k=0}^\\infty \\frac{\\cos((2k+1)x)}{(2k+1)^2}$$\n• **Step 3 (Evaluate at $x = 0$):** $0 = \\frac{\\pi}{2} - \\frac{4}{\\pi} \\sum_{k=0}^\\infty \\frac{1}{(2k+1)^2} \\implies \\sum_{k=0}^\\infty \\frac{1}{(2k+1)^2} = \\frac{\\pi^2}{8}$.\n• **Step 4 (Deduce Basel Sum):** Using $\\sum_{n=1}^\\infty \\frac{1}{n^2} = \\sum_{\\text{odd}} \\frac{1}{n^2} + \\frac{1}{4}\\sum_{n=1}^\\infty \\frac{1}{n^2}$, we find $\\sum_{n=1}^\\infty \\frac{1}{n^2} = \\frac{4}{3}\\left(\\frac{\\pi^2}{8}\\right) = \\frac{\\pi^2}{6}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Applying the Fourier series of |x| at x = 0 proves that the sum of the squared reciprocals of all odd positive integers equals pi squared over ___.",
      "blankAnswer": "eight",
      "blankDistractors": ["six", "four", "two"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the sum of the Basel problem sum_{n=1}^infty 1/n^2 = pi^2 / 6 to two decimal places.",
      "numericAnswer": 1.64,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the characteristic overshoot percentage of the Gibbs phenomenon near a jump discontinuity as the number of Fourier terms N -> infty?",
      "options": [
        { "text": "Approximately 9% of the jump height (Wilbraham-Gibbs constant)", "isCorrect": true, "explanation": "Correct! The partial sums overshoot the jump by (1/pi int_0^pi (sin t)/t dt - 1/2) * 100% approx 8.95%." },
        { "text": "0% (overshoot completely vanishes as N -> infty)", "isCorrect": false, "explanation": "Incorrect: Pointwise overshoot does not vanish, only its width shrinks." },
        { "text": "50%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "25%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
