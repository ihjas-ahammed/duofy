# Duofy Reusable Lesson Format: Matroid Axioms and Greedy Optimization

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Algebraic_Combinatorics`  
**Lesson Format Type:** `matroid_axioms_and_greedy_optimization`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Matroid Theory** (Hassler Whitney, 1935): define a matroid $M = (E, \mathcal{I})$ via **Independent Set Axioms** (non-empty, hereditary, independent augmentation), evaluate equivalent cryptomorphic axiom systems (**Bases, Circuits, Rank Function**), apply **Edmonds's Matroid Greedy Theorem** (proving a greedy algorithm finds the global optimum if and only if the underlying independence system is a matroid), and interact with live Graphic Matroid Spanning Tree Kruskal widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Matroid Independent Set Axioms & Greedy Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Matroid Cryptomorphic Axiom System & Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Rado-Edmonds Greedy Theorem Equivalence Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Graphic Matroid Minimal Dependent Subset Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Graphic Matroid Kruskal Greedy Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "matroid_axioms_and_greedy_optimization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is a Matroid M = (E, I), and what is the Rado-Edmonds Greedy Theorem?",
      "blankAnswer": "A Matroid M = (E, I) is a finite ground set E with a family of independent subsets I satisfying three axioms: (1) Non-empty: emptyset in I, (2) Hereditary: if I in I and J subseteq I, then J in I, (3) Augmentation (Independence Exchange): if I_1, I_2 in I with |I_1| < |I_2|, there exists e in I_2 \\setminus I_1 such that I_1 cup {e} in I. The Rado-Edmonds Greedy Theorem proves that for any non-negative weight function w: E -> R+, the greedy algorithm (sorting elements by weight and adding the largest feasible element) finds a maximum-weight independent set IF AND ONLY IF (E, I) is a matroid!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each cryptomorphic matroid characterization to its defining axiom.",
      "matchPairs": [
        { "left": "Independent Sets I", "right": "Exchange Axiom: |I_1| < |I_2| => exists e in I_2 \\ I_1 with I_1 cup {e} in I" },
        { "left": "Bases B (Maximal Independent)", "right": "Base Exchange: B_1, B_2 in B and x in B_1 \\ B_2 => exists y in B_2 \\ B_1 with (B_1 \\ {x}) cup {y} in B" },
        { "left": "Circuits C (Minimal Dependent)", "right": "Circuit Elimination: C_1 != C_2 and e in C_1 cap C_2 => exists C_3 in C with C_3 subseteq (C_1 cup C_2) \\ {e}" },
        { "left": "Rank Function r(A)", "right": "Submodularity: r(A cup B) + r(A cap B) <= r(A) + r(B)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does Kruskal's algorithm (1956) always guarantee finding the global Minimum Spanning Tree (MST) in any connected edge-weighted graph G?",
      "options": [
        { "text": "Because the forests (cycle-free edge subsets) of graph G form a GRAPHIC MATROID M(G); by Edmonds's Greedy Theorem, greedy selection on a matroid is mathematically guaranteed to find the globally optimal basis", "isCorrect": true, "explanation": "Correct! Graphic matroids satisfy all matroid axioms where independent sets are forests and bases are spanning trees. The success of Kruskal's greedy strategy is a direct consequence of matroid structure." },
        { "text": "Because all graphs are planar", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because greedy algorithms always work on all combinatorial problems", "isCorrect": false, "explanation": "Incorrect: Greedy fails on general non-matroid systems (e.g. Knapsack, Traveling Salesperson)." },
        { "text": "Because edge weights are always integers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "In matroid theory, what 7-letter noun denotes a minimal dependent subset (in graphic matroids, this corresponds to a simple cycle) (circuit)?",
      "blankAnswer": "circuit"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Graphic Matroid Spanning Tree Greedy Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Matroid Greedy Engine: MST on K₄</h3><p>Edges: e₁(w=1), e₂(w=2), e₃(w=3), e₄(w=4), e₅(w=5), e₆(w=6)</p><button id=\"matBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Execute Matroid Greedy Selection</button><div id=\"matOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('matBtn').onclick=()=>{document.getElementById('matOut').innerText='Selected independent edges: e₁(1) + e₂(2) + e₃(3) = 6. Edge e₄ creates a circuit (cycle) and is rejected. Global Optimal Spanning Tree Basis achieved!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
