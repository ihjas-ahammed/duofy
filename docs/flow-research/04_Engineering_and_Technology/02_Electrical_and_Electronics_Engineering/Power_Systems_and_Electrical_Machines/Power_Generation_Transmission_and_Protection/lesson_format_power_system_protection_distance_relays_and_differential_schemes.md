# Duofy Reusable Lesson Format: Power Protection (Distance Relays & Differential Schemes)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Power_Generation_Transmission_and_Protection`  
**Lesson Format Type:** `power_system_protection_distance_relays_and_differential_schemes`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify high-voltage substation protection engineering, Current Transformers ($\text{CT}$), Voltage Transformers ($\text{VT/PT}$), three-zone stepped distance relay protection (Mho, Quadrilateral, Reactance characteristics), and the Merz-Price percentage biased differential protection scheme for transformers, generators, and busbars (J. Duncan Glover *Power System Analysis and Design* Chapter 10; Hadi Saadat *Power System Analysis* Chapter 11): master the **Three-Zone Stepped Distance Relay Protection Strategy**:
$$\mathbf{\text{Apparent Impedance Seen by Relay: } Z_{\text{seen}} = \frac{V_{\text{relay}}}{I_{\text{relay}}} = z_{\text{line}} \cdot d}$$
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Protection Zone} & \textbf{Reach Setting} & \textbf{Trip Time Delay} & \textbf{Primary Protection Role} \\
\hline
\mathbf{\text{Zone 1}} & \mathbf{80\% - 85\% \text{ Line Length}} & \mathbf{\text{Instantaneous (0 cycles / } <20\text{ ms)}} & \text{High-speed primary protection (avoids overreach)} \\
\mathbf{\text{Zone 2}} & \mathbf{120\% \text{ Line Length}} & \mathbf{0.3 - 0.4\text{ s Delay}} & \text{Clears remaining } 20\% \text{ end-zone and remote busbar} \\
\mathbf{\text{Zone 3}} & \mathbf{200\% \text{ Remote Line Reach}} & \mathbf{0.8 - 1.2\text{ s Delay}} & \text{Remote backup for adjacent substation line failure} \\
\hline
\end{array}$$
derive the **Merz-Price Percentage Biased Differential Protection Criterion**:
$$\mathbf{\text{Operating Current: } I_{\text{op}} = |I_1 - I_2| \quad \Big| \quad \text{Restraining Current: } I_{\text{rest}} = \frac{|I_1| + |I_2|}{2}}$$
$$\mathbf{\text{Trip Condition: } \frac{I_{\text{op}}}{I_{\text{rest}}} = \frac{|I_1 - I_2|}{(|I_1| + |I_2|)/2} \ge K \ (\text{Slope Percentage, typically } 10\% - 40\%)}$$
master the **Transformer Differential CT Phase Shift Compensation Rule**:
- For a $\mathbf{\Delta\text{-}Y}$ **Power Transformer** (which introduces a $30^\circ$ phase shift):
  - CT secondary windings on the $\mathbf{\Delta}$ side MUST be connected in **$\mathbf{Y}$ (Wye)**;
  - CT secondary windings on the $\mathbf{Y}$ side MUST be connected in **$\mathbf{\Delta}$ (Delta)**;
