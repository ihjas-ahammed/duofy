# Duofy Reusable Lesson Format: The Friedberg-Muchnik Theorem and Incomparable c.e. Degrees

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Computability_and_Recursion_Theory / Turing_Degrees_and_Unsolvability`  
**Lesson Format Type:** `friedberg_muchnik_incomparable_ce_degrees`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Friedberg-Muchnik Theorem (1956/1957)**: construct two computably enumerable sets $A$ and $B$ that are **Turing Incomparable** ($A \not\le_T B$ and $B \not\le_T A$), examine the dynamic interplay of requirements $\mathcal{P}_{2e}: A \ne \Phi_e^B$ and $\mathcal{N}_{2e}: \text{preserve } \Phi_e^A(x)$, explore the algebraic lattice structure of c.e. degrees $\mathcal{R}$, and interact with live priority queue requirement simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Friedberg-Muchnik Theorem & Incomparable Degrees Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Priority Argument Component & Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Incomparable Degrees Join Bound Upper Semilattice Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Degree Comparison Adjective Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Priority Queue Witness & Restraint Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "friedberg_muchnik_incomparable_ce_degrees",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Friedberg-Muchnik Theorem, and why does it definitively solve Post's Problem for Turing degrees?",
      "blankAnswer": "The Friedberg-Muchnik Theorem (Albert Muchnik 1956, Richard Friedberg 1957) proves the existence of two computably enumerable (c.e.) sets A and B that are TURING INCOMPARABLE: A not <=_T B and B not <=_T A. Consequently, both degrees a = d(A) and b = d(B) lie strictly between 0 and 0' (0 < a < 0' and 0 < b < 0'), proving that the c.e. Turing degrees are neither trivial (containing more than {0, 0'}) nor linearly ordered!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each component of the Friedberg-Muchnik construction to its role.",
      "matchPairs": [
        { "left": "Requirement P_{2e}: A != Phi_e^B", "right": "Ensures set A cannot be computed by an oracle for set B" },
        { "left": "Requirement P_{2e+1}: B != Phi_e^A", "right": "Ensures set B cannot be computed by an oracle for set A" },
        { "left": "Follower / Witness x(e, s)", "right": "Dynamic candidate integer appointed to enter set A if oracle computation outputs 0" },
        { "left": "Restraint Function r(e, s)", "right": "Upper bound on oracle queries made by higher priority computations to prevent destruction" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If a and b are the incomparable c.e. degrees constructed by the Friedberg-Muchnik theorem, what can be said about their least upper bound (join) a v b?",
      "options": [
        { "text": "The join a v b is a valid c.e. degree satisfying a < a v b and b < a v b (and in particular, a v b can be strictly below 0' or equal to 0')", "isCorrect": true, "explanation": "Correct! The join of any two c.e. degrees is represented by the disjoint union A (+) B = {2x : x in A} cup {2x+1 : x in B}, which is c.e. and strictly above both a and b." },
        { "text": "The join a v b is always 0", "isCorrect": false, "explanation": "Incorrect: 0 is the meet/bottom." },
        { "text": "The join does not exist because degrees are non-computable", "isCorrect": false, "explanation": "Incorrect: Turing degrees form an upper semilattice." },
        { "text": "a v b is not computably enumerable", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What 12-letter adjective describes two Turing degrees a and b such that neither a <=_T b nor b <=_T a holds (incomparable)?",
      "blankAnswer": "incomparable"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Priority Method Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Friedberg-Muchnik Priority Engine</h3><p>Managing Requirements: R₀ (Priority 1), R₁ (Priority 2), R₂ (Priority 3)</p><button id=\"priBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Execute Stage s=4 Action</button><div id=\"priOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('priBtn').onclick=()=>{document.getElementById('priOut').innerText='Stage 4: R₀ satisfied! Witness x=2 enters A. Restraint for R₁ injured (resetting witness x₁=5). R₀ now permanently dormant; R₁ stabilizes. Incomparability A |_| B achieved!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
