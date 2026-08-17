# Duofy Reusable Lesson Format: Static Equilibrium (2D/3D Rigid Bodies and Free-Body Diagrams)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Statics_and_Force_Systems`  
**Lesson Format Type:** `2d_and_3d_rigid_body_equilibrium_and_free_body_diagrams`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational Newtonian mechanics, vector force resolution, support reaction constraints, and static equilibrium equations in 2D and 3D (Russell C. Hibbeler *Engineering Mechanics: Statics* Chapter 3 & 5; Ferdinand P. Beer & E. Russell Johnston Jr. *Vector Mechanics for Engineers: Statics* Chapter 4): master the creation of the **Free-Body Diagram (FBD)** (isolating a mechanical body from its surroundings and replacing all physical contacts, cables, and supports with active and reactive force vectors), master the **Support Reaction Invariants** (**Roller:** 1 normal force $N_y$; **Smooth Pin/Hinge:** 2 orthogonal forces $A_x, A_y$; **Fixed/Cantilever Clamped Support:** 2 forces $A_x, A_y$ plus 1 resistive couple moment $M_A$), and master the **Equations of Equilibrium** in 2D ($\mathbf{\sum F_x = 0, \ \sum F_y = 0, \ \sum M_O = 0}$) and 3D ($\mathbf{\sum \mathbf{F} = \mathbf{0}, \ \sum \mathbf{M}_O = \mathbf{0}}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Support Reaction Classification & 2D/3D Equilibrium Equations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Procedure to Construct an FBD and Solve Beam Support Reactions Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Mechanical Support Type / Constraint & Unknown Reaction Forces Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Support That Prevents Both Linear Translation and Rotational Bending by Exerting Forces and a Couple Moment Is a ___ Support (Fixed / Clamped) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Mechanics Analysis: Solving Reaction Forces on a Simply Supported Beam with Point & UDL Loads Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Statics Equilibrium (Hibbeler 2016; Beer & Johnston 2019):
   - **Support Reactions Taxonomy Matrix:**
     $$\begin{array}{|l|c|l|l|}
     \hline
     \textbf{Support Type} & \textbf{\# Unknowns} & \textbf{Reactions Developed} & \textbf{Physical Movement Allowed} \\
     \hline
     \mathbf{\text{Roller / Rocker}} & \mathbf{1} & \text{Force perpendicular to surface } (N_y) & \text{Free translation along surface + Free rotation} \\
     \mathbf{\text{Smooth Pin / Hinge}} & \mathbf{2} & \text{Two orthogonal forces } (A_x, A_y) & \text{Free rotation ONLY (No translation)} \\
     \mathbf{\text{Fixed / Clamped}} & \mathbf{3} & \mathbf{\text{Two forces } (A_x, A_y) + \text{Couple Moment } M_A} & \mathbf{\text{NO translation AND NO rotation!}} \\
     \hline
     \end{array}$$
   - **The 2D Static Equilibrium Invariant:**
     $$\mathbf{\sum F_x = 0, \quad \sum F_y = 0, \quad \sum M_A = 0 \quad (\text{Select pivot } A \text{ to eliminate max unknowns!})}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of solving a simply supported beam: (1) isolate the beam from supports and draw the Free-Body Diagram (FBD), (2) replace pin at $A$ with $A_x, A_y$ and roller at $B$ with vertical reaction $B_y$, (3) convert distributed loads (UDL) into equivalent concentrated resultant point forces acting at their centroid, (4) take moment equilibrium about pin support $\sum M_A = 0$ to solve for roller reaction $B_y$ directly, (5) apply force equilibrium $\sum F_y = 0$ and $\sum F_x = 0$ to solve remaining reactions $A_y$ and $A_x$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Roller Support, Pin Support, Fixed Cantilever Support, Centroid of Triangular Load) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Fixed (or Clamped). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on solving simply supported beam: A simply supported beam of span $L = 6\text{ m}$ has a pin support at $A$ ($x=0$) and a roller support at $B$ ($x=6\text{ m}$). It carries a uniformly distributed load (UDL) of $w = 4\text{ kN/m}$ across its entire span and a concentrated downward point load of $P = 12\text{ kN}$ at $x = 2\text{ m}$. What are the vertical support reactions $A_y$ and $B_y$? (Total UDL force $= w \cdot L = 4 \cdot 6 = 24\text{ kN}$ acting at the midpoint $x = 3\text{ m}$; taking moments about $A$: $\sum M_A = 0 \implies (24\text{ kN} \times 3\text{ m}) + (12\text{ kN} \times 2\text{ m}) - (B_y \times 6\text{ m}) = 0 \implies 72 + 24 - 6 B_y = 0 \implies 96 = 6 B_y \implies \mathbf{B_y = 16\text{ kN}}$; applying $\sum F_y = 0 \implies A_y + B_y = 24 + 12 = 36\text{ kN} \implies A_y = 36 - 16 = \mathbf{20\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "2d_and_3d_rigid_body_equilibrium_and_free_body_diagrams",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Rigid Body Static Equilibrium \\& Support Reactions (Hibbeler)**\n• **Support Constraint \\& Reaction Matrix:**\n$$\n\\begin{array}{|l|c|l|l|}\n\\hline\n\\textbf{Support Type} & \\textbf{\\# Unknowns} & \\textbf{Reaction Vectors} & \\textbf{Kinematic Restraint} \\\\\n\\hline\n\\mathbf{\\text{Roller Support}} & \\mathbf{1} & \\text{Normal Force } (B_y) & \\text{Prevents translation normal to plane} \\\\\n\\mathbf{\\text{Pin / Hinge Support}} & \\mathbf{2} & \\text{Orthogonal Forces } (A_x, A_y) & \\text{Prevents all horizontal \\& vertical translation} \\\\\n\\mathbf{\\text{Fixed (Clamped)}} & \\mathbf{3} & \\mathbf{\\text{Forces } (A_x, A_y) + \\text{Moment } M_A} & \\mathbf{\\text{Prevents ALL translation AND rotation!}} \\\\\n\\hline\n\\end{array}\n$$\n• **The 2D Static Equilibrium System:**\n$$\n\\mathbf{\\sum F_x = 0, \\quad \\sum F_y = 0, \\quad \\sum M_O = 0}\n$$\n• **Pivot Strategy:** Always take moments about the support with the **greatest number of unknown forces** (e.g. Pin $A$) to eliminate their moment arms ($r=0$) and solve the remaining reactions directly!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve support reaction forces on a loaded structural beam.",
      "orderItems": [
        "Isolate the physical beam from all external supports and draw a clean Free-Body Diagram (FBD)",
        "Replace physical supports with unknown reaction forces (Pin -> Ax, Ay; Roller -> By)",
        "Convert distributed loads (UDL/UVL) into equivalent concentrated point forces located at their geometric centroids",
        "Formulate moment equilibrium about the pin support (sum M_A = 0) to solve for the unknown roller reaction By directly",
        "Apply sum F_y = 0 and sum F_x = 0 force equilibrium equations to determine the remaining reaction components (Ay and Ax)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Structural Support Type to its exact Reaction Signature.",
      "matchPairs": [
        { "left": "Roller Support", "right": "1 unknown reaction force oriented perpendicular to the supporting surface" },
        { "left": "Pin / Hinge Support", "right": "2 unknown reaction force components (horizontal and vertical) with zero moment restraint" },
        { "left": "Fixed / Cantilever Support", "right": "3 unknowns: 2 orthogonal force components plus 1 resistive bending couple moment" },
        { "left": "Centroid of Triangular Load (UVL)", "right": "Located at exactly one-third of the span length (L/3) measured from the largest vertical base" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A support that prevents all translational movement and rotational bending by exerting reaction forces and a moment is a ___ support.",
      "blankAnswer": "fixed",
      "blankDistractors": ["roller", "pin", "rocker"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A simply supported beam of span L = 6 m has a pin at A (x=0) and a roller at B (x=6 m). It carries a uniformly distributed load (UDL) of w = 4 kN/m across the full 6 m span, plus a concentrated point load P = 12 kN at x = 2 m. What are the vertical support reactions Ay and By?",
      "options": [
        { "text": "Ay = 20 kN and By = 16 kN", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Newtonian statics (Hibbeler *Engineering Mechanics: Statics* Chapter 5). 1. **Equivalent Point Load of UDL:** - Total UDL force: $W = w \\cdot L = (4\\text{ kN/m})(6\\text{ m}) = 24\\text{ kN}$. - Location of UDL centroid: Midpoint of span, $x = \\frac{6}{2} = 3\\text{ m}$. 2. **Moment Equilibrium about Pin $A$ ($\\sum M_A = 0$):** - Take counterclockwise moments as positive: $$\\sum M_A = - (P \\cdot 2\\text{ m}) - (W \\cdot 3\\text{ m}) + (B_y \\cdot 6\\text{ m}) = 0$$ $$-(12\\text{ kN} \\times 2\\text{ m}) - (24\\text{ kN} \\times 3\\text{ m}) + 6 B_y = 0$$ $$-24 - 72 + 6 B_y = 0 \\implies 6 B_y = 96 \\implies \\mathbf{B_y = 16\\text{ kN}}$$ 3. **Vertical Force Equilibrium ($\\sum F_y = 0$):** $$\\sum F_y = A_y + B_y - P - W = 0$$ $$A_y + 16 - 12 - 24 = 0 \\implies A_y = 36 - 16 = \\mathbf{20\\text{ kN}}$$ 4. **Check:** $A_y + B_y = 20 + 16 = 36\\text{ kN} = \\text{Total downward load}$! Flawless equilibrium!" },
        { "text": "Ay = 18 kN and By = 18 kN", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ay = 24 kN and By = 12 kN", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ay = 36 kN and By = 0 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
