# Duofy Reusable Lesson Format: Sunk Key Design (Shear & Crushing Failure Modes)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Design_of_Shafts_Keys_and_Couplings`  
**Lesson Format Type:** `design_of_sunk_keys_shear_and_crushing_failure_criteria`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through machine element key connections, torque transmission mechanics, and dual failure mode sizing (shear vs crushing) in shaft-hub assemblies (Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 7; Robert L. Norton *Machine Design: An Integrated Approach* Chapter 10; V.B. Bhandari *Design of Machine Elements* Chapter 9): derive the **Tangential Transmitted Force on a Sunk Key ($\mathbf{F = \frac{2 T}{d}}$)** where $T$ is shaft torque and $d$ is shaft diameter; master the **Two Primary Modes of Mechanical Key Failure**:
1. **Shear Failure Mode:** Key slices along the horizontal pitch plane between shaft and hub:
   $$\mathbf{\tau = \frac{F}{w \cdot L} = \frac{2 T}{d \cdot w \cdot L} \le \tau_{\text{allow}} \implies \mathbf{L_{\text{shear}} = \frac{2 T}{d \cdot w \cdot \tau_{\text{allow}}}}}$$
2. **Crushing (Bearing Compressive) Failure Mode:** Key side wall is crushed against the keyway flank over half-height $h/2$:
   $$\mathbf{\sigma_c = \frac{F}{(h/2) \cdot L} = \frac{4 T}{d \cdot h \cdot L} \le \sigma_{c,\text{allow}} \implies \mathbf{L_{\text{crush}} = \frac{4 T}{d \cdot h \cdot \sigma_{c,\text{allow}}}}}$$
and prove the **Equal Strength Sunk Key Theorem** (demonstrating why standard engineering proportions specify a **Square Key with $w = h = d/4$**: when key material has compressive bearing strength $\sigma_{c,\text{allow}} = 2 \tau_{\text{allow}}$, a square key exhibits **EXACTLY identical failure resistance in both shear and crushing**!).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sunk Key Shear ($\tau = \frac{2T}{d w L}$) & Crushing ($\sigma_c = \frac{4T}{d h L}$) Equations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Required Key Length (L) for a Machine Hub Connection Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Key Geometry Parameter / Failure Stress & Physical Machine Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Sunk Key with Equal Width and Height (w = h) Is Classified as a ___ Key (Square) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanical Component Design Problem: Calculating the Required Sunk Key Length to Transmit 1000 N·m Torque Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Sunk Key Design (Budynas 2020; Bhandari 2017):
   - **Sunk Key Stress Formulations:**
     $$\mathbf{\tau = \frac{2 T}{d \cdot w \cdot L} \le \tau_{\text{allow}} \quad \Big| \quad \sigma_c = \frac{4 T}{d \cdot h \cdot L} \le \sigma_{c,\text{allow}}}$$
   - **Required Length Formulations:**
     $$\mathbf{L = \max\left( \frac{2 T}{d \cdot w \cdot \tau_{\text{allow}}}, \ \frac{4 T}{d \cdot h \cdot \sigma_{c,\text{allow}}} \right)}$$
   - **The Equal Strength Square Key Invariant:**
     - For standard ductile steel where $\sigma_{c,\text{allow}} = 2 \tau_{\text{allow}}$:
     - Equating $L_{\text{shear}} = L_{\text{crush}} \implies \frac{2T}{dw\tau} = \frac{4T}{dh(2\tau)} \implies \mathbf{w = h}$ (**Square Key!**)
