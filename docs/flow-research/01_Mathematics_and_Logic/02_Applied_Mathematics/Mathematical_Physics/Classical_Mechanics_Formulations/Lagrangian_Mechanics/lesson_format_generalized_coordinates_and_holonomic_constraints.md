# Duofy Reusable Lesson Format: Generalized Coordinates and Holonomic Constraints

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Classical_Mechanics_Formulations / Lagrangian_Mechanics`  
**Lesson Format Type:** `generalized_coordinates_and_holonomic_constraints`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to determine system **Degrees of Freedom (DOF)** ($d = 3N - k$), transform Cartesian coordinates $\mathbf{r}_i(q_1, \dots, q_d, t)$ into **Generalized Coordinates**, incorporate **Holonomic vs Non-Holonomic Constraints**, and calculate constraint forces using **Lagrange Multipliers** $\lambda_k$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Generalized Coordinates & Degrees of Freedom Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 2-Particle Constrained DOF Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Constraint Type & Mathematical Form Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Double Pendulum Degrees of Freedom Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Holonomic Rolling Without Slipping Constraint Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of holonomic constraints: Algebraic relations among coordinates $f_k(\mathbf{r}_1, \dots, \mathbf{r}_N, t) = 0$ for $k = 1, \dots, m$. For an $N$-particle system with $m$ holonomic constraints, the number of independent generalized coordinates (degrees of freedom) is $d = 3N - m$. The transformation equations are $\mathbf{r}_i = \mathbf{r}_i(q_1, \dots, q_d, t)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct a bead of mass $m$ sliding frictionlessly on a parabolic wire $y = a x^2$: (1) 2D Cartesian coordinates $(x, y)$ subject to $1$ holonomic constraint $f(x, y) = y - a x^2 = 0$, (2) degrees of freedom: $d = 2 - 1 = 1$, choose generalized coordinate $q = x$, (3) velocities: $\dot{x} = \dot{q}, \dot{y} = 2 a q \dot{q}$, (4) kinetic energy $T = \frac{1}{2}m(\dot{x}^2 + \dot{y}^2) = \frac{1}{2}m(1 + 4a^2 q^2)\dot{q}^2$ and potential $V = mgy = mgaq^2$, automatically eliminating the normal constraint force!
3. **Slide 3 (`matching`):** Pair 4 constraint classifications (Holonomic Scleronomous, Holonomic Rheonomous, Non-Holonomic, Inequality / Unilateral) with their physical mechanical examples.
4. **Slide 4 (`numerical`):** Ask student to calculate the number of degrees of freedom for a planar double pendulum consisting of 2 masses attached by 2 rigid massless rods of lengths $l_1, l_2$ constrained to the $xy$-plane ($d = 2 \times 2 - 2 = 2.0$).
5. **Slide 5 (`quiz`):** Quiz analyzing non-holonomic constraints: Why is a sphere rolling without slipping on a horizontal 2D plane a classic NON-HOLONOMIC constraint? (The non-slip conditions relate velocities $\mathbf{v} = \mathbf{\omega} \times \mathbf{r}$ which cannot be integrated into an algebraic constraint on coordinates $f(x, y, \theta, \phi, \psi) = 0$, requiring 5 configuration coordinates despite having only 2 instantaneous velocity degrees of freedom).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "generalized_coordinates_and_holonomic_constraints",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Generalized Coordinates and Holonomic Constraints**\n• For a system of $N$ particles in 3D with $m$ **holonomic constraints** of the form:\n$$\nf_k(\\mathbf{r}_1, \\dots, \\mathbf{r}_N, t) = 0, \\quad k = 1, \\dots, m\n$$\n• The system possesses $d = 3N - m$ independent **Degrees of Freedom (DOF)**.\n• We parameterize the motion using $d$ **generalized coordinates** $\\mathbf{q} = (q_1, \\dots, q_d)$:\n$$\n\\mathbf{r}_i = \\mathbf{r}_i(q_1, \\dots, q_d, t), \\quad i = 1, \\dots, N\n$$\n• **Lagrange Multipliers for Constraint Forces:** If constraint forces $Q_k^{\\text{constraint}}$ are needed:\n$$\n\\frac{d}{dt}\\left( \\frac{\\partial L}{\\partial \\dot{q}_i} \\right) - \\frac{\\partial L}{\\partial q_i} = \\sum_{k=1}^m \\lambda_k \\frac{\\partial f_k}{\\partial q_i}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Physical System:** Bead sliding on a parabola $y = a x^2$ under gravity.\n• **Step 1 (Constraint & DOF):** $N=1, m=1 \\implies d = 2 - 1 = 1$. Choose generalized coordinate $q = x$.\n• **Step 2 (Velocities):** $\\dot{x} = \\dot{q}$ and $\\dot{y} = 2 a q \\dot{q}$.\n• **Step 3 (Energies):**\n  $$T = \\frac{1}{2}m(\\dot{x}^2 + \\dot{y}^2) = \\frac{1}{2}m (1 + 4a^2 q^2) \\dot{q}^2, \\quad V = mgy = mga q^2$$\n• **Step 4 (Lagrangian):** $L = \\frac{1}{2}m (1 + 4a^2 q^2) \\dot{q}^2 - mga q^2$, completely eliminating the wire's normal force!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each constraint classification to its physical mechanical system.",
      "matchPairs": [
        { "left": "Holonomic Scleronomous (Time-Independent)", "right": "Rigid pendulum bob connected by fixed rod length l (x^2 + y^2 = l^2)" },
        { "left": "Holonomic Rheonomous (Time-Dependent)", "right": "Bead on a wire rotating with constant angular velocity omega (y = x tan(omega t))" },
        { "left": "Non-Holonomic (Non-Integrable Velocity)", "right": "Disk rolling without slipping on a 2D plane (v = omega x R)" },
        { "left": "Unilateral / Inequality Constraint", "right": "Particle bouncing inside a hard-walled container (x >= 0)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the number of independent degrees of freedom for a planar double pendulum (two point masses in the xy plane connected by two rigid rods).",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the constraint of a bowling ball rolling without slipping on a flat surface classified as NON-HOLONOMIC?",
      "options": [
        { "text": "The rolling constraint dx - R dtheta = 0 is a non-integrable differential relation between velocities that cannot be integrated into an algebraic equation f(x, y, theta, phi, psi) = 0 on positions alone", "isCorrect": true, "explanation": "Correct! Non-holonomic constraints restrict allowable velocities without restricting the reachable configuration manifold." },
        { "text": "Because bowling balls have no kinetic energy", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the ball cannot change position", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because gravity is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
