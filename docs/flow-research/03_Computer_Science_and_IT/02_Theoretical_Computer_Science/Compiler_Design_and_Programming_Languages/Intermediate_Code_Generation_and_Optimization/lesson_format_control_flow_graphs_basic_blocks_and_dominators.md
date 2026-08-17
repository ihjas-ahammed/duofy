# Duofy Reusable Lesson Format: Control Flow Graphs (Basic Blocks and Dominators)

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Intermediate_Code_Generation_and_Optimization`  
**Lesson Format Type:** `control_flow_graphs_basic_blocks_and_dominators`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural partitioning of straight-line instruction sequences, directed flow graph modeling, and dominance tree relations of compiler Control Flow Graphs (Frances E. Allen 1970; Thomas Lengauer & Robert E. Tarjan 1979; Alfred V. Aho et al. *The Dragon Book* Chapters 8 & 9): master the **Basic Block Single-Entry Single-Exit Invariant** (a maximal sequence of contiguous instructions where execution enters only at the first instruction and leaves only at the last without stopping or branching), execute the **3-Rule Leaders Algorithm**, construct directed **Control Flow Graphs $G = (V, E)$**, formulate **Dominance Relations ($\mathbf{d \text{ dom } n}$ if every path from entry to $n$ passes through $d$)**, define **Immediate Dominators ($idom(n)$)** and **Dominance Trees**, and identify **Natural Loops and Back-Edges** for Loop Invariant Code Motion (LICM).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Basic Block Definition, 3-Rule Leaders Algorithm, & Dominance Tree Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Basic Block Partitioning via the Leaders Algorithm Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | CFG Component / Dominance Concept & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Single-Word Name for a Node d that Lies on Every Path from Entry to Node n (Dominator) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Identification of Natural Loops via Back-Edges and Dominator Trees Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CFGs, Basic Blocks, & Dominators (Allen 1970; Lengauer & Tarjan 1979; Dragon Book Chapter 8):
   - **Basic Block Invariant:**
     - A maximal sequence of consecutive Three-Address Code instructions such that:
       1. Control enters ONLY at the first instruction.
       2. Control leaves ONLY at the last instruction (no branching in the middle!).
   - **The 3-Rule Leaders Algorithm (Dragon Book Algorithm 8.5):**
     1. **Rule 1:** Instruction 1 is a Leader.
     2. **Rule 2:** Any instruction that is the **target of a conditional or unconditional jump** is a Leader.
     3. **Rule 3:** Any instruction that **immediately follows a conditional or unconditional jump** is a Leader.
     - A Basic Block consists of a leader and all instructions up to (but not including) the next leader.
   - **Dominance Theory (Lengauer-Tarjan 1979):**
     - Block $d$ **dominates** block $n$ ($d \text{ dom } n$) if every path from the entry node to $n$ must pass through $d$.
     - **Immediate Dominator ($idom(n)$):** The unique strict dominator of $n$ that does not dominate any other strict dominator of $n$.
     - **Back-Edge & Natural Loop:** An edge $a \to b$ is a *back-edge* if $b \text{ dom } a$. The natural loop of $a \to b$ is $b$ plus all nodes that can reach $a$ without passing through $b$.
2. **Slide 2 (`ordering`):** Provide 5 steps of partitioning Three-Address Code into basic blocks using the Leaders algorithm: (1) mark instruction 1 as the first leader of the program, (2) scan through all instructions to identify all jump targets (labels referenced by goto/if-goto) and mark them as leaders, (3) mark every instruction immediately following any goto or if-goto jump statement as a leader, (4) for each identified leader, collect all subsequent instructions up to the instruction immediately preceding the next leader to form a discrete basic block, (5) construct directed edges between basic blocks to generate the complete Control Flow Graph (CFG)!
3. **Slide 3 (`matching`):** Pair 4 CFG concepts (Leader Rule 1, Leader Rule 2, Immediate Dominator idom(n), Back-Edge a -> b) with their mathematical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a node d that lies on every path from entry to node n is called a dominator. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the formal definition and identification of natural compiler loops: In a Control Flow Graph, how is a 'natural loop' formally identified using dominance and edge classification? (A natural loop is defined by a **back-edge $a \to b$ where destination node $b$ dominates source node $a$ ($b \text{ dom } a$)**; the natural loop consists of loop header $b$ together with the set of all nodes that can reach $a$ along paths that do not pass through $b$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "control_flow_graphs_basic_blocks_and_dominators",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CFGs, Basic Blocks & Dominators (1979)**\n• **Basic Block Invariant:** Single-Entry, Single-Exit straight-line instruction sequence!\n• **The 3 Leaders Rules (Dragon Book Algorithm 8.5):**\n  1. **Rule 1:** Instruction 1 is a Leader.\n  2. **Rule 2:** Target of any conditional/unconditional jump is a Leader.\n  3. **Rule 3:** Instruction immediately following any jump is a Leader.\n• **Dominance Relations ($d \\text{ dom } n$):**\n$$\n\\mathbf{d \\text{ dom } n \\iff \\text{Every path from Entry to } n \\text{ must traverse block } d}\n$$\n• **Back-Edges & Natural Loops:** Edge $a \\to b$ is a back-edge $\\iff \\mathbf{b \\text{ dom } a}$ (forms loop with header $b$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of partitioning Three-Address Code into Basic Blocks using the Leaders Algorithm.",
      "orderItems": [
        "Mark the very first instruction of the intermediate code sequence as Leader 1",
        "Scan the program to locate all jump targets (labels of goto / if-goto statements) and mark them as leaders",
        "Identify and mark every instruction that immediately follows any conditional or unconditional jump statement",
        "Group each leader with all consecutive instructions up to (but not including) the next leader into a Basic Block",
        "Add directed control-flow edges between blocks (fall-through and branch targets) to construct the CFG"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Control Flow Graph concept to its exact theoretical definition.",
      "matchPairs": [
        { "left": "Leader Rule 2", "right": "Designates any instruction targeted by a branch or jump label as the start of a new basic block" },
        { "left": "Leader Rule 3", "right": "Designates the instruction immediately following a jump statement as a new basic block leader" },
        { "left": "Immediate Dominator (idom)", "right": "The unique closest strict dominator of node n in the rooted Dominator Tree hierarchy" },
        { "left": "Back-Edge: a -> b", "right": "Directed edge where destination header b dominates source node a (b dom a), defining a natural loop" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Control Flow Graph, block d is called a ___ of block n if every execution path from the entry node to n must pass through d.",
      "blankAnswer": "dominator",
      "blankDistractors": ["predecessor", "successor", "frontier"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How is a 'natural loop' formally identified in a Control Flow Graph during compiler optimization analysis?",
      "options": [
        { "text": "A natural loop is identified by finding a back-edge a -> b whose target header b dominates its source node a (b dom a); the natural loop is defined as node b plus all CFG nodes that can reach node a along directed paths that do not pass through loop header b", "isCorrect": true, "explanation": "Correct! This is the classic definition of natural loops developed by Frances Allen and formalized in the Dragon Book (Section 9.6). In compiler optimization (such as Loop Invariant Code Motion and loop unrolling), we must identify loops without relying on source syntax (since IR only has gotos and labels). A directed edge $a \\to b$ in a CFG is classified as a 'back-edge' if and only if destination node $b$ dominates source node $a$ ($b \\text{ dom } a$). The presence of a back-edge proves that control can flow from $a$ back to an ancestor node $b$ that was already traversed. The 'natural loop' associated with back-edge $a \\to b$ has $b$ as its single entry point (the 'loop header'). The body of the loop consists of node $b$ together with all nodes $m$ such that there is a path from $m$ to $a$ that does not contain $b$. This rigorous mathematical definition ensures the loop has a single entry, which is required for sound loop optimizations." },
        { "text": "A natural loop is any cycle that has exactly 3 basic blocks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A natural loop is identified by searching for while keywords in the assembly text", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A natural loop is an edge that connects a node to itself only", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