2. **Slide 2 (`ordering`):** Provide 5 steps of sizing a sunk key: (1) determine transmitted shaft torque $T = \frac{P}{\omega}$ and shaft diameter $d$, (2) select standard key cross-section dimensions (width $w \approx d/4$, height $h \approx d/4$), (3) calculate required key length against shear failure $L_{\text{shear}} = \frac{2 T}{d \cdot w \cdot \tau_{\text{allow}}}$, (4) calculate required key length against crushing failure $L_{\text{crush}} = \frac{4 T}{d \cdot h \cdot \sigma_{c,\text{allow}}}$, (5) select final design length $L = \max(L_{\text{shear}}, L_{\text{crush}})$ and verify that $L \le 1.5 d$ to prevent non-uniform load distribution!
3. **Slide 3 (`matching`):** Pair 4 concepts (Shear Failure, Crushing / Bearing Failure, Square Key $w=h$, Woodruff Key) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Square. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating required key length: A solid shaft of diameter $d = 50\text{ mm}$ transmits a torque $T = 1000\text{ N}\cdot\text{m}$. A square sunk key of width $w = 12\text{ mm}$ and height $h = 12\text{ mm}$ is used. The allowable shear stress is $\tau_{\text{allow}} = 60\text{ MPa}$ and the allowable crushing stress is $\sigma_{c,\text{allow}} = 100\text{ MPa}$. What is the minimum required key length $L$? ($L_{\text{shear}} = \frac{2 T}{d \cdot w \cdot \tau_{\text{allow}}} = \frac{2(1000\text{ N}\cdot\text{m})}{(0.050\text{ m})(0.012\text{ m})(60 \times 10^6\text{ N/m}^2)} = \frac{2000}{36,000} = 0.05556\text{ m} = \mathbf{55.6\text{ mm}}$; $L_{\text{crush}} = \frac{4 T}{d \cdot h \cdot \sigma_{c,\text{allow}}} = \frac{4(1000)}{(0.050)(0.012)(100 \times 10^6)} = \frac{4000}{60,000} = 0.06667\text{ m} = \mathbf{66.7\text{ mm}}$; Final length is governed by crushing: $L = \max(55.6, 66.7) = \mathbf{66.7\text{ mm}}$ (Standardized to $L = 70\text{ mm}$)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "design_of_sunk_keys_shear_and_crushing_failure_criteria",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Sunk Key Sizing \\& Dual Failure Modes (Shigley \\& Bhandari)**\n• **Tangential Driving Force on Sunk Key:**\n$$\n\\mathbf{F = \\frac{2 T}{d} \\quad (T = \\text{Shaft Torque}, \\ d = \\text{Shaft Diameter})}\n$$\n• **Dual Stress Failure Formulations:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Failure Mechanism} & \\textbf{Stress Formula} & \\textbf{Minimum Required Key Length } L \\\\\n\\hline\n\\mathbf{\\text{Shear Failure Mode}} & \\mathbf{\\tau = \\frac{2 T}{d \\cdot w \\cdot L} \\le \\tau_{\\text{allow}}} & \\mathbf{L_{\\text{shear}} = \\frac{2 T}{d \\cdot w \\cdot \\tau_{\\text{allow}}}} \\\\\n\\mathbf{\\text{Crushing (Bearing)}} & \\mathbf{\\sigma_c = \\frac{4 T}{d \\cdot h \\cdot L} \\le \\sigma_{c,\\text{allow}}} & \\mathbf{L_{\\text{crush}} = \\frac{4 T}{d \\cdot h \\cdot \\sigma_{c,\\text{allow}}}} \\\\\n\\hline\n\\end{array}\n$$\n• **Design Length Selection Invariant:** $\\mathbf{L = \\max(L_{\\text{shear}}, L_{\\text{crush}})}$.\n• **The Equal-Strength Square Key Invariant:** For standard ductile steels where $\\sigma_{c,\\text{allow}} \\approx 2 \\tau_{\\text{allow}}$, a **Square Key ($\\mathbf{w = h = d/4}$)** yields $L_{\\text{shear}} = L_{\\text{crush}}$, providing **perfectly balanced failure resistance**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design and size a parallel square sunk key for a motor-to-gearbox connection.",
      "orderItems": [
        "Determine the transmitted torque T and nominal shaft diameter d at the keyway location",
        "Select standard key cross-sectional dimensions based on shaft diameter (w = d / 4, h = d / 4)",
        "Calculate the minimum required key length to resist shear failure: L_shear = (2 * T) / (d * w * tau_allow)",
        "Calculate the minimum required key length to resist compressive crushing: L_crush = (4 * T) / (d * h * sigma_c_allow)",
        "Select final design length L = max(L_shear, L_crush) and verify that L <= 1.5 * d to prevent non-uniform load distribution"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Key Design Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Shear Failure on Key", "right": "\u03c4 = 2*T / (d * w * L), shearing across the horizontal pitch plane interface between shaft and hub" },
        { "left": "Crushing Failure on Key", "right": "\u03c3c = 4*T / (d * h * L), compressive bearing deformation across the side contact area" },
        { "left": "Square Sunk Key", "right": "Standard key geometry (w = h) providing equal strength in shear and crushing when \u03c3c = 2*\u03c4" },
        { "left": "Woodruff Key", "right": "Semicircular disc key used on tapered shaft ends capable of self-aligning in tilted keyways" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A sunk key designed with equal width and height (w = h) is classified as a ___ key.",
      "blankAnswer": "square",
      "blankDistractors": ["feather", "spline", "saddle"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A solid shaft of diameter d = 50 mm transmits torque T = 1000 N·m. A square sunk key of width w = 12 mm and height h = 12 mm is used. The allowable shear stress is \u03c4_allow = 60 MPa and allowable crushing stress is \u03c3c_allow = 100 MPa. What is the minimum required key length L?",
      "options": [
        { "text": "L = 66.7 mm (Governed by crushing failure: L_crush = 4*1000 / (0.050 * 0.012 * 100*10^6) = 0.0667 m, while L_shear = 55.6 mm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the dual failure criteria for sunk keys (Richard Budynas *Shigley's Mechanical Engineering Design* Chapter 7; V.B. Bhandari *Design of Machine Elements* Chapter 9). 1. **Calculate Required Length Based on Shear Failure ($L_{\\text{shear}}$):** $$L_{\\text{shear}} = \\frac{2 T}{d \\cdot w \\cdot \\tau_{\\text{allow}}} = \\frac{2(1000\\text{ N}\\cdot\\text{m})}{(0.050\\text{ m})(0.012\\text{ m})(60 \\times 10^6\\text{ N/m}^2)} = \\frac{2000}{36,000} = 0.05556\\text{ m} = \\mathbf{55.6\\text{ mm}}$$ 2. **Calculate Required Length Based on Crushing Failure ($L_{\\text{crush}}$):** $$L_{\\text{crush}} = \\frac{4 T}{d \\cdot h \\cdot \\sigma_{c,\\text{allow}}} = \\frac{4(1000\\text{ N}\\cdot\\text{m})}{(0.050\\text{ m})(0.012\\text{ m})(100 \\times 10^6\\text{ N/m}^2)} = \\frac{4000}{60,000} = 0.06667\\text{ m} = \\mathbf{66.7\\text{ mm}}$$ 3. **Select Design Length:** - Since $L_{\\text{crush}} (66.7\\text{ mm}) > L_{\\text{shear}} (55.6\\text{ mm})$, **crushing is the critical failure mode**! - Minimum required length: $L = \\max(55.6\\text{ mm}, 66.7\\text{ mm}) = \\mathbf{66.7\\text{ mm}}$. - Standard commercial selection: **$L = 70\\text{ mm}$**!" },
        { "text": "L = 55.6 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L = 33.3 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L = 120.0 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
