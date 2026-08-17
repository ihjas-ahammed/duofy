# Duofy Reusable Lesson Format: Truss Statics (Determinacy, Joints, & Cutting Sections)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Determinate_and_Indeterminate_Trusses`  
**Lesson Format Type:** `truss_static_determinacy_method_of_joints_and_sections`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fundamental mechanics of 2D planar pin-jointed trusses, static determinacy criteria ($b + r = 2j$), overall equilibrium of support reactions ($\sum F_x = 0, \sum F_y = 0, \sum M_z = 0$), the concurrent pin Method of Joints, and the moment-isolating Method of Sections for targeted bridge truss chord and web bar analysis (Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 3; Aslam Kassimali *Structural Analysis* 6th ed. Chapter 4): formulate the **Static Determinacy Criterion for 2D Trusses**:
$$\mathbf{\text{DSI} = b + r - 2j}$$
where:
1. **$b$:** Number of internal truss member bars;
2. **$r$:** Number of external support reaction components;
3. **$j$:** Number of pin joints;
$$\mathbf{b + r < 2j \implies \text{Unstable Mechanism} \quad \Big| \quad \mathbf{b + r = 2j \implies \text{Statically Determinate}} \quad \Big| \quad \mathbf{b + r > 2j \implies \text{Statically Indeterminate}}}$$
master the **Two Analysis Methodologies**:
- **Method of Joints:** Isolate individual concurrent pin joints with at most 2 unknown member forces using:
  $$\mathbf{\sum F_x = 0 \quad \Big| \quad \sum F_y = 0 \quad (\text{Sequential joint sweep})}$$
- **Method of Sections:** Pass an imaginary cutting plane through at most 3 non-concurrent members and apply rigid-body statics to one isolated portion:
  $$\mathbf{\sum M_{\text{intersection}} = 0 \implies \mathbf{\text{Isolates 1 Unknown Force Directly Without Prior Joint Sweeps!}}}$$
