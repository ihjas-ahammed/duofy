# Duofy Reusable Lesson Format: Otto Cycle (Spark-Ignition and Compression Ratio)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Thermodynamics_and_Heat_Transfer / Thermodynamic_Cycles_Rankine_Otto_Diesel`  
**Lesson Format Type:** `air_standard_otto_cycle_compression_ratio_and_spark_ignition`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through air-standard internal combustion models, spark-ignition kinematics, and isochoric combustion in automotive petrol engines (Nikolaus Otto 1876; Yunus A. Çengel, Michael A. Boles, Mehmet Kanoğlu *Thermodynamics: An Engineering Approach* Chapter 9): master the **Four Thermodynamic Processes of the Ideal Otto Cycle**: (1) Process 1-2: Isentropic Compression ($s_1 = s_2, \frac{T_2}{T_1} = r^{k-1}$), (2) Process 2-3: Constant-Volume (Isochoric) Heat Addition ($v_2 = v_3, q_{\text{in}} = c_v(T_3 - T_2)$), (3) Process 3-4: Isentropic Power Expansion ($s_3 = s_4, \frac{T_4}{T_3} = \frac{1}{r^{k-1}}$), and (4) Process 4-1: Constant-Volume Heat Rejection ($v_4 = v_1, q_{\text{out}} = c_v(T_4 - T_1)$); derive the **Air-Standard Otto Thermal Efficiency Formula**:
$$\mathbf{\eta_{\text{th,Otto}} = 1 - \frac{1}{r^{k - 1}} \quad \left(r = \frac{V_{\text{max}}}{V_{\text{min}}} = \frac{V_1}{V_2}, \ k = \frac{c_p}{c_v} \approx 1.4\right)}$$
and analyze the engineering upper ceiling on compression ratio ($r \approx 8 - 11$) imposed by premature autoignition (engine knocking).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ideal Otto Cycle ($P-v$ & $T-s$ Coordinates) & Air-Standard Efficiency Formula Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Progression Through the 4 Otto Cycle Strokes and Thermodynamic States Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Otto Cycle Thermodynamic Process / Parameter & Exact Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Ideal Air-Standard Otto Cycle, Heat Addition Occurs at Constant ___ (Volume / Isochoric) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Thermodynamics Problem: Calculating the Thermal Efficiency of an Otto Engine with Compression Ratio r = 8 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Otto Cycle (Çengel & Boles 2019; Otto 1876):
   - **Otto Cycle Formulation:**
     $$\mathbf{\eta_{\text{th,Otto}} = 1 - \frac{q_{\text{out}}}{q_{\text{in}}} = 1 - \frac{c_v(T_4 - T_1)}{c_v(T_3 - T_2)} = 1 - \frac{1}{r^{k - 1}} \quad \left(r = \frac{V_1}{V_2}, \ k = 1.4\right)}$$
   - **Process Breakdown Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{State Path} & \textbf{Thermodynamic Process} & \textbf{Mechanical Action} & \textbf{Governing Energy Equation} \\
     \hline
     \mathbf{1 \to 2} & \mathbf{\text{Isentropic Compression}} & \text{Piston moves BDC } \to \text{ TDC} & T_2 = T_1 \cdot r^{k-1}, \ w_{\text{in}} = c_v(T_2 - T_1) \\
     \mathbf{2 \to 3} & \mathbf{\text{Isochoric Heat Addition}} & \text{Spark plug fires instantaneously} & \mathbf{q_{\text{in}} = c_v(T_3 - T_2) \ (v = \text{Constant})} \\
     \mathbf{3 \to 4} & \mathbf{\text{Isentropic Expansion}} & \text{Power stroke: TDC } \to \text{ BDC} & T_4 = T_3 / r^{k-1}, \ w_{\text{out}} = c_v(T_3 - T_4) \\
     \mathbf{4 \to 1} & \mathbf{\text{Isochoric Heat Rejection}} & \text{Exhaust blowdown} & \mathbf{q_{\text{out}} = c_v(T_4 - T_1) \ (v = \text{Constant})} \\
     \hline
     \end{array}$$
   - **Knocking Invariant:** Compressing beyond $r \approx 11$ raises unburned fuel mixture temperature above autoignition temperature, causing violent detonation (knocking)!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Otto cycle: (1) intake air-fuel mixture is compressed isentropically as piston rises from Bottom Dead Center (BDC) to Top Dead Center (TDC), (2) spark plug fires at TDC, adding heat $q_{\text{in}}$ at constant volume as pressure spikes rapidly, (3) high-pressure combustion gas expands isentropically, forcing piston down from TDC to BDC during the power stroke, (4) exhaust valve opens at BDC, rejecting waste heat $q_{\text{out}}$ at constant volume as cylinder pressure drops to atmospheric, (5) cycle resets as piston exhausts burned gas and draws in a fresh charge!
