# Duofy Reusable Lesson Format: Truss Analysis (Method of Joints vs Method of Sections)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Statics_and_Force_Systems`  
**Lesson Format Type:** `planar_truss_analysis_method_of_joints_vs_method_of_sections`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through structural mechanics, internal axial forces (Tension vs Compression), and analytical methods for planar engineering trusses (Russell C. Hibbeler *Engineering Mechanics: Statics* Chapter 6; Ferdinand P. Beer & E. Russell Johnston Jr. *Vector Mechanics for Engineers: Statics* Chapter 6): master the two core analytical methods: **1. The Method of Joints** (isolating individual pin joints as concurrent particle equilibrium systems $\mathbf{\sum F_x = 0, \ \sum F_y = 0}$, advancing joint by joint to solve all internal member forces throughout the entire truss) vs **2. The Method of Sections** (cutting an imaginary plane through at most 3 unknown truss members, treating a sliced portion as a rigid body and taking $\mathbf{\sum M_{\text{intersection}} = 0}$ to solve specific internal member forces directly in a single step), and master the **Two Zero-Force Member Inspection Rules** to simplify complex bridge and roof trusses instantly before calculation.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Truss Member Mechanics (Tension vs Compression) & Zero-Force Member Rules Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of the Method of Sections to Solve an Internal Truss Member Force Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Truss Analysis Technique / Zero-Force Case & Technical Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | An Internal Truss Member Pulled Outward from Its Connecting Pin Joints Is in ___ (Tension) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Visual Structural Inspection Problem: Identifying Zero-Force Members in a Bridge Truss Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Truss Analysis (Hibbeler 2016; Beer & Johnston):
   - **Method Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Method} & \textbf{Equilibrium Equations Used} & \textbf{Analysis Scope} & \textbf{Best Use Case} \\
     \hline
     \mathbf{\text{Method of Joints}} & \mathbf{\sum F_x = 0, \ \sum F_y = 0 \text{ (Particle)}} & \text{Sequential joint progression} & \mathbf{\text{Solving ALL member forces in truss}} \\
     \mathbf{\text{Method of Sections}} & \mathbf{\sum F_x = 0, \ \sum F_y = 0, \ \sum M_O = 0} & \mathbf{\text{Rigid body slice (Max 3 cuts)}} & \mathbf{\text{Solving 1-3 specific internal members}} \\
     \hline
     \end{array}$$
   - **Zero-Force Member Rules:**
     - **Rule 1:** 2 non-collinear members meeting at an unloaded joint $\implies$ **Both carry $F=0$!**
     - **Rule 2:** 3 members meeting at a joint where 2 are collinear and no external load acts on the joint $\implies$ **The 3rd non-collinear member carries $F=0$!**
