# Duofy Reusable Lesson Format: Time-Dependent Schrödinger Equation and Probability Current

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Schrodinger_Equation_and_Wavefunctions`  
**Lesson Format Type:** `time_dependent_schrodinger_equation_and_probability_current`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fundamental dynamical equation and statistical conservation of quantum mechanics: formulate the **Time-Dependent Schrödinger Equation ($i\hbar\frac{\partial\Psi}{\partial t} = \hat{H}\Psi$)**, define **Born's Statistical Probability Density ($\rho(x, t) = |\Psi(x, t)|^2$)**, derive the **Probability Current Density Vector ($J(x, t) = \frac{\hbar}{2mi}(\Psi^*\frac{\partial\Psi}{\partial x} - \Psi\frac{\partial\Psi^*}{\partial x}) = \frac{\hbar}{m}\operatorname{Im}(\Psi^*\nabla\Psi)$)**, prove the **Quantum Continuity Equation ($\frac{\partial\rho}{\partial t} + \nabla\cdot\mathbf{J} = 0$)**, and evaluate global probability normalization conservation ($\frac{d}{dt}\int |\Psi|^2 dV = 0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TDSE & Probability Current Density Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Probability Continuity Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Quantum Dynamical Expression & Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Total Probability Conservation Time Derivative Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Stationary State Probability Current Vanishing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Dynamics and Conservation of Quantum Probability:
   - **The Time-Dependent Schrödinger Equation (TDSE, 1926):**
     $$i\hbar \frac{\partial \Psi(\mathbf{r}, t)}{\partial t} = \hat{H} \Psi(\mathbf{r}, t) = \left[ -\frac{\hbar^2}{2m}\nabla^2 + V(\mathbf{r}, t) \right] \Psi(\mathbf{r}, t)$$
   - **Born's Statistical Interpretation (Max Born, Nobel Prize 1954):**
     $$\rho(\mathbf{r}, t) \equiv |\Psi(\mathbf{r}, t)|^2 = \Psi^* \Psi \qquad (\text{Probability Density per Volume})$$
   - **Probability Current Density Vector:**
     $$\mathbf{J}(\mathbf{r}, t) \equiv \frac{\hbar}{2mi} \left( \Psi^* \nabla\Psi - \Psi \nabla\Psi^* \right) = \frac{\hbar}{m} \operatorname{Im}(\Psi^* \nabla\Psi)$$
   - **Local Probability Conservation (Continuity Equation):**
     $$\frac{\partial \rho}{\partial t} + \nabla \cdot \mathbf{J} = 0$$
   - **Global Probability Conservation:**
     $$\frac{d}{dt} \iiint_{\text{all space}} |\Psi(\mathbf{r}, t)|^2 dV = 0 \implies \iiint |\Psi(\mathbf{r}, t)|^2 dV = 1 \quad \forall t$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the probability continuity equation: (1) express time derivative of probability density: $\frac{\partial\rho}{\partial t} = \frac{\partial(\Psi^*\Psi)}{\partial t} = \frac{\partial\Psi^*}{\partial t}\Psi + \Psi^*\frac{\partial\Psi}{\partial t}$, (2) substitute TDSE $\frac{\partial\Psi}{\partial t} = \frac{1}{i\hbar}\left(-\frac{\hbar^2}{2m}\nabla^2\Psi + V\Psi\right)$ and complex conjugate: $\frac{\partial\Psi^*}{\partial t} = -\frac{1}{i\hbar}\left(-\frac{\hbar^2}{2m}\nabla^2\Psi^* + V\Psi^*\right)$, (3) combine terms and cancel the potential energy $V(\mathbf{r}, t)$ products: $\frac{\partial\rho}{\partial t} = \frac{i\hbar}{2m} (\Psi^* \nabla^2\Psi - \Psi \nabla^2\Psi^*)$, (4) apply vector calculus identity: $\Psi^* \nabla^2\Psi - \Psi \nabla^2\Psi^* = \nabla \cdot (\Psi^* \nabla\Psi - \Psi \nabla\Psi^*)$, (5) factor $-\nabla \cdot$ to define probability current $\mathbf{J}$ and conclude $\frac{\partial\rho}{\partial t} + \nabla \cdot \mathbf{J} = 0$!
3. **Slide 3 (`matching`):** Pair 4 quantum dynamical expressions ($\rho(x, t)$, $J(x, t)$, Plane Wave $\Psi = A e^{i(kx - \omega t)}$, Real Stationary State $\psi(x)$) with their probability current values ($\Psi^*\Psi$, $\frac{\hbar}{m}\operatorname{Im}(\Psi^*\nabla\Psi)$, $J = |A|^2 \frac{\hbar k}{m} = |A|^2 v$, $J = 0$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the time derivative of the total integrated quantum probability across all space d/dt (int |Psi|^2 dx) equals 0. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the probability current of a bound stationary state: Why is the probability current density $J(x)$ IDENTICALLY ZERO for any non-degenerate bound stationary state whose spatial wavefunction $\psi(x)$ can be chosen purely real? (Because for a real wavefunction $\psi(x) = \psi^*(x)$, the gradient is also real ($\nabla\psi = \nabla\psi^*$), so $\Psi^*\nabla\Psi - \Psi\nabla\Psi^* = \psi\nabla\psi - \psi\nabla\psi = 0$, meaning bound stationary states have static probability distributions with zero net probability flow).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "time_dependent_schrodinger_equation_and_probability_current",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Time-Dependent Schrödinger Equation and Probability Current**\n• **The Time-Dependent Schrödinger Equation (TDSE):**\n$$\ni\\hbar \\frac{\\partial \\Psi}{\\partial t} = \\hat{H}\\Psi = -\\frac{\\hbar^2}{2m}\\nabla^2\\Psi + V(\\mathbf{r}, t)\\Psi\n$$\n• **Born Probability Density:** $\\rho(\\mathbf{r}, t) = |\\Psi(\\mathbf{r}, t)|^2 = \\Psi^* \\Psi$.\n• **Probability Current Density Vector $\\mathbf{J}(\\mathbf{r}, t)$:**\n$$\n\\mathbf{J}(\\mathbf{r}, t) \\equiv \\frac{\\hbar}{2mi} \\left( \\Psi^* \\nabla\\Psi - \\Psi \\nabla\\Psi^* \\right) = \\frac{\\hbar}{m} \\operatorname{Im}(\\Psi^* \\nabla\\Psi)\n$$\n• **Local Conservation Law (Continuity Equation):**\n$$\n\\frac{\\partial \\rho}{\\partial t} + \\nabla \\cdot \\mathbf{J} = 0 \\implies \\frac{d}{dt} \\iiint |\\Psi(\\mathbf{r}, t)|^2 dV = 0\n$$\n  *(Guarantees that a normalized wavefunction remains 100% normalized for all future times!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the calculus steps proving the local quantum probability continuity equation d(rho)/dt + div(J) = 0.",
      "orderItems": [
        "Differentiate probability density with respect to time using product rule: d(rho)/dt = (dPsi*/dt)*Psi + Psi*(dPsi/dt)",
        "Substitute TDSE for dPsi/dt = (1/i hbar) [ -(hbar^2 / 2m) Laplacian(Psi) + V Psi ] and its complex conjugate",
        "Observe the exact algebraic cancellation of the real potential energy terms V * Psi* * Psi",
        "Factor out the kinetic terms: d(rho)/dt = (i hbar / [2m]) * [ Psi* Laplacian(Psi) - Psi Laplacian(Psi*) ]",
        "Rewrite using vector identity as the divergence of the probability current: d(rho)/dt = -div( (hbar / [2mi]) [ Psi* grad(Psi) - Psi grad(Psi*) ] ) = -div(J)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each wavefunction state to its probability current density J.",
      "matchPairs": [
        { "left": "Free Traveling Plane Wave Psi = A * exp(i [k x - omega t])", "right": "J = |A|^2 * (hbar * k / m) = |A|^2 * v (uniform rightward probability flux)" },
        { "left": "Purely Real Stationary State psi(x)", "right": "J = 0 everywhere (static probability, zero net current)" },
        { "left": "Superposition of Two Stationary States", "right": "J(x, t) oscillates sinusoidally at Bohr transition frequency omega_21" },
        { "left": "Evanescent Decaying Wave Psi = A * exp(-kappa * x)", "right": "J = 0 (exponential attenuation carries zero steady net flux)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because quantum probability is globally conserved under unitary time evolution, the time derivative d/dt (int |Psi|^2 dV) equals ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "hbar", "infinity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the probability current density J(x) IDENTICALLY ZERO for any bound stationary state whose spatial wavefunction psi(x) is purely real?",
      "options": [
        { "text": "For a real wavefunction psi(x) = psi*(x), the term (psi* dpsi/dx - psi dpsi*/dx) = (psi dpsi/dx - psi dpsi/dx) = 0 vanishes identically, meaning bound stationary states represent standing waves with zero net flow of probability", "isCorrect": true, "explanation": "Correct! Probability current J = (hbar / m) Im(psi* grad(psi)). If psi is real, psi* grad(psi) is strictly real, so its imaginary part is identically zero. Bound stationary states are standing waves with no net directional transport of probability." },
        { "text": "Because the particle has zero kinetic energy", "isCorrect": false, "explanation": "Incorrect: Kinetic energy is positive." },
        { "text": "Because the particle is stationary at one point in space", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Planck's constant is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
