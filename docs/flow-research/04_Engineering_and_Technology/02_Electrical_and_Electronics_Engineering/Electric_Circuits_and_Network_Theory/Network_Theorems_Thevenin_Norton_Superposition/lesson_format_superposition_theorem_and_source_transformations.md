# Duofy Reusable Lesson Format: Linear Network Simplification (Superposition & Source Transformations)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / Network_Theorems_Thevenin_Norton_Superposition`  
**Lesson Format Type:** `superposition_theorem_and_source_transformations`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through circuit linearity principles, independent source deactivation rules, the Superposition Theorem, and Thévenin-Norton source equivalence transformations in linear electric networks (Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 4; James W. Nilsson & Susan A. Riedel *Electric Circuits* Chapter 4): master the **Superposition Theorem Formulation**:
$$\mathbf{v_{\text{total}} = \sum_{k=1}^N v_k \quad \Big| \quad i_{\text{total}} = \sum_{k=1}^N i_k}$$
under strict **Source Deactivation Rules**:
1. **Independent Voltage Sources ($V_s = 0$):** Replaced by an ideal zero-resistance **Short Circuit**;
2. **Independent Current Sources ($I_s = 0$):** Replaced by an ideal infinite-resistance **Open Circuit**;
3. **Dependent Sources:** **NEVER DEACTIVATED** (controlled sources must remain active during every sub-circuit evaluation);
master the **Non-Linear Power Invariant** (proving why Superposition applies **strictly to voltages and currents, NEVER to power $\mathbf{P \ne P_1 + P_2}$** because power is quadratic: $\mathbf{P = i^2 R = (i_1 + i_2)^2 R = i_1^2 R + i_2^2 R + 2 i_1 i_2 R}$); and master **Source Transformations**:
$$\mathbf{\text{Voltage Source in Series with } R \quad \Longleftrightarrow \quad \text{Current Source } I_s = \frac{V_s}{R} \text{ in Parallel with } R}$$

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Superposition Law, Source Deactivation Rules & Source Transformation Equivalence Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Solve Branch Voltage Using the Superposition Theorem Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Network Simplification Operation / Source State & Technical Circuit Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | To Deactivate an Independent Voltage Source in Superposition Analysis, It Must Be Replaced by a ___ Circuit (Short) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Linear Circuit Analysis Problem: Calculating the Branch Current and Total Power Dissipation Using Superposition Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Superposition & Source Transformations (Alexander & Sadiku 2021; Nilsson 2020):
   - **Superposition & Transformation Formulations:**
     $$\mathbf{v = v_1 + v_2 + \dots + v_N \quad \Big| \quad i = i_1 + i_2 + \dots + i_N \quad \Big| \quad V_s = I_s R \Longleftrightarrow I_s = \frac{V_s}{R}}$$
   - **Source Deactivation Rules Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Source Element} & \textbf{Deactivated State Action} & \textbf{Equivalent Impedance} \\
     \hline
     \mathbf{\text{Independent Voltage Source}} & \mathbf{\text{Replace with Short Circuit } (V = 0)} & R_{\text{internal}} = 0\,\Omega \\
     \mathbf{\text{Independent Current Source}} & \mathbf{\text{Replace with Open Circuit } (I = 0)} & R_{\text{internal}} = \infty\,\Omega \\
     \mathbf{\text{Dependent Controlled Source}} & \mathbf{\text{DO NOT TOUCH (Remains Active!)}} & \text{Controlled by circuit variables} \\
     \hline
     \end{array}$$
   - **The Non-Linear Power Invariant:** Superposition **CANNOT be used to calculate power directly ($\mathbf{P \ne P_1 + P_2}$)**; you must first find total current $i = i_1 + i_2$ and then compute $P = i^2 R$!
