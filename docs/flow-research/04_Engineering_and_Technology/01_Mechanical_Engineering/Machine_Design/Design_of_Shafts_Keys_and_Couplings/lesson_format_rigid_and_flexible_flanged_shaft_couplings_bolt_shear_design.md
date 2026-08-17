# Duofy Reusable Lesson Format: Shaft Couplings (Rigid Flanged & Flexible Bushed-Pin)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Design_of_Shafts_Keys_and_Couplings`  
**Lesson Format Type:** `rigid_and_flexible_flanged_shaft_couplings_bolt_shear_design`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through permanent and detachable shaft connections, bolt shear stress calculations, hub/flange proportions, and flexible bush dynamics in mechanical powertrain design (Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 7 & 8; Robert L. Norton *Machine Design: An Integrated Approach* Chapter 10; V.B. Bhandari *Design of Machine Elements* Chapter 9): contrast **Rigid Couplings (Flanged, Sleeve/Muff, Clamp)** vs **Flexible Couplings (Bushed-Pin Flange, Oldham, Gear, Universal Hooke's Joint)**; master the **Bolt Shear Design of a Rigid Flanged Coupling**:
$$\mathbf{T = N_b \cdot \left(\frac{\pi}{4} d_b^2 \tau_b\right) \cdot \left(\frac{D_c}{2}\right) \implies \mathbf{\tau_b = \frac{8 T}{\pi d_b^2 D_c N_b} \le \tau_{\text{allow}}}}$$
where $N_b$ is the number of fitted bolts ($N_b \ge 3$ for $d \le 40\text{ mm}$, $N_b = 4$ for $d \le 100\text{ mm}$, $N_b = 6$ for $d \le 180\text{ mm}$), $D_c = 3 d$ is the pitch circle diameter of the bolt circle, and $d_b$ is nominal bolt diameter; evaluate **Flange Shear Stress at Hub ($\mathbf{\tau_f = \frac{2 T}{\pi D_{\text{hub}}^2 t_f}}$)** where hub diameter $D_{\text{hub}} = 2 d$ and flange thickness $t_f = 0.5 d$; and analyze why **Flexible Bushed-Pin Couplings** utilize vulcanized rubber/leather bushes to absorb high-frequency torsional shock waves and accommodate small angular ($\le 2^\circ$) and parallel ($\le 0.5\text{ mm}$) shaft misalignments without destroying support bearings.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Rigid Flanged Coupling Bolt Shear Equation ($\tau_b = \frac{8T}{\pi d_b^2 D_c N_b}$) & Flange Hub Proportions Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing and Stress Verification for a Rigid Flanged Coupling Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Coupling Architecture / Fastener Failure Mode & Technical Machine Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Flexible Coupling That Uses Rubber Bushes on Connecting Pins to Damp Shock and Accommodate Misalignment Is the Bushed-___ Flange Coupling (Pin) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanical Powertrain Design Problem: Calculating the Required Bolt Diameter for a Flanged Coupling Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Flanged Couplings (Budynas 2020; Bhandari 2017):
   - **Bolt Shear Stress Formulation:**
     $$\mathbf{\tau_b = \frac{8 T}{\pi d_b^2 D_c N_b} \le \tau_{\text{allow}} \quad \Longleftrightarrow \quad \mathbf{d_b = \sqrt{\frac{8 T}{\pi D_c N_b \tau_{\text{allow}}}}}}$$
   - **Flange Geometry Proportions Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Coupling Feature} & \textbf{Standard Empirical Proportion} & \textbf{Governing Failure Mode} \\
     \hline
     \mathbf{\text{Hub Outer Diameter}} & \mathbf{D_{\text{hub}} = 2.0 d} & \text{Torsional shear in cast iron hub} \\
     \mathbf{\text{Hub Axial Length}} & \mathbf{L_{\text{hub}} = 1.5 d} & \text{Keyway length requirement} \\
     \mathbf{\text{Bolt Pitch Circle Diameter}} & \mathbf{D_c = 3.0 d} & \text{Bolt shear and crushing} \\
     \mathbf{\text{Flange Thickness}} & \mathbf{t_f = 0.5 d} & \mathbf{\text{Circumferential shear: } \tau_f = \frac{2 T}{\pi D_{\text{hub}}^2 t_f}} \\
     \mathbf{\text{Outer Flange Diameter}} & \mathbf{D_o = 4.0 d + 2 t_f} & \text{Protective rim enclosing bolt heads} \\
     \hline
     \end{array}$$
   - **Rigid vs Flexible Invariant:** Rigid couplings require **perfect collinear alignment** ($\le 0.05\text{ mm}$); flexible bushed couplings absorb vibration and allow up to **$2^\circ$ angular / $0.5\text{ mm}$ radial misalignment**!
