# Duofy Reusable Lesson Format: Zeeman and Stark Effects

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Perturbation_Theory_Time_Dependent_and_Independent`  
**Lesson Format Type:** `zeeman_and_stark_effects`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through atomic spectral line splitting in external fields: formulate the **Zeeman Effect** in magnetic fields ($\hat{H}_Z = \frac{\mu_B}{\hbar}(\mathbf{L} + 2\mathbf{S})\cdot\mathbf{B}$), calculate the **Landé $g$-Factor ($g_J = 1 + \frac{j(j+1) + s(s+1) - l(l+1)}{2j(j+1)}$)** for the weak-field Anomalous Zeeman Effect ($\Delta E = \mu_B g_J B_{\text{ext}} m_j$), evaluate the strong-field **Paschen-Back Effect** where $\mathbf{L}$ and $\mathbf{S}$ decouple, evaluate the **Stark Effect** in electric fields ($\hat{H}_{\text{Stark}} = -e E z$), and contrast the **Linear Stark Effect in Degenerate $n=2$ Hydrogen** with the **Quadratic Stark Effect in Non-Degenerate Ground States**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Zeeman & Stark Field Perturbations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Hydrogen n=2 Linear Stark Subspace Secular Equation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Atomic Field Regime & Energy Splitting Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Pure Orbital Landé g-Factor Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Linear vs Quadratic Stark Effect Parity Selection Rule Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Magnetic and Electric Field Atomic Perturbations:
   - **The Zeeman Effect (Pieter Zeeman, 1896):**
     $$\hat{H}_Z = -\boldsymbol{\mu} \cdot \mathbf{B}_{\text{ext}} = \frac{\mu_B}{\hbar} (\mathbf{L} + g_s \mathbf{S}) \cdot \mathbf{B}_{\text{ext}} \qquad (\text{where } g_s \approx 2, \ \mu_B = \frac{e\hbar}{2m})$$
     - **Weak Field ($B_{\text{ext}} \ll B_{\text{int}} \sim 10\text{ T}$, Anomalous Zeeman):** Good states $|j, m_j\rangle$:
       $$\Delta E_Z = \mu_B g_J B_{\text{ext}} m_j, \qquad g_J = 1 + \frac{j(j+1) + s(s+1) - l(l+1)}{2j(j+1)}$$
     - **Strong Field ($B_{\text{ext}} \gg B_{\text{int}}$, Paschen-Back):** $\mathbf{L}$ and $\mathbf{S}$ decouple, good states $|l, m_l, s, m_s\rangle$:
       $$\Delta E_{\text{PB}} = \mu_B B_{\text{ext}} (m_l + 2 m_s)$$
   - **The Stark Effect (Johannes Stark, 1913):**
     $$\hat{H}_{\text{Stark}} = -q \mathbf{E}_{\text{ext}} \cdot \mathbf{r} = +e \mathcal{E} z = e \mathcal{E} r \cos\theta$$
     - **Linear Stark Effect:** Occurs in degenerate $n=2$ hydrogen ($2s$ and $2p$ mix via dipole matrix element $\langle 2s | z | 2p_0 \rangle = -3 e a_0 \mathcal{E}$).
     - **Quadratic Stark Effect:** Occurs in non-degenerate ground states ($E^{(1)} = \langle 100 | z | 100 \rangle = 0$ by parity; $E^{(2)} \propto \mathcal{E}^2$).
2. **Slide 2 (`ordering`):** Provide 5 steps finding the linear Stark splitting for $n=2$ Hydrogen: (1) identify 4-fold degenerate basis: $|2s\rangle, |2p_0\rangle, |2p_1\rangle, |2p_{-1}\rangle$, (2) check parity: all diagonal matrix elements vanish by parity: $\langle 2s | z | 2s \rangle = \langle 2p_m | z | 2p_m \rangle = 0$, (3) evaluate off-diagonal dipole matrix element between opposite-parity states: $\langle 2s | e \mathcal{E} z | 2p_0 \rangle = -3 e a_0 \mathcal{E}$, (4) construct $4 \times 4$ secular determinant with only non-zero entries between $2s$ and $2p_0$: $\det\begin{pmatrix} -E^{(1)} & -3 e a_0 \mathcal{E} & 0 & 0 \\ -3 e a_0 \mathcal{E} & -E^{(1)} & 0 & 0 \\ 0 & 0 & -E^{(1)} & 0 \\ 0 & 0 & 0 & -E^{(1)} \end{pmatrix} = 0$, (5) solve eigenvalue equation to find split energy levels: $E^{(1)} = \pm 3 e a_0 \mathcal{E}$ and $E^{(1)} = 0$ (two unshifted levels)!
3. **Slide 3 (`matching`):** Pair 4 field effects (Weak-Field Zeeman, Strong-Field Paschen-Back, Hydrogen $n=2$ Linear Stark, Ground State Quadratic Stark) with their energy shift behaviors.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that for a pure orbital state with spin s = 0 (Normal Zeeman effect), the Landé g-factor g_J equals 1. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why the atomic ground state (1s) exhibits a QUADRATIC Stark effect rather than a linear Stark effect: Why is the first-order Stark shift $E^{(1)} = 0$ for the ground state of hydrogen? (Because the unperturbed ground state $\psi_{100}(\mathbf{r})$ has definite positive parity ($P\psi_{100} = +\psi_{100}$); since the perturbation operator $\hat{H}' = e\mathcal{E}z$ is odd under spatial inversion ($P z = -z$), the integrand $|\psi_{100}|^2 z$ is strictly odd, making the first-order spatial integral vanish identically).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "zeeman_and_stark_effects",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Zeeman and Stark Spectral Line Splitting**\n• **The Zeeman Effect (Magnetic Field $\\mathbf{B}$):**\n  - **Weak Field ($B \\ll B_{\\text{int}}$, Anomalous Zeeman):**\n$$\n\\Delta E_Z = \\mu_B g_J B m_j, \\qquad g_J = 1 + \\frac{j(j+1) + s(s+1) - l(l+1)}{2j(j+1)}\n$$\n  - **Strong Field ($B \\gg B_{\\text{int}}$, Paschen-Back):** $\\Delta E_{\\text{PB}} = \\mu_B B (m_l + 2 m_s)$.\n• **The Stark Effect (Electric Field $\\boldsymbol{\\mathcal{E}}$ along $z$):**\n  - **Perturbation:** $\\hat{H}' = e \\mathcal{E} z$.\n  - **Degenerate $n=2$ Hydrogen (Linear Stark):** $\\Delta E = \\pm 3 e a_0 \\mathcal{E}, 0$ (linear in $\\mathcal{E}$).\n  - **Non-Degenerate Ground State (Quadratic Stark):** $E^{(1)} = 0$ (by parity), $E^{(2)} \\propto \\mathcal{E}^2$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the degenerate matrix steps deriving the linear Stark splitting for n=2 Hydrogen.",
      "orderItems": [
        "Set up the 4-fold degenerate basis for n=2: |2,0,0>, |2,1,0>, |2,1,1>, |2,1,-1>",
        "Observe that all diagonal matrix elements <2,l,m| z |2,l,m> vanish identically due to spatial parity",
        "Compute the only non-vanishing off-diagonal matrix element: <2,0,0| e*E*z |2,1,0> = -3 e a_0 E",
        "Formulate the 4x4 secular determinant containing a 2x2 coupled sub-block between 2s and 2p_0",
        "Solve the characteristic equation to find two linearly split states E^(1) = +-3 e a_0 E and two unshifted states E^(1) = 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each field perturbation regime to its energy shift expression.",
      "matchPairs": [
        { "left": "Weak-Field Zeeman Shift", "right": "Delta E = mu_B * g_J * B * m_j (governed by Landé g-factor)" },
        { "left": "Strong-Field Paschen-Back Shift", "right": "Delta E = mu_B * B * (m_l + 2 * m_s) (L and S decouple)" },
        { "left": "Hydrogen n=2 Linear Stark Shift", "right": "Delta E = +-3 * e * a_0 * E (linear in applied electric field)" },
        { "left": "Ground State (1s) Quadratic Stark Shift", "right": "Delta E = -(9/4) * (4 pi eps_0) * a_0^3 * E^2 (quadratic in E)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For a spinless particle (s = 0, Normal Zeeman effect where j = l), the Landé g-factor g_J equals ___.",
      "blankAnswer": "1",
      "blankDistractors": ["2", "1/2", "0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the ground state (1s) of a hydrogen atom exhibit a QUADRATIC Stark effect (Delta E ∝ E²) rather than a linear Stark effect?",
      "options": [
        { "text": "The ground state |100> has definite POSITIVE PARITY; because the dipole perturbation operator e*E*z is an ODD function of position, the first-order expectation value <100| z |100> vanishes identically by parity, forcing the lowest non-zero shift to appear at second order (E^(2) ∝ E²)", "isCorrect": true, "explanation": "Correct! The integrand in <100| z |100> is the product of an even probability density |psi_100|^2 and an odd coordinate function z. The symmetric integral over all space is strictly zero, meaning there is no permanent electric dipole moment in the 1s state and the leading response is induced polarization (quadratic in E)." },
        { "text": "Because electric fields cannot interact with electrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the fine structure constant is zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hydrogen is a gas", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
