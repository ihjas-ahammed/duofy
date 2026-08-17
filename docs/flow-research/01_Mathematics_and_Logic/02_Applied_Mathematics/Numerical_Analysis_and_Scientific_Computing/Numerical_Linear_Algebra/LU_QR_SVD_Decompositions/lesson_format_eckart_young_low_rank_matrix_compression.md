# Duofy Reusable Lesson Format: Eckart-Young-Mirsky Theorem and Low-Rank Matrix Compression

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / LU_QR_SVD_Decompositions`  
**Lesson Format Type:** `eckart_young_low_rank_matrix_compression`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Eckart-Young-Mirsky Theorem** (the truncated SVD $A_k = \sum_{j=1}^k \sigma_j u_j v_j^T$ is the unique optimal rank-$k$ approximation in both spectral and Frobenius norms), calculate compression ratios and energy recovery, and interact with live image rank truncation visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Eckart-Young-Mirsky Low-Rank Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Matrix Norm & SVD Singular Value Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Spectral Error Value Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Low Rank Truncation Method Acronym Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive SVD Image Compression Rank Truncator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "eckart_young_low_rank_matrix_compression",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What does the Eckart-Young-Mirsky Theorem state regarding the best rank-k approximation of a matrix A?",
      "blankAnswer": "For any target rank k < rank(A), the truncated SVD A_k = sum_{j=1}^k sigma_j u_j v_j^T uniquely minimizes ||A - B|| across all matrices B of rank at most k, with spectral error ||A - A_k||_2 = sigma_{k+1} and Frobenius error ||A - A_k||_F = sqrt(sum_{j=k+1}^r sigma_j^2)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each matrix norm or property to its SVD singular value expression.",
      "matchPairs": [
        { "left": "Spectral Norm ||A||_2", "right": "sigma_1 (the largest singular value)" },
        { "left": "Frobenius Norm ||A||_F", "right": "sqrt(sum_{j=1}^r sigma_j^2)" },
        { "left": "Nuclear / Trace Norm ||A||_*", "right": "sum_{j=1}^r sigma_j (sum of all singular values)" },
        { "left": "Rank-k Spectral Approximation Error", "right": "sigma_{k+1} (the first discarded singular value)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If a matrix A has singular values sigma = [100, 50, 20, 5, 1], what is the exact spectral norm error ||A - A_2||_2 when approximating A with its best rank-2 truncated SVD?",
      "options": [
        { "text": "20 (which is sigma_3, the first discarded singular value)", "isCorrect": true, "explanation": "Correct! By the Eckart-Young-Mirsky theorem, ||A - A_k||_2 = sigma_{k+1}. For k = 2, sigma_3 = 20." },
        { "text": "50", "isCorrect": false, "explanation": "Incorrect: 50 is sigma_2 (retained)." },
        { "text": "100", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: 1 is sigma_5." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What three-letter acronym denotes the matrix decomposition used to construct the optimal Eckart-Young low-rank approximation?",
      "blankAnswer": "svd"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive SVD Image Rank Truncator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>SVD Rank Truncation Compressor</h3><p>512x512 Image Matrix | Rank 512 → Rank 20</p><button id=\"svdBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Truncate to Top 20 Modes</button><div id=\"svdOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('svdBtn').onclick=()=>{document.getElementById('svdOut').innerText='Compressed! Storage reduced from 262,144 numbers to 20,480 numbers (92.2% compression ratio) while capturing 96.4% of total Frobenius energy!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
