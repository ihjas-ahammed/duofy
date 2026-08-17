# Duofy Reusable Lesson Format: Mobility & DOF (Kutzbach-Grübler Criterion)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Kinematic_Chains_and_Mechanisms`  
**Lesson Format Type:** `kutzbach_grubler_mobility_criterion_and_degrees_of_freedom`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through planar mechanism topology, kinematic joint constraints, and degree of freedom mobility analysis in mechanical engineering (Martin Grübler 1883; Karl Kutzbach 1929; Joseph E. Shigley et al. *Theory of Machines and Mechanisms* Chapter 1; Kenneth J. Waldron & Gary L. Kinzel Chapter 1): master the **Kutzbach-Grübler Mobility Criterion for Planar Linkages**:
$$\mathbf{M = 3(n - 1) - 2 j_1 - j_2}$$
where $n$ is the total number of rigid links (including the fixed ground frame as Link 1), $j_1$ is the number of 1-DOF lower pairs (revolute pin joints $R$, prismatic sliding joints $P$), and $j_2$ is the number of 2-DOF higher pairs (rolling/sliding cam-followers, meshing gear teeth); master the **Mobility Classification Spectrum**: (1) $\mathbf{M = 1}$ (**Constrained Mechanism**, exactly 1 independent actuator or motor uniquely specifies the position and motion of all links), (2) $\mathbf{M = 0}$ (**Statically Determinate Structure / Truss**, zero kinematic motion), (3) $\mathbf{M < 0}$ (**Super-Structure / Pre-Stressed Frame**, statically indeterminate), and (4) $\mathbf{M \ge 2}$ (**Differential / Multi-DOF Unconstrained Mechanism** requiring $M$ independent actuators); and identify **Redundant Constraints and Idle Degrees of Freedom** (such as rotating cam roller followers).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kutzbach-Grübler Mobility Criterion ($M = 3(n-1) - 2j_1 - j_2$) & Kinematic Joint Classification Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Count Links, Identify Pairs, and Calculate Mobility of a Mechanism Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Kinematic Joint Type / Mobility Spectrum Index & Technical Physical Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Planar Linkage with Mobility M = 1 That Requires Exactly One Actuator to Control All Link Positions Is a Constrained ___ (Mechanism) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanism Topology Problem: Calculating the Degrees of Freedom of a Stephenson Six-Bar Linkage Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Kutzbach-Grübler Mobility (Shigley 2014; Waldron 2016):
   - **Kutzbach-Grübler Planar Formulation:**
     $$\mathbf{M = 3(n - 1) - 2 j_1 - j_2 \quad (\text{Planar Linkages})}$$
   - **Kinematic Pairs & Constraint Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Kinematic Joint Class} & \textbf{Pair Type} & \textbf{DOF Permitted } (f) & \textbf{Constraints Imposed } (c = 3 - f) \\
     \hline
     \mathbf{\text{Revolute Pin Joint } (R)} & \text{Lower Pair } (j_1) & 1 \text{ DOF (Rotation)} & 2 \text{ Constraints (No } x, y \text{ translation)} \\
     \mathbf{\text{Prismatic Slider } (P)} & \text{Lower Pair } (j_1) & 1 \text{ DOF (Translation)} & 2 \text{ Constraints (No } y \text{ trans, No rot)} \\
     \mathbf{\text{Cam-Follower / Gear Mesh}} & \mathbf{\text{Higher Pair } (j_2)} & \mathbf{2 \text{ DOF (Roll + Slide)}} & \mathbf{1 \text{ Constraint (Contact normal)}} \\
     \hline
     \end{array}$$
   - **Mobility Invariant:**
     - $M = 1$: Single-degree-of-freedom mechanism (Standard machine);
     - $M = 0$: Rigid structure / truss;
     - $M < 0$: Statically indeterminate pre-stressed structure;
     - $M = 2$: Differential gear or robotic two-joint arm.
