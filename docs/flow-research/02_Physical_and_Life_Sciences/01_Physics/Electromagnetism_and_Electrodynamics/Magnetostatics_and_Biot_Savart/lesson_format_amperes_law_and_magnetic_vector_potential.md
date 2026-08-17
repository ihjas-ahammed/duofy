# Duofy Reusable Lesson Format: Ampère's Law and Magnetic Vector Potential

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Magnetostatics_and_Biot_Savart`  
**Lesson Format Type:** `amperes_law_and_magnetic_vector_potential`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through differential magnetostatics and potential theory: formulate **Ampère's Circuital Law ($\oint \mathbf{B}\cdot d\mathbf{l} = \mu_0 I_{\text{enc}} \iff \nabla \times \mathbf{B} = \mu_0 \mathbf{J}$)**, prove that $\nabla \cdot \mathbf{B} = 0$ implies the existence of the **Magnetic Vector Potential $\mathbf{A}$ ($\mathbf{B} = \nabla \times \mathbf{A}$)**, apply the **Coulomb Gauge ($\nabla \cdot \mathbf{A} = 0$)** to obtain Poisson's vector equation $\nabla^2 \mathbf{A} = -\mu_0 \mathbf{J}$, solve fields for **Ideal Solenoids ($B = \mu_0 n I$)** and **Toroids**, and interpret magnetic flux as the line integral $\Phi = \oint \mathbf{A} \cdot d\mathbf{l}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ampère's Law & Vector Potential Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Stokes' Theorem Ampere Conversion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | High-Symmetry Configuration & Ampère Field Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Magnetic Monopole Non-Existence Divergence of B Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Physical Interpretation of Vector Potential A in Aharonov-Bohm Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Fundamental Laws of Magnetostatics:
   - **Gauss's Law for Magnetism:** $\nabla \cdot \mathbf{B} = 0 \iff \oint_{\partial V} \mathbf{B} \cdot d\mathbf{A} = 0$ (No magnetic monopoles exist!).
   - **Ampère's Circuital Law (André-Marie Ampère, 1826):**
     $$\oint_C \mathbf{B} \cdot d\mathbf{l} = \mu_0 I_{\text{enc}} \iff \nabla \times \mathbf{B} = \mu_0 \mathbf{J}$$
   - **The Magnetic Vector Potential ($\mathbf{A}$):** Because $\nabla \cdot \mathbf{B} = 0$, there exists a vector potential $\mathbf{A}(\mathbf{r})$ such that:
     $$\mathbf{B} = \nabla \times \mathbf{A}$$
   - **Coulomb Gauge ($\nabla \cdot \mathbf{A} = 0$):**
     $$\nabla^2 \mathbf{A} = -\mu_0 \mathbf{J} \implies \mathbf{A}(\mathbf{r}) = \frac{\mu_0}{4\pi} \iiint \frac{\mathbf{J}(\mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|} \, dV'$$
   - **Magnetic Flux Theorem:** $\Phi_B = \iint_S \mathbf{B} \cdot d\mathbf{S} = \oint_{\partial S} \mathbf{A} \cdot d\mathbf{l}$.
2. **Slide 2 (`ordering`):** Provide 5 steps converting Ampère's Law from integral to differential form: (1) write integral Ampère's Law: $\oint_C \mathbf{B} \cdot d\mathbf{l} = \mu_0 I_{\text{enc}}$, (2) express enclosed current as surface integral of current density: $I_{\text{enc}} = \iint_S \mathbf{J} \cdot d\mathbf{S}$, (3) apply Stokes' Theorem to line integral of $\mathbf{B}$: $\oint_C \mathbf{B} \cdot d\mathbf{l} = \iint_S (\nabla \times \mathbf{B}) \cdot d\mathbf{S}$, (4) equate surface integrals: $\iint_S (\nabla \times \mathbf{B}) \cdot d\mathbf{S} = \iint_S (\mu_0 \mathbf{J}) \cdot d\mathbf{S}$, (5) since surface $S$ is arbitrary, conclude $\nabla \times \mathbf{B} = \mu_0 \mathbf{J}$!
3. **Slide 3 (`matching`):** Pair 4 symmetric devices (Infinite Solenoid ($n$ turns/meter), Toroid ($N$ turns, radius $r$), Infinite Current Sheet ($\mathbf{K} = K\hat{\mathbf{x}}$), Thick Wire (radius $R$, total $I$, $r < R$)) with their internal magnetic fields ($B = \mu_0 n I$, $B = \frac{\mu_0 N I}{2\pi r}$, $B = \frac{\mu_0 K}{2}$, $B(r) = \frac{\mu_0 I r}{2\pi R^2}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the divergence of magnetic field B is identically zero. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Aharonov-Bohm Effect (1959): In quantum mechanics, how does the Magnetic Vector Potential $\mathbf{A}$ produce physical observable interference even in regions where the magnetic field is strictly ZERO ($\mathbf{B} = \mathbf{0}$, e.g. outside a long solenoid)? (Electrons split around the solenoid acquire a quantum mechanical gauge phase shift $\Delta\phi = \frac{q}{\hbar} \oint \mathbf{A} \cdot d\mathbf{l} = \frac{q\Phi_B}{\hbar}$ proportional to the enclosed magnetic flux $\Phi_B$, proving $\mathbf{A}$ is more physically fundamental than $\mathbf{B}$ in quantum theory).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "amperes_law_and_magnetic_vector_potential",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Ampère's Law and Magnetic Vector Potential**\n• **Gauss's Law for Magnetism:** $\\nabla \\cdot \\mathbf{B} = 0$ (No magnetic monopoles).\n• **Ampère's Circuital Law (1826):**\n$$\n\\oint_C \\mathbf{B} \\cdot d\\mathbf{l} = \\mu_0 I_{\\text{enc}} \\longleftrightarrow \\nabla \\times \\mathbf{B} = \\mu_0 \\mathbf{J}\n$$\n• **The Magnetic Vector Potential $\\mathbf{A}$:**\n$$\n\\mathbf{B} = \\nabla \\times \\mathbf{A}\n$$\n• **Coulomb Gauge ($\\nabla \\cdot \\mathbf{A} = 0$):**\n$$\n\\nabla^2 \\mathbf{A} = -\\mu_0 \\mathbf{J} \\implies \\mathbf{A}(\\mathbf{r}) = \\frac{\\mu_0}{4\\pi} \\iiint \\frac{\\mathbf{J}(\\mathbf{r}')}{|\\mathbf{r} - \\mathbf{r}'|} \\, dV'\n$$\n• **Flux Equivalence:** $\\Phi_B = \\iint_S \\mathbf{B} \\cdot d\\mathbf{S} = \\oint_{\\partial S} \\mathbf{A} \\cdot d\\mathbf{l}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the vector calculus steps converting Ampère's Law from integral to differential form.",
      "orderItems": [
        "Write Ampère's circuital law: oint_C B . dl = mu_0 * I_enc",
        "Express enclosed current as a surface integral of current density: I_enc = int_S J . dA",
        "Apply Stokes' Theorem to convert line integral to surface integral: oint_C B . dl = int_S (curl B) . dA",
        "Equate the two surface integrals: int_S [ curl(B) - mu_0 * J ] . dA = 0",
        "Since the bounding surface S is arbitrary, deduce that curl(B) = mu_0 * J everywhere"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each symmetric current device to its internal magnetic field B.",
      "matchPairs": [
        { "left": "Ideal Infinite Solenoid (n turns/m)", "right": "B = mu_0 * n * I (uniform axial field inside, 0 outside)" },
        { "left": "Toroid (N turns, inner radius r)", "right": "B = mu_0 * N * I / (2 pi r) (confined circular field inside)" },
        { "left": "Infinite Flat Current Sheet (K = K x_hat)", "right": "B = mu_0 * K / 2 (uniform parallel field above and below)" },
        { "left": "Thick Wire (radius R, r < R)", "right": "B(r) = mu_0 * I * r / (2 pi R^2) (grows linearly with radius)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because magnetic monopoles do not exist in classical electrodynamics, the divergence of the magnetic field div(B) equals ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "mu_0", "eps_0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does the quantum mechanical Aharonov-Bohm Effect (1959) prove regarding the physical reality of the Magnetic Vector Potential A?",
      "options": [
        { "text": "Electrons passing outside a long solenoid (where B = 0 everywhere along their paths) experience an observable quantum phase shift Delta phi = (q / hbar) * oint A . dl = (q / hbar) * Phi_B, proving the vector potential A is a DIRECT PHYSICAL OBSERVABLE in quantum mechanics", "isCorrect": true, "explanation": "Correct! While classical physics views A as a mathematical convenience, the Aharonov-Bohm effect demonstrated that quantum wavefunctions couple directly to A through the gauge-invariant phase loop integral, shifting interference fringes even when B = 0." },
        { "text": "A is zero everywhere in the universe", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Magnetic fields travel faster than light", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Electrons do not have phase", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
