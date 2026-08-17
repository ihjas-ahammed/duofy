# Duofy Reusable Lesson Format: Discrete Wavelet Transform (DWT), Filter Banks, and Mallat's Algorithm

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Wavelet_Analysis`  
**Lesson Format Type:** `discrete_wavelet_filterbanks_and_fast_transform`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to execute **Mallat's Fast Wavelet Transform (FWT)** algorithm, compute Discrete Wavelet Transform (DWT) approximations $a_{j-1}[k] = \sum_n h_{n - 2k} a_j[n]$ and details $d_{j-1}[k] = \sum_n g_{n - 2k} a_j[n]$ through convolution and downsampling ($\downarrow 2$), and verify perfect reconstruction via upsampling ($\uparrow 2$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mallat's Pyramidal Filter Bank Algorithm Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 1-Level Haar DWT Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Downsampling Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Wavelet Detail Coefficient Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | FWT Computational Complexity vs FFT Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Mallat's Algorithm: A discrete signal $a_0[n]$ of length $N$ is decomposed into low-pass approximation $a_{-1}[k] = \sum_n h_{n - 2k} a_0[n]$ and high-pass detail $d_{-1}[k] = \sum_n g_{n - 2k} a_0[n]$, followed by dyadic downsampling $\downarrow 2$. Perfect reconstruction is achieved by upsampling $\uparrow 2$ and convolving with synthesis filters $\tilde{h}, \tilde{g}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct a 1-level Haar DWT on discrete input vector $x = [4, 6, 10, 12]$ using normalized Haar filters $h = [1/\sqrt{2}, 1/\sqrt{2}]$ and $g = [1/\sqrt{2}, -1/\sqrt{2}]$: (1) low-pass averages: $a_1 = (4+6)/\sqrt{2} = 5\sqrt{2} \approx 7.07$, $a_2 = (10+12)/\sqrt{2} = 11\sqrt{2} \approx 15.56$, (2) high-pass details: $d_1 = (4-6)/\sqrt{2} = -\sqrt{2} \approx -1.41$, $d_2 = (10-12)/\sqrt{2} = -\sqrt{2} \approx -1.41$, (3) concatenated transform: $[5\sqrt{2}, 11\sqrt{2} \mid -\sqrt{2}, -\sqrt{2}]$, (4) inverse reconstruction check: $x_1 = (a_1 + d_1)/\sqrt{2} = (5\sqrt{2} - \sqrt{2})/\sqrt{2} = 4$, $x_2 = (a_1 - d_1)/\sqrt{2} = 6$, recovering the exact input.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that at each stage of the Mallat pyramidal algorithm, convolution is followed by downsampling by a factor of two. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the unnormalized Haar detail coefficient $d = \frac{x_1 - x_2}{2}$ for input pair $x_1 = 18, x_2 = 6$ ($d = (18 - 6)/2 = 6.0$).
5. **Slide 5 (`quiz`):** Quiz comparing computational complexity: What is the asymptotic time complexity of computing a full $J$-level Fast Wavelet Transform on a signal of length $N$? ($\mathcal{O}(N)$ linear time, strictly faster than $\mathcal{O}(N \log N)$ Fast Fourier Transform).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "discrete_wavelet_filterbanks_and_fast_transform",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Mallat's Pyramidal Fast Wavelet Transform (FWT)**\nLet $a_j$ be the discrete approximation coefficients of a signal at scale $j$.\n• **Analysis (Decomposition):**\n$$\n\\begin{aligned}\na_{j-1}[k] &= \\sum_{n \\in \\mathbb{Z}} h[n - 2k] \\, a_j[n] \\quad (\\text{Low-pass Filter } + \\text{ Downsample } \\downarrow 2) \\\\\nd_{j-1}[k] &= \\sum_{n \\in \\mathbb{Z}} g[n - 2k] \\, a_j[n] \\quad (\\text{High-pass Filter } + \\text{ Downsample } \\downarrow 2)\n\\end{aligned}\n$$\n• **Synthesis (Perfect Reconstruction):**\n$$\na_j[n] = \\sum_{k \\in \\mathbb{Z}} \\left( h[n - 2k] \\, a_{j-1}[k] + g[n - 2k] \\, d_{j-1}[k] \\right)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Input Signal:** $x = [4, \\, 6, \\, 10, \\, 12]$.\n• **Step 1 (Haar Low-Pass Averages):**\n  $$a[0] = \\frac{4 + 6}{\\sqrt{2}} = 5\\sqrt{2}, \\quad a[1] = \\frac{10 + 12}{\\sqrt{2}} = 11\\sqrt{2}$$\n• **Step 2 (Haar High-Pass Details):**\n  $$d[0] = \\frac{4 - 6}{\\sqrt{2}} = -\\sqrt{2}, \\quad d[1] = \\frac{10 - 12}{\\sqrt{2}} = -\\sqrt{2}$$\n• **Step 3 (Reconstruction Check):**\n  $$x[0] = \\frac{a[0] + d[0]}{\\sqrt{2}} = \\frac{5\\sqrt{2} - \\sqrt{2}}{\\sqrt{2}} = 4, \\quad x[1] = \\frac{a[0] - d[0]}{\\sqrt{2}} = \\frac{5\\sqrt{2} + \\sqrt{2}}{\\sqrt{2}} = 6$$"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In Mallat's discrete wavelet filter bank, every convolution step is immediately followed by downsampling by a factor of ___.",
      "blankAnswer": "two",
      "blankDistractors": ["four", "three", "eight"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the unnormalized average (scaling) coefficient a = (x_1 + x_2) / 2 for the signal pair x_1 = 18 and x_2 = 6.",
      "numericAnswer": 12.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the total computational complexity of the Fast Wavelet Transform (FWT) algorithm for a 1D discrete signal of length N?",
      "options": [
        { "text": "O(N) linear time (because N + N/2 + N/4 + ... = 2N operations, faster than O(N log N) FFT)", "isCorrect": true, "explanation": "Correct! Because each stage halves the signal length, the geometric series sum converges to 2N, giving strictly linear O(N) complexity." },
        { "text": "O(N log N)", "isCorrect": false, "explanation": "Incorrect: O(N log N) is the complexity of the Fast Fourier Transform (FFT)." },
        { "text": "O(N^2)", "isCorrect": false, "explanation": "Incorrect: O(N^2) is direct matrix multiplication." },
        { "text": "O(log N)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