2. **Slide 2 (`ordering`):** Provide 5 steps of calculating mechanism mobility: (1) identify all separate rigid links including the fixed machine frame/ground as Link 1 ($n$), (2) count all 1-DOF lower pairs ($j_1$) including pin joints and slider blocks, (3) count all 2-DOF higher pairs ($j_2$) such as cam-follower line contacts and gear meshes, (4) identify and eliminate any idle degrees of freedom (e.g. roller follower spin), (5) substitute values into the Kutzbach-Grübler equation $M = 3(n-1) - 2j_1 - j_2$ to evaluate system mobility!
3. **Slide 3 (`matching`):** Pair 4 concepts (Lower Pair $j_1$, Higher Pair $j_2$, Mobility $M=1$, Mobility $M=0$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Mechanism. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating mobility of a six-bar mechanism: A Stephenson six-bar planar linkage consists of $n = 6$ rigid links connected exclusively by revolute pin joints (lower pairs $j_1$). There are 7 single revolute pin joints in the linkage ($j_1 = 7$) and zero higher pairs ($j_2 = 0$). What is the mobility (degrees of freedom $M$) of this kinematic mechanism? ($M = 3(n - 1) - 2 j_1 - j_2 = 3(6 - 1) - 2(7) - 0 = 3(5) - 14 = 15 - 14 = \mathbf{1}$; **$M = 1$, confirming it is a fully constrained single-input mechanism**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kutzbach_grubler_mobility_criterion_and_degrees_of_freedom",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Kutzbach-Grübler Mobility Criterion (Shigley \\& Uicker)**\n• **Planar Linkage Degrees of Freedom Formulation:**\n$$\n\\mathbf{M = 3(n - 1) - 2 j_1 - j_2}\n$$\n• **Kinematic Joint Constraint Matrix:**\n$$\n\\begin{array}{|l|l|c|c|}\n\\hline\n\\textbf{Kinematic Joint} & \\textbf{Classification} & \\textbf{DOF Allowed } (f) & \\textbf{Constraints Imposed } (c) \\\\\n\\hline\n\\mathbf{\\text{Revolute Pin } (R)} & \\text{Lower Pair } (j_1) & 1 & 2 \\\\\n\\mathbf{\\text{Prismatic Slider } (P)} & \\text{Lower Pair } (j_1) & 1 & 2 \\\\\n\\mathbf{\\text{Cam-Follower / Gear}} & \\mathbf{\\text{Higher Pair } (j_2)} & \\mathbf{2} & \\mathbf{1} \\\\\n\\hline\n\\end{array}\n$$\n• **Mobility State Spectrum:**\n  - $\\mathbf{M = 1}$: **Constrained Mechanism** (1 motor/actuator dictates all link motions);\n  - $\\mathbf{M = 0}$: **Statically Determinate Structure / Truss** (zero movement);\n  - $\\mathbf{M < 0}$: **Super-Structure / Pre-Stressed Frame** (statically indeterminate);\n  - $\\mathbf{M \\ge 2}$: **Differential Mechanism** (requires $M$ independent input motors)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the mobility (degrees of freedom) of a planar mechanical linkage.",
      "orderItems": [
        "Identify and number all distinct rigid links, counting the fixed machine ground frame as Link 1 (n)",
        "Count all 1-DOF lower pairs j1 (revolute pin joints and prismatic sliding contacts)",
        "Count all 2-DOF higher pairs j2 (cam-follower rolling/sliding contacts and meshing gear teeth)",
        "Identify and subtract any redundant links or idle degrees of freedom (such as roller follower rotation)",
        "Substitute link and joint counts into the Kutzbach-Grübler equation: M = 3*(n - 1) - 2*j1 - j2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Kinematic Mobility Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Lower Pair (j1)", "right": "Joint with surface contact permitting exactly 1 relative DOF (revolute pin or slider)" },
        { "left": "Higher Pair (j2)", "right": "Joint with point/line contact permitting 2 relative DOF (cam-follower or gear mesh)" },
        { "left": "Constrained Mechanism (M = 1)", "right": "System where driving a single input link uniquely and deterministically controls all output links" },
        { "left": "Rigid Structure (M = 0)", "right": "Statically determinate truss that cannot undergo macroscopic kinematic motion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A planar linkage with mobility M = 1 that requires exactly one input actuator to determine all link motions is a constrained ___.",
      "blankAnswer": "mechanism",
      "blankDistractors": ["structure", "truss", "frame"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A Stephenson six-bar planar linkage consists of n = 6 rigid links connected exclusively by revolute pin joints. There are j1 = 7 single revolute pin joints and zero higher pairs (j2 = 0). What is the mobility (degrees of freedom M) of this linkage?",
      "options": [
        { "text": "M = 1 (A constrained single-degree-of-freedom mechanism, calculated from M = 3*(6 - 1) - 2*7 - 0 = 15 - 14 = 1)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Kutzbach-Grübler Mobility Criterion (Shigley *Theory of Machines and Mechanisms* Chapter 1). 1. **Identify the Given Parameters:** - Total number of rigid links: $n = 6$ (including fixed ground). - Number of 1-DOF lower pairs (revolute pin joints): $j_1 = 7$. - Number of 2-DOF higher pairs: $j_2 = 0$. 2. **Apply the Kutzbach-Grübler Equation:** $$M = 3(n - 1) - 2 j_1 - j_2$$ $$M = 3(6 - 1) - 2(7) - 0 = 3(5) - 14 = 15 - 14 = \\mathbf{1}$$ 3. **Physical Interpretation:** - With $M = 1$, the six-bar linkage possesses **exactly one degree of freedom**. - Connecting an electric motor or hydraulic piston to any single driving link will **uniquely, smoothly, and deterministically govern the motions of all other 5 links** in the assembly!" },
        { "text": "M = 0 (A locked rigid structure)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "M = 2 (An unconstrained differential mechanism)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "M = 3", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
