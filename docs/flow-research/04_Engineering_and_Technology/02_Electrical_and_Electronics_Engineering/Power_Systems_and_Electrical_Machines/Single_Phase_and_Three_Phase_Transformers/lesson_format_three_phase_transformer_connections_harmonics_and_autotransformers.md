# Duofy Reusable Lesson Format: 3-Phase Transformers (Vector Groups, Harmonics, & Autotransformers)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Single_Phase_and_Three_Phase_Transformers`  
**Lesson Format Type:** `three_phase_transformer_connections_harmonics_and_autotransformers`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify three-phase transformer bank connections ($Y\text{-}Y, \ Y\text{-}\Delta, \ \Delta\text{-}Y, \ \Delta\text{-}\Delta$), IEEE $30^\circ$ phase shift standards, magnetic core non-linear saturation, third harmonic ($180\text{ Hz}$) flux trapping in closed delta windings, and autotransformer conductive versus inductive power transfer advantages in high-voltage substation grids (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 2; A. E. Fitzgerald *Electric Machinery* Chapter 2): master the **Four Fundamental 3-Phase Transformer Connections**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Connection Type} & \textbf{Line Voltage Ratio } V_{L,\text{sec}} / V_{L,\text{pri}} & \textbf{Line Phase Shift} & \textbf{Primary Industrial Role} \\
\hline
\mathbf{Y\text{-}Y \ (\text{Wye-Wye})} & N_2 / N_1 & 0^\circ \text{ or } 180^\circ & \text{High-voltage tie; requires tertiary delta} \\
\mathbf{Y\text{-}\Delta \ (\text{Wye-Delta})} & \frac{1}{\sqrt{3}} (N_2 / N_1) & -30^\circ \ (\text{LV lags HV}) & \mathbf{\text{Step-down transmission substations}} \\
\mathbf{\Delta\text{-}Y \ (\text{Delta-Wye})} & \sqrt{3} (N_2 / N_1) & -30^\circ \ (\text{LV lags HV}) & \mathbf{\text{Generator step-up; commercial 4-wire supply}} \\
\mathbf{\Delta\text{-}\Delta \ (\text{Delta-Delta})} & N_2 / N_1 & 0^\circ \text{ or } 180^\circ & \text{Industrial plants; supports Open-Delta } (V\text{-}V) \\
\hline
\end{array}$$
derive the **Autotransformer Power Transfer Advantage**:
$$\mathbf{S_{\text{apparent,auto}} = V_H I_H = \left( \frac{N_{\text{se}} + N_c}{N_{\text{se}}} \right) S_{\text{transformed}} = \left( \frac{1}{1 - \frac{V_L}{V_H}} \right) S_{\text{transformed}}}$$
(proving that when step ratio is near unity, e.g. $2400\text{ V}$ to $2200\text{ V}$, a compact $10\text{ kVA}$ transformer can handle over **$120\text{ kVA}$ of total power** via direct conductive current conduction); and interact with live Transformer equivalent circuit OC/SC calculator, Voltage regulation phasor simulator, Maximum efficiency / All-day loss optimizer, and Three-Phase Delta-Wye harmonic visualizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 3-Phase Bank ($Y\text{-}\Delta, \Delta\text{-}Y$ $30^\circ$ Shift), Delta 3rd Harmonic Trap & Autotransformer Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | 3-Phase Connection / Special Transformer & Technical Grid Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Delta Windings Are Universally Incorporated in Power Substation Transformers to Trap 3rd Harmonic Currents Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | In North American IEEE Standards, the Line-to-Line Voltages of a Delta-Wye or Wye-Delta Transformer Secondary Lag the Primary by Exactly ___ Degrees (30 / Thirty) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Transformers & Power Systems Studio: OC/SC Testing, VR Phasors, Max Efficiency & 3-Phase Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "three_phase_transformer_connections_harmonics_and_autotransformers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do 3-Phase Transformer connections operate, why are Delta windings 3rd harmonic traps, and what is the Autotransformer advantage?",
      "blankAnswer": "3-Phase Transformers & Autotransformers (Stephen Chapman): (1) 3-PHASE CONNECTIONS: Y-\u0394 and \u0394-Y produce a standard 30\u00b0 line-to-line phase shift (LV lags HV by 30\u00b0). (2) 3RD HARMONIC TRAPPING: Magnetic core saturation requires 3rd harmonic (180 Hz) magnetizing currents. A closed \u0394-winding allows 3rd harmonics to circulate harmlessly in a closed loop, preserving clean sinusoidal phase voltages. (3) AUTOTRANSFORMER ADVANTAGE: By sharing a common winding, power is transferred both inductively (magnetic) and conductively (direct wire). Apparent rating: S_auto = S_transformed / (1 - VL/VH). When VL \u2248 VH, a small core can transfer massive power!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each 3-Phase Transformer Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "\u0394-Y Connection", "right": "Standard generator step-up topology providing \u221a3 voltage boost and 4-wire neutral distribution" },
        { "left": "Delta 3rd Harmonic Trap", "right": "Closed delta loop allowing 180 Hz zero-sequence harmonic currents to circulate without distorting line voltages" },
        { "left": "Autotransformer Power Boost", "right": "S_auto = S_transformed / (1 - VL/VH), transferring majority of power via direct electrical conduction" },
        { "left": "Open-Delta (V-V) Bank", "right": "Delivers 57.7% of full three-phase power bank capacity using only 2 single-phase transformers" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In high-voltage power transmission networks, why is an ungrounded Wye-Wye (Y-Y) transformer connection considered dangerous and rarely used unless a tertiary Delta (\u0394) winding is physically installed?",
      "options": [
        { "text": "Because non-linear magnetic saturation in the iron core produces prominent 3rd harmonic (180 Hz) components in the excitation current that are all in-phase (zero sequence); in an ungrounded Y-Y connection, 3rd harmonic currents cannot flow because they have no return path, causing severe 3rd harmonic distortion in the magnetic flux that induces massive peak voltage spikes (up to 3x nominal) and causes neutral point floating instability; adding a closed tertiary delta winding allows 3rd harmonic currents to circulate locally, completely restoring sinusoidal flux and voltages", "isCorrect": true, "explanation": "Correct! This is Stephen Chapman and A.E. Fitzgerald's classic explanation of harmonic phenomena in power transformers (*Electric Machinery Fundamentals* Chapter 2; *Electric Machinery* Chapter 2). 1. **The Origin of 3rd Harmonics:** - Due to non-linear $B\\text{-}H$ core saturation, a sinusoidal flux requires a peaked magnetizing current containing a large **$3\\text{rd}$ harmonic ($180\\text{ Hz}$) component**. 2. **The Ungrounded Y-Y Deadlock:** - The $3\\text{rd}$ harmonic currents in all three phases are in phase with each other ($i_{a3} = i_{b3} = i_{c3}$). - At an ungrounded neutral node: $i_{a3} + i_{b3} + i_{c3} = 3 i_{3} = 0 \\implies i_{3} = 0$. - Because the $3\\text{rd}$ harmonic currents **cannot flow**, the magnetic flux becomes severely flat-topped! 3. **The Resulting Overvoltage Disaster:** - The flat-topped flux induces **extremely peaked phase voltages** ($e = -N \\frac{d\\Phi}{dt}$), causing insulation breakdown, radio interference, and an unstable, floating neutral point! 4. **The Tertiary Delta Remedy:** - Adding a closed tertiary $\\Delta$-winding provides a low-impedance closed loop for $3\\text{rd}$ harmonic currents to circulate, restoring perfectly clean, pure sinusoidal terminal voltages!" },
        { "text": "Because Wye connections only work with direct current (DC)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 3-phase power cannot pass through iron cores without a ground rod", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because delta windings eliminate all resistance from copper wires", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In North American IEEE standards, the line voltages of a Delta-Wye or Wye-Delta transformer secondary lag the primary by exactly ___ degrees.",
      "blankAnswer": "30",
      "blankDistractors": ["60", "90", "120"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Transformers & Power Systems Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Transformers & Power Systems Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">OC/SC Testing, VR Phasors, Max Efficiency & 3-Phase</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnTest\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. OC/SC Tests (Req=48\u03a9, Xeq=152.6\u03a9)</button><button id=\"btnVr\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. VR & Max Efficiency (x=79.1%)</button><button id=\"btn3p\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. 3-Phase Bank & Delta Trap</button></div><div id=\"xfmrLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate OC/SC tests...</div><script>document.getElementById('btnTest').onclick=()=>{document.getElementById('xfmrLog').innerHTML='<b>1. OC \\& SC PARAMETER EXTRACTION:</b><br>• OC Test (LV @ rated V) &rarr; P_core = Poc, Rc = Voc^2/Poc, Xm = Voc/Im<br>• SC Test (HV @ rated I) &rarr; <b style=\"color:#10b981;\">Req = 48.0 \\u03a9, Xeq = 152.6 \\u03a9!</b><br>• Decoupled testing isolates core and copper losses!';}; document.getElementById('btnVr').onclick=()=>{document.getElementById('xfmrLog').innerHTML='<b>2. VOLTAGE REGULATION \\& EFFICIENCY:</b><br>• VR = 2.71% (@ 0.8 Lagging PF); VR < 0 for Leading!<br>• <b style=\"color:#38bdf8;\">Max Efficiency: x = \\u221a(Pcore/Pcu,fl) = 79.1% load!</b><br>• All-Day Energy: \u03b7_all-day optimizes continuous 24h core losses!';}; document.getElementById('btn3p').onclick=()=>{document.getElementById('xfmrLog').innerHTML='<b>3. 3-PHASE TRANSFORMER BANK:</b><br>• Y-\\u0394 & \\u0394-Y: Standard 30\u00b0 line voltage phase shift!<br>• Delta Winding: <b style=\"color:#10b981;\">Traps 3rd harmonic (180 Hz) circulating currents!</b><br>• Autotransformer: S_auto = S_trans / (1 - VL/VH)<br>🏆 <b style=\"color:#10b981;\">Single_Phase_and_Three_Phase_Transformers 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
