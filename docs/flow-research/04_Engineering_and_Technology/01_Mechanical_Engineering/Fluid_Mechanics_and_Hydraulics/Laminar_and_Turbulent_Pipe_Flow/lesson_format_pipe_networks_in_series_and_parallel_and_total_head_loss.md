# Duofy Reusable Lesson Format: Piping Networks (Series, Parallel, & Network Synthesis)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Laminar_and_Turbulent_Pipe_Flow`  
**Lesson Format Type:** `pipe_networks_in_series_and_parallel_and_total_head_loss`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify complex hydraulic piping network analysis, series-parallel flow splitting, Hardy Cross loop balancing, and pump-pipeline matching in fluid mechanics (Frank M. White *Fluid Mechanics* Chapter 6; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 8): contrast **Series Piping Networks** (where flow rate is constant $\mathbf{Q_1 = Q_2 = Q_{\text{total}}}$ and total head loss is the cumulative sum of all segments: $\mathbf{h_{L,\text{total}} = h_{L,1} + h_{L,2} + \dots}$) vs **Parallel Piping Networks** (where the head loss across all branching pipes between common junction nodes is strictly equal: $\mathbf{h_{L,A} = h_{L,B} = \Delta H_{\text{junction}}}$, and total flow rate splits among branches: $\mathbf{Q_{\text{total}} = Q_A + Q_B}$); analyze the **Piping Flow Split Rule** ($\mathbf{\frac{Q_A}{Q_B} = \left(\frac{f_B L_B D_A^5}{f_A L_A D_B^5}\right)^{1/2}}$ showing that flow rate scales with $D^{2.5}$), and interact with live Hagen-Poiseuille velocity profile simulator, Moody chart friction factor calculator, and Parallel Piping Network flow split solver widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Series vs Parallel Piping Network Laws ($h_{L,\text{series}} = \sum h_i$ vs $h_{L,A} = h_{L,B}$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Piping Network Rule / Hydraulic Configuration & Governing Law Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Head Loss Across All Parallel Branches Is Identical Regardless of Diameter Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | In a Parallel Piping System, the Head Loss Across Every Individual Branch Connected Between Two Common Nodes Is Strictly ___ (Equal / Identical) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Fluid Pipe Flow Studio: Poiseuille Profile, Moody Chart & Parallel Network Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pipe_networks_in_series_and_parallel_and_total_head_loss",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do fluid flow rate (Q) and head loss (h_L) behave in Series vs Parallel piping networks?",
      "blankAnswer": "Series vs Parallel Pipe Networks (Frank M. White; Munson): (1) SERIES PIPING: Single continuous line. Flow rate is CONSTANT (Q1 = Q2 = Q_total). Total head loss is the SUM of all pipe losses (h_L_total = h_L,1 + h_L,2 + ...). (2) PARALLEL PIPING: Line branches into multiple paths and rejoins. Total flow rate is the SUM of branch flows (Q_total = Q_A + Q_B). Head loss across all parallel branches is STRICTLY EQUAL (h_L,A = h_L,B = \u0394H_nodes) because both branches connect to the same start and end pressure nodes! (3) FLOW SPLIT FORMULA: Flow automatically divides such that h_f,A = h_f,B -> Q_A / Q_B = sqrt((f_B * L_B * D_A^5) / (f_A * L_A * D_B^5)). Flow strongly favors the larger diameter pipe (scaling with D^2.5)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Piping Network Configuration to its exact Hydraulic Principle.",
      "matchPairs": [
        { "left": "Series Piping Network", "right": "Constant volumetric flow rate (Q = const) with additive cumulative head losses (h_L = sum h_i)" },
        { "left": "Parallel Piping Network", "right": "Equal head loss across all branches (h_L,1 = h_L,2) with additive flow rates (Q_total = sum Q_i)" },
        { "left": "Hardy Cross Method", "right": "Iterative loop-balancing numerical algorithm for solving multi-pipe closed loop water networks" },
        { "left": "Parallel Flow Diameter Scaling", "right": "Discharge capacity scales proportionally with pipe diameter to the 2.5 power (Q \u221d D^2.5)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In a municipal water supply network where a main pipe splits into two parallel branches (Pipe A and Pipe B) before recombining downstream, why MUST the total head loss across Branch A be strictly identical to the total head loss across Branch B (h_L,A = h_L,B), even if Pipe A is twice as long as Pipe B?",
      "options": [
        { "text": "Both Branch A and Branch B originate at the exact same upstream junction node (having unique total head H_in) and terminate at the exact same downstream junction node (having unique total head H_out); because total energy head at any physical point in space is a single-valued scalar property, the net drop in head across either path must equal the exact same physical difference (h_L,A = h_L,B = H_in - H_out); fluid automatically redistributes its volumetric flow rate between the two pipes until their respective frictional head losses balance identically", "isCorrect": true, "explanation": "Correct! This is Frank M. White and Bruce Munson's fundamental justification for parallel piping networks (*Fluid Mechanics* Chapter 6). 1. **Single-Valued Head Invariant:** - Node 1 has total piezometric head $H_1 = \\frac{P_1}{\\gamma} + z_1$. - Node 2 has total piezometric head $H_2 = \\frac{P_2}{\\gamma} + z_2$. - Any particle traveling from Node 1 to Node 2 experiences the exact same net head loss: $$\\Delta H = H_1 - H_2$$ 2. **Why Head Losses Must Match ($h_{L,A} = h_{L,B}$):** - Path A: $H_1 - h_{L,A} = H_2 \\implies h_{L,A} = H_1 - H_2$. - Path B: $H_1 - h_{L,B} = H_2 \\implies h_{L,B} = H_1 - H_2$. - Therefore, $\\mathbf{h_{L,A} = h_{L,B} = \\Delta H}$! 3. **The Self-Balancing Flow Mechanism:** - If Pipe A is longer or narrower, water encounters higher resistance, so less flow enters Pipe A ($Q_A \\downarrow$). - More flow enters Pipe B ($Q_B \\uparrow$), increasing velocity in Pipe B until $h_{L,B} = f_B \\frac{L_B}{D_B} \\frac{V_B^2}{2g}$ **rises to match $h_{L,A}$ exactly**!" },
        { "text": "Because parallel pipes are legally required to carry the same water velocity", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because gravity pulls harder on the shorter pipe", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because friction disappears in branching systems", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a parallel piping network, the total head loss across every individual branch connected between two common nodes is strictly ___.",
      "blankAnswer": "equal",
      "blankDistractors": ["additive", "zero", "variable"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Pipe Flow Studio: Poiseuille, Moody & Networks",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Laminar & Turbulent Pipe Flow Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Hagen-Poiseuille, Moody Chart & Parallel Networks</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnLam\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Laminar Flow (Re = 225)</button><button id=\"btnMood\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Moody Chart (Darcy f)</button><button id=\"btnNet\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Parallel Pipe Flow Split</button></div><div id=\"pfLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate laminar flow...</div><script>document.getElementById('btnLam').onclick=()=>{document.getElementById('pfLog').innerHTML='<b>1. HAGEN-POISEUILLE LAMINAR FLOW:</b><br>• Re = 225 &rarr; f = 64/Re = 0.284 (Roughness Independent!)<br>• Parabolic velocity profile: <b style=\"color:#10b981;\">u_max = 2.0 * V_avg</b><br>• Pressure drop: \\u0394P = 128.0 kPa across 50m pipe!';}; document.getElementById('btnMood').onclick=()=>{document.getElementById('pfLog').innerHTML='<b>2. MOODY TURBULENT FRICTION FACTOR:</b><br>• Re = 100,000, \\u03b5/D = 0.002 &rarr; Colebrook Equation<br>• Darcy Friction Factor: <b style=\"color:#38bdf8;\">f = 0.0259</b><br>• Fully rough regime: f becomes horizontal constant!';}; document.getElementById('btnNet').onclick=()=>{document.getElementById('pfLog').innerHTML='<b>3. PARALLEL PIPING NETWORK:</b><br>• Branch A (D=0.1m) vs Branch B (D=0.2m)<br>• Equal Head Loss: h_L,A = h_L,B = 5.2 m<br>• Flow splits with D^2.5 &rarr; <b style=\"color:#10b981;\">Q_B = 5.66 * Q_A!</b><br>🏆 <b style=\"color:#10b981;\">Laminar & Turbulent Pipe Flow 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
