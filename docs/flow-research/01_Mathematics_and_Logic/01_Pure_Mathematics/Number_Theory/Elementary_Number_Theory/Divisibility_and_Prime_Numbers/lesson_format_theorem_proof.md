# Duofy Reusable Lesson Format: Divisibility and Prime Numbers - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Divisibility_and_Prime_Numbers`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of **Bézout's Identity** via the Well-Ordering Principle, prove **Euclid's Lemma** ($p \mid ab \implies p \mid a \lor p \mid b$) as a corollary, and establish the uniqueness of prime factorization in the **Fundamental Theorem of Arithmetic**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bézout's Identity & Euclid's Lemma Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Well-Ordering Principle Linear Combination Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Euclid's Lemma Multiplication by b Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Fundamental Theorem of Arithmetic Uniqueness Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Axiom Principle Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bézout's Theorem: Let $a, b \in \mathbb{Z}$ with $(a, b) \ne (0, 0)$. There exist integers $x, y \in \mathbb{Z}$ such that $ax + by = \gcd(a, b)$, and Euclid's Lemma: If $p$ is prime and $p \mid ab$, then $p \mid a$ or $p \mid b$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of Bézout's identity via Well-Ordering: (1) let $S = \{ax + by > 0 \mid x, y \in \mathbb{Z}\}$, (2) since $a^2 + b^2 > 0$, $S$ is a non-empty set of positive integers; by the Well-Ordering Principle, let $d = \min(S) = ax_0 + by_0$, (3) by division algorithm, write $a = qd + r$ with $0 \le r < d$, (4) expand remainder: $r = a - q(ax_0 + by_0) = a(1 - qx_0) + b(-qy_0)$, so $r$ is an integer linear combination of $a$ and $b$, (5) if $r > 0$, then $r \in S$ with $r < d$, contradicting $d = \min(S)$; hence $r = 0$, so $d \mid a$ (and similarly $d \mid b$), proving $d = \gcd(a, b)$.
3. **Slide 3 (`quiz`):** Test how Euclid's Lemma is proven from Bézout: If $p \nmid a$, then $\gcd(p, a) = 1$, so $px + ay = 1$; multiply by $b$ to get $pbx + aby = b$; since $p \mid pbx$ and $p \mid aby$, $p \mid b$.
4. **Slide 4 (`proof`):** Interactive derivation showing that if $p_1 \dots p_r = q_1 \dots q_s$, then Euclid's Lemma forces $p_1 \mid q_j \implies p_1 = q_j$, proving uniqueness by induction.
5. **Slide 5 (`one_word`):** Plain-text recall of the mathematical principle stating every non-empty set of positive integers has a least element (well-ordering).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bézout's Identity and Euclid's Lemma**\n• **Bézout's Identity:** For any integers $a, b$ (not both zero), there exist integers $x, y \\in \\mathbb{Z}$ such that:\n$$\nax + by = \\gcd(a, b)\n$$\n• **Euclid's Lemma:** If a prime $p$ divides $ab$, and $p \\nmid a$, then $p \\mid b$.\n*(Proof strategy: Use the Well-Ordering Principle of $\\mathbb{Z}^+$ to prove Bézout, then deduce Euclid's Lemma).* "
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical steps proving Bézout's Identity using the Well-Ordering Principle.",
      "orderItems": [
        "Define the set S = {ax + by > 0 | x, y in Z}; observe S is non-empty (since |a| or |b| is in S)",
        "By the Well-Ordering Principle, S has a unique smallest positive element d = a x_0 + b y_0",
        "Apply the Division Algorithm to write a = q d + r with 0 <= r < d",
        "Express the remainder as r = a - q(a x_0 + b y_0) = a(1 - q x_0) + b(-q y_0), which is a linear combination of a and b",
        "Observe that if r > 0, then r in S with r < d, which contradicts d = min(S); hence r = 0, proving d divides a (and similarly d divides b), so d = gcd(a, b)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Assuming Bézout's Identity, how does one formally prove Euclid's Lemma: 'If prime p divides ab and p does not divide a, then p divides b'?",
      "options": [
        { "text": "Since gcd(p, a) = 1, Bézout gives px + ay = 1; multiplying both sides by b yields p(bx) + (ab)y = b; since p divides both terms on the left, p must divide b", "isCorrect": true, "explanation": "Correct! Multiplying 1 = px + ay by b creates p(bx) + (ab)y = b, and since p | p and p | ab, p divides the entire sum b." },
        { "text": "By dividing a by p", "isCorrect": false, "explanation": "Incorrect: p does not divide a." },
        { "text": "Because all primes are odd", "isCorrect": false, "explanation": "Incorrect: 2 is an even prime." },
        { "text": "Because b must be equal to 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Uniqueness in the Fundamental Theorem of Arithmetic",
      "interactiveSteps": [
        {
          "stepText": "Suppose n has two prime factorizations: p_1 p_2 ... p_r = q_1 q_2 ... q_s."
        },
        {
          "prompt": "Since p_1 divides the product q_1 (q_2 ... q_s), what does Euclid's Lemma guarantee?",
          "options": [
            { "text": "p_1 must divide some q_j, which forces p_1 = q_j since both are primes", "isCorrect": true },
            { "text": "p_1 must equal 1", "isCorrect": false },
            { "text": "p_1 must divide n+1", "isCorrect": false },
            { "text": "The factorizations are infinite", "isCorrect": false }
          ]
        },
        {
          "stepText": "Canceling p_1 = q_j and repeating by induction proves r = s and every prime factor matches, establishing unique factorization."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the fundamental axiom stating that every non-empty set of positive integers contains a least element?",
      "blankAnswer": "well-ordering"
    }
  ]
}
```
