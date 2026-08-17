# Duofy Reusable Lesson Format: Transverse Shear Stress (Jourawski's Shear Formula in Beams)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Bending_Moments_and_Shear_Force`  
**Lesson Format Type:** `transverse_shear_stress_in_beams_and_jourawski_formula`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through horizontal and vertical transverse shear stresses, first moments of area ($Q$), and parabolic stress distributions in structural beams (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 6; Russell C. Hibbeler *Mechanics of Materials* Chapter 7): master **Jourawski's Shear Formula**:
$$\mathbf{\tau(y) = \frac{V Q(y)}{I b}}$$
where $V$ is internal transverse shear force, $I$ is moment of inertia of entire cross-section, $b$ is section width at coordinate $y$, and $\mathbf{Q(y) = \bar{y}' A'}$ is the **First Moment of Area** of the segment above/below the cut about the Neutral Axis; derive the **Parabolic Shear Stress Distribution** across rectangular beams:
$$\mathbf{\tau(y) = \frac{3 V}{2 b h} \left(1 - \frac{4 y^2}{h^2}\right) \implies \mathbf{\tau_{\text{max}} = \frac{3}{2} \frac{V}{A} = 1.5 \, \tau_{\text{avg}} \text{ at the Neutral Axis } (y=0)}}$$
contrast shear profiles in **Wide-Flange I-Beams** (where the thin vertical web carries $>90-95\%$ of total shear force while flanges carry $<10\%$), and evaluate circular cross-sections ($\mathbf{\tau_{\text{max}} = \frac{4}{3} \frac{V}{A}}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Jourawski Formula ($\tau = \frac{VQ}{Ib}$), $Q = \bar{y}'A'$, & Rectangular Parabolic Profile Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Calculation of the First Moment of Area Q and Peak Shear Stress Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Beam Shear Stress Property / Cross-Section Shape & Technical Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Solid Rectangular Beam Subjected to Transverse Shear, Maximum Shear Stress Occurs at the ___ Axis (Neutral) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Mechanics Problem: Calculating the Maximum Transverse Shear Stress in a Rectangular Beam Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Jourawski Formula (Beer & Johnston 2020; Hibbeler 2018):
   - **Transverse Shear Stress Formulation:**
     $$\mathbf{\tau = \frac{V Q}{I b} \quad \text{where } Q = \int_y^c y' \, dA' = \bar{y}' A'}$$
   - **Cross-Sectional Peak Shear Stress Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Cross-Section Geometry} & \textbf{Shear Distribution Profile} & \textbf{Location of } \tau_{\text{max}} & \textbf{Peak Stress Formula } \tau_{\text{max}} \\
     \hline
     \mathbf{\text{Solid Rectangle } (b \times h)} & \mathbf{\text{Parabolic Profile}} & \mathbf{\text{Neutral Axis } (y=0)} & \mathbf{\tau_{\text{max}} = \frac{3}{2} \frac{V}{A} = 1.5 \, \tau_{\text{avg}}} \\
     \mathbf{\text{Solid Circle } (d)} & \text{Parabolic Profile} & \text{Neutral Axis (Centroid)} & \mathbf{\tau_{\text{max}} = \frac{4}{3} \frac{V}{A} \approx 1.33 \, \tau_{\text{avg}}} \\
     \mathbf{\text{I-Beam (Flanges + Web)}} & \mathbf{\text{Web carries } >90\% \text{ of shear}} & \text{Neutral Axis (Web center)} & \mathbf{\tau_{\text{max}} \approx \frac{V}{A_{\text{web}}}} \\
     \hline
     \end{array}$$
   - **Boundary Condition Invariant:** Normal free top and bottom surfaces ($y = \pm h/2$) have $A' = 0 \implies Q = 0 \implies \mathbf{\tau = 0}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of calculating transverse shear stress: (1) determine internal vertical shear force $V$ at the desired beam cross-section from the SFD, (2) compute total moment of inertia $I = \frac{bh^3}{12}$ for the entire cross-section about the Neutral Axis, (3) identify the level $y_1$ where shear stress is needed and isolate area $A'$ above $y_1$, (4) calculate first moment of area $Q = \bar{y}' A'$ where $\bar{y}'$ is the centroid of $A'$ to the Neutral Axis, (5) apply Jourawski formula $\tau = \frac{VQ}{Ib}$ to obtain the shear stress in Pascals!
