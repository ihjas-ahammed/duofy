# Duofy Reusable Lesson Format: Legendre Transformation and Hamilton's Canonical Equations

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Classical_Mechanics_Formulations / Hamiltonian_Mechanics`  
**Lesson Format Type:** `legendre_transform_and_canonical_equations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the transition from Lagrangian configuration space $(q, \dot{q})$ to Hamiltonian phase space $(q, p)$ via the **Legendre Transformation** $H = p \dot{q} - L$, derive **Hamilton's Canonical Equations of Motion** $\dot{q}_i = \frac{\partial H}{\partial p_i}, \dot{p}_i = -\frac{\partial H}{\partial q_i}$, and compute total system energy.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Legendre Transform & Canonical Equations Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Differentials & Convex Duality Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Lagrangian Term & Hamiltonian Dual Pair Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Canonical Momentum Definition Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Canonical Momentum Sign Negation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Legendre transform: For Lagrangian $L(q, \dot{q}, t)$, define generalized canonical momentum $p_i = \frac{\partial L}{\partial \dot{q}_i}$. The Hamiltonian is $H(q, p, t) = \sum_{i=1}^n p_i \dot{q}_i - L$. State Hamilton's Canonical Equations: $\dot{q}_i = \frac{\partial H}{\partial p_i}, \dot{p}_i = -\frac{\partial H}{\partial q_i}$, and $\frac{dH}{dt} = \frac{\partial H}{\partial t} = -\frac{\partial L}{\partial t}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct total differential $dH = \sum (\dot{q}_i dp_i + p_i d\dot{q}_i) - \sum \left(\frac{\partial L}{\partial q_i}dq_i + \frac{\partial L}{\partial \dot{q}_i}d\dot{q}_i\right) - \frac{\partial L}{\partial t}dt = \sum (\dot{q}_i dp_i - \dot{p}_i dq_i) - \frac{\partial L}{\partial t}dt$, substitution of Euler-Lagrange $\frac{\partial L}{\partial q_i} = \dot{p}_i$, and conversion of $n$ second-order ODEs into $2n$ coupled first-order ODEs.
3. **Slide 3 (`matching`):** Pair 4 mechanics entities (Generalized coordinate $q_i$, Canonical momentum $p_i$, Lagrangian $L = T - V$, Hamiltonian $H = T + V$) with their physical descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that canonical momentum $p_i$ is defined as the partial derivative of the Lagrangian with respect to generalized velocity. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking: Why does the canonical equation for $\dot{p}_i$ have a minus sign $\dot{p}_i = -\frac{\partial H}{\partial q_i}$ while $\dot{q}_i = +\frac{\partial H}{\partial p_i}$? (Euler-Lagrange equates $\dot{p}_i = \frac{\partial L}{\partial q_i}$; in the differential $dH = p d\dot{q} + \dot{q} dp - dL$, the $dq$ term comes with a negative sign $-\frac{\partial L}{\partial q_i} dq_i = -\dot{p}_i dq_i$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "legendre_transform_and_canonical_equations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Legendre Transformation and Hamilton's Canonical Equations**\n• For a system with Lagrangian $L(q, \\dot{q}, t)$, the **canonical momentum** is:\n$$\np_i = \\frac{\\partial L}{\\partial \\dot{q}_i}\n$$\n• The **Hamiltonian** $H(q, p, t)$ is the Legendre transform of $L$ with respect to $\\dot{q}$:\n$$\nH(q, p, t) = \\sum_{i=1}^n p_i \\dot{q}_i - L(q, \\dot{q}, t)\n$$\n• **Hamilton's Canonical Equations of Motion (2n First-Order ODEs):**\n$$\n\\dot{q}_i = \\frac{\\partial H}{\\partial p_i}, \\qquad \\dot{p}_i = -\\frac{\\partial H}{\\partial q_i}\n$$\n• If $L$ has no explicit time dependence ($\\partial_t L = 0$), $H$ is a **conserved constant of motion** ($dH/dt = 0$, total energy $E = T + V$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Differential Total Identity:**\n  $$dH = \\sum_{i=1}^n (\\dot{q}_i \\, dp_i + p_i \\, d\\dot{q}_i) - \\sum_{i=1}^n \\left(\\frac{\\partial L}{\\partial q_i} dq_i + \\frac{\\partial L}{\\partial \\dot{q}_i} d\\dot{q}_i\\right) - \\frac{\\partial L}{\\partial t} dt$$\n• **Cancellation of $d\\dot{q}_i$:** Since $p_i = \\frac{\\partial L}{\\partial \\dot{q}_i}$, the $d\\dot{q}_i$ terms cancel completely.\n• **Euler-Lagrange Substitution:** Replacing $\\frac{\\partial L}{\\partial q_i} = \\dot{p}_i$ gives $dH = \\sum (\\dot{q}_i dp_i - \\dot{p}_i dq_i) - \\frac{\\partial L}{\\partial t} dt$.\n• **Matching Partial Derivatives:** Equating coefficients yields Hamilton's equations $\\dot{q}_i = \\partial H / \\partial p_i$ and $\\dot{p}_i = -\\partial H / \\partial q_i$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each classical mechanics concept to its mathematical representation.",
      "matchPairs": [
        { "left": "Lagrangian L(q, q_dot)", "right": "T - V (Kinetic minus Potential energy on tangent bundle TQ)" },
        { "left": "Hamiltonian H(q, p)", "right": "T + V (Total energy on phase space cotangent bundle T*Q)" },
        { "left": "Canonical Momentum p_i", "right": "partial L / partial q_dot_i (conjugate momentum coordinate)" },
        { "left": "Cyclic / Ignorable Coordinate", "right": "Coordinate q_k missing from H, implying p_k = const is conserved" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The canonical momentum p_i conjugate to generalized coordinate q_i is defined as the partial derivative of the Lagrangian with respect to generalized ___.",
      "blankAnswer": "velocity",
      "blankDistractors": ["position", "acceleration", "force"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is there a minus sign in Hamilton's momentum equation p_dot_i = - partial H / partial q_i while q_dot_i = + partial H / partial p_i?",
      "options": [
        { "text": "In the differential dH = sum (q_dot dp - p_dot dq), the dq term inherits a minus sign directly from subtracting the Euler-Lagrange term (partial L / partial q_i = p_dot_i)", "isCorrect": true, "explanation": "Correct! Because dH = sum (p dq_dot + q_dot dp) - dL, subtracting partial L / partial q = p_dot creates the minus sign on the partial derivative." },
        { "text": "Because momentum is always negative", "isCorrect": false, "explanation": "Incorrect: Momentum can be positive or negative." },
        { "text": "Because time runs backward in Hamiltonian mechanics", "isCorrect": false, "explanation": "Incorrect: Dynamics are reversible, but time variable is standard." },
        { "text": "Because energy is dissipated", "isCorrect": false, "explanation": "Incorrect: Hamiltonian mechanics is conservative." }
      ]
    }
  ]
}
```
