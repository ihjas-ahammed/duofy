# Duofy Reusable Lesson Format: Beam Diagrams (Shear Force SFD and Bending Moment BMD)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Bending_Moments_and_Shear_Force`  
**Lesson Format Type:** `shear_force_and_bending_moment_diagrams_sfd_and_bmd`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through internal shear and moment distribution along beams, differential calculus relationships, and graphical diagram construction in solid mechanics (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 5; Russell C. Hibbeler *Mechanics of Materials* Chapter 6): master the fundamental differential equilibrium equations: **$\mathbf{\frac{dV}{dx} = -w(x)}$** (the slope of the Shear Force Diagram at any coordinate equals the negative intensity of the distributed load) and **$\mathbf{\frac{dM}{dx} = V(x)}$** (the slope of the Bending Moment Diagram equals the shear force value), master the **Area Integration Theorem ($\mathbf{M(x_2) - M(x_1) = \int_{x_1}^{x_2} V(x) \, dx}$)** (the change in bending moment between two cross-sections equals the area under the SFD between those points), prove why **Maximum/Minimum Bending Moments occur exactly where Shear Force equals zero ($V = 0$) or changes sign**, and analyze jump discontinuities created by concentrated point forces and point couple moments.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Differential Equilibrium Equations ($\frac{dV}{dx} = -w, \frac{dM}{dx} = V$) & Graphical Slope Laws Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Construction of an SFD and BMD from Support Reactions to Maximum Moment Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Beam Loading Feature / Diagram Characteristic & Technical Mathematical Representation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Bending Moment in a Beam Reaches Its Local Maximum or Minimum at the Cross-Section Where the Shear Force Is ___ (Zero / 0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Mechanics Problem: Calculating the Maximum Bending Moment of a Simply Supported Beam Under UDL Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SFD & BMD Calculus (Beer & Johnston 2020; Hibbeler 2018):
   - **Differential Relations & Geometric Slope Invariants:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Applied Load } w(x) & \textbf{Shear Force Curve } V(x) & \textbf{Bending Moment Curve } M(x) & \textbf{Mathematical Derivative} \\
     \hline
     \mathbf{\text{No Load } (w = 0)} & \mathbf{\text{Horizontal Line (Constant)}} & \mathbf{\text{Inclined Linear Line (1st Order)}} & \frac{dV}{dx} = 0, \ \frac{dM}{dx} = V \\
     \mathbf{\text{Uniform Load (UDL } w\text{)}} & \mathbf{\text{Sloped Line (Linear 1st Order)}} & \mathbf{\text{Parabolic Curve (Quadratic 2nd Order)}} & \frac{dV}{dx} = -w, \ \frac{dM}{dx} = V(x) \\
     \mathbf{\text{Triangular Load (UVL)}} & \text{Parabolic (2nd Order)} & \text{Cubic Curve (3rd Order)} & \frac{dV}{dx} = -kx \\
     \hline
     \end{array}$$
   - **Discontinuity Invariants:**
     - A downward point load $P$ creates an **instantaneous downward vertical drop of magnitude $P$** in the SFD.
     - A clockwise concentrated couple moment $M_0$ creates an **instantaneous vertical upward jump of magnitude $M_0$** in the BMD.
