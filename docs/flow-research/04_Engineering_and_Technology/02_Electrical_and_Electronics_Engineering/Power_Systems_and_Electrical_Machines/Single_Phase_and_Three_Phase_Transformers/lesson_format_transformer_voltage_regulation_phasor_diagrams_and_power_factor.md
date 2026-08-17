# Duofy Reusable Lesson Format: Voltage Regulation (Phasor Diagrams & Load Power Factor)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Single_Phase_and_Three_Phase_Transformers`  
**Lesson Format Type:** `transformer_voltage_regulation_phasor_diagrams_and_power_factor`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through transformer secondary terminal voltage variations between no-load ($V_{nl}$) and full-load ($V_{fl}$), phasor diagram derivations for lagging (inductive), unity, and leading (capacitive) load power factors, and the exact/approximate percentage Voltage Regulation ($\text{VR}$) formulations in power distribution engineering (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 2; A. E. Fitzgerald *Electric Machinery* Chapter 2): formulate the **Exact Definition of Percentage Voltage Regulation**:
$$\mathbf{\text{VR} = \frac{|V_{nl}| - |V_{fl}|}{|V_{fl}|} \times 100\% = \frac{|V_1 / a| - |V_{2,fl}|}{|V_{2,fl}|} \times 100\%}$$
derive the **Approximate Voltage Regulation Equation (Referred to Secondary Side)**:
$$\mathbf{\text{VR} \approx \frac{I_2 (R_{eq2} \cos\theta_2 \pm X_{eq2} \sin\theta_2)}{V_{2,fl}} \times 100\%}$$
master the **Power Factor Phasor Regimes**:
1. **Lagging Power Factor ($\mathbf{+}$ Sign, Inductive Loads: Motors, Inductors):**
   $$\mathbf{\text{VR} > 0 \implies |V_{2,fl}| < |V_{nl}|} \quad (\text{Terminal voltage drops under load});$$
2. **Unity Power Factor ($\cos\theta_2 = 1.0, \ \sin\theta_2 = 0$):**
   $$\mathbf{\text{VR} \approx \frac{I_2 R_{eq2}}{V_{2,fl}} \times 100\% > 0};$$
3. **Leading Power Factor ($\mathbf{-}$ Sign, Capacitive Loads / Long Cables):**
   $$\mathbf{\text{VR} < 0 \implies |V_{2,fl}| > |V_{nl}|} \quad (\text{Terminal voltage RISES under load, Ferranti effect!});$$
