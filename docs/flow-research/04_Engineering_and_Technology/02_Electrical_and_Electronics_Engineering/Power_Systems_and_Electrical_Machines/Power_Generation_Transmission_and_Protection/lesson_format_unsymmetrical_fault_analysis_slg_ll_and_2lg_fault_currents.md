# Duofy Reusable Lesson Format: Fault Analysis (SLG, L-L, & 2LG Sequence Topologies)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Power_Generation_Transmission_and_Protection`  
**Lesson Format Type:** `unsymmetrical_fault_analysis_slg_ll_and_2lg_fault_currents`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through symmetrical components analysis applied to power system short-circuit faults, Sequence Network Interconnections (Series for Single Line-to-Ground $\text{SLG}$, Parallel for Line-to-Line $\text{L-L}$ and Double Line-to-Ground $\text{2LG}$), Thevenin sequence impedances ($Z_1, Z_2, Z_0$), fault impedance ($Z_f$), and short-circuit MVA calculations in grid protection engineering (Hadi Saadat *Power System Analysis* Chapter 10 & 11; J. Duncan Glover *Power System Analysis and Design* Chapter 9): formulate the **Four Canonical Fault Interconnection Theorems**:
1. **Three-Phase Symmetrical Fault (3LG / L-L-L):**
   $$\mathbf{I_f = I_{a1} = \frac{V_f}{Z_1 + Z_f} \quad (I_{a2} = 0, \ I_{a0} = 0)}$$
2. **Single Line-to-Ground Fault (SLG - Phase A to Ground):**
   - **Sequence Network Topology:** Positive, Negative, and Zero sequence networks connected in **SERIES**:
     $$\mathbf{I_{a0} = I_{a1} = I_{a2} = \frac{V_f}{Z_1 + Z_2 + Z_0 + 3 Z_f} \implies \mathbf{I_{\text{fault}} = I_a = 3 I_{a1} = \frac{3 V_f}{Z_1 + Z_2 + Z_0 + 3 Z_f}}}$$
3. **Line-to-Line Fault (L-L - Phase B to Phase C):**
   - **Sequence Network Topology:** Positive and Negative sequence networks in **PARALLEL** ($I_{a0} = 0$):
     $$\mathbf{I_{a1} = -I_{a2} = \frac{V_f}{Z_1 + Z_2 + Z_f} \implies \mathbf{I_{\text{fault}} = |I_b| = \sqrt{3} |I_{a1}| = \frac{\sqrt{3} V_f}{Z_1 + Z_2 + Z_f}}}$$
4. **Double Line-to-Ground Fault (2LG - Phases B & C to Ground):**
   - **Sequence Network Topology:** Positive, Negative, and Zero sequence networks in **PARALLEL**:
     $$\mathbf{I_{a1} = \frac{V_f}{Z_1 + \frac{Z_2 (Z_0 + 3 Z_f)}{Z_2 + Z_0 + 3 Z_f}} \implies \mathbf{I_{\text{ground}} = 3 I_{a0}}}$$
(analyzing why the Single Line-to-Ground fault constitutes over $70\%$ of all real power system faults and can produce short-circuit currents that exceed symmetrical three-phase fault currents when zero-sequence impedance $Z_0$ is low).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fault Topologies, SLG Series Interconnection ($I_f = \frac{3 V_f}{Z_1+Z_2+Z_0+3Z_f}$) & L-L Parallel Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Short-Circuit Current for a Single Line-to-Ground Fault Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Power System Fault Type / Sequence Topology & Mathematical Current Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Single Line-to-Ground Fault Analysis, the Sequence Networks (Positive, Negative, and Zero) Are Connected in ___ (Series) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Power Substation Problem: Calculating SLG Fault Current in Amperes for a 13.8kV Generator Bus Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Unsymmetrical Fault Analysis (Saadat 2010; Glover 2016):
   - **Fault Current Formulations:**
     $$\mathbf{I_{\text{SLG}} = \frac{3 V_f}{Z_1 + Z_2 + Z_0 + 3 Z_f} \quad \Big| \quad I_{\text{L-L}} = \frac{\sqrt{3} V_f}{Z_1 + Z_2 + Z_f} \quad \Big| \quad I_{\text{3}\phi} = \frac{V_f}{Z_1}}$$
   - **Sequence Network Interconnection Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Fault Classification} & \textbf{Statistical Frequency} & \textbf{Sequence Network Connection} & \textbf{Key Boundary Condition} \\
     \hline
     \mathbf{\text{Single Line-to-Ground (SLG)}} & \mathbf{70\% \ (\text{Most Common})} & \mathbf{\text{All 3 Networks in SERIES}} & \mathbf{I_{a0} = I_{a1} = I_{a2}} \\
     \mathbf{\text{Line-to-Line (L-L)}} & 15\% & \text{Positive } \parallel \text{ Negative } (Z_1 \parallel Z_2) & I_{a0} = 0, \ I_{a1} = -I_{a2} \\
     \mathbf{\text{Double Line-to-Ground (2LG)}} & 10\% & \text{All 3 Networks in PARALLEL} & V_{a0} = V_{a1} = V_{a2} \\
     \mathbf{\text{3-Phase Symmetrical (3LG)}} & 5\% \ (\text{Most Severe}) & \text{Positive Sequence Only } (Z_1) & I_{a2} = 0, \ I_{a0} = 0 \\
     \hline
     \end{array}$$
   - **The Ground Multiplier Invariant:** In an SLG fault, ground return current passes all three sequence currents ($I_{a0} + I_{a1} + I_{a2} = 3 I_{a1}$); this causes any physical fault impedance $Z_f$ to appear as **$3 Z_f$ in the sequence loop**!
