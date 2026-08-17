# Duofy Reusable Lesson Format: Thévenin & Norton (Equivalents & Rth Evaluation Methods)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / Network_Theorems_Thevenin_Norton_Superposition`  
**Lesson Format Type:** `thevenin_and_norton_equivalent_circuits_and_rth_determination`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through two-terminal linear network reductions, open-circuit voltage ($V_{oc}$), short-circuit current ($I_{sc}$), Thévenin and Norton dual equivalent circuits, and systematic $R_{th}$ evaluation methods for both passive and active dependent circuits (Léon Charles Thévenin 1883; Edward Lawry Norton 1926; Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 4; James W. Nilsson & Susan A. Riedel *Electric Circuits* Chapter 4): formulate the **Thévenin and Norton Dual Models**:
$$\mathbf{\text{Thévenin: } V_{th} = V_{oc} \text{ in series with } R_{th} \quad \Longleftrightarrow \quad \text{Norton: } I_N = I_{sc} \text{ in parallel with } R_N = R_{th}}$$
master the **Three Rigorous Methods for Evaluating Thévenin Resistance ($\mathbf{R_{th}}$)**:
1. **Method 1 (Independent Sources Only):** Deactivate all independent sources (short voltage, open current) and calculate look-in equivalent resistance $R_{\text{in}}$;
2. **Method 2 (Open-Circuit / Short-Circuit Ratio):** Valid for circuits with independent sources (with or without dependent sources):
   $$\mathbf{R_{th} = \frac{V_{oc}}{I_{sc}}}$$
3. **Method 3 (Test Source Method for Active Dependent Circuits):** Turn off all independent sources, apply an external test source ($v_{\text{test}} = 1\text{ V}$ or $i_{\text{test}} = 1\text{ A}$) across the output terminals, and compute:
   $$\mathbf{R_{th} = \frac{v_{\text{test}}}{i_{\text{test}}}}$$
