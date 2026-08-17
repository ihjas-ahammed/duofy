# Duofy Reusable Lesson Format: Shaft Efficiency (Hollow vs Solid Shafts and Angle of Twist)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Torsion_of_Shafts_and_Columns`  
**Lesson Format Type:** `hollow_vs_solid_shaft_efficiency_and_angle_of_twist`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through structural weight optimization, polar inertia geometry, and torsional angular deformation limits in shaft design (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 3; James M. Gere & Barry J. Goodno *Mechanics of Materials*): master the **Angle of Twist ($\mathbf{\theta = \frac{T L}{G J}}$)** for stepped and composite shafts in series and parallel, analyze **Polar Moment of Inertia for Hollow Shafts ($\mathbf{J = \frac{\pi (D_o^4 - D_i^4)}{32}}$)**, prove why **Hollow Shafts are Vastly Superior in Weight-to-Strength Ratio compared to Solid Shafts** of identical cross-sectional material area (because in a solid shaft, material near the center axis $r \approx 0$ experiences near-zero shear stress and contributes negligibly to torque resistance, while a hollow shaft places 100% of material at large outer radii $R$ where shear stress and moment arms are maximized), and calculate percentage weight savings in automotive driveshafts and aerospace propulsion systems.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hollow Shaft Polar Inertia ($J = \frac{\pi (D^4-d^4)}{32}$) & Angle of Twist ($\theta = \frac{TL}{GJ}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Comparison of Torque Capacity for Equal-Weight Solid vs Hollow Shafts Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Torsional Deflection / Hollow Shaft Optimization Construct & Technical Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Angular Rotation Experienced by a Shaft Under Torsion Is the Angle of ___ (Twist) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanical Optimization Analysis: Why Hollow Shafts Transmit Greater Torque for Identical Material Weight Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hollow Shafts & Twist (Beer & Johnston 2020; Gere & Goodno):
   - **Solid vs Hollow Shafts Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Shaft Configuration} & \textbf{Cross-Section Area } A & \textbf{Polar Moment of Inertia } J & \textbf{Torsional Section Modulus } Z_p \\
     \hline
     \mathbf{\text{Solid Shaft } (d_s)} & A = \frac{\pi d_s^2}{4} & \mathbf{J = \frac{\pi d_s^4}{32}} & \mathbf{Z_p = \frac{\pi d_s^3}{16}} \\
     \mathbf{\text{Hollow Shaft } (D_o, D_i)} & A = \frac{\pi (D_o^2 - D_i^2)}{4} & \mathbf{J = \frac{\pi (D_o^4 - D_i^4)}{32}} & \mathbf{Z_p = \frac{\pi (D_o^4 - D_i^4)}{16 D_o}} \\
     \hline
     \end{array}$$
   - **The Angle of Twist in Series:**
     $$\mathbf{\theta_{\text{total}} = \sum_{i=1}^n \frac{T_i L_i}{G_i J_i} \quad [\text{rad}] \quad \left(\text{To convert to degrees: } \theta^\circ = \theta_{\text{rad}} \times \frac{180}{\pi}\right)}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of comparing equal-weight solid vs hollow shafts: (1) set cross-sectional area equal $A_{\text{solid}} = A_{\text{hollow}} \implies d_s^2 = D_o^2 - D_i^2$, (2) express inner diameter as a ratio of outer diameter $D_i = k D_o$ (e.g. $k=0.6$), (3) solve solid diameter $d_s = D_o \sqrt{1 - k^2}$, (4) compute torsional section moduli ratio $\frac{Z_{p,\text{hollow}}}{Z_{p,\text{solid}}} = \frac{D_o^4 - D_i^4}{D_o d_s^3} = \frac{1 - k^4}{(1 - k^2)^{1.5}} = \frac{1 + k^2}{\sqrt{1 - k^2}}$, (5) verify that for $k=0.6$, the hollow shaft transmits **$1.70\times$ more torque ($+70\%$ capacity)** for the exact same mass of metal!
