# Duofy Reusable Lesson Format: Period-Doubling Cascades and Feigenbaum Universality

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Dynamical_Systems_and_Chaos_Theory / Bifurcation_Theory`  
**Lesson Format Type:** `period_doubling_cascade_and_feigenbaum_universality`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to evaluate the **Flip (Period-Doubling) Bifurcation** in iterated 1D maps ($x_{n+1} = r x_n (1 - x_n)$), track the cascade of period-doubling points $r_n \to r_\infty \approx 3.5699456$, and compute the universal **Feigenbaum Constant** $\delta = \lim_{n\to\infty} \frac{r_n - r_{n-1}}{r_{n+1} - r_n} \approx 4.6692016$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Period-Doubling & Feigenbaum Constant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Logistic Map Period-2 Birth Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Flip Bifurcation Multiplier Criterion Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Feigenbaum Constant Ratio Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Renormalization Group Universality Class Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Period-Doubling (Flip) Bifurcation for discrete map $x_{n+1} = f(x_n, r)$: Occurs when the linearized multiplier crosses $\lambda = f'(x^*) = -1$. For the logistic map $f(x) = r x (1 - x)$, period-doublings occur at $r_1 = 3, r_2 = 1 + \sqrt{6} \approx 3.449, r_3 \approx 3.544, \dots$ accumulating at $r_\infty \approx 3.569946$. State the Feigenbaum Constant: $\delta = \lim_{n \to \infty} \frac{r_n - r_{n-1}}{r_{n+1} - r_n} \approx 4.669201609\dots$.
2. **Slide 2 (`concept_pieces`):** Deconstruct period-2 orbit birth: (1) fixed point $x^* = 1 - 1/r$, (2) multiplier $\lambda = f'(x^*) = r(1 - 2x^*) = 2 - r$, (3) for $1 < r < 3$, $|\lambda| < 1$ (stable); at $r = 3$, $\lambda = -1$, (4) for $r > 3$, fixed point loses stability and an alternating stable 2-cycle $\{p, q\}$ is born satisfying $f(p) = q$ and $f(q) = p$, (5) at $r_2 = 1 + \sqrt{6}$, the 2-cycle multiplier crosses $-1$, spawning a stable 4-cycle.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that a flip bifurcation in a discrete map occurs when the multiplier eigenvalue crosses negative one. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the next approximate bifurcation interval $\Delta r_3 = (r_2 - r_1) / \delta$ given $r_1 = 3.0, r_2 = 3.4495$ and $\delta = 4.6692$: $\Delta r_3 = 0.4495 / 4.6692 \approx 0.096$ (numeric answer: 0.10).
5. **Slide 5 (`quiz`):** Quiz on the physical universality of the Feigenbaum constant $\delta$: Why does $\delta \approx 4.669$ appear in real-world fluid turbulence (Rayleigh-Bénard convection) and non-linear electrical circuits? (Because period doubling is governed by a universal fixed-point operator equation in the Renormalization Group theory $g(x) = -\alpha g(g(-x/\alpha))$ that depends ONLY on the quadratic shape of the local maximum, independent of the microscopic physical details).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "period_doubling_cascade_and_feigenbaum_universality",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Period-Doubling Cascades and Feigenbaum Universality**\n• For a 1D iterated map $x_{n+1} = f(x_n, r)$ (e.g. the Logistic Map $x_{n+1} = r x_n (1 - x_n)$):\n• **Flip (Period-Doubling) Bifurcation:** Occurs when the linear multiplier crosses:\n$$\n\\lambda = \\left.\\frac{df}{dx}\\right|_{x^*} = -1\n$$\n• At critical parameters $r_1, r_2, r_3, \\dots$, stable orbits of period $1 \\to 2 \\to 4 \\to 8 \\to 2^n$ are sequentially born, accumulating at the chaos boundary $r_\\infty \\approx 3.5699456$.\n• **The Feigenbaum Constant $\\delta$ (1978):**\n$$\n\\delta = \\lim_{n \\to \\infty} \\frac{r_n - r_{n-1}}{r_{n+1} - r_n} = 4.66920160910299\\dots\n$$\n(A universal constant of nature shared by *all* systems transitioning to chaos via period doubling!)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Fixed Point):** For $f(x) = r x (1 - x)$, the non-trivial fixed point is $x^* = 1 - 1/r$.\n• **Step 2 (Linear Multiplier):** $\\lambda = f'(x^*) = r(1 - 2x^*) = 2 - r$.\n• **Step 3 (First Bifurcation at $r_1 = 3$):** $\\lambda = 2 - 3 = -1$. The fixed point becomes unstable, and a stable 2-cycle $\\{p, q\\}$ is born.\n• **Step 4 (Second-Iterate Map $f^2(x)$):** The 2-cycle corresponds to fixed points of $f(f(x))$. Its multiplier is $(f^2)'(p) = f'(p) f'(q)$.\n• **Step 5 (Cascade):** At $r_2 = 1 + \\sqrt{6} \\approx 3.4495$, $(f^2)'(p) = -1$, triggering the birth of a period-4 orbit."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In discrete iterated maps, a flip (period-doubling) bifurcation occurs when the linearized eigenvalue multiplier reaches exactly negative ___.",
      "blankAnswer": "one",
      "blankDistractors": ["two", "zero", "infinity"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Using r_1 = 3.0, r_2 = 3.4495, and Feigenbaum delta = 4.6692, estimate the width of the next bifurcation interval Delta r_2 = (r_2 - r_1) / delta to two decimal places.",
      "numericAnswer": 0.10,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is Mitchell Feigenbaum's constant delta approx 4.6692 classified as 'universal' in physics and mathematics?",
      "options": [
        { "text": "It applies to ALL 1D unimodal maps with a quadratic maximum and any physical experiment (fluid convection, heart rhythms, circuits) undergoing period-doubling chaos, governed by Renormalization Group fixed points", "isCorrect": true, "explanation": "Correct! Feigenbaum used the Renormalization Group functional equation g(x) = -alpha g(g(-x/alpha)) to prove that delta depends only on the quadratic order of the local peak, not the specific physical system." },
        { "text": "Because it equals pi", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it only works for the logistic map", "isCorrect": false, "explanation": "Incorrect: It applies universally to all quadratic-peak maps." },
        { "text": "Because it represents the speed of light", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