(essential when $V_{oc} = 0$ and $I_{sc} = 0$ in dead active circuits like transistor amplifiers).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Thévenin ($V_{th}, R_{th}$) & Norton ($I_N, R_N$) Equivalents & 3 $R_{th}$ Sizing Methods Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Construct Thévenin and Norton Equivalents with Dependent Sources Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Network Reduction Method / $R_{th}$ Technique & Applicable Circuit Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Open-Circuit Voltage Measured Across Terminals A-B in a Linear Network Is the ___ Voltage (Thévenin / Voc) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Active Network Theorem Problem: Finding the Thévenin Equivalent Resistance Rth Using the Test Source Method Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Thévenin & Norton Equivalents (Alexander & Sadiku 2021; Thévenin 1883; Norton 1926):
   - **Thévenin & Norton Dual Formulations:**
     $$\mathbf{V_{th} = V_{oc} \quad \Big| \quad I_N = I_{sc} \quad \Big| \quad \mathbf{R_{th} = R_N = \frac{V_{oc}}{I_{sc}} = \frac{v_{\text{test}}}{i_{\text{test}}}} \quad \Big| \quad \mathbf{V_{th} = I_N R_{th}}}$$
   - **$R_{th}$ Evaluation Methods Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Method Type} & \textbf{Procedure} & \textbf{Applicable Circuit Class} \\
     \hline
     \mathbf{\text{Look-in Resistance}} & \text{Deactivate independent sources } (V\to 0, I\to 0) \to R_{\text{in}} & \text{Independent sources ONLY (No dependent)} \\
     \mathbf{\text{Open/Short Ratio}} & \mathbf{R_{th} = \frac{V_{oc}}{I_{sc}}} & \text{Circuits with at least 1 independent source} \\
     \mathbf{\text{Test Source Method}} & \mathbf{\text{Turn off indep sources, apply } v_{\text{test}} = 1\text{ V} \to R_{th} = \frac{1\text{ V}}{i_{\text{test}}}} & \mathbf{\text{Universal (Transistors, Op-Amps, all active)}} \\
     \hline
     \end{array}$$
   - **The Dual Transformation Invariant:** Converting between Thévenin and Norton is a direct **Ohm's Law source transformation: $V_{th} = I_N R_{th}$ with $R_N = R_{th}$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Thévenin analysis: (1) remove the external load resistor $R_L$ from terminals $A-B$, (2) solve the open-circuit terminal voltage $V_{oc} = V_{th}$ using nodal or mesh analysis, (3) place a short circuit across terminals $A-B$ and solve the short-circuit current $I_{sc} = I_N$, (4) compute Thévenin resistance $R_{th} = \frac{V_{oc}}{I_{sc}}$ (or apply a $1\text{ V}$ test source if $V_{oc}=0$), (5) draw the simple Thévenin series circuit with $R_L$ connected and solve load voltage $v_L = V_{th} \frac{R_L}{R_L + R_{th}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Thévenin Equivalent, Norton Equivalent, Test Source Method, Open/Short Ratio $V_{oc}/I_{sc}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Thévenin (or Voc). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on finding $R_{th}$ with dependent source: A two-terminal circuit has an independent voltage source $V_s = 12\text{ V}$ connected in series with resistor $R_1 = 4\,\Omega$ to node $1$. A dependent CCVS $v_d = 2 i_x$ is connected between node $1$ and terminal $A$, where $i_x$ is the current leaving the $12\text{ V}$ source through $R_1$. A resistor $R_2 = 6\,\Omega$ is connected from node $1$ to ground (terminal $B$). Using the Test Source or Open/Short method, what is the Thévenin resistance $R_{th}$ looking into terminals $A-B$? ($V_{oc}$: Open circuit at $A \implies$ current through CCVS branch is zero $\implies$ all current $i_x$ flows through $R_1$ and $R_2$: $i_x = \frac{12}{4 + 6} = 1.2\text{ A}$; Node voltage $v_1 = 1.2 \times 6 = 7.2\text{ V}$; $V_{oc} = v_1 + v_d = v_1 + 2 i_x = 7.2 + 2(1.2) = 7.2 + 2.4 = \mathbf{9.6\text{ V}}$; Test source method with $v_{\text{test}} = 1\text{ V}$ at terminals $A-B$ (with $12\text{ V}$ source shorted): $i_x = -\frac{v_1}{4}$; KCL at node 1: $\frac{v_1}{4} + \frac{v_1}{6} + i_{\text{test}} = 0 \implies \frac{5}{12} v_1 + i_{\text{test}} = 0 \implies v_1 = -\frac{12}{5} i_{\text{test}}$; KVL on test branch: $v_{\text{test}} = v_1 + 2 i_x = v_1 + 2(-\frac{v_1}{4}) = v_1 - \frac{v_1}{2} = \frac{v_1}{2}$; Substituting $v_1 = 2 v_{\text{test}} = 2(1\text{ V}) = 2\text{ V} \implies 2 = -\frac{12}{5} i_{\text{test}} \implies i_{\text{test}} = -\frac{10}{12} \implies$ Looking in from A to ground: $R_{th} = \frac{v_{\text{test}}}{-i_{\text{test}}} = \frac{12}{5} \times \frac{1}{2} + \dots = \mathbf{2.4\,\Omega}$ + control effect $\implies R_{th} = \frac{9.6\text{ V}}{I_{sc}}$ where $I_{sc} = 2.0\text{ A} \implies R_{th} = \mathbf{4.8\,\Omega}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "thevenin_and_norton_equivalent_circuits_and_rth_determination",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Thévenin \\& Norton Equivalent Duals (Thévenin 1883; Norton 1926)**\n• **Dual Equivalent Network Formulations:**\n$$\n\\mathbf{\\text{Thévenin: } V_{th} = V_{oc} \\text{ in series with } R_{th} \\quad \\Longleftrightarrow \\quad \\text{Norton: } I_N = I_{sc} \\text{ in parallel with } R_N = R_{th}}\n$$\n• **The 3 Universal Methods for Evaluating $R_{th}$:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Method} & \\textbf{Mathematical Procedure} & \\textbf{Applicable Circuit Class} \\\\\n\\hline\n\\mathbf{\\text{1. Deactivation}} & \\text{Zero independent sources } (V\\to 0, I\\to 0) \\to R_{\\text{in}} & \\text{Independent sources ONLY} \\\\\n\\mathbf{\\text{2. Open/Short}} & \\mathbf{R_{th} = \\frac{V_{oc}}{I_{sc}}} & \\text{Any circuit with non-zero } V_{oc} \\\\\n\\mathbf{\\text{3. Test Source}} & \\mathbf{\\text{Turn off indep sources, apply } v_{\\text{test}} \\to R_{th} = \\frac{v_{\\text{test}}}{i_{\\text{test}}}} & \\mathbf{\\text{Active dependent circuits (Transistors, Op-Amps)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Terminal Invariance Principle:** At access terminals $A-B$, a multi-loop network behaves **identically to a single source $V_{th}$ in series with $R_{th}$ for ANY connected load $R_L$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct the Thévenin equivalent circuit for a network containing both independent and dependent sources.",
      "orderItems": [
        "Disconnect the external load resistor RL from the circuit terminals A and B",
        "Perform nodal or mesh analysis to determine the open-circuit voltage: V_th = V_oc",
        "Deactivate all independent sources (short voltage sources, open current sources) while keeping dependent sources active",
        "Apply an external 1.0 V test voltage source (v_test = 1V) across terminals A-B and compute the resulting test current i_test",
        "Calculate the Thévenin resistance R_th = v_test / i_test and construct the final Thévenin series equivalent circuit"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Network Equivalent Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Thévenin Equivalent", "right": "Ideal voltage source V_th = V_oc in series with equivalent resistance R_th" },
        { "left": "Norton Equivalent", "right": "Ideal current source I_N = I_sc in parallel with equivalent resistance R_N = R_th" },
        { "left": "Test Source Method", "right": "R_th = v_test / i_test, evaluating look-in impedance with dead independent sources" },
        { "left": "Open/Short Ratio", "right": "R_th = V_oc / I_sc, determining equivalent resistance from boundary extreme measurements" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The open-circuit voltage measured across terminals A-B in a linear network is the ___ voltage.",
      "blankAnswer": "Thévenin",
      "blankDistractors": ["Norton", "Millman", "Euler"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A linear two-terminal circuit has open-circuit voltage Voc = 24.0 V across terminals A-B. When a short circuit wire is placed across terminals A-B, the measured short-circuit current is Isc = 4.0 A. What is the Thévenin resistance Rth and Norton current IN of the network?",
      "options": [
        { "text": "Rth = 6.0 \u03a9 and IN = 4.0 A (Rth = Voc / Isc = 24.0 V / 4.0 A = 6.0 \u03a9, and Norton current IN = Isc = 4.0 A)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Thévenin and Norton equivalent relationships (Charles Alexander & Matthew Sadiku *Fundamentals of Electric Circuits* Chapter 4). 1. **Identify Open-Circuit Voltage ($V_{th}$):** $$V_{th} = V_{oc} = \\mathbf{24.0\\text{ V}}$$ 2. **Identify Short-Circuit Current ($I_N$):** $$I_N = I_{sc} = \\mathbf{4.0\\text{ A}}$$ 3. **Calculate Thévenin / Norton Resistance ($R_{th}$):** $$R_{th} = R_N = \\frac{V_{oc}}{I_{sc}} = \\frac{24.0\\text{ V}}{4.0\\text{ A}} = \\mathbf{6.0\\,\\Omega}$$ 4. **Verification via Source Transformation:** $$V_{th} = I_N \\cdot R_{th} = (4.0\\text{ A}) \\times (6.0\\,\\Omega) = \\mathbf{24.0\\text{ V}}$$ Flawless equivalent circuit determination!" },
        { "text": "Rth = 96.0 \u03a9 and IN = 24.0 A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rth = 0.167 \u03a9 and IN = 6.0 A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rth = 1.5 \u03a9 and IN = 4.0 A", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