(proving how inverse CT connections cancel the transformer's $30^\circ$ phase shift and block zero-sequence false trips during external through-faults); and interact with live Transmission ABCD & SIL calculator, Symmetrical components visualizer, Unsymmetrical SLG/LL fault simulator, and Interactive 3-Zone Distance & Differential relay testing widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Distance Zones ($85\% \to 120\% \to 200\%$), Differential Slope ($I_{\text{op}} / I_{\text{rest}} \ge K$) & CT Matrix Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Protection Scheme / Relay Mechanism & Technical Operational Principle Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Distance Relay Zone 1 Is Deliberately Set to 80-85% of Line Length Rather Than 100% Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | In Differential Protection for a Delta-Wye Power Transformer, Current Transformers on the Wye Side Must Be Connected in ___ (Delta) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Power Systems & Protection Studio: Transmission ABCD, Symmetrical Components, Faults & Relays Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "power_system_protection_distance_relays_and_differential_schemes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Three-Zone Distance Protection, and how does Merz-Price Percentage Differential Protection operate?",
      "blankAnswer": "Power System Protection (Glover; Saadat): (1) THREE-ZONE DISTANCE RELAYING: Zone 1 (80-85% line, Instantaneous 0 ms); Zone 2 (120% line, 0.3-0.4 s delay to clear remaining 20% end-zone); Zone 3 (200% reach, 0.8-1.2 s remote backup). (2) PERCENTAGE DIFFERENTIAL: Operates on I_op = |I1 - I2| vs I_rest = (|I1|+|I2|)/2. Trips when I_op / I_rest >= K (Slope 10-40%), providing absolute unit protection. (3) CT PHASE COMPENSATION: To protect a \u0394-Y power transformer (30\u00b0 phase shift), CTs on the \u0394 side must be wired in Y, and CTs on the Y side must be wired in \u0394 to cancel phase shift and zero-sequence spill currents!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Protection System Scheme to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Distance Relay Zone 1", "right": "Instantaneous tripping covering 80-85% of line length, set below 100% to prevent overreaching" },
        { "left": "Distance Relay Zone 2", "right": "Time-delayed (0.3-0.4 s) protection covering 120% of line length to clear the remaining 15-20% end section" },
        { "left": "Percentage Differential Relay", "right": "Trips when |I1 - I2| / I_rest >= K, providing instantaneous unit protection for generators and transformers" },
        { "left": "Transformer CT Inverse Rule", "right": "Connecting CTs in Delta on the Wye side and in Wye on the Delta side to cancel 30\u00b0 transformer phase shift" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In high-voltage transmission line distance protection, why is the instantaneous Zone 1 reach strictly restricted to 80% to 85% of the total line length rather than being set to 100%?",
      "options": [
        { "text": "Due to unavoidable measurement inaccuracies in Current Transformers (CTs), Voltage Transformers (VTs), transmission line impedance modeling approximations, and transient DC offset errors, setting Zone 1 to 100% would cause the relay to 'overreach' and instantaneously trip for faults located just beyond the remote busbar on adjacent lines, destroying system protection selectivity; restricting Zone 1 to 80-85% guarantees it NEVER trips for out-of-zone faults, while time-delayed Zone 2 (120%) safely clears the remaining 15-20% line end-zone", "isCorrect": true, "explanation": "Correct! This is J. Duncan Glover and Hadi Saadat's fundamental rule for stepped-distance relay coordination (*Power System Analysis and Design* Chapter 10; *Power System Analysis* Chapter 11). 1. **The Overreach Danger:** - Distance relays compute apparent impedance: $$Z_{\\text{seen}} = \\frac{V_{\\text{relay}}}{I_{\\text{relay}}}$$ - Measurement errors arise from: CT saturation ($3-5\\%$), VT ratio error ($1-2\\%$), line sag/temperature variation ($5\\%$), and DC transient offset ($5\\%$). - Total measurement tolerance: **$\\pm 10\\% \\text{ to } \\pm 15\\%$**. 2. **The Catastrophic 100% Scenario:** - If Zone 1 were set to $100\\%$, an external fault at $102\\%$ (on an adjacent neighbor line) might be measured as $97\\%$ impedance. - The relay would **instantaneously trip the wrong line**, disconnecting healthy power paths and potentially triggering cascading blackouts! 3. **The Engineering Solution:** - Zone 1 is set to **$80\\% - 85\\%$ instantaneous (0 ms)**. - Zone 2 is set to **$120\\%$ with a $0.35\\text{ s}$ time delay** to let the neighbor's Zone 1 clear first, providing $100\\%$ line coverage with zero overreach risk!" },
        { "text": "Because electricity slows down over the last 15% of a line", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because circuit breakers cannot open at 100% current", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because distance relays only work with DC voltage", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In percentage differential protection for a Delta-Wye power transformer, the current transformers on the Wye side must be connected in ___.",
      "blankAnswer": "delta",
      "blankDistractors": ["wye", "series", "parallel"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Power Generation, Transmission & Protection Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Power Transmission & Protection Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">ABCD Lines, SIL, Symmetrical Components, SLG Faults & Relaying</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnAbcd\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Transmission & SIL (SIL=450MW)</button><button id=\"btnFlt\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Symmetrical & SLG Fault (15.7kA)</button><button id=\"btnProt\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Distance Relaying (85% Z1) & Diff</button></div><div id=\"pwrLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate transmission line...</div><script>document.getElementById('btnAbcd').onclick=()=>{document.getElementById('pwrLog').innerHTML='<b>1. TRANSMISSION LINES \\& SIL:</b><br>• Medium Nominal \\u03c0: A = 1 + ZY/2 = 0.965, Zc = 264.6 \\u03a9<br>• <b style=\"color:#10b981;\">SIL = VL^2 / Zc = 450.0 MW (Flat voltage profile)!</b><br>• Ferranti Effect: Unloaded line VR > VS!';}; document.getElementById('btnFlt').onclick=()=>{document.getElementById('pwrLog').innerHTML='<b>2. SYMMETRICAL COMPONENTS \\& SLG FAULT:</b><br>• Fortescue: I_012 = A^-1 * I_abc (a = 1\\u2220120\u00b0)<br>• SLG Fault (Series loop): <b style=\"color:#38bdf8;\">If = 3*Ia1 = 7.50 pu = 15.69 kA!</b><br>• 3Zf term accounts for ground return loop!';}; document.getElementById('btnProt').onclick=()=>{document.getElementById('pwrLog').innerHTML='<b>3. POWER SYSTEM PROTECTION:</b><br>• 3-Zone Distance: Zone 1 (85% Instant), Zone 2 (120% 0.35s delay)<br>• Percentage Differential: I_op/I_rest >= K<br>• <b style=\"color:#10b981;\">Transformer \\u0394-Y CT Rule: Wire CTs in \\u0394 on Y-side!</b><br>🏆 <b style=\"color:#10b981;\">Power_Systems_and_Electrical_Machines (ALL 3 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
