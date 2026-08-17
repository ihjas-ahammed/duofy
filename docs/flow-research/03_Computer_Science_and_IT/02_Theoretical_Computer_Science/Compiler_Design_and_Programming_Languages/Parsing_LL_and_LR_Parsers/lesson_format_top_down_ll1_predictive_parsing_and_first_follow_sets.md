# Duofy Reusable Lesson Format: Top-Down LL(1) Predictive Parsing and FIRST/FOLLOW Sets

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Parsing_LL_and_LR_Parsers`  
**Lesson Format Type:** `top_down_ll1_predictive_parsing_and_first_follow_sets`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the lookahead prediction, FIRST and FOLLOW set mathematical equations, and table construction invariants of LL(1) Parsers (Alfred V. Aho et al. *The Dragon Book* Section 4.4; Donald E. Knuth): master the formal definitions of **$\text{FIRST}(\alpha)$** (set of all terminals that begin strings derived from $\alpha$) and **$\text{FOLLOW}(A)$** (set of all terminals that appear immediately to the right of variable $A$ in some sentential form, including endmarker `$` for start variable $S$), construct the **LL(1) Parsing Table $M[A, a]$**, formulate the **LL(1) Grammar Condition** (a grammar is LL(1) if and only if **for every pair of productions $A \to \alpha \mid \beta$: $\text{FIRST}(\alpha) \cap \text{FIRST}(\beta) = \emptyset$, and if $\alpha \Rightarrow^* \varepsilon$, then $\text{FIRST}(\beta) \cap \text{FOLLOW}(A) = \emptyset$**), and trace non-recursive predictive parsing using an explicit symbol stack.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | LL(1) Lookahead Invariants, FIRST/FOLLOW Equations, & Table Rules Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Predictive Stack Parser Execution Tracing an Input String Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | LL(1) Entity / Parsing Condition & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Special End-of-Input Terminal Symbol Seeded into the FOLLOW Set of the Start Variable ($) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason a Left-Recursive Grammar Can Never Be LL(1) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State LL(1) Predictive Parsing & FIRST/FOLLOW (Dragon Book Section 4.4):
   - **LL(1) Meaning:** Left-to-right scan, Leftmost derivation, **1** token of lookahead.
   - **FIRST($\alpha$) & FOLLOW($A$) Mathematical Definitions:**
     - $\mathbf{\text{FIRST}(\alpha) = \{a \in \Sigma \mid \alpha \Rightarrow^* a\beta\} \cup \{\varepsilon \text{ if } \alpha \Rightarrow^* \varepsilon\}}$.
     - $\mathbf{\text{FOLLOW}(A) = \{a \in \Sigma \mid S \Rightarrow^* \alpha A a \beta\} \cup \{\$ \text{ if } A = S\}}$.
   - **LL(1) Parse Table Construction Algorithm (Table $M[A, a]$):**
     - For each production rule $A \to \alpha$:
       1. For every terminal $a \in \text{FIRST}(\alpha)$, add $A \to \alpha$ to $M[A, a]$.
       2. If $\varepsilon \in \text{FIRST}(\alpha)$, for every terminal $b \in \text{FOLLOW}(A)$ (including `$`): add $A \to \alpha$ to $M[A, b]$.
   - **The LL(1) Grammar Condition:**
     $$\mathbf{G \text{ is LL(1)} \iff \mathbf{\text{No cell in table } M[A, a] \text{ contains multiple production rules!}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the non-recursive LL(1) predictive stack parsing loop: (1) initialize the parsing stack with the endmarker $ followed by the grammar start symbol S on top, (2) read the first input lookahead token a from the input buffer, (3) if stack top is a terminal matching lookahead a, pop it from stack and advance input pointer to next token, (4) if stack top is a non-terminal A, consult table M[A, a] to fetch production rule A -> X1 X2 ... Xk, (5) pop non-terminal A from stack and push rule RHS symbols in reverse order (Xk down to X1), repeating until stack and input are simultaneously empty ($ matches $)!
3. **Slide 3 (`matching`):** Pair 4 LL(1) parsing concepts (FIRST Set, FOLLOW Set, LL(1) Table Cell M[A, a], Predictive Stack Top Match) with their mathematical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the special endmarker symbol placed into the FOLLOW set of the start symbol is the dollar sign $. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why left-recursive grammars cannot be parsed by LL(1) predictive parsers: Why is any context-free grammar containing an immediate left-recursive rule $A \to A\alpha \mid \beta$ mathematically incapable of being parsed by an LL(1) parser? (Because for rule $A \to A\alpha$, any terminal $a \in \text{FIRST}(\beta)$ is automatically in $\text{FIRST}(A\alpha)$ as well as $\text{FIRST}(\beta)$; this causes both productions $A \to A\alpha$ and $A \to \beta$ to be placed into the exact same table cell $M[A, a]$, **creating a fatal multi-entry table conflict and causing a top-down parser to enter an infinite predictive expansion loop**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "top_down_ll1_predictive_parsing_and_first_follow_sets",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: LL(1) Predictive Parsing & FIRST/FOLLOW (Dragon Book 4.4)**\n• **FIRST & FOLLOW Formal Definitions:**\n$$\n\\mathbf{\\text{FIRST}(\\alpha) = \\{a \\in \\Sigma \\mid \\alpha \\Rightarrow^* a\\beta\\} \\qquad \\text{FOLLOW}(A) = \\{a \\in \\Sigma \\cup \\{\\$\\} \\mid S \\Rightarrow^* \\alpha A a \\beta\\}}\n$$\n• **LL(1) Parse Table Construction Rules:**\n  1. For each $a \\in \\text{FIRST}(\\alpha) \\implies$ Add $\\mathbf{A \\to \\alpha}$ to $\\mathbf{M[A, a]}$.\n  2. If $\\varepsilon \\in \\text{FIRST}(\\alpha) \\implies$ For each $b \\in \\text{FOLLOW}(A)$, add $\\mathbf{A \\to \\alpha}$ to $\\mathbf{M[A, b]}$.\n• **The LL(1) Invariant:**\n$$\n\\mathbf{G \\text{ is LL(1)} \\iff \\mathbf{\\text{Every table cell } M[A, a] \\text{ contains AT MOST ONE production rule!}}}\n$$\n• **Disqualification:** Left-recursive and non-left-factored grammars are **NEVER LL(1)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of a non-recursive predictive LL(1) parser processing an input string.",
      "orderItems": [
        "Initialize the parser stack with the bottom endmarker $ followed by the start non-terminal S on top",
        "Inspect the current input lookahead token a from the lexical scanner stream",
        "If stack top is a terminal matching lookahead a, pop it from stack and advance input pointer to next token",
        "If stack top is non-terminal A, consult table M[A, a] to retrieve production rule A -> X1 X2 ... Xk",
        "Pop non-terminal A and push body symbols in reverse order (Xk down to X1), repeating until both stack and input equal $"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each LL(1) Parsing component to its exact mathematical responsibility.",
      "matchPairs": [
        { "left": "FIRST(alpha) Set", "right": "Set of all terminal characters that can appear as the very first symbol in derivations of alpha" },
        { "left": "FOLLOW(A) Set", "right": "Set of all terminals that can appear immediately to the right of variable A in some sentential form" },
        { "left": "Table Entry M[A, b] via FOLLOW", "right": "Dictates expanding A -> alpha when alpha derives epsilon and lookahead matches FOLLOW(A)" },
        { "left": "LL(1) Conflict", "right": "Occurrence of multiple production rules competing inside the exact same table cell M[A, a]" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In compiler syntax analysis, the special endmarker terminal symbol seeded into FOLLOW of the start symbol is the ___ character.",
      "blankAnswer": "$",
      "blankDistractors": ["EOF", "NUL", "#"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is any grammar containing an immediate left-recursive rule (A -> A alpha | beta) mathematically disqualified from being an LL(1) grammar?",
      "options": [
        { "text": "Because FIRST(A alpha) contains all symbols in FIRST(beta); this forces both production rules A -> A alpha and A -> beta to be entered into the exact same table cells M[A, a] for every terminal a in FIRST(beta), creating multi-entry table conflicts and causing a top-down parser to enter an infinite predictive loop trying to expand A endlessly", "isCorrect": true, "explanation": "Correct! This is the classic structural flaw that disqualifies left-recursive grammars from top-down LL parsing (Dragon Book Section 4.3). Consider the grammar $A \\to A\\alpha \\mid \\beta$ where $\\beta$ does not begin with $A$: 1. By definition, $\\text{FIRST}(A)$ includes $\\text{FIRST}(\\beta)$. 2. For the rule $A \\to A\\alpha$, its FIRST set is $\\text{FIRST}(A\\alpha) = \\text{FIRST}(A)$, which contains every terminal in $\\text{FIRST}(\\beta)$. 3. For the rule $A \\to \\beta$, its FIRST set is $\\text{FIRST}(\\beta)$. 4. When constructing the LL(1) parse table, for every terminal $a \\in \\text{FIRST}(\\beta)$, the table construction algorithm will add rule $1$ ($A \\to A\\alpha$) to cell $M[A, a]$ AND will ALSO add rule $2$ ($A \\to \\beta$) to the exact same cell $M[A, a]$! 5. Because cell $M[A, a]$ now contains multiple entries, the grammar is NOT LL(1). Furthermore, if a top-down predictive parser tried to parse $A$ on lookahead $a$, choosing $A \\to A\\alpha$ would place $A$ back on top of the stack without consuming any input, causing the parser to loop infinitely. Therefore, all left recursion must be eliminated before constructing an LL(1) parser." },
        { "text": "Because left recursion is forbidden in C and Java compilers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because left-recursive grammars have no terminal symbols", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because LL(1) parsers only read input from right to left", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
