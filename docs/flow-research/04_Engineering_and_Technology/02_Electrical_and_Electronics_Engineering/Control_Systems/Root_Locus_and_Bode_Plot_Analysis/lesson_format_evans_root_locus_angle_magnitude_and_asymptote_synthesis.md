# Duofy Reusable Lesson Format: Root Locus (Evans Method, Asymptotes, & Breakaway Points)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / Root_Locus_and_Bode_Plot_Analysis`  
**Lesson Format Type:** `evans_root_locus_angle_magnitude_and_asymptote_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the graphical tracking of closed-loop pole migrations in the complex $s$-plane as controller gain $K$ varies continuously from $0$ to $+\infty$, the fundamental Evans angle and magnitude criteria, real-axis locus existence rules, asymptote geometry ($\sigma_a, \theta_a$), and breakaway point calculus in classical control design (Walter R. Evans 1948; Katsuhiko Ogata *Modern Control Engineering* Chapter 6; Norman S. Nise *Control Systems Engineering* Chapter 8): formulate the **Two Master Evans Root Locus Criteria ($1 + K G(s)H(s) = 0$)**:
1. **The Angle Criterion (Defines the Root Locus Trajectory Paths):**
   $$\mathbf{\angle G(s)H(s) = \sum_{j=1}^m \angle(s + z_j) - \sum_{i=1}^n \angle(s + p_i) = \pm (2k + 1) 180^\circ \quad (k = 0, 1, 2, \dots)}$$
2. **The Magnitude Criterion (Determines the Exact Gain $K$ at Any Point on the Locus):**
   $$\mathbf{K = \frac{1}{|G(s)H(s)|} = \frac{\prod_{i=1}^n |s + p_i|}{\prod_{j=1}^m |s + z_j|}}$$
master the **Evans Construction Rules**:
- **Real-Axis Locus Rule:** A point on the real axis belongs to the root locus if and only if **the total number of real poles and real zeros to its right is ODD**;
- **Asymptote Centroid ($\sigma_a$) & Angles ($\theta_a$) ($n$ poles, $m$ zeros):**
  $$\mathbf{\sigma_a = \frac{\sum_{i=1}^n p_i - \sum_{j=1}^m z_j}{n - m} \quad \Big| \quad \mathbf{\theta_a = \frac{\pm (2k + 1) 180^\circ}{n - m} \quad (k = 0, 1, \dots, n-m-1)}}$$
- **Breakaway / Break-in Points:** Solved by taking the derivative of gain with respect to $s$: $\mathbf{\frac{dK}{ds} = 0 \Longleftrightarrow \sum_{i=1}^n \frac{1}{s + p_i} = \sum_{j=1}^m \frac{1}{s + z_j}}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Angle Criterion ($\angle GH = \pm 180^\circ$), Magnitude ($K = \frac{\prod |s+p_i|}{\prod |s+z_j|}$) & Asymptote Centroid Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Construct a Complete Root Locus Sketch Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Root Locus Geometric Entity / Construction Rule & Technical Analytical Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Point on the Real Axis Lies on the Root Locus If the Total Count of Open-Loop Poles and Zeros to Its Right Is ___ (Odd) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Control System Problem: Calculating Asymptote Centroid \sigma_a, Angles \theta_a, and Breakaway Point \sigma_b Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Evans Root Locus Method (Ogata 2010; Evans 1948):
   - **Angle, Magnitude & Asymptote Formulations:**
     $$\mathbf{\angle GH = \pm (2k+1)180^\circ \quad \Big| \quad K = \frac{\prod |s+p_i|}{\prod |s+z_j|} \quad \Big| \quad \sigma_a = \frac{\sum p_i - \sum z_j}{n - m} \quad \Big| \quad \theta_a = \frac{\pm(2k+1)180^\circ}{n-m}}$$
   - **Root Locus Construction Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Locus Feature} & \textbf{Mathematical Equation} & \textbf{Physical Meaning} \\
     \hline
     \mathbf{\text{Real-Axis Segment}} & \text{Sum of poles + zeros to right is ODD} & \text{Poles moving directly along real axis} \\
     \mathbf{\text{Asymptote Centroid } \sigma_a} & \sigma_a = (\sum p_i - \sum z_j) / (n - m) & \text{Intersection point of radiating asymptotes} \\
     \mathbf{\text{Asymptote Angles } \theta_a} & \theta_a = \pm (2k + 1) 180^\circ / (n - m) & \text{Direction trajectories heading to infinity} \\
     \mathbf{\text{Breakaway Point } \sigma_b} & dK/ds = 0 & \text{Point where real roots collide and turn complex} \\
     \hline
     \end{array}$$
   - **The Origin & Termination Invariant:** Root locus branches **originate at open-loop poles ($K = 0$)** and **terminate at open-loop zeros or infinity ($K = \infty$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Root Locus construction: (1) plot open-loop poles (X) and zeros (O) on the complex $s$-plane, (2) identify real-axis locus segments located to the left of an odd number of real poles/zeros, (3) calculate asymptote centroid $\sigma_a = \frac{\sum p - \sum z}{n - m}$ and asymptote angles $\theta_a = \frac{\pm 180^\circ(2k+1)}{n-m}$, (4) solve $\frac{dK}{ds} = 0$ to find real-axis breakaway/break-in coordinates, (5) sketch branches originating from poles at $K=0$ and traveling toward zeros/infinity as $K \to \infty$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Angle Criterion, Magnitude Formula, Asymptote Centroid $\sigma_a$, Breakaway Point $dK/ds = 0$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Odd. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Root Locus parameters: A feedback control system has open-loop transfer function $G(s)H(s) = \frac{K}{s (s + 2) (s + 4)}$ (with $n = 3$ poles at $s = 0, -2, -4$ and $m = 0$ zeros). What is the asymptote centroid $\sigma_a$, the asymptote angles $\theta_a$, and the valid breakaway coordinate $\sigma_b$ on the real axis? ($\sigma_a = \frac{\sum p_i - \sum z_j}{n - m} = \frac{0 + (-2) + (-4) - 0}{3 - 0} = \frac{-6}{3} = \mathbf{-2.0}$; Asymptote angles: $\theta_a = \frac{\pm 180^\circ(2k+1)}{3} = \mathbf{\pm 60^\circ, 180^\circ}$; Breakaway: $K = -s(s+2)(s+4) = -(s^3 + 6s^2 + 8s)$; $\frac{dK}{ds} = -(3s^2 + 12s + 8) = 0 \implies 3s^2 + 12s + 8 = 0$; $s = \frac{-12 \pm \sqrt{144 - 4(3)(8)}}{6} = \frac{-12 \pm \sqrt{48}}{6} = \frac{-12 \pm 6.928}{6} = \mathbf{-0.845\text{ and } -3.155}$; Since the real-axis locus exists only between $0$ and $-2$, the only valid physical breakaway point is $\sigma_b = \mathbf{-0.845}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "evans_root_locus_angle_magnitude_and_asymptote_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Evans Root Locus Method (Walter R. Evans 1948)**\n• **The 2 Master Governing Root Locus Criteria:**\n$$\n\\mathbf{\\angle G(s)H(s) = \\sum_{j=1}^m \\angle(s + z_j) - \\sum_{i=1}^n \\angle(s + p_i) = \\pm (2k + 1) 180^\\circ \\quad (\\text{Angle Criterion})}\n$$\n$$\n\\mathbf{K = \\frac{1}{|G(s)H(s)|} = \\frac{\\prod_{i=1}^n |s + p_i|}{\\prod_{j=1}^m |s + z_j|} \\quad (\\text{Magnitude Criterion})}\n$$\n• **Asymptote Geometry ($n$ poles, $m$ zeros):**\n$$\n\\mathbf{\\sigma_a = \\frac{\\sum_{i=1}^n p_i - \\sum_{j=1}^m z_j}{n - m} \\quad \\Big| \\quad \\mathbf{\\theta_a = \\frac{\\pm (2k + 1) 180^\\circ}{n - m} \\quad (k = 0, 1, \\dots, n - m - 1)}}\n$$\n• **Breakaway / Break-in Point Calculus:**\n$$\n\\mathbf{\\frac{dK}{ds} = 0 \\Longleftrightarrow \\sum_{i=1}^n \\frac{1}{s + p_i} = \\sum_{j=1}^m \\frac{1}{s + z_j}}\n$$\n• **The Real-Axis Locus Invariant:** A point on the real axis belongs to the root locus if and only if **the total number of real poles and real zeros to its right is strictly ODD**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct and sketch the Evans Root Locus of an open-loop plant G(s)H(s).",
      "orderItems": [
        "Locate and plot all open-loop poles (X) and open-loop zeros (O) on the complex s-plane",
        "Identify the valid real-axis locus segments residing to the left of an odd number of real poles and zeros",
        "Calculate the real-axis asymptote centroid: \u03c3a = (\u2211 poles - \u2211 zeros) / (n - m) and asymptote angles \u03b8a",
        "Differentiate the characteristic gain equation dK/ds = 0 to solve for valid real-axis breakaway coordinates",
        "Sketch continuous locus branches starting at poles for K=0 and heading to zeros or along asymptotes to infinity for K \u2192 \u221e"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Root Locus Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Angle Criterion", "right": "\u2220GH = \u00b1180\u00b0*(2k+1), phase condition determining whether a test point s lies on the root locus path" },
        { "left": "Magnitude Criterion", "right": "K = \u220f|s+pi| / \u220f|s+zj|, formula computing the exact gain K required to place closed-loop poles at s" },
        { "left": "Asymptote Centroid (\u03c3a)", "right": "\u03c3a = (\u2211p - \u2211z) / (n - m), center of gravity on the real axis where radiating asymptote lines converge" },
        { "left": "Breakaway Point (\u03c3b)", "right": "dK/ds = 0, point where two real roots collide and depart into the complex plane as conjugate pairs" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A point on the real axis lies on the root locus if the total count of open-loop poles and zeros to its right is ___.",
      "blankAnswer": "odd",
      "blankDistractors": ["even", "zero", "infinite"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A control system has open-loop transfer function G(s)H(s) = K / [s(s + 2)(s + 4)] (n = 3 poles at 0, -2, -4; m = 0 zeros). What is the asymptote centroid \u03c3a, the asymptote angles \u03b8a, and the valid real-axis breakaway point \u03c3b?",
      "options": [
        { "text": "\u03c3a = -2.0, \u03b8a = \u00b160\u00b0, 180\u00b0, and \u03c3b = -0.845 (\u03c3a = (0 - 2 - 4)/3 = -2.0; \u03b8a = \u00b1180\u00b0/3 = \u00b160\u00b0, 180\u00b0; dK/ds = -(3s^2 + 12s + 8) = 0 \u2192 roots are -0.845 and -3.155; -0.845 lies on the valid locus [0, -2])", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Evans Root Locus rules (Katsuhiko Ogata *Modern Control Engineering* Chapter 6). 1. **Identify Poles and Zeros:** - Poles: $p_1 = 0, p_2 = -2, p_3 = -4$ ($n = 3$). - Zeros: None ($m = 0$). - Number of asymptotes: $n - m = 3 - 0 = 3$. 2. **Calculate Asymptote Centroid ($\\sigma_a$):** $$\\sigma_a = \\frac{\\sum p_i - \\sum z_j}{n - m} = \\frac{0 + (-2) + (-4) - 0}{3} = \\frac{-6}{3} = \\mathbf{-2.00}$$ 3. **Calculate Asymptote Angles ($\\theta_a$):** $$\\theta_a = \\frac{\\pm (2k + 1) 180^\\circ}{3} = \\mathbf{\\pm 60^\\circ, \\quad 180^\\circ}$$ 4. **Calculate Breakaway Points ($\\frac{dK}{ds} = 0$):** - Characteristic equation: $s(s + 2)(s + 4) + K = 0 \\implies K = -(s^3 + 6 s^2 + 8 s)$. - Differentiate: $$\\frac{dK}{ds} = -(3 s^2 + 12 s + 8) = 0 \\implies 3 s^2 + 12 s + 8 = 0$$ - Using quadratic formula: $$s = \\frac{-12 \\pm \\sqrt{144 - 4(3)(8)}}{6} = \\frac{-12 \\pm \\sqrt{48}}{6} = \\frac{-12 \\pm 6.9282}{6} \\implies s_1 = \\mathbf{-0.845}, \\quad s_2 = -3.155$$ 5. **Check Valid Real-Axis Locus Segments:** - Real-axis locus exists on: $[0, -2]$ and $[-4, -\\infty)$. - $s_1 = -0.845$ lies on the valid segment $[0, -2]$ $\\implies \\mathbf{\\sigma_b = -0.845}$. - $s_2 = -3.155$ lies on non-locus segment $[-2, -4]$ (invalid!)." },
        { "text": "\u03c3a = -3.0, \u03b8a = \u00b190\u00b0, and \u03c3b = -1.000", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c3a = -2.0, \u03b8a = \u00b145\u00b0, \u00b1135\u00b0, and \u03c3b = -3.155 (Invalid segment)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c3a = -1.5, \u03b8a = \u00b160\u00b0, 180\u00b0, and \u03c3b = -0.845", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
