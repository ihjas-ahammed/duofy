# Duofy Reusable Lesson Format: Hardy Cross Method (Moment Distribution & Convergence)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Slope_Deflection_and_Moment_Distribution`  
**Lesson Format Type:** `hardy_cross_moment_distribution_method_and_distribution_factors`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Hardy Cross's revolutionary 1930 **Moment Distribution Method (Hardy Cross Method)** for solving complex continuous indeterminate beams without setting up simultaneous matrix equations, calculating member flexural stiffness ($K = \frac{4EI}{L}$), Distribution Factors ($\text{DF}$), Carry-Over Factors ($\text{COF} = +0.50$), and executing iterative cycles of joint unlocking, moment balancing, and carry-over distribution until mathematical convergence is achieved (Hardy Cross *Analysis of Continuous Frames by Distributing Fixed-End Moments* 1930; Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 12; Aslam Kassimali *Structural Analysis* 6th ed. Chapter 15): formulate the **Member Rotational Stiffness ($K$)**:
$$\mathbf{K_{\text{fixed}} = \frac{4 E I}{L} \quad (\text{Far end fixed}) \quad \Big| \quad \mathbf{K_{\text{pinned}} = \frac{3 E I}{L} \quad (\text{Far end pinned/roller})}}$$
derive the **Joint Distribution Factor ($\text{DF}_{ij}$)**:
$$\mathbf{\text{DF}_{ij} = \frac{K_{ij}}{\sum_{k} K_{ik}} \quad \left(\text{Enforces } \sum \text{DF} = 1.0 \text{ at each rigid joint}\right)}$$
$$\mathbf{\text{Boundary Values: } \mathbf{\text{DF} = 0 \ (\text{Rigid Fixed Wall})} \quad \Big| \quad \mathbf{\text{DF} = 1.0 \ (\text{Simple Pin/Roller End})}}$$
master the **Hardy Cross Iterative Algorithm**:
1. **Lock all joints** and write initial Fixed-End Moments ($\text{FEM}$);
2. **Compute Unbalanced Joint Moment:** $M_{\text{unbalanced}} = \sum M_{\text{initial}}$ at the joint;
3. **Balance / Distribute:** $\mathbf{M_{\text{dist},ij} = - \text{DF}_{ij} \cdot M_{\text{unbalanced}}}$;
4. **Carry-Over:** $\mathbf{M_{\text{carried},ji} = +\frac{1}{2} M_{\text{dist},ij} \ (\text{COF} = +0.50)}$;
5. Repeat until distributed moments converge below $0.05\text{ kNm}$, then sum each column to get exact final support moments.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hardy Cross Algorithm, Stiffness ($K = \frac{4EI}{L}$), $\text{DF} = \frac{K}{\sum K}$ & $\text{COF} = +0.50$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution of the Moment Distribution Table for a 2-Span Continuous Beam Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Moment Distribution Parameter / Operation & Technical Mechanics Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Hardy Cross Moment Distribution Method, the Carry-Over Factor to a Fixed Far End Is Exactly Positive ___ (0.5 / Half) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Civil Engineering Problem: Calculating Distribution Factors and First-Cycle Distributed Moments for a 2-Span Beam Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hardy Cross Moment Distribution (Cross 1930; Hibbeler 2018):
   - **Hardy Cross Formulations:**
     $$\mathbf{K = \frac{4EI}{L} \quad \Big| \quad \text{DF} = \frac{K}{\sum K} \quad \Big| \quad M_{\text{dist}} = -\text{DF} \cdot \sum M \quad \Big| \quad \text{COF} = +0.50 \quad \Big| \quad \sum \text{DF}_{\text{joint}} = 1.0}$$
   - **Distribution Factor Boundary Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Support Type} & \textbf{Rotational Stiffness } K & \textbf{Distribution Factor } \text{DF} & \textbf{Carry-Over Factor } \text{COF} \\
     \hline
     \mathbf{\text{Continuous Rigid Joint}} & \sum K_{\text{members}} & \mathbf{\text{DF}_{ij} = K_{ij} / \sum K} & \mathbf{+0.50 \ (+1/2)} \\
     \mathbf{\text{Fixed End Wall}} & K = \infty & \mathbf{\text{DF} = 0 \ (\text{Absorbs all, distributes none})}} & 0 \\
     \mathbf{\text{Simple Pin / Roller End}} & K = 0 & \mathbf{\text{DF} = 1.0 \ (\text{Cannot resist moment})}} & 0 \\
     \hline
     \end{array}$$
   - **The Relaxation Invariant:** Balancing a joint is physically equivalent to **temporarily unlocking the pin**, allowing it to rotate until internal moments cancel ($\sum M = 0$), and then re-clamping it to carry over half the balancing moment to the opposite ends!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Hardy Cross method: (1) calculate relative member stiffnesses $K = 4EI/L$ and distribution factors $\text{DF} = K / \sum K$ for all joints, (2) compute initial Fixed-End Moments ($\text{FEM}$) on all spans, (3) balance all unlocked joints by multiplying total unbalanced moment by $-\text{DF}$, (4) carry over $+0.50 \times \text{Distributed Moment}$ to adjacent fixed member ends, (5) iterate balancing and carry-over cycles until residual moments diminish to near zero, then sum all columns!
