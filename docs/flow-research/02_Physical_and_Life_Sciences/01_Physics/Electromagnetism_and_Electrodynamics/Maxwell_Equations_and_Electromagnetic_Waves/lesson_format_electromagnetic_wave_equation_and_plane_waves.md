# Duofy Reusable Lesson Format: Electromagnetic Wave Equation and Plane Waves

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Maxwell_Equations_and_Electromagnetic_Waves`  
**Lesson Format Type:** `electromagnetic_wave_equation_and_plane_waves`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the wave nature of light: derive the **3D Electromagnetic Wave Equation** ($\nabla^2 \mathbf{E} = \frac{1}{c^2}\frac{\partial^2\mathbf{E}}{\partial t^2}$) in vacuum by taking the curl of Faraday's Law, derive the **Speed of Light $c = \frac{1}{\sqrt{\mu_0\epsilon_0}}$**, evaluate **Monochromatic Transverse Plane Waves** ($\mathbf{E}(\mathbf{r}, t) = \mathbf{E}_0 e^{i(\mathbf{k}\cdot\mathbf{r} - \omega t)}$), prove the orthogonal triad relation $\mathbf{B}_0 = \frac{1}{c}(\hat{\mathbf{k}}\times\mathbf{E}_0)$, and analyze linear, circular, and elliptical polarization states.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | EM Wave Equation & Plane Waves Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step EM Wave Equation Vector Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Wave Parameter & Physical Mathematical Relation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Transverse Wave k Dot E Dot Product Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Amplitude Ratio E_0 to B_0 in Vacuum Plane Wave Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the derivation of the Wave Equation in free space ($\rho = 0, \mathbf{J} = \mathbf{0}$):
   $$\nabla^2 \mathbf{E} = \mu_0 \epsilon_0 \frac{\partial^2 \mathbf{E}}{\partial t^2} = \frac{1}{c^2} \frac{\partial^2 \mathbf{E}}{\partial t^2}, \qquad \nabla^2 \mathbf{B} = \frac{1}{c^2} \frac{\partial^2 \mathbf{B}}{\partial t^2}$$
   - **The Speed of Light in Vacuum:**
     $$c = \frac{1}{\sqrt{\mu_0 \epsilon_0}} = 299,792,458\text{ m/s}$$
   - **Monochromatic Plane Wave Solutions:**
     $$\mathbf{E}(\mathbf{r}, t) = \mathbf{E}_0 e^{i(\mathbf{k} \cdot \mathbf{r} - \omega t)}, \qquad \mathbf{B}(\mathbf{r}, t) = \mathbf{B}_0 e^{i(\mathbf{k} \cdot \mathbf{r} - \omega t)}$$
   - **Transverse Properties from Maxwell's Equations:**
     - $\nabla \cdot \mathbf{E} = 0 \implies \mathbf{k} \cdot \mathbf{E}_0 = 0$ (Electric field is perpendicular to propagation vector $\mathbf{k}$).
     - $\nabla \cdot \mathbf{B} = 0 \implies \mathbf{k} \cdot \mathbf{B}_0 = 0$ (Magnetic field is perpendicular to $\mathbf{k}$).
     - $\nabla \times \mathbf{E} = -\frac{\partial\mathbf{B}}{\partial t} \implies \mathbf{B}_0 = \frac{1}{c} (\hat{\mathbf{k}} \times \mathbf{E}_0)$ (In phase, mutually orthogonal, with $E_0 = c B_0$!).
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the wave equation from Maxwell's equations: (1) take the curl of Faraday's Law: $\nabla \times (\nabla \times \mathbf{E}) = -\nabla \times \left(\frac{\partial\mathbf{B}}{\partial t}\right) = -\frac{\partial}{\partial t}(\nabla \times \mathbf{B})$, (2) apply vector identity: $\nabla \times (\nabla \times \mathbf{E}) = \nabla(\nabla \cdot \mathbf{E}) - \nabla^2 \mathbf{E}$, (3) substitute Gauss's Law in vacuum $\nabla \cdot \mathbf{E} = 0$: $\nabla(\nabla \cdot \mathbf{E}) - \nabla^2 \mathbf{E} = -\nabla^2 \mathbf{E}$, (4) substitute Ampère-Maxwell Law in vacuum $\nabla \times \mathbf{B} = \mu_0 \epsilon_0 \frac{\partial\mathbf{E}}{\partial t}$ into RHS: $-\frac{\partial}{\partial t}(\mu_0 \epsilon_0 \frac{\partial\mathbf{E}}{\partial t}) = -\mu_0 \epsilon_0 \frac{\partial^2 \mathbf{E}}{\partial t^2}$, (5) equate both sides and cancel negative signs: $\nabla^2 \mathbf{E} = \mu_0 \epsilon_0 \frac{\partial^2 \mathbf{E}}{\partial t^2} = \frac{1}{c^2}\frac{\partial^2 \mathbf{E}}{\partial t^2}$!
3. **Slide 3 (`matching`):** Pair 4 wave properties (Dispersion Relation, Wavelength $\lambda$, Wavevector $\mathbf{k}$, B-field Amplitude $B_0$) with their mathematical definitions ($\omega = c k$, $\lambda = 2\pi/k$, $\mathbf{k} = \frac{2\pi}{\lambda}\hat{\mathbf{k}}$, $B_0 = E_0/c$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that for transverse electromagnetic waves in vacuum, the dot product k . E_0 equals 0. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the ratio of electric to magnetic field amplitudes in a vacuum plane wave: For a monochromatic plane wave traveling in vacuum with electric field amplitude $E_0 = 300\text{ V/m}$, what is the magnetic field amplitude $B_0$? ($B_0 = \frac{E_0}{c} = \frac{300}{3.0 \times 10^8} = 1.0 \times 10^{-6}\text{ Tesla} = 1.0\ \mu\text{T}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "electromagnetic_wave_equation_and_plane_waves",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Electromagnetic Wave Equation and Plane Waves**\n• **The 3D Wave Equation in Vacuum:**\n$$\n\\nabla^2 \\mathbf{E} = \\frac{1}{c^2} \\frac{\\partial^2 \\mathbf{E}}{\\partial t^2}, \\qquad \\nabla^2 \\mathbf{B} = \\frac{1}{c^2} \\frac{\\partial^2 \\mathbf{B}}{\\partial t^2}\n$$\n• **The Speed of Light:** $c = \\frac{1}{\\sqrt{\\mu_0 \\epsilon_0}} = 299,792,458\\text{ m/s}$.\n• **Monochromatic Plane Wave Triad:**\n$$\n\\mathbf{E}(\\mathbf{r}, t) = \\mathbf{E}_0 e^{i(\\mathbf{k} \\cdot \\mathbf{r} - \\omega t)}, \\qquad \\mathbf{B}(\\mathbf{r}, t) = \\frac{1}{c} (\\hat{\\mathbf{k}} \\times \\mathbf{E})\n$$\n• **Transverse Nature:** $\\mathbf{E} \\perp \\mathbf{B} \\perp \\hat{\\mathbf{k}}$, and amplitudes satisfy $E_0 = c B_0$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the vector calculus steps deriving the electromagnetic wave equation from Maxwell's equations.",
      "orderItems": [
        "Take the vector curl of Faraday's Law: curl(curl(E)) = -d/dt(curl(B))",
        "Apply the vector Laplacian identity to the LHS: curl(curl(E)) = grad(div(E)) - Laplacian(E)",
        "Substitute vacuum Gauss's Law div(E) = 0 to reduce LHS to -Laplacian(E)",
        "Substitute vacuum Ampère-Maxwell Law curl(B) = mu_0 * eps_0 * dE/dt into the RHS",
        "Equate LHS and RHS to obtain the wave equation: Laplacian(E) = mu_0 * eps_0 * d^2E/dt^2 = (1/c^2) * d^2E/dt^2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each plane wave parameter to its definition.",
      "matchPairs": [
        { "left": "Dispersion Relation in Vacuum", "right": "omega = c * k = 2 pi * f" },
        { "left": "Magnetic Field Amplitude", "right": "B_0 = E_0 / c" },
        { "left": "Transverse Field Condition", "right": "k . E_0 = 0 and k . B_0 = 0 (fields are perpendicular to propagation)" },
        { "left": "Circular Polarization", "right": "Two equal-amplitude orthogonal E-components with 90° (pi/2) phase difference" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because electromagnetic waves in vacuum are strictly transverse, the dot product k . E_0 between wavevector k and electric amplitude E_0 equals ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "c", "omega"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For a laser beam traveling through vacuum with an electric field amplitude E_0 = 300 V/m, what is its magnetic field amplitude B_0?",
      "options": [
        { "text": "B_0 = E_0 / c = 300 / (3.0 × 10^8) = 1.0 × 10^-6 Tesla (1.0 microtesla)", "isCorrect": true, "explanation": "Correct! In a vacuum electromagnetic plane wave, the relation between field amplitudes is strictly E_0 = c * B_0. Thus B_0 = 300 / (3.0 x 10^8) = 1.0 x 10^-6 T." },
        { "text": "B_0 = 300 Tesla", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "B_0 = 300 * c = 9.0 × 10^10 Tesla", "isCorrect": false, "explanation": "Incorrect: E_0 is multiplied by 1/c, not c." },
        { "text": "B_0 = 0 Tesla", "isCorrect": false, "explanation": "Incorrect: EM waves require both E and B." }
      ]
    }
  ]
}
```