2. **Slide 2 (`ordering`):** Provide 5 steps of constructing SFD and BMD: (1) determine all external support reactions using global static equilibrium $\sum F_y = 0, \sum M = 0$, (2) start at left end $x=0$, plotting $V(x)$ by adding upward reaction forces and subtracting downward loads, (3) locate points where the shear force curve crosses the zero-axis ($V(x) = 0$), (4) calculate the bending moment at critical points by integrating the area under the SFD: $M(x) = \int V \, dx$, (5) connect moment points using smooth curves matching slope rules ($\text{slope} = V$), confirming $M_{\text{max}}$ occurs at $V=0$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Slope of SFD, Slope of BMD, Area Under SFD, Point Load in SFD) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Zero (or 0). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on simply supported beam under UDL: A simply supported beam of span $L = 8\text{ m}$ carries a uniformly distributed load (UDL) of $w = 5\text{ kN/m}$ across its entire span. What is the maximum bending moment $M_{\text{max}}$ developed in the beam, and where does it occur? (Support reactions: $A_y = B_y = \frac{w L}{2} = \frac{(5)(8)}{2} = 20\text{ kN}$; Shear force equation: $V(x) = A_y - w x = 20 - 5x$; setting $V(x) = 0 \implies 20 - 5x = 0 \implies \mathbf{x = 4\text{ m (midspan)}}$; maximum bending moment occurs at $x = 4\text{ m}$: $M_{\text{max}} = \frac{w L^2}{8} = \frac{(5\text{ kN/m})(8\text{ m})^2}{8} = \frac{5 \times 64}{8} = \mathbf{40\text{ kN}\cdot\text{m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "shear_force_and_bending_moment_diagrams_sfd_and_bmd",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Differential Equilibrium of Beams \\& SFD/BMD Calculus (Beer \\& Johnston)**\n• **Differential Relations \\& Slope Invariants:**\n$$\n\\mathbf{\\frac{dV}{dx} = -w(x) \\quad \\Big| \\quad \\frac{dM}{dx} = V(x) \\quad \\Big| \\quad M(x_2) - M(x_1) = \\int_{x_1}^{x_2} V(x) \\, dx}\n$$\n• **Loading Mode vs Curve Order Hierarchy:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Loading Condition } w(x) & \\textbf{Shear Curve } V(x) & \\textbf{Moment Curve } M(x) & \\textbf{Geometric Relationship} \\\\\n\\hline\n\\mathbf{\\text{Zero Load } (w=0)} & \\mathbf{\\text{Horizontal (Degree 0)}} & \\mathbf{\\text{Linear Slope (Degree 1)}} & \\text{Slope}(M) = \\text{Constant } V \\\\\n\\mathbf{\\text{Uniform UDL } (w)} & \\mathbf{\\text{Linear Slope (Degree 1)}} & \\mathbf{\\text{Parabolic (Degree 2)}} & \\text{Slope}(V) = -w \\\\\n\\mathbf{\\text{Triangular UVL}} & \\text{Parabolic (Degree 2)} & \\text{Cubic (Degree 3)} & \\text{Curved moment profile} \\\\\n\\hline\n\\end{array}\n$$\n• **The Extreme Moment Invariant:** The bending moment reaches a mathematical maximum or minimum **EXACTLY where the shear force crosses zero ($\\mathbf{V = 0}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct the Shear Force Diagram (SFD) and Bending Moment Diagram (BMD) of a loaded structural beam.",
      "orderItems": [
        "Calculate all external vertical support reactions and couple moments using global static equilibrium (sum Fy = 0, sum M = 0)",
        "Construct the SFD from left to right, inserting vertical step jumps at concentrated point loads and sloped lines under UDLs",
        "Identify and solve the exact x-coordinates where the shear force diagram crosses the zero axis (V(x) = 0)",
        "Compute the bending moment at key points by integrating the cumulative area under the Shear Force Diagram (delta M = integral V dx)",
        "Sketch the BMD connecting critical points with curves matching the slope rule (slope = V), plotting M_max at V=0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Beam Diagram Calculus Relationship to its exact Mathematical Expression.",
      "matchPairs": [
        { "left": "Slope of the SFD (dV/dx)", "right": "Equal to the negative intensity of the distributed load (-w)" },
        { "left": "Slope of the BMD (dM/dx)", "right": "Equal to the magnitude of the internal shear force V(x)" },
        { "left": "Area under the SFD", "right": "Equal to the net change in bending moment (M2 - M1) between two cross-sections" },
        { "left": "Maximum Bending Moment Location", "right": "Occurs precisely at the cross-section where the shear force passes through zero (V = 0)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The bending moment in a structural beam reaches its local maximum or minimum at the cross-section where the shear force is ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["maximum", "positive", "infinite"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A simply supported beam of span L = 8 m carries a uniformly distributed load (UDL) of w = 5 kN/m across its entire span. What is the maximum bending moment M_max developed in the beam, and where does it occur?",
      "options": [
        { "text": "M_max = 40 kN·m at the midspan (x = 4 m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using beam equilibrium calculus (Beer & Johnston *Mechanics of Materials* Chapter 5). 1. **Support Reactions:** - By symmetry: $A_y = B_y = \\frac{w L}{2} = \\frac{(5\\text{ kN/m})(8\\text{ m})}{2} = \\mathbf{20\\text{ kN}}$. 2. **Shear Force Function $V(x)$:** $$V(x) = A_y - w x = 20 - 5x$$ 3. **Location of Zero Shear ($V = 0$):** $$20 - 5x = 0 \\implies 5x = 20 \\implies \\mathbf{x = 4\\text{ m (Midspan)}}$$ 4. **Maximum Bending Moment $M_{\\text{max}}$:** - Using the canonical UDL formula: $$M_{\\text{max}} = \\frac{w L^2}{8} = \\frac{(5\\text{ kN/m})(8\\text{ m})^2}{8} = \\frac{5 \\times 64}{8} = 5 \\times 8 = \\mathbf{40\\text{ kN}\\cdot\\text{m}}$$ - Or via area under the SFD from $x=0$ to $x=4$: $$\\text{Area} = \\frac{1}{2} \\times \\text{base} \\times \\text{height} = \\frac{1}{2} \\times (4\\text{ m}) \\times (20\\text{ kN}) = \\mathbf{40\\text{ kN}\\cdot\\text{m}}$$ Flawless and rapid beam design analysis!" },
        { "text": "M_max = 20 kN·m at x = 2 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "M_max = 80 kN·m at x = 8 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "M_max = 320 kN·m at the support", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
