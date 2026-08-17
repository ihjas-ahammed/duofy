# Duofy Reusable Lesson Format: Spillway Hydraulics (Ogee Crest Rating & Cavitation)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Surface_Water_Hydrology_and_Dams`  
**Lesson Format Type:** `spillway_ogee_crest_hydraulics_and_discharge_capacity`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the hydraulic design and discharge rating of **Ogee (WES / USBR Standard) Crest Spillways**, the profile shape matching the lower nappe of an aerated sharp-crested weir, the discharge coefficient ($C_d$ / $C_0 \approx 2.18 - 2.22$ SI Metric or $3.95 - 4.02$ US Customary), effective spillway crest length ($L_e = L - 2(N K_p + K_a)H_e$ accounting for pier and abutment contractions), the effect of operating heads ($H > H_d$ causing sub-atmospheric negative pressures and **Cavitation Pitting**, versus $H < H_d$ causing positive backpressure and reduced discharge efficiency) (USBR *Design of Small Dams* 3rd ed. Chapter 9; Ven Te Chow *Open-Channel Hydraulics* Chapter 14): formulate the **Ogee Spillway Discharge Master Equation**:
$$\mathbf{Q = C_d \cdot L_e \cdot H_e^{3/2} \quad \left(H_e = \text{Total Energy Head above Crest } = H + \frac{V_a^2}{2g}\right)}$$
derive the **Effective Spillway Crest Length ($L_e$)**:
$$\mathbf{L_e = L - 2 \left( N \cdot K_p + K_a \right) H_e}$$
where:
1. **$L$:** Gross clear span length of the spillway crest;
2. **$N$:** Number of intermediate bridge piers ($K_p \approx 0.01 - 0.02$ for rounded piers);
3. **$K_a$:** Abutment contraction coefficient ($K_a \approx 0.10$ for rounded abutments);
4. **$H_d$:** Design head matching the lower nappe trajectory profile:
   $$\mathbf{x^{1.85} = 2.0 \cdot H_d^{0.85} \cdot y \quad (\text{USBR / WES Standard Downstream Profile})}$$
master the **Cavitation & Negative Pressure Invariant**:
- If actual flood head exceeds design head ($\mathbf{H_e > H_d}$):
  $$\mathbf{P_{\text{crest}} < P_{\text{atm}} \implies \text{Sub-atmospheric pressures develop along the crest}}$$
  - Increases discharge coefficient ($C_d > C_0$);
  - Triggers dangerous **vapor bubble implosion (Cavitation Erosion)** that can destroy reinforced concrete spillway slabs!
