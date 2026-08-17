# Duofy Reusable Lesson Format: Orthogonal Cutting (Merchant's Circle & Shear Mechanics)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / CNC_Machining_and_Tool_Life`  
**Lesson Format Type:** `merchants_circle_cutting_forces_and_shear_angle_mechanics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through 2D orthogonal metal cutting physics, continuous shear zone plasticity, Merchant's circle force diagram, and shear plane angle determination in manufacturing engineering (M. Eugene Merchant 1944; Serope Kalpakjian & Steven R. Schmid *Manufacturing Engineering and Technology* Chapter 21; Mikell P. Groover *Fundamentals of Modern Manufacturing* Chapter 21): master the **Chip Thickness Ratio ($\mathbf{r_c = \frac{t_0}{t_c} \le 1.0}$)** and the exact **Shear Plane Angle Equation**:
$$\mathbf{\tan\phi = \frac{r_c \cos\alpha}{1 - r_c \sin\alpha}}$$
where $\alpha$ is the tool orthogonal rake angle; master **Merchant's First Minimum Power Theory**:
$$\mathbf{\phi = 45^\circ + \frac{\alpha}{2} - \frac{\beta}{2} \quad \left(\beta = \tan^{-1}\mu = \text{Friction Angle}\right)}$$
(proving that increasing the tool rake angle $\alpha$ or reducing chip-tool interface friction $\mu$ increases shear angle $\phi$, reducing shear plane area and drastically slashing total cutting power); and master **Merchant's Force Vector Transformations**:
$$\mathbf{F_s = F_c \cos\phi - F_t \sin\phi \quad \Big| \quad F = F_c \sin\alpha + F_t \cos\alpha \quad \Big| \quad \mu = \tan\beta = \frac{F}{N} = \frac{F_t + F_c \tan\alpha}{F_c - F_t \tan\alpha}}$$
where $F_c$ is primary tangential cutting force and $F_t$ is feed thrust force measured by a tool dynamometer.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Shear Angle Equation ($\tan\phi = \frac{r_c \cos\alpha}{1-r_c \sin\alpha}$) & Merchant's Force Circle Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Shear Angle, Shear Force, and Friction Coefficient Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Metal Cutting Force Vector / Geometry Entity & Technical Physical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Primary Plane Along Which Workpiece Metal Undergoes Severe Plastic Shear Strain into a Chip Is the ___ Plane (Shear) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Machining Mechanics Problem: Calculating the Shear Plane Angle \phi in an Orthogonal Turning Operation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Merchant's Orthogonal Cutting (Kalpakjian 2020; Merchant 1944):
   - **Shear Angle Formulations:**
     $$\mathbf{\tan\phi = \frac{r_c \cos\alpha}{1 - r_c \sin\alpha} \quad \Big| \quad r_c = \frac{t_0}{t_c} \quad \Big| \quad \phi = 45^\circ + \frac{\alpha}{2} - \frac{\beta}{2}}$$
   - **Merchant's Circle Force Transformation Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Force Component} & \textbf{Symbol} & \textbf{Merchant Vector Formulation} \\
     \hline
     \mathbf{\text{Tangential Cutting Force}} & \mathbf{F_c} & \text{Measured directly by lathe dynamometer (in direction of } v) \\
     \mathbf{\text{Thrust (Feed) Force}} & \mathbf{F_t} & \text{Measured perpendicular to cutting velocity } v \\
     \mathbf{\text{Shear Plane Force}} & \mathbf{F_s} & \mathbf{F_s = F_c \cos\phi - F_t \sin\phi} \\
     \mathbf{\text{Friction Force (Rake Face)}} & \mathbf{F} & \mathbf{F = F_c \sin\alpha + F_t \cos\alpha} \\
     \mathbf{\text{Normal Force (Rake Face)}} & \mathbf{N} & \mathbf{N = F_c \cos\alpha - F_t \sin\alpha} \\
     \hline
     \end{array}$$
   - **The Chip Ratio Invariant:** Because metal plastic compression always thickens the chip ($t_c > t_0$), the chip thickness ratio is **ALWAYS less than or equal to unity ($\mathbf{r_c \le 1.0}$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of orthogonal cutting force analysis: (1) measure uncut chip thickness $t_0$, cut chip thickness $t_c$, and tool rake angle $\alpha$, (2) calculate chip thickness ratio $r_c = t_0/t_c$, (3) compute shear plane angle $\phi = \tan^{-1}\left(\frac{r_c \cos\alpha}{1 - r_c \sin\alpha}\right)$, (4) record dynamometer readings for cutting force $F_c$ and thrust force $F_t$, (5) calculate shear force $F_s = F_c \cos\phi - F_t \sin\phi$ and friction coefficient $\mu = \frac{F_t + F_c \tan\alpha}{F_c - F_t \tan\alpha}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Shear Plane Angle $\phi$, Chip Thickness Ratio $r_c$, Friction Force $F$, Merchant's Minimum Power Law) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Shear. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating shear angle: In an orthogonal machining test, uncut chip thickness is $t_0 = 0.25\text{ mm}$ and the deformed chip thickness is measured as $t_c = 0.50\text{ mm}$. The cutting tool has a rake angle $\alpha = +10^\circ$. What is the shear plane angle $\phi$? ($r_c = \frac{t_0}{t_c} = \frac{0.25}{0.50} = \mathbf{0.50}$; $\cos(10^\circ) = 0.9848$, $\sin(10^\circ) = 0.1736$; $\tan\phi = \frac{0.50 (0.9848)}{1 - 0.50 (0.1736)} = \frac{0.4924}{1 - 0.0868} = \frac{0.4924}{0.9132} \approx \mathbf{0.5392}$; $\phi = \tan^{-1}(0.5392) \approx \mathbf{28.33^\circ} \approx \mathbf{28.3^\circ}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "merchants_circle_cutting_forces_and_shear_angle_mechanics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Merchant's Orthogonal Cutting Mechanics (M. Eugene Merchant 1944)**\n• **Chip Thickness Ratio \\& Shear Plane Angle Formulations:**\n$$\n\\mathbf{r_c = \\frac{t_0}{t_c} \\le 1.0 \\quad \\Big| \\quad \\mathbf{\\tan\\phi = \\frac{r_c \\cos\\alpha}{1 - r_c \\sin\\alpha}}}\n$$\n• **Merchant's Minimum Cutting Energy Principle:**\n$$\n\\mathbf{\\phi = 45^\\circ + \\frac{\\alpha}{2} - \\frac{\\beta}{2} \\quad (\\alpha = \\text{Rake Angle}, \\ \\beta = \\text{Friction Angle} = \\tan^{-1}\\mu)}\n$$\n• **Merchant's Force Vector Transformations:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Force Vector} & \\textbf{Symbol} & \\textbf{Trigonometric Transformation} \\\\\n\\hline\n\\mathbf{\\text{Shear Plane Force}} & \\mathbf{F_s} & \\mathbf{F_s = F_c \\cos\\phi - F_t \\sin\\phi} \\\\\n\\mathbf{\\text{Normal Shear Force}} & \\mathbf{F_n} & \\mathbf{F_n = F_c \\sin\\phi + F_t \\cos\\phi} \\\\\n\\mathbf{\\text{Tool Rake Friction}} & \\mathbf{F} & \\mathbf{F = F_c \\sin\\alpha + F_t \\cos\\alpha} \\\\\n\\mathbf{\\text{Rake Normal Force}} & \\mathbf{N} & \\mathbf{N = F_c \\cos\\alpha - F_t \\sin\\alpha} \\\\\n\\hline\n\\end{array}\n$$\n• **The Chip Ratio Invariant:** Due to severe plastic compression in the primary shear zone, $t_c > t_0 \\implies \\mathbf{r_c \\le 1.0}$ always!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate the shear plane angle and resolve cutting forces using Merchant's circle equations.",
      "orderItems": [
        "Measure the uncut chip thickness t0, cut chip thickness tc, and cutting tool rake angle alpha",
        "Calculate the chip thickness ratio: r_c = t0 / tc",
        "Compute the shear plane angle using: tan(phi) = (r_c * cos(alpha)) / (1 - r_c * sin(alpha))",
        "Record cutting force Fc and thrust force Ft measured by a multi-axis lathe tool dynamometer",
        "Calculate the shear force along the shear plane Fs = Fc*cos(phi) - Ft*sin(phi) and rake friction coefficient mu"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Orthogonal Cutting Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Shear Plane Angle (\u03c6)", "right": "tan(\u03c6) = (rc*cos\u03b1) / (1 - rc*sin\u03b1), the orientation of the primary deformation shear plane" },
        { "left": "Chip Thickness Ratio (rc)", "right": "rc = t0 / tc, ratio of undeformed feed thickness to actual curled chip thickness" },
        { "left": "Shear Force (Fs)", "right": "Fs = Fc*cos(\u03c6) - Ft*sin(\u03c6), the pure shear force driving plastic flow across the shear plane" },
        { "left": "Merchant's Minimum Power Law", "right": "\u03c6 = 45° + \u03b1/2 - \u03b2/2, theoretical shear angle that minimizes required cutting energy" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The primary angled plane along which uncut metal undergoes severe plastic shear deformation into a chip is the ___ plane.",
      "blankAnswer": "shear",
      "blankDistractors": ["rake", "clearance", "flank"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In an orthogonal turning test, the uncut chip thickness is t0 = 0.25 mm and the cut chip thickness is tc = 0.50 mm. The tool has a positive rake angle \u03b1 = +10°. What is the shear plane angle \u03c6?",
      "options": [
        { "text": "\u03c6 = 28.33° (Chip ratio rc = 0.25/0.50 = 0.50, and tan(\u03c6) = (0.50 * cos(10°)) / (1 - 0.50 * sin(10°)) = 0.4924 / 0.9132 = 0.5392)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Merchant's shear angle relation (Serope Kalpakjian *Manufacturing Engineering and Technology* Chapter 21). 1. **Calculate Chip Thickness Ratio ($r_c$):** $$r_c = \\frac{t_0}{t_c} = \\frac{0.25\\text{ mm}}{0.50\\text{ mm}} = \\mathbf{0.50}$$ 2. **Evaluate Trigonometric Terms for $\\alpha = 10^\\circ$:** - $\\cos(10^\\circ) \\approx 0.984808$. - $\\sin(10^\\circ) \\approx 0.173648$. 3. **Apply the Shear Angle Formula:** $$\\tan\\phi = \\frac{r_c \\cos\\alpha}{1 - r_c \\sin\\alpha} = \\frac{0.50 \\times 0.984808}{1 - (0.50 \\times 0.173648)} = \\frac{0.492404}{1 - 0.086824} = \\frac{0.492404}{0.913176} \\approx \\mathbf{0.539221}$$ 4. **Solve for $\\phi$:** $$\\phi = \\tan^{-1}(0.539221) \\approx \\mathbf{28.334^\\circ \\approx 28.33^\\circ}$$ 5. **Physical Meaning:** A shear angle of $28.3^\\circ$ means plastic deformation occurs over a relatively short shear zone, ensuring stable continuous chip formation!" },
        { "text": "\u03c6 = 26.57° (tan(\u03c6) = 0.50, ignoring rake angle)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c6 = 45.00°", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c6 = 14.17°", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
