# Duofy Reusable Lesson Format: Orthogonal Varimax and Oblique Factor Rotations

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Multivariate_Statistical_Analysis / PCA_and_Factor_Analysis`  
**Lesson Format Type:** `orthogonal_varimax_and_oblique_rotations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Factor Rotation Techniques**: understand Thurstone's criteria for **Simple Structure**, execute **Orthogonal Varimax Rotation** (Henry Kaiser, 1958) to maximize variance of squared loadings while preserving $90^\circ$ independence ($\mathbf{T}^T \mathbf{T} = \mathbf{I}$), contrast against **Oblique Rotations (Promax / Direct Oblimin)** allowing correlated factors ($\operatorname{Cov}(\mathbf{f}) = \mathbf{\Phi}$), and interact with live 2D factor loading rotation simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Factor Rotation & Simple Structure Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Rotation Method & Factor Relationship Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Varimax Maximization Criterion Objective Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Non-Orthogonal Rotation Adjective Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Factor Loading Varimax Rotation Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "orthogonal_varimax_and_oblique_rotations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why are initial unrotated factor loading matrices rotated, and what is the difference between Orthogonal (Varimax) and Oblique (Promax) rotations?",
      "blankAnswer": "Initial factor extractions maximize total variance sequentially, producing uninterpretable cross-loadings where variables load moderately on all factors. Factor rotation applies an invertible transformation T (Lambda* = Lambda * T) to achieve Thurstone's 'Simple Structure' (each variable loads heavily on ONE factor and near-zero on others). Orthogonal rotations (Varimax) force factors to remain strictly uncorrelated (T^T T = I at 90 degrees), whereas Oblique rotations (Promax, Oblimin) allow factors to correlate, providing more realistic representations of correlated psychological or socioeconomic constructs."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each factor rotation technique to its mathematical and geometric behavior.",
      "matchPairs": [
        { "left": "Varimax Rotation (Orthogonal)", "right": "Maximizes variance of squared loadings per factor while preserving strict 90-degree independence" },
        { "left": "Quartimax Rotation (Orthogonal)", "right": "Maximizes variance of squared loadings across rows (simplifies variables rather than factors)" },
        { "left": "Promax Rotation (Oblique)", "right": "Raises Varimax loadings to higher powers (e.g. 4) and relaxes orthogonality to allow factor correlations" },
        { "left": "Simple Structure (Thurstone)", "right": "Ideal pattern where every variable loads cleanly on one dominant factor with near-zero secondary loadings" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What mathematical criterion does Henry Kaiser's Varimax algorithm (1958) maximize when searching for the optimal rotation matrix T?",
      "options": [
        { "text": "The sample VARIANCE OF SQUARED LOADINGS across columns: V = sum_{j=1}^m [ (1/p) sum_{i=1}^p (lambda_{ij}^*)^4 - ((1/p) sum_{i=1}^p (lambda_{ij}^*)^2)^2 ] (pushing loadings toward +/- 1 or 0)", "isCorrect": true, "explanation": "Correct! Maximizing the variance of squared loadings forces each loading to become either very large (near +/- 1) or very small (near 0), eliminating ambiguous intermediate loadings." },
        { "text": "The determinant of the covariance matrix", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The sum of eigenvalues", "isCorrect": false, "explanation": "Incorrect: Eigenvalue sums are rotationally invariant." },
        { "text": "The number of observations n", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What adjective describes factor rotation methods (like Promax or Direct Oblimin) that allow latent factors to be correlated rather than strictly orthogonal?",
      "blankAnswer": "oblique"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Varimax Factor Rotation Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Varimax Factor Rotation</h3><p>Unrotated Loadings: Math = (0.71, 0.70) | English = (0.71, -0.69)</p><button id=\"rotBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply 45° Varimax Rotation</button><div id=\"rotOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('rotBtn').onclick=()=>{document.getElementById('rotOut').innerText='Rotated Loadings: Math = (1.00, 0.01) [Factor 1: Quantitative Skill] | English = (0.01, 0.99) [Factor 2: Verbal Skill]. Perfect Thurstone Simple Structure achieved!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
