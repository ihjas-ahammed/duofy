# Duofy Reusable Lesson Format: Diode Modeling (Shockley Equation & Small-Signal Resistance)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / Diode_Circuits_and_Rectifiers`  
**Lesson Format Type:** `shockley_diode_models_constant_voltage_drop_and_small_signal_resistance`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through semiconductor p-n junction physics, the Shockley exponential current equation, thermal voltage ($V_T$), the hierarchy of diode modeling approximations (Ideal, Constant Voltage Drop CVD, Piecewise Linear), and small-signal dynamic AC resistance ($r_d$) in analog electronics (William Shockley 1949; Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 4; Robert L. Boylestad Chapter 1): formulate the **Shockley Diode Equation**:
$$\mathbf{I_D = I_S \left( e^{\frac{V_D}{n V_T}} - 1 \right) \quad \left(V_T = \frac{k T}{q} = \frac{(1.38 \times 10^{-23})(300)}{1.602 \times 10^{-19}} \approx 25.85\text{ mV} \approx 26\text{ mV at } 300\text{ K}\right)}$$
master the **Four Diode Modeling Approximations**:
1. **Ideal Diode:** $V_D = 0\text{ V}$ when forward biased ($I_D > 0$), $I_D = 0\text{ A}$ when reverse biased ($V_D < 0$);
2. **Constant Voltage Drop (CVD):** $V_D = V_\gamma \approx 0.7\text{ V}$ (Silicon), $0.3\text{ V}$ (Germanium), $0.2\text{ V}$ (Schottky) when conducting;
3. **Piecewise Linear:** $V_D = V_\gamma + I_D r_d$;
4. **Small-Signal Dynamic Incremental Resistance ($\mathbf{r_d}$)**:
   $$\mathbf{r_d = \left( \left. \frac{d I_D}{d V_D} \right|_{V_D = V_{DQ}} \right)^{-1} = \frac{n V_T}{I_{DQ} + I_S} \approx \mathbf{\frac{n V_T}{I_{DQ}} \approx \frac{26\text{ mV}}{I_{DQ}}}}$$