2. **Slide 2 (`ordering`):** Provide 5 steps of Method of Sections: (1) calculate external support reactions for the entire truss using global equilibrium, (2) pass an imaginary section cut through at most 3 internal members including the target member, (3) isolate one side of the sliced truss and draw its Free-Body Diagram with exposed internal forces assumed in tension, (4) locate the intersection point where 2 of the 3 unknown force lines meet and take moment equilibrium $\sum M_{\text{intersection}} = 0$, (5) solve directly for the target internal force; a positive value confirms Tension (T), while a negative value indicates Compression (C)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Method of Joints, Method of Sections, Zero-Force Rule 1, Zero-Force Rule 2) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Tension. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on zero-force member identification: In a planar Pratt bridge truss, pin joint $D$ connects two collinear horizontal chord members ($CD$ and $DE$) and one vertical web member ($DF$). Joint $D$ has zero external loads and no support reactions attached. Why is the vertical member $DF$ guaranteed to carry zero force ($F_{DF} = 0$)? (Applying particle equilibrium $\sum F_y = 0$ at isolated joint $D$: **the collinear horizontal members $CD$ and $DE$ act purely along the $x$-axis and contribute $0$ vertical force component; because no external vertical load acts on joint $D$, the internal axial force in the vertical member $DF$ is the sole term in the vertical equilibrium equation ($\sum F_y = F_{DF} = 0$), mathematically proving that member $DF$ carries zero force**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "planar_truss_analysis_method_of_joints_vs_method_of_sections",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Planar Truss Analysis \\& Zero-Force Member Rules (Hibbeler)**\n• **Joints vs Sections Method Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Analysis Method} & \\textbf{Equilibrium Formulation} & \\textbf{Constraint Rule} & \\textbf{Strategic Advantage} \\\\\n\\hline\n\\mathbf{\\text{Method of Joints}} & \\mathbf{\\sum F_x = 0, \\quad \\sum F_y = 0} & \\text{Max 2 unknowns per joint} & \\mathbf{\\text{Computes full internal force map}} \\\\\n\\mathbf{\\text{Method of Sections}} & \\mathbf{\\sum F_x = 0, \\ \\sum F_y = 0, \\ \\sum M_O = 0} & \\mathbf{\\text{Cut through max 3 members}} & \\mathbf{\\text{Solves target member directly in 1 step!}} \\\\\n\\hline\n\\end{array}\n$$\n• **Zero-Force Member Visual Inspection Laws:**\n  - **Case 1 (2 Members):** If two non-collinear members form an unloaded joint $\\implies \\mathbf{F_1 = 0 \\text{ and } F_2 = 0}$!\n  - **Case 2 (3 Members):** If two of three members meeting at an unloaded joint are collinear $\\implies \\mathbf{F_{\\text{non-collinear}} = 0}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the Method of Sections to solve an internal diagonal member force in a bridge truss.",
      "orderItems": [
        "Compute global external support reactions for the entire truss using sum Fx=0, sum Fy=0, and sum M=0",
        "Pass an imaginary section cut through at most three internal truss members including the target member",
        "Isolate one portion of the sliced truss and draw its Free-Body Diagram, drawing unknown internal forces in tension (pulling away from cut)",
        "Identify the geometric intersection point of the two unwanted unknown force lines and take moment equilibrium sum M_intersect = 0",
        "Solve the resulting single-variable linear moment equation directly for the target internal force (positive = Tension, negative = Compression)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Truss Analysis Technique to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Method of Joints", "right": "Treats each pin joint as a 2D concurrent particle in equilibrium (sum Fx=0, sum Fy=0)" },
        { "left": "Method of Sections", "right": "Slices a portion of the truss as a rigid body to solve internal forces via moment equilibrium" },
        { "left": "Zero-Force Rule 1", "right": "Two non-collinear members meeting at an unloaded joint carry exactly zero force" },
        { "left": "Zero-Force Rule 2", "right": "The non-collinear third member meeting two collinear members at an unloaded joint carries zero force" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An internal structural truss member experiencing an axial pull away from its connecting pin joints is in ___.",
      "blankAnswer": "tension",
      "blankDistractors": ["compression", "torsion", "shear"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a planar bridge truss, joint D connects two collinear horizontal members (CD and DE) and one vertical web member (DF). Joint D has zero external applied loads and no support reactions. Why is member DF mathematically guaranteed to carry zero force (F_DF = 0)?",
      "options": [
        { "text": "Formulating particle equilibrium in the vertical direction (sum Fy = 0) at isolated joint D reveals that the two collinear horizontal chord members (CD and DE) act purely along the x-axis, contributing zero vertical force component; because no external load or support reaction acts vertically on joint D, the internal axial force in the vertical member DF is the only vertical term in the equation (sum Fy = F_DF = 0), proving that member DF must carry exactly 0 force", "isCorrect": true, "explanation": "Correct! This is Hibbeler and Beer & Johnston's classic Zero-Force Member Case 2 (*Engineering Mechanics: Statics* Chapter 6). 1. **Isolate Joint $D$ (Particle FBD):** - Member $CD$ exerts force $F_{CD}$ along $-\\hat{\\mathbf{i}}$. - Member $DE$ exerts force $F_{DE}$ along $+\\hat{\\mathbf{i}}$. - Member $DF$ exerts force $F_{DF}$ along $+\\hat{\\mathbf{j}}$. - External applied load $= 0$. 2. **Vertical Force Equilibrium ($\\sum F_y = 0$):** $$\\sum F_y = F_{DF} = 0 \\implies \\mathbf{F_{DF} = 0\\text{ (Zero-Force Member!)}}$$ 3. **Horizontal Force Equilibrium ($\\sum F_x = 0$):** $$\\sum F_x = F_{DE} - F_{CD} = 0 \\implies F_{CD} = F_{DE}$$ 4. **Why Engineers Include Zero-Force Members:** Although member $DF$ carries zero force under primary loading, it provides essential lateral buckling stability for members $CD$ and $DE$ and supports unexpected transient loads (e.g. maintenance weight or wind)!" },
        { "text": "Because vertical members are prohibited from carrying loads in bridge trusses", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because joint D is made of rubber", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because horizontal members absorb 100% of all gravity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