derive the **Zero Voltage Regulation Condition ($\mathbf{\text{VR} = 0\%}$)**:
$$\mathbf{R_{eq2} \cos\theta_2 = X_{eq2} \sin\theta_2 \implies \tan\theta_2 = \frac{R_{eq2}}{X_{eq2}} \quad (\text{Leading Power Factor})}$$
$$\mathbf{\cos\theta_{2,\text{zero VR}} = \frac{X_{eq2}}{\sqrt{R_{eq2}^2 + X_{eq2}^2}} \quad (\text{Leading})}$$
(proving why capacitive compensation banks can be adjusted to achieve perfect $0.00\%$ voltage regulation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Voltage Regulation ($\text{VR} \approx \frac{I_2 (R_{eq2}\cos\theta_2 \pm X_{eq2}\sin\theta_2)}{V_2}$), Lagging vs Leading Phasors Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Voltage Regulation for Lagging and Leading Loads Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Load Power Factor Regime / Operating Condition & Voltage Regulation Phenotype Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | When Supplying a Purely Capacitive Leading Power Factor Load, the Transformer Full-Load Voltage Exceeds the No-Load Voltage, Resulting in a ___ Percentage Voltage Regulation (Negative / <0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Power Grid Problem: Calculating Voltage Regulation for a 50 kVA Transformer at 0.8 Lagging vs 0.8 Leading PF Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Voltage Regulation & Power Factor (Chapman 2012; Fitzgerald 2013):
   - **Voltage Regulation Formulations:**
     $$\mathbf{\text{VR} = \frac{V_{nl} - V_{fl}}{V_{fl}} \times 100\% \quad \Big| \quad \text{VR} \approx \frac{I_2 (R_{eq2} \cos\theta_2 \pm X_{eq2} \sin\theta_2)}{V_2} \times 100\% \quad \Big| \quad \cos\theta_{\text{zero VR}} = \frac{X_{eq}}{\sqrt{R_{eq}^2 + X_{eq}^2}}}$$
   - **Load Regime Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Load Type} & \textbf{Power Factor} & \textbf{VR Formula Sign} & \textbf{Terminal Voltage Behavior} \\
     \hline
     \mathbf{\text{Inductive Load}} & \text{Lagging } (\cos\theta) & \mathbf{+ \text{ Sign: } (R\cos\theta + X\sin\theta)} & \mathbf{\text{Positive VR: Voltage sags/drops under load}} \\
     \mathbf{\text{Resistive Load}} & \text{Unity } (1.0) & R_{eq2} \text{ drop only} & \text{Slight positive VR} \\
     \mathbf{\text{Capacitive Load}} & \mathbf{\text{Leading } (\cos\theta)} & \mathbf{- \text{ Sign: } (R\cos\theta - X\sin\theta)} & \mathbf{\text{Negative VR: Voltage RISES above no-load}} \\
     \hline
     \end{array}$$
   - **The Negative VR Invariant:** In a leading capacitive load, if $X_{eq2}\sin\theta_2 > R_{eq2}\cos\theta_2$, the voltage regulation becomes **strictly negative ($\text{VR} < 0$)**, delivering higher voltage under load than at no load!
2. **Slide 2 (`ordering`):** Provide 5 steps of VR calculation: (1) calculate secondary rated current $I_{2,\text{fl}} = S_{\text{rated}} / V_{2,\text{rated}}$, (2) calculate power factor angle $\theta_2 = \arccos(\text{PF})$ and evaluate $\cos\theta_2$ and $\sin\theta_2$, (3) assign algebraic sign ($+$ for lagging PF, $-$ for leading PF), (4) calculate internal impedance voltage drop $\Delta V = I_2 (R_{eq2}\cos\theta_2 \pm X_{eq2}\sin\theta_2)$, (5) divide by nominal rated voltage $V_{2,\text{fl}}$ and multiply by $100\%$ to obtain percentage Voltage Regulation!
3. **Slide 3 (`matching`):** Pair 4 concepts (Lagging Power Factor VR, Leading Power Factor VR, Zero Voltage Regulation Condition, No-Load Voltage $V_{nl}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Negative (or <0). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating voltage regulation: A $15\text{ kVA}, \ 2400/240\text{ V}$ distribution transformer has equivalent series resistance $R_{eq2} = 0.040\ \Omega$ and leakage reactance $X_{eq2} = 0.120\ \Omega$ referred to the secondary side. What is the approximate percentage Voltage Regulation when operating at rated full load with a power factor of $0.80\text{ lagging}$? ($I_{2,\text{fl}} = \frac{15000\text{ VA}}{240\text{ V}} = \mathbf{62.5\text{ A}}$; $\cos\theta_2 = 0.80 \implies \sin\theta_2 = 0.60$; $\Delta V = I_2 (R_{eq2}\cos\theta_2 + X_{eq2}\sin\theta_2) = 62.5 \times [(0.040)(0.80) + (0.120)(0.60)] = 62.5 \times [0.032 + 0.072] = 62.5 \times 0.104\text{ V} = \mathbf{6.50\text{ V}}$; $\text{VR} = \frac{6.50\text{ V}}{240.0\text{ V}} \times 100\% = \mathbf{2.708\% \approx 2.71\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "transformer_voltage_regulation_phasor_diagrams_and_power_factor",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Transformer Voltage Regulation \\& Load Power Factor (Stephen Chapman)**\n• **Exact Voltage Regulation Definition:**\n$$\n\\mathbf{\\text{VR} = \\frac{|V_{nl}| - |V_{fl}|}{|V_{fl}|} \\times 100\\% = \\frac{|V_1 / a| - |V_{2,fl}|}{|V_{2,fl}|} \\times 100\\%}\n$$\n• **Approximate Voltage Regulation Formulation (Secondary Referred):**\n$$\n\\mathbf{\\text{VR} \\approx \\frac{I_2 (R_{eq2} \\cos\\theta_2 \\pm X_{eq2} \\sin\\theta_2)}{V_{2,fl}} \\times 100\\%}\n$$\n  - **$\\mathbf{+}$ Sign (Lagging / Inductive Load):** Voltage sags under load $\\implies \\mathbf{\\text{VR} > 0\\%}$;\n  - **$\\mathbf{-}$ Sign (Leading / Capacitive Load):** Voltage rises under load $\\implies \\mathbf{\\text{VR} < 0\\%}$ (Ferranti effect!);\n• **Zero Voltage Regulation Condition ($\\text{VR} = 0\\%$):**\n$$\n\\mathbf{\\tan\\theta_{2,\\text{zero}} = \\frac{R_{eq2}}{X_{eq2}} \\implies \\mathbf{\\cos\\theta_{2,\\text{zero}} = \\frac{X_{eq2}}{\\sqrt{R_{eq2}^2 + X_{eq2}^2}} \\quad (\\text{Leading Power Factor})}}\n$$\n• **The Negative VR Invariant:** With leading capacitive loads, secondary terminal voltage at full load **exceeds the no-load voltage**, generating a strictly negative voltage regulation percentage!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the percentage Voltage Regulation of a power transformer for a specified load power factor.",
      "orderItems": [
        "Calculate the rated secondary load current: I2_rated = S_rated / V2_rated",
        "Determine the load power factor angle: \u03b82 = arccos(PF) and evaluate cos(\u03b82) and sin(\u03b82)",
        "Select the appropriate algebraic sign: plus (+) for lagging inductive load, or minus (-) for leading capacitive load",
        "Compute the internal impedance voltage drop: \u0394V = I2 * (Req2 * cos \u03b82 \u00b1 Xeq2 * sin \u03b82)",
        "Divide the voltage drop by rated secondary voltage and multiply by 100%: VR = (\u0394V / V2_rated) * 100%"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Voltage Regulation Condition to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Lagging Power Factor (Inductive)", "right": "\u0394V = I2*(Req*cos\u03b8 + Xeq*sin\u03b8), positive VR representing terminal voltage sag under heavy motor loads" },
        { "left": "Leading Power Factor (Capacitive)", "right": "\u0394V = I2*(Req*cos\u03b8 - Xeq*sin\u03b8), negative VR representing terminal voltage rise under capacitive loads" },
        { "left": "Zero Voltage Regulation (\u0394V = 0)", "right": "tan\u03b8 = Req / Xeq (Leading), perfect voltage balance where capacitive reactive rise cancels resistive drop" },
        { "left": "Unity Power Factor (PF = 1.0)", "right": "\u0394V = I2*Req, voltage drop governed exclusively by winding copper resistance" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When supplying a purely capacitive leading power factor load, the transformer full-load voltage exceeds no-load voltage, resulting in a ___ voltage regulation.",
      "blankAnswer": "negative",
      "blankDistractors": ["positive", "infinite", "unity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 15 kVA, 2400/240 V single-phase transformer has Req2 = 0.040 \u03a9 and Xeq2 = 0.120 \u03a9 referred to the 240 V secondary. What is the approximate percentage Voltage Regulation at rated full load with a power factor of 0.80 lagging?",
      "options": [
        { "text": "VR = 2.71% (I2 = 15000/240 = 62.5 A; cos\u03b8 = 0.8, sin\u03b8 = 0.6; \u0394V = 62.5 * [0.040(0.8) + 0.120(0.6)] = 62.5 * 0.104 = 6.50 V; VR = (6.50 / 240) * 100% = 2.708%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the approximate Voltage Regulation formula (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 2). 1. **Calculate Full-Load Secondary Current ($I_2$):** $$I_2 = \\frac{S_{\\text{rated}}}{V_{2,\\text{rated}}} = \\frac{15,000\\text{ VA}}{240\\text{ V}} = \\mathbf{62.5\\text{ A}}$$ 2. **Calculate Trigonometric Components for $0.80\\text{ Lagging PF}$:** - $$\\cos\\theta_2 = 0.80$$ - $$\\sin\\theta_2 = \\sqrt{1 - (0.80)^2} = \\sqrt{0.36} = 0.60$$ 3. **Calculate Internal Series Voltage Drop ($\\Delta V$):** - Since load is **lagging**, we use the **$+$ sign**: $$\\Delta V = I_2 \\left( R_{eq2} \\cos\\theta_2 + X_{eq2} \\sin\\theta_2 \\right)$$ $$\\Delta V = 62.5\\text{ A} \\times \\left[ (0.040\\ \\Omega)(0.80) + (0.120\\ \\Omega)(0.60) \\right]$$ $$\\Delta V = 62.5 \\times \\left[ 0.032 + 0.072 \\right] = 62.5 \\times 0.104\\text{ V} = \\mathbf{6.50\\text{ V}}$$ 4. **Calculate Percentage Voltage Regulation (VR):** $$\\text{VR} = \\frac{\\Delta V}{V_{2,\\text{rated}}} \\times 100\\% = \\frac{6.50\\text{ V}}{240.0\\text{ V}} \\times 100\\% = \\mathbf{2.7083\\% \\approx 2.71\\%}$$ Flawless voltage regulation calculation!" },
        { "text": "VR = 1.04%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "VR = 5.42%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "VR = -2.71% (Applied leading formula instead of lagging)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
