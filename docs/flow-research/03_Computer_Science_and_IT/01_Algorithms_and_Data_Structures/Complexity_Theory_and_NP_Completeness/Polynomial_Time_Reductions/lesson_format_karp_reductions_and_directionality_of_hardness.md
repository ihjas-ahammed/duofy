# Duofy Reusable Lesson Format: Karp Reductions and Directionality of Hardness

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Complexity_Theory_and_NP_Completeness / Polynomial_Time_Reductions`  
**Lesson Format Type:** `karp_reductions_and_directionality_of_hardness`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the formal mathematical definitions, mapping transformations, and strict directional logic of polynomial-time Many-One (Karp) reductions (Richard M. Karp 1972; Stephen Cook 1971; Michael Sipser; Thomas H. Cormen et al. CLRS Chapter 34): master the formal definition of **Karp Reducibility ($A \le_P B$)** as a polynomial-time computable mapping $f: \Sigma^* \to \Sigma^*$ satisfying the bidirectional equivalence **$w \in A \iff f(w) \in B$**, master the **Directionality Law of Hardness ("Known $\le_P$ New")** (to prove a new problem $Y$ is NP-Hard, reduce a KNOWN NP-Hard problem $X$ to $Y$: $X \le_P Y$, and prove $Y \in \text{NP}$ to establish NP-Completeness), eliminate the widespread backwards reduction blunder ($Y \le_P X$ which only proves $Y$ is easy/solvable, not hard), and prove transitivity ($A \le_P B \land B \le_P C \implies A \le_P C$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Karp Reduction Formal Definition, Directionality Rule, & Transitivity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 3-Phase NP-Completeness Proof Structure Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Reduction Statement & Mathematical Implication Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Correct Reduction Operator Form Used to Prove Problem Y is NP-Hard Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Critical Flaw in Backwards Reductions (Reducing New to Known) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Karp Reductions & Directionality (Karp 1972; Sipser; CLRS):
   - **Formal Definition of Polynomial Reduction ($A \le_P B$):**
     - Language $A \le_P B$ if there exists a deterministic polynomial-time computable function $f: \Sigma^* \to \Sigma^*$ such that:
       $$\mathbf{\forall w \in \Sigma^*: \quad w \in A \iff f(w) \in B}$$
     - $(\implies)$ If $w \in A$, then $f(w) \in B$ (**Yes-Instance maps to Yes-Instance**).
     - $(\impliedby)$ If $w \notin A$, then $f(w) \notin B$ (**No-Instance maps to No-Instance**).
   - **The Golden Rule of Directionality:**
     $$\mathbf{\text{To prove } Y \text{ is NP-Hard: You MUST show } \text{KNOWN\_HARD } X \le_P \text{NEW\_PROBLEM } Y}$$
     - **Intuition:** "If you can solve $Y$, you can solve $X$. Since $X$ is known to be intractable, $Y$ must be at least as hard as $X$!"
   - **Consequence Theorems:**
     - If $A \le_P B$ and $B \in \text{P}$, then $\mathbf{A \in \text{P}}$.
     - If $A \le_P B$ and $A \notin \text{P}$, then $\mathbf{B \notin \text{P}}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of the standard 3-phase NP-Completeness proof protocol: (1) prove that candidate problem Y belongs to Class NP by providing a polynomial certificate and deterministic verifier, (2) select an appropriate already-proven NP-Complete problem X (e.g. 3-SAT or Vertex Cover), (3) design a polynomial-time mapping function f that transforms any arbitrary instance of X into an instance of Y, (4) prove the forward direction: if x is a Yes-instance of X, then f(x) is a Yes-instance of Y, (5) prove the backward direction: if f(x) is a Yes-instance of Y, then x is a Yes-instance of X, concluding that Y is NP-Complete!
3. **Slide 3 (`matching`):** Pair 4 reduction statements (X <=_P Y with X in NPC, Y <=_P X with X in P, A <=_P B and B <=_P C, f(w) computable in O(n^k)) with their theoretical meanings.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that to prove problem Y is NP-hard, one must reduce a known NP-hard problem X to Y (X <=_P Y). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the logical fallacy of reducing a new problem to an existing NP-Complete problem: A student attempts to prove that a new puzzle problem $Y$ is NP-Complete by showing that $Y$ reduces to 3-SAT in polynomial time ($Y \le_P 3\text{-SAT}$). What did the student actually prove about problem $Y$? (The student only proved that **$Y \in \text{NP}$**; reducing $Y$ to 3-SAT means $Y$ is no harder than 3-SAT, which **fails completely to prove that $Y$ is NP-Hard**; for all we know, $Y$ could be trivial linear search in Class P).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "karp_reductions_and_directionality_of_hardness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Karp Reductions & Directionality of Hardness**\n• **Formal Mapping Reduction ($A \\le_P B$):**\n$$\n\\mathbf{\\exists \\text{ Poly-Time } f: \\Sigma^* \\to \\Sigma^* \\quad \\text{s.t.} \\quad w \\in A \\iff f(w) \\in B}\n$$\n  - **Yes $\\to$ Yes:** $w \\in A \\implies f(w) \\in B$.\n  - **No $\\to$ No:** $w \\notin A \\implies f(w) \\notin B$.\n• **The Directionality Law of Hardness:**\n$$\n\\mathbf{\\text{To prove } Y \\text{ is NP-Hard: Show } \\text{KNOWN HARD } X \\le_P \\text{NEW PROBLEM } Y}\n$$\n  - **Intuition:** *B is at least as hard as A* ($A \\le_P B$).\n• **Transitivity:** $A \\le_P B \\ \\land \\ B \\le_P C \\implies \\mathbf{A \\le_P C}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of proving that a newly defined decision problem Y is NP-Complete.",
      "orderItems": [
        "Demonstrate that problem Y is in NP by specifying a polynomial-sized certificate and polynomial verification algorithm",
        "Select a suitable already-established NP-Complete problem X from the literature (e.g. 3-SAT or Vertex Cover)",
        "Construct a deterministic algorithm that transforms any instance x of X into an instance f(x) of Y in polynomial time",
        "Prove the forward implication: if x is a valid Yes-instance of X, then f(x) is guaranteed to be a Yes-instance of Y",
        "Prove the reverse implication: if f(x) is a valid Yes-instance of Y, then x must be a Yes-instance of X, proving NPC"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each reduction relationship to its exact theoretical conclusion.",
      "matchPairs": [
        { "left": "Known NPC X <=_P New Y", "right": "Proves that New Problem Y is NP-Hard (at least as difficult as X)" },
        { "left": "New Y <=_P Known P Problem X", "right": "Proves that New Problem Y is in Class P (solvable in polynomial time)" },
        { "left": "New Y <=_P 3-SAT", "right": "Proves only that New Problem Y is in Class NP (does NOT prove NP-Hardness!)" },
        { "left": "A <=_P B and B <=_P C", "right": "Transitivity property guaranteeing that problem A reduces directly to problem C (A <=_P C)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To prove that a new problem Y is NP-Hard, the reduction must be constructed from a ___ NP-Hard problem X to Y (X <=_P Y).",
      "blankAnswer": "known",
      "blankDistractors": ["new", "polynomial", "simple"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A researcher attempts to prove that a new scheduling problem Y is NP-Complete by showing that any instance of Y can be converted into an equivalent 3-SAT formula in polynomial time (Y <=_P 3-SAT). What has the researcher actually proven about problem Y?",
      "options": [
        { "text": "The researcher has only proven that problem Y is in Class NP (meaning Y is no harder than 3-SAT); this completely fails to prove that Y is NP-Hard or NP-Complete, because even trivial linear-time problems in Class P (like finding an element in a list) can be reduced to 3-SAT", "isCorrect": true, "explanation": "Correct! This is the single most common conceptual error made by students in complexity theory. A reduction $A \\le_P B$ means 'Problem $A$ is no harder than Problem $B$' (or '$B$ is at least as hard as $A$'). If you reduce your new problem $Y$ to 3-SAT ($Y \\le_P 3\\text{-SAT}$), you have only shown that $Y$ is at most as hard as 3-SAT, which simply proves that $Y \\in \\text{NP}$. In fact, EVERY problem in Class P (such as 2+2=4, sorting an array, or computing shortest paths) can be reduced to 3-SAT in polynomial time! To prove that $Y$ is NP-Hard, you must prove the EXACT OPPOSITE direction: you must show that $3\\text{-SAT} \\le_P Y$. That proves that if someone gave you a magic fast solver for $Y$, you could use it to solve 3-SAT, proving that $Y$ is at least as hard as 3-SAT." },
        { "text": "The researcher has successfully proven that Y is NP-Complete", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The researcher has proven that P = NP", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The researcher has proven that 3-SAT is undecidable", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
