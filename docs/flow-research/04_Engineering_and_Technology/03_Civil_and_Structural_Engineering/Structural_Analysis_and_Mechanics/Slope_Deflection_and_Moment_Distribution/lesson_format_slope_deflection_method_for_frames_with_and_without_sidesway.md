# Duofy Reusable Lesson Format: Frame Analysis (Slope-Deflection & Sidesway Equilibrium)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Slope_Deflection_and_Moment_Distribution`  
**Lesson Format Type:** `slope_deflection_method_for_frames_with_and_without_sidesway`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural analysis of rigid planar building frames using the Slope-Deflection Method, classifying frames without sidesway (symmetric geometry + symmetric vertical loading, or unyielding lateral bracing) versus unbraced frames subjected to **Sidesway ($\Delta \ne 0$)** caused by lateral wind/seismic loads or structural asymmetry, and deriving the fundamental **Story Shear Equilibrium Equation ($\sum F_x = 0$)** (Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 11; Aslam Kassimali *Structural Analysis* 6th ed. Chapter 14): formulate the **Column Chord Rotation under Horizontal Sway ($\Delta$)**:
$$\mathbf{\psi_{\text{col}} = \frac{\Delta}{h_{\text{story}}} \implies \mathbf{M_{\text{col}} = \text{FEM} + \frac{2 E I}{h} \left( 2 \theta_{\text{near}} + \theta_{\text{far}} - 3 \frac{\Delta}{h} \right)}}$$
master the **Story Shear Equilibrium Equation**:
- Isolate the individual column members of the story and sum horizontal forces:
  $$\mathbf{V_{\text{col},1} = \frac{M_{AB} + M_{BA}}{h} \quad \Big| \quad V_{\text{col},2} = \frac{M_{DC} + M_{CD}}{h}}$$
  $$\mathbf{\sum F_x = 0 \implies \mathbf{V_{\text{col},1} + V_{\text{col},2} + P_{\text{lateral}} = 0 \Longleftrightarrow \frac{M_{AB} + M_{BA}}{h} + \frac{M_{DC} + M_{CD}}{h} + P_{\text{lateral}} = 0}}}$$
combine the $N_{\text{joints}}$ Joint Moment Equilibrium equations ($\sum M_j = 0$) with the $N_{\text{stories}}$ Story Shear equations ($\sum F_x = 0$) to solve the complete coupled linear matrix system for both joint rotations $\mathbf{\theta}$ and lateral story sway translations $\mathbf{\Delta}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Frame Sidesway ($\psi = \Delta/h$), Column Slope-Deflection & Story Shear ($\sum F_x = 0$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Formulate Joint Equilibrium and Story Shear for a Sway Portal Frame Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Frame Condition / Structural Parameter & Technical Mechanical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In an Unbraced Rigid Frame with One Story, the Additional Equilibrium Equation Required to Solve for Lateral Sway $\Delta$ Is the Story ___ Equation (Shear / Horizontal Shear) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High-Rise Structural Problem: Formulating the Story Shear Equation for a Lateral Wind Load on a Portal Frame Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Frame Sidesway & Story Shear (Maney 1915; Hibbeler 2018):
   - **Sidesway & Story Shear Formulations:**
     $$\mathbf{\psi = \frac{\Delta}{h} \quad \Big| \quad M_{\text{col}} = \text{FEM} + \frac{2EI}{h}\left(2\theta_1 + \theta_2 - 3\frac{\Delta}{h}\right) \quad \Big| \quad \frac{M_{AB} + M_{BA}}{h} + \frac{M_{DC} + M_{CD}}{h} + P_x = 0}$$
   - **Sidesway Classification Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Frame Configuration} & \textbf{Loading Type} & \textbf{Lateral Sidesway } \Delta & \textbf{Unknowns Required} \\
     \hline
     \mathbf{\text{Symmetric Geometry \& Support}} & \text{Symmetric vertical gravity only} & \mathbf{\Delta = 0 \ (\text{No Sidesway})}} & \text{Rotations } \theta_B, \theta_C \text{ only} \\
     \mathbf{\text{Asymmetric Geometry / Loading}} & \text{Any vertical load} & \mathbf{\Delta \ne 0 \ (\text{Sidesway Active})}} & \text{Rotations } \theta + \text{Sway } \Delta \\
     \mathbf{\text{Lateral Wind / Seismic Load}} & \text{Horizontal force } P_x & \mathbf{\Delta \ne 0 \ (\text{Sidesway Active})}} & \text{Rotations } \theta + \text{Sway } \Delta \ (\sum F_x = 0) \\
     \hline
     \end{array}$$
   - **The Column Shear Invariant:** For a column of height $h$, horizontal base shear is **strictly equal to $\frac{M_{\text{top}} + M_{\text{bottom}}}{h}$**; summing column shears across the entire story yields the indispensable extra equation needed to solve lateral sway $\Delta$!
