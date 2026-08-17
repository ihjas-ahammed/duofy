# Duofy Reusable Lesson Format: Ginzburg-Landau Theory and Type I/II Superconductors

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Superconductivity_and_Magnetism`  
**Lesson Format Type:** `ginzburg_landau_and_type_i_ii_superconductivity`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the phenomenological theory of superconductivity: formulate **Ginzburg-Landau (GL) Free Energy** with complex order parameter $\psi(\mathbf{r})$, define the **GL Coherence Length $\xi(T)$** and **Penration Depth $\lambda(T)$**, evaluate the **GL Parameter $\kappa = \lambda/\xi$**, classify **Type I ($\kappa < 1/\sqrt{2}$)** vs **Type II ($\kappa > 1/\sqrt{2}$)** superconductors, evaluate the **Mixed Shubnikov Vortex State**, calculate the **Magnetic Flux Quantum ($\Phi_0 = \frac{h}{2e} \approx 2.07 \times 10^{-15}\text{ Wb}$)**, and determine critical fields $H_{c1}$ and $H_{c2}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ginzburg-Landau Theory & Type I/II Superconductors Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Magnetic Flux Quantization Integral Derivation | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Superconductor Type / Regime & Magnetic Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Critical Ginzburg-Landau Parameter Kappa Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Abrikosov Vortex Lattice and Upper Critical Field H_c2 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Ginzburg-Landau Theory of Phase Transitions (Vitaly Ginzburg & Lev Landau, 1950):
   - **Complex Order Parameter:** $\psi(\mathbf{r}) = |\psi(\mathbf{r})| e^{i\theta(\mathbf{r})}$, where $|\psi|^2 = n_s / 2$ is Cooper pair density.
   - **Two Characteristic Length Scales:**
     - **Penetration Depth:** $\lambda(T) \propto (1 - T/T_c)^{-1/2}$ (scale over which $\mathbf{B}$ decays).
     - **Coherence Length:** $\xi(T) \propto (1 - T/T_c)^{-1/2}$ (scale over which order parameter $|\psi|$ can vary).
   - **The Ginzburg-Landau Parameter:** $\kappa \equiv \frac{\lambda}{\xi}$.
   - **Classification (Alexei Abrikosov, 1957):**
     - **Type I ($\kappa < \frac{1}{\sqrt{2}} \approx 0.707$):** Positive surface energy $\sigma_{NS} > 0$. Abrupt transition at $H_c$.
     - **Type II ($\kappa > \frac{1}{\sqrt{2}}$):** Negative surface energy $\sigma_{NS} < 0$. Forms **Mixed Vortex State** between lower critical field $H_{c1}$ and upper critical field $H_{c2} = \frac{\Phi_0}{2\pi \xi^2}$.
   - **Magnetic Flux Quantum:** $\Phi_0 = \frac{h}{2e} \approx 2.0678 \times 10^{-15}\text{ Wb}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct proof of flux quantization around a superconducting ring: (1) express supercurrent density: $\mathbf{J}_s = \frac{q^* n_s^*}{m^*} (\hbar \nabla\theta - q^* \mathbf{A})$ where $q^* = -2e, m^* = 2m_e$, (2) integrate along closed loop $C$ deep inside the superconductor where $\mathbf{J}_s = \mathbf{0}$: $\oint_C \hbar \nabla\theta \cdot d\mathbf{r} = q^* \oint_C \mathbf{A} \cdot d\mathbf{r}$, (3) apply Stokes' theorem to vector potential: $\oint_C \mathbf{A} \cdot d\mathbf{r} = \iint \mathbf{B} \cdot d\mathbf{S} = \Phi$, (4) single-valuedness of wavefunction $\psi = |\psi|e^{i\theta}$ requires phase change around closed loop to be an integer multiple of $2\pi$: $\oint_C \nabla\theta \cdot d\mathbf{r} = 2\pi n$, (5) equate: $\hbar (2\pi n) = (2e) \Phi \implies \Phi = n \left(\frac{h}{2e}\right) = n \Phi_0$!
3. **Slide 3 (`matching`):** Pair 4 superconducting states (Type I Superconductor in $H < H_c$, Type II Superconductor in $H < H_{c1}$, Type II Mixed State $H_{c1} < H < H_{c2}$, High-$T_c$ Cuprates e.g. YBCO) with their vortex and magnetic structures.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the boundary between Type I and Type II superconductivity occurs when $\kappa = 1/\sqrt{2}$ (or approximately 0.707). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Abrikosov vortex state in Type II superconductors: What is the microscopic structure of a single Abrikosov vortex (fluxon)? (A normal, non-superconducting core of radius $\sim \xi$ through which exactly ONE quantum of magnetic flux $\Phi_0 = h/2e$ penetrates, surrounded by circulating supercurrent vortices decaying over radius $\sim \lambda$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ginzburg_landau_and_type_i_ii_superconductivity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Ginzburg-Landau Theory and Type I vs II Superconductors**\n• **The Ginzburg-Landau Order Parameter $\\psi(\\mathbf{r})$:**\n  $|\\psi(\\mathbf{r})|^2 = n_s/2$ (Cooper pair density).\n• **Two Fundamental Length Scales:**\n  - **Penetration Depth $\\lambda$:** Magnetic screening distance.\n  - **Coherence Length $\\xi$:** Distance over which order parameter $\\psi$ recovers.\n• **The Ginzburg-Landau Parameter $\\kappa = \\frac{\\lambda}{\\xi}$ (Abrikosov, 1957):**\n  - **Type I ($\\kappa < 1/\\sqrt{2} \\approx 0.707$):** Positive surface energy ($\\sigma_{NS} > 0$). Complete Meissner expulsion until single critical field $H_c$.\n  - **Type II ($\\kappa > 1/\\sqrt{2}$):** Negative surface energy ($\\sigma_{NS} < 0$). Forms a **Mixed Vortex State** between $H_{c1}$ and $H_{c2}$.\n• **Magnetic Flux Quantum:** $\\Phi_0 = \\frac{h}{2e} \\approx 2.0678 \\times 10^{-15}\\text{ Wb}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Supercurrent Equation):** $\\mathbf{J}_s = \\frac{2e \\, n_s}{2m_e} (\\hbar \\nabla\\theta - 2e \\mathbf{A})$.\n• **Step 2 (Deep Interior Line Integral):** Along closed loop $C$ deep inside where $\\mathbf{J}_s = \\mathbf{0}$, $\\hbar \\oint_C \\nabla\\theta \\cdot d\\mathbf{r} = 2e \\oint_C \\mathbf{A} \cdot d\\mathbf{r}$.\n• **Step 3 (Stokes' Theorem on $\\mathbf{A}$):** $\\oint_C \\mathbf{A} \\cdot d\\mathbf{r} = \\iint \\mathbf{B} \\cdot d\\mathbf{S} = \\Phi$ (total enclosed magnetic flux).\n• **Step 4 (Wavefunction Single-Valuedness):** The phase $\\theta$ must return to itself modulo $2\\pi$: $\\oint_C \\nabla\\theta \\cdot d\\mathbf{r} = 2\\pi n$.\n• **Step 5 (Quantization Result):**\n  $$\\hbar(2\\pi n) = 2e \\Phi \\implies \\Phi = n \\left(\\frac{h}{2e}\\right) = n \\Phi_0!$$"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each superconductor regime to its magnetic behavior.",
      "matchPairs": [
        { "left": "Type I Superconductor (H < H_c)", "right": "Complete Meissner expulsion (B = 0) with sharp first-order transition at H_c" },
        { "left": "Type II Meissner State (H < H_{c1})", "right": "Complete magnetic expulsion (B = 0) below lower critical field H_{c1}" },
        { "left": "Type II Mixed Vortex State (H_{c1} < H < H_{c2})", "right": "Magnetic flux penetrates as a triangular lattice of quantized Abrikosov flux vortices" },
        { "left": "High-Tc Cuprates (e.g. YBCO)", "right": "Extreme Type II superconductors (kappa >> 1, H_{c2} > 100 Tesla)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The boundary separating Type I from Type II superconductors occurs when the Ginzburg-Landau parameter kappa equals 1 / sqrt(___).",
      "blankAnswer": "2",
      "blankDistractors": ["3", "4", "pi"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the internal structure of an individual Abrikosov vortex line in a Type II superconductor?",
      "options": [
        { "text": "A cylindrical NORMAL CORE of radius ≈ xi (where superconductivity is suppressed, |psi| -> 0) carrying exactly ONE quantum of magnetic flux Phi_0 = h / (2e), surrounded by circulating supercurrents decaying over radius ≈ lambda", "isCorrect": true, "explanation": "Correct! In the mixed state, magnetic flux penetrates through quantized flux tubes. Each vortex has a normal core of radius equal to the coherence length xi and magnetic radius equal to the penetration depth lambda." },
        { "text": "A sphere made of pure gold", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A region where all electrons are destroyed", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A hole with zero magnetic field inside", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
