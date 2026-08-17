# Duofy Reusable Lesson Format: Dataflow Analysis (Gen-Kill Equations and Lattices)

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Intermediate_Code_Generation_and_Optimization`  
**Lesson Format Type:** `dataflow_analysis_gen_kill_equations_and_lattices`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the iterative fixed-point computations, transfer functions, and semi-lattice frameworks of compiler Dataflow Analysis (Gary A. Kildall 1973, *A Unified Approach to Global Program Optimization*; Frances E. Allen & John Cocke 1976; Alfred V. Aho et al. *The Dragon Book* Chapter 9): master the canonical **Gen-Kill Transfer Function ($\mathbf{\text{OUT}[B] = \text{GEN}[B] \cup (\text{IN}[B] \setminus \text{KILL}[B])}$)**, evaluate the **3 Classic Global Analyses**:
1. **Reaching Definitions** (**Forward + Union / May**),
2. **Available Expressions** (**Forward + Intersection / Must**), and
3. **Live Variable Analysis** (**Backward + Union / May: $\mathbf{\text{IN}[B] = \text{USE}[B] \cup (\text{OUT}[B] \setminus \text{DEF}[B])}$**),
prove the **Monotonicity & Knaster-Tarski Fixed-Point Theorem** guaranteeing termination on bounded lattices, and apply results directly to compiler optimization passes (Common Subexpression Elimination, Dead Code Elimination, and Constant Propagation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dataflow Framework, Gen-Kill Equations, & 3 Canonical Analyses Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Iterative Worklist Solver Execution Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Dataflow Analysis Framework & Direction / Confluence Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Direction of Information Flow in Live Variable Analysis (Backward) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason Available Expressions Requires Intersection (Must) Rather Than Union (May) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Dataflow Analysis & Gen-Kill Equations (Kildall 1973; Dragon Book Chapter 9):
   - **The Generic Dataflow Transfer Framework:**
     $$\mathbf{\text{OUT}[B] = f_B(\text{IN}[B]) = \text{GEN}[B] \ \cup \ (\text{IN}[B] \setminus \text{KILL}[B])}$$
   - **The 3 Canonical Dataflow Analyses Master Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Analysis} & \textbf{Direction} & \textbf{Meet / Confluence} & \textbf{Transfer Equation} & \textbf{Optimization Pass} \\
     \hline
     \mathbf{\text{Reaching Definitions}} & \text{Forward} & \bigcup \ (\text{May}) & \text{OUT}[B] = \text{GEN} \cup (\text{IN} \setminus \text{KILL}) & \text{Constant Propagation} \\
     \mathbf{\text{Available Expressions}} & \text{Forward} & \mathbf{\bigcap \ (\text{Must})} & \text{OUT}[B] = \text{GEN} \cup (\text{IN} \setminus \text{KILL}) & \mathbf{\text{Common Subexpression Elim (CSE)}} \\
     \mathbf{\text{Live Variables}} & \mathbf{\text{Backward}} & \bigcup \ (\text{May}) & \mathbf{\text{IN}[B] = \text{USE} \cup (\text{OUT} \setminus \text{DEF})} & \mathbf{\text{Dead Code Elim / Reg Alloc}} \\
     \hline
     \end{array}$$
   - **Fixed-Point Convergence:** If transfer functions are monotonic over a finite semi-lattice $(L, \wedge)$, the worklist algorithm is guaranteed to converge to the **Unique Maximum Fixed Point (MFP)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of the worklist dataflow solver algorithm: (1) initialize local GEN and KILL sets for each basic block B in the CFG, (2) initialize IN[B] and OUT[B] sets to boundary values (empty set for Union/May analyses; Universal set U for Intersection/Must analyses), (3) insert all basic blocks into an active worklist queue, (4) pop a basic block B from worklist, compute its confluent IN[B] = Meet_{P in Pred(B)} OUT[P], and update OUT[B] = GEN[B] U (IN[B] \\ KILL[B]), (5) if OUT[B] changed, add all successor blocks of B back into the worklist, repeating until the worklist is empty and fixed point is achieved!
3. **Slide 3 (`matching`):** Pair 4 dataflow concepts (Reaching Definitions Forward-Union, Available Expressions Forward-Intersection, Live Variables Backward-Union, Monotonicity Theorem) with their functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Live Variable Analysis propagates dataflow information in the backward direction. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Available Expressions requires the intersection ($\cap$) operator: In Available Expressions analysis for Common Subexpression Elimination, why must the confluence operator at a merge point be set intersection ($\cap$ / Must) rather than set union ($\cup$ / May)? (Because an expression $x + y$ is safe to reuse only if its computed value is **guaranteed to be available along EVERY incoming control flow path** leading to the block; using union would falsely assume an expression is available when it was computed on only one branch, leading to incorrect program execution if the alternate branch was taken).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dataflow_analysis_gen_kill_equations_and_lattices",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Kildall's Dataflow Analysis Framework (1973)**\n• **The Canonical Transfer Function:**\n$$\n\\mathbf{\\text{OUT}[B] = \\text{GEN}[B] \\ \\cup \\ (\\text{IN}[B] \\setminus \\text{KILL}[B])}\n$$\n• **The 3 Canonical Analyses (Dragon Book Chapter 9):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Analysis} & \\textbf{Direction} & \\textbf{Meet} & \\textbf{Transfer Equation} \\\\\n\\hline\n\\mathbf{\\text{Reaching Defs}} & \\text{Forward} & \\bigcup \\ (\\text{May}) & \\text{OUT} = \\text{GEN} \\cup (\\text{IN} \\setminus \\text{KILL}) \\\\\n\\mathbf{\\text{Available Exprs}} & \\text{Forward} & \\mathbf{\\bigcap \\ (\\text{Must})} & \\text{OUT} = \\text{GEN} \\cup (\\text{IN} \\setminus \\text{KILL}) \\\\\n\\mathbf{\\text{Live Variables}} & \\mathbf{\\text{Backward}} & \\bigcup \\ (\\text{May}) & \\mathbf{\\text{IN} = \\text{USE} \\cup (\\text{OUT} \\setminus \\text{DEF})} \\\\\n\\hline\n\\end{array}\n$$\n• **Fixed-Point Theorem:** Monotonicity over finite lattices guarantees termination at the **Maximum Fixed Point (MFP)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the iterative worklist dataflow solver algorithm.",
      "orderItems": [
        "Compute local GEN and KILL sets for each basic block by inspecting instruction operands",
        "Initialize global dataflow sets (empty set for May/Union analyses; Universal set for Must/Intersection)",
        "Push all basic blocks of the Control Flow Graph onto the active worklist queue",
        "Pop block B from worklist, compute IN[B] using the confluence meet operator across all predecessors",
        "Evaluate transfer function OUT[B]; if OUT[B] changes, push all successor blocks of B back onto worklist"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Dataflow Analysis to its exact direction and confluence characteristics.",
      "matchPairs": [
        { "left": "Reaching Definitions", "right": "Forward + Union (May): Identifies all assignment sites that may reach a program read" },
        { "left": "Available Expressions", "right": "Forward + Intersection (Must): Identifies expressions computed along all paths for CSE" },
        { "left": "Live Variable Analysis", "right": "Backward + Union (May): Identifies variables whose current value may be read later" },
        { "left": "Lattice Monotonicity", "right": "Mathematical condition ensuring iterative values move in one direction toward fixed point" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Live Variable Analysis computes dataflow facts by propagating information in the ___ direction from successors to predecessors.",
      "blankAnswer": "backward",
      "blankDistractors": ["forward", "random", "bidirectional"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Available Expressions analysis (used for Common Subexpression Elimination), why must the confluence operator at control-flow merge points be set intersection (Must-analysis) rather than set union (May-analysis)?",
      "options": [
        { "text": "An expression x + y can only be safely replaced with a precomputed temporary if its value is guaranteed to be available along EVERY possible execution path leading to the block; using union would treat an expression as available even if it was only computed on one incoming branch, causing the program to read uninitialized or stale data if the alternative branch is taken at runtime", "isCorrect": true, "explanation": "Correct! This represents the fundamental distinction between 'Must' (safe for code replacement) and 'May' analyses (Dragon Book Section 9.2). In Common Subexpression Elimination (CSE), if expression $e = x + y$ is available at basic block $B$, the compiler eliminates the recalculation of $x + y$ and replaces it with the previously stored temporary variable $t$. For this transformation to be sound, the value in $t$ MUST be valid and identical regardless of which execution path reached $B$. If block $B$ has two predecessors $P_1$ and $P_2$, and $x + y$ was calculated in $P_1$ but NOT in $P_2$, the expression is NOT available along the $P_2$ path. If we used set union ($\\cup$), the analysis would claim $x + y$ is available at $B$. If the program takes the $P_2$ path at runtime and tries to use $t$, $t$ will contain garbage or stale data, corrupting program execution! Therefore, Available Expressions MUST use set intersection ($\\cap$), retaining an expression if and only if it is generated along ALL incoming paths." },
        { "text": "Because set intersection is computationally faster to calculate on binary CPUs", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because compiler languages forbid the union operator in dataflow code", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because set union is only valid for backward dataflow analyses", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
