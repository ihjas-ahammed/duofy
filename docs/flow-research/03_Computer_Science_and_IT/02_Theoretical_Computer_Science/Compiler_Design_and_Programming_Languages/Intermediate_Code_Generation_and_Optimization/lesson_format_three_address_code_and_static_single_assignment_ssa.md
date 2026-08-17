# Duofy Reusable Lesson Format: Three-Address Code and Static Single Assignment (SSA)

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Intermediate_Code_Generation_and_Optimization`  
**Lesson Format Type:** `three_address_code_and_static_single_assignment_ssa`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the linearized intermediate representation, variable versioning invariants, and control-flow merge functions of Static Single Assignment (SSA) form (Ron Cytron et al. 1991, *Efficiently Computing Static Single Assignment Form and the Control Dependence Graph*; Alfred V. Aho et al. *The Dragon Book* Chapter 6 & 8): master **Three-Address Code (TAC)** linearized instruction syntax ($x = y \text{ op } z$), contrast intermediate data structures (**Quadruples `(op, arg1, arg2, result)`**, **Triples `(op, arg1, arg2)`**, and **Indirect Triples**), formulate the **Static Single Assignment Invariant** (every variable is assigned a value **EXACTLY ONCE** in static program text), formulate the **$\phi$-Function ($\mathbf{x_3 = \phi(x_1, x_2)}$)** selecting runtime values at confluence points of the Control Flow Graph, and analyze why SSA form drastically simplifies global optimizations like constant propagation and dead code elimination in LLVM and GCC.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Three-Address Code, SSA Versioning Invariant, & Phi-Function Placement Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Conversion of Conditional Branching Code into SSA Form Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Intermediate Representation Entity & Structural Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Function Placed at Control Flow Joins to Select Between Variable Versions (phi) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Mathematical and Architectural Advantage of SSA Form in Modern Optimizing Compilers Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Three-Address Code & SSA Form (Cytron et al. 1991; Dragon Book Chapter 6):
   - **Three-Address Code (TAC):**
     - Linearized instructions with at most 1 operator and 3 addresses:
       $$\mathbf{x = y \text{ op } z \qquad x = \text{op } y \qquad x = y \qquad \text{if } x \text{ relop } y \text{ goto } L}$$
     - Representation formats: **Quadruples** `(op, arg1, arg2, res)` vs **Triples** `(op, arg1, arg2)`.
   - **Static Single Assignment (SSA Form - 1991):**
     - **The Fundamental Invariant:** Every variable is assigned **EXACTLY ONCE** statically!
     - Every variable assignment receives a unique subscript version ($x_1, x_2, x_3, \dots$).
   - **The $\phi$-Function (Phi-Node):**
     - At control flow merge points (e.g. after an `if-else` branch), insert a $\phi$-node:
       $$\mathbf{x_3 = \phi(x_1, x_2)}$$
     - Evaluates dynamically to $x_1$ if execution arrived from Branch 1, or $x_2$ if arrived from Branch 2.
   - **Dominance Frontiers:** The mathematically optimal placement of $\phi$-nodes occurs at the **Dominance Frontier ($DF(B)$)** of basic blocks defining variables.
2. **Slide 2 (`ordering`):** Provide 5 steps of converting code with an if-else statement into SSA form: (1) initialize all variable versions with index 0 at the entry basic block (e.g. x0 = 5), (2) in the 'then' branch block, rename target variable assignment to a new version (x1 = x0 + 10), (3) in the 'else' branch block, rename target variable assignment to an independent new version (x2 = x0 * 2), (4) at the join block where the two branches converge, insert a phi-function combining the reaching versions: x3 = phi(x1, x2), (5) update all subsequent downstream uses in following basic blocks to refer to version x3, finalizing the SSA representation!
3. **Slide 3 (`matching`):** Pair 4 IR concepts (Quadruple Representation, Static Single Assignment, Phi-Function phi(x1, x2), Dominance Frontier) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the merge function used in SSA form is called the phi function. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why SSA form enables faster and cleaner compiler optimizations: Why do modern production compilers like LLVM and GCC convert all intermediate code into Static Single Assignment (SSA) form before running optimization passes? (Because in SSA form, every variable use corresponds to **exactly ONE unique static definition site**, directly establishing **explicit Def-Use chains without requiring expensive iterative dataflow reaching definitions analysis**; this enables optimizations like Sparse Conditional Constant Propagation and Global Value Numbering to run in linear time).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "three_address_code_and_static_single_assignment_ssa",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Three-Address Code & SSA Form (Cytron 1991)**\n• **Three-Address Code (TAC) Format:**\n$$\n\\mathbf{x = y \\text{ op } z \\qquad x = \\text{op } y \\qquad x = y \\qquad \\text{if } x < y \\text{ goto } L}\n$$\n• **Static Single Assignment (SSA) Invariant:**\n$$\n\\mathbf{\\text{Every variable is assigned a value } \\mathbf{\\text{EXACTLY ONCE}} \\text{ in static program code!}}\n$$\n• **The $\\phi$-Function (Phi-Node at Control Joins):**\n$$\n\\mathbf{x_3 = \\phi(x_1, x_2) \\quad (\\text{selects } x_1 \\text{ if from path 1, } x_2 \\text{ if from path 2})}\n$$\n• **Optimal Placement:** Insert $\\phi$-functions at the **Dominance Frontiers ($DF$)** of defining basic blocks!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of converting a conditional if-else branch into Static Single Assignment (SSA) form.",
      "orderItems": [
        "Initialize variable version numbers at entry block (e.g. assign x0 and evaluate conditional predicate)",
        "In the 'then' basic block, rename the assignment to generate a fresh variable version (e.g. x1 = 10)",
        "In the 'else' basic block, rename the assignment to generate an independent version (e.g. x2 = 20)",
        "At the confluence join block where both control paths merge, insert phi-node: x3 = phi(x1, x2)",
        "Replace all subsequent downstream reads of variable x with version x3, preserving single assignment"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Intermediate Representation component to its exact role.",
      "matchPairs": [
        { "left": "Quadruple Format", "right": "Four-field IR record (op, arg1, arg2, result) with explicit storage for destination names" },
        { "left": "Static Single Assignment (SSA)", "right": "Intermediate representation property guaranteeing each variable name has exactly one definition site" },
        { "left": "Phi-Function: phi(x1, x2)", "right": "Control-flow multiplexer selecting variable version dynamically based on the arriving execution path" },
        { "left": "Dominance Frontier (DF)", "right": "Set of basic blocks where the dominance of a definition block ceases, dictating optimal phi placement" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In SSA intermediate representation, the special operator placed at control-flow join points to merge multiple reaching definitions is called a ___ function.",
      "blankAnswer": "phi",
      "blankDistractors": ["psi", "lambda", "sigma"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why do modern optimizing compilers (such as LLVM, GCC, and HotSpot) convert intermediate representations into Static Single Assignment (SSA) form before applying optimization passes?",
      "options": [
        { "text": "Because in SSA form, every variable use corresponds to exactly ONE static definition site, creating trivial explicit Def-Use chains without requiring expensive iterative reaching-definitions dataflow analysis; this makes optimizations like Constant Propagation, Dead Code Elimination, and Global Value Numbering significantly faster, cleaner, and more powerful", "isCorrect": true, "explanation": "Correct! This is why SSA form is universally adopted in modern compiler design (Cytron et al. 1991; Dragon Book Chapter 8). In standard non-SSA Three-Address Code, a variable like `x` can be reassigned multiple times across loops and branches. To know what value `x` holds at line 50, the compiler must perform a full, iterative dataflow analysis (Reaching Definitions) across the entire Control Flow Graph to determine which assignments could reach that point. In SSA form, because every variable is assigned exactly once ($x_1, x_2, x_3$), the variable name ITSELF identifies its unique definition point! The Def-Use chain is explicit and direct. If $x_1 = 5$ is defined, any use of $x_1$ anywhere in the program is guaranteed to be 5, making constant propagation, dead code elimination, and value numbering nearly instantaneous and trivial to implement." },
        { "text": "Because SSA form compresses the final executable file size by 90%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CPU hardware registers can only execute SSA instructions directly", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SSA form removes all conditional if statements from the source code", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
