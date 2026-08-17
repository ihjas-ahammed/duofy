# Duofy Reusable Lesson Format: Infinite Square Well and Completeness/Orthogonality

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Schrodinger_Equation_and_Wavefunctions`  
**Lesson Format Type:** `infinite_square_well_and_completeness_orthogonality`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the canonical Particle-in-a-Box model: solve the 1D **Infinite Square Well Potential ($V(x) = 0$ for $0 \le x \le a$, $\infty$ otherwise)**, derive boundary conditions $\psi(0) = \psi(a) = 0$, obtain the **Quantized Energy Spectrum ($E_n = \frac{n^2 \pi^2 \hbar^2}{2 m a^2}$)** and normalized eigenstates $\psi_n(x) = \sqrt{\frac{2}{a}}\sin\left(\frac{n\pi x}{a}\right)$, prove **Orthonormality ($\int_0^a \psi_m^*(x)\psi_n(x)dx = \delta_{mn}$)**, expand arbitrary initial wavefunctions via **Fourier Completeness ($c_n = \langle \psi_n | \Psi(0) \rangle$)**, and calculate time-dependent quantum revivals ($\Psi(x, t) = \sum c_n \psi_n(x) e^{-i E_n t / \hbar}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Infinite Square Well & Fourier Completeness Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Box Energy Quantization Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Box State Property & Quantum Feature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Particle in a Box Energy Quantum Number Power Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Existent n=0 Ground State and Uncertainty Principle Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 1D Infinite Square Well Problem:
   - **Potential:** $V(x) = 0$ for $0 \le x \le a$, and $V(x) = \infty$ outside.
   - **Boundary Conditions:** $\psi(0) = 0$ and $\psi(a) = 0$.
   - **Quantized Energy Eigenvalues:**
     $$E_n = \frac{n^2 \pi^2 \hbar^2}{2 m a^2} = n^2 E_1 \qquad (n = 1, 2, 3, \dots)$$
   - **Normalized Stationary Eigenstates:**
     $$\psi_n(x) = \sqrt{\frac{2}{a}} \sin\left(\frac{n\pi x}{a}\right)$$
   - **Orthonormality & Completeness (Hilbert Space Basis):**
     $$\int_0^a \psi_m^*(x) \psi_n(x) \, dx = \delta_{mn}$$
     $$\Psi(x, t) = \sum_{n=1}^\infty c_n \psi_n(x) e^{-i E_n t / \hbar}, \qquad c_n = \int_0^a \psi_n^*(x) \Psi(x, 0) \, dx, \qquad \sum_{n=1}^\infty |c_n|^2 = 1$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving $E_n$ and $\psi_n(x)$: (1) write TISE inside well where $V = 0$: $-\frac{\hbar^2}{2m}\frac{d^2\psi}{dx^2} = E\psi \implies \frac{d^2\psi}{dx^2} = -k^2\psi$ with $k = \frac{\sqrt{2mE}}{\hbar}$, (2) write general solution: $\psi(x) = A\sin(kx) + B\cos(kx)$, (3) apply left boundary condition $\psi(0) = 0$: $B = 0 \implies \psi(x) = A\sin(kx)$, (4) apply right boundary condition $\psi(a) = 0$: $A\sin(ka) = 0 \implies ka = n\pi$ ($n = 1, 2, 3, \dots$), (5) substitute $k = \frac{n\pi}{a}$ into energy definition $E = \frac{\hbar^2 k^2}{2m} = \frac{n^2\pi^2\hbar^2}{2ma^2}$ and normalize $\int_0^a A^2\sin^2(n\pi x/a)dx = A^2(a/2) = 1 \implies A = \sqrt{\frac{2}{a}}$!
3. **Slide 3 (`matching`):** Pair 4 infinite well states ($n=1$, $n=2$, $n=3$, $n=4$) with their node counts and energies ($0$ internal nodes / $E_1$, $1$ node at $a/2$ / $4E_1$, $2$ nodes / $9E_1$, $3$ nodes / $16E_1$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that energy eigenvalues of the infinite square well scale quadratically with quantum number n as n^2. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why $n=0$ is NOT a valid quantum state for a particle in a box: Why is the state with $n=0$ physically unacceptable? (Setting $n=0$ yields $\psi_0(x) = \sqrt{2/a}\sin(0) = 0$ identically everywhere, which represents no particle at all and cannot be normalized ($\int |\psi|^2 dx = 0 \ne 1$); furthermore, $E=0$ would imply $\Delta p = 0$ in a finite box $\Delta x \le a$, violating Heisenberg's Uncertainty Principle $\Delta x \Delta p \ge \hbar/2$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "infinite_square_well_and_completeness_orthogonality",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Infinite Square Well and Quantum Quantization**\n• **Potential:** $V(x) = 0$ ($0 \\le x \\le a$), $\\infty$ elsewhere.\n• **Boundary Conditions:** $\\psi(0) = 0, \\quad \\psi(a) = 0$.\n• **Quantized Energy Eigenvalues:**\n$$\nE_n = \\frac{n^2 \\pi^2 \\hbar^2}{2 m a^2} = n^2 E_1 \\qquad (n = 1, 2, 3, \\dots)\n$$\n• **Normalized Stationary Eigenstates:**\n$$\n\\psi_n(x) = \\sqrt{\\frac{2}{a}} \\sin\\left(\\frac{n\\pi x}{a}\\right)\n$$\n• **Orthonormality & Fourier Completeness:**\n$$\n\\langle \\psi_m | \\psi_n \\rangle = \\delta_{mn}, \\qquad \\Psi(x, t) = \\sum_{n=1}^\\infty c_n \\psi_n(x) e^{-i E_n t / \\hbar}, \\qquad c_n = \\langle \\psi_n | \\Psi(0) \\rangle\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the boundary value steps deriving the quantized energies E_n = n^2 pi^2 hbar^2 / (2 m a^2).",
      "orderItems": [
        "Write the free Schrödinger equation inside the well (V=0): d^2psi/dx^2 + k^2 psi = 0 with k = sqrt(2mE) / hbar",
        "Formulate the general oscillatory solution: psi(x) = A * sin(k x) + B * cos(k x)",
        "Apply the left hard-wall boundary condition psi(0) = 0 to eliminate the cosine component: B = 0",
        "Apply the right hard-wall boundary condition psi(a) = 0 to establish the quantization condition: k * a = n * pi",
        "Substitute k = n pi / a into the energy relation E = hbar^2 k^2 / (2m) to conclude E_n = n^2 pi^2 hbar^2 / (2 m a^2)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each infinite square well state to its physical characteristics.",
      "matchPairs": [
        { "left": "Ground State (n=1)", "right": "Energy E_1 = pi^2 hbar^2 / (2 m a^2); 0 internal nodes (single central peak)" },
        { "left": "First Excited State (n=2)", "right": "Energy E_2 = 4 E_1; 1 central node at x = a/2" },
        { "left": "Second Excited State (n=3)", "right": "Energy E_3 = 9 E_1; 2 internal nodes at x = a/3 and 2a/3" },
        { "left": "Fourier Probability |c_n|^2", "right": "Probability that an energy measurement on Psi(x, 0) yields the eigenvalue E_n" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The energy levels of a particle in an infinite square well scale quadratically with quantum number n as n to the power of ___.",
      "blankAnswer": "2",
      "blankDistractors": ["1", "3", "1/2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the quantum state n = 0 PHYSICALLY FORBIDDEN for a particle trapped in an infinite square well of width a?",
      "options": [
        { "text": "Setting n = 0 yields psi_0(x) = sqrt(2/a) sin(0) = 0 everywhere, which cannot be normalized (zero particle exists); additionally, a zero-energy state (E=0 => p=0 exactly) in a confined box (Delta x <= a) violates Heisenberg's Uncertainty Principle (Delta x Delta p >= hbar/2)", "isCorrect": true, "explanation": "Correct! A non-zero particle must have int |psi|^2 dx = 1, which psi(x) = 0 fails. Furthermore, confining a particle to width a forces a minimum momentum uncertainty Delta p >= hbar / (2a), preventing exact zero kinetic energy." },
        { "text": "Because n must be a negative number", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because particles can only exist at absolute zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the mass of the particle would become infinite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
