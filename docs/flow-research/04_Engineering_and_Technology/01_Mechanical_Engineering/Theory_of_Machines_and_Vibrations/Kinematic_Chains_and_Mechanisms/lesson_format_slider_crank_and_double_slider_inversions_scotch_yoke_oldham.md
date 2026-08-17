# Duofy Reusable Lesson Format: Slider-Crank Inversions (Quick-Return, Scotch Yoke, & Oldham)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Kinematic_Chains_and_Mechanisms`  
**Lesson Format Type:** `slider_crank_and_double_slider_inversions_scotch_yoke_oldham`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through kinematic inversions of single and double slider-crank chains in practical mechanical systems (Joseph E. Shigley et al. *Theory of Machines and Mechanisms* Chapter 1 & 2; Kenneth J. Waldron & Gary L. Kinzel Chapter 3; S.S. Rattan): master **Inversions of the Single Slider-Crank Chain** ($1\text{ Sliding Pair } + 3\text{ Revolute Pairs}$):
1. **Inversion 1 (Fixed Cylinder / Frame):** Reciprocating IC Engine & Air Compressor (rotary $\leftrightarrow$ linear);
2. **Inversion 2 (Fixed Crank Link):** **Whitworth Quick-Return Mechanism** & Rotary Gnome Aircraft Engine;
3. **Inversion 3 (Fixed Connecting Rod):** **Crank and Slotted-Lever Quick-Return Mechanism** (used in shaper and slotter machine tools; Quick Return Ratio $\mathbf{QRR = \frac{\text{Time of Cutting Stroke}}{\text{Time of Return Stroke}} = \frac{\alpha}{\beta} = \frac{360^\circ - \theta}{\theta} > 1}$) & Oscillating Cylinder Engine;
4. **Inversion 4 (Fixed Slider Piston):** Hand Pump (Bull Engine);
and master **Inversions of the Double Slider-Crank Chain** ($2\text{ Sliding Pairs } + 2\text{ Revolute Pairs}$):
1. **Elliptical Trammel (Fixed Slotted Plate):** Every point on the tracing arm traces an exact mathematical ellipse ($\frac{x^2}{a^2} + \frac{y^2}{b^2} = 1$);
2. **Scotch Yoke (Fixed Cylinder / Slider):** Converts rotary motion into pure harmonic linear motion ($\mathbf{x(t) = r \cos\omega t}$, zero secondary inertia harmonics);
3. **Oldham's Coupling (Fixed Slotted Intermediate Disc):** Transmits uniform angular velocity between two parallel shafts whose rotational axes are radially misaligned (offset).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Single & Double Slider-Crank Inversion Matrix & Quick-Return Ratio Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Stroke Length and Quick-Return Ratio for a Shaper Mechanism Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Kinematic Inversion / Industrial Mechanism & Operating Physical Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Double-Slider Inversion Used to Connect Two Parallel Shafts with Lateral Offset Misalignment Is ___ Coupling (Oldham's / Oldham) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Machine Tool Kinematics Problem: Calculating the Quick-Return Ratio (QRR) of a Shaper Slotted-Lever Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Slider-Crank Inversions (Shigley 2014; Rattan 2014):
   - **Slider-Crank Inversions Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Kinematic Chain} & \textbf{Fixed Element} & \textbf{Mechanism Name} & \textbf{Engineering Application} \\
     \hline
     \mathbf{\text{Single Slider (1P + 3R)}} & \text{Link 1 (Cylinder)} & \text{Reciprocating Engine} & \text{Automobile IC Engines} \\
     \mathbf{\text{Single Slider (1P + 3R)}} & \mathbf{\text{Link 2 (Crank)}} & \mathbf{\text{Whitworth Quick-Return}} & \text{Rotary Gnome Engine / Shapers} \\
     \mathbf{\text{Single Slider (1P + 3R)}} & \mathbf{\text{Link 3 (Connecting Rod)}} & \mathbf{\text{Crank \\& Slotted Lever}} & \mathbf{\text{Shaper Machine Cutting Stroke}} \\
     \mathbf{\text{Single Slider (1P + 3R)}} & \text{Link 4 (Slider)} & \text{Hand Pump (Bull Engine)} & \text{Deep-well manual water pumps} \\
     \hline
     \mathbf{\text{Double Slider (2P + 2R)}} & \mathbf{\text{Slotted Base Plate}} & \mathbf{\text{Elliptical Trammel}} & \text{Precision ellipse drafting} \\
     \mathbf{\text{Double Slider (2P + 2R)}} & \mathbf{\text{Slider / Frame}} & \mathbf{\text{Scotch Yoke}} & \mathbf{\text{Pure Harmonic Linear Motion (SHM)}} \\
     \mathbf{\text{Double Slider (2P + 2R)}} & \mathbf{\text{Intermediate Floating Disc}} & \mathbf{\text{Oldham's Coupling}} & \mathbf{\text{Transmits torque across offset shafts}} \\
     \hline
     \end{array}$$
   - **Quick-Return Ratio (QRR) Invariant:**
     $$\mathbf{QRR = \frac{\text{Time of Working (Cutting) Stroke}}{\text{Time of Idle (Return) Stroke}} = \frac{\alpha}{\beta} = \frac{360^\circ - \theta}{\theta} > 1}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of analyzing a crank & slotted lever quick-return: (1) measure crank length $r$ and distance between fixed centers $d$ ($d > r$), (2) determine extreme tangent positions where crank is perpendicular to slotted lever ($\cos(\theta/2) = r/d$), (3) compute return stroke crank angle $\theta = 2 \cos^{-1}(r/d)$ and forward cutting angle $\alpha = 360^\circ - \theta$, (4) calculate Quick-Return Ratio $QRR = \frac{\alpha}{\theta}$, (5) compute tool stroke length $L_{\text{stroke}} = 2 R \frac{r}{d}$ where $R$ is the length of the slotted lever to the ram pin!
3. **Slide 3 (`matching`):** Pair 4 concepts (Scotch Yoke, Oldham's Coupling, Elliptical Trammel, Crank & Slotted Lever) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Oldham's (or Oldham). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Quick-Return Ratio: In a crank and slotted-lever quick-return mechanism for a metal shaper, the driving crank length is $r = 100\text{ mm}$ and the distance between the fixed centers is $d = 200\text{ mm}$. What is the Quick-Return Ratio ($QRR$) of this machine tool? ($\cos(\theta/2) = \frac{r}{d} = \frac{100}{200} = 0.5 \implies \theta/2 = 60^\circ \implies \theta = 120^\circ$ (return angle); Working cutting stroke angle $\alpha = 360^\circ - 120^\circ = 240^\circ$; Quick-Return Ratio $QRR = \frac{\alpha}{\theta} = \frac{240^\circ}{120^\circ} = \mathbf{2.0}$; the idle return stroke takes exactly half the time of the cutting stroke, doubling machining productivity!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "slider_crank_and_double_slider_inversions_scotch_yoke_oldham",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Slider-Crank \\& Double-Slider Inversions (Shigley \\& Rattan)**\n• **Single Slider-Crank Inversions (1 Sliding + 3 Revolute Pairs):**\n  - **Inversion 1 (Fixed Cylinder):** Reciprocating IC Engine \\& Compressor;\n  - **Inversion 2 (Fixed Crank):** Whitworth Quick-Return \\& Rotary Engine;\n  - **Inversion 3 (Fixed Connecting Rod):** **Crank and Slotted-Lever Quick-Return** \\& Oscillating Cylinder;\n  - **Inversion 4 (Fixed Slider):** Hand Pump (Bull Engine)!\n• **Double Slider-Crank Inversions (2 Sliding + 2 Revolute Pairs):**\n  - **Elliptical Trammel:** Fixed slotted guide plate; trammel arm traces exact mathematical ellipses;\n  - **Scotch Yoke:** Fixed frame; converts uniform rotation to **pure sinusoidal linear harmonic motion ($x = r \\cos\\omega t$)**;\n  - **Oldham's Coupling:** Fixed intermediate link; **transmits torque between parallel shafts with lateral axis offset**!\n• **The Quick-Return Ratio Invariant:**\n$$\n\\mathbf{QRR = \\frac{\\text{Cutting Stroke Time}}{\\text{Return Stroke Time}} = \\frac{\\alpha}{\\beta} = \\frac{360^\\circ - \\theta}{\\theta} > 1 \\quad \\left(\\cos\\frac{\\theta}{2} = \\frac{r_{\\text{crank}}}{d_{\\text{center}}}\\right)}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the Quick-Return Ratio (QRR) and stroke length of a shaper machine slotted-lever mechanism.",
      "orderItems": [
        "Record the driving crank length r and the center-to-center distance d between the crank axis and lever pivot (d > r)",
        "Identify the extreme limiting tangent positions where the driving crank is perpendicular to the slotted lever",
        "Calculate the half-angle of the idle return stroke using the trigonometric relation cos(theta / 2) = r / d",
        "Compute the full return angle theta = 2*cos^-1(r/d) and forward cutting stroke angle alpha = 360° - theta",
        "Evaluate the Quick-Return Ratio QRR = alpha / theta and calculate tool ram stroke length: Stroke = 2 * R_lever * (r / d)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Kinematic Inversion to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Scotch Yoke Mechanism", "right": "Double-slider inversion producing pure sinusoidal simple harmonic motion without secondary harmonics" },
        { "left": "Oldham's Coupling", "right": "Double-slider inversion transmitting constant velocity ratio between laterally offset parallel shafts" },
        { "left": "Elliptical Trammel", "right": "Double-slider inversion where points on the rigid connecting link trace out pure geometric ellipses" },
        { "left": "Crank and Slotted Lever", "right": "Single-slider inversion where fixed connecting rod provides rapid non-cutting tool return in shapers" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The double-slider inversion used to transmit torque between laterally offset parallel shafts is ___ coupling.",
      "blankAnswer": "Oldham's",
      "blankDistractors": ["Hooke's", "Borda's", "Euler's"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a crank and slotted-lever quick-return mechanism for a metal shaper, the driving crank length is r = 100 mm and the fixed center distance is d = 200 mm. What is the Quick-Return Ratio (QRR) of this machine tool?",
      "options": [
        { "text": "QRR = 2.0 (The cutting stroke angle is 240° and the return stroke angle is 120°, giving QRR = 240 / 120 = 2.0)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using quick-return geometry (Shigley *Theory of Machines and Mechanisms* Chapter 2; S.S. Rattan *Theory of Machines*). 1. **Calculate the Extreme Tangent Angle ($\\theta/2$):** - In the extreme positions of the slotted lever, the crank is tangent to the lever path (forming a right triangle). - $$\\cos\\left(\\frac{\\theta}{2}\\right) = \\frac{r_{\\text{crank}}}{d_{\\text{center}}} = \\frac{100\\text{ mm}}{200\\text{ mm}} = 0.5$$ - $$\\frac{\\theta}{2} = \\cos^{-1}(0.5) = 60^\\circ \\implies \\theta = 2 \\times 60^\\circ = \\mathbf{120^\\circ}$$ 2. **Calculate the Working (Cutting) Stroke Angle ($\\alpha$):** - $$\\alpha = 360^\\circ - \\theta = 360^\\circ - 120^\\circ = \\mathbf{240^\\circ}$$ 3. **Evaluate the Quick-Return Ratio ($QRR$):** - $$QRR = \\frac{\\text{Time of Cutting Stroke}}{\\text{Time of Return Stroke}} = \\frac{\\alpha}{\\theta} = \\frac{240^\\circ}{120^\\circ} = \\mathbf{2.0}$$ 4. **Productivity Benefit:** The idle non-cutting return stroke happens **twice as fast** as the heavy cutting stroke, maximizing machine tool cutting throughput!" },
        { "text": "QRR = 1.5", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "QRR = 3.0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "QRR = 1.0 (Equal stroke times)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
