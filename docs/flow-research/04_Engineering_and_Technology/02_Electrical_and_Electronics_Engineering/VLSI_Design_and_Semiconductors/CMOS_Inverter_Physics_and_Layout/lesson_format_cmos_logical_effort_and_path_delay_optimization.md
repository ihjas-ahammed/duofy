# Duofy Reusable Lesson Format: Gate Sizing (Logical Effort & Path Delay Optimization)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / CMOS_Inverter_Physics_and_Layout`  
**Lesson Format Type:** `cmos_logical_effort_and_path_delay_optimization`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the Method of Logical Effort developed by Ivan Sutherland, Bob Sproull, and David Harris for analytical transistor gate sizing, multistage path delay optimization, branching effort, and electrical fanout scaling in high-speed digital VLSI datapaths (Ivan Sutherland, Bob Sproull, David Harris *Logical Effort: Designing Fast CMOS Circuits* 1999; Neil Weste & David Harris *CMOS VLSI Design* Chapter 4): formulate the **Stage Delay Equation**:
$$\mathbf{d = g \cdot h + p = f + p = g \left( \frac{C_{\text{out}}}{C_{\text{in}}} \right) + p \quad (\text{Delay in Units of Inverter Normalization Constant } \tau)}$$
where:
1. **$g$ (Logical Effort):** Ratio of input capacitance of a gate to that of an inverter delivering identical output drive current:
   - Inverter: $\mathbf{g_{\text{INV}} = 1}$;
   - 2-Input NAND: $\mathbf{g_{\text{NAND2}} = \frac{2 + 2}{1 + 2} = \frac{4}{3}}$ ($n$-input NAND: $g = \frac{n + 2}{3}$);
   - 2-Input NOR: $\mathbf{g_{\text{NOR2}} = \frac{1 + 4}{1 + 2} = \frac{5}{3}}$ ($n$-input NOR: $g = \frac{2n + 1}{3}$);
   - 2-Input XOR: $\mathbf{g_{\text{XOR2}} = 4}$;
