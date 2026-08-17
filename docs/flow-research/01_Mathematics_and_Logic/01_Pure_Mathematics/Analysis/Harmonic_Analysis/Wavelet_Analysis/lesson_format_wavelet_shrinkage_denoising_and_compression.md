# Duofy Reusable Lesson Format: Wavelet Shrinkage, Signal Denoising, and Compression

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Wavelet_Analysis`  
**Lesson Format Type:** `wavelet_shrinkage_denoising_and_compression`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to execute **Donoho-Johnstone Wavelet Shrinkage Denoising** (VisuShrink, SureShrink), compare **Hard vs Soft Thresholding** operators ($\eta_{\text{hard}}(w)$ vs $\eta_{\text{soft}}(w)$), apply the Universal Threshold $\lambda = \sigma \sqrt{2 \ln N}$, and explore JPEG 2000 biorthogonal wavelet compression (CDF 9/7).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Universal Threshold & Wavelet Shrinkage Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Thresholding Rule & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | JPEG 2000 Wavelet vs DCT Blocking Artifacts Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Thresholding Function Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Wavelet Soft Threshold Denoising Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "wavelet_shrinkage_denoising_and_compression",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Donoho-Johnstone Universal Threshold formula for denoising a signal of length N corrupted by Gaussian noise N(0, sigma^2)?",
      "blankAnswer": "lambda = sigma * sqrt(2 * ln(N)). It asymptotically removes all spurious Gaussian noise spikes with high probability."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each wavelet thresholding operator to its mathematical formula.",
      "matchPairs": [
        { "left": "Hard Thresholding eta_hard(w, lambda)", "right": "w if |w| >= lambda, and 0 if |w| < lambda (discontinuous keep-or-kill)" },
        { "left": "Soft Thresholding eta_soft(w, lambda)", "right": "sgn(w) * max(|w| - lambda, 0) (continuous shrinkage toward zero)" },
        { "left": "Garrote Non-Negative Thresholding", "right": "w - lambda^2 / w if |w| >= lambda, and 0 otherwise" },
        { "left": "Universal VisuShrink Threshold", "right": "lambda = sigma * sqrt(2 ln N)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the JPEG 2000 image compression standard (based on the Cohen-Daubechies-Feauveau 9/7 biorthogonal wavelet) eliminate the blocky grid artifacts common in legacy JPEG?",
      "options": [
        { "text": "Wavelet transforms operate globally across the entire image at multiple dyadic scales, rather than dividing the image into rigid 8x8 pixel blocks like the Discrete Cosine Transform (DCT)", "isCorrect": true, "explanation": "Correct! Wavelets provide seamless multi-scale spatial decomposition without block boundaries, completely eliminating 8x8 blocking artifacts." },
        { "text": "Because JPEG 2000 does not compress images", "isCorrect": false, "explanation": "Incorrect: JPEG 2000 achieves higher compression ratios than legacy JPEG." },
        { "text": "Because wavelets are only 1-dimensional", "isCorrect": false, "explanation": "Incorrect: 2D wavelets are constructed via separable tensor products." },
        { "text": "Because noise is always zero in JPEG 2000", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "Which continuous thresholding operator contracts all wavelet coefficients exceeding lambda toward zero by exactly lambda?",
      "blankAnswer": "soft"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Wavelet Soft Thresholding Denoising Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Wavelet Soft Threshold Denoising</h3><p>Signal coefficient w = 4.5 | Noise threshold λ = 1.5</p><button id=\"denoiseBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Soft Threshold η_λ(w)</button><div id=\"denoiseOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('denoiseBtn').onclick=()=>{document.getElementById('denoiseOut').innerText='Denoised coefficient: η_soft(4.5, 1.5) = sgn(4.5)*(4.5 - 1.5) = +3.0! Noise suppressed while signal energy preserved.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
