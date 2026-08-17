# Duofy Reusable Lesson Format: Finite Square Well and Transcendental Bound States

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Schrodinger_Equation_and_Wavefunctions`  
**Lesson Format Type:** `finite_square_well_and_transcendental_bound_states`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the wavefunctions and bound states of the 1D symmetric **Finite Square Well ($V(x) = -V_0$ for $|x| \le a$, $0$ outside)**: formulate continuous boundary conditions (continuity of $\psi$ and $\frac{d\psi}{dx}$ at $x = \pm a$), derive the exponential evanescent decay tails in the classically forbidden barrier regions ($\kappa = \frac{\sqrt{-2mE}}{\hbar}$), derive the dimensionless **Transcendental Equations** for even parity ($\xi \tan\xi = \eta$) and odd parity ($-\xi \cot\xi = \eta$) with circle constraint $\xi^2 + \eta^2 = z_0^2 = \frac{2m V_0 a^2}{\hbar^2}$, prove that **at least ONE bound state ALWAYS exists in 1D**, and find the critical well strength for higher excited states.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Finite Square Well & Transcendental Boundary Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Even Bound State Transcendental Matching Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Well Parameter & Bound State Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | 1D Symmetric Finite Well Minimum Guaranteed Bound State Count Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Graphical Solution of Transcendental Bound States and Odd State Cutoff Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Symmetric Finite Square Well ($V(x) = -V_0$ for $|x| \le a$, and $0$ for $|x| > a$):
   - **Wavefunction Regions (Bound states $-V_0 < E < 0$):**
     - Inside ($|x| \le a$): Oscillatory $\psi(x) = D\cos(lx)$ (Even) or $C\sin(lx)$ (Odd), with $l \equiv \frac{\sqrt{2m(E + V_0)}}{\hbar}$.
     - Outside ($|x| > a$): Evanescent exponential decay $\psi(x) = F e^{-\kappa |x|}$, with $\kappa \equiv \frac{\sqrt{-2mE}}{\hbar}$.
   - **Boundary Conditions at $x = a$ (Smooth matching):**
     $$\psi(a^-) = \psi(a^+), \qquad \psi'(a^-) = \psi'(a^+)$$
   - **Dimensionless Variables ($\xi \equiv l a$, $\eta \equiv \kappa a$):**
     $$\xi^2 + \eta^2 = z_0^2 \equiv \frac{2m V_0 a^2}{\hbar^2} \quad (\text{Circle of Radius } z_0)$$
   - **Transcendental Matching Equations:**
     $$\text{Even Parity Bound States: } \xi \tan\xi = \eta = \sqrt{z_0^2 - \xi^2}$$
     $$\text{Odd Parity Bound States: } -\xi \cot\xi = \eta = \sqrt{z_0^2 - \xi^2}$$
   - **Theorem:** No matter how shallow ($V_0 \to 0$) or narrow ($a \to 0$) the well is, there is **ALWAYS AT LEAST ONE BOUND STATE** (an even-parity ground state)!
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the even parity transcendental relation: (1) write even wavefunction ansatz: $\psi_{\text{in}}(x) = D\cos(lx)$ and $\psi_{\text{out}}(x) = F e^{-\kappa x}$ for $x > a$, (2) match wavefunctions at $x = a$: $D\cos(la) = F e^{-\kappa a}$, (3) match first spatial derivatives at $x = a$: $-D l\sin(la) = -\kappa F e^{-\kappa a}$, (4) divide derivative equation by value equation to eliminate unknown amplitudes $D$ and $F$: $\frac{-D l\sin(la)}{D\cos(la)} = \frac{-\kappa F e^{-\kappa a}}{F e^{-\kappa a}} \implies l\tan(la) = \kappa$, (5) multiply both sides by half-width $a$ and substitute $\xi = la, \eta = \kappa a$ to obtain $\xi\tan\xi = \eta$!
3. **Slide 3 (`matching`):** Pair 4 finite well properties (Even Parity States, Odd Parity States, Circle Radius $z_0$, Infinite Well Limit $z_0 \to \infty$) with their mathematical conditions ($\xi\tan\xi = \eta$, $-\xi\cot\xi = \eta$, $z_0 = \frac{a}{\hbar}\sqrt{2mV_0}$, $\xi_n \to n\pi/2$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that every 1D symmetric attractive finite square well possesses at least 1 bound state regardless of how small $V_0$ is. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the minimum well depth for the FIRST ODD BOUND STATE: What is the threshold value of $z_0 = \frac{a}{\hbar}\sqrt{2mV_0}$ required to support at least one odd-parity bound state? ($z_0 \ge \pi/2$; the odd-parity curve $\eta = -\xi\cot\xi$ originates at $\xi = \pi/2$, so an odd bound state requires the circle radius to satisfy $z_0 \ge \pi/2$, meaning very shallow wells ($z_0 < \pi/2$) possess only a single even bound state).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "finite_square_well_and_transcendental_bound_states",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Finite Square Well and Transcendental Bound States**\n• **Symmetric Potential:** $V(x) = -V_0$ ($|x| \\le a$), and $0$ elsewhere.\n• **Wavefunctions (Bound States $-V_0 < E < 0$):**\n  - **Interior ($|x| \\le a$):** Oscillatory $\\cos(lx)$ (Even) or $\\sin(lx)$ (Odd), with $l = \\frac{\\sqrt{2m(E+V_0)}}{\\hbar}$.\n  - **Exterior ($|x| > a$):** Exponential evanescent decay $e^{-\\kappa |x|}$, with $\\kappa = \\frac{\\sqrt{-2mE}}{\\hbar}$.\n• **Transcendental Matching Equations ($\\xi = la, \\eta = \\kappa a, \\xi^2 + \\eta^2 = z_0^2$):**\n$$\n\\text{Even Parity: } \\xi \\tan\\xi = \\eta = \\sqrt{z_0^2 - \\xi^2}, \\qquad \\text{Odd Parity: } -\\xi \\cot\\xi = \\eta = \\sqrt{z_0^2 - \\xi^2}\n$$\n  *(where well capacity parameter is $z_0 = \\frac{a}{\\hbar}\\sqrt{2m V_0}$).*\n• **Fundamental Theorem:** A 1D symmetric attractive well **ALWAYS supports at least 1 bound state** (even ground state) for ANY $V_0 > 0$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the boundary matching steps deriving the even bound state transcendental equation xi tan(xi) = eta.",
      "orderItems": [
        "Write the even wavefunctions: psi_in(x) = D * cos(l x) inside and psi_out(x) = F * exp(-kappa x) outside for x > a",
        "Enforce wavefunction continuity at x = a: D * cos(l a) = F * exp(-kappa a)",
        "Enforce first derivative continuity at x = a: -D * l * sin(l a) = -kappa * F * exp(-kappa a)",
        "Divide the derivative equation by the amplitude equation to cancel constants D and F: l * tan(l a) = kappa",
        "Multiply both sides by well half-width a and substitute dimensionless variables xi = l*a and eta = kappa*a to get xi * tan(xi) = eta"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each finite square well condition to its graphical property.",
      "matchPairs": [
        { "left": "Even Parity Bound States", "right": "Intersections of eta = xi * tan(xi) with circle xi^2 + eta^2 = z_0^2" },
        { "left": "Odd Parity Bound States", "right": "Intersections of eta = -xi * cot(xi) with circle xi^2 + eta^2 = z_0^2" },
        { "left": "Shallow Well Limit (z_0 < pi/2)", "right": "Exactly ONE bound state exists (ground state with even parity)" },
        { "left": "Deep Well Limit (z_0 -> infinity)", "right": "Energy levels approach infinite square well spectrum E_n" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A one-dimensional symmetric attractive finite potential well always possesses at least ___ bound state regardless of how shallow the well is.",
      "blankAnswer": "1",
      "blankDistractors": ["0", "2", "infinite"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the minimum well parameter z_0 = (a / hbar) sqrt(2 m V_0) required to produce the FIRST ODD-PARITY BOUND STATE in a symmetric finite well?",
      "options": [
        { "text": "z_0 >= pi / 2; because the odd transcendental branch eta = -xi * cot(xi) starts at xi = pi / 2, the circle radius must be at least pi / 2 for an intersection to exist", "isCorrect": true, "explanation": "Correct! As xi -> 0, -xi cot(xi) -> -1 (unphysical since eta >= 0). The curve -xi cot(xi) enters the positive quadrant at xi = pi/2. Therefore, a circle of radius z_0 cannot intersect the odd branch unless z_0 >= pi/2." },
        { "text": "z_0 >= pi", "isCorrect": false, "explanation": "Incorrect: That is the threshold for the second even state." },
        { "text": "z_0 = 0", "isCorrect": false, "explanation": "Incorrect: At z_0 < pi/2, only the even ground state exists." },
        { "text": "z_0 >= 2 pi", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
