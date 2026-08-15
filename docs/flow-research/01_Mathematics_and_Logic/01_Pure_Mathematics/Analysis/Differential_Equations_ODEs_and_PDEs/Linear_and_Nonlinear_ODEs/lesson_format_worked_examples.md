# Duofy Reusable Lesson Format: Linear and Nonlinear ODEs - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Linear_and_Nonlinear_ODEs`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to find all equilibrium points of non-linear systems (such as the non-linear pendulum $\dot{x} = y, \dot{y} = -\sin x$ or Lotka-Volterra predator-prey systems), evaluate their Jacobian matrices, classify their stability, and construct candidate Lyapunov functions $V(x, y)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nonlinear Pendulum System Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fixed Point Analysis Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Separatrix Orbit Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Equilibrium Jacobian Determinant | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Lyapunov Stability Construction Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the non-linear pendulum system: $\dot{x} = y, \dot{y} = -\sin x$. Fixed points occur at $(k\pi, 0)$ for integer $k$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) $(0, 0)$ has $J = \begin{pmatrix} 0 & 1 \\ -1 & 0 \end{pmatrix}$, $\tau = 0, \Delta = 1 > 0$ (linearized center), (2) $(\pi, 0)$ has $J = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix}$, $\tau = 0, \Delta = -1 < 0$ (saddle point), (3) Energy function $E(x, y) = \frac{1}{2}y^2 + (1 - \cos x)$, (4) $\dot{E} = y \dot{y} + \sin x \dot{x} = y(-\sin x) + \sin x(y) = 0$ (conserved Hamiltonian).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the trajectory connecting saddle points is called a separatrix. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the determinant of the Jacobian at the downward resting equilibrium $(0, 0)$ ($\det(J) = 1.0$).
5. **Slide 5 (`quiz`):** Quiz testing the verification of asymptotic stability for $\dot{x} = -x^3 - y, \dot{y} = x - y^3$ using $V(x, y) = \frac{1}{2}(x^2 + y^2)$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Nonlinear Pendulum: $\\dot{x} = y, \\; \\dot{y} = -\\sin x$**\nEquilibrium points solve $y = 0$ and $\\sin x = 0 \\implies (x^*, y^*) = (k\\pi, 0)$ for $k \\in \\mathbb{Z}$.\nThe Jacobian matrix is:\n$$\nJ(x, y) = \\begin{pmatrix} 0 & 1 \\\\ -\\cos x & 0 \\end{pmatrix}\n$$\n• At $(0, 0)$: $J = \\begin{pmatrix} 0 & 1 \\\\ -1 & 0 \\end{pmatrix} \\implies \\tau = 0, \\Delta = 1$ (Linearized Center).\n• At $(\\pi, 0)$: $J = \\begin{pmatrix} 0 & 1 \\\\ 1 & 0 \\end{pmatrix} \\implies \\tau = 0, \\Delta = -1$ (Saddle Point)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Construct Energy Function):** Total mechanical energy is $E(x, y) = \\frac{1}{2}y^2 + (1 - \\cos x)$.\n• **Step 2 (Differentiate along Trajectories):** $\\dot{E} = y \\dot{y} + \\sin x \\dot{x} = y(-\\sin x) + \\sin x(y) = 0$.\n• **Step 3 (Confirm True Center):** Because $\\dot{E} = 0$ identically, trajectories are closed level curves $E(x, y) = C$, proving $(0, 0)$ is a true non-linear center.\n• **Step 4 (Separatrix):** The level curve $E(x, y) = 2$ connects the saddle points $(\\pm \\pi, 0)$, separating oscillatory librations from continuous rotations."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The boundary trajectory in the phase portrait that separates closed oscillatory orbits from open rotational motions is called the ___.",
      "blankAnswer": "separatrix",
      "blankDistractors": ["nullcline", "isocline", "bifurcation"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For the pendulum system dot{x} = y, dot{y} = -sin(x), what is the determinant of the Jacobian matrix at the equilibrium (0, 0)?",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For the non-linear system dot{x} = -x^3 - y, dot{y} = x - y^3, use the Lyapunov function V(x, y) = (1/2)(x^2 + y^2). What is dot{V}?",
      "options": [
        { "text": "dot{V} = -(x^4 + y^4) < 0 for (x, y) != (0, 0), proving global asymptotic stability", "isCorrect": true, "explanation": "Correct! dot{V} = x(-x^3 - y) + y(x - y^3) = -x^4 - xy + xy - y^4 = -(x^4 + y^4) < 0." },
        { "text": "dot{V} = 0, proving neutral stability", "isCorrect": false, "explanation": "Incorrect: -x^4 - y^4 is strictly negative away from the origin." },
        { "text": "dot{V} = x^4 + y^4 > 0, proving instability", "isCorrect": false, "explanation": "Incorrect: The signs on the cubic damping terms are negative." },
        { "text": "dot{V} = -2xy", "isCorrect": false, "explanation": "Incorrect: The cross terms -xy and +xy cancel out exactly." }
      ]
    }
  ]
}
```