3. **Slide 3 (`matching`):** Pair 4 concepts (Distribution Factor $\text{DF}$, Carry-Over Factor $+0.50$, Member Stiffness $4EI/L$, Fixed Support $\text{DF} = 0$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.5 (or Half). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating DFs and first cycle: A 2-span continuous beam $ABC$ has fixed support at $A$, continuous roller support at $B$, and fixed support at $C$. Span $AB$ has $L_1 = 4.0\text{ m}, \ EI$ ($K_{BA} = \frac{4EI}{4} = 1.0 EI$). Span $BC$ has $L_2 = 6.0\text{ m}, \ EI$ ($K_{BC} = \frac{4EI}{6} = 0.667 EI$). Span $AB$ carries a uniform load producing $\text{FEM}_{BA} = +60.0\text{ kNm}$, while span $BC$ is unloaded ($\text{FEM}_{BC} = 0$). What are the distribution factors $\text{DF}_{BA}$ and $\text{DF}_{BC}$ at joint $B$, and what is the distributed balancing moment at $BA$ on Cycle 1? ($\sum K_B = 1.0 EI + 0.6667 EI = 1.6667 EI$; $\text{DF}_{BA} = \frac{1.0}{1.6667} = \mathbf{0.60\text{ (or } 3/5)}$; $\text{DF}_{BC} = \frac{0.6667}{1.6667} = \mathbf{0.40\text{ (or } 2/5)}$; Unbalanced moment $= +60.0\text{ kNm}$; Balancing moment at $BA = -0.60 \times (+60.0) = \mathbf{-36.0\text{ kNm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hardy_cross_moment_distribution_method_and_distribution_factors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hardy Cross Moment Distribution Method (Hardy Cross 1930)**\n• **Member Rotational Stiffness ($K$):**\n$$\n\\mathbf{K_{\\text{fixed}} = \\frac{4 E I}{L} \\quad \\Big| \\quad K_{\\text{pinned}} = \\frac{3 E I}{L}}\n$$\n• **Joint Distribution Factor ($\\text{DF}_{ij}$):**\n$$\n\\mathbf{\\text{DF}_{ij} = \\frac{K_{ij}}{\\sum_{k} K_{ik}} \\quad (\\sum \\text{DF} = 1.0 \\text{ at rigid joints}, \\ \\text{DF}_{\\text{fixed}} = 0, \\ \\text{DF}_{\\text{pin}} = 1.0)}\n$$\n• **Carry-Over Factor ($\\text{COF}$):**\n$$\n\\mathbf{\\text{COF} = +\\frac{1}{2} = +0.50 \\quad (\\text{Transfers half the distributed moment to the far fixed end})}\n$$\n• **The Relaxation Invariant:** Unlocking a joint distributes the unbalanced moment $-\\text{DF} \\cdot \\sum M$ proportionally to stiffness, automatically converging toward the exact elastic solution without matrix inversion!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the iterative Hardy Cross Moment Distribution Method for a continuous beam.",
      "orderItems": [
        "Calculate member flexural stiffnesses K = 4EI/L and compute Distribution Factors DF = K / \u2211K at every joint",
        "Clamp all joints and compute initial Fixed-End Moments (FEM) for every loaded span",
        "Unlock rigid joints and distribute balancing moments: M_dist = -DF * (\u2211M_unbalanced)",
        "Carry over +0.50 times the distributed moment to the opposite ends of each member: M_carry = +0.50 * M_dist",
        "Repeat distribution and carry-over cycles until unbalanced residuals become negligible, then sum each column"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hardy Cross Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Distribution Factor (DF)", "right": "DF = K / \u2211K, fraction of joint unbalanced moment absorbed by a connected member based on relative stiffness" },
        { "left": "Carry-Over Factor (+0.50)", "right": "Fraction of distributed moment induced at the far fixed end when a near joint rotates" },
        { "left": "Fixed Support DF = 0", "right": "Rigid wall with infinite stiffness that absorbs all incoming carry-over moments without releasing any back" },
        { "left": "Simple Pin End DF = 1.0", "right": "Zero-stiffness end that releases 100% of any applied moment to maintain zero support moment" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Hardy Cross Moment Distribution Method, the carry-over factor to a fixed far end is exactly positive ___.",
      "blankAnswer": "0.5",
      "blankDistractors": ["1.0", "0", "-0.5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2-span continuous beam ABC has fixed supports at A and C, and continuous roller at B. Span AB (L1 = 4.0 m, EI) has K_BA = 1.0 EI, while span BC (L2 = 6.0 m, EI) has K_BC = 0.667 EI. Span AB carries a load creating FEM_BA = +60.0 kNm, while span BC is unloaded (FEM_BC = 0). What are the distribution factors DF_BA and DF_BC at joint B, and what is the distributed balancing moment M_dist at BA on Cycle 1?",
      "options": [
        { "text": "DF_BA = 0.60 (3/5), DF_BC = 0.40 (2/5), and M_dist(BA) = -36.0 kNm (\u2211K_B = 1.0 + 0.667 = 1.667 EI; DF_BA = 1.0/1.667 = 0.60; DF_BC = 0.667/1.667 = 0.40; M_unbalanced = +60 kNm \u2192 M_dist(BA) = -0.60 * (+60) = -36.0 kNm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Hardy Cross Moment Distribution Method (Hardy Cross 1930; Russell C. Hibbeler *Structural Analysis* Chapter 12). 1. **Calculate Joint $B$ Rotational Stiffnesses ($K = \\frac{4EI}{L}$):** - Member $BA$ (far end $A$ is fixed): $$K_{BA} = \\frac{4 E I}{L_1} = \\frac{4 E I}{4.0\\text{ m}} = \\mathbf{1.000\\ E I}$$ - Member $BC$ (far end $C$ is fixed): $$K_{BC} = \\frac{4 E I}{L_2} = \\frac{4 E I}{6.0\\text{ m}} = \\mathbf{0.6667\\ E I = \\frac{2}{3} E I}$$ 2. **Calculate Total Joint $B$ Stiffness ($\\sum K_B$):** $$\\sum K_B = K_{BA} + K_{BC} = 1.000\\ E I + 0.6667\\ E I = \\mathbf{1.6667\\ E I = \\frac{5}{3} E I}$$ 3. **Calculate Distribution Factors at Joint $B$:** $$\\text{DF}_{BA} = \\frac{K_{BA}}{\\sum K_B} = \\frac{1.000\\ E I}{1.6667\\ E I} = \\frac{1}{5/3} = \\mathbf{0.60\\text{ (or } 60\\%\\text{)}}$$ $$\\text{DF}_{BC} = \\frac{K_{BC}}{\\sum K_B} = \\frac{0.6667\\ E I}{1.6667\\ E I} = \\frac{2/3}{5/3} = \\mathbf{0.40\\text{ (or } 40\\%\\text{)}}$$ - Sanity check: $\\text{DF}_{BA} + \\text{DF}_{BC} = 0.60 + 0.40 = \\mathbf{1.00}$! 4. **Calculate Cycle 1 Distributed Balancing Moment ($M_{\\text{dist}}$):** - Total unbalanced moment at joint $B$: $$\\sum M_{\\text{initial}} = \\text{FEM}_{BA} + \\text{FEM}_{BC} = +60.0\\text{ kN}\\cdot\\text{m} + 0 = \\mathbf{+60.0\\text{ kN}\\cdot\\text{m}}$$ - Balancing moment distributed to member $BA$: $$M_{\\text{dist},BA} = - \\text{DF}_{BA} \\times \\left(\\sum M_{\\text{initial}}\\right) = - 0.60 \\times (+60.0\\text{ kN}\\cdot\\text{m}) = \\mathbf{-36.0\\text{ kN}\\cdot\\text{m}}$$ - Balancing moment distributed to member $BC$: $$M_{\\text{dist},BC} = - \\text{DF}_{BC} \\times (+60.0\\text{ kN}\\cdot\\text{m}) = \\mathbf{-24.0\\text{ kN}\\cdot\\text{m}}$$ - Notice: $(-36.0) + (-24.0) = -60.0\\text{ kNm}$, which perfectly balances the $+60.0\\text{ kNm}$ initial clamp! Flawless Hardy Cross distribution!" },
        { "text": "DF_BA = 0.50, DF_BC = 0.50, and M_dist(BA) = -30.0 kNm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "DF_BA = 0.40, DF_BC = 0.60, and M_dist(BA) = -24.0 kNm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "DF_BA = 0.60, DF_BC = 0.40, and M_dist(BA) = +36.0 kNm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