and interact with live Unit hydrograph convolution calculator, Modified Puls reservoir routing simulator, Concrete gravity dam stability inspector, and Ogee spillway discharge & cavitation curve explorer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ogee Spillway Equation ($Q = C_d L_e H_e^{3/2}$), $L_e = L - 2(NK_p+K_a)H_e$ & Cavitation Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Effective Length and Discharge Capacity for an Ogee Crest Spillway Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Spillway Hydraulic Parameter / Nappe Condition & Technical Physical Consequence Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | If the Operating Water Head Above an Ogee Spillway Crest Exceeds the Design Head ($H_e > H_d$), the Pressure on the Crest Becomes Sub-Atmospheric, Creating a Risk of Concrete ___ Damage (Cavitation / Cavitation Pitting) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Surface Water Hydrology & Dam Engineering Studio: Unit Hydrographs, Routing, Dam Stability & Ogee Spillways Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "spillway_ogee_crest_hydraulics_and_discharge_capacity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How is the discharge capacity of an Ogee Crest Spillway calculated, and why is the design head (Hd) critical for avoiding cavitation?",
      "blankAnswer": "Ogee Spillway Hydraulics (USBR Small Dams; Ven Te Chow): (1) DISCHARGE FORMULATION: Q = Cd * Le * He^(3/2), where Cd \u2248 2.2 (SI metric) or 4.0 (US), and He is total energy head (H + Va^2/2g). (2) EFFECTIVE LENGTH: Le = L - 2*(N*Kp + Ka)*He accounting for pier and abutment end contractions. (3) DESIGN HEAD (Hd): The crest profile matches the lower nappe of a ventilated sharp weir: x^1.85 = 2.0*Hd^0.85*y. (4) CAVITATION HAZARD: If actual flood head He > Hd, sub-atmospheric negative pressures develop along the crest, causing vapor bubble implosions (cavitation erosion) that can destroy the concrete chute!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the flood discharge capacity of an Ogee crest spillway with bridge piers.",
      "orderItems": [
        "Determine the gross spillway crest width (L), design head (Hd), and count the number of bridge piers (N)",
        "Identify the pier contraction coefficient (Kp) and abutment contraction coefficient (Ka) based on nose shape geometry",
        "Calculate the total upstream energy head: He = H + (Va^2 / 2g) including approach velocity",
        "Compute the effective crest length: Le = L - 2*(N*Kp + Ka)*He to account for side flow contractions",
        "Evaluate discharge coefficient Cd (adjusted for He/Hd) and compute total discharge capacity: Q = Cd * Le * He^(3/2)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Spillway Hydraulic Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Effective Crest Length (Le)", "right": "Le = L - 2*(N*Kp + Ka)*He, contracted net flow width between bridge piers and abutments" },
        { "left": "Design Head (Hd)", "right": "Reference head used to shape the downstream Ogee profile matching natural lower nappe curvature" },
        { "left": "Cavitation Hazard (He > Hd)", "right": "Severe sub-atmospheric suction pressures inducing concrete surface pitting and erosion" },
        { "left": "Ogee Discharge Exponent (3/2)", "right": "Theoretical weir flow exponent relating discharge rate Q to total energy head He^(1.5)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "If the operating water head above an Ogee spillway crest exceeds the design head (He > Hd), the sub-atmospheric crest pressure creates a severe risk of concrete ___ damage.",
      "blankAnswer": "cavitation",
      "blankDistractors": ["settlement", "corrosion", "liquefaction"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hydrology & Dam Engineering Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Water Resources & Dam Engineering Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Unit Hydrographs, Modified Puls, Dam Stability & Ogee Crests</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnUh\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Unit Hydrograph (Q_peak = 135m\u00b3/s)</button><button id=\"btnPuls\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Modified Puls Routing (O2=26m\u00b3/s)</button><button id=\"btnDam\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Dam Stability (e&le;B/6) & Ogee Crest</button></div><div id=\"waterLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Unit Hydrograph convolution...</div><script>document.getElementById('btnUh').onclick=()=>{document.getElementById('waterLog').innerHTML='<b>1. UNIT HYDROGRAPH \\& CONVOLUTION:</b><br>• Qn = \\u2211(P_m * U_{n-m+1}) + Q_base<br>• Burst 1 (2cm) + Burst 2 (3cm lagged 2h)<br>• <b style=\"color:#10b981;\">Direct Runoff Peak = 130.0 m\u00b3/s (Total River: 135.0 m\u00b3/s)!</b>';}; document.getElementById('btnPuls').onclick=()=>{document.getElementById('waterLog').innerHTML='<b>2. MODIFIED PULS RESERVOIR ROUTING:</b><br>• Continuity: (2S2/\\u0394t + O2) = (I1+I2) + (2S1/\\u0394t - O1)<br>• Inflow jumped from 20 to 80 m\u00b3/s &rarr; <b style=\"color:#38bdf8;\">Outflow O2 = 26.0 m\u00b3/s!</b><br>• Major peak flood attenuation \\& storage buffering!';}; document.getElementById('btnDam').onclick=()=>{document.getElementById('waterLog').innerHTML='<b>3. DAM STABILITY \\& OGEE SPILLWAYS:</b><br>• Dam Overturning: FS_O = \\u2211MR / \\u2211MO (Middle-third: e &le; B/6)<br>• Ogee Spillway: Q = Cd * Le * He^(3/2)<br>• <b style=\"color:#ef4444;\">Cavitation Warning: He > Hd causes sub-atmospheric pitting!</b><br>🏆 <b style=\"color:#10b981;\">Hydraulics_and_Water_Resources_Engineering (ALL 2 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
