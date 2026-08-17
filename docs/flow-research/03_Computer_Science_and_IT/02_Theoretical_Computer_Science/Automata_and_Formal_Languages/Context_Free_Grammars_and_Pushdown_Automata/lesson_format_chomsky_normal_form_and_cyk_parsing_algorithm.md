# Duofy Reusable Lesson Format: Chomsky Normal Form and CYK Parsing Algorithm

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Automata_and_Formal_Languages / Context_Free_Grammars_and_Pushdown_Automata`  
**Lesson Format Type:** `chomsky_normal_form_and_cyk_parsing_algorithm`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 4-step grammar normalization protocol and dynamic programming table parsing of Chomsky Normal Form (CNF) and the CYK (Cocke-Younger-Kasami) algorithm (Noam Chomsky 1959; John Cocke, Daniel H. Younger, & Tadao Kasami 1965; Michael Sipser Chapter 2): master the strict **CNF Production Rule Syntax ($\mathbf{A \to BC}$ or $\mathbf{A \to a}$, and optionally $S_0 \to \varepsilon$)**, execute the **4 Normalization Steps** (1. Add new start symbol $S_0 \to S$, 2. Eliminate $\varepsilon$-rules $A \to \varepsilon$, 3. Eliminate unit rules $A \to B$, and 4. Binarize long rules and replace mixed terminals), prove why a derivation in CNF for a string of length $n$ requires **exactly $2n - 1$ steps**, formulate the **CYK Triangular DP Parsing Table ($T[i, j] = \bigcup_{k=i}^{j-1} \{A \mid A \to BC, B \in T[i, k], C \in T[k+1, j]\}$)**, and analyze its **$O(n^3 \cdot |G|)$ time complexity**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CNF Syntax Definition, 2n - 1 Derivation Steps, & CYK DP Table Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 4-Phase CFG to Chomsky Normal Form Conversion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Normal Form Conversion Step / CYK Entity & Mathematical Operation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Total Number of Derivation Steps to Generate String of Length n in CNF (2n - 1) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Dynamic Programming Subproblem Invariant of the CYK Parsing Algorithm Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Chomsky Normal Form & CYK Parsing (Chomsky 1959; CYK 1965; Sipser):
   - **Chomsky Normal Form (CNF) Invariant:**
     - A grammar is in CNF if EVERY production rule is strictly of the form:
       $$\mathbf{A \to BC \quad (\text{Exactly two non-terminals})} \qquad \text{or} \qquad \mathbf{A \to a \quad (\text{Exactly one terminal})}$$
       (plus $S_0 \to \varepsilon$ if $\varepsilon \in L(G)$, with $S_0$ never appearing on any RHS).
   - **Theorem: Derivation Length in CNF:**
     - To generate any non-empty string $w$ of length $n = |w|$:
       $$\mathbf{\text{Exact Number of Derivation Steps} = \mathbf{2n - 1}} \quad (n-1 \text{ binary rules } A \to BC \ + \ n \text{ terminal rules } A \to a)$$
   - **The CYK Dynamic Programming Parsing Algorithm:**
     - Given string $w = w_1 w_2 \dots w_n$ and CNF grammar $G$.
     - Base Case (Length 1): $T[i, i] = \{A \mid A \to w_i \in R\}$.
     - Induction (Substrings of length $L = 2 \dots n$ from index $i$ to $j = i + L - 1$):
       $$\mathbf{T[i, j] = \bigcup_{k=i}^{j-1} \Big\{ A \in V \mid A \to BC \in R, \ B \in T[i, k], \ C \in T[k+1, j] \Big\}}$$
     - **Acceptance:** $w \in L(G) \iff \mathbf{S_0 \in T[1, n]}$ in $\mathbf{O(n^3 \cdot |G|)\text{ Time}}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of the 4-phase algorithm converting an arbitrary CFG into Chomsky Normal Form: (1) add a new start symbol S0 with production rule S0 -> S to ensure the start variable never appears on the right-hand side, (2) eliminate all epsilon-rules A -> epsilon by finding nullable variables and adding all combinations of rules with nullable variables removed, (3) eliminate all unit rules A -> B by replacing them with all non-unit productions B -> gamma, (4) replace all terminals in multi-symbol rules with new dummy non-terminal variables (e.g. U_a -> a), (5) binarize long rules with >= 3 variables (A -> B1 B2 ... Bk) into cascades of binary rules using new intermediate variables, finalizing the CNF grammar!
3. **Slide 3 (`matching`):** Pair 4 CNF/CYK components (CNF Syntax Rule, Derivation Step Count 2n-1, CYK Base Case T[i, i], CYK Time Complexity O(n^3 * |G|)) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that generating a string of length n in CNF takes exactly 2n minus 1 derivation steps. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how CYK dynamic programming guarantees deciding language membership: How does the CYK algorithm determine whether a non-terminal $A$ can generate the entire string $w = w_1 w_2 \dots w_n$? (CYK systematically builds a triangular table where cell $T[i, j]$ holds all non-terminals capable of deriving substring $w[i \dots j]$; it tests all possible split points $k$ between $i$ and $j-1$, **combining smaller solved subproblems ($B \in T[i, k]$ and $C \in T[k+1, j]$) to check if $A \to BC$ exists in the grammar; string $w$ is accepted if and only if start symbol $S_0 \in T[1, n]$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "chomsky_normal_form_and_cyk_parsing_algorithm",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Chomsky Normal Form & CYK Parsing (1965)**\n• **CNF Syntax Rules (Sipser Definition 2.8):**\n$$\n\\mathbf{A \\to BC \\quad (\\text{Two Variables})} \\qquad \\text{or} \\qquad \\mathbf{A \\to a \\quad (\\text{One Terminal})}\n$$\n• **Exact Derivation Length Invariant:**\n$$\n\\mathbf{\\text{Steps to derive string of length } n = \\mathbf{2n - 1} \\quad (n-1 \\text{ split steps } + n \\text{ terminal steps})}\n$$\n• **The CYK Parsing Recurrence ($O(n^3 \\cdot |G|)$ Time):**\n$$\n\\mathbf{T[i, j] = \\bigcup_{k=i}^{j-1} \\Big\\{ A \\mid A \\to BC \\in R, \\ B \\in T[i, k], \\ C \\in T[k+1, j] \\Big\\}}\n$$\n• **Acceptance Criterion:** String $w \\in L(G) \\iff \\mathbf{S_0 \\in T[1, n]}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential phases of converting an arbitrary Context-Free Grammar into Chomsky Normal Form (CNF).",
      "orderItems": [
        "Introduce a new start symbol S0 and add rule S0 -> S to ensure start variable never appears on any RHS",
        "Eliminate all epsilon-rules (A -> epsilon) by identifying nullable variables and expanding all combinatorial subsets",
        "Eliminate all unit rules (A -> B) by substituting variable A with all non-unit derivations of B",
        "Replace all terminal characters in composite production rules with dedicated dummy variables (e.g. U_a -> a)",
        "Binarize all long rules containing 3 or more variables into cascades of strictly 2-variable productions"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Chomsky Normal Form and CYK parsing concept to its exact mathematical identity.",
      "matchPairs": [
        { "left": "CNF Production Structure", "right": "Restricted format permitting only A -> BC or A -> a (strictly binary branching parse trees)" },
        { "left": "Derivation Step Count: 2n - 1", "right": "Exact number of rule applications required to produce any non-empty string of length n" },
        { "left": "CYK Base Layer: T[i, i]", "right": "Set of all variables A that directly generate the single terminal character w_i via A -> w_i" },
        { "left": "CYK Algorithm Complexity", "right": "O(n^3 * |G|) cubic dynamic programming runtime deciding CFG string membership" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Chomsky Normal Form, any derivation of a string of length n requires exactly 2 times n minus ___ rule application steps.",
      "blankAnswer": "1",
      "blankDistractors": ["2", "0", "n"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does the CYK dynamic programming parsing algorithm decide whether a string w of length n belongs to the language of a CNF grammar G?",
      "options": [
        { "text": "CYK fills a triangular table of size n x n where cell T[i, j] stores all non-terminals that can generate substring w[i...j]; it computes entries in order of increasing substring length by iterating over all possible split points k (from i to j - 1) and checking if there exists a rule A -> BC where B is in T[i, k] and C is in T[k+1, j]; string w is accepted if and only if the start symbol S0 appears in the top cell T[1, n]", "isCorrect": true, "explanation": "Correct! The CYK (Cocke-Younger-Kasami) algorithm is a classic dynamic programming algorithm (Michael Sipser Chapter 2). Because the grammar is in Chomsky Normal Form, every non-terminal either produces a single terminal ($A \\to a$) or splits into exactly two non-terminals ($A \\to BC$). 1. Base Layer (Substrings of length 1): For each position $i$, cell $T[i, i]$ contains all variables $A$ that have a rule $A \\to w[i]$. 2. Inductive Layer (Substrings of length $L = 2, 3, \\dots, n$): To determine if variable $A$ can generate substring $w[i \\dots j]$, $w[i \\dots j]$ must be split into two non-empty pieces: a left piece $w[i \\dots k]$ and a right piece $w[k+1 \\dots j]$ for some split point $k \\in [i, j-1]$. The algorithm queries smaller already-computed table cells: does there exist a rule $A \\to BC$ such that $B \\in T[i, k]$ and $C \\in T[k+1, j]$? If yes, $A$ is added to $T[i, j]$. 3. Termination: The entire string $w[1 \\dots n]$ is generated by grammar $G$ if and only if the start symbol $S_0$ is present in the final cell $T[1, n]$. Because there are $O(n^2)$ table cells, and each cell checks $O(n)$ split points across $|G|$ rules, the total runtime is $O(n^3 \\cdot |G|)$." },
        { "text": "CYK generates all possible infinite strings and compares them using string matching", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "CYK converts the grammar into an NFA in O(1) time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "CYK only works on strings containing the letter A", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
