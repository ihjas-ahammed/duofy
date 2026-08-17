# Duofy Reusable Lesson Format: Shaft Design (ASME Code & DE-Goodman Fatigue)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Design_of_Shafts_Keys_and_Couplings`  
**Lesson Format Type:** `asme_shaft_design_and_de_goodman_fatigue_failure_criterion`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through transmission shaft design, multi-axial fatigue stress analysis, and the DE-Goodman failure criterion in mechanical engineering (Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 7; ASME B106.1M Design of Transmission Shafting Standard): master the **Distortion Energy (DE) Goodman Fatigue Shaft Equation** for solid circular shafts subjected to completely reversed alternating bending moment $M_a = M$ (due to shaft rotation) and steady mean torque $T_m = T$:
$$\mathbf{d = \left[ \frac{16 n}{\pi} \left( \frac{2 K_f M}{S_e} + \frac{\sqrt{3} K_{fs} T}{S_{ut}} \right) \right]^{1/3}}$$
where $n$ is design safety factor, $K_f, K_{fs}$ are fatigue stress concentration factors at keyways/shoulders, $S_e$ is endurance limit, and $S_{ut}$ is ultimate tensile strength; contrast with the **Static Maximum Shear Stress (Tresca) Theory**:
$$\mathbf{T_e = \sqrt{M^2 + T^2} \implies \mathbf{d = \left(\frac{16 T_e}{\pi \tau_{\text{allow}}}\right)^{1/3}} \quad \Big| \quad M_e = \frac{1}{2}\left(M + \sqrt{M^2 + T^2}\right)}$$
and analyze why shaft diameter sizing is almost always **deflection/rigidity-limited rather than pure yield-limited** (to prevent gear tooth misalignment and bearing binding).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DE-Goodman Fatigue Shaft Equation & Equivalent Twisting Moment ($T_e = \sqrt{M^2 + T^2}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of a Transmission Shaft Diameter under Combined Bending and Torsion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Shaft Design Variable / Failure Criterion & Physical Engineering Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Static Shaft Design under Combined Loads, the Quantity T_e = \sqrt{M^2 + T^2} Is the Equivalent ___ Moment (Twisting / Torsional) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Powertrain Machine Design Problem: Calculating the Required Shaft Diameter under Combined Bending and Torsion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Shaft Fatigue & Static Design (Budynas 2020; ASME):
   - **DE-Goodman Shaft Formulation:**
     $$\mathbf{d = \left[ \frac{16 n}{\pi} \left( \frac{2 K_f M}{S_e} + \frac{\sqrt{3} K_{fs} T}{S_{ut}} \right) \right]^{1/3} \quad \left(M_a = M, \ T_m = T\right)}$$
   - **Static Equivalent Moments Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Failure Theory} & \textbf{Equivalent Formulation} & \textbf{Governing Equation} & \textbf{Application} \\
     \hline
     \mathbf{\text{Max Shear Stress (Tresca)}} & \mathbf{T_e = \sqrt{M^2 + T^2}} & \mathbf{\tau_{\text{max}} = \frac{16 T_e}{\pi d^3} \le \tau_{\text{allow}}} & \text{Ductile shaft static sizing} \\
     \mathbf{\text{Max Normal Stress (Rankine)}} & \mathbf{M_e = \frac{1}{2}(M + \sqrt{M^2 + T^2})} & \sigma_{\text{max}} = \frac{32 M_e}{\pi d^3} \le \sigma_{\text{allow}} & \text{Brittle shaft static sizing} \\
     \hline
     \end{array}$$
   - **The Rotation Fatigue Invariant:** A rotating shaft carrying a constant transverse load experiences **completely reversed cyclic bending stress ($\sigma = \pm \frac{32 M}{\pi d^3}$)** on every half-rotation, making fatigue the primary failure mode!
