# Duofy Reusable Lesson Format: RLC Resonance (Quality Factor, Bandwidth, & Filter Synthesis)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / Transient_and_Sinusoidal_Steady_State`  
**Lesson Format Type:** `series_and_parallel_rlc_resonance_and_quality_factor`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify electrical resonance physics, series vs parallel RLC tank circuits, Quality Factor ($Q$), half-power bandwidth ($\text{BW}$), and bandpass filter selectivity in AC communication networks (Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 14; James W. Nilsson & Susan A. Riedel *Electric Circuits* Chapter 14): master the **Resonant Frequency Condition ($\mathbf{\text{Im}(Z) = 0 \Longleftrightarrow \omega_0 L = \frac{1}{\omega_0 C}}$)**:
$$\mathbf{\omega_0 = \frac{1}{\sqrt{LC}} \ [\text{rad/s}] \quad \Big| \quad f_0 = \frac{1}{2\pi \sqrt{LC}} \ [\text{Hz}]}$$
master the **Series RLC vs Parallel RLC Quality Factor Invariant**:
$$\mathbf{\text{Series RLC: } Q = \frac{\omega_0 L}{R} = \frac{1}{\omega_0 R C} = \frac{1}{R}\sqrt{\frac{L}{C}} \quad \Big| \quad \text{Parallel RLC: } Q = \frac{R}{\omega_0 L} = \omega_0 R C = R \sqrt{\frac{C}{L}}}$$
derive the **Half-Power Bandwidth ($\mathbf{\text{BW}}$)** and **Cutoff Frequencies ($\mathbf{\omega_1, \omega_2}$)**:
$$\mathbf{\text{BW} = \frac{\omega_0}{Q} = \omega_2 - \omega_1 \quad \Big| \quad \text{Series: } \text{BW} = \frac{R}{L} \quad \Big| \quad \text{High-}Q \ (Q \ge 10): \ \omega_{1,2} \approx \omega_0 \mp \frac{\text{BW}}{2}}$$
and interact with live RC/RL transient step response simulator, Second-order RLC damping waveform animator, AC complex power triangle calculator, and RLC resonance frequency response spectrum analyzer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RLC Resonant Frequency ($\omega_0 = \frac{1}{\sqrt{LC}}$), Quality Factor ($Q = \frac{\omega_0}{\text{BW}}$) & Bandwidth Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Resonance Metric / Bandpass Parameter & Technical Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Series RLC Has Minimum Impedance at Resonance While Parallel RLC Has Maximum Impedance Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Frequency Band Between the Half-Power Cutoff Points in an RLC Resonant Circuit Is the ___ (Bandwidth / BW) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Electric Circuits Studio: RC/RL Step, Second-Order RLC, AC Power & Resonance Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "series_and_parallel_rlc_resonance_and_quality_factor",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Electrical Resonance, how are Quality Factor (Q) and Bandwidth (BW) calculated, and how do Series and Parallel RLC circuits differ?",
      "blankAnswer": "RLC Resonance (Alexander & Sadiku): (1) RESONANT FREQUENCY: Occurs when inductive and capacitive reactances cancel (Im(Z) = 0): \u03c90 = 1 / sqrt(LC) rad/s or f0 = 1 / (2*\u03c0*sqrt(LC)) Hz. (2) SERIES RLC: At resonance, impedance collapses to minimum Z_min = R (purely resistive), current peaks at maximum I_max = V / R. Quality Factor Q = \u03c90*L / R = (1/R)*sqrt(L/C). (3) PARALLEL RLC: At resonance, impedance peaks at maximum Z_max = R, current drops to minimum. Quality Factor Q = R / (\u03c90*L) = R*sqrt(C/L). (4) BANDWIDTH & SELECTIVITY: Half-power bandwidth BW = \u03c90 / Q = \u03c92 - \u03c91. High Q (Q >= 10) produces narrow bandwidth and razor-sharp filter selectivity!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Resonance Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Resonant Frequency (\u03c90)", "right": "\u03c90 = 1 / sqrt(L*C), frequency where inductive and capacitive reactances cancel to zero" },
        { "left": "Series Quality Factor (Q)", "right": "Q = \u03c90*L / R, magnifying reactive component voltages by Q times the source voltage" },
        { "left": "Half-Power Bandwidth (BW)", "right": "BW = \u03c90 / Q, the frequency interval where delivered power is at least 50% of the peak" },
        { "left": "Parallel Quality Factor (Q)", "right": "Q = R / (\u03c90*L), where a larger parallel resistance yields higher quality factor and selectivity" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In radio receivers and wireless communication front-ends, why does a Series RLC circuit exhibit minimum impedance (Z = R) at resonance while a Parallel RLC circuit exhibits maximum impedance (Z = R)?",
      "options": [
        { "text": "In a Series RLC circuit, the inductive reactance (+j\u03c9L) and capacitive reactance (-j/(\u03c9C)) are equal and opposite at \u03c90, canceling each other out to leave only the series resistance Z_series = R (minimum impedance, drawing peak current from the antenna); in contrast, in a Parallel RLC tank, the inductive susceptance (-j/(\u03c9L)) and capacitive susceptance (+j\u03c9C) cancel each other out, making the parallel admittance Y_parallel = 1/R (minimum admittance, creating maximum parallel impedance Z_parallel = R that rejects off-resonant signals)", "isCorrect": true, "explanation": "Correct! This is Charles Alexander and Matthew Sadiku's fundamental dual comparison of series vs parallel resonance (*Fundamentals of Electric Circuits* Chapter 14). 1. **Series RLC Impedance:** $$Z_{\\text{series}}(\\omega) = R + j \\left(\\omega L - \\frac{1}{\\omega C}\\right)$$ - At $\\omega_0 = \\frac{1}{\\sqrt{LC}}$, the reactive term is **identically zero**: $$Z_{\\text{series}}(\\omega_0) = R + j(0) = \\mathbf{R \\quad (\\text{Global Minimum Impedance!})}$$ - Current peaks at $I_{\\text{max}} = \\frac{V_s}{R}$. 2. **Parallel RLC Admittance:** $$Y_{\\text{parallel}}(\\omega) = \\frac{1}{R} + j \\left(\\omega C - \\frac{1}{\\omega L}\\right)$$ - At $\\omega_0$, the imaginary susceptance cancels out: $$Y_{\\text{parallel}}(\\omega_0) = \\frac{1}{R} \\implies Z_{\\text{parallel}}(\\omega_0) = \\frac{1}{Y} = \\mathbf{R \\quad (\\text{Global Maximum Impedance!})}$$ 3. **Applications:** Series RLC is used as an **acceptor filter** to pass a desired carrier frequency; Parallel RLC is used as a **rejector / tank load** in RF amplifiers to produce massive voltage gain at $\\omega_0$!" },
        { "text": "Because series inductors turn into capacitors at resonance", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because parallel circuits only work at DC frequencies", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because resistors absorb all reactive power at resonance", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The frequency span between the upper and lower half-power cutoff frequencies in a resonant filter is the ___.",
      "blankAnswer": "bandwidth",
      "blankDistractors": ["reactance", "susceptance", "impedance"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Electric Circuits & Networks Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Electric Circuits & Network Theory Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">RC/RL Step, Second-Order RLC Damping & AC Resonance</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnRc\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. RC Step (vC = 6.32V @ 1\u03c4)</button><button id=\"btnRlc\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. RLC Damping (\u03c9d = 245 rad/s)</button><button id=\"btnAc\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. AC Power Factor & Resonance</button></div><div id=\"eeLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate RC step response...</div><script>document.getElementById('btnRc').onclick=()=>{document.getElementById('eeLog').innerHTML='<b>1. FIRST-ORDER RC TRANSIENT STEP:</b><br>• R = 1k\\u03a9, C = 2\\u03bcF &rarr; \\u03c4 = RC = 2.0 ms<br>• vC(t) = 10.0 * (1 - e^-t/\\u03c4)<br>• <b style=\"color:#10b981;\">At t = 1\\u03c4 (2 ms): vC = 6.32 V (63.2% of steady state)!</b>';}; document.getElementById('btnRlc').onclick=()=>{document.getElementById('eeLog').innerHTML='<b>2. SECOND-ORDER RLC DAMPING REGIMES:</b><br>• Series R=40\\u03a9, L=0.1H, C=100\\u03bcF &rarr; \\u03c90 = 316.2 rad/s<br>• \\u03b1 = R/(2L) = 200 Np/s < \\u03c90 &rarr; <b style=\"color:#38bdf8;\">UNDERDAMPED!</b><br>• Damped Ringing Frequency: \\u03c9d = sqrt(\\u03c90^2 - \\u03b1^2) = 244.95 rad/s!';}; document.getElementById('btnAc').onclick=()=>{document.getElementById('eeLog').innerHTML='<b>3. AC POWER FACTOR \\& RLC RESONANCE:</b><br>• PFC: Adding C_shunt = 2.30 mF raises pf from 0.60 to 0.96 lagging (-61% line losses!)<br>• Resonance: \\u03c90 = 1/sqrt(LC), Im(Z)=0, Bandwidth BW = \\u03c90 / Q<br>🏆 <b style=\"color:#10b981;\">Electric_Circuits_and_Network_Theory 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
