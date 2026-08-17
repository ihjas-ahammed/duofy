# Duofy Reusable Lesson Format: Composites (Rule of Mixtures & Voigt/Reuss Bounds)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Ceramics_Polymers_and_Composites / Structure_and_Properties_of_Polymers`  
**Lesson Format Type:** `fiber_composite_rule_of_mixtures_voigt_reuss_modulus`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through continuous aligned fiber-reinforced polymer matrix composites (CFRP, GFRP), the mechanical micromechanics of two-phase composite laminae, the **Voigt Iso-Strain Model** for longitudinal tensile loading parallel to fibers ($\epsilon_c = \epsilon_f = \epsilon_m$), the **Reuss Iso-Stress Model** for transverse loading perpendicular to fibers ($\sigma_c = \sigma_f = \sigma_m$), calculation of longitudinal elastic modulus ($E_{11} = E_f V_f + E_m V_m$), transverse modulus ($E_{22} = \frac{E_f E_m}{E_m V_f + E_f V_m}$), fiber volume fraction ($V_f$), and fiber load sharing ratio ($F_f / F_{\text{total}}$) (William D. Callister Jr., David G. Rethwisch *Materials Science and Engineering: An Introduction* 10th ed. Chapter 16; Robert M. Jones *Mechanics of Composite Materials* 2nd ed. Chapter 3; Woldemar Voigt 1889; Andreas Reuss 1929): formulate the **Voigt Longitudinal Iso-Strain Upper Bound Formulation**:
$$\mathbf{E_{\text{longitudinal}} = E_{11} = E_f V_f + E_m V_m = E_f V_f + E_m \left( 1 - V_f \right) \quad [\text{GPa}]}$$
where:
1. **$E_f, E_m$:** Elastic moduli of the reinforcing fiber (e.g. Carbon $E_f \approx 230\text{ GPa}$) and polymer matrix (e.g. Epoxy $E_m \approx 3.5\text{ GPa}$);
2. **$V_f, V_m$:** Fiber and matrix volume fractions ($V_f + V_m = 1.00$);
derive the **Reuss Transverse Iso-Stress Lower Bound Formulation**:
$$\mathbf{\frac{1}{E_{\text{transverse}}} = \frac{1}{E_{22}} = \frac{V_f}{E_f} + \frac{V_m}{E_m} \Longleftrightarrow \mathbf{E_{22} = \frac{E_f E_m}{E_m V_f + E_f \left( 1 - V_f \right)} \quad [\text{GPa}]}}$$
derive the **Longitudinal Fiber Load Sharing Ratio ($\frac{F_f}{F_{\text{total}}}$)**:
$$\mathbf{\frac{F_f}{F_{\text{total}}} = \frac{E_f V_f}{E_f V_f + E_m V_m} = \frac{E_f V_f}{E_{11}} \quad \left(\text{Typically } > 95\% \text{ carried by fibers!}\right)}$$
(proving that continuous aligned fibers in parallel provide immense axial stiffness and carry nearly all external loads, while transverse stiffness is severely limited by the compliant polymer matrix).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Voigt Iso-Strain ($E_{11} = E_f V_f + E_m V_m$), Reuss Iso-Stress ($E_{22} = \frac{E_f E_m}{E_m V_f + E_f V_m}$) & Load Split Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Longitudinal Modulus, Transverse Modulus, and Fiber Load Fraction for a CFRP Lamina Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Composite Micromechanics Construct / Loading Mode & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Under Longitudinal Tensile Loading Parallel to Continuous Aligned Fibers, Both the Fiber and Matrix Undergo the Exact Same Strain, Defining the Iso-___ Condition of the Voigt Model (Strain / Iso-Strain) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Aerospace Composite Problem: Computing Longitudinal and Transverse Moduli for Carbon-Fiber Reinforced Polymer (CFRP) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Composite Micromechanics (Callister 2020; Jones 1999):
   - **Rule of Mixtures Formulations:**
     $$\mathbf{E_{11} = E_f V_f + E_m (1-V_f) \quad \Big| \quad E_{22} = \frac{E_f E_m}{E_m V_f + E_f (1-V_f)} \quad \Big| \quad \frac{F_f}{F_{\text{total}}} = \frac{E_f V_f}{E_{11}}}$$
   - **Composite Mechanical Anisotropy Matrix ($V_f = 60\%$ Carbon in Epoxy):**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Loading Direction} & \textbf{Micromechanical Model} & \textbf{Effective Modulus } E_c & \textbf{Physical Load Distribution} \\
     \hline
     \mathbf{\text{Longitudinal } (0^\circ)} & \mathbf{\text{Voigt (Iso-Strain: } \epsilon_f = \epsilon_m\text{)}} & \mathbf{E_{11} \approx 139.4\text{ GPa}} & \mathbf{\text{Fibers carry } 99.0\% \text{ of total axial load}} \\
     \mathbf{\text{Transverse } (90^\circ)} & \mathbf{\text{Reuss (Iso-Stress: } \sigma_f = \sigma_m\text{)}} & \mathbf{E_{22} \approx 8.6\text{ GPa}} & \mathbf{\text{Matrix dominates; high transverse strain}} \\
     \text{In-Plane Shear } (12) & \text{Iso-Stress Shear} & G_{12} \approx 4.5\text{ GPa} & Matrix resin controls shear deformation \\
     \hline
     \end{array}$$
   - **The Modulus Ratio Invariant:** In high-performance CFRP, the longitudinal modulus $E_{11}$ is **over $16\times$ stiffer than the transverse modulus $E_{22}$**; laminating plies at multidirectional angles ($[0/\pm 45/90]_s$) is required to create quasi-isotropic aerospace structures!