2. **Slide 2 (`ordering`):** Provide 5 steps of shaft diameter sizing: (1) calculate bending moments in vertical and horizontal planes and compute resultant moment $M = \sqrt{M_v^2 + M_h^2}$, (2) determine steady transmitted torque $T = \frac{P}{\omega}$, (3) compute modified endurance limit $S_e = k_a k_b k_c k_d S_e'$ and obtain stress concentration factors $K_f, K_{fs}$, (4) apply the DE-Goodman equation to calculate required fatigue shaft diameter $d$, (5) check torsional and lateral deflections to ensure gear mesh alignment ($\theta \le 0.05^\circ$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (DE-Goodman Equation, Equivalent Twisting Moment $T_e$, Endurance Limit $S_e$, Reversed Bending $\sigma_a$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Twisting (or Torsional). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating shaft diameter: A solid steel transmission shaft is subjected to a steady torque $T = 400\text{ N}\cdot\text{m}$ and a maximum resultant bending moment $M = 300\text{ N}\cdot\text{m}$. The allowable shear stress for the shaft material is $\tau_{\text{allow}} = 50\text{ MPa} = 50 \times 10^6\text{ N/m}^2$. Using the Maximum Shear Stress Theory (Tresca), what is the minimum required shaft diameter $d$? ($T_e = \sqrt{M^2 + T^2} = \sqrt{(300)^2 + (400)^2} = \sqrt{90,000 + 160,000} = \sqrt{250,000} = \mathbf{500\text{ N}\cdot\text{m}}$; $d = \left(\frac{16 T_e}{\pi \tau_{\text{allow}}}\right)^{1/3} = \left(\frac{16 \times 500}{\pi \times 50 \times 10^6}\right)^{1/3} = \left(\frac{8000}{157.08 \times 10^6}\right)^{1/3} = (5.093 \times 10^{-5})^{1/3} \approx \mathbf{0.03707\text{ m} \approx 37.1\text{ mm}}$ (Standardized to $d = 40\text{ mm}$)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "asme_shaft_design_and_de_goodman_fatigue_failure_criterion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Shaft Design \\& DE-Goodman Fatigue Failure (Shigley \\& ASME)**\n• **DE-Goodman Multi-Axial Fatigue Formulation:**\n$$\n\\mathbf{d = \\left[ \\frac{16 n}{\\pi} \\left( \\frac{2 K_f M}{S_e} + \\frac{\\sqrt{3} K_{fs} T}{S_{ut}} \\right) \\right]^{1/3} \\quad \\left(M_a = M, \\ T_m = T\\right)}\n$$\n• **Static Failure Criteria Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Failure Theory} & \\textbf{Equivalent Moment Formulation} & \\textbf{Shaft Sizing Formula } d \\\\\n\\hline\n\\mathbf{\\text{Max Shear Stress (Tresca)}} & \\mathbf{T_e = \\sqrt{M^2 + T^2}} & \\mathbf{d = \\left( \\frac{16 T_e}{\\pi \\tau_{\\text{allow}}} \\right)^{1/3}} \\\\\n\\mathbf{\\text{Max Normal Stress (Rankine)}} & \\mathbf{M_e = \\frac{1}{2}\\left(M + \\sqrt{M^2 + T^2}\\right)} & d = \\left( \\frac{32 M_e}{\\pi \\sigma_{\\text{allow}}} \\right)^{1/3} \\\\\n\\hline\n\\end{array}\n$$\n• **The Rotation Fatigue Invariant:** A rotating shaft carrying transverse gear/pulley loads experiences **completely reversed alternating bending stresses ($\\mathbf{\\sigma_a = \\pm \\frac{32 M}{\\pi d^3}}$)**, making fatigue endurance $S_e$ the primary design constraint!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a rotating machine transmission shaft for infinite fatigue life under combined bending and torsion.",
      "orderItems": [
        "Construct bending moment diagrams in horizontal and vertical planes to compute resultant bending moment M = sqrt(M_h^2 + M_v^2)",
        "Determine the transmitted torque from machine power and speed: T = Power / omega",
        "Compute the modified endurance limit Se using Marin surface, size, and reliability factors",
        "Determine fatigue stress concentration factors Kf and Kfs for keyways, shoulders, and snap-ring grooves",
        "Apply the DE-Goodman fatigue equation to evaluate minimum shaft diameter d and verify torsional/lateral deflection limits"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Shaft Design Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Equivalent Twisting Moment (Te)", "right": "Te = sqrt(M^2 + T^2), representing the combined static torsional shear stress intensity" },
        { "left": "Equivalent Bending Moment (Me)", "right": "Me = 0.5 * (M + sqrt(M^2 + T^2)), representing maximum principal tensile stress in brittle shafts" },
        { "left": "DE-Goodman Fatigue Criterion", "right": "Combines alternating bending stress with mean torsional shear stress to size shafts for infinite life" },
        { "left": "Endurance Limit Modification", "right": "Marin factors (ka, kb, kc) derating laboratory endurance strength for surface finish and shaft size" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In static shaft design under combined loads, the quantity Te = sqrt(M^2 + T^2) is the equivalent ___ moment.",
      "blankAnswer": "twisting",
      "blankDistractors": ["bending", "polar", "axial"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A solid steel shaft transmits steady torque T = 400 N·m while subjected to a maximum resultant bending moment M = 300 N·m. The allowable shear stress for the material is \u03c4_allow = 50 MPa. Using the Maximum Shear Stress Theory (Tresca), what is the minimum required shaft diameter d?",
      "options": [
        { "text": "d = 37.1 mm (Te = sqrt(300^2 + 400^2) = 500 N·m and d = (16 * 500 / (pi * 50*10^6))^(1/3) = 0.0371 m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Maximum Shear Stress Theory (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 7). 1. **Calculate Equivalent Twisting Moment ($T_e$):** $$T_e = \\sqrt{M^2 + T^2} = \\sqrt{(300\\text{ N}\\cdot\\text{m})^2 + (400\\text{ N}\\cdot\\text{m})^2} = \\sqrt{90,000 + 160,000} = \\sqrt{250,000} = \\mathbf{500\\text{ N}\\cdot\\text{m}}$$ 2. **Apply the Torsional Shear Stress Equation:** $$\\tau_{\\text{max}} = \\frac{16 T_e}{\\pi d^3} \\le \\tau_{\\text{allow}}$$ 3. **Solve for Shaft Diameter ($d$):** $$d = \\left( \\frac{16 T_e}{\\pi \\tau_{\\text{allow}}} \\right)^{1/3} = \\left( \\frac{16 \\times 500\\text{ N}\\cdot\\text{m}}{\\pi \\times 50 \\times 10^6\\text{ N/m}^2} \\right)^{1/3}$$ $$d = \\left( \\frac{8000}{157,079,632} \\right)^{1/3} = \\left( 5.092958 \\times 10^{-5} \\right)^{1/3} \\approx \\mathbf{0.037068\\text{ m} \\approx 37.1\\text{ mm}}$$ 4. **Standard Selection:** A mechanical engineer would specify a standard commercial shaft diameter of **$d = 40\\text{ mm}$**!" },
        { "text": "d = 50.0 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d = 25.4 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d = 18.5 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
