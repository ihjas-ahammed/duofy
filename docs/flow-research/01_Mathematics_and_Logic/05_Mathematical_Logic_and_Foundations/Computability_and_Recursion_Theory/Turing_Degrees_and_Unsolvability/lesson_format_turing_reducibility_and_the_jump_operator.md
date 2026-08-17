# Duofy Reusable Lesson Format: Turing Reducibility and the Jump Operator

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Computability_and_Recursion_Theory / Turing_Degrees_and_Unsolvability`  
**Lesson Format Type:** `turing_reducibility_and_the_jump_operator`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Oracle Turing Machines** and **Turing Reducibility** ($A \le_T B$), define **Turing Degrees** as equivalence classes in upper semilattices $(\mathcal{D}, \le_T)$, evaluate the **Turing Jump Operator** $A' = \{e \mid \Phi_e^A(e) \downarrow\}$, and prove **Turing's Diagonalization Theorem** ($A <_T A'$ strictly strictly ascending infinite chains of unsolvability $\mathbf{0} < \mathbf{0}' < \mathbf{0}'' < \dots$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Oracle Computation & Turing Jump Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Proof of Strict Incomparability A <_T A' Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Computability Object & Turing Degree Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Lowest Turing Degree Symbol Representation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Turing Jump Invertibility and Friedberg Inversion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of an Oracle Turing Machine $M^B$: A Turing machine with an extra query tape and query states allowing instantaneous $O(1)$ membership checks $x \in B$. Set $A$ is **Turing reducible** to $B$ ($A \le_T B$) if $A$ is decided by some oracle machine $\Phi_e^B$. State Turing Equivalence: $A \equiv_T B \iff A \le_T B \text{ and } B \le_T A$. The equivalence classes are **Turing Degrees** $\mathbf{d}(A) \in \mathcal{D}$. State the Turing Jump Operator: For any set $A$, its jump is $A' = \{e \in \mathbb{N} \mid \Phi_e^A(e) \downarrow\}$ (the relativized halting problem with oracle $A$). State Theorem (Alan Turing, 1939): $A \le_T A'$, but $A' \not\le_T A$, establishing the strict hierarchy $A <_T A'$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving $A' \not\le_T A$ via relativized Cantor diagonalization: (1) assume for contradiction that $A' \le_T A$, (2) then the complement $\overline{A}' = \{e \mid \Phi_e^A(e) \uparrow\}$ is also computable relative to $A$, (3) define the total computable function $f(e)$ relative to $A$: $f(e) = 1$ if $\Phi_e^A(e) \uparrow$, and undefined/diverges if $\Phi_e^A(e) \downarrow$, (4) by the universal machine theorem, function $f$ has an index $e_0$ in the enumeration of $A$-oracle machines: $f = \Phi_{e_0}^A$, (5) evaluate $\Phi_{e_0}^A(e_0)$: $\Phi_{e_0}^A(e_0) \downarrow \iff e_0 \notin A' \iff \Phi_{e_0}^A(e_0) \uparrow$, reaching a direct logical contradiction, proving $A' \not\le_T A$!
3. **Slide 3 (`matching`):** Pair 4 Turing degrees ($\mathbf{0}$, $\mathbf{0}'$, $\mathbf{0}''$, $\mathbf{0}^{(\omega)}$) with their canonical decision problems (Computable sets, Halting Problem $K$, Finiteness problem $\operatorname{FIN}$, Arithmetic truth).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the Turing degree containing all decidable/computable sets is denoted by bold zero. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Friedberg Inversion Theorem (Richard Friedberg, 1957): For any degree $\mathbf{c} \ge \mathbf{0}'$, does there exist a degree $\mathbf{a}$ such that $\mathbf{a}' = \mathbf{c}$? (Yes! Friedberg proved that the jump operator is SURJECTIVE onto the cone of degrees $[\mathbf{0}', \infty)$, meaning every degree above the Halting Problem is the jump of some lower degree).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "turing_reducibility_and_the_jump_operator",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Turing Reducibility and the Jump Operator**\n• **Oracle Turing Machine $\\Phi_e^B$:** A Turing machine equipped with an oracle query tape providing instantaneous answers to queries '$x \\in B$'.\n• **Turing Reducibility ($A \\le_T B$ / Alan Turing, 1939):** $A$ is computable using an oracle for $B$: $\\chi_A = \\Phi_e^B$.\n• **Turing Degrees $\\mathcal{D}$:** Equivalence classes of $\\equiv_T$ forming an upper semilattice:\n  - $\\mathbf{0} = \\mathbf{d}(\\emptyset)$: The degree of all decidable/computable sets.\n  - $\\mathbf{0}' = \\mathbf{d}(K)$: The degree of the classical **Halting Problem**.\n• **The Turing Jump Operator $A'$:**\n$$\nA' = \\{e \\in \\mathbb{N} \\mid \\Phi_e^A(e) \\downarrow\\}\n$$\n• **Strict Hierarchy Theorem:** For **every** set $A$:\n$$\nA <_T A' <_T A'' <_T A''' <_T \\dots\n$$\n($A'$ can never be computed by an oracle for $A$!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical steps proving that A' cannot be computed with an oracle for A (A' not <=_T A).",
      "orderItems": [
        "Assume for contradiction that A' <=_T A, implying its complement (the non-halting set) is A-computable",
        "Define the partial A-computable diagonal function f(e) which halts if Phi_e^A(e) diverges, and diverges if Phi_e^A(e) halts",
        "By the Universal Oracle Machine theorem, function f must have an index e_0 such that f = Phi_{e_0}^A",
        "Evaluate the behavior of machine Phi_{e_0}^A on its own input index e_0",
        "Deduce that Phi_{e_0}^A(e_0) halts if and only if Phi_{e_0}^A(e_0) diverges, a direct logical contradiction proving A' not <=_T A"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Turing degree to its canonical decision problem.",
      "matchPairs": [
        { "left": "Degree 0", "right": "All computable / decidable sets (empty oracle needed)" },
        { "left": "Degree 0'", "right": "The Halting Problem K = {e : Phi_e(e) halts} (Sigma_1^0-complete)" },
        { "left": "Degree 0''", "right": "The Finiteness Problem FIN = {e : W_e is finite} (Sigma_2^0-complete)" },
        { "left": "Degree 0'''", "right": "The Cofiniteness Problem COFIN = {e : W_e is cofinite} (Sigma_3^0-complete)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The bottom element of the Turing degrees containing all decidable languages is denoted as bold ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "two", "omega"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What did Richard Friedberg prove in his famous 1957 Jump Inversion Theorem regarding degrees c >= 0'?",
      "options": [
        { "text": "For EVERY degree c >= 0', there exists a degree a such that a' = c (the jump operator is SURJECTIVE onto the upper cone of 0')", "isCorrect": true, "explanation": "Correct! Friedberg's Jump Inversion Theorem proves that every degree containing at least as much information as the Halting Problem is the jump of some lower degree." },
        { "text": "The jump operator is injective (one-to-one)", "isCorrect": false, "explanation": "Incorrect: Many distinct degrees have the same jump." },
        { "text": "No sets exist between 0 and 0'", "isCorrect": false, "explanation": "Incorrect: Intermediate degrees exist." },
        { "text": "The Halting Problem can be inverted in polynomial time", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
