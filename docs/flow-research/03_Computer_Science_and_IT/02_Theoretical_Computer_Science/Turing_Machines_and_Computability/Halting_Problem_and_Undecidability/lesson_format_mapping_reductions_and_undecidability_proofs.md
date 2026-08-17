# Duofy Reusable Lesson Format: Mapping Reductions and Undecidability Proofs

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Turing_Machines_and_Computability / Halting_Problem_and_Undecidability`  
**Lesson Format Type:** `mapping_reductions_and_undecidability_proofs`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the formal mathematical definitions, computable reduction functions, and directionality of hardness in Mapping Reductions ($A \le_m B$) for undecidability proofs (Emil L. Post 1944; Michael Sipser Chapter 5.3; John E. Hopcroft et al.): master the **Mapping Reduction Definition ($\mathbf{w \in A \iff f(w) \in B}$)** with computable function $f$, formulate the **Directionality Axioms** (**If $A \le_m B$ and $B$ is Decidable $\implies A$ is Decidable**; **If $A \le_m B$ and $A$ is Undecidable $\implies B$ is Undecidable**), construct the **Classic Reduction $A_{\text{TM}} \le_m HALT_{\text{TM}}$**, construct the **Reduction $A_{\text{TM}} \le_m E_{\text{TM}}$ (Emptiness Problem)**, and eliminate the common novice error of reducing in the wrong direction ($B \le_m A$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mapping Reduction Axioms, Computable Converter f, & Directionality Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Reduction Architecture from A_TM to HALT_TM Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Computability Reduction Term / Property & Formal Logic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Symbolic Notation Denoting that Language A Reduces to Language B in Computability (A <=_m B) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Critical Direction of Reduction Required to Prove a New Language is Undecidable Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Mapping Reductions & Undecidability Proofs (Post 1944; Sipser Section 5.3):
   - **Formal Definition of Mapping Reduction ($A \le_m B$):**
     - Language $A \subseteq \Sigma^*$ is *mapping reducible* to language $B \subseteq \Gamma^*$ ($A \le_m B$) if there exists a **computable function $f: \Sigma^* \to \Gamma^*$** such that:
       $$\mathbf{\forall w \in \Sigma^* : \quad w \in A \iff f(w) \in B}$$
   - **The 2 Master Directionality Theorems (Sipser Theorem 5.22 & 5.23):**
     1. **Decidability Transfer:** If $\mathbf{A \le_m B}$ and $\mathbf{B \text{ is Decidable}} \implies \mathbf{A \text{ is Decidable}}$.
     2. **Undecidability Transfer (Hardness):** If $\mathbf{A \le_m B}$ and $\mathbf{A \text{ is Undecidable}} \implies \mathbf{B \text{ is Undecidable}}$!
   - **The Classic Reduction Example ($A_{\text{TM}} \le_m HALT_{\text{TM}}$):**
     - Input $\langle M, w \rangle$. Construct machine $M'$ that simulates $M$ on $w$:
       - If $M$ accepts $w \implies M'$ halts.
       - If $M$ rejects $w \implies M'$ enters an explicit infinite loop!
     - Now: $M$ accepts $w \iff M'$ halts on input $\varepsilon$. Thus, $A_{\text{TM}} \le_m HALT_{\text{TM}}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of proving problem B is undecidable via reduction from A_TM: (1) select a known undecidable base problem (e.g. A_TM), (2) assume for contradiction that there exists a decider machine R that decides target language B, (3) construct a master decider S for A_TM which takes input <M, w>, (4) inside S, construct an auxiliary machine description <M'> tailored so that <M, w> in A_TM iff <M'> in B, (5) pass <M'> into decider R and return R's output; because S successfully decides A_TM (which is impossible), decider R cannot exist $\implies$ B is undecidable!
3. **Slide 3 (`matching`):** Pair 4 reduction concepts (Mapping Function f, Decidability Direction, Undecidability Direction, Auxiliary Machine M') with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that mapping reduction is denoted by the mathematical symbol <=_m. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the fatal error of reducing in the wrong direction: A researcher wants to prove that a newly discovered language $B$ is undecidable. The researcher proves that $B \le_m A_{\text{TM}}$ (mapping $B$ to the Acceptance Problem). Has the researcher proven that $B$ is undecidable? (No! Reducing $B \le_m A_{\text{TM}}$ only proves that $B$ is **at most as hard as $A_{\text{TM}}$**; it does NOT prove $B$ is hard ($B$ could be trivial or regular!); to prove $B$ is undecidable, the reduction must go in the **OPPOSITE direction: $A_{\text{TM}} \le_m B$, which proves that $B$ is at least as hard as $A_{\text{TM}}$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mapping_reductions_and_undecidability_proofs",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Mapping Reductions ($A \\le_m B$) (Sipser 5.3)**\n• **Formal Definition of Mapping Reducibility:**\n$$\n\\mathbf{A \\le_m B \\iff \\exists \\text{ Computable Function } f : \\Sigma^* \\to \\Gamma^* \\quad \\text{s.t.} \\quad \\mathbf{w \\in A \\iff f(w) \\in B}}\n$$\n• **The 2 Directionality Axioms (Transfer of Hardness):**\n  1. If $\\mathbf{A \\le_m B}$ and $\\mathbf{B \\text{ is Decidable}} \\implies \\mathbf{A \\text{ is Decidable}}$!\n  2. If $\\mathbf{A \\le_m B}$ and $\\mathbf{A \\text{ is Undecidable}} \\implies \\mathbf{B \\text{ is Undecidable}}$!\n• **The Prover's Rule:** To prove target problem $B$ is undecidable, you MUST reduce **Known Undecidable $A \\le_m B$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of proving target problem B is undecidable via reduction from A_TM.",
      "orderItems": [
        "Select the known undecidable problem A_TM = {<M, w> | M accepts w} as the foundation",
        "Assume for contradiction that a hypothetical algorithm/decider R exists for target language B",
        "Construct a master decider S designed to solve A_TM by taking input pair <M, w>",
        "Inside S, author an auxiliary machine M' whose behavior guarantees that <M, w> in A_TM iff <M'> in B",
        "Run decider R on <M'> and output R's answer, contradicting the undecidability of A_TM to prove B is undecidable"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Mapping Reduction concept to its exact theoretical property.",
      "matchPairs": [
        { "left": "Computable Mapping f", "right": "Total algorithmic transformation converting any instance of language A into an instance of language B" },
        { "left": "Undecidability Transfer Rule", "right": "If A <=_m B and A is known to be undecidable, then target problem B is guaranteed undecidable" },
        { "left": "Decidability Transfer Rule", "right": "If A <=_m B and target problem B is known to be decidable, then base problem A is decidable" },
        { "left": "Reduction: A_TM <=_m HALT_TM", "right": "Converts an acceptance query into a halting query by turning rejections into infinite loops" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In computability theory, the mathematical symbol denoting that language A mapping reduces to language B is written as A <=_m ___.",
      "blankAnswer": "B",
      "blankDistractors": ["A", "TM", "p"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A computer science student wants to prove that a newly discovered language L is undecidable. The student successfully constructs a valid mapping reduction proving that L <=_m A_TM. Did the student prove that language L is undecidable?",
      "options": [
        { "text": "No! Proving L <=_m A_TM only establishes that L is at most as hard as A_TM (it allows L to be a simple, trivially decidable language like the empty set or regular languages); to prove that L is undecidable, the reduction MUST go in the reverse direction: A_TM <=_m L, which proves that language L is at least as hard as A_TM", "isCorrect": true, "explanation": "Correct! This is the single most frequent mistake made by students in computability theory (Michael Sipser Section 5.3). Remember that $A \\le_m B$ means 'problem $A$ is no harder than problem $B$' (or '$B$ is at least as hard as $A$'). 1. If you reduce $L \\le_m A_{\\text{TM}}$, you are showing that $L$ is no harder than $A_{\\text{TM}}$. For example, the trivial regular language $L = \\{0\\}$ reduces to $A_{\\text{TM}}$ ($0 \\le_m A_{\\text{TM}}$) because any simple problem can be translated into a Turing machine question! This tells you NOTHING about whether $L$ is undecidable. 2. To prove $L$ is undecidable, you must show that $L$ is AT LEAST AS HARD as a known undecidable problem. You must construct a reduction FROM the known hard problem TO your new problem: $A_{\\text{TM}} \\le_m L$. 3. By the Undecidability Transfer Theorem: If $A_{\\text{TM}} \\le_m L$ and $A_{\\text{TM}}$ is undecidable, then $L$ MUST be undecidable. Always reduce FROM the known hard problem TO the unknown problem!" },
        { "text": "Yes, reducing to A_TM is the standard definition of undecidability", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Yes, because all languages that reduce to A_TM are automatically NP-hard", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "No, because mapping reductions can only be applied to polynomial time problems", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
