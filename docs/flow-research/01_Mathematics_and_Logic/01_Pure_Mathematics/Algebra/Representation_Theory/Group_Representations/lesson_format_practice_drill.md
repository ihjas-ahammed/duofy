# Duofy Reusable Lesson Format: Group Representations - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Group_Representations`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid identification of representation matrix properties (unitarity, conjugacy trace invariance), standard representation dimensions ($n-1$ for $S_n$), and interactive representation direct sum widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Center Scalar Action Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Symmetric Group & Standard Rep Dimension Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Abelian Group Irrep Dimension Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Homomorphism Space Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Subrepresentation Splitter Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why does every element z in the center Z(G) of a finite group act as a scalar matrix on any complex irreducible representation V?",
      "blankAnswer": "Because rho(z) commutes with all rho(g), making rho(z) a G-homomorphism. By Schur's Lemma, rho(z) = lambda * id_V."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each symmetric group S_n to the dimension of its standard irreducible representation V_std.",
      "matchPairs": [
        { "left": "S_3", "right": "Dimension 2 (3 - 1)" },
        { "left": "S_4", "right": "Dimension 3 (4 - 1)" },
        { "left": "S_5", "right": "Dimension 4 (5 - 1)" },
        { "left": "S_2", "right": "Dimension 1 (2 - 1)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the maximum dimension of any complex irreducible representation of a finite abelian group?",
      "options": [
        { "text": "1 (all irreducible representations of abelian groups over C are 1-dimensional)", "isCorrect": true, "explanation": "Correct! In an abelian group, all elements are in the center Z(G), so by Schur's Lemma every matrix rho(g) is scalar, meaning every 1D subspace is G-invariant." },
        { "text": "|G|", "isCorrect": false, "explanation": "Incorrect: |G| is the dimension of the regular representation." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect: Non-abelian groups can have 2D irreps, but abelian groups only have 1D irreps." },
        { "text": "Infinite", "isCorrect": false, "explanation": "Incorrect: Representations of finite groups over C are finite-dimensional." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a linear map between two representations that commutes with the group action across all elements?",
      "blankAnswer": "equivariant"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Representation Decomposition Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Decompose Permutation Rep C^3</h3><p>C^3 = V_triv (span(1,1,1)) ⊕ V_std (x_1+x_2+x_3=0)</p><button id=\"splitBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Maschke Projection</button><div id=\"outBox\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('splitBtn').onclick=()=>{document.getElementById('outBox').innerText='Projection applied! Dim(V_triv) = 1, Dim(V_std) = 2. Direct sum complete!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
