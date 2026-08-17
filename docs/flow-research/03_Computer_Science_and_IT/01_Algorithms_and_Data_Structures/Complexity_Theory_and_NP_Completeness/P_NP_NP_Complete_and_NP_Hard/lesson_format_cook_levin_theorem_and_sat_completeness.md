# Duofy Reusable Lesson Format: Cook-Levin Theorem and SAT Completeness

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Complexity_Theory_and_NP_Completeness / P_NP_NP_Complete_and_NP_Hard`  
**Lesson Format Type:** `cook_levin_theorem_and_sat_completeness`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the foundational theorem of computational complexity theory proving the existence of NP-Complete problems (Stephen A. Cook 1971, *The Complexity of Theorem-Proving Procedures*; Leonid Levin 1973; Michael Sipser; Thomas H. Cormen et al. CLRS Chapter 34): master the formulation of the **Boolean Satisfiability Problem (SAT / CNF-SAT)**, evaluate why proving the FIRST NP-Complete problem required a universal reduction from all conceivable NDTMs rather than reducing from an existing problem, master the **Tableau Simulation Construction** (representing the complete execution trace of any polynomial-time Non-Deterministic Turing Machine as an $n^k \times n^k$ grid of tape cells), construct the 4 Boolean formula clause groups (**$\phi_{\text{cell}}$ [each cell holds 1 symbol]**, **$\phi_{\text{start}}$ [initial configuration]**, **$\phi_{\text{accept}}$ [accept state reached]**, and **$\phi_{\text{move}}$ [valid $2 \times 3$ window transitions]**), and prove that $\phi = \phi_{\text{cell}} \land \phi_{\text{start}} \land \phi_{\text{accept}} \land \phi_{\text{move}}$ is satisfiable if and only if the machine accepts input $w$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The Cook-Levin Theorem, SAT Formulation, & Tableau Encoding Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction of the 4 SAT Tableau Boolean Clauses Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cook-Levin Tableau Formula Component & Logical Invariant Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Year Stephen Cook Published the Proof That SAT is NP-Complete Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Historical Reason Cook-Levin Could Not Use a Standard Reduction Proof Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Cook-Levin Theorem (Cook 1971; Levin 1973; Sipser):
   - **The Milestone Theorem:** The Boolean Satisfiability problem (**SAT**) is **NP-Complete**!
   - **The SAT Problem Definition:**
     - Given a Boolean formula in Conjunctive Normal Form (CNF): $\phi = C_1 \land C_2 \land \dots \land C_m$ (where each clause $C_j = (l_1 \lor l_2 \lor \dots)$ is a disjunction of literals).
     - Does there exist a truth assignment $\tau: V \to \{0, 1\}$ such that $\phi(\tau) = 1$ (True)?
   - **The Universal Tableau Construction Proof (Sipser Chapter 7):**
     - Let $N$ be any NDTM deciding language $A \in \text{NP}$ in time $n^k$.
     - Represent the computation of $N$ on input $w$ as an **$n^k \times n^k$ 2D grid (Tableau)** of tape cells.
     - Construct a Boolean CNF formula $\mathbf{\phi = \phi_{\text{cell}} \land \phi_{\text{start}} \land \phi_{\text{accept}} \land \phi_{\text{move}}}$:
       - $\phi_{\text{cell}}$: Exactly one symbol appears in each cell $(i, j)$ of the tableau.
       - $\phi_{\text{start}}$: Row 1 represents the initial configuration $q_0 w_1 w_2 \dots w_n \sqcup \dots \sqcup$.
       - $\phi_{\text{accept}}$: At least one cell contains the accepting state $q_{\text{accept}}$.
       - $\phi_{\text{move}}$: Every $2 \times 3$ window of cells in the grid follows valid Turing machine transition rules $\delta$.
     - **Size & Reducibility:** Formula $\phi$ has size $O(n^{2k})$ (polynomial in $|w|$) and can be constructed in polynomial time $\implies \mathbf{A \le_P \text{SAT}}$ for all $A \in \text{NP}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Cook-Levin tableau reduction pipeline: (1) represent the polynomial-time computation of an arbitrary NDTM as an n^k by n^k spacetime configuration grid, (2) introduce boolean variables x_{i,j,s} asserting that cell (i,j) contains tape symbol or state s, (3) encode cell uniqueness clauses (phi_cell) ensuring each square contains exactly one symbol, (4) encode boundary clauses enforcing the start configuration on row 1 and the accept state in row n^k, (5) encode 2x3 local window transition clauses (phi_move) verifying that every step obeys machine transition function delta, producing polynomial CNF formula phi!
3. **Slide 3 (`matching`):** Pair 4 Cook-Levin formula components (phi_cell, phi_start, phi_accept, phi_move) with their logical constraints.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Stephen Cook published his landmark NP-completeness paper in 1971. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why proving the Cook-Levin theorem required a universal reduction from all Turing machines rather than a standard reduction from an existing problem: Why couldn't Stephen Cook prove that SAT was NP-Complete by reducing another NP-Complete problem to SAT (the way subsequent problems like 3-SAT and Clique were proven)? (Because prior to Cook's 1971 paper, **NO NP-Complete problems were known to exist**; to bootstrap the entire field of NP-Completeness, Cook had to construct a **generic reduction proving that EVERY arbitrary language in NP reduces to SAT directly via Turing machine simulation**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cook_levin_theorem_and_sat_completeness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Cook-Levin Theorem (1971 / 1973)**\n• **The Landmark Discovery:** Boolean Satisfiability ($\\mathbf{\\text{SAT}}$) is **NP-Complete**!\n• **The SAT Problem:** Find truth assignment $\\tau$ making CNF formula $\\phi = \\bigwedge C_j$ evaluate to True.\n• **The Spacetime Tableau Construction ($n^k \\times n^k$ Grid):**\n$$\n\\mathbf{\\phi = \\phi_{\\text{cell}} \\ \\land \\ \\phi_{\\text{start}} \\ \\land \\ \\phi_{\\text{accept}} \\ \\land \\ \\phi_{\\text{move}}}\n$$\n  1. $\\mathbf{\\phi_{\\text{cell}}}$: Exactly one tape symbol per grid cell ($x_{i,j,s}$).\n  2. $\\mathbf{\\phi_{\\text{start}}}$: Row 1 encodes initial state $q_0 w_1 w_2 \\dots w_n$.\n  3. $\\mathbf{\\phi_{\\text{accept}}}$: Grid contains accepting state $q_{\\text{accept}}$.\n  4. $\\mathbf{\\phi_{\\text{move}}}$: Every $2 \\times 3$ window obeys Turing transition $\\delta$!\n• **Significance:** Proved $\\mathbf{\\forall A \\in \\text{NP}, \\ A \\le_P \\text{SAT}}$ in polynomial size $O(n^{2k})$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of constructing the Cook-Levin Boolean formula simulating an arbitrary Turing machine.",
      "orderItems": [
        "Construct an n^k by n^k spacetime tableau grid representing tape contents and head states across all time steps",
        "Define boolean variables x_(i,j,s) indicating whether grid position (i,j) contains symbol or state s",
        "Generate uniqueness clauses (phi_cell) ensuring every cell contains at least one and at most one valid symbol",
        "Generate boundary clauses (phi_start and phi_accept) locking row 1 to input w and requiring an accept state",
        "Generate local window clauses (phi_move) verifying that all 2x3 cell neighborhoods follow valid machine transitions delta"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Cook-Levin formula clause group to its exact logical invariant.",
      "matchPairs": [
        { "left": "phi_cell Clauses", "right": "Guarantees that each grid cell in the spacetime tableau contains exactly one symbol" },
        { "left": "phi_start Clauses", "right": "Forces the first row of the tableau to match the machine's initial configuration on input w" },
        { "left": "phi_accept Clauses", "right": "Requires that the machine state in at least one cell of the tableau is the accept state q_accept" },
        { "left": "phi_move Clauses", "right": "Enforces that state transitions between consecutive rows obey the NDTM transition function delta" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Stephen Cook established the NP-completeness of SAT in his foundational paper published in the year ___.",
      "blankAnswer": "1971",
      "blankDistractors": ["1950", "1999", "1985"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why was Stephen Cook unable to prove that SAT was NP-Complete using a standard reduction from an existing NP-Complete problem?",
      "options": [
        { "text": "Because prior to Cook's 1971 paper, zero NP-Complete problems were known to exist in mathematics; to bootstrap the entire field of computational complexity, Cook had to construct a universal reduction demonstrating that EVERY conceivable polynomial-time Non-Deterministic Turing Machine could be translated directly into a Boolean formula", "isCorrect": true, "explanation": "Correct! Today, when computer scientists prove a new problem X is NP-Complete, they use the technique established by Richard Karp: show X is in NP, and reduce an ALREADY KNOWN NP-Complete problem (like 3-SAT or Vertex Cover) to X in polynomial time ($3\\text{-SAT} \\le_P X$). However, Stephen Cook (and independently Leonid Levin in the USSR) had no existing NP-Complete problem to reduce from—none had ever been identified in history! Cook had to prove NP-Completeness from absolute first principles. By definition, a problem is NP-Hard if EVERY language $A \\in \\text{NP}$ reduces to it ($A \\le_P \\text{SAT}$). Cook had to take the abstract definition of ANY arbitrary Non-Deterministic Turing Machine $N$ running in polynomial time $O(n^k)$, and construct an explicit algebraic compiler that converts the physical execution tape of that machine into a Boolean CNF formula. This monumental breakthrough established the existence of NP-Completeness and founded modern computational complexity theory." },
        { "text": "Because Boolean logic was invented after Turing machines", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because reduction algorithms had not been programmed in C++ yet", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all NP problems were previously classified as undecidable", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
