# Duofy Reusable Lesson Format: LR(0) and SLR(1) Bottom-Up Shift-Reduce Parsing

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Parsing_LL_and_LR_Parsers`  
**Lesson Format Type:** `lr0_and_slr1_bottom_up_shift_reduce_parsing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the bottom-up handle pruning mechanics, LR(0) item closure automata, and Simple LR (SLR(1)) reduction lookahead heuristics of bottom-up shift-reduce parsing (Donald E. Knuth 1965; Frank L. DeRemer 1971; Alfred V. Aho et al. *The Dragon Book* Section 4.5 & 4.6): master the **4 Shift-Reduce Parser Actions (Shift, Reduce, Accept, Error)**, define **$\text{LR}(0)$ Items ($A \to \alpha \cdot \beta$)** tracking parsing progress via the dot position, construct the **Canonical Collection of LR(0) Items** using the **$\text{CLOSURE}(I)$** and **$\text{GOTO}(I, X)$** functions, contrast **LR(0) Unconditional Reduction** with the **SLR(1) Selective Reduction Heuristic** (placing $\text{reduce}(A \to \alpha)$ in state $I$ **ONLY under terminals belonging to $\text{FOLLOW}(A)$**), and resolve classical **Shift-Reduce and Reduce-Reduce Conflicts**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | LR(0) Item Dot Notation, CLOSURE / GOTO Functions, & SLR(1) Reduction Rule Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction of the Canonical Collection of LR(0) Item Sets Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Bottom-Up Parser Term / Action & Operational Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Substring in a Sentential Form That Matches a Production RHS and is Replaced During Reduction (Handle) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason SLR(1) Selects Reductions Only on FOLLOW(A) to Eliminate Conflicts Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State LR(0) & SLR(1) Parsing (Knuth 1965; DeRemer 1971; Dragon Book Chapter 4):
   - **The 4 Parser Actions:**
     1. **Shift ($s_k$):** Push next token and target state $k$ onto stack.
     2. **Reduce ($r_j$):** Pop $2 \times |\beta|$ items from stack for rule $A \to \beta$, consult `GOTO` table, and push non-terminal $A$ and new state.
     3. **Accept:** Grammar root reduced; input exhausted successfully!
     4. **Error:** Empty table entry $\implies$ Syntax Error.
   - **$\text{LR}(0)$ Items & Dot Notation:**
     - $A \to \cdot X Y Z$ (Initial: expect to see $X$), $A \to X \cdot Y Z$ (Shifted $X$), $A \to X Y Z \cdot$ (Complete: ready to **Reduce**!).
   - **SLR(1) Selective Reduction Rule (DeRemer 1971):**
     - For state $I_i$, if complete item $A \to \alpha \cdot$ is present:
       $$\mathbf{\text{Set } \text{ACTION}[i, a] = \text{Reduce}(A \to \alpha) \quad \mathbf{\text{FOR ALL } a \in \text{FOLLOW}(A)}}$$
     - (And set $\text{ACTION}[i, \$] = \text{Accept}$ if $S' \to S \cdot$ is in $I_i$).
2. **Slide 2 (`ordering`):** Provide 5 steps of constructing the Canonical Collection of LR(0) items: (1) augment the grammar by introducing a new start variable S' with rule S' -> S, (2) initialize start state I0 as CLOSURE({S' -> . S}), (3) for each existing state I and grammar symbol X, compute GOTO(I, X) = CLOSURE({A -> alpha X . beta | A -> alpha . X beta in I}), (4) if GOTO(I, X) produces a non-empty new item set, add it as a new state in the collection, (5) repeat GOTO and CLOSURE operations until no new states are discovered, forming the complete LR(0) DFA state machine!
3. **Slide 3 (`matching`):** Pair 4 bottom-up parsing concepts (Shift Action, Reduce Action, LR(0) Item Dot, SLR(1) FOLLOW Rule) with their functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the substring matching the RHS of a production to be reduced is called a handle. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how SLR(1) eliminates LR(0) conflicts: Why does the SLR(1) parser construction algorithm succeed on many grammars that fail under pure LR(0) parsing? (Because an LR(0) parser places a reduce action **blindly into EVERY column of the action table** whenever a state contains a complete item $A \to \alpha \cdot$, immediately conflicting with any shift actions; an SLR(1) parser **places the reduce action ONLY in the table columns for terminals in $\text{FOLLOW}(A)$**, preventing conflicts whenever the lookahead symbol cannot legally follow variable $A$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lr0_and_slr1_bottom_up_shift_reduce_parsing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: LR(0) & SLR(1) Shift-Reduce Parsing (1971)**\n• **The 4 Shift-Reduce Parser Actions:**\n$$\n\\mathbf{\\text{Shift } (s_k) \\qquad \\text{Reduce } (r_j) \\qquad \\text{Accept} \\qquad \\text{Error}}\n$$\n• **LR(0) Item Dot Notation:**\n  - $A \\to \\alpha \\cdot \\beta$ : Indicates $\\alpha$ has been parsed; expecting to see $\\beta$.\n  - $\\mathbf{A \\to \\alpha \\cdot}$ : Complete item $\\implies$ **Ready to REDUCE!**\n• **SLR(1) Reduction Rule (DeRemer 1971):**\n$$\n\\mathbf{\\text{If } [A \\to \\alpha \\cdot] \\in I_i \\implies \\mathbf{\\text{Set } \\text{ACTION}[i, a] = \\text{Reduce}(A \\to \\alpha) \\quad \\forall a \\in \\mathbf{\\text{FOLLOW}(A)}!}}\n$$\n• **Advantage over LR(0):** Restricting reductions to $\\text{FOLLOW}(A)$ eliminates shift-reduce conflicts!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of constructing the Canonical Collection of LR(0) Item Sets for a grammar.",
      "orderItems": [
        "Augment the original grammar by introducing a dedicated start variable S' with production S' -> S",
        "Construct the initial state I0 by computing CLOSURE({S' -> . S})",
        "Iterate through each state I and compute target state GOTO(I, X) for every grammar symbol X",
        "If GOTO(I, X) generates a distinct non-empty item set, register it as a new state in the DFA collection",
        "Repeat GOTO transitions and CLOSURE calculations until a fixed point is reached with no new states"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Bottom-Up Shift-Reduce concept to its exact operational role.",
      "matchPairs": [
        { "left": "Shift Action (s_k)", "right": "Pushes the current input terminal and target DFA state number k onto the parsing stack" },
        { "left": "Reduce Action (r_j)", "right": "Pops 2 * |RHS| elements from stack, replaces with LHS variable, and consults GOTO table" },
        { "left": "LR(0) Complete Item", "right": "Production item with dot at the far right end (A -> alpha .), indicating rule completion" },
        { "left": "SLR(1) Lookahead Filter", "right": "Restricts reduce action placement exclusively to terminal columns belonging to FOLLOW(A)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In bottom-up parsing, the substring of a sentential form that matches the right-hand side of a production rule is called a ___.",
      "blankAnswer": "handle",
      "blankDistractors": ["pivot", "kernel", "closure"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the primary architectural reason why Simple LR (SLR(1)) parsers can parse many grammars that fail with conflicts in pure LR(0) parsers?",
      "options": [
        { "text": "In pure LR(0) parsing, whenever a state contains a completed item A -> alpha ., a reduce action is blindly placed in EVERY terminal column of that state's row; in SLR(1), the reduce action is selectively placed ONLY under terminal columns that belong to FOLLOW(A), avoiding conflicts whenever a competing shift action uses a lookahead terminal that cannot legally follow variable A", "isCorrect": true, "explanation": "Correct! This is the defining difference between LR(0) and SLR(1) parsing (Dragon Book Section 4.6). In an LR(0) parser, the table construction algorithm has no lookahead information whatsoever. If a state $I_i$ contains a completed item $A \\to \\alpha \\cdot$, the parser places `reduce(A -> alpha)` into EVERY single terminal column of row $i$. If state $I_i$ ALSO contains a shift item like $B \\to \beta \cdot a \gamma$, the cell for terminal $a$ will contain BOTH `shift` and `reduce`, creating a fatal Shift-Reduce conflict. Frank DeRemer observed that after reducing $A \\to \alpha$, the non-terminal $A$ can ONLY ever be legally followed by terminal characters that belong to $\text{FOLLOW}(A)$. Therefore, in SLR(1), we place the reduce action ONLY in the columns for $a \in \text{FOLLOW}(A)$. If the shift terminal $a$ is NOT in $\text{FOLLOW}(A)$, the shift-reduce conflict disappears completely! This makes SLR(1) significantly more powerful than LR(0) with zero increase in state count." },
        { "text": "Because SLR(1) parsers use multi-core GPU acceleration", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SLR(1) parsers convert bottom-up parsing into top-down parsing", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because LR(0) parsers cannot parse arithmetic operations", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