3. **Slide 3 (`matching`):** Pair 4 concepts (Compression Ratio $r$, Isochoric Heat Addition, Isentropic Compression, Engine Knocking) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Volume. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Otto thermal efficiency: An ideal air-standard Otto engine operates with a compression ratio of $r = 8.0$. Assuming a specific heat ratio $k = 1.4$ for air ($8^{0.4} \approx 2.2974$), what is the theoretical thermal efficiency $\eta_{\text{th,Otto}}$ of the engine? ($\eta_{\text{th,Otto}} = 1 - \frac{1}{r^{k-1}} = 1 - \frac{1}{8^{1.4 - 1}} = 1 - \frac{1}{8^{0.4}} = 1 - \frac{1}{2.2974} = 1 - 0.43528 = 0.56472 \approx \mathbf{56.47\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "air_standard_otto_cycle_compression_ratio_and_spark_ignition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Air-Standard Otto Cycle \\& Compression Ratio (Nikolaus Otto 1876)**\n• **Air-Standard Thermal Efficiency Formulation:**\n$$\n\\mathbf{\\eta_{\\text{th,Otto}} = 1 - \\frac{q_{\\text{out}}}{q_{\\text{in}}} = 1 - \\frac{1}{r^{k - 1}} \\quad \\left(r = \\frac{V_1}{V_2} = \\frac{V_{\\text{max}}}{V_{\\text{min}}}, \\ k = \\frac{c_p}{c_v} \\approx 1.4\\right)}\n$$\n• **The 4 Thermodynamic Process Stages:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{State Path} & \\textbf{Thermodynamic Process} & \\textbf{Cylinder Mechanism} & \\textbf{Governing Equation} \\\\\n\\hline\n\\mathbf{1 \\to 2} & \\mathbf{\\text{Isentropic Compression}} & \\text{Piston travels BDC } \\to \\text{ TDC} & T_2 = T_1 \\cdot r^{k - 1} \\\\\n\\mathbf{2 \\to 3} & \\mathbf{\\text{Isochoric Heat Addition}} & \\mathbf{\\text{Spark plug fires (Constant Volume)}} & \\mathbf{q_{\\text{in}} = c_v (T_3 - T_2)} \\\\\n\\mathbf{3 \\to 4} & \\mathbf{\\text{Isentropic Expansion}} & \\text{Power stroke: TDC } \\to \\text{ BDC} & T_4 = T_3 / r^{k - 1} \\\\\n\\mathbf{4 \\to 1} & \\mathbf{\\text{Isochoric Heat Rejection}} & \\text{Exhaust blowdown (Constant Volume)} & \\mathbf{q_{\\text{out}} = c_v (T_4 - T_1)} \\\\\n\\hline\n\\end{array}\n$$\n• **The Autoignition Knock Limit:** Efficiency increases monotonically with $r$, but petrol engines are limited to $\\mathbf{r \\approx 8 - 11}$ to prevent spontaneous detonation (engine knocking)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential thermodynamic processes comprising the four stages of the ideal air-standard Otto cycle.",
      "orderItems": [
        "Isentropic Compression (1->2): Working air is compressed reversibly and adiabatically as piston moves from BDC to TDC",
        "Isochoric Heat Addition (2->3): Spark ignition adds heat q_in instantaneously at constant cylinder volume (v = Constant)",
        "Isentropic Expansion (3->4): High-pressure combustion gas expands doing boundary work during the power stroke (TDC to BDC)",
        "Isochoric Heat Rejection (4->1): Heat q_out is rejected instantaneously at constant cylinder volume (v = Constant)",
        "Air completes the closed thermodynamic loop, returning to initial state 1 (P1, V1, T1) for the next cycle"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Otto Cycle Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Compression Ratio (r)", "right": "r = V_max / V_min = V_BDC / V_TDC, the primary geometric determinant of cycle efficiency" },
        { "left": "Isochoric Heat Addition", "right": "q_in = c_v * (T3 - T2), modeling instantaneous spark combustion at constant volume" },
        { "left": "Engine Knocking", "right": "Uncontrolled explosive autoignition of end-gas caused by excessively high compression ratios" },
        { "left": "Isentropic Expansion", "right": "w_out = c_v * (T3 - T4), extracting useful shaft work as gas expands adiabatically" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the ideal air-standard Otto cycle, heat addition from combustion occurs at constant ___.",
      "blankAnswer": "volume",
      "blankDistractors": ["pressure", "temperature", "entropy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An ideal air-standard Otto engine operates with a compression ratio of r = 8.0. Assuming a specific heat ratio k = 1.4 for air (with 8^0.4 = 2.2974), what is the theoretical thermal efficiency of the Otto engine?",
      "options": [
        { "text": "\u03b7_Otto = 56.47%", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the air-standard Otto cycle thermal efficiency equation (Çengel & Boles *Thermodynamics: An Engineering Approach* Chapter 9). 1. **Otto Thermal Efficiency Formula:** $$\\eta_{\\text{th,Otto}} = 1 - \\frac{1}{r^{k - 1}}$$ 2. **Substitute $r = 8.0$ and $k = 1.4$:** $$r^{k - 1} = 8^{1.4 - 1} = 8^{0.4} = 2.2974$$ $$\\eta_{\\text{th,Otto}} = 1 - \\frac{1}{2.2974} = 1 - 0.435275 = 0.564725 = \\mathbf{56.47\\%}$$ 3. **Physical Significance:** Under ideal air-standard assumptions, an engine with $r=8$ converts $56.47\\%$ of fuel heat into mechanical piston work, while rejecting the remaining $43.53\\%$ through the exhaust!" },
        { "text": "\u03b7_Otto = 43.53%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b7_Otto = 80.00%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b7_Otto = 25.00%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
