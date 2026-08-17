# Duofy Reusable Lesson Format: Transformer Testing (OC/SC Tests & Equivalent Circuit)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Single_Phase_and_Three_Phase_Transformers`  
**Lesson Format Type:** `transformer_equivalent_circuit_open_and_short_circuit_tests`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the real physical model of power transformers, primary/secondary winding copper resistances ($R_1, R_2$), magnetic leakage reactances ($X_1, X_2$), core excitation shunt branch ($R_c, X_m$), and the standard experimental parameter extraction protocols: the Open-Circuit ($\text{OC}$) Test and Short-Circuit ($\text{SC}$) Test (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 2; A. E. Fitzgerald *Electric Machinery* Chapter 2): formulate the **Open-Circuit Test (Rated Voltage on Low-Voltage Winding, High-Voltage Open)**:
$$\mathbf{P_{oc} \approx P_{\text{core}} = P_h + P_e \quad \Big| \quad \mathbf{\cos\theta_{oc} = \frac{P_{oc}}{V_{oc} I_{oc}}} \implies \mathbf{R_c = \frac{V_{oc}^2}{P_{oc}}} \quad \Big| \quad \mathbf{X_m = \frac{V_{oc}}{I_{oc} \sin\theta_{oc}} = \frac{V_{oc}}{\sqrt{I_{oc}^2 - (P_{oc}/V_{oc})^2}}}}$$
formulate the **Short-Circuit Test (Rated Current on High-Voltage Winding, Low-Voltage Shorted)**:
$$\mathbf{P_{sc} \approx P_{cu,\text{fl}} = I_{sc}^2 R_{eq} \quad \Big| \quad \mathbf{Z_{eq} = \frac{V_{sc}}{I_{sc}}} \implies \mathbf{R_{eq} = \frac{P_{sc}}{I_{sc}^2}} \quad \Big| \quad \mathbf{X_{eq} = \sqrt{Z_{eq}^2 - R_{eq}^2}}}$$
and derive the **Turns Ratio ($a = N_1 / N_2$) Impedance Reflection Rules**:
$$\mathbf{R_{eq1} = R_1 + a^2 R_2 \quad \Big| \quad X_{eq1} = X_1 + a^2 X_2 \quad \Big| \quad Z_{eq1} = a^2 Z_{eq2}}$$
(proving why open-circuit measurements isolate core losses at negligible copper loss, while short-circuit measurements isolate winding losses at negligible core excitation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Real Transformer Model, OC Test ($R_c = \frac{V_{oc}^2}{P_{oc}}$) & SC Test ($R_{eq} = \frac{P_{sc}}{I_{sc}^2}, X_{eq} = \sqrt{Z^2-R^2}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Extract Equivalent Circuit Parameters from Experimental OC/SC Data Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Transformer Test / Equivalent Circuit Branch & Technical Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Standard Transformer Test Performed at Rated Current with Reduced Voltage to Determine Winding Copper Losses Is the ___-Circuit Test (Short / SC) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Power Electrical Problem: Calculating Rc, Xm, Req, and Xeq from a 50 kVA Transformer Test Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Transformer Tests & Equivalent Circuit (Chapman 2012; Fitzgerald 2013):
   - **OC & SC Formulations:**
     $$\mathbf{R_c = \frac{V_{oc}^2}{P_{oc}} \quad \Big| \quad X_m = \frac{V_{oc}}{\sqrt{I_{oc}^2 - I_c^2}} \quad \Big| \quad R_{eq} = \frac{P_{sc}}{I_{sc}^2} \quad \Big| \quad Z_{eq} = \frac{V_{sc}}{I_{sc}} \quad \Big| \quad X_{eq} = \sqrt{Z_{eq}^2 - R_{eq}^2}}$$
   - **Test Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Test Name} & \textbf{Applied Excitation} & \textbf{Winding Setup} & \textbf{Parameters Extracted} \\
     \hline
     \mathbf{\text{Open-Circuit (OC)}} & \mathbf{\text{Rated Voltage } V_{\text{rated}}} & \text{Applied to LV side, HV open} & \mathbf{\text{Shunt Core Branch: } R_c, X_m \ (P_{\text{core}} = P_{oc})} \\
     \mathbf{\text{Short-Circuit (SC)}} & \mathbf{\text{Rated Current } I_{\text{rated}}} & \text{Applied to HV side, LV shorted} & \mathbf{\text{Series Winding: } R_{eq}, X_{eq} \ (P_{cu,\text{fl}} = P_{sc})} \\
     \hline
     \end{array}$$
   - **The Test Physics Invariant:** During the OC test, current is tiny ($2-5\%$ of rated), making winding $I^2 R$ loss negligible; during the SC test, applied voltage is tiny ($3-8\%$ of rated), making core $\text{loss} \propto V^2$ completely negligible!
2. **Slide 2 (`ordering`):** Provide 5 steps of parameter extraction: (1) read OC test measurements ($V_{oc}, I_{oc}, P_{oc}$) on LV winding, (2) compute open-circuit core resistance $R_c = V_{oc}^2 / P_{oc}$ and magnetizing reactance $X_m$, (3) read SC test measurements ($V_{sc}, I_{sc}, P_{sc}$) on HV winding, (4) compute equivalent series resistance $R_{eq} = P_{sc} / I_{sc}^2$ and total impedance $Z_{eq} = V_{sc} / I_{sc}$, (5) compute series leakage reactance $X_{eq} = \sqrt{Z_{eq}^2 - R_{eq}^2}$ and reflect parameters across turns ratio $a$ as required!
3. **Slide 3 (`matching`):** Pair 4 concepts (Core Loss Resistance $R_c$, Magnetizing Reactance $X_m$, Equivalent Series Resistance $R_{eq}$, Leakage Reactance $X_{eq}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Short (or SC). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating transformer parameters: A $20\text{ kVA}, \ 8000/240\text{ V}, \ 60\text{ Hz}$ single-phase transformer is tested. The Short-Circuit (SC) test performed on the high-voltage side yields: $V_{sc} = 400\text{ V}, \ I_{sc} = 2.50\text{ A}\text{ (rated HV current)}, \ P_{sc} = 300\text{ W}$. What is the equivalent series resistance $R_{eq,\text{HV}}$, total series impedance $Z_{eq,\text{HV}}$, and leakage reactance $X_{eq,\text{HV}}$ referred to the high-voltage winding? ($Z_{eq,\text{HV}} = \frac{V_{sc}}{I_{sc}} = \frac{400\text{ V}}{2.50\text{ A}} = \mathbf{160.0\ \Omega}$; $R_{eq,\text{HV}} = \frac{P_{sc}}{I_{sc}^2} = \frac{300\text{ W}}{(2.50\text{ A})^2} = \frac{300}{6.25} = \mathbf{48.0\ \Omega}$; $X_{eq,\text{HV}} = \sqrt{Z_{eq}^2 - R_{eq}^2} = \sqrt{160^2 - 48^2} = \sqrt{25600 - 2304} = \sqrt{23296} \approx \mathbf{152.63\ \Omega \approx 152.6\ \Omega}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "transformer_equivalent_circuit_open_and_short_circuit_tests",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Transformer Equivalent Circuit \\& Test Extraction (Stephen Chapman)**\n• **Open-Circuit (OC) Test Formulations (Rated Voltage on LV Side, HV Open):**\n$$\n\\mathbf{P_{oc} = P_{\\text{core}} \\quad \\Big| \\quad \\mathbf{R_c = \\frac{V_{oc}^2}{P_{oc}}} \\quad \\Big| \\quad \\mathbf{X_m = \\frac{V_{oc}}{\\sqrt{I_{oc}^2 - (P_{oc}/V_{oc})^2}}}}\n$$\n• **Short-Circuit (SC) Test Formulations (Rated Current on HV Side, LV Shorted):**\n$$\n\\mathbf{P_{sc} = P_{cu,\\text{fl}} \\quad \\Big| \\quad \\mathbf{Z_{eq} = \\frac{V_{sc}}{I_{sc}}} \\quad \\Big| \\quad \\mathbf{R_{eq} = \\frac{P_{sc}}{I_{sc}^2}} \\quad \\Big| \\quad \\mathbf{X_{eq} = \\sqrt{Z_{eq}^2 - R_{eq}^2}}}\n$$\n• **Turns Ratio ($a = N_1 / N_2$) Impedance Scaling:**\n$$\n\\mathbf{R_{eq1} = a^2 R_{eq2} \\quad \\Big| \\quad X_{eq1} = a^2 X_{eq2} \\quad \\Big| \\quad Z_{eq1} = a^2 Z_{eq2}}\n$$\n• **The Test Decoupling Invariant:** In the OC test, current is $2-5\\%$ rated, making winding $I^2 R$ losses negligible; in the SC test, applied voltage is $3-8\\%$ rated, making core loss $\\propto V^2$ completely negligible!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to extract real transformer equivalent circuit parameters from Open-Circuit and Short-Circuit test data.",
      "orderItems": [
        "Record Open-Circuit test data (Voc, Ioc, Poc) measured at rated voltage on the Low-Voltage winding",
        "Compute core loss shunt resistance: Rc = Voc^2 / Poc and magnetizing reactance Xm = Voc / Im",
        "Record Short-Circuit test data (Vsc, Isc, Psc) measured at rated current on the High-Voltage winding",
        "Compute total series equivalent resistance Req = Psc / Isc^2 and total series impedance Zeq = Vsc / Isc",
        "Compute series leakage reactance Xeq = \u221a(Zeq^2 - Req^2) and reflect all parameters to the desired reference side"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Transformer Test Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Core Resistance (Rc)", "right": "Rc = Voc^2 / Poc, shunt resistance modeling magnetic core hysteresis and eddy current iron losses" },
        { "left": "Magnetizing Reactance (Xm)", "right": "Xm = Voc / Im, shunt reactance modeling magnetic flux permeability in the iron core" },
        { "left": "Equivalent Resistance (Req)", "right": "Req = Psc / Isc^2, combined primary and reflected secondary winding copper ohmic resistance" },
        { "left": "Leakage Reactance (Xeq)", "right": "Xeq = \u221a(Zeq^2 - Req^2), series reactance modeling leakage flux paths that fail to link both windings" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The standard transformer test performed at rated current with reduced voltage to determine winding copper losses is the ___-circuit test.",
      "blankAnswer": "short",
      "blankDistractors": ["open", "ground", "delta"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 20 kVA, 8000/240 V, 60 Hz single-phase transformer is subjected to a Short-Circuit test on its HV side: Vsc = 400 V, Isc = 2.50 A (rated HV current), and Psc = 300 W. What is Req,HV, Zeq,HV, and Xeq,HV referred to the HV side?",
      "options": [
        { "text": "Zeq,HV = 160.0 \u03a9, Req,HV = 48.0 \u03a9, and Xeq,HV = 152.6 \u03a9 (Zeq = 400/2.5 = 160.0 \u03a9; Req = 300 / 2.5^2 = 48.0 \u03a9; Xeq = \u221a(160^2 - 48^2) = \u221a(25600 - 2304) = 152.63 \u03a9)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Short-Circuit test formulas (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 2). 1. **Calculate Total Series Impedance ($Z_{eq,\\text{HV}}$):** $$Z_{eq,\\text{HV}} = \\frac{V_{sc}}{I_{sc}} = \\frac{400.0\\text{ V}}{2.50\\text{ A}} = \\mathbf{160.0\\ \\Omega}$$ 2. **Calculate Equivalent Series Resistance ($R_{eq,\\text{HV}}$):** $$R_{eq,\\text{HV}} = \\frac{P_{sc}}{I_{sc}^2} = \\frac{300.0\\text{ W}}{(2.50\\text{ A})^2} = \\frac{300.0}{6.25} = \\mathbf{48.0\\ \\Omega}$$ 3. **Calculate Series Leakage Reactance ($X_{eq,\\text{HV}}$):** $$X_{eq,\\text{HV}} = \\sqrt{Z_{eq,\\text{HV}}^2 - R_{eq,\\text{HV}}^2} = \\sqrt{(160.0)^2 - (48.0)^2} = \\sqrt{25600 - 2304} = \\sqrt{23296} = \\mathbf{152.63\\ \\Omega \\approx 152.6\\ \\Omega}$$ 4. **Physical Sanity Check:** In high-voltage power transformers, leakage reactance $X_{eq}$ is typically $3\\times$ to $5\\times$ larger than winding resistance $R_{eq}$ because of high magnetic flux leakage paths! Flawless parameter extraction calculation!" },
        { "text": "Zeq,HV = 160.0 \u03a9, Req,HV = 120.0 \u03a9, and Xeq,HV = 105.8 \u03a9", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Zeq,HV = 80.0 \u03a9, Req,HV = 48.0 \u03a9, and Xeq,HV = 64.0 \u03a9", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Zeq,HV = 160.0 \u03a9, Req,HV = 152.6 \u03a9, and Xeq,HV = 48.0 \u03a9", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
