# Duofy Reusable Lesson Format: Laplace Transform (ROC Topology & LTI System Stability)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Fourier_Series_Transforms_and_Laplace`  
**Lesson Format Type:** `laplace_transform_region_of_convergence_and_lti_stability`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the bilateral Laplace transform, complex frequency variable $s = \sigma + j\omega$, Region of Convergence (ROC) geometric properties, pole-zero distributions, and system stability/causality criteria in continuous-time linear systems theory (Pierre-Simon Laplace 1785; Alan V. Oppenheim & Alan S. Willsky *Signals and Systems* Chapter 9; B.P. Lathi *Linear Systems and Signals* Chapter 6): define the **Bilateral Laplace Transform**:
$$\mathbf{X(s) = \mathcal{L}\{x(t)\} = \int_{-\infty}^\infty x(t) e^{-st} \, dt = \int_{-\infty}^\infty \left[ x(t) e^{-\sigma t} \right] e^{-j\omega t} \, dt \quad (s = \sigma + j\omega)}$$
master the **Six Fundamental ROC Topology Invariants**:
1. The ROC consists of vertical strips parallel to the $j\omega$-axis in the complex $s$-plane;
2. The ROC contains **strictly ZERO poles**;
3. For a **Finite-Duration Signal**, the ROC is the **entire $s$-plane**;
4. For a **Right-Sided (Causal) Signal**, the ROC is the half-plane **to the right of the rightmost pole ($\mathbf{\text{Re}(s) > \sigma_{\text{max}}}$)**;
5. For a **Left-Sided (Anti-Causal) Signal**, the ROC is the half-plane **to the left of the leftmost pole ($\mathbf{\text{Re}(s) < \sigma_{\text{min}}}$)**;
6. **LTI BIBO Stability Invariant:** An LTI system is BIBO stable if and only if **the ROC includes the imaginary $j\omega$-axis ($\mathbf{\sigma = 0 \in \text{ROC}}$)**;
and prove that a **Causal LTI System is BIBO Stable if and only if ALL of its transfer function poles lie strictly in the Open Left-Half Plane ($\mathbf{\text{Re}(p_k) < 0}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bilateral Laplace ($X(s) = \int x e^{-st} dt$), ROC Strip Topology & Stability ($j\omega \in \text{ROC}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Determine ROC and Evaluate Causality and Stability from Poles Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | ROC Topology / Pole Location & System Property (Causal / Stable / Anti-Causal) Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | For a Causal and BIBO Stable Continuous-Time LTI System, All Transfer Function Poles Must Lie Strictly in the Left-Half ___ (Plane / LHP) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Continuous-Time Systems Problem: Evaluating the ROC and Stability of a Transfer Function with Multiple Poles Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Laplace Transform & ROC Stability (Oppenheim & Willsky 1997; Lathi 2017):
   - **Laplace Transform & ROC Formulations:**
     $$\mathbf{X(s) = \int_{-\infty}^\infty x(t) e^{-st} dt \quad \Big| \quad s = \sigma + j\omega \quad \Big| \quad \mathbf{\text{Causal: } \text{Re}(s) > \sigma_{\text{max}}} \quad \Big| \quad \mathbf{\text{Stable: } j\omega \in \text{ROC}}}$$
   - **ROC Topology Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Signal Geometry} & \textbf{Time Domain Support} & \textbf{s-Domain ROC Shape} & \textbf{BIBO Stability Criterion} \\
     \hline
     \mathbf{\text{Right-Sided (Causal)}} & x(t) = 0 \text{ for } t < T_1 & \mathbf{\text{Re}(s) > \sigma_{\text{max}}} & \mathbf{\text{All poles in Open LHP } (\text{Re}(p) < 0)} \\
     \mathbf{\text{Left-Sided (Anti-Causal)}} & x(t) = 0 \text{ for } t > T_2 & \mathbf{\text{Re}(s) < \sigma_{\text{min}}} & \text{All poles in Open RHP } (\text{Re}(p) > 0) \\
     \mathbf{\text{Two-Sided}} & -\infty < t < \infty & \mathbf{\sigma_1 < \text{Re}(s) < \sigma_2} & \text{ROC strip straddles } j\omega\text{-axis} \\
     \hline
     \end{array}$$
   - **The Pole-Free Invariant:** The Region of Convergence can **NEVER contain any poles** ($\lim_{s\to p_k} X(s) = \infty$, violating convergence)!
2. **Slide 2 (`ordering`):** Provide 5 steps of Laplace ROC evaluation: (1) express transfer function $H(s) = N(s)/D(s)$, (2) factor denominator polynomial $D(s)$ to find all system pole locations $p_1, p_2, \dots, p_n$, (3) plot poles on the complex $s$-plane, (4) identify whether the system is specified as causal (ROC right of rightmost pole) or stable (ROC containing $j\omega$-axis), (5) evaluate whether all poles have negative real parts ($\text{Re}(p_k) < 0$) to confirm both causality and BIBO stability!
3. **Slide 3 (`matching`):** Pair 4 concepts (Causal ROC $\text{Re}(s) > \sigma_{\text{max}}$, Anti-Causal ROC $\text{Re}(s) < \sigma_{\text{min}}$, BIBO Stability $j\omega \in \text{ROC}$, Pole-Free ROC) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Plane (or LHP). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on ROC and stability: An LTI system has transfer function $H(s) = \frac{s + 3}{(s + 1)(s - 2)}$. If the system is known to be **BIBO Stable**, what is the unique Region of Convergence (ROC) of $H(s)$, and is the system causal or non-causal? (Poles are at $s = -1$ and $s = +2$; For the system to be BIBO stable, its ROC **must contain the imaginary $j\omega$-axis ($\text{Re}(s) = 0$)**; The strip containing $\text{Re}(s) = 0$ bounded by the poles is $\mathbf{-1 < \text{Re}(s) < 2}$; Because the ROC is a strip bounded on both sides rather than a right-half plane, the system is **Non-Causal (Two-Sided)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "laplace_transform_region_of_convergence_and_lti_stability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bilateral Laplace Transform \\& ROC Stability (Oppenheim \\& Willsky)**\n• **Bilateral Laplace Transform Formulation ($s = \\sigma + j\\omega$):**\n$$\n\\mathbf{X(s) = \\mathcal{L}\\{x(t)\\} = \\int_{-\\infty}^\\infty x(t) e^{-st} \\, dt = \\mathcal{F}\\left\\{ x(t) e^{-\\sigma t} \\right\\}}\n$$\n• **The 3 Fundamental ROC Geometric Topologies:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Signal Character} & \\textbf{Time Support} & \\textbf{s-Domain ROC Topology} \\\\\n\\hline\n\\mathbf{\\text{Right-Sided (Causal)}} & x(t) = 0 \\text{ for } t < T_1 & \\mathbf{\\text{ROC: } \\text{Re}(s) > \\sigma_{\\text{max}} \\text{ (Right of rightmost pole)}} \\\\\n\\mathbf{\\text{Left-Sided (Anti-Causal)}} & x(t) = 0 \\text{ for } t > T_2 & \\mathbf{\\text{ROC: } \\text{Re}(s) < \\sigma_{\\text{min}} \\text{ (Left of leftmost pole)}} \\\\\n\\mathbf{\\text{Two-Sided}} & -\\infty < t < \\infty & \\mathbf{\\text{ROC: Strip } \\sigma_1 < \\text{Re}(s) < \\sigma_2} \\\\\n\\hline\n\\end{array}\n$$\n• **The BIBO Stability Invariant:** An LTI system is BIBO stable if and only if **the ROC contains the imaginary $j\\omega$-axis ($\mathbf{\\sigma = 0 \\in \\text{ROC}}$)**!\n• **Causal \\& Stable Requirement:** A causal LTI system is BIBO stable if and only if **ALL transfer function poles lie strictly in the Open Left-Half Plane ($\\mathbf{\\text{Re}(p_k) < 0}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the Region of Convergence (ROC) and evaluate the causality and stability of an LTI system.",
      "orderItems": [
        "Express the continuous system transfer function as a rational fraction: H(s) = N(s) / D(s)",
        "Factor the denominator polynomial D(s) to locate all system poles on the complex s-plane",
        "Draw vertical pole boundary lines dividing the s-plane into parallel convergence strips",
        "Identify the required ROC based on system causality (right-half plane) or stability (containing the imaginary j*omega axis)",
        "Verify whether all system poles lie strictly in the Open Left-Half Plane (Re(p) < 0) for simultaneous causality and stability"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Laplace ROC Property to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Causal System ROC", "right": "Re(s) > \u03c3max, region lying strictly to the right of the rightmost system transfer function pole" },
        { "left": "BIBO Stability Condition", "right": "ROC containing the imaginary j\u03c9-axis (\u03c3 = 0), ensuring the Fourier transform converges" },
        { "left": "Pole-Free Invariant", "right": "The Region of Convergence can never contain any poles where X(s) evaluates to infinity" },
        { "left": "Anti-Causal System ROC", "right": "Re(s) < \u03c3min, region extending infinitely to the left of the leftmost pole" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For a causal and BIBO stable continuous-time LTI system, all transfer function poles must lie strictly in the Left-Half ___.",
      "blankAnswer": "plane",
      "blankDistractors": ["axis", "circle", "strip"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An LTI system has transfer function H(s) = (s + 3) / [(s + 1)(s - 2)]. If the system is known to be BIBO Stable, what is the exact Region of Convergence (ROC) of H(s), and is the system causal or non-causal?",
      "options": [
        { "text": "ROC is -1 < Re(s) < 2 and the system is Non-Causal (Two-sided) (For BIBO stability, the ROC must contain the j\u03c9-axis Re(s)=0; the strip containing 0 between poles at -1 and +2 is -1 < Re(s) < 2; since the ROC is a vertical strip, it is non-causal)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Laplace ROC topology rules (Alan Oppenheim & Alan Willsky *Signals and Systems* Chapter 9). 1. **Identify System Poles:** - Denominator: $D(s) = (s + 1)(s - 2) = 0$. - Poles are located at $s = -1$ and $s = +2$. 2. **Possible ROC Regions:** - Region 1 (Causal): $\\text{Re}(s) > 2$ (Right of rightmost pole). - Region 2 (Two-sided): $\\mathbf{-1 < \\text{Re}(s) < 2}$ (Strip between poles). - Region 3 (Anti-causal): $\\text{Re}(s) < -1$ (Left of leftmost pole). 3. **Apply the BIBO Stability Invariant:** - An LTI system is BIBO stable if and only if **the ROC contains the imaginary axis ($\text{Re}(s) = 0$)**. - Region 1 does not contain $\\text{Re}(s) = 0$ ($0 \\ngtr 2$). - Region 3 does not contain $\\text{Re}(s) = 0$ ($0 \\nless -1$). - **Region 2 ($-1 < \\text{Re}(s) < 2$) contains $\\text{Re}(s) = 0$!** 4. **Determine Causality:** - Because the ROC is a **strip bounded on both sides** rather than a right-half plane, the impulse response $h(t)$ is two-sided ($h(t) \\ne 0$ for $t < 0$). - Therefore, the system is **Non-Causal**! Flawless Laplace ROC stability deduction!" },
        { "text": "ROC is Re(s) > 2 and the system is Causal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "ROC is Re(s) < -1 and the system is Anti-Causal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "ROC is Re(s) > -1 and the system is Causal and Stable", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
