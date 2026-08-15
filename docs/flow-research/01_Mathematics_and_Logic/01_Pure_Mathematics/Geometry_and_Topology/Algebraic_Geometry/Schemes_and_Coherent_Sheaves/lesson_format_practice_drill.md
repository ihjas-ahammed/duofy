# Duofy Reusable Lesson Format: Schemes and Coherent Sheaves - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_Geometry / Schemes_and_Coherent_Sheaves`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of scheme stalk calculations ($\mathcal{O}_{X, \mathfrak{p}} \cong R_\mathfrak{p}$), sheaf exact sequences, Serre duality on projective spaces ($H^i(X, \mathcal{F}) \cong H^{n-i}(X, \omega_X \otimes \mathcal{F}^*)^*$), and interactive scheme stalk visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Serre Duality on Projective Space Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Ring & Spec Points/Stalks Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Canonical Sheaf of $\mathbb{P}^n$ Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Ringed Space Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Scheme Stalk Inspector Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the canonical sheaf omega_{P^n} of projective n-space P^n, and what is Serre Duality on P^n?",
      "blankAnswer": "omega_{P^n} = O_{P^n}(-n - 1). Serre duality states H^i(P^n, F) is canonically isomorphic to H^{n-i}(P^n, omega_{P^n} tensor F*)*."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each ring to the geometric description of its prime spectrum Spec(R).",
      "matchPairs": [
        { "left": "Spec(C[x])", "right": "Affine line A^1 with closed points (x - a) and generic point (0)" },
        { "left": "Spec(Z)", "right": "Arithmetic curve with closed points (p) for primes p and generic point (0)" },
        { "left": "Spec(R[x] / (x^2 + 1))", "right": "A single point with residue field C (field extension)" },
        { "left": "Spec(k[x] / (x^2))", "right": "A single double-point with non-zero nilpotent regular function" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the canonical bundle omega_{P^1} of the projective line P^1?",
      "options": [
        { "text": "O_{P^1}(-2) (since omega_{P^n} = O(-n-1) with n = 1)", "isCorrect": true, "explanation": "Correct! For n = 1, -n - 1 = -2, so the canonical sheaf is O(-2)." },
        { "text": "O_{P^1}(-1)", "isCorrect": false, "explanation": "Incorrect: O(-1) is the tautological line bundle." },
        { "text": "O_{P^1}(0)", "isCorrect": false, "explanation": "Incorrect: O(0) is the trivial bundle." },
        { "text": "O_{P^1}(2)", "isCorrect": false, "explanation": "Incorrect: O(2) is the tangent bundle T_{P^1}." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What adjective describes a ringed space whose stalks at all points are local rings?",
      "blankAnswer": "locally"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Scheme Stalk Inspector",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Scheme: X = Spec(Z)</h3><p>Select a point to inspect its stalk O_{X, p} and residue field κ(p):</p><div style=\"display:flex; gap:10px; margin:15px 0;\"><button id=\"genPt\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">Generic Point (0)</button><button id=\"clPt\" style=\"padding:8px 16px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Closed Point (p = 7)</button></div><div id=\"specOut\" style=\"color:#38bdf8; font-weight:bold;\">Closed Point (7): Stalk = Z_{(7)} (rationals with denominator coprime to 7). Residue field = F_7!</div><script>document.getElementById('genPt').onclick=()=>{document.getElementById('specOut').innerText='Generic Point (0): Stalk = Q (Field of fractions). Residue field = Q!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}; document.getElementById('clPt').onclick=()=>{document.getElementById('specOut').innerText='Closed Point (7): Stalk = Z_{(7)}. Residue field = Z/7Z = F_7!';};</script></div>"
    }
  ]
}
```
