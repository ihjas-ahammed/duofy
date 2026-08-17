# Key to Flow: Parsing LL and LR Parsers (LL(1), FIRST/FOLLOW, SLR(1), CLR(1), & LALR(1) Merging)

**Subject Area:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Parsing_LL_and_LR_Parsers`

---

## 📌 Core Concept & Mental Model
**Top-Down Predictive LL(1) Descents, Lookahead FIRST/FOLLOW Confluence, Bottom-Up Handle Pruning, Dot-Item State DFA Automata, and LALR(1) Core Merging** govern syntax analysis, AST generation, and grammar parsing across production compilers (Donald E. Knuth 1965, Stephen C. Johnson 1975, Alfred V. Aho, Monica S. Lam, Ravi Sethi, & Jeffrey D. Ullman *The Dragon Book* Chapter 4):
* **1. Top-Down LL(1) Predictive Parsing:**
  - **FIRST($\alpha$):** Set of all terminal symbols that can begin strings derived from $\alpha$ (plus $\varepsilon$ if $\alpha \Rightarrow^* \varepsilon$).
  - **FOLLOW($A$):** Set of all terminal symbols that can appear immediately to the right of non-terminal $A$ in some sentential form (with `$` in $\text{FOLLOW}(S)$).
  - **LL(1) Table Invariant:** For rule $A \to \alpha$:
    1. For each $a \in \text{FIRST}(\alpha)$, add $A \to \alpha$ to $M[A, a]$.
    2. If $\varepsilon \in \text{FIRST}(\alpha)$, for each $b \in \text{FOLLOW}(A)$, add $A \to \alpha$ to $M[A, b]$.
  - **LL(1) Condition:** A grammar is LL(1) $\iff$ **No cell in table $M$ contains multiple entries!**
* **2. The Hierarchy of LR Parsers (Knuth 1965):**
  $$\mathbf{LL(1) \subset LR(0) \subset SLR(1) \subset LALR(1) \subset CLR(1) \subset LR(k)}$$
* **3. LR Item Mechanics & Automata Construction:**
  - **$\text{LR}(0)$ Item:** A production with a dot representing parser progress: $\mathbf{A \to \alpha \cdot \beta}$.
  - **$\text{CLOSURE}(I)$ & $\text{GOTO}(I, X)$:** Constructs the Canonical Collection of LR items (DFA state machine).
  - **SLR(1) Reduction Rule:** In state $I$, if item $A \to \alpha \cdot$ exists, place $\text{reduce}(A \to \alpha)$ **ONLY for terminals $a \in \text{FOLLOW}(A)$**!
* **4. CLR(1) vs LALR(1) (Yacc / Bison Foundation):**
  - **$\text{LR}(1)$ Item:** $[A \to \alpha \cdot \beta, a]$ where $a \in \Sigma \cup \{\$\}$ is the explicit lookahead terminal.
  - **CLR(1) (Canonical LR):** Explodes to thousands of states because lookaheads split states with identical cores.
  - **LALR(1) (Look-Ahead LR - Johnson 1975):**
    - Merges all CLR(1) states that have the **SAME LR(0) CORE** (same production rules and dot positions), taking the union of their lookaheads.
    - **Conflict Invariants:**
      - Merging states **CANNOT introduce new Shift-Reduce conflicts**.
      - Merging states **CAN introduce new Reduce-Reduce conflicts**!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Parser Decision Spectrum
* **Top-Down (LL):** "What rule should I expand next based on lookahead?" $\to$ Need FIRST/FOLLOW.
* **Bottom-Up (LR):** "Should I Shift the next token onto the stack, or Reduce a completed rule?" $\to$ Need LR Item DFA.

### 2. Top Recommended Resources
* **The Compiler Standard:** *Compilers: Principles, Techniques, and Tools* (The Dragon Book), Chapter 4 (Syntax Analysis).
* **Modern Parsing:** *Modern Compiler Implementation in C/Java/ML* by Andrew Appel.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute FIRST and FOLLOW sets for an arbitrary Context-Free Grammar?
- [ ] Can you eliminate Left Recursion and Left Factor a grammar to make it LL(1)?
- [ ] Can you construct the Canonical Collection of LR(0) items using CLOSURE and GOTO?
- [ ] Can you explain why LALR(1) state merging can create Reduce-Reduce conflicts but not Shift-Reduce conflicts?