2. **Slide 2 (`ordering`):** Provide 5 steps of composite micromechanics calculation: (1) determine constituent properties: fiber modulus $E_f$, matrix modulus $E_m$, and fiber volume fraction $V_f$, (2) calculate matrix volume fraction: $V_m = 1 - V_f$, (3) calculate Voigt longitudinal upper bound modulus: $E_{11} = E_f V_f + E_m V_m$, (4) calculate Reuss transverse lower bound modulus: $E_{22} = (E_f E_m) / (E_m V_f + E_f V_m)$, (5) determine the fraction of total longitudinal tensile force carried by the fibers: $F_f / F_{\text{total}} = (E_f V_f) / E_{11}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Voigt Iso-Strain $E_{11}$, Reuss Iso-Stress $E_{22}$, Fiber Volume Fraction $V_f$, Fiber Load Fraction $F_f/F$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Strain (or Iso-Strain). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $E_{11}, E_{22}$, and load split for a carbon-fiber reinforced epoxy composite: A continuous aligned carbon-fiber composite has $E_f = 240.0\text{ GPa}$, epoxy matrix modulus $E_m = 4.0\text{ GPa}$, and fiber volume fraction $V_f = 60.0\% = 0.600$ ($V_m = 1 - 0.600 = \mathbf{0.400}$).
   - Longitudinal modulus ($E_{11}$):
     $E_{11} = E_f V_f + E_m V_m = (240.0 \times 0.600) + (4.0 \times 0.400) = 144.0 + 1.6 = \mathbf{145.6\text{ GPa}}$;
   - Transverse modulus ($E_{22}$):
     $E_{22} = \frac{E_f E_m}{E_m V_f + E_f V_m} = \frac{240.0 \times 4.0}{(4.0 \times 0.600) + (240.0 \times 0.400)} = \frac{960.0}{2.4 + 96.0} = \frac{960.0}{98.4} = \mathbf{9.756\text{ GPa} \approx 9.76\text{ GPa}}$;
   - Fiber load fraction:
     $\frac{F_f}{F_{\text{total}}} = \frac{E_f V_f}{E_{11}} = \frac{144.0}{145.6} = \mathbf{0.9890 = 98.90\% \approx 98.9\%}$;
   - What are the longitudinal modulus $E_{11}$ and transverse modulus $E_{22}$? ($E_{11} = \mathbf{145.6\text{ GPa}}$ and $E_{22} = \mathbf{9.76\text{ GPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fiber_composite_rule_of_mixtures_voigt_reuss_modulus",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Composite Rule of Mixtures \\& Voigt/Reuss Bounds (William D. Callister Jr.)**\n• **Voigt Longitudinal Iso-Strain Upper Bound Formulation ($E_{11}$):**\n$$\n\\mathbf{E_{11} = E_f V_f + E_m V_m = E_f V_f + E_m (1 - V_f) \\quad [\\text{GPa}]}\n$$\n  - **Assumption:** Both fiber and matrix undergo identical axial strain ($\\epsilon_c = \\epsilon_f = \\epsilon_m$);\n• **Reuss Transverse Iso-Stress Lower Bound Formulation ($E_{22}$):**\n$$\n\\mathbf{E_{22} = \\frac{E_f E_m}{E_m V_f + E_f V_m} = \\frac{E_f E_m}{E_m V_f + E_f (1 - V_f)} \\quad [\\text{GPa}]}\n$$\n  - **Assumption:** Both phases experience identical transverse stress ($\\sigma_c = \\sigma_f = \\sigma_m$);\n• **Longitudinal Fiber Load Carrying Fraction:**\n$$\n\\mathbf{\\frac{F_f}{F_{\\text{total}}} = \\frac{E_f V_f}{E_{11}} = \\frac{E_f V_f}{E_f V_f + E_m V_m} \\quad (\\text{Typically } > 95\\% - 99\\%)}\n$$\n• **The Anisotropy Invariant:** Continuous carbon fibers provide immense axial stiffness ($E_{11} \\approx 145\\text{ GPa}$) and carry $99\\%$ of flight loads, while transverse stiffness ($E_{22} \\approx 10\\text{ GPa}$) is restricted by the flexible polymer matrix!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the longitudinal and transverse elastic moduli of a continuous fiber-reinforced composite lamina.",
      "orderItems": [
        "Extract the mechanical properties: fiber modulus Ef, matrix modulus Em, and fiber volume fraction Vf",
        "Calculate the matrix volume fraction from volumetric conservation: Vm = 1 - Vf",
        "Apply the Voigt Iso-Strain Rule of Mixtures to compute the longitudinal tensile modulus: E11 = Ef * Vf + Em * Vm",
        "Apply the Reuss Iso-Stress Rule of Mixtures to compute the transverse tensile modulus: E22 = (Ef * Em) / (Em * Vf + Ef * Vm)",
        "Calculate the proportion of total longitudinal tensile force supported by the fibers: F_f / F_total = (Ef * Vf) / E11"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Composite Micromechanics Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Voigt Model (Iso-Strain)", "right": "E11 = Ef*Vf + Em*Vm, upper bound modulus assuming parallel deformation with equal strain in fiber and matrix" },
        { "left": "Reuss Model (Iso-Stress)", "right": "E22 = (Ef*Em)/(Em*Vf + Ef*Vm), lower bound modulus assuming series loading with equal stress in both phases" },
        { "left": "Fiber Volume Fraction (Vf)", "right": "Volume of reinforcing fibers divided by total composite volume governing mechanical performance" },
        { "left": "Fiber Load Ratio (Ff / Ftot)", "right": "(Ef*Vf) / E11, fraction of total applied external axial load carried directly by the reinforcing fibers" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under longitudinal tensile loading parallel to continuous aligned fibers, both the fiber and matrix undergo the exact same strain, defining the iso-___ condition of the Voigt model.",
      "blankAnswer": "strain",
      "blankDistractors": ["stress", "thermal", "density"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A carbon fiber-epoxy composite has Ef = 240.0 GPa, Em = 4.0 GPa, and Vf = 0.600 (Vm = 0.400). Longitudinal modulus is E11 = 240*0.6 + 4*0.4 = 144.0 + 1.6 = 145.6 GPa (Fiber carries 144/145.6 = 98.9% load). Transverse modulus is E22 = (240*4) / (4*0.6 + 240*0.4) = 960 / (2.4 + 96.0) = 960 / 98.4 = 9.756 GPa. What are the longitudinal modulus E11 and transverse modulus E22?",
      "options": [
        { "text": "E11 = 145.6 GPa and E22 = 9.76 GPa (E11 = 144.0 + 1.6 = 145.6 GPa; E22 = 960.0 / 98.4 = 9.756 GPa \u2248 9.76 GPa)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Rule of Mixtures for continuous aligned fiber composites (William D. Callister Jr. *Materials Science and Engineering: An Introduction* Chapter 16; Robert M. Jones *Mechanics of Composite Materials* Chapter 3). 1. **Identify Constituent Parameters \\& Volume Fractions:** - Carbon fiber modulus: $E_f = 240.0\\text{ GPa}$. - Epoxy matrix modulus: $E_m = 4.0\\text{ GPa}$. - Fiber volume fraction: $V_f = 0.600 = 60.0\\%$. - Matrix volume fraction: $V_m = 1 - V_f = 1 - 0.600 = \\mathbf{0.400 = 40.0\\%}$. 2. **Calculate Longitudinal Modulus ($E_{11}$ via Voigt Iso-Strain):** $$E_{11} = E_f V_f + E_m V_m = (240.0\\text{ GPa} \\times 0.600) + (4.0\\text{ GPa} \\times 0.400)$$ $$E_{11} = 144.0\\text{ GPa} + 1.6\\text{ GPa} = \\mathbf{145.6\\text{ GPa}}$$ 3. **Calculate Transverse Modulus ($E_{22}$ via Reuss Iso-Stress):** $$E_{22} = \\frac{E_f \\cdot E_m}{E_m V_f + E_f V_m} = \\frac{240.0\\text{ GPa} \\times 4.0\\text{ GPa}}{(4.0\\text{ GPa} \\times 0.600) + (240.0\\text{ GPa} \\times 0.400)}$$ $$E_{22} = \\frac{960.0\\text{ GPa}^2}{2.40\\text{ GPa} + 96.0\\text{ GPa}} = \\frac{960.0}{98.40} = \\mathbf{9.7561\\text{ GPa} \\approx 9.76\\text{ GPa}}$$ 4. **Calculate Fiber Load Fraction:** $$\\frac{F_f}{F_{\\text{total}}} = \\frac{E_f V_f}{E_{11}} = \\frac{144.0\\text{ GPa}}{145.6\\text{ GPa}} = \\mathbf{0.98901 = 98.90\\%}$$ - Notice that the carbon fibers carry $98.9\\%$ of the axial load! Flawless composite rule of mixtures derivation!" },
        { "text": "E11 = 9.76 GPa and E22 = 145.6 GPa (Inverted longitudinal and transverse values)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "E11 = 145.6 GPa and E22 = 145.6 GPa (Assumed isotropic behavior)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "E11 = 122.0 GPa and E22 = 4.0 GPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
