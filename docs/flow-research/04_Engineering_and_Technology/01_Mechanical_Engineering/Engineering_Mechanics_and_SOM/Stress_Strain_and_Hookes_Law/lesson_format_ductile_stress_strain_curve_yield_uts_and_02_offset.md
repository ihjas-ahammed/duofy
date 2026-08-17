# Duofy Reusable Lesson Format: Stress-Strain Curve (Yield, UTS, and 0.2% Offset Method)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Stress_Strain_and_Hookes_Law`  
**Lesson Format Type:** `ductile_stress_strain_curve_yield_uts_and_02_offset`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through tensile testing, plastic deformation physics, strain hardening, and material failure characterization in solid mechanics (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 2; William D. Callister Jr. *Materials Science and Engineering* Chapter 6; ASTM E8 Standard Test Methods for Tension Testing of Metallic Materials): master the complete **Stress-Strain Curve of Ductile Mild Steel**: **1. Linear Elastic Region** (slope $= E$, obeying Hooke's Law up to the **Proportional Limit** $\sigma_{\text{pl}}$ and **Elastic Limit**), **2. Yielding Region** (Upper and Lower Yield Points $\sigma_y$ where dislocation slip planes activate, creating Lüders bands at constant stress), **3. Strain Hardening Region** (plastic deformation increasing crystal dislocation density, reaching the **Ultimate Tensile Strength [UTS]** $\sigma_u$), **4. Localized Necking** (unstable cross-sectional area reduction causing engineering stress $\sigma = P/A_0$ to drop while true stress $\sigma_T = P/A_{\text{inst}}$ continues to rise), and **5. Cup-and-Cone Fracture**; master the **0.2% Offset Yield Method ($\mathbf{\epsilon = 0.002}$)** for materials without a distinct yield plateau (e.g. Aluminum, High-Strength Alloy Steels), and contrast **Ductile vs Brittle (e.g. Cast Iron, Concrete)** failure mechanics.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ductile Mild Steel Stress-Strain Curve Diagram (Proportional $\to$ Yield $\to$ UTS $\to$ Necking $\to$ Fracture) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Progression of a Mild Steel Tensile Specimen Pulled to Rupture Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Tensile Curve Phenomenon / Characteristic Point & Physical Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | For Materials Without a Distinct Yield Plateau, the Standard Offset Strain Used to Determine Yield Strength Is 0.___ Percent (2 / 0.2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Materials Mechanics Analysis: Why Engineering Stress Drops Beyond the UTS While True Stress Rises Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Stress-Strain Curve (Callister 2020; Beer & Johnston 2020):
   - **Tensile Curve Stages Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Curve Stage} & \textbf{Physical Deformation Mode} & \textbf{Reversibility / Governing Law} \\
     \hline
     \mathbf{\text{1. Proportional Limit (}\sigma_{\text{pl}}\text{)}} & \text{Atomic bond stretching; Slope } = E & \mathbf{\text{100\% Elastic \& Reversible (Hooke's Law)}} \\
     \mathbf{\text{2. Yield Point (}\sigma_y\text{)}} & \mathbf{\text{Dislocation slip begins (Plastic deformation)}} & \mathbf{\text{Permanent set; unrecoverable plastic strain}} \\
     \mathbf{\text{3. Strain Hardening}} & \text{Dislocation entanglement increases strength} & \text{Material strengthens up to UTS (}\sigma_u\text{)} \\
     \mathbf{\text{4. Localized Necking}} & \mathbf{\text{Instability; cross-section } A_{\text{inst}} \text{ drops rapidly}} & \mathbf{\text{Engineering stress drops; True stress rises!}} \\
     \mathbf{\text{5. Fracture Point}} & \text{Microvoid coalescence; shear rupture} & \text{Complete physical separation (Cup-and-Cone)} \\
     \hline
     \end{array}$$
   - **The 0.2% Offset Method:** Draw line parallel to linear elastic slope starting at $\mathbf{\epsilon = 0.002 \ (0.2\%)}$; intersection with curve defines **Offset Yield Strength** $\sigma_{0.2}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of tensile test progression: (1) tensile machine applies axial load; specimen stretches elastically along linear slope $\sigma = E \epsilon$, (2) stress surpasses elastic limit and hits yield point; dislocations slide creating permanent plastic strain, (3) plastic deformation causes strain hardening as crystal dislocations tangle, reaching the Ultimate Tensile Strength (UTS), (4) specimen undergoes localized necking, where cross-sectional area shrinks drastically in the center gauge length, (5) internal microvoids coalesce into a cup-and-cone shear fracture at the necked section!
3. **Slide 3 (`matching`):** Pair 4 concepts (Proportional Limit, Yield Strength, Ultimate Tensile Strength UTS, 0.2% Offset Method) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.2 (or 2). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why engineering stress drops while true stress rises: During a tensile test of ductile structural steel, why does the **Engineering Stress ($\sigma_{\text{eng}} = \frac{P}{A_0}$)** curve drop significantly after passing the Ultimate Tensile Strength (UTS), whereas the **True Stress ($\sigma_{\text{true}} = \frac{P}{A_{\text{inst}}}$)** continues to rise steadily until fracture? (Engineering stress is calculated by dividing the applied load $P$ by the **fixed, original initial cross-sectional area $A_0$**; **after the UTS is reached, localized necking occurs where the instantaneous cross-sectional area $A_{\text{inst}}$ decreases much faster than the load $P$ decreases; because the actual load-bearing area shrinks dramatically, the real physical stress carried by the remaining metal atoms ($\sigma_{\text{true}} = \frac{P}{A_{\text{inst}}}$) continues to increase until fracture**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ductile_stress_strain_curve_yield_uts_and_02_offset",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Tensile Stress-Strain Curve \\& 0.2% Offset Method (Beer \\& Johnston)**\n• **Ductile Mild Steel Deformation Spectrum:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Characteristic Region} & \\textbf{Stress Benchmark} & \\textbf{Microstructural Mechanism} & \\textbf{Deformation Nature} \\\\\n\\hline\n\\mathbf{\\text{1. Linear Elastic}} & \\mathbf{\\sigma_{\\text{pl}} \\text{ (Proportional Limit)}} & \\text{Reversible interatomic bond stretching} & \\mathbf{\\text{100\\% Reversible (Hooke's Law } \\sigma = E\\epsilon)} \\\\\n\\mathbf{\\text{2. Yield Plateau}} & \\mathbf{\\sigma_y \\text{ (Yield Strength)}} & \\text{Dislocation glide along crystal slip planes} & \\mathbf{\\text{Permanent unrecoverable plastic deformation}} \\\\\n\\mathbf{\\text{3. Strain Hardening}} & \\mathbf{\\sigma_u \\text{ (Ultimate Tensile UTS)}} & \\text{Dislocation pile-up \\& crystal tangling} & \\text{Material hardens against increasing load} \\\\\n\\mathbf{\\text{4. Localized Necking}} & \\text{Beyond UTS} & \\mathbf{\\text{Rapid cross-sectional area reduction } (A_{\\text{inst}})} & \\mathbf{\\text{Engineering stress drops; True stress RISES!}} \\\\\n\\mathbf{\\text{5. Rupture / Fracture}} & \\sigma_f \\text{ (Fracture Stress)} & \\text{Microvoid coalescence \\& 45-degree shear failure} & \\text{Complete cup-and-cone physical separation} \\\\\n\\hline\n\\end{array}\n$$\n• **The 0.2% Offset Yield Invariant:** For alloys lacking a sharp yield plateau (Aluminum, Titanium), yield strength is defined by constructing a parallel line $(\\text{slope } = E)$ originating from $\\mathbf{\\epsilon = 0.002 \\ (0.2\\%)}$ strain!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential physical deformation stages of a mild steel specimen during a standard uniaxial tensile test.",
      "orderItems": [
        "Specimen deforms elastically; interatomic bonds stretch reversibly following linear Hooke's Law up to proportional limit",
        "Specimen exceeds elastic limit and yields at sigma_y, undergoing permanent plastic deformation via dislocation slip",
        "Plastic strain accumulation causes strain hardening as dislocations tangle, increasing resistance to load up to UTS",
        "Specimen reaches Ultimate Tensile Strength (UTS), triggering localized geometric necking at the center of the gauge length",
        "Internal microvoids coalesce within the necked region, causing final cup-and-cone shear rupture at the fracture point"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Stress-Strain Characteristic to its exact Mechanical Definition.",
      "matchPairs": [
        { "left": "Proportional Limit", "right": "The maximum stress at which stress remains strictly linearly proportional to strain" },
        { "left": "0.2% Offset Yield Strength", "right": "Stress obtained by drawing a line with slope E starting at 0.002 strain to intersect the curve" },
        { "left": "Ultimate Tensile Strength (UTS)", "right": "The maximum engineering stress a material can withstand before necking initiates" },
        { "left": "Necking", "right": "Localized, unstable reduction of cross-sectional area occurring in ductile materials after UTS" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For materials without a sharp yield point, yield strength is standardized using an offset strain of 0.___ percent.",
      "blankAnswer": "2",
      "blankDistractors": ["5", "1", "02"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "During a tensile test of ductile structural steel, why does the Engineering Stress curve (sigma_eng = P / A_0) drop significantly after passing the Ultimate Tensile Strength (UTS), whereas the True Stress (sigma_true = P / A_inst) continues to rise steadily until fracture?",
      "options": [
        { "text": "Engineering stress is calculated by dividing the applied load P by the fixed, original initial cross-sectional area A_0; after the Ultimate Tensile Strength is reached, localized necking occurs where the true instantaneous cross-sectional area A_inst shrinks much faster than the load P decreases; because the actual load-bearing area decreases drastically, the true physical stress carried by the remaining material (sigma_true = P / A_inst) continues to increase steadily until final fracture", "isCorrect": true, "explanation": "Correct! This is William Callister and Beer & Johnston's fundamental distinction between Engineering Stress and True Stress (*Materials Science and Engineering* Chapter 6; *Mechanics of Materials* Chapter 2). 1. **Engineering Stress vs True Stress Formulas:** - Engineering Stress: $\\sigma_{\\text{eng}} = \\frac{P}{A_0}$ (where $A_0$ is the *constant initial cross-sectional area* before the test began). - True Stress: $\\sigma_{\\text{true}} = \\frac{P}{A_{\\text{inst}}}$ (where $A_{\\text{inst}}$ is the *actual live shrinking cross-sectional area*). 2. **What Happens at the UTS (The Necking Point):** - Before UTS: The specimen elongates uniformly across its entire length. $A_{\\text{inst}}$ shrinks slowly and evenly. - At UTS: Plastic deformation becomes geometrically unstable and concentrates in a narrow localized band (the **Neck**). - Beyond UTS: The neck thins out rapidly. The machine needs less total force $P$ to continue stretching the thin neck. - Because $A_0$ is a constant, dividing a decreasing load $P$ by $A_0$ makes **Engineering Stress drop**! - BUT $A_{\\text{inst}}$ is shrinking even faster than $P$ $\\implies$ The ratio $\\frac{P}{A_{\\text{inst}}}$ **continues to skyrocket upward until fracture**! 3. **The Conclusion:** The material is NOT getting weaker after UTS; the cross-sectional area is simply localizing!" },
        { "text": "Because ductile steel melts during tensile testing", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the testing machine loses electrical power after UTS", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Hooke's Law becomes negative at high strain", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