3. **Slide 3 (`matching`):** Pair 4 concepts (Jourawski's Formula, First Moment of Area $Q$, Rectangular $\tau_{\text{max}} = 1.5 \tau_{\text{avg}}$, I-Beam Web Dominance) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Neutral. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing $\tau_{\text{max}}$ in a rectangular beam: A rectangular wooden beam of width $b = 120\text{ mm} = 0.12\text{ m}$ and height $h = 250\text{ mm} = 0.25\text{ m}$ carries an internal vertical shear force of $V = 30\text{ kN} = 30 \times 10^3\text{ N}$. What is the maximum transverse shear stress $\tau_{\text{max}}$ developed at the neutral axis? (Cross-sectional area $A = b \cdot h = (0.12\text{ m})(0.25\text{ m}) = 0.03\text{ m}^2$; average shear stress $\tau_{\text{avg}} = \frac{V}{A} = \frac{30 \times 10^3\text{ N}}{0.03\text{ m}^2} = 1.0 \times 10^6\text{ Pa} = 1.0\text{ MPa}$; maximum shear stress for a rectangular section: $\tau_{\text{max}} = \frac{3}{2} \tau_{\text{avg}} = 1.5 \times 1.0\text{ MPa} = \mathbf{1.5\text{ MPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "transverse_shear_stress_in_beams_and_jourawski_formula",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Transverse Shear Stress \\& Jourawski's Formula (Beer \\& Johnston)**\n• **Jourawski's Shear Formula Formulation:**\n$$\n\\mathbf{\\tau(y) = \\frac{V Q(y)}{I b} \\quad \\text{where } Q(y) = \\bar{y}' A' = \\int_y^c y' \\, dA'}\n$$\n• **Cross-Sectional Stress Distribution Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Cross-Section Geometry} & \\textbf{Shear Profile Shape} & \\textbf{Location of } \\tau_{\\text{max}} & \\textbf{Maximum Shear Stress } \\tau_{\\text{max}} \\\\\n\\hline\n\\mathbf{\\text{Solid Rectangle } (b \\times h)} & \\mathbf{\\text{Parabolic Curve}} & \\mathbf{\\text{Neutral Axis } (y=0)} & \\mathbf{\\tau_{\\text{max}} = \\frac{3}{2} \\frac{V}{A} = 1.5 \\, \\tau_{\\text{avg}}} \\\\\n\\mathbf{\\text{Solid Circle } (d)} & \\text{Parabolic Curve} & \\text{Neutral Axis (Centroid)} & \\mathbf{\\tau_{\\text{max}} = \\frac{4}{3} \\frac{V}{A} \\approx 1.33 \\, \\tau_{\\text{avg}}} \\\\\n\\mathbf{\\text{Structural I-Beam}} & \\text{Jump at flange-web junction} & \\text{Web Neutral Axis} & \\mathbf{\\tau_{\\text{web}} \\approx \\frac{V}{A_{\\text{web}}} \\text{ (Web takes } >90\\%)} \\\\\n\\hline\n\\end{array}\n$$\n• **Boundary Invariant:** At the top and bottom free surfaces ($y = \\pm h/2$), $A' = 0 \\implies Q = 0 \\implies \\mathbf{\\tau = 0}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the maximum transverse shear stress developed across a beam cross-section.",
      "orderItems": [
        "Determine the internal vertical shear force V at the target cross-section from the Shear Force Diagram (SFD)",
        "Calculate the total moment of inertia I of the entire cross-section with respect to the Neutral Axis",
        "Isolate the portion of the cross-sectional area A' lying above the Neutral Axis to compute peak stress",
        "Compute the first moment of area Q = y_bar_prime * A' about the Neutral Axis",
        "Apply Jourawski's formula tau_max = (V * Q) / (I * b) to calculate the peak shear stress in Pascals"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Transverse Shear Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "First Moment of Area (Q)", "right": "Q = y_bar_prime * A', measuring the area distribution above the cut relative to the Neutral Axis" },
        { "left": "Rectangular tau_max", "right": "tau_max = 1.5 * (V / A), occurring at the Neutral Axis of a rectangular cross-section" },
        { "left": "Circular tau_max", "right": "tau_max = (4/3) * (V / A), representing the peak shear stress at the diameter of a solid circular bar" },
        { "left": "I-Beam Web Dominance", "right": "Structural behavior where the thin vertical web carries over 90-95% of total transverse shear force" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a solid rectangular beam subjected to transverse shear, maximum shear stress occurs at the ___ axis.",
      "blankAnswer": "neutral",
      "blankDistractors": ["extreme", "top", "bottom"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular wooden beam of width b = 120 mm and height h = 250 mm carries an internal transverse shear force of V = 30 kN. What is the maximum transverse shear stress tau_max developed at the Neutral Axis?",
      "options": [
        { "text": "tau_max = 1.5 MPa (tau_avg = 1.0 MPa and tau_max = 1.5 * tau_avg)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Jourawski's parabolic shear distribution (Beer & Johnston *Mechanics of Materials* Chapter 6). 1. **Cross-Sectional Area $A$:** $$A = b \\cdot h = (0.120\\text{ m})(0.250\\text{ m}) = 0.030\\text{ m}^2$$ 2. **Average Shear Stress ($\\tau_{\\text{avg}}$):** $$\\tau_{\\text{avg}} = \\frac{V}{A} = \\frac{30 \\times 10^3\\text{ N}}{0.030\\text{ m}^2} = 1,000,000\\text{ Pa} = \\mathbf{1.0\\text{ MPa}}$$ 3. **Maximum Shear Stress at Neutral Axis ($\\tau_{\\text{max}}$):** - For any solid rectangular cross-section: $$\\tau_{\\text{max}} = \\frac{3}{2} \\tau_{\\text{avg}} = 1.5 \\times 1.0\\text{ MPa} = \\mathbf{1.5\\text{ MPa}}$$ 4. **Verification via $Q$ and $I$:** - $I = \\frac{b h^3}{12} = \\frac{(0.12)(0.25)^3}{12} = 0.00015625\\text{ m}^4$. - $A' = b \\times (h/2) = (0.12)(0.125) = 0.015\\text{ m}^2$; $\\bar{y}' = \\frac{h}{4} = 0.0625\\text{ m}$. - $Q = \\bar{y}' A' = (0.0625)(0.015) = 0.0009375\\text{ m}^3$. - $\\tau = \\frac{V Q}{I b} = \\frac{(30,000)(0.0009375)}{(0.00015625)(0.12)} = \\frac{28.125}{0.00001875} = \\mathbf{1,500,000\\text{ Pa} = 1.5\\text{ MPa}}$! Perfectly consistent!" },
        { "text": "tau_max = 1.0 MPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "tau_max = 3.0 MPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "tau_max = 0.75 MPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
