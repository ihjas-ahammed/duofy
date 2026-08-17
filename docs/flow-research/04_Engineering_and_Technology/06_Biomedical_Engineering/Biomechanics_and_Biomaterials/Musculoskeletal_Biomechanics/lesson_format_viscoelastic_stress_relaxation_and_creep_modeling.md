# Duofy Reusable Lesson Format: Tissue Viscoelasticity (Stress Relaxation & Creep Models)

**Target Topic:** `04_Engineering_and_Technology / 06_Biomedical_Engineering / Biomechanics_and_Biomaterials / Musculoskeletal_Biomechanics`  
**Lesson Format Type:** `viscoelastic_stress_relaxation_and_creep_modeling`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the time-dependent mechanical behavior of soft biological connective tissues (tendons, ligaments, articular cartilage, intervertebral discs), the linear spring (Hookean elasticity $\sigma = E \epsilon$) and dashpot (Newtonian viscosity $\sigma = \eta \dot{\epsilon}$), the **Maxwell Model** (spring and dashpot in series), the **Kelvin-Voigt Model** (spring and dashpot in parallel), the **Standard Linear Solid (SLS / Zener Model)** combining an isolated spring $E_1$ with a Maxwell arm ($E_2, \eta$), the analytical formulation of **Stress Relaxation ($\sigma(t)$ under constant strain $\epsilon_0$)**, and **Creep ($\epsilon(t)$ under constant stress $\sigma_0$)** (C. Ross Ethier, Craig A. Simmons *Introductory Biomechanics* 2nd ed. Chapter 8; Y. C. Fung *Biomechanics: Mechanical Properties of Living Tissues* Chapter 7): formulate the **Standard Linear Solid (SLS) Stress Relaxation Master Formulation**:
$$\mathbf{\sigma(t) = \sigma_\infty + \left( \sigma_0 - \sigma_\infty \right) \exp\left( -\frac{t}{\tau_R} \right) \quad [\text{MPa}]}$$
where:
1. **$\sigma_0 = (E_1 + E_2) \cdot \epsilon_0$:** Instantaneous initial peak stress at $t = 0$;
2. **$\sigma_\infty = E_1 \cdot \epsilon_0$:** Long-term equilibrium residual stress as $t \to \infty$;
3. **$\tau_R = \frac{\eta}{E_2}$:** Viscoelastic relaxation time constant (in seconds or minutes);
formulate the **Kelvin-Voigt Creep Master Equation**:
$$\mathbf{\epsilon(t) = \frac{\sigma_0}{E} \left[ 1 - \exp\left( -\frac{t}{\tau_C} \right) \right] \quad \left(\tau_C = \frac{\eta}{E} = \text{Retardation / Creep Time Constant}\right)}$$
master the **Biological Viscoelastic Triad**:
$$\begin{array}{|l|l|l|}
\hline
\textbf{Viscoelastic Phenomenon} & \textbf{Testing Condition} & \textbf{Physiological Function in Human Body} \\
\hline
\mathbf{\text{Stress Relaxation}} & \mathbf{\text{Constant Strain }} \epsilon(t) = \epsilon_0 & \mathbf{\text{Relieves dangerous peak stress during sustained joint flexion}} \\
\mathbf{\text{Creep Deformation}} & \mathbf{\text{Constant Stress }} \sigma(t) = \sigma_0 & \mathbf{\text{Gradual cartilage thinning under prolonged standing/weightbearing}} \\
\mathbf{\text{Hysteresis Loop}} & \text{Cyclic Loading / Unloading} & \text{Dissipates mechanical shock energy as thermal damping} \\
\hline
\end{array}$$
(proving why cartilage and tendons protect underlying subchondral bone by dampening impact shocks through fluid exudation and viscous strain energy dissipation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SLS Stress Relaxation ($\sigma(t) = \sigma_\infty + (\sigma_0-\sigma_\infty)e^{-t/\tau_R}$) & Kelvin-Voigt Creep ($\epsilon(t) = \frac{\sigma_0}{E}[1-e^{-t/\tau_C}]$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Peak Stress, Relaxation Time Constant, and Equilibrium Residual Stress Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Viscoelastic Entity / Mechanical Model & Technical Biomechanical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Progressive Increase in Strain Over Time Exhibited by Articular Cartilage Under a Constant Sustained Compressive Load Is Known as Viscoelastic ___ (Creep / Creep Strain) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Tissue Mechanics Problem: Calculating Stress Relaxation Profile for a Human Patellar Tendon Autograft Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Tissue Viscoelastic Mechanics (Ethier & Simmons 2016; Fung 1993):
   - **Viscoelastic Formulations:**
     $$\mathbf{\sigma(t) = \sigma_\infty + (\sigma_0 - \sigma_\infty) e^{-t/\tau_R} \quad \Big| \quad \epsilon(t) = \frac{\sigma_0}{E}[1 - e^{-t/\tau_C}] \quad \Big| \quad \tau_R = \frac{\eta}{E_2} \quad \Big| \quad \sigma_0 = (E_1+E_2)\epsilon_0}$$
   - **Viscoelastic Models Comparison Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Viscoelastic Model} & \textbf{Components} & \textbf{Instantaneous Elasticity} & \textbf{Steady-State Solid} & \textbf{Biomechanical Accuracy} \\
     \hline
     \text{Maxwell Model} & \text{Spring + Dashpot in Series} & \text{Yes } (\sigma_0 = E\epsilon_0) & \text{No (Relaxes to zero)} & \text{Models fluids/mucus} \\
     \text{Kelvin-Voigt Model} & \text{Spring + Dashpot in Parallel} & \text{No (Infinite viscous drag)} & \text{Yes } (\epsilon_\infty = \sigma_0/E) & \text{Models creep behavior} \\
     \mathbf{\text{Standard Linear Solid (SLS)}} & \mathbf{\text{Spring } E_1 \parallel \text{ (Spring } E_2 + \text{Dashpot } \eta\text{)}} & \mathbf{\text{Yes } (\sigma_0 = [E_1+E_2]\epsilon_0)} & \mathbf{\text{Yes } (\sigma_\infty = E_1\epsilon_0)} & \mathbf{\text{Full tendon, ligament, cartilage}} \\
     \hline
     \end{array}$$
   - **The Asymptotic Plateau Invariant:** In living solid tissues modeled by SLS, **stress relaxes to a non-zero solid equilibrium plateau $\sigma_\infty = E_1 \epsilon_0$**; the parallel spring $E_1$ prevents the tissue from completely melting away into a fluid!
2. **Slide 2 (`ordering`):** Provide 5 steps of SLS stress relaxation analysis: (1) determine spring moduli $E_1, E_2$, dashpot viscosity $\eta$, and applied step strain $\epsilon_0$, (2) calculate instantaneous peak stress at $t = 0$: $\sigma_0 = (E_1 + E_2) \cdot \epsilon_0$, (3) calculate long-term equilibrium residual stress: $\sigma_\infty = E_1 \cdot \epsilon_0$, (4) compute relaxation time constant: $\tau_R = \eta / E_2$, (5) formulate continuous relaxation curve: $\sigma(t) = \sigma_\infty + (\sigma_0 - \sigma_\infty) e^{-t/\tau_R}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Stress Relaxation, Creep Deformation, Standard Linear Solid SLS, Time Constant $\tau_R$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Creep (or Creep Strain). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating stress relaxation in a tendon: A patellar tendon autograft ($E_1 = 300.0\text{ MPa}, E_2 = 700.0\text{ MPa}, \eta = 14,000.0\text{ MPa}\cdot\text{s}$) is subjected to a sudden constant tensile step strain of $\epsilon_0 = 5.0\% = 0.050$.
   - Instantaneous initial peak stress ($t = 0$):
     $\sigma_0 = (E_1 + E_2) \cdot \epsilon_0 = (300.0 + 700.0\text{ MPa}) \times 0.050 = 1000.0\text{ MPa} \times 0.050 = \mathbf{50.0\text{ MPa}}$;
   - Long-term equilibrium stress ($t \to \infty$):
     $\sigma_\infty = E_1 \cdot \epsilon_0 = 300.0\text{ MPa} \times 0.050 = \mathbf{15.0\text{ MPa}}$;
   - Relaxation time constant:
     $\tau_R = \frac{\eta}{E_2} = \frac{14,000.0\text{ MPa}\cdot\text{s}}{700.0\text{ MPa}} = \mathbf{20.0\text{ seconds}}$;
   - At time $t = 20.0\text{ s}$ ($t = \tau_R \implies e^{-1} \approx 0.3679$):
     $\sigma(20) = \sigma_\infty + (\sigma_0 - \sigma_\infty) e^{-1} = 15.0 + (50.0 - 15.0) \times 0.3679 = 15.0 + (35.0 \times 0.3679) = 15.0 + 12.88 = \mathbf{27.88\text{ MPa} \approx 27.9\text{ MPa}}$;
   - What are the initial peak stress $\sigma_0$ and the stress $\sigma(20\text{s})$ after 20 seconds? ($\sigma_0 = \mathbf{50.0\text{ MPa}}$ and $\sigma(20\text{s}) = \mathbf{27.9\text{ MPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "viscoelastic_stress_relaxation_and_creep_modeling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Tissue Viscoelasticity \\& SLS Modeling (Y. C. Fung \\& Ethier)**\n• **Standard Linear Solid (SLS) Stress Relaxation Master Formulation:**\n$$\n\\mathbf{\\sigma(t) = \\sigma_\\infty + \\left( \\sigma_0 - \\sigma_\\infty \\right) \\exp\\left( -\\frac{t}{\\tau_R} \\right) \\quad [\\text{MPa}]}\n$$\n  - **$\\sigma_0 = (E_1 + E_2) \\cdot \\epsilon_0$:** Instantaneous initial elastic peak stress at $t = 0$;\n  - **$\\sigma_\\infty = E_1 \\cdot \\epsilon_0$:** Long-term equilibrium residual stress as $t \\to \\infty$;\n  - **$\\tau_R = \\frac{\\eta}{E_2}$:** Viscoelastic relaxation time constant ($\\text{seconds}$);\n• **Kelvin-Voigt Creep Formulation (Constant Stress $\\sigma_0$):**\n$$\n\\mathbf{\\epsilon(t) = \\frac{\\sigma_0}{E} \\left[ 1 - \\exp\\left( -\\frac{t}{\\tau_C} \\right) \\right] \\quad \\left(\\tau_C = \\frac{\\eta}{E}\\right)}\n$$\n• **The Solid Plateau Invariant:** In living tissues modeled by SLS, **stress relaxes to a non-zero solid equilibrium plateau $\\sigma_\\infty = E_1 \\epsilon_0$**; the parallel spring $E_1$ ensures permanent structural integrity without fluid dissipation to zero!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the time-dependent stress relaxation response of a ligament using the Standard Linear Solid model.",
      "orderItems": [
        "Extract the model parameters: equilibrium spring modulus E1, Maxwell spring modulus E2, and dashpot viscosity \u03b7",
        "Calculate the instantaneous peak stress immediately following a step strain \u03b50: \u03c30 = (E1 + E2) * \u03b50",
        "Calculate the long-term equilibrium residual stress supported by the elastic matrix: \u03c3_\u221e = E1 * \u03b50",
        "Calculate the viscoelastic relaxation time constant: \u03c4R = \u03b7 / E2",
        "Formulate the continuous stress relaxation decay equation: \u03c3(t) = \u03c3_\u221e + (\u03c30 - \u03c3_\u221e) * exp(-t / \u03c4R)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Viscoelastic Tissue Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Stress Relaxation", "right": "\u03c3(t) decay under constant strain \u03b50, relieving dangerous mechanical stresses over time in held postures" },
        { "left": "Creep Deformation", "right": "\u03b5(t) progressive strain increase under constant sustained stress \u03c00 (e.g. cartilage thinning under standing)" },
        { "left": "Standard Linear Solid (SLS)", "right": "Three-parameter model combining E1 in parallel with (E2 + \u03b7) to capture both instantaneous and equilibrium elasticity" },
        { "left": "Relaxation Time Constant (\u03c4R)", "right": "\u03c4R = \u03b7 / E2, characteristic time duration required for transient stress to decay by (1 - 1/e) \u2248 63.2%" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The progressive increase in strain over time exhibited by articular cartilage under a constant sustained compressive load is known as viscoelastic ___.",
      "blankAnswer": "creep",
      "blankDistractors": ["relaxation", "fatigue", "fracture"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A patellar tendon autograft (E1 = 300.0 MPa, E2 = 700.0 MPa, \u03b7 = 14,000.0 MPa*s) is pulled to a constant step strain \u03b50 = 5.0% = 0.050. \u03c30 = (300+700)*0.05 = 50.0 MPa, \u03c3_\u221e = 300*0.05 = 15.0 MPa, and \u03c4R = 14,000 / 700 = 20.0 s. At t = 20.0 s (e^-1 = 0.3679), \u03c3(20) = 15.0 + (50.0 - 15.0) * 0.3679 = 15.0 + 12.88 = 27.88 MPa. What are the initial peak stress \u03c30 and the stress \u03c3(20s) after 20 seconds?",
      "options": [
        { "text": "\u03c30 = 50.0 MPa and \u03c3(20s) = 27.9 MPa (\u03c30 = 1000 * 0.05 = 50.0 MPa; \u03c3(20s) = 15.0 + 35.0 * 0.36788 = 27.88 MPa \u2248 27.9 MPa)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Standard Linear Solid (SLS) stress relaxation equation (C. Ross Ethier & Craig A. Simmons *Introductory Biomechanics* Chapter 8; Y. C. Fung *Biomechanics* Chapter 7). 1. **Identify SLS Model Parameters \\& Input Strain:** - Equilibrium spring modulus: $E_1 = 300.0\\text{ MPa}$. - Maxwell arm spring modulus: $E_2 = 700.0\\text{ MPa}$. - Dashpot dynamic viscosity: $\\eta = 14,000.0\\text{ MPa}\\cdot\\text{s}$. - Constant applied step strain: $\\epsilon_0 = 5.0\\% = \\mathbf{0.050}$. 2. **Calculate Instantaneous Initial Peak Stress ($\\sigma_0$ at $t = 0$):** - At $t = 0$, the dashpot has zero time to move, acting as a rigid link: $$\\sigma_0 = (E_1 + E_2) \\cdot \\epsilon_0 = (300.0\\text{ MPa} + 700.0\\text{ MPa}) \\times 0.050$$ $$\\sigma_0 = 1000.0\\text{ MPa} \\times 0.050 = \\mathbf{50.0\\text{ MPa}}$$ 3. **Calculate Long-Term Equilibrium Stress ($\\sigma_\\infty$ as $t \\to \\infty$):** - As $t \\to \\infty$, the dashpot completely dissipates tension in the $E_2$ branch: $$\\sigma_\\infty = E_1 \\cdot \\epsilon_0 = 300.0\\text{ MPa} \\times 0.050 = \\mathbf{15.0\\text{ MPa}}$$ 4. **Calculate Viscoelastic Relaxation Time Constant ($\\tau_R$):** $$\\tau_R = \\frac{\\eta}{E_2} = \\frac{14,000.0\\text{ MPa}\\cdot\\text{s}}{700.0\\text{ MPa}} = \\mathbf{20.0\\text{ seconds}}$$ 5. **Calculate Stress at $t = 20.0\\text{ s}$ ($t = \\tau_R$):** $$\\sigma(20) = \\sigma_\\infty + (\\sigma_0 - \\sigma_\\infty) \\cdot e^{-20.0 / 20.0}$$ $$\\sigma(20) = 15.0\\text{ MPa} + (50.0 - 15.0\\text{ MPa}) \\cdot e^{-1}$$ $$\\sigma(20) = 15.0 + 35.0 \\times 0.367879 = 15.0 + 12.8758 = \\mathbf{27.876\\text{ MPa} \\approx 27.9\\text{ MPa}}$$ Flawless Standard Linear Solid viscoelastic stress relaxation derivation!" },
        { "text": "\u03c30 = 35.0 MPa and \u03c3(20s) = 15.0 MPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c30 = 50.0 MPa and \u03c3(20s) = 15.0 MPa (Assumed infinite time relaxation)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c30 = 100.0 MPa and \u03c3(20s) = 55.8 MPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
