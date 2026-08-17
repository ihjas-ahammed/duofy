# Duofy Reusable Lesson Format: System Stability (Routh-Hurwitz Array & Gain Bounds)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / Transfer_Functions_and_Block_Diagrams`  
**Lesson Format Type:** `routh_hurwitz_stability_criterion_and_parametric_k_range`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algebraic determination of linear system stability, the Routh-Hurwitz stability criterion, characteristic polynomial testing, Routh array construction, row-of-zeros auxiliary polynomial handling, and solving for the permissible controller gain range ($K_{\text{min}} < K < K_{\text{max}}$) for stable closed-loop operation (Edward John Routh 1877; Adolf Hurwitz 1895; Katsuhiko Ogata *Modern Control Engineering* Chapter 5; Norman S. Nise *Control Systems Engineering* Chapter 6): formulate the **Routh-Hurwitz Stability Theorem**:
$$\mathbf{q(s) = a_n s^n + a_{n-1} s^{n-1} + \dots + a_1 s + a_0 = 0}$$
- **Necessary Condition for Stability:** All coefficients $a_n, a_{n-1}, \dots, a_0$ must exist and be strictly of the same algebraic sign ($a_i > 0$);
- **Sufficient Condition for Stability:** Construct the Routh array:
  $$\begin{array}{l|lll}
  s^n & a_n & a_{n-2} & a_{n-4} \\
  s^{n-1} & a_{n-1} & a_{n-3} & a_{n-5} \\
  s^{n-2} & b_1 = \frac{a_{n-1} a_{n-2} - a_n a_{n-3}}{a_{n-1}} & b_2 = \frac{a_{n-1} a_{n-4} - a_n a_{n-5}}{a_{n-1}} & \dots \\
  s^{n-3} & c_1 = \frac{b_1 a_{n-3} - a_{n-1} b_2}{b_1} & \dots & \dots \\
  \end{array}$$
- **The First-Column Sign Change Invariant:**
  $$\mathbf{\text{Number of Roots in the Open Right-Half } s\text{-Plane (Unstable Poles)} = \mathbf{\text{Number of Sign Changes in the FIRST COLUMN}}}$$
  (proving that a closed-loop system is strictly stable if and only if **every single term in the first column is strictly positive**).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Routh Array ($b_1 = \frac{a_{n-1}a_{n-2}-a_n a_{n-3}}{a_{n-1}}$), First-Column Sign Changes & Stability Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Construct a Routh Array and Find the Permissible Gain Range K Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Routh-Hurwitz Feature / Special Array Condition & Technical Mathematical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Number of Roots of a Characteristic Equation Lying in the Unstable Right-Half Plane Equals the Number of Sign Changes in the ___ Column of the Routh Array (First / 1st) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Control Stability Problem: Determining the Stable Range of Gain K and Marginal Oscillation Frequency \omega_osc Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Routh-Hurwitz Stability Criterion (Ogata 2010; Routh 1877):
   - **Characteristic Equation & Array Formulations:**
     $$\mathbf{q(s) = a_n s^n + a_{n-1} s^{n-1} + \dots + a_0 = 0 \quad \Big| \quad b_1 = \frac{a_{n-1} a_{n-2} - a_n a_{n-3}}{a_{n-1}} \quad \Big| \quad c_1 = \frac{b_1 a_{n-3} - a_{n-1} b_2}{b_1}}$$
   - **Routh Stability Invariant Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{First Column Pattern} & \textbf{Complex Pole Distribution} & \textbf{System Stability State} \\
     \hline
     \mathbf{\text{All Positive (> 0)}} & \mathbf{\text{All roots strictly in Open LHP } (\text{Re}(p) < 0)} & \mathbf{\text{Strictly Asymptotically Stable}} \\
     \mathbf{k \text{ Sign Changes}} & k \text{ roots in Open RHP } (\text{Re}(p) > 0) & \mathbf{\text{Unstable (Exponential Blowup)}} \\
     \mathbf{\text{Entire Row of Zeros}} & \text{Roots symmetrically located on } \pm j\omega\text{-axis} & \text{Marginally Stable / Sustained Oscillation} \\
     \hline
     \end{array}$$
   - **The Necessary Condition Invariant:** If any coefficient $a_k \le 0$ (missing or negative), the system has **at least one root with $\text{Re}(s) \ge 0$ (unstable or marginally stable)**!
