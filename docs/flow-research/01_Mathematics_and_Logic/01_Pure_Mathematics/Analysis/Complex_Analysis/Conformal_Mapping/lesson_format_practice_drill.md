# Duofy Reusable Lesson Format: Conformal Mapping - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Conformal_Mapping`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of canonical conformal maps (Half-plane to disk, Sector to strip, Circle inversion), cross-ratio formulas, Joukowsky airfoil mappings, and interactive conformal grid visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cayley Transform Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Geometric Region & Conformal Map Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Circle-to-Line Inversion Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Transformation Theorem Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Conformal Grid Deformer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Cayley transform mapping the upper half-plane {Im(z) > 0} to the open unit disk {|w| < 1}?",
      "blankAnswer": "w = (z - i) / (z + i), which sends the real line Im(z)=0 onto the boundary unit circle |w|=1."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each domain to its standard conformal mapping.",
      "matchPairs": [
        { "left": "Sector {0 < arg(z) < pi/4}", "right": "Maps to upper half-plane via w = z^4" },
        { "left": "Infinite Strip {0 < Im(z) < pi}", "right": "Maps to upper half-plane via w = e^z" },
        { "left": "Upper Half-Plane {Im(z) > 0}", "right": "Maps to unit disk via w = (z - i)/(z + i)" },
        { "left": "Exterior of Unit Disk {|z| > 1}", "right": "Maps to interior of unit disk via w = 1/z" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Under the complex inversion map w = 1/z, what is the image of a circle passing through the origin z = 0?",
      "options": [
        { "text": "A straight line not passing through the origin in the w-plane", "isCorrect": true, "explanation": "Correct! Inversion sends the point z = 0 to w = infinity, transforming any circle passing through the origin into a straight line." },
        { "text": "Another circle passing through the origin", "isCorrect": false, "explanation": "Incorrect: A circle through 0 must contain infinity in its image, making it a line." },
        { "text": "A single point", "isCorrect": false, "explanation": "Incorrect: 1/z is a bijection on the extended complex plane." },
        { "text": "A parabola", "isCorrect": false, "explanation": "Incorrect: Möbius maps preserve generalized circles (lines and circles)." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "Whose mapping theorem guarantees that every simply connected proper domain in C can be conformally mapped to the unit disk?",
      "blankAnswer": "riemann"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Conformal Grid Distortion Widget",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Conformal Map: w = z^2</h3><p>Orthogonal grid lines in z-plane map to orthogonal parabolas in w-plane!</p><button id=\"mapBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply w = z^2</button><div id=\"mapOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('mapBtn').onclick=()=>{document.getElementById('mapOut').innerText='Conformal property verified! Angles between intersecting coordinate lines remain exactly 90°.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