2. **Slide 2 (`ordering`):** Provide 5 steps of superposition analysis: (1) count independent sources and create separate sub-circuits for each source, (2) in sub-circuit 1, deactivate all other independent sources (short voltage sources, open current sources) while keeping dependent sources active, (3) solve the sub-response voltage $v_1$ or current $i_1$ using Ohm's Law/nodal analysis, (4) repeat for all remaining independent sources to find $v_2, \dots, v_N$, (5) sum all individual contributions algebraically ($v_{\text{total}} = \sum v_k$) and calculate total power $P = v_{\text{total}}^2 / R$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Superposition Theorem, Voltage Source Deactivation, Current Source Deactivation, Source Transformation) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Short. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on superposition and power: A resistor $R = 5\,\Omega$ is connected in a circuit driven simultaneously by a $V_s = 20\text{ V}$ independent voltage source and an $I_s = 2\text{ A}$ independent current source. Analysis reveals that the voltage source acting alone produces a current $i_1 = 3\text{ A}$ through $R$, while the current source acting alone produces a current $i_2 = 1\text{ A}$ through $R$ in the same direction. What is the total current $i_{\text{total}}$ through $R$, and what is the actual total power $P$ dissipated in the $5\,\Omega$ resistor? ($i_{\text{total}} = i_1 + i_2 = 3\text{ A} + 1\text{ A} = \mathbf{4\text{ A}}$; Actual power: $P = i_{\text{total}}^2 R = (4\text{ A})^2 \times 5\,\Omega = 16 \times 5 = \mathbf{80\text{ W}}$ (Note: Sum of individual powers $P_1 + P_2 = (3)^2(5) + (1)^2(5) = 45 + 5 = 50\text{ W} \ne 80\text{ W}$ due to the cross-term $2 i_1 i_2 R = 2(3)(1)(5) = 30\text{ W}$!)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "superposition_theorem_and_source_transformations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Superposition Theorem \\& Source Equivalence (Alexander \\& Sadiku)**\n• **The Superposition Theorem Formulation:**\n$$\n\\mathbf{v_{\\text{total}} = \\sum_{k=1}^N v_k \\quad \\Big| \\quad i_{\\text{total}} = \\sum_{k=1}^N i_k \\quad (\\text{In any linear bilateral network})}\n$$\n• **Independent Source Deactivation Rules:**\n  - **Independent Voltage Source ($V = 0$):** Replaced with an ideal **Short Circuit** (zero resistance wire);\n  - **Independent Current Source ($I = 0$):** Replaced with an ideal **Open Circuit** (broken wire);\n  - **Dependent Sources:** **NEVER DEACTIVATED** (must remain fully active during every sub-circuit calculation)!\n• **Source Transformation Equivalence:**\n$$\n\\mathbf{\\text{Voltage Source } V_s \\text{ in series with } R \\quad \\Longleftrightarrow \\quad \\text{Current Source } I_s = \\frac{V_s}{R} \\text{ in parallel with } R}\n$$\n• **The Non-Linear Power Invariant:** Superposition applies **strictly to linear voltages and currents, NEVER directly to power ($\\mathbf{P \\ne P_1 + P_2}$)** because power is quadratic: $\\mathbf{P = (i_1 + i_2)^2 R = i_1^2 R + i_2^2 R + 2 i_1 i_2 R}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate a branch current in a multi-source circuit using the Superposition Theorem.",
      "orderItems": [
        "Identify all independent energy sources present in the linear electrical network",
        "Select the first independent source to analyze and deactivate all other independent sources (short voltage sources, open current sources)",
        "Calculate the partial response current i1 in the target branch caused solely by the first active source",
        "Repeat the process for all remaining independent sources to find their individual partial responses (i2, i3, ..., in)",
        "Algebraically sum all partial currents i_total = i1 + i2 + ... + in and compute total power dissipation P = (i_total)^2 * R"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Circuit Transformation Rule to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Superposition Theorem", "right": "Total response equals algebraic sum of individual responses from each independent source acting alone" },
        { "left": "Voltage Source Deactivation", "right": "Setting Vs = 0 V by replacing the voltage source with an ideal zero-ohm short circuit" },
        { "left": "Current Source Deactivation", "right": "Setting Is = 0 A by replacing the current source with an infinite-impedance open circuit" },
        { "left": "Source Transformation", "right": "Replacing a series (Vs, R) branch with an identical parallel (Is = Vs/R, R) source branch" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To deactivate an independent voltage source during superposition analysis, it must be replaced by a ___ circuit.",
      "blankAnswer": "short",
      "blankDistractors": ["open", "ground", "diode"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A resistor R = 5 \u03a9 is driven by two independent sources. Source 1 alone produces i1 = 3 A through R, while Source 2 alone produces i2 = 1 A in the same direction. What is the total current i_total and the actual total power P dissipated in the 5 \u03a9 resistor?",
      "options": [
        { "text": "i_total = 4 A and P = 80 W (i_total = 3 + 1 = 4 A, and actual power P = (4 A)^2 * 5 \u03a9 = 80 W; demonstrating why P != P1 + P2 = 45W + 5W = 50W)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Superposition Theorem and power principles (Charles Alexander & Matthew Sadiku *Fundamentals of Electric Circuits* Chapter 4). 1. **Calculate Total Current via Superposition:** - Current from Source 1: $i_1 = 3\\text{ A}$. - Current from Source 2: $i_2 = 1\\text{ A}$ (same direction). $$i_{\\text{total}} = i_1 + i_2 = 3\\text{ A} + 1\\text{ A} = \\mathbf{4\\text{ A}}$$ 2. **Calculate Actual Total Power Dissipation ($P$):** $$P = i_{\\text{total}}^2 \\cdot R = (4\\text{ A})^2 \\times 5\\,\\Omega = 16 \\times 5 = \\mathbf{80\\text{ Watts}}$$ 3. **The Power Superposition Fallacy Demonstration:** - $P_1 = i_1^2 R = (3)^2(5) = 45\\text{ W}$. - $P_2 = i_2^2 R = (1)^2(5) = 5\\text{ W}$. - $P_1 + P_2 = 45 + 5 = 50\\text{ W} \\ne 80\\text{ W}$! - The difference of $30\\text{ W}$ is the cross-coupling power term: $$P_{\\text{cross}} = 2 i_1 i_2 R = 2(3)(1)(5) = \\mathbf{30\\text{ W}}$$ This is why power can NEVER be directly calculated by superposing sub-circuit powers!" },
        { "text": "i_total = 4 A and P = 50 W (Adding P1 = 45W and P2 = 5W)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "i_total = 2 A and P = 20 W", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "i_total = 3 A and P = 45 W", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
