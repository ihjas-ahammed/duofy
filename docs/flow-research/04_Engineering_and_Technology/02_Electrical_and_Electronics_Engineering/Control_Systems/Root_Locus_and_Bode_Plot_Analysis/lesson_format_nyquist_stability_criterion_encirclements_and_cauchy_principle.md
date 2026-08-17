# Duofy Reusable Lesson Format: Nyquist Criterion (Cauchy Mapping & Encirclements)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / Root_Locus_and_Bode_Plot_Analysis`  
**Lesson Format Type:** `nyquist_stability_criterion_encirclements_and_cauchy_principle`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the complex frequency domain mapping of the standard Nyquist contour in the $s$-plane into the $G(s)H(s)$ plane, Cauchy's Argument Principle, encirclements of the critical point $(-1 + j0)$, and the exact determination of closed-loop stability for plants containing open-loop unstable poles or pure integrators (Harry Nyquist 1932; Katsuhiko Ogata *Modern Control Engineering* Chapter 8; Norman S. Nise *Control Systems Engineering* Chapter 10): formulate **Cauchy's Argument Principle**:
$$\mathbf{\Delta \angle F(s) = 2\pi (Z - P) \implies \mathbf{N = Z - P} \Longleftrightarrow \mathbf{Z = N + P}}$$
where:
1. **$Z$:** Number of zeros of $1 + G(s)H(s)$ in the Right-Half $s$-Plane ($\text{RHP}$) $\implies$ **Number of Unstable Closed-Loop Poles**;
2. **$P$:** Number of poles of $G(s)H(s)$ in the Right-Half $s$-Plane ($\text{RHP}$) $\implies$ **Number of Open-Loop Unstable Poles**;
3. **$N$:** Net number of **CLOCKWISE encirclements** of the critical point $\mathbf{(-1 + j0)}$ by the complete Nyquist plot $G(j\omega)H(j\omega)$ ($\omega \in (-\infty, +\infty)$);
derive the **Master Closed-Loop Asymptotic Stability Condition**:
$$\mathbf{\text{Closed-Loop System Asymptotically Stable} \Longleftrightarrow \mathbf{Z = 0} \Longleftrightarrow \mathbf{N = -P}}$$
(proving that for an open-loop stable plant with $P = 0$, the Nyquist plot must have **ZERO encirclements ($N = 0$)** of $(-1 + j0)$ for stability; whereas if the open-loop plant has $P = 2$ unstable poles, the Nyquist plot must encircle $(-1 + j0)$ **EXACTLY TWO TIMES COUNTER-CLOCKWISE ($N = -2$)** to achieve closed-loop stability).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nyquist Formula ($Z = N + P$), Critical Point ($-1 + j0$) & Cauchy Mapping Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Construct a Complete Nyquist Plot and Determine Stability Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Nyquist Contour Segment / Variable & Technical Mapping Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Nyquist Stability Criterion Equation Z = N + P, the Variable Z Represents the Count of Unstable Closed-Loop Poles in the ___ Half Plane (Right / RHP) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Control Stability Problem: Evaluating Closed-Loop Stability for an Open-Loop Unstable Plant with P = 1 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Nyquist Stability Criterion (Nyquist 1932; Ogata 2010):
   - **Cauchy & Nyquist Formulations:**
     $$\mathbf{Z = N + P \quad \Big| \quad \mathbf{\text{Stable: } Z = 0 \implies N = -P} \quad \Big| \quad \text{Critical Point: } -1 + j0}$$
   - **Nyquist Stability Encirclement Matrix:**
     $$\begin{array}{|c|c|l|l|}
     \hline
     \textbf{Open-Loop Poles } P & \textbf{Clockwise Encirclements } N & \textbf{Unstable Closed Poles } Z = N + P & \textbf{System Stability Result} \\
     \hline
     \mathbf{P = 0 \ (\text{Open Stable})} & \mathbf{N = 0 \ (\text{No encirclement})} & \mathbf{Z = 0 + 0 = 0} & \mathbf{\text{Strictly Stable}} \\
     P = 0 \ (\text{Open Stable}) & N = +1 \ (\text{1 Clockwise}) & Z = 1 + 0 = 1 & \text{Unstable (1 RHP Pole)} \\
     \mathbf{P = 1 \ (\text{1 Open Unstable})} & \mathbf{N = -1 \ (\text{1 Counter-Clockwise})} & \mathbf{Z = -1 + 1 = 0} & \mathbf{\text{Strictly Stable (Compensated)}} \\
     P = 2 \ (\text{2 Open Unstable}) & N = 0 \ (\text{No encirclement}) & Z = 0 + 2 = 2 & \text{Unstable (2 RHP Poles)} \\
     \hline
     \end{array}$$
   - **The Critical Point Invariant:** The point $\mathbf{-1 + j0}$ represents the threshold where loop gain $|GH| = 1$ and phase $\angle GH = -180^\circ$, which turns negative feedback into destructive positive regeneration!
