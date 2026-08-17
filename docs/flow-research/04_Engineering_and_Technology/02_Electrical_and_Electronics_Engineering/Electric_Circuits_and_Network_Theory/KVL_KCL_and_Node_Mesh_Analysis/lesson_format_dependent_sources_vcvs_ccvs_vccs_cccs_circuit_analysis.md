# Duofy Reusable Lesson Format: Controlled Sources (VCVS, CCVS, VCCS, & CCCS Topologies)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / KVL_KCL_and_Node_Mesh_Analysis`  
**Lesson Format Type:** `dependent_sources_vcvs_ccvs_vccs_cccs_circuit_analysis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through active electronic device modeling (transistors, operational amplifiers, Small-Signal Hybrid-$\pi$ equivalents), controlled source topologies, and matrix augmentation in nodal and mesh analysis (Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 3; James W. Nilsson & Susan A. Riedel *Electric Circuits* Chapter 4): classify the **Four Fundamental Controlled Source Topologies**:
1. **VCVS ($\mathbf{v_d = \mu v_x}$):** Voltage-Controlled Voltage Source (dimensionless voltage gain $\mu$, Op-Amp model);
2. **CCVS ($\mathbf{v_d = r i_x}$):** Current-Controlled Voltage Source (transresistance gain $r$ in $\text{V/A}$ or $\Omega$);
3. **VCCS ($\mathbf{i_d = g_m v_x}$):** Voltage-Controlled Current Source (transconductance gain $g_m$ in $\text{A/V}$ or $\text{S}$, MOSFET/BJT small-signal model);
4. **CCCS ($\mathbf{i_d = \beta i_x}$):** Current-Controlled Current Source (dimensionless current gain $\beta$, BJT forward active mode model);
master the **Controlling Variable Substitution Method**: express the controlling variable ($v_x$ or $i_x$) strictly in terms of the primary circuit unknowns (node voltages $[V]$ or mesh currents $[I]$), and substitute into the KCL/KVL equations to eliminate extra variables while preserving standard matrix solvability.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 4 Controlled Source Models (VCVS, CCVS, VCCS, CCCS) & Controlling Variable Substitution Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Formulate and Solve Nodal Equations with Dependent Sources Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Controlled Source Topology / Gain Parameter & Technical Physical Dimension Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Controlled Current Source Whose Output Current Is Linearly Proportional to an Input Control Voltage Is a ___ Source (VCCS / Transconductance) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Active Circuit Analysis Problem: Calculating the Output Node Voltage with a VCCS Transconductance Element Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Dependent Sources (Alexander & Sadiku 2021; Nilsson 2020):
   - **4 Controlled Sources Formulations:**
     $$\mathbf{\text{VCVS: } v_d = \mu v_x \quad \Big| \quad \text{CCVS: } v_d = r i_x \quad \Big| \quad \text{VCCS: } i_d = g_m v_x \quad \Big| \quad \text{CCCS: } i_d = \beta i_x}$$
   - **Dependent Source Matrix Integration:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Source Type} & \textbf{Symbol} & \textbf{Gain Parameter Dimension} & \textbf{Electronic Device Equivalent} \\
     \hline
     \mathbf{\text{VCVS}} & v_d = \mu v_x & \text{Dimensionless (Voltage Gain } A_v) & \text{Ideal Operational Amplifier} \\
     \mathbf{\text{CCVS}} & v_d = r i_x & \text{Transresistance } r \ (\Omega \text{ or V/A}) & \text{Current-to-Voltage Converter} \\
     \mathbf{\text{VCCS}} & i_d = g_m v_x & \mathbf{\text{Transconductance } g_m \ (\text{Siemens S or A/V})} & \mathbf{\text{MOSFET / BJT Transconductance}} \\
     \mathbf{\text{CCCS}} & i_d = \beta i_x & \text{Dimensionless (Current Gain } \beta = h_{fe}) & \text{BJT Active Mode Collector Model} \\
     \hline
     \end{array}$$
   - **The Controlling Variable Invariant:** Always rewrite the control variable ($v_x$ or $i_x$) **strictly in terms of the primary system state variables (node voltages or mesh currents)** before matrix assembly!
2. **Slide 2 (`ordering`):** Provide 5 steps of dependent source circuit analysis: (1) label primary node voltages or mesh currents, (2) write the controlling variable ($v_x$ or $i_x$) in terms of these primary unknowns (e.g. $v_x = v_1 - v_2$ or $i_x = \frac{v_1 - 0}{R}$), (3) write standard KCL / KVL equations treating the dependent source as a standard source, (4) substitute the controlling expression directly into the equations to replace all dependent terms, (5) group like terms to form the augmented linear system and solve!
3. **Slide 3 (`matching`):** Pair 4 concepts (VCVS, CCVS Transresistance, VCCS Transconductance $g_m$, CCCS Current Gain $\beta$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of VCCS (or Transconductance). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on solving circuit with VCCS: A circuit has an independent current source $I_{\text{in}} = 4\text{ A}$ entering node $1$. Node $1$ is connected to ground through $R_1 = 4\,\Omega$ and to node $2$ through $R_2 = 2\,\Omega$. A VCCS dependent current source connects from node $2$ to ground, drawing current $i_d = 2 v_x$ away from node $2$, where control voltage $v_x$ is the voltage across $R_1$ ($v_x = v_1$). Resistor $R_3 = 4\,\Omega$ connects node $2$ to ground. What is node voltage $v_1$ and $v_2$? (KCL at node 1: $\frac{v_1}{4} + \frac{v_1 - v_2}{2} = 4 \implies v_1 + 2(v_1 - v_2) = 16 \implies 3 v_1 - 2 v_2 = 16$; KCL at node 2: $\frac{v_2 - v_1}{2} + \frac{v_2}{4} + 2 v_1 = 0 \implies 2(v_2 - v_1) + v_2 + 8 v_1 = 0 \implies 6 v_1 + 3 v_2 = 0 \implies v_2 = -2 v_1$; Substitute: $3 v_1 - 2(-2 v_1) = 16 \implies 3 v_1 + 4 v_1 = 16 \implies 7 v_1 = 16 \implies \mathbf{v_1 = \frac{16}{7}\text{ V} \approx 2.29\text{ V}}$; $v_2 = -2(\frac{16}{7}) = \mathbf{-\frac{32}{7}\text{ V} \approx -4.57\text{ V}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dependent_sources_vcvs_ccvs_vccs_cccs_circuit_analysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Dependent Sources \\& Active Network Analysis (Alexander \\& Sadiku)**\n• **The 4 Fundamental Controlled Source Topologies:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Controlled Topology} & \\textbf{Constitutive Law} & \\textbf{Gain Dimension} & \\textbf{Electronic Circuit Model} \\\\\n\\hline\n\\mathbf{\\text{VCVS}} & v_d = \\mu \\cdot v_x & \\text{Dimensionless (V/V)} & \\text{Ideal Operational Amplifier} \\\\\n\\mathbf{\\text{CCVS}} & v_d = r \\cdot i_x & \\text{Transresistance } (\\Omega = \\text{V/A}) & \\text{Transimpedance Preamplifier} \\\\\n\\mathbf{\\text{VCCS}} & i_d = g_m \\cdot v_x & \\mathbf{\\text{Transconductance } (\\text{S} = \\text{A/V})} & \\mathbf{\\text{MOSFET / BJT Small-Signal Model}} \\\\\n\\mathbf{\\text{CCCS}} & i_d = \\beta \\cdot i_x & \\text{Dimensionless (A/A)} & \\text{BJT Active Collector Current } \\beta i_B \\\\\n\\hline\n\\end{array}\n$$\n• **Controlling Variable Substitution Strategy:**\n  - Express the control variable ($v_x$ or $i_x$) strictly in terms of primary node voltages $[V]$ or mesh currents $[I]$;\n  - Substitute into the KCL/KVL equations to eliminate auxiliary variables;\n• **The Non-Symmetry Invariant:** Dependent sources introduce non-symmetrical off-diagonal terms ($G_{jk} \\ne G_{kj}$), reflecting unilateral active amplification!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform Nodal Analysis on an active transistor circuit containing dependent sources.",
      "orderItems": [
        "Label all essential node voltages (v1, v2, ..., vn) referenced to a common ground datum (v_ref = 0 V)",
        "Express the controlling variable (e.g. control voltage v_x or current i_x) purely in terms of unknown node voltages",
        "Formulate standard Kirchhoff's Current Law (KCL) equations at all non-reference nodes treating dependent sources as current injections",
        "Substitute the controlling variable expressions directly into the KCL equations to eliminate auxiliary variables",
        "Group like node voltage terms to construct the linear matrix system [G][V] = [I] and solve"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Controlled Source Type to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "VCVS (Voltage-Controlled Voltage)", "right": "vd = \u03bc * vx, source producing an output voltage proportional to an input controlling voltage" },
        { "left": "VCCS (Transconductance)", "right": "id = gm * vx, source generating an output current proportional to an input control voltage" },
        { "left": "CCCS (Current Gain)", "right": "id = \u03b2 * ix, active source amplifying an input branch current by a dimensionless gain factor" },
        { "left": "CCVS (Transresistance)", "right": "vd = r * ix, active source converting an input controlling current into a proportional output voltage" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A controlled source whose output current is linearly proportional to an input control voltage is a ___ source.",
      "blankAnswer": "VCCS",
      "blankDistractors": ["VCVS", "CCVS", "CCCS"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A circuit has an independent current source I_in = 4 A entering node 1. Node 1 connects to ground through R1 = 4 \u03a9 and to node 2 through R2 = 2 \u03a9. A VCCS draws current id = 2*vx away from node 2 to ground, where control voltage vx = v1 (across R1). Resistor R3 = 4 \u03a9 connects node 2 to ground. What is node voltage v1?",
      "options": [
        { "text": "v1 = 2.29 V (16/7 V) and v2 = -4.57 V (-32/7 V) (KCL at node 1: 3*v1 - 2*v2 = 16; KCL at node 2: 6*v1 + 3*v2 = 0 \u2192 v2 = -2*v1; substituting gives 7*v1 = 16 \u2192 v1 = 16/7 V)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Nodal Analysis with dependent source substitution (Charles Alexander & Matthew Sadiku *Fundamentals of Electric Circuits* Chapter 3). 1. **Control Variable Expression:** $$v_x = v_1$$ 2. **Formulate KCL at Node 1:** $$\\frac{v_1}{R_1} + \\frac{v_1 - v_2}{R_2} = I_{\\text{in}}$$ $$\\frac{v_1}{4} + \\frac{v_1 - v_2}{2} = 4$$ - Multiply by 4: $$v_1 + 2(v_1 - v_2) = 16 \\implies \\mathbf{3 v_1 - 2 v_2 = 16} \\quad \\text{--- (Eq. 1)}$$ 3. **Formulate KCL at Node 2:** $$\\frac{v_2 - v_1}{R_2} + \\frac{v_2}{R_3} + i_d = 0$$ $$\\frac{v_2 - v_1}{2} + \\frac{v_2}{4} + 2 v_1 = 0$$ - Multiply by 4: $$2(v_2 - v_1) + v_2 + 8 v_1 = 0$$ $$-2 v_1 + 8 v_1 + 2 v_2 + v_2 = 0 \\implies 6 v_1 + 3 v_2 = 0 \\implies \\mathbf{v_2 = -2 v_1} \\quad \\text{--- (Eq. 2)}$$ 4. **Substitute Eq. 2 into Eq. 1:** $$3 v_1 - 2(-2 v_1) = 16$$ $$3 v_1 + 4 v_1 = 16 \\implies 7 v_1 = 16 \\implies \\mathbf{v_1 = \\frac{16}{7}\\text{ V} \\approx 2.2857\\text{ V} \\approx 2.29\\text{ V}}$$ 5. **Calculate $v_2$:** $$v_2 = -2 v_1 = -2 \\left(\\frac{16}{7}\\right) = \\mathbf{-\\frac{32}{7}\\text{ V} \\approx -4.57\\text{ V}}$$ Flawless active dependent source solution!" },
        { "text": "v1 = 4.00 V and v2 = -8.00 V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v1 = 1.60 V and v2 = -3.20 V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v1 = 5.33 V and v2 = 2.67 V", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
