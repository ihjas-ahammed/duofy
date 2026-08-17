# Duofy Reusable Lesson Format: Z-Transform (ROC Annular Geometry & DT Stability)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Z_Transforms_and_Filter_Design`  
**Lesson Format Type:** `z_transform_region_of_convergence_and_discrete_lti_stability`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the bilateral discrete-time Z-transform, complex variable $z = r e^{j\omega}$, Region of Convergence (ROC) annular geometry, pole-zero distributions, and discrete-time system stability/causality criteria in digital signal processing (Alan V. Oppenheim & Ronald W. Schafer *Discrete-Time Signal Processing* Chapter 3; John G. Proakis *Digital Signal Processing* Chapter 3): define the **Bilateral Z-Transform**:
$$\mathbf{X(z) = \mathcal{Z}\{x[n]\} = \sum_{n=-\infty}^\infty x[n] z^{-n} = \sum_{n=-\infty}^\infty \left[ x[n] r^{-n} \right] e^{-j\omega n} \quad \left(z = r e^{j\omega}\right)}$$
master the **Four Fundamental Discrete ROC Topology Invariants**:
1. The ROC is an annular ring or disk centered at the origin $|z| = 0$ in the complex $z$-plane;
2. The ROC contains **strictly ZERO poles**;
3. For a **Right-Sided (Causal) Sequence**, the ROC extends outward from the outermost pole: $\mathbf{|z| > r_{\text{max}}}$;
4. For a **Left-Sided (Anti-Causal) Sequence**, the ROC extends inward from the innermost pole: $\mathbf{|z| < r_{\text{min}}}$;
5. **DT LTI BIBO Stability Invariant:** A discrete-time LTI system is BIBO stable if and only if **the ROC includes the Unit Circle ($\mathbf{|z| = 1 \in \text{ROC}}$)**;
and prove that a **Causal Discrete-Time LTI System is BIBO Stable if and only if ALL transfer function poles lie strictly INSIDE the Open Unit Circle ($\mathbf{|p_k| < 1}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Z-Transform ($X(z) = \sum x[n] z^{-n}$), ROC Ring Topology & Unit Circle Stability ($|z|=1$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Determine ROC and Evaluate Discrete Causality and Stability Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Discrete Sequence Type / Pole Location & z-Domain ROC Topology Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | For a Causal and BIBO Stable Discrete-Time LTI System, All Transfer Function Poles Must Lie Strictly Inside the Unit ___ (Circle / Unit Circle) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Discrete Systems Problem: Evaluating the ROC and Stability of a Digital Transfer Function with Multiple Poles Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Z-Transform & ROC Stability (Oppenheim & Schafer 2010; Proakis 2007):
   - **Z-Transform & Stability Formulations:**
     $$\mathbf{X(z) = \sum_{n=-\infty}^\infty x[n] z^{-n} \quad \Big| \quad z = r e^{j\omega} \quad \Big| \quad \mathbf{\text{Causal: } |z| > r_{\text{max}}} \quad \Big| \quad \mathbf{\text{Stable: } |z| = 1 \in \text{ROC}}}$$
   - **Canonical Transform Pairs & ROC:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Time-Domain Sequence } x[n] & \textbf{Z-Transform } X(z) & \textbf{Region of Convergence (ROC)} \\
     \hline
     \mathbf{a^n u[n] \ (\text{Causal Exponential})} & \mathbf{\frac{1}{1 - a z^{-1}} = \frac{z}{z - a}} & \mathbf{|z| > |a| \ (\text{Exterior of circle of radius } |a|)} \\
     \mathbf{-a^n u[-n - 1] \ (\text{Anti-Causal})} & \mathbf{\frac{1}{1 - a z^{-1}} = \frac{z}{z - a}} & \mathbf{|z| < |a| \ (\text{Interior of circle of radius } |a|)} \\
     \mathbf{\delta[n] \ (\text{Unit Impulse})} & 1 & \text{Entire } z\text{-plane (all } z) \\
     \hline
     \end{array}$$
   - **The Algebraic Identity Invariant:** Causal $a^n u[n]$ and anti-causal $-a^n u[-n-1]$ have **identical algebraic formulas $\frac{z}{z-a}$**; they are distinguishable **ONLY by their Region of Convergence**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Z-transform ROC analysis: (1) express discrete transfer function $H(z) = N(z)/D(z)$, (2) factor denominator polynomial to find pole magnitudes $|p_1|, |p_2|, \dots, |p_m|$, (3) draw concentric circles of radii $|p_k|$ on the complex $z$-plane, (4) identify required ROC region based on causality ($|z| > \max|p|$) or stability (containing unit circle $|z|=1$), (5) check whether all poles satisfy $|p_k| < 1$ for simultaneous causality and BIBO stability!
3. **Slide 3 (`matching`):** Pair 4 concepts (Causal Sequence ROC $|z| > |a|$, Anti-Causal ROC $|z| < |a|$, Unit Circle Stability $|z|=1$, Pole-Free Annulus) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Circle (or Unit Circle). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on discrete ROC and stability: A discrete-time LTI system has transfer function $H(z) = \frac{1}{(1 - 0.5 z^{-1})(1 - 2.0 z^{-1})}$. If the system is known to be **BIBO Stable**, what is the unique Region of Convergence (ROC) of $H(z)$, and is the system causal or non-causal? (Poles are at $z = 0.5$ and $z = 2.0$; For BIBO stability, the ROC **must contain the unit circle $|z| = 1$**; The annular ring containing $|z| = 1$ bounded by the poles is $\mathbf{0.5 < |z| < 2.0}$; Because the ROC is an annular ring bounded on the outside rather than an exterior plane $|z| > 2.0$, the system is **Non-Causal (Two-Sided)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "z_transform_region_of_convergence_and_discrete_lti_stability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Z-Transform, Annular ROC \\& DT Stability (Oppenheim \\& Schafer)**\n• **Bilateral Z-Transform Formulation ($z = r e^{j\\omega}$):**\n$$\n\\mathbf{X(z) = \\mathcal{Z}\\{x[n]\\} = \\sum_{n=-\\infty}^\\infty x[n] z^{-n} = \\sum_{n=-\\infty}^\\infty \\left[ x[n] r^{-n} \\right] e^{-j\\omega n}}\n$$\n• **The 3 Canonical ROC Annular Geometries:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Sequence Character} & \\textbf{Time Domain Support} & \\textbf{z-Domain ROC Topology} \\\\\n\\hline\n\\mathbf{\\text{Right-Sided (Causal)}} & x[n] = 0 \\text{ for } n < N_1 & \\mathbf{\\text{ROC: } |z| > r_{\\text{max}} \\text{ (Exterior of outermost pole circle)}} \\\\\n\\mathbf{\\text{Left-Sided (Anti-Causal)}} & x[n] = 0 \\text{ for } n > N_2 & \\mathbf{\\text{ROC: } |z| < r_{\\text{min}} \\text{ (Interior of innermost pole circle)}} \\\\\n\\mathbf{\\text{Two-Sided}} & -\\infty < n < \\infty & \\mathbf{\\text{ROC: Annular Ring } r_1 < |z| < r_2} \\\\\n\\hline\n\\end{array}\n$$\n• **The Unit Circle Stability Invariant:** A discrete-time LTI system is BIBO stable if and only if **the ROC contains the Unit Circle ($\mathbf{|z| = 1 \\in \\text{ROC}}$)**!\n• **Causal \\& Stable Requirement:** A causal discrete LTI filter is BIBO stable if and only if **ALL transfer function poles lie strictly INSIDE the Open Unit Circle ($\\mathbf{|p_k| < 1}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the Region of Convergence (ROC) and evaluate the causality and stability of a discrete LTI system.",
      "orderItems": [
        "Express the discrete system transfer function in rational polynomial form: H(z) = N(z) / D(z)",
        "Factor the denominator polynomial D(z) to find all system pole magnitudes |p1|, |p2|, ..., |pm|",
        "Draw concentric circular boundaries at radii |p_k| on the complex z-plane",
        "Identify the valid ROC based on required system causality (|z| > max|p|) or stability (containing the unit circle |z| = 1)",
        "Verify whether all system poles lie strictly inside the Open Unit Circle (|p| < 1) for simultaneous causality and stability"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Z-Transform ROC Feature to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Causal Sequence ROC", "right": "|z| > rmax, region extending infinitely outward from the circle containing the outermost pole" },
        { "left": "Unit Circle Stability (|z| = 1)", "right": "Condition guaranteeing the Discrete-Time Fourier Transform (DTFT) converges and system is BIBO stable" },
        { "left": "Anti-Causal Sequence ROC", "right": "|z| < rmin, circular disk interior extending to the origin from the innermost pole" },
        { "left": "Two-Sided Annular Ring", "right": "r1 < |z| < r2, doughnut-shaped convergence region straddling the unit circle between poles" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For a causal and BIBO stable discrete-time LTI digital filter, all transfer function poles must lie strictly inside the unit ___.",
      "blankAnswer": "circle",
      "blankDistractors": ["axis", "plane", "strip"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A discrete-time LTI system has transfer function H(z) = 1 / [(1 - 0.5*z^-1)(1 - 2.0*z^-1)]. If the system is known to be BIBO Stable, what is the exact Region of Convergence (ROC) of H(z), and is the system causal or non-causal?",
      "options": [
        { "text": "ROC is 0.5 < |z| < 2.0 and the system is Non-Causal (Two-Sided) (For BIBO stability, the ROC must contain the unit circle |z|=1; the annular ring containing 1 between poles at 0.5 and 2.0 is 0.5 < |z| < 2.0; since the ROC is bounded on the outside, it is non-causal)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Z-transform ROC topology rules (Alan Oppenheim & Ronald Schafer *Discrete-Time Signal Processing* Chapter 3). 1. **Identify System Poles:** - Denominator: $(1 - 0.5 z^{-1})(1 - 2.0 z^{-1}) = 0$. - Poles are located at $z = 0.5$ and $z = 2.0$. 2. **Possible ROC Regions:** - Region 1 (Causal): $|z| > 2.0$ (Outside circle of radius 2.0). - Region 2 (Two-sided): $\\mathbf{0.5 < |z| < 2.0}$ (Annular ring between radii 0.5 and 2.0). - Region 3 (Anti-causal): $|z| < 0.5$ (Inside circle of radius 0.5). 3. **Apply the BIBO Stability Invariant:** - An LTI system is BIBO stable if and only if **the ROC contains the Unit Circle ($|z| = 1$)**. - Region 1 does not contain $|z| = 1$ ($1 \\ngtr 2.0$). - Region 3 does not contain $|z| = 1$ ($1 \\nless 0.5$). - **Region 2 ($0.5 < |z| < 2.0$) contains the unit circle $|z| = 1$!** 4. **Determine Causality:** - Because the ROC is an **annular ring bounded on the outside** by the pole at $|z| = 2.0$, the inverse transform contains an anti-causal left-sided component ($-2^n u[-n-1]$). - Therefore, the system is **Non-Causal**! Flawless discrete ROC stability deduction!" },
        { "text": "ROC is |z| > 2.0 and the system is Causal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "ROC is |z| < 0.5 and the system is Anti-Causal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "ROC is |z| > 0.5 and the system is Causal and Stable", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
