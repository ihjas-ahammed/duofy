# Duofy Reusable Lesson Format: Principle of Stationary Action and Euler-Lagrange Equations

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Classical_Mechanics_Formulations / Lagrangian_Mechanics`  
**Lesson Format Type:** `stationary_action_and_euler_lagrange`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Hamilton's Principle of Stationary Action** ($\delta S = 0$), derive the **Euler-Lagrange Equations** $\frac{d}{dt}\left(\frac{\partial L}{\partial \dot{q}_i}\right) - \frac{\partial L}{\partial q_i} = 0$ via the calculus of variations, and formulate the Lagrangian $L = T - V$ for mechanical systems.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Action Functional & Euler-Lagrange Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Variational Integration by Parts Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Lagrangian Sign Convention & Energy Formula Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Simple Pendulum Nonlinear ODE Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Action Functional Physical Units Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hamilton's Principle: The physical path $q(t)$ between fixed endpoints $q(t_1) = q_1, q(t_2) = q_2$ makes the action functional $S[q] = \int_{t_1}^{t_2} L(q, \dot{q}, t) dt$ stationary ($\delta S = 0$). State the resulting Euler-Lagrange equations: $\frac{d}{dt}\left(\frac{\partial L}{\partial \dot{q}_i}\right) - \frac{\partial L}{\partial q_i} = 0$ for $i = 1, \dots, n$, where $L = T - V$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the calculus of variations proof: (1) let $q(t, \epsilon) = q(t) + \epsilon \eta(t)$ where $\eta(t_1) = \eta(t_2) = 0$, (2) differentiate the action: $\left.\frac{dS}{d\epsilon}\right|_{\epsilon=0} = \int_{t_1}^{t_2} \left(\frac{\partial L}{\partial q}\eta + \frac{\partial L}{\partial \dot{q}}\dot{\eta}\right) dt$, (3) integrate the second term by parts: $\int_{t_1}^{t_2} \frac{\partial L}{\partial \dot{q}}\dot{\eta} dt = \left[\frac{\partial L}{\partial \dot{q}}\eta\right]_{t_1}^{t_2} - \int_{t_1}^{t_2} \frac{d}{dt}\left(\frac{\partial L}{\partial \dot{q}}\right)\eta dt$, (4) vanish boundary terms since $\eta(t_1) = \eta(t_2) = 0$, giving $\delta S = \int_{t_1}^{t_2} \left(\frac{\partial L}{\partial q} - \frac{d}{dt}\frac{\partial L}{\partial \dot{q}}\right)\eta(t) dt = 0$, (5) invoke the Fundamental Lemma of Calculus of Variations to conclude $\frac{d}{dt}\left(\frac{\partial L}{\partial \dot{q}}\right) - \frac{\partial L}{\partial q} = 0$.
3. **Slide 3 (`quiz`):** Test the difference between Lagrangian and Hamiltonian: Why is the Lagrangian $L = T - V$ while the Hamiltonian total energy is $H = T + V$? (Lagrangian is the generating function for Hamilton's stationary action principle where kinetic and potential energies compete, while the Legendre transform yields the conserved total energy $H = p \dot{q} - L = 2T - (T - V) = T + V$).
4. **Slide 4 (`proof`):** Interactive derivation for the simple pendulum of length $l$ with angle $\theta$: $T = \frac{1}{2}m l^2 \dot{\theta}^2, V = -mgl\cos\theta \implies L = \frac{1}{2}ml^2\dot{\theta}^2 + mgl\cos\theta$, computing $\frac{\partial L}{\partial \theta} = -mgl\sin\theta, \frac{\partial L}{\partial \dot{\theta}} = ml^2\dot{\theta} \implies \ddot{\theta} + \frac{g}{l}\sin\theta = 0$.
5. **Slide 5 (`one_word`):** Plain-text recall of the SI unit of action (joule-second / action).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "stationary_action_and_euler_lagrange",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Hamilton's Principle of Stationary Action**\n• For a mechanical system with generalized coordinates $\\mathbf{q} = (q_1, \\dots, q_n)$, the **Lagrangian** is $L = T - V$.\n• **The Action Functional:**\n$$\nS[\\mathbf{q}] = \\int_{t_1}^{t_2} L(\\mathbf{q}(t), \\dot{\\mathbf{q}}(t), t) \\, dt\n$$\n• **Hamilton's Principle:** The true physical trajectory $\\mathbf{q}(t)$ is a **stationary path** of $S$ ($\\delta S = 0$) for all variations with fixed endpoints $\\delta \\mathbf{q}(t_1) = \\delta \\mathbf{q}(t_2) = \\mathbf{0}$.\n• **The Euler-Lagrange Equations of Motion:**\n$$\n\\frac{d}{dt}\\left( \\frac{\\partial L}{\\partial \\dot{q}_i} \\right) - \\frac{\\partial L}{\\partial q_i} = 0, \\quad i = 1, \\dots, n\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical variational steps deriving the Euler-Lagrange equations from delta S = 0.",
      "orderItems": [
        "Parameterize test paths q(t, eps) = q(t) + eps * eta(t) where eta(t_1) = eta(t_2) = 0",
        "Compute the first variation: dS/deps = int_{t_1}^{t_2} (partial L / partial q * eta + partial L / partial q_dot * eta_dot) dt",
        "Apply integration by parts to the velocity term: int (partial L / partial q_dot) eta_dot dt = [partial L / partial q_dot * eta]_{t_1}^{t_2} - int d/dt(partial L / partial q_dot) eta dt",
        "Eliminate the boundary term since variations vanish at endpoints: eta(t_1) = eta(t_2) = 0",
        "Apply the Fundamental Lemma of Calculus of Variations to int (partial L / partial q - d/dt(partial L / partial q_dot)) eta dt = 0 to extract the Euler-Lagrange equation"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the classical mechanical Lagrangian defined as L = T - V (kinetic MINUS potential) rather than total energy T + V?",
      "options": [
        { "text": "Stationary action requires kinetic energy (rate of motion) and potential energy (spatial configuration) to balance variationally; Legendre transforming L = T - V naturally recovers total energy H = T + V", "isCorrect": true, "explanation": "Correct! Hamilton's principle delta int (T - V) dt = 0 generates conservative Newton's laws F = -grad V = m a. The Legendre transform p q_dot - L = 2T - (T - V) = T + V gives total energy." },
        { "text": "Because potential energy is always negative", "isCorrect": false, "explanation": "Incorrect: Potential energy can be positive or negative." },
        { "text": "Because kinetic energy cannot be differentiated", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because mass is negative in Lagrangian mechanics", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Simple Pendulum Nonlinear Equation of Motion",
      "interactiveSteps": [
        {
          "stepText": "For a pendulum of mass m, length l, and angle theta: T = 1/2 m l^2 theta_dot^2 and V = -mgl cos(theta), giving Lagrangian L = 1/2 m l^2 theta_dot^2 + mgl cos(theta)."
        },
        {
          "prompt": "Evaluate the partial derivatives partial L / partial theta and partial L / partial theta_dot.",
          "options": [
            { "text": "partial L / partial theta = -mgl sin(theta) and partial L / partial theta_dot = m l^2 theta_dot", "isCorrect": true },
            { "text": "partial L / partial theta = 0", "isCorrect": false },
            { "text": "partial L / partial theta = mgl cos(theta)", "isCorrect": false },
            { "text": "partial L / partial theta_dot = m l theta_dot", "isCorrect": false }
          ]
        },
        {
          "stepText": "Substituting into d/dt(partial L / partial theta_dot) - partial L / partial theta = 0 yields m l^2 theta_ddot + mgl sin(theta) = 0 => theta_ddot + (g/l) sin(theta) = 0."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the physical quantity represented by the time integral of energy (with SI units Joule-seconds)?",
      "blankAnswer": "action"
    }
  ]
}
```