2. **Slide 2 (`ordering`):** Provide 5 steps to find the stable gain range $K$: (1) derive the closed-loop characteristic polynomial $1 + G(s)H(s) = 0$ in terms of gain $K$, (2) verify that all polynomial coefficients are positive for positive $K$, (3) construct the Routh array with elements parameterized by $K$, (4) set every expression in the first column to be strictly greater than zero ($> 0$), (5) solve the resulting simultaneous algebraic inequalities to find the bounded range $K_{\text{min}} < K < K_{\text{max}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (First Column Sign Change, Entire Row of Zeros, Necessary Condition $a_i>0$, Auxiliary Polynomial $A(s)$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of First (or 1st). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on finding stable gain range $K$: A unity feedback control system has open-loop transfer function $G(s) = \frac{K}{s (s + 2) (s + 4)}$. The closed-loop characteristic equation is $s^3 + 6 s^2 + 8 s + K = 0$. For what range of gain $K$ is the closed-loop system stable, and what is the frequency of sustained oscillation $\omega_{\text{osc}}$ at the critical marginal stability boundary $K_{\text{crit}}$? (Routh array: $s^3: 1, 8$; $s^2: 6, K$; $s^1: b_1 = \frac{6(8) - 1(K)}{6} = \frac{48 - K}{6}$; $s^0: K$; For stability: $b_1 > 0 \implies 48 - K > 0 \implies K < 48$; $s^0 > 0 \implies K > 0$; Range for stability: $\mathbf{0 < K < 48}$; At $K_{\text{crit}} = 48$, the $s^1$ row becomes zero, auxiliary equation is $6 s^2 + 48 = 0 \implies s^2 + 8 = 0 \implies s = \pm j\sqrt{8} \approx \pm j 2.83\text{ rad/s} \implies \mathbf{\omega_{\text{osc}} = \sqrt{8} \approx 2.83\text{ rad/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "routh_hurwitz_stability_criterion_and_parametric_k_range",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Routh-Hurwitz Stability Criterion (Edward Routh 1877)**\n• **Characteristic Polynomial \\& Routh Array Formulation:**\n$$\n\\mathbf{q(s) = a_n s^n + a_{n-1} s^{n-1} + a_{n-2} s^{n-2} + \\dots + a_0 = 0}\n$$\n$$\n\\begin{array}{l|lll}\n\\hline\ns^n & a_n & a_{n-2} & a_{n-4} \\\\\ns^{n-1} & a_{n-1} & a_{n-3} & a_{n-5} \\\\\ns^{n-2} & b_1 = \\frac{a_{n-1} a_{n-2} - a_n a_{n-3}}{a_{n-1}} & b_2 = \\frac{a_{n-1} a_{n-4} - a_n a_{n-5}}{a_{n-1}} & \\dots \\\\\ns^{n-3} & c_1 = \\frac{b_1 a_{n-3} - a_{n-1} b_2}{b_1} & \\dots & \\dots \\\\\n\\hline\n\\end{array}\n$$\n• **The First Column Sign Change Invariant:**\n$$\n\\mathbf{\\text{Number of Unstable RHP Poles} = \\text{Number of Sign Changes in the FIRST COLUMN}}\n$$\n• **Asymptotic Stability Condition:** A closed-loop system is strictly stable if and only if **all coefficients $a_i > 0$ and ALL entries in the first column are strictly positive (> 0)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct a Routh array and determine the stable range of controller gain K.",
      "orderItems": [
        "Formulate the closed-loop characteristic equation: 1 + G(s)*H(s) = 0 in standard polynomial form",
        "Verify that all polynomial coefficients are positive for positive values of controller gain K",
        "Construct the rows of the Routh array using the cross-multiplication determinant algorithm",
        "Formulate algebraic inequalities forcing every term in the first column to be strictly greater than zero (> 0)",
        "Solve the simultaneous inequalities to determine the permissible stable parameter range: K_min < K < K_max"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Routh-Hurwitz Feature to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "First Column Sign Changes", "right": "Count of sign reversals indicating the exact number of roots located in the unstable Right-Half Plane" },
        { "left": "Entire Row of Zeros", "right": "Indicates pairs of roots located symmetrically on the imaginary j\u03c9-axis causing sustained oscillations" },
        { "left": "Auxiliary Polynomial A(s)", "right": "Even polynomial formed from the row above a row of zeros used to find marginal oscillation frequencies" },
        { "left": "Necessary Stability Rule", "right": "All polynomial coefficients must be non-zero and share identical positive algebraic signs" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The number of roots of a characteristic polynomial lying in the unstable right-half plane equals the number of sign changes in the ___ column of the Routh array.",
      "blankAnswer": "first",
      "blankDistractors": ["last", "second", "diagonal"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A closed-loop system has characteristic equation s^3 + 6*s^2 + 8*s + K = 0. For what range of gain K is the system stable, and what is the sustained oscillation frequency \u03c9_osc at the critical marginal stability boundary K_crit?",
      "options": [
        { "text": "0 < K < 48 and \u03c9_osc = 2.83 rad/s (\u221a8 rad/s) (Routh row s^1: b1 = (6*8 - K)/6 > 0 \u2192 K < 48; row s^0: K > 0; at K=48, auxiliary 6*s^2 + 48 = 0 \u2192 s = \u00b1j\u221a8 \u2248 \u00b1j2.83 rad/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Routh-Hurwitz stability criterion (Katsuhiko Ogata *Modern Control Engineering* Chapter 5). 1. **Characteristic Equation:** $$q(s) = s^3 + 6 s^2 + 8 s + K = 0$$ 2. **Construct the Routh Array:** - **Row $s^3$:** $1, \\quad 8$ - **Row $s^2$:** $6, \\quad K$ - **Row $s^1$:** $$b_1 = \\frac{6(8) - 1(K)}{6} = \\frac{48 - K}{6}$$ - **Row $s^0$:** $$c_1 = \\frac{b_1(K) - 6(0)}{b_1} = K$$ 3. **Evaluate Stability Conditions (First Column $> 0$):** - From Row $s^1$: $$\\frac{48 - K}{6} > 0 \\implies 48 - K > 0 \\implies \\mathbf{K < 48}$$ - From Row $s^0$: $$K > 0 \\implies \\mathbf{K > 0}$$ - **Stable Range: $\\mathbf{0 < K < 48}$**. 4. **Calculate Marginal Oscillation Frequency at $K_{\\text{crit}} = 48$:** - When $K = 48$, the $s^1$ row becomes strictly zero. - Form the **Auxiliary Polynomial $A(s)$** from the $s^2$ row: $$A(s) = 6 s^2 + K_{\\text{crit}} = 6 s^2 + 48 = 0$$ $$6 s^2 = -48 \\implies s^2 = -8 \\implies s = \\pm j \\sqrt{8} = \\pm j 2 \\sqrt{2} \\approx \\mathbf{\\pm j 2.8284\\text{ rad/s}}$$ - Therefore: $\\mathbf{\\omega_{\\text{osc}} = \\sqrt{8} \\approx 2.83\\text{ rad/s}}$! Flawless Routh-Hurwitz analysis!" },
        { "text": "0 < K < 24 and \u03c9_osc = 4.00 rad/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "K > 48 and \u03c9_osc = 6.00 rad/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0 < K < 48 and \u03c9_osc = 8.00 rad/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