2. **$h = \frac{C_{\text{out}}}{C_{\text{in}}}$ (Electrical Effort / Fanout);**
3. **$p$ (Parasitic Delay):** Internal diffusion capacitance delay ($p_{\text{INV}} = 1, \ p_{\text{NAND}n} = n, \ p_{\text{NOR}n} = n$);
derive the **Multistage Path Optimization Protocol ($N$ Stages)**:
$$\mathbf{\text{Path Logical Effort: } G = \prod_{i=1}^N g_i \quad \Big| \quad \text{Path Branching Effort: } B = \prod_{i=1}^N b_i \quad \Big| \quad \text{Path Electrical Effort: } H = \frac{C_{\text{load}}}{C_{\text{in}}}}$$
$$\mathbf{\text{Total Path Effort: } \mathbf{F = G \cdot B \cdot H} \implies \mathbf{\text{Optimal Stage Effort: } \hat{f} = F^{1/N}}}$$
$$\mathbf{D_{\text{minimum}} = N F^{1/N} + P = N F^{1/N} + \sum_{i=1}^N p_i}$$
(proving that path delay is strictly minimized when every stage in the path bears the **exact same stage effort $\hat{f} \approx 3.59 \approx 4$**); and interact with live CMOS inverter VTC explorer, Dynamic switching power calculator, Euler path stick diagram layout animator, and Multi-stage Logical Effort delay optimizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Logical Effort ($d = gh + p$), NAND ($g = 4/3$), Path Effort ($F = GBH$) & Optimal Sizing ($\hat{f} = F^{1/N}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Logical Effort Term / Gate Property & Technical Mathematical Value Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why a 2-Input NAND Gate Has a Lower Logical Effort (g = 4/3) Than a 2-Input NOR Gate (g = 5/3) in CMOS Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | In the Method of Logical Effort, the Logical Effort of an Inverter by Definition Equals Exactly ___ (One / 1) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive CMOS Device Physics & VLSI Layout Studio: VTC, Dynamic Power, Euler Path & Logical Effort Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cmos_logical_effort_and_path_delay_optimization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Method of Logical Effort, and how does it size a multi-stage logic path for minimum propagation delay?",
      "blankAnswer": "Logical Effort (Sutherland, Sproull, & Harris 1999): (1) STAGE DELAY: d = g*h + p (in units of \u03c4), where g = logical effort, h = Cout/Cin (electrical effort), and p = parasitic delay. (2) LOGICAL EFFORT VALUES: Inverter g = 1, 2-input NAND g = 4/3, 2-input NOR g = 5/3. (3) PATH EFFORT: F = G * B * H = (\u220f g) * (\u220f b) * (C_load / C_in). (4) MINIMUM DELAY CONDITION: Delay is minimized when every stage bears the exact same stage effort: f_hat = F^(1/N). Minimum total delay: D_min = N * F^(1/N) + \u2211 p_i!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Logical Effort Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Logical Effort (g)", "right": "Ratio of a gate's input capacitance to an inverter delivering identical output drive current (NAND2 = 4/3, NOR2 = 5/3)" },
        { "left": "Electrical Effort (h)", "right": "h = Cout / Cin, capacitive fanout ratio between output load and input gate capacitance" },
        { "left": "Parasitic Delay (p)", "right": "Delay caused by internal self-loading diffusion junction capacitance (p_inv = 1, p_nand2 = 2)" },
        { "left": "Optimal Stage Effort (f_hat)", "right": "f_hat = F^(1/N), equal effort allocated across all N stages to achieve absolute minimum path delay" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In static CMOS digital standard cell design, why does a 2-input NAND gate exhibit a significantly lower Logical Effort (g = 4/3 \u2248 1.33) and faster speed than a 2-input NOR gate (g = 5/3 \u2248 1.67)?",
      "options": [
        { "text": "In a 2-input NAND gate, the NMOS transistors are in series while the PMOS transistors are in parallel; because electron mobility is higher than hole mobility (\u03bcn \u2248 2\u03bcp), stacking NMOS transistors requires sizing them to 2 units each (total input capacitance = 2 + 2 = 4 units vs 3 units for inverter \u2192 g = 4/3); in contrast, a 2-input NOR gate stacks slow PMOS transistors in series, requiring them to be sized to 4 units each (total input capacitance = 1 + 4 = 5 units \u2192 g = 5/3), making NOR gates heavily capacitive and much slower", "isCorrect": true, "explanation": "Correct! This is Ivan Sutherland, Bob Sproull, and David Harris's fundamental physical derivation in *Logical Effort: Designing Fast CMOS Circuits* (Chapter 1 & 4). 1. **Unit Inverter Baseline ($g = 1.0$):** - An inverter sized for equal pull-up and pull-down resistance has $\\text{NMOS} = 1$ unit and $\\text{PMOS} = 2$ units (assuming $\\mu_n / \\mu_p = 2$). - Total input capacitance = $1 + 2 = \\mathbf{3\\text{ units}}$. 2. **2-Input NAND Sizing:** - Pull-down network: Two NMOS in series $\\implies$ each must be sized to $\\mathbf{2\\text{ units}}$ to maintain unit on-resistance. - Pull-up network: Two PMOS in parallel $\\implies$ sized to $\\mathbf{2\\text{ units}}$ each. - Total input capacitance per input pin = $\\text{NMOS}(2) + \\text{PMOS}(2) = \\mathbf{4\\text{ units}}$. - $$\\mathbf{g_{\\text{NAND2}} = \\frac{4}{3} \\approx 1.33}$$ 3. **2-Input NOR Sizing:** - Pull-down network: Two NMOS in parallel $\\implies$ sized to $\\mathbf{1\\text{ unit}}$ each. - Pull-up network: Two PMOS in series $\\implies$ each must be sized to $\\mathbf{4\\text{ units}}$ to overcome poor hole mobility! - Total input capacitance per input pin = $\\text{NMOS}(1) + \\text{PMOS}(4) = \\mathbf{5\\text{ units}}$. - $$\\mathbf{g_{\\text{NOR2}} = \\frac{5}{3} \\approx 1.67}$$ 4. **Industry Architectural Takeaway:** This is why static CMOS microprocessor designers **heavily prioritize NAND-based logic trees over NOR gates** in critical speed paths!" },
        { "text": "Because NOR gates do not follow Ohm's law", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because NAND gates only conduct in one direction", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because NOR gates require double supply voltage", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Method of Logical Effort, the logical effort g of a standard symmetric CMOS inverter by definition equals exactly ___.",
      "blankAnswer": "1",
      "blankDistractors": ["0", "2", "4/3"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive CMOS Device Physics & VLSI Layout Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>CMOS Physics & Layout Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">VTC, Dynamic Power, Euler Path & Logical Effort</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnVtc\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Inverter VTC (Wp = 2.5 Wn, VM=0.9V)</button><button id=\"btnPwr\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Dynamic Power (P = \u03b1*CL*VDD^2*f)</button><button id=\"btnLe\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Euler Path & Logical Effort (NAND=4/3)</button></div><div id=\"vlsiLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate CMOS inverter VTC...</div><script>document.getElementById('btnVtc').onclick=()=>{document.getElementById('vlsiLog').innerHTML='<b>1. INVERTER VTC \\& THRESHOLD:</b><br>• \\u03bcn/\\u03bcp = 2.5 &rarr; <b style=\"color:#10b981;\">Wp = 1.25 \\u03bcm = 2.5 * Wn (0.5 \\u03bcm)!</b><br>• VM = VDD/2 = 0.90 V (Equal NML \\& NMH)!<br>• Region C: Both NMOS and PMOS in Saturation!';}; document.getElementById('btnPwr').onclick=()=>{document.getElementById('vlsiLog').innerHTML='<b>2. DYNAMIC POWER \\& RC DELAY:</b><br>• P_dyn = 0.15 * 10 nF * (0.8V)^2 * 2.5 GHz = <b style=\"color:#38bdf8;\">2.40 W!</b><br>• Quadratic scaling: P \\u221d VDD^2 (DVFS efficiency)!<br>• Propagation delay: tpd = 0.69 * Req * CL';}; document.getElementById('btnLe').onclick=()=>{document.getElementById('vlsiLog').innerHTML='<b>3. EULER PATH \\& LOGICAL EFFORT:</b><br>• AOI21: Common Euler Path [C-A-B] (0 diffusion breaks!)<br>• Logical Effort: Inverter g=1, NAND2 g=4/3, NOR2 g=5/3<br>• Path Sizing: <b style=\"color:#10b981;\">f_hat = F^(1/N) for minimum delay!</b><br>🏆 <b style=\"color:#10b981;\">CMOS_Inverter_Physics_and_Layout 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
