# Duofy Reusable Lesson Format: Boolean Algebra (Postulates, Theorems, and De Morgan's Laws)

**Target Topic:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Digital_Logic_and_Circuit_Design / Boolean_Algebra_and_K_Maps`  
**Lesson Format Type:** `boolean_algebra_postulates_theorems_and_de_morgans_laws`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through axiomatic Boolean algebra, algebraic minimization laws, and dual expressions (M. Morris Mano & Michael D. Ciletti *Digital Design* 6th ed. Chapter 2; Claude Shannon 1938): master **Huntington's Postulates and the Duality Principle** (interchanging AND $\cdot$ with OR $+$, and $0$ with $1$), master algebraic theorems (**Distributive Laws:** $A + BC = (A+B)(A+C)$, **Complement Laws:** $A + \overline{A} = 1, A \cdot \overline{A} = 0$, **Absorption Laws:** $A + AB = A, A(A+B) = A$), master **De Morgan's Laws ($\mathbf{\overline{A + B} = \overline{A} \cdot \overline{B}}$ and $\mathbf{\overline{A \cdot B} = \overline{A} + \overline{B}}$)** for inverting complex multi-variable expressions, and apply **The Consensus Theorem ($\mathbf{AB + \overline{A}C + BC = AB + \overline{A}C}$)** to eliminate hidden redundant terms algebraically.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Boolean Postulates, De Morgan's Laws & Consensus Theorem Reference Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Algebraic Simplification of a Boolean Expression Using Distributive and Consensus Theorems Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Boolean Algebraic Law / Theorem & Exact Mathematical Identity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Boolean Algebra, the Dual Theorem of $\overline{A \cdot B} = \overline{A} + \overline{B}$ Is De ___ Law (Morgan) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof: Applying the Consensus Theorem to Eliminate Redundant Circuit Terms Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Boolean Algebra (Mano & Ciletti Ch 2):
   - **The Axiomatic Boolean Laws Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Theorem / Law} & \textbf{OR Form} & \textbf{AND Form (Dual)} \\
     \hline
     \mathbf{\text{Distributive Law}} & \mathbf{A + BC = (A + B)(A + C)} & A(B + C) = AB + AC \\
     \mathbf{\text{Complement Law}} & A + \overline{A} = 1 & A \cdot \overline{A} = 0 \\
     \mathbf{\text{Absorption Law}} & A + AB = A & A(A + B) = A \\
     \mathbf{\text{De Morgan's Laws}} & \mathbf{\overline{A + B} = \overline{A} \cdot \overline{B}} & \mathbf{\overline{A \cdot B} = \overline{A} + \overline{B}} \\
     \mathbf{\text{Consensus Theorem}} & \mathbf{AB + \overline{A}C + BC = AB + \overline{A}C} & (A + B)(\overline{A} + C)(B + C) = (A + B)(\overline{A} + C) \\
     \hline
     \end{array}$$
   - **The Duality Principle:** If an identity $F(x_1, \dots, x_n, +, \cdot, 0, 1)$ holds, then $F^*(x_1, \dots, x_n, \cdot, +, 1, 0)$ is guaranteed valid!
2. **Slide 2 (`ordering`):** Provide 5 steps of algebraic simplification: (1) start with unsimplified expression $F = AB + \overline{A}C + BC + A\overline{B}$, (2) apply Consensus Theorem on $AB + \overline{A}C + BC$ to eliminate the redundant consensus term $BC$, yielding $AB + \overline{A}C + A\overline{B}$, (3) group terms sharing variable $A$: $A(B + \overline{B}) + \overline{A}C$, (4) apply Complement Law $B + \overline{B} = 1$, yielding $A(1) + \overline{A}C = A + \overline{A}C$, (5) apply Distributive Law $(A + \overline{A})(A + C) = 1 \cdot (A + C) = A + C$ for minimal single-gate output!
3. **Slide 3 (`matching`):** Pair 4 concepts (De Morgan's Law, Consensus Theorem, Distributive Law, Absorption Law) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of De Morgan's Law. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Consensus Theorem proof: In the Boolean expression $F = XY + \overline{X}Z + YZ$, why is the product term $YZ$ mathematically redundant and safely eliminated by the Consensus Theorem? (The term $YZ$ can be expanded by multiplying by $(X + \overline{X}) = 1$ to obtain $XYZ + \overline{X}YZ$; **grouping with adjacent terms gives $XY(1 + Z) + \overline{X}Z(1 + Y)$; by the absorption law $(1 + K) = 1$, this simplifies to $XY(1) + \overline{X}Z(1) = XY + \overline{X}Z$**, proving that whenever $YZ = 1$, either $XY = 1$ (if $X=1$) or $\overline{X}Z = 1$ (if $X=0$), making $YZ$ entirely redundant in physical hardware).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "boolean_algebra_postulates_theorems_and_de_morgans_laws",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Axiomatic Boolean Algebra \\& Logic Theorems (Mano \\& Ciletti 2017)**\n• **Core Boolean Identities \\& Dual Expressions:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Algebraic Law} & \\textbf{Primary Form (OR)} & \\textbf{Dual Form (AND)} \\\\\n\\hline\n\\mathbf{\\text{Distributive Law}} & \\mathbf{A + BC = (A + B)(A + C)} & A(B + C) = AB + AC \\\\\n\\mathbf{\\text{Complement Law}} & A + \\overline{A} = 1 & A \\cdot \\overline{A} = 0 \\\\\n\\mathbf{\\text{Absorption Law}} & A + AB = A & A(A + B) = A \\\\\n\\mathbf{\\text{De Morgan's Laws}} & \\mathbf{\\overline{A + B} = \\overline{A} \\cdot \\overline{B}} & \\mathbf{\\overline{A \\cdot B} = \\overline{A} + \\overline{B}} \\\\\n\\mathbf{\\text{Consensus Theorem}} & \\mathbf{AB + \\overline{A}C + BC = AB + \\overline{A}C} & (A + B)(\\overline{A} + C)(B + C) = (A + B)(\\overline{A} + C) \\\\\n\\hline\n\\end{array}\n$$\n• **The Duality Principle (Claude Shannon 1938):**\n  - Every algebraic identity remains valid if you simultaneously swap $\\mathbf{+ \\leftrightarrow \\cdot}$ and $\\mathbf{0 \\leftrightarrow 1}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential algebraic steps executed to simplify the expression F = AB + A'C + BC + AB' down to minimal hardware literals.",
      "orderItems": [
        "Given the unsimplified expression: F = AB + A'C + BC + AB'",
        "Apply the Consensus Theorem to eliminate the redundant term BC from (AB + A'C + BC), reducing F to: AB + A'C + AB'",
        "Group the terms sharing literal A to factor: A(B + B') + A'C",
        "Apply the Complement Law (B + B' = 1) and Identity Law to obtain: A + A'C",
        "Apply the second Distributive Law: (A + A')(A + C) = (1)(A + C) = A + C"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Boolean Algebraic Theorem to its exact Mathematical Identity.",
      "matchPairs": [
        { "left": "De Morgan's Theorem", "right": "(A + B)' = A' * B' and (A * B)' = A' + B'" },
        { "left": "Consensus Theorem", "right": "AB + A'C + BC = AB + A'C (eliminates redundant bridging term BC)" },
        { "left": "Distributive Law over OR", "right": "A + BC = (A + B)(A + C) (distributes addition over multiplication)" },
        { "left": "Absorption Law", "right": "A + AB = A and A(A + B) = A (absorbs redundant sub-terms)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The theorem stating that the complement of a product equals the sum of the complements is De ___'s law.",
      "blankAnswer": "Morgan",
      "blankDistractors": ["Karnaugh", "Boole", "Shannon"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In digital logic design, why is the product term YZ in the expression F = XY + X'Z + YZ mathematically redundant and eliminated by the Consensus Theorem?",
      "options": [
        { "text": "The term YZ is the consensus of XY and X'Z; algebraically, multiplying YZ by (X + X' = 1) expands it into XYZ + X'YZ, which can be factored as XY(1 + Z) + X'Z(1 + Y) = XY(1) + X'Z(1) = XY + X'Z; logically, whenever Y=1 and Z=1, if X=1 then the first term XY is true, and if X=0 then the second term X'Z is true; therefore, the output F is already guaranteed to be 1 by the first two terms in all possible input conditions, making YZ an unnecessary redundant gate", "isCorrect": true, "explanation": "Correct! This is M. Morris Mano's algebraic proof of the Consensus Theorem (M. Morris Mano *Digital Design* Chapter 2). 1. **The Algebraic Expansion Proof:** - $F = XY + \\overline{X}Z + YZ$ - Since $(X + \\overline{X}) = 1$: Multiply $YZ$ by $1$: $$F = XY + \\overline{X}Z + YZ(X + \\overline{X})$$ $$F = XY + \\overline{X}Z + XYZ + \\overline{X}YZ$$ - Factor $XY$ and $\\overline{X}Z$: $$F = XY(1 + Z) + \\overline{X}Z(1 + Y)$$ - By the identity law $1 + K = 1$: $$F = XY(1) + \\overline{X}Z(1) = \\mathbf{XY + \\overline{X}Z}$$ 2. **The Hardware Value:** In physical silicon, deleting the $YZ$ term eliminates one 2-input AND gate and one input to the final OR gate, reducing chip area, power consumption, and propagation delay!" },
        { "text": "Because Boolean variables cannot be multiplied together", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because De Morgan's laws only apply when Y and Z are equal to zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Consensus Theorem converts digital circuits into analog amplifiers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
