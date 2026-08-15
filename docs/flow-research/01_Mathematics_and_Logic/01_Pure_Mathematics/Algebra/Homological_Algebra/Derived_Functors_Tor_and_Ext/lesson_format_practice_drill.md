# Duofy Reusable Lesson Format: Derived Functors (Tor and Ext) - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Homological_Algebra / Derived_Functors_Tor_and_Ext`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid mental calculation of $\text{Tor}_1$ and $\text{Ext}^1$ across classical abelian groups ($\mathbb{Z}, \mathbb{Q}, \mathbb{Z}/n\mathbb{Z}, \mathbb{Q}/\mathbb{Z}$), flat vs projective tests, and interactive resolution simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Free Module Vanishing Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Group Pair & Tor/Ext Value Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Rational Flatness Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Module Classification Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Tor Calculation Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why is Tor_1(Z, B) = 0 for any abelian group B?",
      "blankAnswer": "Because Z is a free (projective) Z-module, and free modules are flat, causing all positive Tor groups to vanish."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each pair of abelian groups to its Tor_1 value over Z.",
      "matchPairs": [
        { "left": "Tor_1(Z/4Z, Z/6Z)", "right": "Z/2Z (since gcd(4,6) = 2)" },
        { "left": "Tor_1(Z/5Z, Z/7Z)", "right": "0 (since gcd(5,7) = 1)" },
        { "left": "Tor_1(Q, Z/3Z)", "right": "0 (since Q is flat over Z)" },
        { "left": "Tor_1(Z/8Z, Z/12Z)", "right": "Z/4Z (since gcd(8,12) = 4)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is Q a flat Z-module, even though it is not a free or projective Z-module?",
      "options": [
        { "text": "Q is a direct limit of free Z-modules (Q = colim (1/n!)Z), and direct limits preserve flatness and exactness of tensor products", "isCorrect": true, "explanation": "Correct! Flatness is preserved under filtered colimits, so torsion-free abelian groups over PIDs are flat." },
        { "text": "Because Q is a finite group", "isCorrect": false, "explanation": "Incorrect: Q is infinite." },
        { "text": "Because Q has non-trivial torsion", "isCorrect": false, "explanation": "Incorrect: Q is completely torsion-free." },
        { "text": "Because Ext^1(Q, Z) = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What module property describes an R-module M for which the functor - (x)_R M preserves all short exact sequences?",
      "blankAnswer": "flat"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Tor_1(Z/mZ, Z/nZ) GCD Calculator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Tor_1(Z/m, Z/n) = Z / gcd(m, n)</h3><div style=\"margin:15px 0;\"><label>m = </label><input id=\"inM\" type=\"number\" value=\"6\" style=\"width:60px; padding:4px; margin-right:15px;\"/><label>n = </label><input id=\"inN\" type=\"number\" value=\"15\" style=\"width:60px; padding:4px;\"/></div><button id=\"calcBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Tor_1</button><div id=\"out\" style=\"margin-top:12px; color:#10b981; font-size:18px; font-weight:bold;\"></div><script>function gcd(a,b){return b==0?a:gcd(b,a%b);} document.getElementById('calcBtn').onclick=()=>{let m=parseInt(document.getElementById('inM').value), n=parseInt(document.getElementById('inN').value); let g=gcd(m,n); document.getElementById('out').innerText='Tor_1(Z/'+m+', Z/'+n+') ≅ Z/'+g+'Z'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
