# Duofy Reusable Lesson Format: Lax Equivalence Theorem and Von Neumann Stability Analysis

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Solutions_of_Differential_Equations / Finite_Difference_Methods`  
**Lesson Format Type:** `lax_equivalence_and_von_neumann_stability`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof and application of the **Lax Equivalence Theorem** (Consistency + Stability $\iff$ Convergence), and perform **Von Neumann Stability Analysis** to derive the amplification factor $G(\xi)$ for explicit FTCS parabolic heat solvers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lax Equivalence Theorem & Von Neumann Stability Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | FTCS Amplification Factor Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | FTCS Parabolic Stability Limit Bound Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Lax Equivalence Operator Bound Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Stability Condition Greek Exponent Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Lax Equivalence Theorem (Lax & Richtmyer, 1956): Given a properly posed linear initial-value problem and a consistent finite difference approximation, **stability is the necessary and sufficient condition for convergence**. Define Von Neumann stability: for Fourier mode $u_j^n = G^n e^{i k j \Delta x}$, the amplification factor must satisfy $|G(\xi)| \le 1$ for all phase angles $\xi = k \Delta x$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving Von Neumann stability for the explicit heat solver $\frac{u_j^{n+1} - u_j^n}{\Delta t} = \alpha \frac{u_{j+1}^n - 2u_j^n + u_{j-1}^n}{\Delta x^2}$: (1) let $r = \frac{\alpha \Delta t}{\Delta x^2}$ and substitute $u_j^n = G^n e^{i j \xi}$, (2) divide by $G^n e^{i j \xi}$ to obtain $G - 1 = r (e^{i \xi} - 2 + e^{-i \xi})$, (3) use Euler's formula $e^{i\xi} + e^{-i\xi} - 2 = 2\cos\xi - 2 = -4\sin^2(\xi/2)$, (4) express amplification factor: $G(\xi) = 1 - 4r \sin^2(\xi/2)$, (5) enforce stability $-1 \le 1 - 4r \sin^2(\xi/2) \le 1$; the upper bound holds for all $r \ge 0$, and the worst-case lower bound at $\xi = \pi$ ($\sin^2(\pi/2) = 1$) requires $1 - 4r \ge -1 \implies r \le 1/2$.
3. **Slide 3 (`quiz`):** Test why the explicit FTCS scheme for the pure advection equation $u_t + a u_x = 0$ is unconditionally unstable ($G(\xi) = 1 - i C \sin\xi \implies |G(\xi)|^2 = 1 + C^2 \sin^2\xi > 1$ for all $C > 0$).
4. **Slide 4 (`proof`):** Interactive derivation showing error propagation $e^{n+1} = S e^n + \Delta t \, \tau^n \implies e^n = \Delta t \sum_{k=0}^{n-1} S^{n-1-k} \tau^k$, where $\|S^m\| \le C$ (stability) implies $\|e^n\| \le C T \max \|\tau^k\| \to 0$ as grid size shrinks.
5. **Slide 5 (`one_word`):** Plain-text recall of the surname of the Hungarian-American mathematician who formulated the Fourier mode stability method (Neumann / von Neumann).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lax_equivalence_and_von_neumann_stability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Lax Equivalence Theorem (Lax-Richtmyer, 1956)**\nFor a well-posed linear initial-value problem and a **consistent** finite difference approximation:\n$$\n\\textbf{Stability } \\iff \\textbf{ Convergence}\n$$\n• **Von Neumann Stability Analysis:** Insert a single Fourier harmonic $u_j^n = G^n e^{i j \\xi}$ (where $\\xi = k \\Delta x$).\n• The scheme is stable in $L^2$ if and only if the **amplification factor** $G(\\xi)$ satisfies:\n$$\n|G(\\xi)| \\le 1 \\quad \\forall \\xi \\in [-\\pi, \\pi]\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps deriving the exact Von Neumann stability condition for the 1D Heat FTCS scheme.",
      "orderItems": [
        "Write the explicit FTCS heat scheme u_j^{n+1} = u_j^n + r (u_{j+1}^n - 2u_j^n + u_{j-1}^n) where r = alpha Delta t / Delta x^2",
        "Substitute the Fourier ansatz u_j^n = G^n e^{i j xi} and factor out G^n e^{i j xi}",
        "Simplify the spatial bracket: e^{i xi} - 2 + e^{-i xi} = 2 cos(xi) - 2 = -4 sin^2(xi / 2)",
        "Obtain the explicit amplification factor: G(xi) = 1 - 4 r sin^2(xi / 2)",
        "Impose the stability criterion -1 <= G(xi) <= 1; evaluating at the highest frequency xi = pi yields 1 - 4r >= -1, which proves r <= 1/2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the Forward-Time Central-Space (FTCS) scheme for the pure advection equation u_t + a u_x = 0 UNCONDITIONALLY UNSTABLE for any time step Delta t > 0?",
      "options": [
        { "text": "Its amplification factor is G(xi) = 1 - i C sin(xi), so |G(xi)|^2 = 1 + C^2 sin^2(xi) is strictly greater than 1 for all non-zero frequencies", "isCorrect": true, "explanation": "Correct! Central differencing introduces an imaginary component that strictly increases the modulus |G| > 1, causing exponential blowup for any C = a Delta t / Delta x > 0." },
        { "text": "Because central differences have truncation error O(h^3)", "isCorrect": false, "explanation": "Incorrect: Truncation error is O(h^2)." },
        { "text": "Because advection equations have no solutions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because C must equal 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Lax Equivalence Convergence Error Bound",
      "interactiveSteps": [
        {
          "stepText": "Let u^n be the numerical solution and v^n be the exact solution on the grid. The error e^n = u^n - v^n satisfies e^{n+1} = S e^n + Delta t tau^n, where tau^n is the truncation error."
        },
        {
          "prompt": "Unrolling the recurrence with e^0 = 0, what is e^n in terms of the step operator S?",
          "options": [
            { "text": "e^n = Delta t sum_{k=0}^{n-1} S^{n-1-k} tau^k", "isCorrect": true },
            { "text": "e^n = S^n e^0", "isCorrect": false },
            { "text": "e^n = tau^n / Delta t", "isCorrect": false },
            { "text": "e^n = 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "By stability, ||S^m|| <= M for all m <= T/Delta t. Thus ||e^n|| <= M T max ||tau^k|| -> 0 as Delta t, Delta x -> 0, proving convergence."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the mathematician who co-developed the Fourier amplification stability analysis alongside Stanislaw Ulam and Nicholas Metropolis?",
      "blankAnswer": "neumann"
    }
  ]
}
```