2. **Slide 2 (`ordering`):** Provide 5 steps of SLG fault computation: (1) determine pre-fault per-phase voltage $V_f$ and Thevenin sequence impedances $Z_1, Z_2, Z_0$ at the fault bus, (2) connect positive, negative, and zero sequence networks in a single closed series loop, (3) calculate symmetrical sequence current $I_{a1} = \frac{V_f}{Z_1 + Z_2 + Z_0 + 3 Z_f}$, (4) compute total physical phase-A fault current $I_f = 3 I_{a1}$, (5) convert per-unit fault current to actual kiloamperes ($I_{\text{kA}} = I_{\text{pu}} \times I_{\text{base}}$) and verify circuit breaker interrupting capacity!
3. **Slide 3 (`matching`):** Pair 4 concepts (SLG Fault Series Connection, L-L Fault Parallel Connection, 3-Phase Symmetrical Fault, Fault Impedance Multiplier $3Z_f$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Series. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating SLG fault current: A $13.8\text{ kV}$ (line-to-line), $50\text{ MVA}$ generator bus experiences a solid ($Z_f = 0$) Single Line-to-Ground (SLG) fault. Pre-fault voltage is $V_f = 1.0\angle 0^\circ\text{ pu}$. The Thevenin sequence impedances are $Z_1 = j 0.20\text{ pu}, \ Z_2 = j 0.15\text{ pu}, \ Z_0 = j 0.05\text{ pu}$. What is the per-unit fault current $I_{f,\text{pu}}$ and the actual fault current in kiloamperes ($I_{f,\text{kA}}$)? ($I_{\text{base}} = \frac{S_{\text{base}}}{\sqrt{3} V_{\text{base}}} = \frac{50\text{ MVA}}{\sqrt{3} \times 13.8\text{ kV}} = \frac{50,000}{23.902} = \mathbf{2091.8\text{ A} = 2.092\text{ kA}}$; $Z_{\text{total}} = Z_1 + Z_2 + Z_0 = j(0.20 + 0.15 + 0.05) = j 0.40\text{ pu}$; $I_{a1} = \frac{V_f}{Z_{\text{total}}} = \frac{1.0}{j 0.40} = -j 2.50\text{ pu}$; $I_{f,\text{pu}} = 3 I_{a1} = 3 \times (-j 2.50) = \mathbf{-j 7.50\text{ pu} \ (7.50\text{ pu magnitude})}$; $I_{f,\text{kA}} = 7.50 \times 2.0918\text{ kA} = \mathbf{15.689\text{ kA} \approx 15.69\text{ kA}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "unsymmetrical_fault_analysis_slg_ll_and_2lg_fault_currents",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Unsymmetrical Fault Sequence Topologies (Hadi Saadat)**\n• **Single Line-to-Ground (SLG) Fault Sequence Formulation:**\n$$\n\\mathbf{I_{a0} = I_{a1} = I_{a2} = \\frac{V_f}{Z_1 + Z_2 + Z_0 + 3 Z_f} \\implies \\mathbf{I_{\\text{fault}} = 3 I_{a1} = \\frac{3 V_f}{Z_1 + Z_2 + Z_0 + 3 Z_f}}}\n$$\n• **Line-to-Line (L-L) Fault Formulation ($I_{a0} = 0$):**\n$$\n\\mathbf{I_{a1} = -I_{a2} = \\frac{V_f}{Z_1 + Z_2 + Z_f} \\implies \\mathbf{I_{\\text{fault}} = \\sqrt{3} |I_{a1}| = \\frac{\\sqrt{3} V_f}{Z_1 + Z_2 + Z_f}}}\n$$\n• **The Sequence Interconnection Rules:**\n  - **SLG Fault:** Positive, Negative, and Zero sequence networks connect in **SERIES**;\n  - **L-L Fault:** Positive and Negative sequence networks connect in **PARALLEL** ($Z_0$ isolated);\n  - **2LG Fault:** Positive, Negative, and Zero sequence networks connect in **PARALLEL**;\n• **The 3Zf Multiplier Invariant:** In an SLG fault, ground return current carries all 3 sequence components ($3 I_{a1}$), forcing physical ground fault impedance to scale by **$3 Z_f$ in the sequence loop**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to compute the short-circuit fault current for a Single Line-to-Ground (SLG) fault on a power system bus.",
      "orderItems": [
        "Determine the pre-fault per-phase voltage Vf and Thevenin sequence impedances Z1, Z2, and Z0 at the fault bus",
        "Connect the Positive, Negative, and Zero sequence networks in a single continuous series circuit",
        "Compute the symmetrical sequence current: Ia1 = Vf / (Z1 + Z2 + Z0 + 3*Zf)",
        "Calculate the total per-unit physical phase fault current: I_fault,pu = 3 * Ia1",
        "Multiply by base current I_base = S_base / (\u221a3 * V_base) to obtain the physical fault current in kiloamperes (kA)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fault Classification to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Single Line-to-Ground (SLG)", "right": "All 3 sequence networks in SERIES: If = 3*Vf / (Z1 + Z2 + Z0 + 3Zf), accounting for 70% of all grid faults" },
        { "left": "Line-to-Line (L-L)", "right": "Positive and Negative networks in PARALLEL (Ia0 = 0): If = \u221a3*Vf / (Z1 + Z2 + Zf)" },
        { "left": "3-Phase Symmetrical (3LG)", "right": "Positive sequence network ONLY: If = Vf / Z1, standard benchmark for maximum breaker MVA sizing" },
        { "left": "Ground Impedance Term (3Zf)", "right": "Tripled fault impedance factor resulting from ground return carrying In = 3*Ia0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Single Line-to-Ground fault analysis, the positive, negative, and zero sequence networks are connected in ___.",
      "blankAnswer": "series",
      "blankDistractors": ["parallel", "delta", "quadrature"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 13.8 kV, 50 MVA generator bus (I_base = 2.092 kA) experiences a solid (Zf = 0) SLG fault with pre-fault voltage Vf = 1.0\u22200\u00b0 pu. Sequence impedances are Z1 = j0.20 pu, Z2 = j0.15 pu, and Z0 = j0.05 pu. What is the per-unit fault current and actual fault current in kiloamperes?",
      "options": [
        { "text": "I_fault,pu = 7.50 pu and I_fault,kA = 15.69 kA (Z_total = j(0.20+0.15+0.05) = j0.40 pu; Ia1 = 1.0 / j0.40 = -j2.50 pu; I_fault = 3*Ia1 = 7.50 pu; I_fault,kA = 7.50 * 2.092 kA = 15.69 kA)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using symmetrical components SLG fault equations (Hadi Saadat *Power System Analysis* Chapter 10). 1. **Calculate Base Current ($I_{\\text{base}}$):** $$I_{\\text{base}} = \\frac{S_{\\text{base}}}{\\sqrt{3} \\times V_{\\text{base}}} = \\frac{50,000\\text{ kVA}}{\\sqrt{3} \\times 13.8\\text{ kV}} = \\frac{50,000}{23.9023} = \\mathbf{2091.85\\text{ A} = 2.09185\\text{ kA}}$$ 2. **Calculate Total Series Sequence Loop Impedance ($Z_{\\text{total}}$):** - For an SLG fault with solid ground ($Z_f = 0$): $$Z_{\\text{total}} = Z_1 + Z_2 + Z_0 + 3 Z_f = j 0.20 + j 0.15 + j 0.05 + 0 = \\mathbf{j 0.40\\text{ pu}}$$ 3. **Calculate Sequence Current ($I_{a1}$):** $$I_{a1} = \\frac{V_f}{Z_{\\text{total}}} = \\frac{1.0\\angle 0^\\circ}{j 0.40} = \\mathbf{-j 2.50\\text{ pu} = 2.50\\angle -90^\\circ\\text{ pu}}$$ 4. **Calculate Total Physical Phase A Fault Current ($I_{\\text{fault}}$):** - In an SLG fault, $I_{a0} = I_{a1} = I_{a2}$: $$I_{\\text{fault,pu}} = I_a = I_{a0} + I_{a1} + I_{a2} = 3 I_{a1} = 3 \\times 2.50\\text{ pu} = \\mathbf{7.50\\text{ pu}}$$ 5. **Convert Per-Unit Current to Kiloamperes:** $$I_{\\text{fault,kA}} = I_{\\text{fault,pu}} \\times I_{\\text{base}} = 7.50 \\times 2.09185\\text{ kA} = \\mathbf{15.6889\\text{ kA} \\approx 15.69\\text{ kA}}$$ Flawless power system SLG fault calculation!" },
        { "text": "I_fault,pu = 2.50 pu and I_fault,kA = 5.23 kA (Forgot factor of 3)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "I_fault,pu = 5.00 pu and I_fault,kA = 10.46 kA", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "I_fault,pu = 15.0 pu and I_fault,kA = 31.38 kA", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