2. **Slide 2 (`ordering`):** Provide 5 steps of flanged coupling sizing: (1) determine shaft diameter $d$ based on torque $T = \frac{P}{\omega}$, (2) calculate standard hub dimensions $D_{\text{hub}} = 2d, L_{\text{hub}} = 1.5d$ and bolt pitch circle $D_c = 3d$, (3) select number of bolts $N_b$ based on shaft diameter (e.g. $N_b = 4$ for $d = 50\text{ mm}$), (4) calculate required bolt diameter from shear equation $d_b = \sqrt{\frac{8 T}{\pi D_c N_b \tau_b}}$, (5) verify crushing stress on bolts $\sigma_c = \frac{2 T}{N_b d_b t_f D_c}$ and shear stress in flange at hub junction $\tau_f = \frac{2 T}{\pi D_{\text{hub}}^2 t_f}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Rigid Flange Coupling, Bushed-Pin Flexible Coupling, Bolt Pitch Circle $D_c = 3d$, Oldham Coupling) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Pin. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sizing coupling bolts: A rigid flanged shaft coupling connects two collinear shafts of diameter $d = 50\text{ mm}$ transmitting torque $T = 1500\text{ N}\cdot\text{m}$. The coupling uses $N_b = 4$ bolts on a pitch circle diameter $D_c = 3 d = 150\text{ mm} = 0.15\text{ m}$. The allowable shear stress for the steel bolts is $\tau_{\text{allow}} = 40\text{ MPa} = 40 \times 10^6\text{ N/m}^2$. What is the minimum required nominal bolt diameter $d_b$? ($d_b = \sqrt{\frac{8 T}{\pi D_c N_b \tau_{\text{allow}}}} = \sqrt{\frac{8(1500\text{ N}\cdot\text{m})}{\pi (0.15\text{ m})(4)(40 \times 10^6\text{ N/m}^2)}} = \sqrt{\frac{12,000}{75.398 \times 10^6}} = \sqrt{1.59155 \times 10^{-4}} \approx \mathbf{0.012615\text{ m} \approx 12.6\text{ mm}}$ (Standardized to M14 or M16 bolts)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rigid_and_flexible_flanged_shaft_couplings_bolt_shear_design",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Flanged Shaft Coupling Design \\& Fastener Shear (Shigley \\& Bhandari)**\n• **Bolt Shear Formulation on Pitch Circle Diameter ($D_c = 3 d$):**\n$$\n\\mathbf{T = N_b \\cdot \\left(\\frac{\\pi}{4} d_b^2 \\tau_b\\right) \\cdot \\left(\\frac{D_c}{2}\\right) \\implies \\mathbf{\\tau_b = \\frac{8 T}{\\pi d_b^2 D_c N_b} \\le \\tau_{\\text{allow}}}}\n$$\n• **Standard Empirical Flanged Coupling Proportions (Shaft Diameter $d$):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Coupling Component} & \\textbf{Empirical Proportion} & \\textbf{Governing Failure Mode} \\\\\n\\hline\n\\mathbf{\\text{Hub Outer Diameter}} & \\mathbf{D_{\\text{hub}} = 2.0 d} & \\text{Torsional shear in cast iron hub} \\\\\n\\mathbf{\\text{Hub Length}} & \\mathbf{L_{\\text{hub}} = 1.5 d} & \\text{Keyway contact length} \\\\\n\\mathbf{\\text{Bolt Pitch Circle}} & \\mathbf{D_c = 3.0 d} & \\text{Tangential bolt shear force} \\\\\n\\mathbf{\\text{Flange Thickness}} & \\mathbf{t_f = 0.5 d} & \\mathbf{\\text{Flange shear at hub: } \\tau_f = \\frac{2 T}{\\pi D_{\\text{hub}}^2 t_f}} \\\\\n\\hline\n\\end{array}\n$$\n• **Rigid vs Flexible Invariant:** Rigid couplings require **exact collinearity** ($< 0.05\\text{ mm}$); flexible bushed-pin couplings use rubber bushes to damp shock and allow **$\\le 2^\\circ$ angular and $\\le 0.5\\text{ mm}$ lateral misalignment**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design and verify a rigid flanged shaft coupling for an industrial motor-generator set.",
      "orderItems": [
        "Determine the nominal shaft diameter d based on transmitted torque T and allowable shaft shear stress",
        "Calculate the standard empirical dimensions: Hub diameter D_hub = 2*d, Hub length L = 1.5*d, and Bolt pitch circle D_c = 3*d",
        "Select the number of coupling bolts N_b based on shaft diameter (e.g. N_b = 4 bolts for d = 50 mm)",
        "Calculate the minimum required bolt diameter using the shear equation: d_b = sqrt((8 * T) / (pi * D_c * N_b * tau_b_allow))",
        "Verify compressive crushing stress on the bolts and circumferential shear stress in the flange at the hub junction"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Shaft Coupling Type to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Rigid Flanged Coupling", "right": "Heavy-duty transmission coupling for strictly collinear shafts with zero axial or angular misalignment" },
        { "left": "Bushed-Pin Flexible Coupling", "right": "Coupling utilizing rubber/leather bushes around connecting pins to absorb dynamic torsional shocks" },
        { "left": "Bolt Pitch Circle (Dc = 3d)", "right": "Circular diameter on the flange face upon which connecting bolts are circumferentially distributed" },
        { "left": "Flange Circumferential Shear", "right": "\u03c4f = 2*T / (pi * D_hub^2 * t_f), checking shear failure of the flange ring at the outer hub boundary" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The flexible coupling that uses rubber bushes on connecting pins to damp shock and accommodate misalignment is the bushed-___ flange coupling.",
      "blankAnswer": "pin",
      "blankDistractors": ["gear", "muff", "clamp"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rigid flanged coupling connects two collinear shafts of diameter d = 50 mm transmitting torque T = 1500 N·m. The coupling uses Nb = 4 bolts on a pitch circle diameter Dc = 3*d = 150 mm (0.15 m). The allowable shear stress for the bolts is \u03c4_allow = 40 MPa. What is the minimum required nominal bolt diameter d_b?",
      "options": [
        { "text": "d_b = 12.6 mm (Calculated from d_b = sqrt(8 * 1500 / (pi * 0.15 * 4 * 40*10^6)) = 0.0126 m, standardized to M14 or M16 bolts)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the bolt shear formula for flanged shaft couplings (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 8; V.B. Bhandari *Design of Machine Elements* Chapter 9). 1. **Torque Transmission by Bolt Shear:** $$T = N_b \\left(\\frac{\\pi}{4} d_b^2 \\tau_{\\text{allow}}\\right) \\left(\\frac{D_c}{2}\\right) = \\frac{\\pi}{8} d_b^2 D_c N_b \\tau_{\\text{allow}}$$ 2. **Isolate Bolt Diameter ($d_b$):** $$d_b = \\sqrt{\\frac{8 T}{\\pi D_c N_b \\tau_{\\text{allow}}}}$$ 3. **Substitute Numerical Values:** $$d_b = \\sqrt{\\frac{8(1500\\text{ N}\\cdot\\text{m})}{\\pi (0.15\\text{ m})(4)(40 \\times 10^6\\text{ N/m}^2)}} = \\sqrt{\\frac{12,000}{75,398,224}} = \\sqrt{1.59155 \\times 10^{-4}\\text{ m}^2} \\approx \\mathbf{0.012615\\text{ m} \\approx 12.6\\text{ mm}}$$ 4. **Standard Selection:** In mechanical engineering practice, an engineer standardizes this to **M14 or M16 high-tensile steel bolts**!" },
        { "text": "d_b = 6.3 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d_b = 25.2 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d_b = 18.8 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
