# Duofy Reusable Lesson Format: AC-DC Rectification (Half/Full-Wave & Capacitive Filters)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / Diode_Circuits_and_Rectifiers`  
**Lesson Format Type:** `half_wave_and_full_wave_bridge_rectifiers_with_capacitive_filters`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through AC-to-DC power conversion, half-wave vs full-wave bridge topologies, Peak Inverse Voltage ($\text{PIV}$), rectification efficiency ($\eta$), ripple factor ($\gamma$), and capacitive filter smoothing in power supply design (Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 4; Robert L. Boylestad *Electronic Devices and Circuit Theory* Chapter 2): derive the **Full-Wave Bridge Rectifier Operating Formulations**:
$$\mathbf{V_{\text{dc,unfiltered}} = \frac{2 (V_m - 2 V_D)}{\pi} \approx 0.636 (V_m - 2 V_D) \quad \Big| \quad \mathbf{\text{PIV} = V_m - V_D \approx V_m}}$$
(analyzing why 4-diode bridge rectifiers achieve double the DC voltage and double the ripple frequency $2f_{\text{in}}$ of half-wave circuits while requiring only half the PIV rating of center-tapped transformers); derive the **Capacitive Smoothing Filter Ripple and DC Output Voltage Equations**:
$$\mathbf{V_r = \frac{I_{\text{dc}}}{2 f C} = \frac{V_p}{2 f R_L C} \quad \Big| \quad \mathbf{V_{\text{dc}} = V_p - \frac{V_r}{2} = V_p - \frac{I_{\text{dc}}}{4 f C}} \quad \Big| \quad \gamma = \frac{V_r}{2\sqrt{3} V_{\text{dc}}}}$$
where $V_p = V_m - 2 V_D$ is the peak filtered secondary voltage, $f$ is input line frequency, and $C$ is the smoothing reservoir capacitor.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bridge Rectifier ($V_{\text{dc}} = \frac{2 V_p}{\pi}$), Filter Ripple ($V_r = \frac{I_{\text{dc}}}{2fC}$) & PIV Ratings Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Filter Capacitor for a Full-Wave DC Power Supply Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Rectifier Topology / Filter Metric & Technical Physical Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Ripple Frequency at the Output of a Full-Wave Bridge Rectifier Driven by a 60 Hz Line Is Exactly ___ Hertz (120 / One Hundred Twenty) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Power Supply Design Problem: Sizing Filter Capacitance C to Limit Peak Ripple to 1.0 V at 500 mA DC Load Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Rectifiers & Capacitive Filtering (Sedra & Smith 2020; Boylestad 2013):
   - **Rectifier & Filter Formulations:**
     $$\mathbf{V_{\text{dc}} = V_p - \frac{V_r}{2} \quad \Big| \quad \mathbf{V_r = \frac{I_{\text{dc}}}{2 f C}} \quad \Big| \quad \mathbf{\text{PIV}_{\text{bridge}} = V_m - V_D \approx V_m} \quad \Big| \quad \mathbf{\text{PIV}_{\text{center-tap}} = 2 V_m}$$
   - **Rectifier Topology Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Topology} & \textbf{Diodes Count} & \textbf{Ripple Freq } f_r & \textbf{Ripple } V_r \text{ (Cap Filter)} & \textbf{PIV Stress} \\
     \hline
     \mathbf{\text{Half-Wave}} & 1 & f_{\text{in}} & I_{\text{dc}} / (f_{\text{in}} C) & V_m \\
     \mathbf{\text{Full-Wave Center-Tap}} & 2 & 2 f_{\text{in}} & I_{\text{dc}} / (2 f_{\text{in}} C) & \mathbf{2 V_m \text{ (High breakdown hazard)}} \\
     \mathbf{\text{Full-Wave Bridge}} & \mathbf{4} & \mathbf{2 f_{\text{in}}} & \mathbf{I_{\text{dc}} / (2 f_{\text{in}} C)} & \mathbf{V_m \text{ (Lowest diode stress!)}} \\
     \hline
     \end{array}$$
   - **The Conduction Angle Invariant:** A larger smoothing capacitor $C$ reduces ripple $V_r$, but narrows the diode conduction angle $\Delta t$, forcing **narrow, massive peak repetitive surge currents ($I_{\text{peak}} \gg I_{\text{dc}}$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of DC power supply filter sizing: (1) determine secondary transformer peak voltage $V_m$ and subtract two diode drops $V_p = V_m - 2(0.7\text{ V})$, (2) record DC load current $I_{\text{dc}}$ and line frequency $f$, (3) set target maximum peak-to-peak ripple voltage $V_r$, (4) compute required smoothing filter capacitance $C = \frac{I_{\text{dc}}}{2 f V_r}$, (5) calculate final filtered DC voltage $V_{\text{dc}} = V_p - \frac{V_r}{2}$ and check diode PIV rating!
3. **Slide 3 (`matching`):** Pair 4 concepts (Full-Wave Bridge PIV $V_m$, Center-Tap PIV $2V_m$, Capacitive Ripple $V_r = I_{\text{dc}}/(2fC)$, Full-Wave Ripple Frequency $2f_{\text{in}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 120 (or One Hundred Twenty). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sizing filter capacitor: A full-wave bridge rectifier is fed by a $120\text{ V}_{\text{rms}}$, $60\text{ Hz}$ line stepped down to $V_{\text{sec,rms}} = 12.0\text{ V}_{\text{rms}}$ ($V_m = 12.0 \times \sqrt{2} \approx 16.97\text{ V}$). The silicon bridge diodes have $V_D = 0.7\text{ V}$ each ($V_p = 16.97 - 1.40 = 15.57\text{ V}$). The DC load draws $I_{\text{dc}} = 500\text{ mA} = 0.50\text{ A}$. What is the required capacitance $C$ to limit the peak-to-peak ripple voltage to $V_r = 1.0\text{ V}$, and what is the resulting filtered DC output voltage $V_{\text{dc}}$? ($C = \frac{I_{\text{dc}}}{2 f V_r} = \frac{0.50\text{ A}}{2(60\text{ Hz})(1.0\text{ V})} = \frac{0.50}{120} \approx 4.167 \times 10^{-3}\text{ F} = \mathbf{4167\text{ }\mu\text{F} \approx 4.17\text{ mF}}$; Filtered DC voltage: $V_{\text{dc}} = V_p - \frac{V_r}{2} = 15.57\text{ V} - \frac{1.0\text{ V}}{2} = 15.57 - 0.50 = \mathbf{15.07\text{ V}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "half_wave_and_full_wave_bridge_rectifiers_with_capacitive_filters",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: AC-DC Rectification \\& Filter Dynamics (Sedra \\& Smith)**\n• **Full-Wave Bridge Rectifier Formulations:**\n$$\n\\mathbf{V_p = V_m - 2 V_D \\quad \\Big| \\quad \\text{Unfiltered } V_{\\text{dc}} = \\frac{2 V_p}{\\pi} \\approx 0.636 V_p \\quad \\Big| \\quad \\mathbf{\\text{PIV} = V_m - V_D \\approx V_m}}\n$$\n• **Capacitive Smoothing Filter Ripple \\& DC Output:**\n$$\n\\mathbf{V_r = \\frac{I_{\\text{dc}}}{2 f C} = \\frac{V_p}{2 f R_L C} \\quad \\Big| \\quad \\mathbf{V_{\\text{dc}} = V_p - \\frac{V_r}{2} = V_p - \\frac{I_{\\text{dc}}}{4 f C}}}\n$$\n• **PIV Comparison: Bridge vs Center-Tapped:**\n  - **Bridge Rectifier (4 Diodes):** $\\mathbf{\\text{PIV} \\approx V_m}$ (Lowest voltage stress on silicon diodes);\n  - **Center-Tapped (2 Diodes):** $\\mathbf{\\text{PIV} = 2 V_m}$ (Requires 2x higher diode reverse breakdown rating!);\n• **The Ripple Frequency Invariant:** Full-wave rectifiers double the ripple frequency ($\\mathbf{f_r = 2 f_{\\text{in}} = 120\\text{ Hz}}$ for $60\\text{ Hz}$ mains), cutting required smoothing capacitance in half compared to half-wave rectifiers!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design and size the smoothing capacitor for a full-wave bridge DC power supply.",
      "orderItems": [
        "Determine the AC transformer secondary peak voltage Vm and subtract two forward diode drops: Vp = Vm - 2*VD",
        "Record the continuous DC load current I_dc and AC mains line frequency f (e.g. 60 Hz)",
        "Specify the maximum acceptable peak-to-peak ripple voltage Vr across the output capacitor",
        "Calculate the required smoothing filter capacitance using the full-wave ripple formula: C = I_dc / (2 * f * Vr)",
        "Compute the resulting filtered DC output voltage V_dc = Vp - (Vr / 2) and verify diode Peak Inverse Voltage (PIV \u2248 Vm)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Rectifier Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Peak Inverse Voltage (Bridge)", "right": "PIV \u2248 Vm, maximum reverse voltage applied across non-conducting diodes in a 4-diode bridge" },
        { "left": "Peak Inverse Voltage (Center-Tap)", "right": "PIV = 2*Vm, high reverse voltage stress requiring diodes with double the voltage rating" },
        { "left": "Peak-to-Peak Ripple (Vr)", "right": "Vr = Idc / (2*f*C), periodic sawtooth voltage fluctuation resulting from capacitor discharge" },
        { "left": "Full-Wave Ripple Frequency", "right": "fr = 2*fin (120 Hz for 60 Hz AC line), doubling the rate of reservoir recharging pulses" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The ripple frequency at the output of a full-wave bridge rectifier driven by a 60 Hz AC line is exactly ___ Hertz.",
      "blankAnswer": "120",
      "blankDistractors": ["60", "240", "30"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A full-wave bridge rectifier operates on a 60 Hz line with peak secondary voltage after two diode drops Vp = 15.57 V. The DC load draws Idc = 500 mA (0.50 A). What is the required smoothing filter capacitance C to limit ripple to Vr = 1.0 V, and what is the filtered DC voltage Vdc?",
      "options": [
        { "text": "C = 4167 \u03bcF (~4.17 mF) and Vdc = 15.07 V (C = 0.50 A / (2 * 60 Hz * 1.0 V) = 4166.7 \u03bcF; and Vdc = 15.57 V - 1.0/2 = 15.07 V)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using full-wave bridge rectifier capacitor filter formulas (Adel Sedra & Kenneth Smith *Microelectronic Circuits* Chapter 4). 1. **Calculate Required Filter Capacitance ($C$):** $$C = \\frac{I_{\\text{dc}}}{2 f V_r}$$ - Where $I_{\\text{dc}} = 0.50\\text{ A}$, $f = 60\\text{ Hz}$, and $V_r = 1.0\\text{ V}$: $$C = \\frac{0.50\\text{ A}}{2 \\times (60\\text{ Hz}) \\times (1.0\\text{ V})} = \\frac{0.50}{120} = 0.0041667\\text{ F} = \\mathbf{4166.7\\text{ }\\mu\\text{F} \\approx 4167\\text{ }\\mu\\text{F} \\approx 4.17\\text{ mF}}$$ 2. **Calculate Filtered DC Output Voltage ($V_{\\text{dc}}$):** $$V_{\\text{dc}} = V_p - \\frac{V_r}{2} = 15.57\\text{ V} - \\frac{1.0\\text{ V}}{2} = 15.57 - 0.50 = \\mathbf{15.07\\text{ Volts}}$$ 3. **Ripple Factor Check ($\\gamma$):** $$\\gamma = \\frac{V_{r,\\text{rms}}}{V_{\\text{dc}}} = \\frac{V_r / (2\\sqrt{3})}{V_{\\text{dc}}} = \\frac{1.0 / 3.464}{15.07} = \\frac{0.2887}{15.07} = 0.01915 \\implies \\mathbf{1.92\\% \\text{ ripple!}}$$ Flawless DC power supply filter design!" },
        { "text": "C = 8333 \u03bcF and Vdc = 15.07 V (Using half-wave formula)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C = 2083 \u03bcF and Vdc = 14.57 V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C = 4167 \u03bcF and Vdc = 15.57 V (Ignoring ripple sag)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