2. **Slide 2 (`ordering`):** Provide 5 steps of frame sidesway analysis: (1) identify kinematic unknowns: joint rotations $\theta_B, \theta_C$ and lateral sway $\Delta$, (2) write column slope-deflection equations including $-3\Delta/h$ chord rotation terms, (3) write beam slope-deflection equations without chord rotation ($\psi_{\text{beam}} = 0$), (4) apply joint moment equilibrium $\sum M_B = 0$ and $\sum M_C = 0$, (5) formulate the story shear equation $\sum F_x = 0 \implies \frac{M_{AB}+M_{BA}}{h} + \frac{M_{DC}+M_{CD}}{h} + P_x = 0$ to solve the coupled $3\times 3$ system!
3. **Slide 3 (`matching`):** Pair 4 concepts (Story Shear Equation, Column Chord Rotation $\psi = \Delta/h$, Symmetric No-Sway Condition, Rigid Frame Joint Equilibrium) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Shear (or Horizontal Shear). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on formulating story shear equation: A portal frame with columns $AB$ and $DC$ (height $h = 4.0\text{ m}$, flexural rigidity $EI$) is subjected to a lateral wind force $P = 20.0\text{ kN}$ pushing to the right at top joint $B$. What is the correct horizontal story shear equilibrium equation relating the column end moments to the applied lateral load? (Isolating the columns: horizontal column shears are $V_1 = \frac{M_{AB} + M_{BA}}{4.0}$ and $V_2 = \frac{M_{DC} + M_{CD}}{4.0}$; applying horizontal equilibrium $\sum F_x = 0$ to the top girder gives $\mathbf{\frac{M_{AB} + M_{BA}}{4.0} + \frac{M_{DC} + M_{CD}}{4.0} + 20.0 = 0 \Longleftrightarrow M_{AB} + M_{BA} + M_{DC} + M_{CD} + 80.0 = 0}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "slope_deflection_method_for_frames_with_and_without_sidesway",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Frame Sidesway \\& Story Shear Equilibrium (Russell Hibbeler)**\n• **Column Slope-Deflection with Sidesway Displacement ($\\Delta$):**\n$$\n\\mathbf{M_{\\text{col}} = \\text{FEM} + \\frac{2 E I}{h} \\left( 2 \\theta_{\\text{near}} + \\theta_{\\text{far}} - 3 \\frac{\\Delta}{h} \\right) \\quad \\left(\\psi_{\\text{col}} = \\frac{\\Delta}{h}\\right)}\n$$\n• **The Story Shear Equilibrium Formulation:**\n  - In an unbraced frame with unknown lateral sway $\\Delta$, joint moment equations ($\\sum M_j = 0$) provide $N$ equations for $N+1$ unknowns;\n  - The necessary additional independent equation is obtained from **Horizontal Story Shear Equilibrium ($\\sum F_x = 0$)**:\n$$\n\\mathbf{\\sum F_x = 0 \\implies \\frac{M_{AB} + M_{BA}}{h_1} + \\frac{M_{DC} + M_{CD}}{h_2} + P_{\\text{lateral}} = 0}\n$$\n• **The Sidesway Symmetry Invariant:** If a frame possesses perfectly symmetric geometry, equal column stiffnesses, symmetric support conditions, and purely symmetric vertical loads, lateral sidesway is **strictly ZERO ($\\Delta = 0$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve an unbraced rigid frame undergoing lateral sidesway using Slope-Deflection.",
      "orderItems": [
        "Identify kinematic degrees of freedom: joint rotations (\u03b8_B, \u03b8_C) and lateral story sway translation (\u0394)",
        "Formulate column slope-deflection equations containing the -3*(\u0394/h) chord rotation terms",
        "Formulate horizontal girder slope-deflection equations with zero chord rotation (\u03c8_beam = 0)",
        "Enforce joint moment equilibrium equations at each continuous rigid joint: \u2211M_B = 0 and \u2211M_C = 0",
        "Formulate the horizontal story shear equation \u2211Fx = 0 and solve the combined system of equations for all \u03b8 and \u0394"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Frame Mechanics Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Story Shear Equation", "right": "\u2211Fx = 0, equilibrium of horizontal column shears providing the additional equation to solve lateral sway \u0394" },
        { "left": "Column Chord Rotation (\u03c8)", "right": "\u03c8 = \u0394 / h, angular rotation of the vertical column axis caused by horizontal lateral drift" },
        { "left": "Symmetric No-Sway Rule", "right": "Symmetric frame under symmetric vertical gravity load produces zero lateral displacement (\u0394 = 0)" },
        { "left": "Rigid Joint Constraint", "right": "Preserves 90\u00b0 angle between intersecting beam and column during joint rotation" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an unbraced rigid frame, the additional equilibrium equation required to solve for lateral story sway \u0394 is the story ___ equation.",
      "blankAnswer": "shear",
      "blankDistractors": ["moment", "axial", "torsion"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular portal frame has two vertical columns AB and DC of height h = 4.0 m and flexural rigidity EI. A horizontal wind force P = 20.0 kN pushes to the right at top joint B. What is the correct horizontal story shear equilibrium equation relating column end moments to the lateral load?",
      "options": [
        { "text": "(M_AB + M_BA)/4.0 + (M_DC + M_CD)/4.0 + 20.0 = 0 (or M_AB + M_BA + M_DC + M_CD + 80.0 = 0) (Summing horizontal forces on the top girder isolates column shears: V1 = (M_AB+M_BA)/4.0 and V2 = (M_DC+M_CD)/4.0; \u2211Fx = 0 enforces V1 + V2 + 20 = 0)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using frame story shear mechanics (Russell C. Hibbeler *Structural Analysis* Chapter 11). 1. **Isolate Column $AB$ Free Body Diagram:** - Column $AB$ has height $h = 4.0\\text{ m}$. - End moments acting on the column: $M_{AB}$ at bottom and $M_{BA}$ at top (assumed clockwise). - Taking moments about base $A$: $$\\sum M_A = 0 \\implies M_{AB} + M_{BA} - V_1 \\times 4.0\\text{ m} = 0 \\implies V_1 = \\frac{M_{AB} + M_{BA}}{4.0\\text{ m}}$$ 2. **Isolate Column $DC$ Free Body Diagram:** - Similarly, for right column $DC$ of height $4.0\\text{ m}$: $$V_2 = \\frac{M_{DC} + M_{CD}}{4.0\\text{ m}}$$ 3. **Isolate Top Girder $BC$ and Enforce Horizontal Equilibrium ($\sum F_x = 0$):** - The lateral wind load $P = +20.0\\text{ kN}$ acts to the right. - The horizontal shear reactions from the columns act on the girder: $$\\sum F_x = 0 \\implies V_1 + V_2 + P = 0$$ $$\\mathbf{\\frac{M_{AB} + M_{BA}}{4.0} + \\frac{M_{DC} + M_{CD}}{4.0} + 20.0 = 0}$$ 4. **Multiply by $4.0$ to Simplify:** $$\\mathbf{M_{AB} + M_{BA} + M_{DC} + M_{CD} + 80.0 = 0}$$ This provides the precise independent linear equation needed to close the matrix system for lateral sway $\\Delta$! Flawless frame sidesway derivation!" },
        { "text": "M_AB + M_BA = M_DC + M_CD", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "(M_AB - M_BA)/4.0 + (M_DC - M_CD)/4.0 = 20.0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "M_AB + M_BA + M_DC + M_CD = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
