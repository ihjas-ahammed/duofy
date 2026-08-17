# Duofy Reusable Lesson Format: Reactor Physics (One-Group Neutron Diffusion & Length L)

**Target Topic:** `04_Engineering_and_Technology / 09_Nuclear_and_Energy_Engineering / Nuclear_Reactor_Physics_and_Design / Neutron_Diffusion_and_Reactor_Kinetics`  
**Lesson Format Type:** `one_group_neutron_diffusion_and_diffusion_length`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the spatial transport and spatial diffusion of thermal neutrons in moderator and fuel media, **Fick's Law of Neutron Diffusion ($\vec{J} = -D \nabla \phi$)**, the **One-Group Steady-State Neutron Diffusion Equation ($D \nabla^2 \phi - \Sigma_a \phi + S = 0$)**, boundary conditions (zero flux at extrapolated boundary $\tilde{a} = a + d$ with extrapolation distance $d = 2.13 D = 0.71 \lambda_{\text{tr}}$), the physical derivation and calculation of the **Neutron Diffusion Length ($L = \sqrt{D / \Sigma_a}$)** representing the root-mean-square displacement of a thermal neutron from birth to absorption, and the transport mean free path ($\lambda_{\text{tr}}$) (John R. Lamarsh, Anthony J. Baratta *Introduction to Nuclear Engineering* 4th ed. Chapter 5; James J. Duderstadt, Louis J. Hamilton *Nuclear Reactor Analysis* Chapter 5; Elmer E. Lewis *Fundamentals of Nuclear Reactor Physics* Chapter 4): formulate the **One-Group Steady-State Neutron Diffusion Master Formulation**:
$$\mathbf{D \nabla^2 \phi(\vec{r}) - \Sigma_a \phi(\vec{r}) + S(\vec{r}) = 0 \Longleftrightarrow \mathbf{\nabla^2 \phi(\vec{r}) - \frac{1}{L^2} \phi(\vec{r}) + \frac{S(\vec{r})}{D} = 0}}$$
where:
1. **$\phi(\vec{r})$:** Scalar thermal neutron flux ($\text{neutrons}/\text{cm}^2\cdot\text{s}$);
2. **$\vec{J}(\vec{r}) = -D \nabla \phi(\vec{r})$:** Net neutron current density vector ($\text{neutrons}/\text{cm}^2\cdot\text{s}$);
3. **$D$:** Diffusion coefficient in centimeters ($D = \frac{1}{3 \Sigma_{\text{tr}}} = \frac{\lambda_{\text{tr}}}{3}$);
4. **$\Sigma_a$:** Macroscopic thermal absorption cross-section ($\text{cm}^{-1}$);
5. **$S(\vec{r})$:** Independent or fission volumetric neutron source rate ($\text{neutrons}/\text{cm}^3\cdot\text{s}$);
derive the **Neutron Diffusion Length ($L$)**:
$$\mathbf{L = \sqrt{\frac{D}{\Sigma_a}} \quad [\text{centimeters}] \quad \Big| \quad \bar{r}^2 = 6 L^2}$$
master the **Standard Moderator Neutronic Properties Matrix**:
$$\begin{array}{|l|c|c|c|c|l|}
\hline
\textbf{Moderator Material} & \textbf{Diffusion Coeff } D & \textbf{Abs Cross-Sect } \Sigma_a & \textbf{Diffusion Length } L & \textbf{Moderating Ratio } \xi\Sigma_s / \Sigma_a & \textbf{Core Design Role} \\
\hline
\mathbf{\text{Light Water (H}_2\text{O)}} & \mathbf{0.16\text{ cm}} & \mathbf{0.022\text{ cm}^{-1}} & \mathbf{2.85\text{ cm}} & \mathbf{67} & \mathbf{\text{Compact PWR / BWR core; high slowing-down}} \\
\mathbf{\text{Heavy Water (D}_2\text{O)}} & \mathbf{0.87\text{ cm}} & \mathbf{0.000033\text{ cm}^{-1}} & \mathbf{171.0\text{ cm}} & \mathbf{5,820} & \mathbf{\text{CANDU reactors (natural uranium fuel)}} \\
\mathbf{\text{Graphite (C)}} & \mathbf{0.84\text{ cm}} & \mathbf{0.00038\text{ cm}^{-1}} & \mathbf{54.0\text{ cm}} & \mathbf{192} & \mathbf{\text{HTGR gas-cooled cores, RBMK}} \\
\text{Beryllium (Be)} & 0.50\text{ cm} & 0.0012\text{ cm}^{-1} & 21.0\text{ cm} & 143 & Space reactors and research cores \\
\hline
\end{array}$$
(proving that light water has an ultra-short diffusion length $L \approx 2.85\text{ cm}$ enabling compact commercial reactor pressure vessels, whereas heavy water's ultra-low absorption cross-section yields $L \approx 171\text{ cm}$ permitting unenriched natural uranium criticality).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fick's Law ($\vec{J} = -D\nabla\phi$), Steady-State Diffusion ($D\nabla^2\phi - \Sigma_a\phi + S = 0$) & Length ($L = \sqrt{D/\Sigma_a}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Diffusion Coefficient D, Macroscopic Cross-Section, and Diffusion Length L Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Neutron Transport / Diffusion Parameter & Technical Nuclear Physics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Nuclear Reactor Physics, the Characteristic Distance a Thermal Neutron Travels from Its Point of Thermalization to the Point of Absorption Is Defined as the Neutron Diffusion ___ $L = \sqrt{D / \Sigma_a}$ (Length / Diffusion Length) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Reactor Physics Calculation: Computing Diffusion Length L for a Light Water Moderator Medium Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Neutron Diffusion & Fick's Law Mechanics (Lamarsh 2018; Duderstadt 1976):
   - **Diffusion Formulations:**
     $$\mathbf{\vec{J} = -D \nabla \phi \quad \Big| \quad D \nabla^2 \phi - \Sigma_a \phi + S = 0 \quad \Big| \quad L = \sqrt{\frac{D}{\Sigma_a}} \quad \Big| \quad \tilde{a} = a + 0.71 \lambda_{\text{tr}}}$$
   - **The Fick's Law Validity Invariants:**
     - Medium must be weakly absorbing ($\Sigma_a \ll \Sigma_s$);
     - Flux must not vary rapidly over a mean free path ($|\nabla\phi / \phi| \ll 1/\lambda$);
     - Fick's law fails within $\sim 2\lambda$ of core boundaries and localized strong absorber control rods!
2. **Slide 2 (`ordering`):** Provide 5 steps of neutron diffusion analysis: (1) extract macroscopic scattering cross-section $\Sigma_s$, absorption cross-section $\Sigma_a$, and average cosine of scattering angle $\bar{\mu}_0$, (2) calculate transport cross-section $\Sigma_{\text{tr}} = \Sigma_s (1 - \bar{\mu}_0)$, (3) evaluate the neutron diffusion coefficient: $D = 1 / (3 \Sigma_{\text{tr}})$, (4) evaluate the square of the diffusion length: $L^2 = D / \Sigma_a$, (5) take the square root to determine the physical neutron diffusion length: $L = \sqrt{D / \Sigma_a}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Fick's Law of Diffusion, Diffusion Length $L$, Neutron Flux $\phi$, Extrapolated Boundary $\tilde{a}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Length (or Diffusion Length). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $L$ for a light water moderator: A room-temperature light water ($\text{H}_2\text{O}$) moderator has diffusion coefficient $D = 0.160\text{ cm}$ and macroscopic thermal absorption cross-section $\Sigma_a = 0.0220\text{ cm}^{-1}$.
   - $L^2 = \frac{D}{\Sigma_a} = \frac{0.160\text{ cm}}{0.0220\text{ cm}^{-1}} = \mathbf{7.2727\text{ cm}^2}$;
   - Diffusion length: $L = \sqrt{7.2727\text{ cm}^2} = \mathbf{2.6968\text{ cm} \approx 2.70\text{ cm}}$;
   - What is the thermal neutron diffusion length $L$ in this water medium? ($L = \mathbf{2.70\text{ cm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "one_group_neutron_diffusion_and_diffusion_length",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: One-Group Neutron Diffusion \\& Length L (John R. Lamarsh)**\n• **One-Group Steady-State Diffusion Master Formulation:**\n$$\n\\mathbf{D \\nabla^2 \\phi(\\vec{r}) - \\Sigma_a \\phi(\\vec{r}) + S(\\vec{r}) = 0 \\Longleftrightarrow \\nabla^2 \\phi(\\vec{r}) - \\frac{1}{L^2} \\phi(\\vec{r}) + \\frac{S(\\vec{r})}{D} = 0}\n$$\n  - **$\\phi(\\vec{r})$:** Thermal neutron flux ($n/\\text{cm}^2\\cdot\\text{s}$);\n  - **$\\vec{J} = -D \\nabla \\phi$:** Net neutron current vector (Fick's Law of Diffusion);\n  - **$D = \\frac{1}{3 \\Sigma_{\\text{tr}}}$:** Diffusion coefficient ($\\text{cm}$);\n• **Neutron Diffusion Length Formulation ($L$):**\n$$\n\\mathbf{L = \\sqrt{\\frac{D}{\\Sigma_a}} \\quad [\\text{centimeters}] \\quad \\Big| \\quad \\bar{r}^2 = 6 L^2}\n$$\n  - **Physical Meaning:** $L$ represents the root-mean-square displacement a thermal neutron travels from thermal birth to absorption;\n• **The Moderator Length Contrast:** In light water ($\\text{H}_2\\text{O}$), $L \\approx 2.85\\text{ cm}$ creating compact cores, whereas in heavy water ($\\text{D}_2\\text{O}$), ultra-low absorption yields $L \\approx 171\\text{ cm}$, requiring large CANDU calandria tanks!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the transport cross-section, diffusion coefficient D, and thermal diffusion length L of a nuclear reactor moderator.",
      "orderItems": [
        "Extract the macroscopic scattering cross-section \u03a3s, absorption cross-section \u03a3a, and average scattering cosine \u03bc\u03040",
        "Calculate the transport cross-section: \u03a3tr = \u03a3s * (1 - \u03bc\u03040)",
        "Compute the thermal neutron diffusion coefficient: D = 1 / (3 * \u03a3tr)",
        "Calculate the square of the thermal diffusion length: L^2 = D / \u03a3a",
        "Take the square root to obtain the physical thermal neutron diffusion length: L = \u221a(D / \u03a3a)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Neutron Diffusion Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Fick's Law of Diffusion", "right": "J\u2192 = -D*\u2207\u03c6, net neutron leakage current flowing down the spatial flux gradient" },
        { "left": "Thermal Diffusion Length (L)", "right": "L = \u221a(D/\u03a3a), mean spatial displacement a thermal neutron migrates prior to capture" },
        { "left": "Transport Cross-Section (\u03a3tr)", "right": "\u03a3tr = \u03a3s*(1 - \u03bc\u03040), scattering cross-section corrected for forward anisotropic angular deflection" },
        { "left": "Extrapolated Core Boundary (a\u0303)", "right": "Virtual boundary at distance d = 0.71*\u03bbtr beyond physical surface where flux linearly extrapolates to zero" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In nuclear reactor physics, the characteristic distance a thermal neutron travels from its point of thermalization to the point of absorption is defined as the neutron diffusion ___ L = \u221a(D / \u03a3a).",
      "blankAnswer": "length",
      "blankDistractors": ["time", "flux", "energy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A light water (H2O) reactor moderator has diffusion coefficient D = 0.160 cm and macroscopic absorption cross-section \u03a3a = 0.0220 cm^-1. L^2 = 0.160 / 0.0220 = 7.2727 cm^2. L = \u221a(7.2727) = 2.6968 cm. What is the thermal neutron diffusion length L in this water medium?",
      "options": [
        { "text": "L = 2.70 cm (L = \u221a(D / \u03a3a) = \u221a(0.160 cm / 0.0220 cm^-1) = \u221a(7.2727 cm^2) = 2.697 cm \u2248 2.70 cm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the thermal neutron diffusion length equation (John R. Lamarsh & Anthony J. Baratta *Introduction to Nuclear Engineering* Chapter 5; James J. Duderstadt *Nuclear Reactor Analysis* Chapter 5). 1. **Identify Neutronic Medium Parameters:** - Diffusion coefficient: $D = 0.160\\text{ cm}$. - Macroscopic thermal absorption cross-section: $\\Sigma_a = 0.0220\\text{ cm}^{-1}$. 2. **Calculate Diffusion Area ($L^2$):** $$L^2 = \\frac{D}{\\Sigma_a} = \\frac{0.160\\text{ cm}}{0.0220\\text{ cm}^{-1}} = \\mathbf{7.272727\\text{ cm}^2}$$ 3. **Calculate Thermal Diffusion Length ($L$):** $$L = \\sqrt{L^2} = \\sqrt{7.272727\\text{ cm}^2} = \\mathbf{2.69680\\text{ cm} \\approx 2.70\\text{ cm}}$$ - Notice that this short migration distance ($L \\approx 2.70\\text{ cm}$) allows Light Water Reactors (PWRs) to be constructed with high power density in compact reactor pressure vessels! Flawless neutron diffusion length derivation!" },
        { "text": "L = 7.27 cm (Calculated L^2 without taking the square root)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L = 0.137 cm (Inverted ratio: \u221a(\u03a3a / D))", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L = 27.0 cm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