2. **Slide 2 (`ordering`):** Provide 5 steps of Nyquist stability analysis: (1) inspect open-loop transfer function $G(s)H(s)$ and count number of RHP poles $P$, (2) substitute $s = j\omega$ and trace Nyquist locus from $\omega = 0^+$ to $\omega = +\infty$, (3) complete polar plot by reflecting along real axis for negative frequencies $\omega: -\infty \to 0^-$, (4) complete origin indentations ($s = \epsilon e^{j\theta}$) if plant contains integrators $1/s$, (5) count net clockwise encirclements $N$ of $(-1 + j0)$ and compute $Z = N + P$ (system is stable if and only if $Z = 0$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Critical Point $-1+j0$, Clockwise Encirclement $N>0$, Counter-Clockwise Encirclement $N<0$, Open-Loop RHP Poles $P$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Right (or RHP). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Nyquist criterion with open-loop unstable pole: An open-loop plant has transfer function $G(s)H(s) = \frac{10}{s - 1}$, which has $P = 1$ unstable pole in the right-half plane ($s = +1$). The complete Nyquist plot of $G(s)H(s)$ encircles the critical point $(-1 + j0)$ **exactly once in the counter-clockwise direction ($N = -1$)**. Is the closed-loop feedback system stable, and how many unstable closed-loop poles exist? ($P = 1$; Counter-clockwise encirclement means $N = -1$; Apply Nyquist formula: $Z = N + P = -1 + 1 = \mathbf{0}$; Since $Z = 0$, there are **zero unstable closed-loop poles**, and the closed-loop system is **strictly stable**!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nyquist_stability_criterion_encirclements_and_cauchy_principle",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Nyquist Stability Criterion (Harry Nyquist 1932)**\n• **Cauchy's Argument Principle Formula:**\n$$\n\\mathbf{Z = N + P}\n$$\n  - **$Z$:** Number of unstable closed-loop poles in the Right-Half $s$-Plane (RHP);\n  - **$P$:** Number of open-loop unstable poles of $G(s)H(s)$ in the RHP;\n  - **$N$:** Number of **CLOCKWISE encirclements** of the critical point $\\mathbf{(-1 + j0)}$ by the complete Nyquist plot $(\\omega \\in [-\\infty, +\\infty])$;\n• **Closed-Loop Stability Criterion:**\n$$\n\\mathbf{\\text{Asymptotically Stable} \\Longleftrightarrow \\mathbf{Z = 0} \\Longleftrightarrow \\mathbf{N = -P}}\n$$\n• **The Open-Loop Unstable Stabilization Invariant:** If an open-loop plant is unstable with $P$ poles in the RHP, the closed-loop system can be made stable **if and only if the Nyquist plot encircles $(-1 + j0)$ exactly $P$ times in the COUNTER-CLOCKWISE direction ($N = -P$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine closed-loop stability using the Nyquist Stability Criterion.",
      "orderItems": [
        "Inspect the open-loop transfer function G(s)H(s) and count the number of unstable RHP open-loop poles P",
        "Substitute s = j*\u03c9 and sketch the frequency locus G(j\u03c9)H(j\u03c9) as \u03c9 increases from 0+ to +\u221e",
        "Plot the complex conjugate reflection of the locus corresponding to negative frequencies \u03c9 from -\u221e to 0-",
        "Add semicircular arcs of infinite radius if the open-loop transfer function contains poles at the origin (integrators)",
        "Count the net clockwise encirclements N of the critical point (-1 + j0) and evaluate Z = N + P to verify Z = 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Nyquist Analysis Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Critical Point (-1 + j0)", "right": "Threshold singularity where loop gain is unity and phase lag is 180\u00b0, causing infinite closed-loop response" },
        { "left": "Counter-Clockwise Encirclement (N = -1)", "right": "Negative encirclement required to stabilize one open-loop right-half plane pole" },
        { "left": "Open-Loop Unstable Poles (P)", "right": "Count of open-loop plant poles located in the right-half s-plane with positive real parts" },
        { "left": "Closed-Loop Unstable Poles (Z)", "right": "Z = N + P, total number of closed-loop poles in RHP (must equal zero for stability)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Nyquist stability equation Z = N + P, the variable Z represents the count of unstable closed-loop poles in the ___ half plane.",
      "blankAnswer": "right",
      "blankDistractors": ["left", "upper", "lower"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An open-loop magnetic levitation plant has transfer function G(s)H(s) = 10 / (s - 1), which has P = 1 open-loop unstable pole in the right-half plane. The complete Nyquist plot of G(s)H(s) encircles the critical point (-1 + j0) exactly once in the counter-clockwise direction (N = -1). Is the closed-loop system stable?",
      "options": [
        { "text": "Yes, strictly stable with Z = 0 (By Nyquist's formula Z = N + P = -1 + 1 = 0; since Z = 0, there are zero unstable closed-loop poles in the RHP, so feedback has stabilized the open-loop unstable plant)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Nyquist Stability Criterion (Katsuhiko Ogata *Modern Control Engineering* Chapter 8). 1. **Identify Open-Loop Parameters:** - Open-loop pole: $s = +1$. - Since $\\text{Re}(s) = +1 > 0$, this is in the Right-Half Plane (RHP). - **Number of open-loop RHP poles = $P = 1$**. 2. **Analyze Critical Point Encirclements ($N$):** - The Nyquist plot encircles $(-1 + j0)$ **once in the counter-clockwise direction**. - By Nyquist convention, clockwise is positive ($+$) and counter-clockwise is negative ($-$). - **Encirclement count = $N = -1$**. 3. **Calculate Closed-Loop Unstable Poles ($Z$):** $$Z = N + P = (-1) + (1) = \\mathbf{0}$$ 4. **Stability Conclusion:** - Because $Z = 0$, there are **zero closed-loop poles in the right-half plane**. - The negative feedback loop has successfully **pulled the unstable open-loop pole across the imaginary axis into the stable left-half plane**, achieving full closed-loop asymptotic stability!" },
        { "text": "No, unstable with Z = 2 RHP poles", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "No, unstable with Z = 1 RHP pole", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Cannot be determined without knowing the sample rate", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