(proving that dynamic AC resistance varies inversely with DC quiescent bias current $I_{DQ}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Shockley Equation ($I_D = I_S e^{V_D/nV_T}$), CVD Model ($V_\gamma = 0.7\text{V}$) & AC Resistance ($r_d = \frac{26\text{mV}}{I_{DQ}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Perform Small-Signal Diode Circuit Analysis Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Diode Model Hierarchy / Physical Parameter & Technical Analytical Application Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Room Temperature (300 K) Thermal Voltage VT in the Shockley Diode Equation Is Approximately ___ Millivolts (26 / 25.85) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analog Electronics Problem: Calculating the Small-Signal Dynamic Resistance rd and AC Output Voltage Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Diode Modeling & Dynamic Resistance (Sedra & Smith 2020; Shockley 1949):
   - **Shockley & Dynamic Resistance Formulations:**
     $$\mathbf{I_D = I_S \left( e^{\frac{V_D}{n V_T}} - 1 \right) \quad \Big| \quad V_T = \frac{k T}{q} \approx 26\text{ mV} \quad \Big| \quad \mathbf{r_d = \frac{n V_T}{I_{DQ}} \approx \frac{26\text{ mV}}{I_{DQ}}}}$$
   - **Diode Model Spectrum Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Model Name} & \textbf{Forward Condition } (I_D > 0) & \textbf{Reverse Condition } (V_D < 0) & \textbf{Best Used For} \\
     \hline
     \mathbf{\text{Ideal Model}} & V_D = 0.0\text{ V} \ (R_{\text{on}} = 0\,\Omega) & I_D = 0.0\text{ A} \ (R_{\text{off}} = \infty) & \text{High-voltage power rectifiers } (V \gg 10\text{V}) \\
     \mathbf{\text{CVD Model}} & \mathbf{V_D = 0.7\text{ V (Silicon)}} & I_D = 0.0\text{ A} & \mathbf{\text{Standard DC circuit bias analysis}} \\
     \mathbf{\text{Small-Signal AC}} & \mathbf{\text{Replaced by resistor } r_d = \frac{26\text{mV}}{I_{DQ}}} & \text{Junction capacitance } C_j & \mathbf{\text{Small AC signal amplification/attenuation}} \\
     \hline
     \end{array}$$
   - **The Thermal Invariant:** Thermal voltage $V_T = \frac{kT}{q}$ is strictly proportional to absolute temperature in Kelvin ($T = 300\text{ K} \implies V_T \approx 25.85\text{ mV} \approx \mathbf{26\text{ mV}}$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of small-signal diode analysis: (1) deactivate all AC signal sources and solve DC circuit using Constant Voltage Drop model ($V_D = 0.7\text{ V}$) to find DC quiescent current $I_{DQ}$, (2) calculate small-signal incremental resistance $r_d = \frac{n V_T}{I_{DQ}} \approx \frac{26\text{ mV}}{I_{DQ}}$, (3) deactivate DC bias supply sources (replace DC voltage sources with AC ground), (4) replace the diode with its small-signal equivalent linear resistance $r_d$, (5) analyze linear AC circuit to calculate AC output voltage $v_o(t) = v_{\text{ac}}(t) \frac{r_d}{R + r_d}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Shockley Equation, CVD Model $0.7\text{ V}$, Dynamic Resistance $r_d = 26\text{ mV}/I_{DQ}$, Thermal Voltage $V_T$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 26 (or 25.85). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on small-signal analysis: A silicon diode ($n = 1$) is biased with a DC voltage source $V_{DC} = 5.0\text{ V}$ in series with resistor $R = 2.15\text{ k}\Omega = 2150\,\Omega$. Using the CVD model ($V_D = 0.7\text{ V}$), what is the DC bias current $I_{DQ}$, the small-signal dynamic resistance $r_d$, and the resulting AC output voltage peak $v_{o,\text{peak}}$ across the diode when an AC voltage $v_{\text{ac}}(t) = 100\text{ mV}_{\text{peak}} \cos(\omega t)$ is superimposed in series? ($I_{DQ} = \frac{V_{DC} - V_D}{R} = \frac{5.0 - 0.7}{2150} = \frac{4.3}{2150} = 0.0020\text{ A} = \mathbf{2.0\text{ mA}}$; $r_d = \frac{V_T}{I_{DQ}} = \frac{26\text{ mV}}{2.0\text{ mA}} = \mathbf{13.0\,\Omega}$; In AC small-signal circuit, voltage divider: $v_{o,\text{peak}} = v_{\text{ac}} \frac{r_d}{R + r_d} = 100\text{ mV} \times \frac{13.0}{2150 + 13.0} = 100 \times \frac{13}{2163} \approx \mathbf{0.601\text{ mV} \approx 0.60\text{ mV}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "shockley_diode_models_constant_voltage_drop_and_small_signal_resistance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Shockley Diode Physics \\& Small-Signal Modeling (William Shockley 1949)**\n• **Shockley Exponential Current-Voltage Formulation:**\n$$\n\\mathbf{I_D = I_S \\left( e^{\\frac{V_D}{n V_T}} - 1 \\right) \\quad \\Big| \\quad V_T = \\frac{k T}{q} = 25.85\\text{ mV} \\approx 26\\text{ mV at } 300\\text{ K}}\n$$\n• **The 3 Canonical Diode Circuit Models:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Model Approximation} & \\textbf{Forward Conduction State} & \\textbf{Primary Circuit Role} \\\\\n\\hline\n\\mathbf{\\text{Ideal Model}} & V_D = 0.0\\text{ V} \\ (R_{\\text{on}} = 0\\,\\Omega) & \\text{High-voltage power electronics } (V \\gg 10\\text{V}) \\\\\n\\mathbf{\\text{Constant Voltage Drop (CVD)}} & \\mathbf{V_D = V_\\gamma = 0.7\\text{ V (Silicon)}} & \\mathbf{\\text{Standard DC quiescent operating point (Q-point)}} \\\\\n\\mathbf{\\text{Small-Signal AC Model}} & \\mathbf{r_d = \\frac{n V_T}{I_{DQ}} \\approx \\frac{26\\text{ mV}}{I_{DQ}}} & \\mathbf{\\text{Linear AC signal analysis around Q-point}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Dynamic Resistance Invariant:** Small-signal AC resistance $r_d$ varies **inversely with DC quiescent bias current $I_{DQ}$** (doubling DC bias current halves the dynamic AC resistance)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform small-signal AC analysis on a biased diode circuit.",
      "orderItems": [
        "Deactivate all small-signal AC sources to formulate the purely DC circuit",
        "Apply the Constant Voltage Drop model (VD = 0.7 V) to solve for the DC quiescent bias current I_DQ",
        "Calculate the small-signal dynamic resistance of the diode: r_d = (n * V_T) / I_DQ \u2248 26 mV / I_DQ",
        "Deactivate all DC power sources (replace DC voltage sources with AC ground) and replace diode with linear resistance r_d",
        "Analyze the resulting linear AC circuit to calculate small-signal output voltages and currents"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Diode Modeling Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Shockley Equation", "right": "ID = IS*(exp(VD / nVT) - 1), physical exponential transport law across p-n junction" },
        { "left": "Thermal Voltage (VT \u2248 26 mV)", "right": "VT = kT / q, fundamental thermodynamic voltage scale proportional to absolute temperature" },
        { "left": "Dynamic AC Resistance (rd)", "right": "rd = n*VT / IDQ, incremental linear slope resistance around the DC operating bias point" },
        { "left": "CVD Approximation (0.7 V)", "right": "Standard engineering model assuming fixed 0.7 V forward drop across conducting silicon diode" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The room-temperature (300 K) thermal voltage VT in the Shockley diode equation is approximately ___ millivolts.",
      "blankAnswer": "26",
      "blankDistractors": ["700", "50", "12"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A silicon diode (n = 1) is biased with V_DC = 5.0 V through resistor R = 2150 \u03a9. Using CVD (VD = 0.7 V), what is the DC bias current IDQ, dynamic resistance rd, and output AC peak voltage vo,peak when an AC signal vac(t) = 100 mV_peak * cos(\u03c9t) is placed in series?",
      "options": [
        { "text": "IDQ = 2.0 mA, rd = 13.0 \u03a9, and vo,peak = 0.60 mV (IDQ = (5.0 - 0.7)/2150 = 2.0 mA; rd = 26 mV / 2.0 mA = 13.0 \u03a9; and vo,peak = 100 mV * (13 / (2150 + 13)) = 0.601 mV)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using DC bias and small-signal diode analysis (Adel Sedra & Kenneth Smith *Microelectronic Circuits* Chapter 4). 1. **DC Operating Point Analysis (Q-Point):** - Using CVD Model: $V_D = 0.7\\text{ V}$. - $$I_{DQ} = \\frac{V_{\\text{DC}} - V_D}{R} = \\frac{5.0\\text{ V} - 0.7\\text{ V}}{2150\\,\\Omega} = \\frac{4.3\\text{ V}}{2150\\,\\Omega} = 0.0020\\text{ A} = \\mathbf{2.0\\text{ mA}}$$ 2. **Calculate Small-Signal Dynamic Resistance ($r_d$):** - Using $V_T = 26\\text{ mV}$ at room temperature ($300\\text{ K}$): $$r_d = \\frac{n V_T}{I_{DQ}} = \\frac{(1)(26\\text{ mV})}{2.0\\text{ mA}} = \\mathbf{13.0\\,\\Omega}$$ 3. **AC Small-Signal Analysis:** - The diode is replaced by linear resistor $r_d = 13.0\\,\\Omega$. - AC output voltage across diode via voltage divider: $$v_{o,\\text{peak}} = v_{\\text{ac},\\text{peak}} \\left( \\frac{r_d}{R + r_d} \\right) = (100\\text{ mV}) \\left( \\frac{13.0\\,\\Omega}{2150\\,\\Omega + 13.0\\,\\Omega} \\right) = 100 \\times \\frac{13.0}{2163.0} \\approx \\mathbf{0.6010\\text{ mV} \\approx 0.60\\text{ mV}}$$ 4. **Linearity Check:** $v_{o,\\text{peak}} = 0.60\\text{ mV} \\ll V_T = 26\\text{ mV}$, proving the small-signal approximation is **exceptionally accurate**!" },
        { "text": "IDQ = 2.0 mA, rd = 26.0 \u03a9, and vo,peak = 1.20 mV", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "IDQ = 2.33 mA, rd = 11.2 \u03a9, and vo,peak = 0.52 mV (Using ideal 0V model)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "IDQ = 2.0 mA, rd = 13.0 \u03a9, and vo,peak = 100.0 mV", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
