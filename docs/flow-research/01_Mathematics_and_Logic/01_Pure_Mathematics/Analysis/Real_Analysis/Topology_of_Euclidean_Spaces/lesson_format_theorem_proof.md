# Duofy Reusable Lesson Format: Topology of Euclidean Spaces - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Topology_of_Euclidean_Spaces`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Heine-Borel Theorem** for closed bounded intervals $[a, b]$ via the Supremum/LUB property, and prove the **Extreme Value Theorem** for continuous functions on compact domains.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Heine-Borel Interval Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Supremum Set Cover Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Boundary Point Inclusion Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Extreme Value Theorem Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Continuous Map Preservation Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Theorem: Every closed bounded interval $[a, b] \subset \mathbb{R}$ is compact (any open cover $\mathcal{U} = \{U_\alpha\}$ has a finite subcover).
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) let $S = \{x \in [a, b] \mid [a, x] \text{ is covered by finitely many } U_\alpha\}$, (2) note $a \in S$, so $S$ is non-empty and bounded above by $b$, (3) let $c = \sup S \le b$, (4) choose $U_\beta \in \mathcal{U}$ containing $c$, and pick $x_1 \in S \cap U_\beta$ with $x_1 < c$, extending the finite cover past $c$, (5) deduce that $c = b$ and $b \in S$, so $[a, b]$ has a finite subcover.
3. **Slide 3 (`quiz`):** Test why assuming $c < b$ leads to a contradiction by extending the finite cover past $c$.
4. **Slide 4 (`proof`):** Interactive derivation showing that continuous $f: K \to \mathbb{R}$ on compact $K$ has bounded image $f(K)$, and achieves its supremum $M = \sup f(K)$ at some point $x^* \in K$.
5. **Slide 5 (`one_word`):** Plain-text recall of the property preserved when taking continuous images of connected sets (connectedness).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Heine-Borel Theorem for Intervals**\nLet $[a, b] \\subset \\mathbb{R}$ be a closed and bounded interval.\nEvery open cover $\\mathcal{U} = \\{U_\\alpha\\}_{\\alpha \\in A}$ of $[a, b]$ admits a **finite subcover**:\n$$\n[a, b] \\subseteq U_{\\alpha_1} \\cup U_{\\alpha_2} \\cup \\dots \\cup U_{\\alpha_k}\n$$\nThus, every closed and bounded interval in $\\mathbb{R}$ is compact."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of the Heine-Borel Theorem using the Least Upper Bound property.",
      "orderItems": [
        "Define the set S = {x in [a, b] | [a, x] is covered by a finite subcollection of U}",
        "Show S is non-empty (since a in S) and bounded above by b; define c = sup S",
        "Choose an open set U_0 in U containing c; find delta > 0 such that (c - delta, c + delta) is in U_0",
        "Pick x_1 in S with c - delta < x_1 <= c; augment the finite cover of [a, x_1] with U_0 to cover all of [a, c + delta/2]",
        "Conclude that c must equal b and b in S, proving [a, b] is covered by a finite subcover"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does assuming the supremum c = sup S is strictly less than b (c < b) produce an immediate contradiction in the Heine-Borel proof?",
      "options": [
        { "text": "Because the open neighborhood (c - delta, c + delta) allows the finite cover to extend to c + delta/2, contradicting that c was the upper bound of S", "isCorrect": true, "explanation": "Correct! Since [a, c + delta/2] is covered by a finite subcover, c + delta/2 in S, which contradicts c = sup S." },
        { "text": "Because c must be negative", "isCorrect": false, "explanation": "Incorrect: c in [a, b]." },
        { "text": "Because open sets cannot contain their suprema", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because [a, b] is unbounded", "isCorrect": false, "explanation": "Incorrect: [a, b] is bounded." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Extreme Value Theorem on Compact Sets",
      "interactiveSteps": [
        {
          "stepText": "Let f: K -> R be continuous with K compact. Then f(K) is compact in R."
        },
        {
          "prompt": "Since f(K) is closed and bounded by Heine-Borel, let M = sup f(K). Why does there exist x* in K with f(x*) = M?",
          "options": [
            { "text": "M is in the closure of f(K), and since f(K) is closed, M in f(K), so M = f(x*) for some x* in K", "isCorrect": true },
            { "text": "Because all functions are constant", "isCorrect": false },
            { "text": "Because M must be infinite", "isCorrect": false },
            { "text": "Because K contains only one point", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus, continuous functions attain their global maximum and minimum on compact sets."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What topological property is preserved under continuous mappings such that f(Connected Set) is always connected?",
      "blankAnswer": "connectedness"
    }
  ]
}
```
