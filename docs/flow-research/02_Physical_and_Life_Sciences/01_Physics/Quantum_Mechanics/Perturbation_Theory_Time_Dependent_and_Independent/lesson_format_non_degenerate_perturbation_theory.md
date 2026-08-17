# Duofy Reusable Lesson Format: Non-Degenerate Perturbation Theory

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Perturbation_Theory_Time_Dependent_and_Independent`  
**Lesson Format Type:** `non_degenerate_perturbation_theory`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the Rayleigh-Schrödinger perturbation series for non-degenerate energy levels: formulate $\hat{H} = \hat{H}_0 + \lambda \hat{H}'$, derive the **First-Order Energy Shift ($E_n^{(1)} = \langle \psi_n^{(0)} | \hat{H}' | \psi_n^{(0)} \rangle$)**, derive the **First-Order Wavefunction Correction ($|\psi_n^{(1)}\rangle = \sum_{k \ne n} \frac{\langle \psi_k^{(0)} | \hat{H}' | \psi_n^{(0)} \rangle}{E_n^{(0)} - E_k^{(0)}} |\psi_k^{(0)}\rangle$)**, derive the **Second-Order Energy Shift ($E_n^{(2)} = \sum_{k \ne n} \frac{|\langle \psi_k^{(0)} | \hat{H}' | \psi_n^{(0)} \rangle|^2}{E_n^{(0)} - E_k^{(0)}}$)**, and prove that the ground state second-order energy correction is strictly non-positive ($E_0^{(2)} \le 0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Rayleigh-Schrödinger Perturbation Series Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Power-Matching Perturbation Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Perturbation Order & Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Ground-State Second-Order Energy Shift Sign Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Perturbed Infinite Square Well Delta-Function Potential Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Non-Degenerate Rayleigh-Schrödinger Perturbation Theory:
   - **Hamiltonian Expansion:** $\hat{H} = \hat{H}_0 + \lambda \hat{H}'$ (where $\lambda \ll 1$ is a small dimensionless parameter).
   - **State and Energy Expansions:**
     $$|n\rangle = |n^{(0)}\rangle + \lambda |n^{(1)}\rangle + \lambda^2 |n^{(2)}\rangle + \dots, \qquad E_n = E_n^{(0)} + \lambda E_n^{(1)} + \lambda^2 E_n^{(2)} + \dots$$
   - **1st-Order Energy Correction:**
     $$E_n^{(1)} = \langle n^{(0)} | \hat{H}' | n^{(0)}\rangle$$
   - **1st-Order Eigenstate Correction:**
     $$|n^{(1)}\rangle = \sum_{k \ne n} \frac{\langle k^{(0)} | \hat{H}' | n^{(0)}\rangle}{E_n^{(0)} - E_k^{(0)}} \, |k^{(0)}\rangle$$
   - **2nd-Order Energy Correction:**
     $$E_n^{(2)} = \sum_{k \ne n} \frac{|\langle k^{(0)} | \hat{H}' | n^{(0)}\rangle|^2}{E_n^{(0)} - E_k^{(0)}}$$
   - **Theorem:** For the ground state $n = 0$, $E_0^{(0)} < E_k^{(0)}$ for all $k \ne 0 \implies E_0^{(2)} \le 0$ (Ground-state energy is always pushed downwards!).
2. **Slide 2 (`ordering`):** Provide 5 steps deriving $E_n^{(1)}$ and $|n^{(1)}\rangle$: (1) substitute perturbation series into Schrödinger equation: $(\hat{H}_0 + \lambda \hat{H}')(|n^{(0)}\rangle + \lambda |n^{(1)}\rangle + \dots) = (E_n^{(0)} + \lambda E_n^{(1)} + \dots)(|n^{(0)}\rangle + \lambda |n^{(1)}\rangle + \dots)$, (2) collect terms of order $\lambda^1$: $\hat{H}_0 |n^{(1)}\rangle + \hat{H}' |n^{(0)}\rangle = E_n^{(0)} |n^{(1)}\rangle + E_n^{(1)} |n^{(0)}\rangle$, (3) take inner product with $\langle n^{(0)}|$: $\langle n^{(0)}|\hat{H}_0 |n^{(1)}\rangle + \langle n^{(0)}|\hat{H}' |n^{(0)}\rangle = E_n^{(0)} \langle n^{(0)}|n^{(1)}\rangle + E_n^{(1)}$, (4) use hermiticity $\langle n^{(0)}|\hat{H}_0 = E_n^{(0)} \langle n^{(0)}|$ to cancel terms and yield $E_n^{(1)} = \langle n^{(0)}|\hat{H}' |n^{(0)}\rangle$, (5) take inner product with $\langle k^{(0)}|$ ($k \ne n$) to solve for expansion coefficients and construct $|n^{(1)}\rangle$!
3. **Slide 3 (`matching`):** Pair 4 perturbation corrections ($E_n^{(1)}$, $|n^{(1)}\rangle$, $E_n^{(2)}$, $E_0^{(2)}$ sign) with their mathematical formulas and properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the second-order energy correction to the quantum ground state E_0^(2) is always negative (or non-positive). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing a first-order perturbation: An infinite square well $0 \le x \le a$ has a delta-function bump at the center: $\hat{H}' = \alpha \delta(x - a/2)$. What is the first-order energy correction $E_n^{(1)}$ for even quantum numbers $n = 2, 4, 6, \dots$? ($E_n^{(1)} = 0$; for even $n$, the unperturbed wavefunctions $\psi_n(x) = \sqrt{\frac{2}{a}}\sin\left(\frac{n\pi x}{a}\right)$ have nodes at the center: $\psi_n(a/2) = \sqrt{2/a}\sin(n\pi/2) = 0$, so $\langle \psi_n | \alpha\delta(x-a/2) | \psi_n \rangle = \alpha |\psi_n(a/2)|^2 = 0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "non_degenerate_perturbation_theory",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Non-Degenerate Rayleigh-Schrödinger Perturbation Theory**\n• **Hamiltonian:** $\\hat{H} = \\hat{H}_0 + \\lambda \\hat{H}'$.\n• **1st-Order Energy Correction:**\n$$\nE_n^{(1)} = \\langle n^{(0)} | \\hat{H}' | n^{(0)} \\rangle\n$$\n• **1st-Order Wavefunction Correction:**\n$$\n|n^{(1)}\\rangle = \\sum_{k \\ne n} \\frac{\\langle k^{(0)} | \\hat{H}' | n^{(0)} \\rangle}{E_n^{(0)} - E_k^{(0)}} \\, |k^{(0)}\\rangle\n$$\n• **2nd-Order Energy Correction:**\n$$\nE_n^{(2)} = \\sum_{k \\ne n} \\frac{|\\langle k^{(0)} | \\hat{H}' | n^{(0)} \\rangle|^2}{E_n^{(0)} - E_k^{(0)}}\n$$\n• **Ground-State Rule:** $E_0^{(0)} < E_k^{(0)} \\implies E_0^{(2)} \\le 0$ (**The 2nd-order correction always lowers the ground state energy!**)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the power-series matching steps deriving the first-order perturbation equations.",
      "orderItems": [
        "Substitute series expansions for Hamiltonian, state |n>, and energy E_n into the time-independent Schrödinger equation",
        "Collect terms of first order in the expansion parameter lambda: H_0 |n^(1)> + H' |n^(0)> = E_n^(0) |n^(1)> + E_n^(1) |n^(0)>",
        "Project the order-lambda equation onto the unperturbed bra <n^(0)|",
        "Apply hermiticity <n^(0)| H_0 = E_n^(0) <n^(0)| to cancel the |n^(1)> terms on both sides",
        "Conclude with the 1st-order energy correction formula: E_n^(1) = <n^(0)| H' |n^(0)>"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each perturbation term to its mathematical formula.",
      "matchPairs": [
        { "left": "First-Order Energy Shift E_n^(1)", "right": "<n^(0)| H' |n^(0)> (diagonal expectation value of perturbation)" },
        { "left": "First-Order State Correction |n^(1)>", "right": "sum_{k != n} [ <k^(0)| H' |n^(0)> / (E_n^(0) - E_k^(0)) ] |k^(0)>" },
        { "left": "Second-Order Energy Shift E_n^(2)", "right": "sum_{k != n} |<k^(0)| H' |n^(0)>|^2 / (E_n^(0) - E_k^(0))" },
        { "left": "Ground State Second-Order Shift E_0^(2)", "right": "Strictly non-positive (E_0^(2) <= 0 since all energy denominators are negative)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because the unperturbed ground state energy E_0^(0) is lower than all excited state energies, the second-order ground state energy shift E_0^(2) is always ___.",
      "blankAnswer": "negative",
      "blankDistractors": ["positive", "infinite", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A particle in an infinite square well (0 <= x <= a) experiences a delta-function perturbation at the exact center: H' = alpha * delta(x - a/2). What is the first-order energy shift E_n^(1) for EVEN quantum states (n = 2, 4, 6...)?",
      "options": [
        { "text": "E_n^(1) = 0, because the unperturbed wavefunctions psi_n(x) = sqrt(2/a) sin(n pi x / a) have nodes (zeros) at the center x = a/2 for all even n, so the particle never experiences the delta perturbation", "isCorrect": true, "explanation": "Correct! Evaluating E_n^(1) = int |psi_n(x)|^2 alpha delta(x - a/2) dx = alpha |psi_n(a/2)|^2. For even n, sin(n*pi/2) = sin(even*pi / 2) = 0, giving E_n^(1) = 0." },
        { "text": "E_n^(1) = 2 alpha / a", "isCorrect": false, "explanation": "Incorrect: That is the answer for odd n (n = 1, 3, 5...)." },
        { "text": "E_n^(1) = alpha / 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "E_n^(1) = infinity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
