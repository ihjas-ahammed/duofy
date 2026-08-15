# Duofy Reusable Lesson Format: Continuity, Compactness, and Connectedness - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / General_and_Point_Set_Topology / Continuity_Compactness_Connectedness`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of **Urysohn's Lemma** (constructing a continuous function separating disjoint closed sets in a normal space via dyadic rational interpolation) and prove **Tychonoff's Product Theorem** via ultrafilters or Alexander's Subbase Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Urysohn's Lemma Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Dyadic Rational Nesting Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Normality Closure Containment Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Extreme Value Theorem on General Compact Spaces Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Product Compactness Theorem Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Urysohn's Lemma: Let $X$ be a normal topological space ($T_4$). If $A, B \subset X$ are disjoint closed subsets, there exists a continuous function $f: X \to [0, 1]$ such that $f(x) = 0$ for all $x \in A$ and $f(x) = 1$ for all $x \in B$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of Urysohn's Lemma: (1) let $D = \mathbb{Q} \cap [0, 1]$ be the set of dyadic rationals $k/2^n$, (2) by normality, choose open set $U_1 = X \setminus B$ containing $A$, and find open set $U_0$ such that $A \subseteq U_0 \subseteq \overline{U_0} \subseteq U_1$, (3) inductively for each dyadic rational $r < s$, construct open sets $U_r$ satisfying $\overline{U_r} \subseteq U_s$, (4) define $f(x) = \inf \{r \in D \mid x \in U_r\}$ (with $f(x) = 1$ if $x \notin U_r$ for any $r$), (5) verify $f(A) = 0$, $f(B) = 1$, and prove continuity by showing preimages of rays $[0, a)$ and $(b, 1]$ are open unions/intersections of $U_r$.
3. **Slide 3 (`quiz`):** Test why normality is needed at each induction step (to insert an open set $V$ between a closed set $\overline{U_r}$ and an open set $U_s$ such that $\overline{U_r} \subseteq V \subseteq \overline{V} \subseteq U_s$).
4. **Slide 4 (`proof`):** Interactive derivation showing a continuous image $f(K)$ of a compact space $K$ under $f: K \to \mathbb{R}$ is compact, hence closed and bounded in $\mathbb{R}$, attaining maximum and minimum values.
5. **Slide 5 (`one_word`):** Plain-text recall of the Russian topologist whose theorem proves arbitrary products of compact spaces are compact (Tychonoff).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Urysohn's Lemma**\nLet $X$ be a **normal** ($T_4$) topological space.\nFor any two disjoint closed subsets $A, B \\subset X$, there exists a **continuous function**:\n$$\nf: X \\longrightarrow [0, 1]\n$$\nsuch that $f(x) = 0$ for all $x \\in A$ and $f(x) = 1$ for all $x \\in B$.\n*(This proves normal spaces admit a rich supply of continuous real-valued functions).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps constructing the Urysohn separating function via dyadic rationals.",
      "orderItems": [
        "Let D be the set of dyadic rationals in [0, 1]; define U_1 = X \\ B containing closed set A",
        "Use normality to choose open set U_0 such that A is in U_0 and cl(U_0) is in U_1",
        "Inductively construct open sets U_r for all r in D such that r < s implies cl(U_r) is in U_s",
        "Define f(x) = inf {r in D | x in U_r} for x in U_1, and f(x) = 1 otherwise",
        "Prove continuity by verifying that f^{-1}([0, a)) = union_{r < a} U_r and f^{-1}((b, 1]) = union_{r > b} (X \\ cl(U_r)) are both open sets"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the normality axiom (T_4) essential at each induction step in Urysohn's Lemma?",
      "options": [
        { "text": "Normality allows inserting a new open set V between the closed set cl(U_r) and the open set U_s such that cl(U_r) subset V subset cl(V) subset U_s", "isCorrect": true, "explanation": "Correct! Normality guarantees that disjoint closed sets can be separated by disjoint open sets, enabling the nested closure construction." },
        { "text": "Because all normal spaces are metric spaces", "isCorrect": false, "explanation": "Incorrect: Not all normal spaces are metrizable." },
        { "text": "Because dyadic rationals are finite", "isCorrect": false, "explanation": "Incorrect: Dyadics form a countably infinite dense set." },
        { "text": "Because f must be a polynomial", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Compact Image Preservation under Continuous Maps",
      "interactiveSteps": [
        {
          "stepText": "Let f: X -> Y be continuous with X compact. Let {V_alpha} be an open cover of the image f(X)."
        },
        {
          "prompt": "Taking preimages U_alpha = f^{-1}(V_alpha), what kind of cover do {U_alpha} form on X?",
          "options": [
            { "text": "An open cover of X, since f is continuous", "isCorrect": true },
            { "text": "A closed cover", "isCorrect": false },
            { "text": "A finite cover", "isCorrect": false },
            { "text": "An empty cover", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since X is compact, {U_alpha} has a finite subcover {U_1, ..., U_k}. Their images {V_1, ..., V_k} form a finite subcover of f(X), proving f(X) is compact."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the topologist who proved that an arbitrary product of compact spaces is compact?",
      "blankAnswer": "tychonoff"
    }
  ]
}
```