3. **Slide 3 (`matching`):** Pair 4 concepts (Hollow Shaft $J$, Angle of Twist $\theta$, Series Shaft Rule, Shaft Weight Savings) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Twist. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why hollow shafts are superior in weight: In automotive and aerospace engineering, why are propeller drive shafts manufactured as hollow tubes rather than solid metal rods of identical mass? (Torsional shear stress increases linearly with radius from $0$ at the center to maximum at the outer surface; **material located near the center axis of a solid shaft experiences virtually zero shear stress and contributes almost nothing to torque resistance; hollow shafts eliminate this inefficient 'dead weight' metal at the center and relocate it to a larger outer radius $D_o$, substantially increasing the polar moment of inertia $J \propto R^4$ and torsional section modulus $Z_p$, allowing the hollow shaft to transmit significantly higher torque and resist twist with $40-60\%$ less weight**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hollow_vs_solid_shaft_efficiency_and_angle_of_twist",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hollow Shaft Optimization \\& Angle of Twist (Beer \\& Johnston)**\n• **Solid vs Hollow Shaft Geometries:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Shaft Geometry} & \\textbf{Cross-Section Area } A & \\textbf{Polar Moment } J & \\textbf{Torsional Modulus } Z_p \\\\\n\\hline\n\\mathbf{\\text{Solid Shaft } (d_s)} & A = \\frac{\\pi d_s^2}{4} & \\mathbf{J = \\frac{\\pi d_s^4}{32}} & \\mathbf{Z_p = \\frac{\\pi d_s^3}{16}} \\\\\n\\mathbf{\\text{Hollow Shaft } (D_o, D_i)} & A = \\frac{\\pi (D_o^2 - D_i^2)}{4} & \\mathbf{J = \\frac{\\pi (D_o^4 - D_i^4)}{32}} & \\mathbf{Z_p = \\frac{\\pi (D_o^4 - D_i^4)}{16 D_o}} \\\\\n\\hline\n\\end{array}\n$$\n• **Angle of Twist Superposition in Series:**\n$$\n\\mathbf{\\theta_{\\text{total}} = \\sum_{i=1}^n \\frac{T_i L_i}{G_i J_i} \\ [\\text{radians}] \\quad \\Big| \\quad \\theta^\\circ = \\theta_{\\text{rad}} \\times \\frac{180^\\circ}{\\pi}}\n$$\n• **The Efficiency Law:** Removing material from the low-stress center ($r \\approx 0$) and placing it at the high-radius perimeter ($R$) increases torque capacity by **up to 70–100% for the exact same mass of metal**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to prove mathematically that a hollow shaft transmits greater torque than an equal-weight solid shaft.",
      "orderItems": [
        "Set cross-sectional areas equal for identical material weight per unit length: A_solid = A_hollow (d_s^2 = D_o^2 - D_i^2)",
        "Define the inner-to-outer diameter ratio k = D_i / D_o (e.g. k = 0.6) and express solid diameter as d_s = D_o * sqrt(1 - k^2)",
        "Formulate the ratio of torsional section moduli: Z_p(hollow) / Z_p(solid) = (1 - k^4) / (1 - k^2)^1.5",
        "Simplify the algebraic ratio to (1 + k^2) / sqrt(1 - k^2)",
        "Evaluate at k = 0.6 to prove the hollow shaft transmits 1.70x the torque (+70% capacity) of an equal-weight solid shaft"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Torsional Optimization Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Hollow Polar Moment (J)", "right": "J = pi * (D_o^4 - D_i^4) / 32, measuring torsional resistance of a hollow tube" },
        { "left": "Equal-Weight Torque Boost", "right": "Hollow shafts transmit 50-100% greater torque than solid shafts of identical metal mass" },
        { "left": "Shafts in Series (\u03b8_total)", "right": "Total twist equals the algebraic sum of individual segment twists (\u03b81 + \u03b82 + ...)" },
        { "left": "Shafts in Parallel (T_total)", "right": "Applied torque is divided between concentric shafts that share an identical angle of twist (\u03b81 = \u03b82)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The total angular deformation experienced by a shaft under an applied torque is the angle of ___.",
      "blankAnswer": "twist",
      "blankDistractors": ["shear", "bending", "deflection"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In automotive and aerospace engineering, why are propeller drive shafts manufactured as hollow tubes rather than solid metal rods of identical mass?",
      "options": [
        { "text": "Torsional shear stress varies linearly with radius from zero at the center to maximum at the outer surface; material located near the central rotational axis of a solid shaft experiences virtually zero shear stress and contributes negligible resistance to applied torque; hollow shafts eliminate this inefficient central 'dead-weight' material and concentrate 100% of the metal at a larger outer radius D_o, drastically increasing the polar moment of inertia J (proportional to radius to the 4th power) and torsional section modulus Z_p, allowing the hollow shaft to transmit significantly higher torque and resist twist with 40-60% less total weight", "isCorrect": true, "explanation": "Correct! This is Ferdinand Beer and Russell Johnston's central efficiency proof for shaft design (*Mechanics of Materials* Chapter 3). 1. **The Inefficiency of Solid Centers:** - In a solid shaft of radius $R$: - At $r = 0$: Shear stress $\\tau = 0\\text{ MPa}$! - At $r = 0.5 R$: Shear stress is only $50\\%$ of maximum! - The inner $50\\%$ of the shaft diameter contains $25\\%$ of the total metal volume, but contributes **less than $6\\%$ of the total torsional resistance**! 2. **The Hollow Optimization:** - If we bore out the center ($D_i = 0.6 D_o$) and redistribute that metal to the outer perimeter: - $100\\%$ of the metal now operates at high radii ($r \\ge 0.3 D_o$). - Because Polar Moment of Inertia scales as $R^4$: $J = \\frac{\\pi (D_o^4 - D_i^4)}{32}$. - **Result:** The hollow shaft transmits **$70\\%$ more torque** or can be made **$50\\%$ lighter** while matching solid shaft torque capacity! 3. **The Application:** This is why race cars, jet turbine drive shafts, and helicopter rotor masts are exclusively hollow tubes!" },
        { "text": "Because solid shafts are prohibited by highway safety laws", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hollow shafts cool down faster due to internal air circulation", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because solid shafts cannot be turned on a lathe", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