(proving why the Method of Sections provides instantaneous single-equation solutions for center-span chord forces in long bridge trusses).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Determinacy ($b + r = 2j$), Method of Joints ($\sum F=0$) & Method of Sections ($\sum M_O = 0$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Solve a Warren Bridge Truss Chord Force Using the Method of Sections Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Truss Statics Method / Variable & Technical Structural Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Method of Sections, an Imaginary Cutting Plane Should Pass Through No More Than ___ Unknown Truss Members (Three / 3) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Civil Engineering Problem: Calculating Center Top Chord Force F_CD in a Pratt Bridge Truss Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Truss Statics & Determinacy (Hibbeler 2018; Kassimali 2020):
   - **Determinacy & Equilibrium Formulations:**
     $$\mathbf{\text{DSI} = b + r - 2j \quad \Big| \quad \text{Joints: } \sum F_x = 0, \ \sum F_y = 0 \quad \Big| \quad \text{Sections: } \sum M_O = 0, \ \sum F_y = 0}$$
   - **Truss Method Selection Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Analysis Method} & \textbf{Unknowns Handled} & \textbf{Computational Path} & \textbf{Best Engineering Use Case} \\
     \hline
     \mathbf{\text{Method of Joints}} & \text{Max 2 per joint} & \text{Sequential propagation joint-by-joint} & \mathbf{\text{Complete member force inventory (all bars)}} \\
     \mathbf{\text{Method of Sections}} & \mathbf{\text{Max 3 per cut}} & \mathbf{\text{Direct single-step moment equilibrium}} & \mathbf{\text{Targeted center chords / critical web braces}} \\
     \hline
     \end{array}$$
   - **The Sign Convention Invariant:** Always assume internal forces act in **Tension (pulling away from joint/cut)**; a positive result indicates **Tension ($T > 0$)**, while a negative result indicates **Compression ($C < 0$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Method of Sections: (1) calculate global external support reactions using whole-truss equilibrium ($\sum F_x = 0, \sum F_y = 0, \sum M = 0$), (2) pass an imaginary cutting section through at most 3 non-concurrent members including the target member, (3) isolate one side of the severed truss and draw its Free Body Diagram (FBD), (4) select a moment center at the intersection point of the other two cut members to eliminate them from the equation: $\sum M_{\text{intersection}} = 0$, (5) solve directly for the target member axial force and assign Tension/Compression sign!
3. **Slide 3 (`matching`):** Pair 4 concepts (Method of Joints, Method of Sections, Degree of Static Indeterminacy $b+r-2j$, Tension Force Convention) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Three (or 3). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating top chord force via Method of Sections: A symmetric Warren bridge truss spanning $L = 12\text{ m}$ with height $h = 3.0\text{ m}$ has support reactions $R_{Ay} = R_{Ey} = 60\text{ kN}$. A downward point load of $120\text{ kN}$ is applied at center bottom joint $C$ ($x = 6.0\text{ m}$). A vertical cutting section passes through top chord member $BD$ (located at height $y = 3.0\text{ m}$), diagonal member $CD$, and bottom chord member $CE$. Taking moments about bottom joint $C$ for the left section, what is the axial force in top chord member $F_{BD}$? ($\sum M_C = 0 \implies (R_{Ay} \times 6.0\text{ m}) + (F_{BD} \times 3.0\text{ m}) = 0 \implies (60\text{ kN} \times 6.0\text{ m}) + 3.0 F_{BD} = 0 \implies 360 + 3.0 F_{BD} = 0 \implies F_{BD} = -\frac{360}{3.0} = \mathbf{-120\text{ kN} = 120\text{ kN (Compression)}}).$

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "truss_static_determinacy_method_of_joints_and_sections",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Planar Truss Statics \\& Determinacy (Russell Hibbeler)**\n• **Static Determinacy Formulation (2D Trusses):**\n$$\n\\mathbf{\\text{DSI} = b + r - 2j}\n$$\n  - $b + r = 2j \\implies \\mathbf{\\text{Statically Determinate}}$;\n  - $b + r > 2j \\implies \\mathbf{\\text{Statically Indeterminate}}$ (Degree = $\\text{DSI}$);\n  - $b + r < 2j \\implies \\mathbf{\\text{Unstable Mechanism}}$;\n• **Method of Joints vs Method of Sections:**\n  - **Method of Joints:** Isolates single concurrent pin joints with max 2 unknowns: $\\mathbf{\\sum F_x = 0, \\ \\sum F_y = 0}$;\n  - **Method of Sections:** Cuts through max 3 members, applying moment equilibrium at the intersection of unwanted bars: $\\mathbf{\\sum M_{\\text{intersect}} = 0}$ to solve the target bar in **one single step**!\n• **The Tension Convention Invariant:** Always draw unknown member forces pulling **away from the joint / cut face (Tension)**; positive solutions indicate pure **Tension ($T > 0$)**, negative solutions indicate pure **Compression ($C < 0$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve a critical bridge chord member force directly using the Method of Sections.",
      "orderItems": [
        "Calculate the external support reactions from whole-structure equilibrium equations: \u2211Fx = 0, \u2211Fy = 0, \u2211M = 0",
        "Pass an imaginary cutting plane through no more than 3 non-concurrent members, including the desired target member",
        "Isolate one portion (left or right) of the cut truss and draw a complete Free Body Diagram with internal forces in tension",
        "Select a moment center point at the concurrent intersection of the other two cut members to eliminate them from the equation",
        "Sum moments about that intersection point: \u2211M_intersect = 0 to solve directly for the target member axial force"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Truss Analysis Technique to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Method of Sections", "right": "Cuts up to 3 members and applies \u2211M = 0 to directly isolate a single chord force without prior joint sweeps" },
        { "left": "Method of Joints", "right": "Sequential equilibrium analysis (\u2211Fx = 0, \u2211Fy = 0) of concurrent pin joints to find all bar forces" },
        { "left": "Determinacy Criterion (b + r = 2j)", "right": "Exact balance between total unknown internal bars plus reactions and total independent joint equilibrium equations" },
        { "left": "Tensile Force Sign Convention", "right": "Vector pointing away from the pin joint; positive sign indicates tension and negative indicates compression" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Method of Sections, an imaginary cutting plane should pass through no more than ___ unknown truss members.",
      "blankAnswer": "3",
      "blankDistractors": ["1", "5", "6"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A symmetric Warren bridge truss spanning L = 12 m with height h = 3.0 m has left reaction R_Ay = 60 kN and right reaction R_Ey = 60 kN. A single load of 120 kN acts downward at center joint C (x = 6.0 m). A vertical section cuts top chord BD (at height y = 3.0 m), diagonal CD, and bottom chord CE. Taking moments about joint C for the left portion, what is the axial force F_BD?",
      "options": [
        { "text": "F_BD = -120 kN (120 kN Compression) (\u2211M_C = 0 \u2192 (R_Ay * 6.0 m) + (F_BD * 3.0 m) = 0 \u2192 (60 * 6.0) + 3.0*F_BD = 0 \u2192 F_BD = -360 / 3.0 = -120 kN)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Method of Sections (Russell C. Hibbeler *Structural Analysis* Chapter 3). 1. **Establish the Free Body Diagram of the Left Portion:** - The left portion extends from pin support $A$ ($x = 0$) to cutting section passing between $B$ and $D$. - External forces acting on the left segment: - Upward reaction at support $A$: $R_{Ay} = +60.0\\text{ kN}$ at $x = 0$. - Internal cut member forces: $F_{BD}$ (horizontal top chord at height $y = 3.0\\text{ m}$), $F_{CD}$ (slanted diagonal), and $F_{CE}$ (horizontal bottom chord at $y = 0$). 2. **Choose the Optimal Moment Center:** - Notice that diagonal member $CD$ and bottom chord $CE$ both intersect at bottom joint $C$ ($x = 6.0\\text{ m}, y = 0$). - Taking moments about joint $C$ eliminates $F_{CD}$ and $F_{CE}$ completely ($0$ moment arms)! 3. **Sum Moments about Joint $C$ (Counter-Clockwise Positive):** $$\\sum M_C = 0$$ $$(R_{Ay} \\times 6.0\\text{ m}) + (F_{BD} \\times 3.0\\text{ m}) = 0$$ $$(60.0\\text{ kN} \\times 6.0\\text{ m}) + 3.0\\text{ m} \\times F_{BD} = 0$$ $$360.0\\text{ kN}\\cdot\\text{m} + 3.0\\text{ m} \\times F_{BD} = 0$$ $$3.0 F_{BD} = -360.0\\text{ kN}\\cdot\\text{m}$$ $$F_{BD} = -\\frac{360.0}{3.0} = \\mathbf{-120.0\\text{ kN} = 120.0\\text{ kN (Compression)}}$$ 4. **Physical Sanity Check:** In a simply supported bridge truss under downward gravity load, the top chord is always in **compression** ($C < 0$) while the bottom chord is in **tension** ($T > 0$). Flawless Method of Sections calculation!" },
        { "text": "F_BD = +120 kN (120 kN Tension)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F_BD = -60 kN (60 kN Compression)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F_BD = -240 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
