# Duofy Reusable Lesson Format: Structure Factor and Systematic Extinction Rules

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Crystal_Lattices_and_X_Ray_Diffraction`  
**Lesson Format Type:** `structure_factor_and_systematic_extinction_rules`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through diffraction intensity calculations: formulate the **Geometrical Structure Factor $S_{hkl} = \sum_j f_j e^{-2\pi i(h x_j + k y_j + l z_j)}$**, evaluate the **Atomic Form Factor $f_j(\mathbf{G})$**, derive **Systematic Extinction Rules** for **BCC ($h+k+l$ must be even)** and **FCC ($h, k, l$ all even or all odd)**, calculate structure factors for the **Diamond Lattice** and **Sodium Chloride (NaCl)**, and determine diffraction peak intensities.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Structure Factor & Extinction Rules Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step BCC Systematic Extinction Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Crystal Structure & Allowed Miller Indices Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | FCC Parity Selection Condition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Diamond Structure (200) Peak Vanishing Origin Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Geometrical Structure Factor for a unit cell containing $N$ atoms at basis positions $\mathbf{r}_j = x_j \mathbf{a}_1 + y_j \mathbf{a}_2 + z_j \mathbf{a}_3$:
   $$S_{hkl} \equiv \sum_{j=1}^N f_j \, e^{-i \mathbf{G} \cdot \mathbf{r}_j} = \sum_{j=1}^N f_j \, e^{-2\pi i (h x_j + k y_j + l z_j)}$$
   where $f_j$ is the **Atomic Form Factor** (Fourier transform of the atomic electron cloud $\rho_j(\mathbf{r})$).
   - **Diffracted Intensity:** $I_{hkl} \propto |S_{hkl}|^2$.
   - **BCC Extinction Rule (2 atoms at $(0,0,0)$ and $(\frac{1}{2}, \frac{1}{2}, \frac{1}{2})$):**
     $$S_{hkl} = f [1 + e^{-i\pi(h+k+l)}] = \begin{cases} 2f, & h+k+l \text{ is EVEN (Allowed)} \\ 0, & h+k+l \text{ is ODD (Extinct)} \end{cases}$$
   - **FCC Extinction Rule (4 atoms):**
     $$S_{hkl} = f [1 + e^{-i\pi(k+l)} + e^{-i\pi(h+l)} + e^{-i\pi(h+k)}] = \begin{cases} 4f, & h, k, l \text{ ALL EVEN or ALL ODD} \\ 0, & h, k, l \text{ MIXED (Extinct)} \end{cases}$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the BCC extinction condition: (1) write basis coordinates for BCC conventional cell: $(0, 0, 0)$ and $(1/2, 1/2, 1/2)$, (2) plug into structure factor formula: $S_{hkl} = f e^{-2\pi i(0)} + f e^{-2\pi i(h/2 + k/2 + l/2)}$, (3) simplify the exponential: $S_{hkl} = f [1 + e^{-i\pi(h + k + l)}]$, (4) apply Euler's identity $e^{-i\pi m} = (-1)^m$ where $m = h + k + l$, (5) if $h+k+l$ is odd, $(-1)^m = -1 \implies S_{hkl} = f[1 - 1] = 0$ (destructive interference, peak is missing!), while if even, $S_{hkl} = 2f$ (constructive interference)!
3. **Slide 3 (`matching`):** Pair 4 crystal systems (BCC Metal (e.g. Fe), FCC Metal (e.g. Cu, Al), Simple Cubic (e.g. Po), Diamond Lattice (e.g. C, Si)) with their lowest-index allowed diffraction peaks ($(110), (200), (211)$, $(111), (200), (220)$, $(100), (110), (111)$, $(111), (220), (311)$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in an FCC crystal, diffraction peaks are allowed only when $h, k, l$ are all even or all odd (unmixed parity). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Diamond crystal structure: The Diamond structure has an FCC lattice with a 2-atom basis at $(0,0,0)$ and $(1/4, 1/4, 1/4)$. Why does the $(200)$ peak vanish in Diamond even though $h,k,l$ are all even? (Because the 2-atom basis structure factor has the factor $1 + e^{-i\pi(h+k+l)/2}$; for $(200)$, $h+k+l = 2 \implies 1 + e^{-i\pi} = 1 - 1 = 0$, causing complete destructive interference between the two interpenetrating FCC sublattices).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "structure_factor_and_systematic_extinction_rules",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Structure Factor and Systematic Extinctions**\n• **The Geometrical Structure Factor $S_{hkl}$:**\n$$\nS_{hkl} = \\sum_{j=1}^N f_j \\, e^{-2\\pi i (h x_j + k y_j + l z_j)}\n$$\n• **Diffraction Peak Intensity:** $I_{hkl} \\propto |S_{hkl}|^2$.\n• **Systematic Extinction Rules for Cubic Lattices:**\n  - **Simple Cubic (SC):** All $(hkl)$ planes are allowed.\n  - **Body-Centered Cubic (BCC):** Allowed if and only if $h + k + l = \\text{EVEN}$ (e.g. (110), (200), (211)).\n  - **Face-Centered Cubic (FCC):** Allowed if and only if $h, k, l$ are **UNMIXED** (all even or all odd, e.g. (111), (200), (220)).\n  - **Diamond Structure:** FCC unmixed condition PLUS $h + k + l = 4n$ (if all even) or odd."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the algebraic steps deriving the BCC extinction condition S_hkl = 0 for odd h+k+l.",
      "orderItems": [
        "Identify the 2 basis atom coordinates in the BCC unit cell: (0, 0, 0) and (1/2, 1/2, 1/2)",
        "Substitute coordinates into the structure factor definition: S_hkl = f * exp(0) + f * exp(-2 pi i [h/2 + k/2 + l/2])",
        "Factor atomic scattering factor: S_hkl = f * [ 1 + exp(-i pi (h + k + l)) ]",
        "Apply Euler's parity identity: exp(-i pi m) = (-1)^m where m = h + k + l",
        "Evaluate parity: if h+k+l is odd, (-1)^m = -1 => S_hkl = f * (1 - 1) = 0 (complete destructive interference)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each crystal structure to its first 3 allowed diffraction peaks.",
      "matchPairs": [
        { "left": "Simple Cubic (SC)", "right": "(100), (110), (111) — all integer indices allowed" },
        { "left": "Body-Centered Cubic (BCC)", "right": "(110), (200), (211) — requires h+k+l = even" },
        { "left": "Face-Centered Cubic (FCC)", "right": "(111), (200), (220) — requires h,k,l all odd or all even" },
        { "left": "Diamond Cubic (Si, Ge, C)", "right": "(111), (220), (311) — (200) and (222) are systematically extinct" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an FCC crystal, diffraction peaks are permitted only when Miller indices h, k, l are all even or all ___.",
      "blankAnswer": "odd",
      "blankDistractors": ["prime", "zero", "positive"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the (200) diffraction peak COMPLETELY EXTINCT in the diamond cubic crystal structure (like silicon or carbon) even though h, k, l are all even?",
      "options": [
        { "text": "Diamond has a 2-atom basis at (0,0,0) and (1/4, 1/4, 1/4) per FCC lattice point, giving an extra basis factor [1 + exp(-i*pi*(h+k+l)/2)]; for (200), h+k+l = 2, so [1 + exp(-i*pi)] = 1 - 1 = 0", "isCorrect": true, "explanation": "Correct! The diamond structure factor is S_diamond = S_FCC * [1 + exp(-i*pi*(h+k+l)/2)]. For (200), S_FCC = 4f, but the second factor evaluates to 1 + exp(-i*pi) = 1 - 1 = 0, causing exact destructive interference between the two interpenetrating FCC sublattices." },
        { "text": "Because diamond is transparent to X-rays", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because (200) planes do not exist in diamond", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because carbon has 6 electrons", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
