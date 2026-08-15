# Duofy Reusable Lesson Format: Complex Integration and Residue Theorem - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Complex_Integration_and_Residue_Theorem`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of pole orders, mental calculation of simple residues $P(z_0)/Q'(z_0)$, standard contour integrals around unit circles, and interactive residue computation widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Simple Pole Shortcut Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Function & Residue Value Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Removable Singularity Residue Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Contour Principle Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Residue Calculator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the P/Q' shortcut formula for the residue of f(z) = P(z)/Q(z) at a simple pole z_0 where Q(z_0) = 0 and Q'(z_0) != 0?",
      "blankAnswer": "Res(f, z_0) = P(z_0) / Q'(z_0)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each function to its residue at the specified singularity.",
      "matchPairs": [
        { "left": "1 / (z - 3) at z = 3", "right": "Residue = 1" },
        { "left": "1 / (z^2 + 1) at z = i", "right": "Residue = 1 / (2i) = -i/2" },
        { "left": "e^{1/z} at z = 0", "right": "Residue = 1 (from Laurent term 1/z)" },
        { "left": "sin(z) / z^2 at z = 0", "right": "Residue = 1 (since sin(z)/z^2 = 1/z - z/6 + ...)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the residue of a function f(z) at a removable singularity z_0 (such as sin(z)/z at z = 0)?",
      "options": [
        { "text": "0 (the Laurent series has no negative powers, so a_{-1} = 0)", "isCorrect": true, "explanation": "Correct! At a removable singularity, the Laurent series is a Taylor series with a_{-1} = 0." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: 1 is the value f(0), but the residue is the coefficient of 1/z which is 0." },
        { "text": "2 pi i", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Undefined", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the term for the coefficient a_{-1} of the (z - z_0)^{-1} term in the Laurent series expansion?",
      "blankAnswer": "residue"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Residue Theorem Integral Evaluator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Evaluate oint_{|z|=3} 1/(z^2+4) dz</h3><p>Poles: z = +2i and z = -2i (both inside circle |z|=3)</p><button id=\"intBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Sum Residues & Multiply by 2πi</button><div id=\"intOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('intBtn').onclick=()=>{document.getElementById('intOut').innerText='Res(2i) = 1/(4i), Res(-2i) = -1/(4i). Sum = 0 -> Integral = 2*pi*i*(0) = 0!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
