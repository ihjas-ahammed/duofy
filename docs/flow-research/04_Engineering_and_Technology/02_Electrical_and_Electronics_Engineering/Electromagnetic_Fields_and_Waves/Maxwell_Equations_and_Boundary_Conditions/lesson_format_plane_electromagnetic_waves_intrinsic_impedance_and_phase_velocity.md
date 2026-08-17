# Duofy Reusable Lesson Format: Plane EM Waves (Wave Equation, Impedance, & Velocity)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electromagnetic_Fields_and_Waves / Maxwell_Equations_and_Boundary_Conditions`  
**Lesson Format Type:** `plane_electromagnetic_waves_intrinsic_impedance_and_phase_velocity`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through electromagnetic wave propagation, vector wave equation derivation from Maxwell's curl laws, TEM (Transverse Electro-Magnetic) wave structures, phase velocity, and intrinsic medium impedance (Heinrich Hertz 1888; Matthew N.O. Sadiku *Elements of Electromagnetics* Chapter 10; Fawwaz T. Ulaby *Fundamentals of Applied Electromagnetics* Chapter 7): derive the **Homogeneous Vector Helmholtz Wave Equation**:
$$\mathbf{\nabla \times (\nabla \times \mathbf{E}) = -\mu \frac{\partial}{\partial t}(\nabla \times \mathbf{H}) \implies \mathbf{\nabla^2 \mathbf{E} - \mu \epsilon \frac{\partial^2 \mathbf{E}}{\partial t^2} = 0}}$$
derive the **Phase Velocity of Electromagnetic Radiation ($\mathbf{u_p}$)**:
$$\mathbf{u_p = \frac{1}{\sqrt{\mu \epsilon}} = \frac{c}{\sqrt{\mu_r \epsilon_r}} \quad \left(c = \frac{1}{\sqrt{\mu_0 \epsilon_0}} \approx 2.998 \times 10^8\text{ m/s}\right)}$$
derive the **Intrinsic Wave Impedance ($\mathbf{\eta}$)** relating orthogonal transverse $\mathbf{E}$ and $\mathbf{H}$ field amplitudes:
$$\mathbf{\eta = \frac{|\mathbf{E}|}{|\mathbf{H}|} = \sqrt{\frac{\mu}{\epsilon}} = \eta_0 \sqrt{\frac{\mu_r}{\epsilon_r}} \quad \Big| \quad \mathbf{\eta_0 = \sqrt{\frac{\mu_0}{\epsilon_0}} = 120\pi \approx 376.73\,\Omega \approx 377\,\Omega \ (\text{Free Space Impedance})}}$$
and enforce the **TEM Orthogonality Invariant ($\mathbf{\mathbf{H} = \frac{1}{\eta} \left( \hat{a}_k \times \mathbf{E} \right)}$)** where $\mathbf{E} \perp \mathbf{H} \perp \hat{a}_k$ (the propagation wave vector).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Helmholtz Wave Equation ($\nabla^2 \mathbf{E} = \mu\epsilon \frac{\partial^2\mathbf{E}}{\partial t^2}$), Phase Velocity ($u_p = \frac{c}{\sqrt{\mu_r\epsilon_r}}$) & Impedance ($\eta = \sqrt{\frac{\mu}{\epsilon}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Wave Speed, Wavelength, and Magnetic Field Intensity Vector Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Electromagnetic Wave Entity / Propagation Constant & Technical Physical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Characteristic Ratio of Electric Field Intensity to Magnetic Field Intensity in Free Space Is the Intrinsic Impedance Equal to Approximately ___ Ohms (377 / 120pi) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High-Frequency Wave Electromagnetics Problem: Calculating the Phase Velocity and Intrinsic Impedance in Non-Magnetic Glass Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Plane EM Waves (Sadiku 2021; Ulaby 2020; Cheng 2014):
   - **Wave Equation & Velocity Formulations:**
     $$\mathbf{\nabla^2 \mathbf{E} - \mu\epsilon \frac{\partial^2 \mathbf{E}}{\partial t^2} = 0 \quad \Big| \quad u_p = \frac{1}{\sqrt{\mu\epsilon}} = \frac{c}{\sqrt{\mu_r \epsilon_r}} \quad \Big| \quad \lambda = \frac{u_p}{f} = \frac{2\pi}{\beta}}$$
   - **Intrinsic Impedance Formulations:**
     $$\mathbf{\eta = \sqrt{\frac{\mu}{\epsilon}} = \eta_0 \sqrt{\frac{\mu_r}{\epsilon_r}} \quad \Big| \quad \eta_0 = \sqrt{\frac{\mu_0}{\epsilon_0}} = 120\pi \approx 376.73\,\Omega \approx 377\,\Omega}$$
   - **TEM Orthogonality Invariant:**
     $$\mathbf{\mathbf{H} = \frac{1}{\eta} \left( \hat{a}_k \times \mathbf{E} \right) \quad \Longleftrightarrow \quad \mathbf{E} \perp \mathbf{H} \perp \hat{a}_k \quad (\text{Right-Hand Rule Trio!})}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of plane wave analysis: (1) determine medium parameters (permittivity $\epsilon = \epsilon_0 \epsilon_r$, permeability $\mu = \mu_0 \mu_r$, conductivity $\sigma = 0$), (2) calculate phase velocity $u_p = \frac{c}{\sqrt{\mu_r \epsilon_r}}$ and phase constant $\beta = \frac{\omega}{u_p} = \frac{2\pi}{\lambda}$, (3) calculate intrinsic wave impedance $\eta = \eta_0 \sqrt{\frac{\mu_r}{\epsilon_r}}$, (4) identify electric field phasor $\mathbf{E}(z) = E_0 e^{-j\beta z} \hat{a}_x$, (5) evaluate magnetic field phasor $\mathbf{H}(z) = \frac{1}{\eta}(\hat{a}_z \times \mathbf{E}) = \frac{E_0}{\eta} e^{-j\beta z} \hat{a}_y$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Phase Velocity $u_p = 1/\sqrt{\mu\epsilon}$, Intrinsic Impedance $\eta = \sqrt{\mu/\epsilon}$, Free Space Impedance $\eta_0 \approx 377\,\Omega$, Phase Constant $\beta = \omega\sqrt{\mu\epsilon}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 377 (or 120pi). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating wave velocity and impedance: A uniform plane electromagnetic wave propagates in a non-magnetic optical glass medium with relative permittivity $\epsilon_r = 4.0$ and relative permeability $\mu_r = 1.0$. What is the phase velocity $u_p$ of the wave and the intrinsic wave impedance $\eta$ of the glass medium? ($u_p = \frac{c}{\sqrt{\mu_r \epsilon_r}} = \frac{3.0 \times 10^8\text{ m/s}}{\sqrt{1.0 \times 4.0}} = \frac{3.0 \times 10^8}{2.0} = \mathbf{1.5 \times 10^8\text{ m/s}}$; $\eta = \frac{\eta_0}{\sqrt{\epsilon_r}} = \frac{120\pi}{\sqrt{4.0}} = \frac{376.99\,\Omega}{2} = 60\pi \approx \mathbf{188.5\,\Omega}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "plane_electromagnetic_waves_intrinsic_impedance_and_phase_velocity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Plane EM Waves, Intrinsic Impedance \\& Velocity (Heinrich Hertz 1888)**\n• **Homogeneous Vector Helmholtz Wave Equation:**\n$$\n\\mathbf{\\nabla^2 \\mathbf{E} - \\mu \\epsilon \\frac{\\partial^2 \\mathbf{E}}{\\partial t^2} = 0 \\quad \\Longleftrightarrow \\quad \\nabla^2 \\mathbf{H} - \\mu \\epsilon \\frac{\\partial^2 \\mathbf{H}}{\\partial t^2} = 0}\n$$\n• **Electromagnetic Phase Velocity Formulation:**\n$$\n\\mathbf{u_p = \\frac{1}{\\sqrt{\\mu \\epsilon}} = \\frac{c}{\\sqrt{\\mu_r \\epsilon_r}} \\quad \\left(c = 3.0 \\times 10^8\\text{ m/s}, \\ \\lambda = \\frac{u_p}{f}\\right)}\n$$\n• **Intrinsic Medium Wave Impedance Formulation:**\n$$\n\\mathbf{\\eta = \\frac{|\\mathbf{E}|}{|\\mathbf{H}|} = \\sqrt{\\frac{\\mu}{\\epsilon}} = \\eta_0 \\sqrt{\\frac{\\mu_r}{\\epsilon_r}} \\quad \\Big| \\quad \\mathbf{\\eta_0 = \\sqrt{\\frac{\\mu_0}{\\epsilon_0}} = 120\\pi \\approx 376.73\\,\\Omega \\approx 377\\,\\Omega}}\n$$\n• **The TEM Wave Orthogonality Invariant:** In a Transverse Electro-Magnetic (TEM) wave, the fields form a right-handed orthogonal triad: $\\mathbf{\\mathbf{H} = \\frac{1}{\\eta} (\\hat{a}_k \\times \\mathbf{E})} \\implies \\mathbf{E} \\perp \\mathbf{H} \\perp \\hat{a}_k$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the phase velocity, intrinsic impedance, and magnetic field vector of a propagating plane wave.",
      "orderItems": [
        "Record the medium constitutive parameters: relative permittivity eps_r, permeability mu_r, and wave frequency f",
        "Calculate the electromagnetic phase propagation velocity: u_p = c / sqrt(mu_r * eps_r)",
        "Compute the intrinsic wave impedance of the medium: eta = eta_0 * sqrt(mu_r / eps_r)",
        "Calculate the spatial phase constant (wavenumber): beta = omega / u_p = (2*pi*f) / u_p",
        "Apply the TEM cross-product rule H = (1 / eta) * (a_k x E) to determine the orthogonal magnetic field intensity vector"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Wave Electromagnetics Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Phase Velocity (up)", "right": "up = 1 / sqrt(\u03bc*\u03b5), the speed at which constant-phase wave fronts propagate through a medium" },
        { "left": "Intrinsic Impedance (\u03b7)", "right": "\u03b7 = sqrt(\u03bc / \u03b5), the characteristic ratio of transverse electric field to magnetic field strength" },
        { "left": "Free Space Impedance (\u03b70)", "right": "\u03b70 = 120\u03c0 \u2248 377 \u03a9, the universal characteristic wave impedance of the vacuum" },
        { "left": "Phase Constant (\u03b2)", "right": "\u03b2 = 2*\u03c0 / \u03bb, spatial phase shift per meter of wave travel along the propagation vector" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The characteristic ratio of electric field to magnetic field intensity in free space is the intrinsic impedance equal to ___ ohms.",
      "blankAnswer": "377",
      "blankDistractors": ["50", "75", "120"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A uniform plane electromagnetic wave propagates in non-magnetic optical glass (\u03b5r = 4.0, \u03bcr = 1.0). What is the phase velocity up of the wave and the intrinsic wave impedance \u03b7 of the glass medium?",
      "options": [
        { "text": "up = 1.50 * 10^8 m/s and \u03b7 = 188.5 \u03a9 (up = c / sqrt(4) = 3*10^8 / 2 = 1.5*10^8 m/s, and \u03b7 = 377 / sqrt(4) = 188.5 \u03a9 = 60\u03c0 \u03a9)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using uniform plane wave propagation equations (Matthew Sadiku *Elements of Electromagnetics* Chapter 10). 1. **Calculate Phase Velocity ($u_p$):** $$u_p = \\frac{c}{\\sqrt{\\mu_r \\epsilon_r}} = \\frac{3.0 \\times 10^8\\text{ m/s}}{\\sqrt{1.0 \\times 4.0}} = \\frac{3.0 \\times 10^8}{2.0} = \\mathbf{1.50 \\times 10^8\\text{ m/s}}$$ 2. **Calculate Intrinsic Medium Impedance ($\\eta$):** $$\\eta = \\sqrt{\\frac{\\mu}{\\epsilon}} = \\eta_0 \\sqrt{\\frac{\\mu_r}{\\epsilon_r}} = \\frac{120\\pi}{\\sqrt{4.0}} = \\frac{376.991\\,\\Omega}{2} = 60\\pi\\,\\Omega \\approx \\mathbf{188.50\\,\\Omega}$$ 3. **Refractive Index Verification:** - Refractive index $n = \\sqrt{\\epsilon_r} = \\sqrt{4} = 2.0$. - $u_p = \\frac{c}{n} = \\frac{3 \\times 10^8}{2.0} = 1.5 \\times 10^8\\text{ m/s}$. - $\\eta = \\frac{\\eta_0}{n} = \\frac{377}{2.0} = 188.5\\,\\Omega$. Flawless dielectric wave analysis!" },
        { "text": "up = 3.00 * 10^8 m/s and \u03b7 = 377.0 \u03a9 (Free space values)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "up = 0.75 * 10^8 m/s and \u03b7 = 94.2 \u03a9", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "up = 6.00 * 10^8 m/s and \u03b7 = 754.0 \u03a9", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
