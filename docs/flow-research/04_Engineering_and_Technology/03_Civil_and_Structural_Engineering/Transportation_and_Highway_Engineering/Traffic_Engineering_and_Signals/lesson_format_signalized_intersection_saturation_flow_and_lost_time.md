# Duofy Reusable Lesson Format: Signal Operations (Saturation Flow & Lost Time Mechanics)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Traffic_Engineering_and_Signals`  
**Lesson Format Type:** `signalized_intersection_saturation_flow_and_lost_time`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the micro-mechanics of discharge flow at signalized intersections, saturation headway ($h \approx 1.9\text{ s/veh}$), ideal base saturation flow rate ($s_0 = 3600 / h = 1900\text{ pc/h/ln}$), start-up lost time ($l_s \approx 2.0\text{ s}$ across the first 4 queued vehicles), yellow change and all-red clearance intervals ($Y + R_{\text{all-red}}$), clearance lost time ($l_c$), effective green time ($g = G_{\text{displayed}} + Y + R_{\text{all-red}} - t_L$), and HCM adjustment factors ($s = s_0 \cdot N \cdot f_w \cdot f_{HV} \cdot f_g \cdot f_p \cdot f_{bb} \cdot f_a \cdot f_{LU} \cdot f_{LT} \cdot f_{RT}$) (TRB *Highway Capacity Manual* Chapter 19; Roger P. Roess *Traffic Engineering* 5th ed. Chapter 18): formulate the **Base Saturation Flow Rate Master Formulation**:
$$\mathbf{s_0 = \frac{3600}{h} = \frac{3600\text{ s/h}}{1.90\text{ s/veh}} \approx \mathbf{1900\text{ pc/h/ln}}}$$
derive the **Total Phase Lost Time ($t_L$) & Effective Green Time ($g$) Formulations**:
$$\mathbf{t_L = l_s + l_c \quad \left(l_s = \text{Start-up lost time} \approx 2.0\text{ s}, \quad l_c = \text{Clearance lost time} \approx 2.0\text{ s}\right) \implies \mathbf{t_L \approx 4.0\text{ s/phase}}}$$
$$\mathbf{g = G_{\text{displayed}} + Y + R_{\text{all-red}} - t_L = G_{\text{displayed}} + Y + R_{\text{all-red}} - (l_s + l_c)}$$
derive the **Heavy Vehicle Adjustment Factor ($f_{HV}$)**:
$$\mathbf{f_{HV} = \frac{100}{100 + \%HV \left( E_T - 1 \right)} \quad (E_T = \text{Passenger Car Equivalent for Trucks} \approx 2.0)}$$
and interact with live Greenshields speed-density-flow interactive canvas, Webster optimum cycle length calculator, Signal phase green split allocator, and HCM intersection delay & LOS analyzer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Saturation Headway ($s_0 = 3600/h = 1900$), Phase Lost Time ($t_L = l_s+l_c \approx 4\text{s}$) & $f_{HV}$ Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Adjusted Saturation Flow Rate and Effective Green Time Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Signal Operational Construct / Saturation Parameter & Technical Traffic Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Base Saturation Flow Rate of an Ideal 12-Foot Traffic Lane with 1.9-Second Saturation Headway Equals Exactly ___ Passenger Cars per Hour per Lane (1900 / Nineteen Hundred) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Traffic Engineering & Signal Studio: Greenshields Flow, Webster Cycle, Green Splits & Delay Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "signalized_intersection_saturation_flow_and_lost_time",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is saturation flow rate in traffic engineering, and how are lost times and effective green times computed?",
      "blankAnswer": "Saturation Flow & Lost Time Mechanics (HCM 7th ed.): (1) SATURATION HEADWAY: h \u2248 1.90 s/veh for queued vehicles in steady discharge. (2) BASE SATURATION FLOW: s0 = 3600 / h = 3600 / 1.90 \u2248 1900 pc/h/ln. (3) LOST TIMES: Start-up lost time ls \u2248 2.0s (reaction lag of first 4 cars) + Clearance lost time lc \u2248 2.0s (unused yellow/red) \u2192 Total phase lost time tL = ls + lc \u2248 4.0 s/phase. (4) EFFECTIVE GREEN: g = G_disp + Y + R_allred - tL. (5) HEAVY VEHICLE FACTOR: f_HV = 100 / [100 + %HV*(ET - 1)], reducing capacity for trucks!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the adjusted saturation flow rate and effective green time for a signalized lane group.",
      "orderItems": [
        "Establish base ideal saturation flow rate: s0 = 1900 pc/h/ln based on standard 1.9-second saturation headway",
        "Compute geometric and traffic adjustment factors: lane width (fw), heavy vehicles (f_HV), grade (fg), and parking (fp)",
        "Multiply base rate by all adjustment factors: s = s0 * N * fw * f_HV * fg * fp * ... to get prevailing saturation flow",
        "Measure start-up lost time (ls) and clearance lost time (lc) to determine total phase lost time: tL = ls + lc",
        "Compute effective green time: g = G_displayed + Yellow + All_Red - tL for capacity and delay calculations"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Signal Saturation Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Base Saturation Flow (1900 pc/h/ln)", "right": "Maximum theoretical discharge rate achieved under ideal 12-ft lanes, zero grade, and all-passenger cars" },
        { "left": "Start-Up Lost Time (ls \u2248 2.0s)", "right": "Excess time consumed by the first 3 to 4 queued drivers perceiving the green light and accelerating" },
        { "left": "Clearance Lost Time (lc \u2248 2.0s)", "right": "Portion of the yellow change and all-red clearance interval not utilized by entering vehicles" },
        { "left": "Heavy Vehicle Factor (f_HV)", "right": "f_HV = 100 / [100 + %HV*(ET - 1)], downward adjustment factor accounting for truck sluggishness" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The base saturation flow rate of an ideal traffic lane with a 1.9-second saturation headway equals exactly ___ passenger cars per hour per lane.",
      "blankAnswer": "1900",
      "blankDistractors": ["1200", "2400", "3600"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Traffic Engineering & Signal Design Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Traffic Engineering & Signal Design Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Greenshields Flow, Webster Optimum, Green Splits & Delay</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnGreen\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Greenshields (q_max = 2400veh/h)</button><button id=\"btnWeb\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Webster Cycle (C0 = 38.3s, g1=19.2s)</button><button id=\"btnDelay\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. HCM Delay (d=21.6s &rarr; LOS C)</button></div><div id=\"trafLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Greenshields traffic stream...</div><script>document.getElementById('btnGreen').onclick=()=>{document.getElementById('trafLog').innerHTML='<b>1. GREENSHIELDS TRAFFIC FLOW:</b><br>• Speed: v = vf*(1 - k/kj) = 80*(1 - k/120)<br>• Capacity: k_cap = 60 veh/km, v_cap = 40 km/h<br>• <b style=\"color:#10b981;\">Maximum Flow: q_max = (vf*kj)/4 = 2400 veh/h/lane!</b>';}; document.getElementById('btnWeb').onclick=()=>{document.getElementById('trafLog').innerHTML='<b>2. WEBSTER OPTIMUM SIGNAL TIMING:</b><br>• C0 = (1.5L + 5) / (1 - Y) = (1.5*8 + 5) / (1 - 0.556) = <b style=\"color:#10b981;\">38.3 s!</b><br>• Effective Green: g1 = (y1/Y)*(C-L) = <b style=\"color:#38bdf8;\">19.2 s!</b><br>• Enforces identical degree of saturation X across phases!';}; document.getElementById('btnDelay').onclick=()=>{document.getElementById('trafLog').innerHTML='<b>3. INTERSECTION DELAY \\& HCM LOS:</b><br>• Webster Delay: d1 = [C*(1-\\u03bb)\u00b2] / [2*(1-v/s)] = <b style=\"color:#10b981;\">21.6 s/veh!</b><br>• <b style=\"color:#38bdf8;\">HCM Level of Service: LOS C (Satisfactory \\& Stable)</b><br>• Saturation Flow: s0 = 3600/h = 1900 pc/h/ln (tL = 4.0s)<br>🏆 <b style=\"color:#10b981;\">Transportation_and_Highway_Engineering (ALL 3 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
