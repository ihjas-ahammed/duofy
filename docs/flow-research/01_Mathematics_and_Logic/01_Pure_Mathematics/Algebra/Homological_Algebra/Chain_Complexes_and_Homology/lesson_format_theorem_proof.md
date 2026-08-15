# Duofy Reusable Lesson Format: Chain Complexes and Homology - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Homological_Algebra / Chain_Complexes_and_Homology`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the construction of the **Connecting Homomorphism** in the **Snake Lemma** and the derivation of the **Long Exact Sequence in Homology** via diagram chasing.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Snake Lemma & Connecting Map Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Diagram Chase Step Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Well-Definedness Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Long Exact Sequence Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Connecting Map Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Snake Lemma: Given a short exact sequence of complexes $0 \to A_\bullet \to B_\bullet \to C_\bullet \to 0$, there exists a connecting homomorphism $\delta_n: H_n(C) \to H_{n-1}(A)$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the diagram chase to define $\delta([c])$: (1) pick cycle $c \in Z_n(C)$, (2) pull back to $b \in B_n$ via surjectivity of $p$, (3) apply boundary $d(b) \in B_{n-1}$, (4) observe $p(d(b)) = d(p(b)) = d(c) = 0$, so $d(b) = i(a)$ by exactness, (5) verify $d(a) = 0$ to define $\delta([c]) = [a]$.
3. **Slide 3 (`quiz`):** Test why the class $[a] \in H_{n-1}(A)$ is independent of the choice of preimage $b \in B_n$.
4. **Slide 4 (`proof`):** Interactive derivation showing exactness at $H_n(C)$ and $H_{n-1}(A)$.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the map. Plain text only.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Long Exact Sequence in Homology (Snake Lemma)**\nLet $0 \\to A_\\bullet \\xrightarrow{i} B_\\bullet \\xrightarrow{p} C_\\bullet \\to 0$ be a short exact sequence of chain complexes.\nThen there exist natural **connecting homomorphisms** $\\delta_n: H_n(C) \\to H_{n-1}(A)$ producing the long exact sequence:\n$$\n\\dots \\to H_n(A) \\xrightarrow{i_*} H_n(B) \\xrightarrow{p_*} H_n(C) \\xrightarrow{\\delta_n} H_{n-1}(A) \\xrightarrow{i_*} H_{n-1}(B) \\to \\dots\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps of the diagram chase constructing the connecting map delta([c]).",
      "orderItems": [
        "Take a cycle representative c in Z_n(C), so d(c) = 0 in C_{n-1}",
        "Lift c to an element b in B_n using the surjectivity of p_n (p_n(b) = c)",
        "Compute the boundary d_B(b) in B_{n-1}, and observe p_{n-1}(d_B(b)) = d_C(p_n(b)) = d_C(c) = 0",
        "By exactness at B_{n-1}, find a unique element a in A_{n-1} such that i_{n-1}(a) = d_B(b)",
        "Verify d_A(a) = 0 by injectivity of i, and define delta([c]) = [a] in H_{n-1}(A)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the homology class [a] in H_{n-1}(A) independent of the choice of lift b in B_n with p(b) = c?",
      "options": [
        { "text": "If b' is another lift, then b - b' in ker(p) = im(i), which pushes forward to a boundary in A_{n-1}", "isCorrect": true, "explanation": "Correct! If b - b' = i(a_0), then d(b - b') = d(i(a_0)) = i(d(a_0)), so a - a' = d(a_0), which represents 0 in H_{n-1}(A)." },
        { "text": "Because the map p is injective", "isCorrect": false, "explanation": "Incorrect: p is surjective, but not generally injective." },
        { "text": "Because B_n is a free abelian group", "isCorrect": false, "explanation": "Incorrect: B_n does not need to be free." },
        { "text": "Because all boundary maps are zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Exactness at H_n(C)",
      "interactiveSteps": [
        {
          "stepText": "To prove exactness at H_n(C), we must show that im(p_*) = ker(delta_n)."
        },
        {
          "prompt": "If [c] = p_*([b]) is in im(p_*), where b in Z_n(B), what is delta_n([c])?",
          "options": [
            { "text": "delta_n([c]) = 0, because d_B(b) = 0, giving a = 0", "isCorrect": true },
            { "text": "delta_n([c]) = [b]", "isCorrect": false },
            { "text": "delta_n([c]) = 1", "isCorrect": false },
            { "text": "delta_n([c]) is undefined", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus im(p_*) ⊆ ker(delta_n), and a reverse chase shows ker(delta_n) ⊆ im(p_*)."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the boundary homomorphism delta in the long exact sequence that connects H_n(C) to H_{n-1}(A)?",
      "blankAnswer": "connecting"
    }
  ]
}
```
