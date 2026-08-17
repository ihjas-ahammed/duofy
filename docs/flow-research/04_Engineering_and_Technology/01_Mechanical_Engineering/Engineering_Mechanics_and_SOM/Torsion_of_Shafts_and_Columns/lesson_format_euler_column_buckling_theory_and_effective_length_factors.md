# Duofy Reusable Lesson Format: Column Buckling (Euler Critical Load and Effective Length Factors)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Torsion_of_Shafts_and_Columns`  
**Lesson Format Type:** `euler_column_buckling_theory_and_effective_length_factors`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through elastic instability, bifurcation buckling, differential deflection equations, and end boundary restraint factors in structural compression members (Leonhard Euler 1757; Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 10; James M. Gere & Barry J. Goodno *Mechanics of Materials* Chapter 11): derive the differential equation for column buckling ($\mathbf{E I \frac{d^2 v}{dx^2} + P v = 0 \implies v(x) = C_1 \sin(kx) + C_2 \cos(kx)}$), master **Euler's Critical Buckling Load Formula**:
$$\mathbf{P_{\text{cr}} = \frac{\pi^2 E I_{\text{min}}}{(L_e)^2} = \frac{\pi^2 E I_{\text{min}}}{(K L)^2}}$$
master the **4 Fundamental Effective Length Factors ($K$)**: **1. Both Ends Pinned / Hinged ($\mathbf{K = 1.0 \implies L_e = L}$)**, **2. One End Fixed, One End Free Cantilever ($\mathbf{K = 2.0 \implies L_e = 2L \implies P_{\text{cr}} = 0.25 \frac{\pi^2 E I}{L^2}}$ - Weakest!)**, **3. One End Fixed, One End Pinned ($\mathbf{K \approx 0.7 \implies L_e = 0.7L \implies P_{\text{cr}} \approx 2.04 \frac{\pi^2 E I}{L^2}}$)**, and **4. Both Ends Fixed / Clamped ($\mathbf{K = 0.5 \implies L_e = 0.5L \implies P_{\text{cr}} = 4 \frac{\pi^2 E I}{L^2}}$ - $4\times$ Strongest!)**; and emphasize why columns **ALWAYS buckle about the axis of Minimum Moment of Inertia ($I_{\text{min}}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler Buckling Formula ($P_{\text{cr}} = \frac{\pi^2 E I}{(KL)^2}$) & 4 End Conditions Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing and Buckling Load Calculation for a Column Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Column End Restraint Condition / Boundary Parameter & Effective Length Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Column with Both Ends Clamped (Fixed-Fixed) Has an Effective Length Factor K Equal to 0.___ (5 / 0.5) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Structural Mechanics Problem: Calculating the Critical Euler Buckling Load of an I-Section Column Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Euler Buckling (Euler 1757; Beer & Johnston 2020):
   - **Euler Critical Buckling Load Formulation:**
     $$\mathbf{P_{\text{cr}} = \frac{\pi^2 E I_{\text{min}}}{(K L)^2}}$$
   - **Effective Length Factor ($K$) Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{End Restraints} & \textbf{Effective Factor } K & \textbf{Effective Length } L_e & \textbf{Buckling Capacity } P_{\text{cr}} \\
     \hline
     \mathbf{\text{Both Ends Fixed (Clamped)}} & \mathbf{K = 0.5} & L_e = 0.5 L & \mathbf{P_{\text{cr}} = \frac{4 \pi^2 E I}{L^2} \ (4.0\times \text{ Baseline - Strongest!})} \\
     \mathbf{\text{One Fixed, One Pinned}} & \mathbf{K = 0.7} & L_e = 0.7 L & P_{\text{cr}} = \frac{\pi^2 E I}{(0.7 L)^2} \approx \frac{2.04 \pi^2 E I}{L^2} \\
     \mathbf{\text{Both Ends Pinned (Hinged)}} & \mathbf{K = 1.0} & L_e = 1.0 L & \mathbf{P_{\text{cr}} = \frac{\pi^2 E I}{L^2} \ (1.0\times \text{ Baseline})} \\
     \mathbf{\text{One Fixed, One Free (Cantilever)}} & \mathbf{K = 2.0} & L_e = 2.0 L & \mathbf{P_{\text{cr}} = \frac{\pi^2 E I}{4 L^2} \ (0.25\times \text{ Baseline - Weakest!})} \\
     \hline
     \end{array}$$
   - **The Weak-Axis Invariant:** A column **ALWAYS buckles about its weakest principal axis** possessing the **Minimum Moment of Inertia** ($I_{\text{min}} = \min(I_x, I_y)$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of calculating Euler buckling load: (1) calculate principal moments of inertia $I_x$ and $I_y$ for the column cross-section and identify $I_{\text{min}} = \min(I_x, I_y)$, (2) inspect the column's physical end boundary supports to determine effective length factor $K$, (3) calculate the effective length $L_e = K L$, (4) compute Euler's critical buckling load $P_{\text{cr}} = \frac{\pi^2 E I_{\text{min}}}{L_e^2}$, (5) divide by factor of safety ($FS$) to determine maximum allowable compressive service load $P_{\text{allow}} = \frac{P_{\text{cr}}}{FS}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Fixed-Fixed $K=0.5$, Fixed-Free $K=2.0$, Pinned-Pinned $K=1.0$, Weak Axis $I_{\text{min}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.5 (or 5). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Euler critical load: A solid rectangular steel column ($E = 200\text{ GPa} = 200 \times 10^9\text{ Pa}$) of actual length $L = 4.0\text{ m}$ is **fixed at the base and pinned at the top ($K = 0.7$)**. Its cross-section has dimensions $b = 50\text{ mm} = 0.05\text{ m}$ and $h = 100\text{ mm} = 0.10\text{ m}$. What is the Euler critical buckling load $P_{\text{cr}}$ of the column? ($I_x = \frac{b h^3}{12} = \frac{(0.05)(0.10)^3}{12} = 4.167 \times 10^{-6}\text{ m}^4$; $I_y = \frac{h b^3}{12} = \frac{(0.10)(0.05)^3}{12} = 1.0417 \times 10^{-6}\text{ m}^4$; minimum inertia $I_{\text{min}} = I_y = 1.0417 \times 10^{-6}\text{ m}^4$; effective length $L_e = K L = (0.7)(4.0\text{ m}) = 2.8\text{ m}$; $P_{\text{cr}} = \frac{\pi^2 E I_{\text{min}}}{L_e^2} = \frac{\pi^2 (200 \times 10^9)(1.0417 \times 10^{-6})}{(2.8)^2} = \frac{2.0562 \times 10^6}{7.84} \approx \mathbf{262.3\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "euler_column_buckling_theory_and_effective_length_factors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Euler Column Buckling \\& Effective Length Theory (Leonhard Euler 1757)**\n• **Euler Critical Buckling Load Formulation:**\n$$\n\\mathbf{P_{\\text{cr}} = \\frac{\\pi^2 E I_{\\text{min}}}{(K L)^2} = \\frac{\\pi^2 E I_{\\text{min}}}{(L_e)^2}}\n$$\n• **Effective Length Factor (K) Boundary Matrix:**\n$$\n\\begin{array}{|l|c|c|l|}\n\\hline\n\\textbf{End Boundary Restraints} & \\textbf{Factor } K & \\textbf{Effective Length } L_e & \\textbf{Relative Buckling Capacity} \\\\\n\\hline\n\\mathbf{\\text{Both Ends Fixed / Clamped}} & \\mathbf{K = 0.5} & L_e = 0.5 L & \\mathbf{P_{\\text{cr}} = \\frac{4 \\pi^2 E I}{L^2} \\ (4.0\\times \\text{ Strongest!})} \\\\\n\\mathbf{\\text{One Fixed, One Pinned}} & \\mathbf{K = 0.7} & L_e = 0.7 L & P_{\\text{cr}} \\approx \\frac{2.04 \\pi^2 E I}{L^2} \\ (2.04\\times) \\\\\n\\mathbf{\\text{Both Ends Pinned / Hinged}} & \\mathbf{K = 1.0} & L_e = 1.0 L & \\mathbf{P_{\\text{cr}} = \\frac{\\pi^2 E I}{L^2} \\ (1.0\\times \\text{ Baseline})} \\\\\n\\mathbf{\\text{One Fixed, One Free (Cantilever)}} & \\mathbf{K = 2.0} & L_e = 2.0 L & \\mathbf{P_{\\text{cr}} = \\frac{\\pi^2 E I}{4 L^2} \\ (0.25\\times \\text{ Weakest!})} \\\\\n\\hline\n\\end{array}\n$$\n• **The Weak-Axis Invariant:** A column will **ALWAYS buckle about its weakest principal axis**, corresponding to the **Minimum Moment of Inertia ($\\mathbf{I_{\\text{min}} = \\min(I_x, I_y)}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to compute the Euler critical buckling load for a structural column.",
      "orderItems": [
        "Calculate the principal moments of inertia Ix and Iy for the cross-section and identify the minimum value I_min",
        "Inspect the physical end support restraints to determine the theoretical Effective Length Factor K",
        "Compute the column's effective length using the relationship L_e = K * L",
        "Apply Euler's formula P_cr = (pi^2 * E * I_min) / (L_e)^2 to compute the critical elastic buckling load in Newtons",
        "Divide P_cr by a structural factor of safety (FS) to establish the safe allowable compressive design load P_allow"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Column Boundary Condition to its exact Effective Length Factor K.",
      "matchPairs": [
        { "left": "Both Ends Fixed (Clamped-Clamped)", "right": "K = 0.5, creating inflection points at L/4 and quadrupling buckling capacity (4x)" },
        { "left": "One Fixed, One Pinned", "right": "K = 0.7, yielding an effective length L_e = 0.7 L with roughly double baseline strength" },
        { "left": "Both Ends Pinned (Hinged-Hinged)", "right": "K = 1.0, representing the standard fundamental half-sine wave baseline mode" },
        { "left": "Fixed-Free (Cantilever Column)", "right": "K = 2.0, cutting buckling capacity to only one-quarter (0.25x) of pinned baseline" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A column clamped rigidly at both ends (Fixed-Fixed) has an effective length factor K equal to 0.___.",
      "blankAnswer": "5",
      "blankDistractors": ["7", "2", "1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rectangular steel column (E = 200 GPa = 200 x 10^9 Pa) of length L = 4.0 m is Fixed at the base and Pinned at the top (K = 0.7). Its cross-section dimensions are b = 50 mm (0.05 m) and h = 100 mm (0.10 m). What is the Euler critical buckling load P_cr of the column?",
      "options": [
        { "text": "P_cr = 262.3 kN (buckling occurs about the weak axis with I_min = I_y = 1.042 x 10^-6 m^4)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Euler's column buckling formula (Beer & Johnston *Mechanics of Materials* Chapter 10). 1. **Moments of Inertia about Principal Axes:** - Major axis: $I_x = \\frac{b h^3}{12} = \\frac{(0.05)(0.10)^3}{12} = 4.1667 \\times 10^{-6}\\text{ m}^4$. - Minor (Weak) axis: $I_y = \\frac{h b^3}{12} = \\frac{(0.10)(0.05)^3}{12} = \\mathbf{1.04167 \\times 10^{-6}\\text{ m}^4}$. - **Weak Axis Invariant:** $I_{\\text{min}} = I_y = 1.04167 \\times 10^{-6}\\text{ m}^4$! (The column will bow sideways parallel to width $b$). 2. **Effective Length ($L_e$):** - For Fixed-Pinned: $K = 0.7$. - $L_e = K L = (0.7)(4.0\\text{ m}) = \\mathbf{2.8\\text{ m}}$. 3. **Euler Critical Buckling Load ($P_{\\text{cr}}$):** $$P_{\\text{cr}} = \\frac{\\pi^2 E I_{\\text{min}}}{(L_e)^2} = \\frac{\\pi^2 (200 \\times 10^9\\text{ Pa})(1.04167 \\times 10^{-6}\\text{ m}^4)}{(2.8\\text{ m})^2} = \\frac{2,056,180}{7.84} = 262,267\\text{ N} = \\mathbf{262.3\\text{ kN}}$$ Flawless stability analysis!" },
        { "text": "P_cr = 1,049.2 kN (calculated using strong axis Ix)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_cr = 128.5 kN", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_cr = 524.6 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
