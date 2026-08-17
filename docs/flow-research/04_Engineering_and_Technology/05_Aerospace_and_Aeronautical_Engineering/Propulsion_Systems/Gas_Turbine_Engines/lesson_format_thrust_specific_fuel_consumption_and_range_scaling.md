# Duofy Reusable Lesson Format: Fuel Economy (TSFC Metrics & Breguet Range Scaling)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Propulsion_Systems / Gas_Turbine_Engines`  
**Lesson Format Type:** `thrust_specific_fuel_consumption_and_range_scaling`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the economics and flight performance metrics of aircraft propulsion systems, the definition and units of **Thrust Specific Fuel Consumption ($TSFC$ or $c_t$)**, the fundamental physical relationship linking $TSFC$ to overall engine efficiency ($TSFC = \frac{u_0}{\eta_o \cdot h_{\text{PR}}}$), Louis Breguet's classical **Breguet Jet Range Equation ($R = \frac{V}{g \cdot TSFC} (\frac{L}{D}) \ln(\frac{W_i}{W_f})$)**, the impact of high-bypass turbofans on airline operational fuel burn, and environmental emissions scaling (Jack D. Mattingly *Elements of Propulsion: Gas Turbines and Rockets* 2nd ed. Chapter 4; John D. Anderson Jr. *Aircraft Performance and Design* Chapter 5; Louis Breguet 1921): formulate the **Thrust Specific Fuel Consumption Master Formulation**:
$$\mathbf{TSFC = \frac{\dot{m}_f}{F} = \frac{u_0}{\eta_o \cdot h_{\text{PR}}} \quad \left[\frac{\text{kg}}{\text{N}\cdot\text{s}} \text{ or } \frac{\text{g}}{\text{kN}\cdot\text{s}} \text{ or } \frac{\text{lbm}}{\text{lbf}\cdot\text{hr}}\right]}$$
where:
1. **$TSFC$:** Fuel mass flow rate consumed per unit thrust output produced;
2. **$\dot{m}_f$:** Fuel consumption rate ($\text{kg/s}$);
3. **$F$:** Engine net thrust ($\text{N}$);
4. **$u_0$:** Aircraft flight velocity ($\text{m/s}$);
5. **$\eta_o = \eta_{\text{th}} \cdot \eta_p$:** Overall thermal-propulsive engine efficiency;
6. **$h_{\text{PR}}$:** Lower heating value of aviation fuel ($43.0\text{ MJ/kg}$);
derive the **Breguet Jet Range Equation ($R$)**:
$$\mathbf{R = \left( \frac{V_\infty}{g \cdot TSFC} \right) \left( \frac{L}{D} \right) \ln\left( \frac{W_{\text{initial}}}{W_{\text{final}}} \right) = \left( \frac{\eta_o \cdot h_{\text{PR}}}{g} \right) \left( \frac{L}{D} \right) \ln\left( \frac{W_i}{W_f} \right) \quad [\text{meters}]}$$
and interact with live Turbofan thrust split solver, Propulsive/thermal efficiency calculator, Joule-Brayton station temperature plotter, and Breguet range & TSFC flight simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TSFC ($TSFC = \frac{\dot{m}_f}{F} = \frac{u_0}{\eta_o h_{\text{PR}}}$), Breguet Range ($R = \frac{V}{g TSFC}\frac{L}{D}\ln\frac{W_i}{W_f}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate TSFC, Overall Engine Efficiency, and Total Transoceanic Flight Range Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Propulsion Economy Entity / Flight Range Parameter & Technical Aeronautical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Aircraft Flight Mechanics, Maximizing Overall Engine Efficiency $\eta_o$ Directly Reduces the Thrust Specific Fuel Consumption, Leading to a Proportionate Increase in Aircraft Flight ___ (Range / Cruise Range) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Aerospace Propulsion Studio: Turbofan Thrust, Efficiencies Triad, Brayton Cycle & TSFC Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "thrust_specific_fuel_consumption_and_range_scaling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Thrust Specific Fuel Consumption (TSFC), and how does it govern the Breguet flight range equation for jet aircraft?",
      "blankAnswer": "Propulsion Economy \\& Range Mechanics (Mattingly 2006; Breguet 1921): (1) TSFC DEFINITION: TSFC = \u1e41f / F = u0 / (\u03b7o * h_PR), fuel mass burn rate required to generate one unit of net thrust (lower TSFC = superior fuel efficiency). (2) BREGUET JET RANGE FORMULA: Range R = [ V\u221e / (g * TSFC) ] * (L / D) * ln(W_initial / W_final). (3) OVERALL EFFICIENCY LINK: Range R = [ (\u03b7o * h_PR) / g ] * (L / D) * ln(W_i / W_f). Slighting TSFC via high-bypass turbofans directly multiplies commercial airliner flight range and passenger payload capacity!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the TSFC of a turbofan engine and determine the total cruise range of an airliner.",
      "orderItems": [
        "Extract the engine net thrust F, fuel consumption rate \u1e41f, and cruise airspeed V\u221e",
        "Calculate the Thrust Specific Fuel Consumption: TSFC = \u1e41f / F (in kg/N*s)",
        "Extract aircraft aerodynamic efficiency (L/D) and takeoff vs landing weight ratio: W_initial / W_final",
        "Calculate the structural weight logarithm: ln(W_initial / W_final)",
        "Apply the Breguet Jet Range Equation: R = [ V\u221e / (g * TSFC) ] * (L / D) * ln(W_initial / W_final) to find total range"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Propulsion Economy Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Thrust Specific Fuel Consumption (TSFC)", "right": "TSFC = \u1e41f / F = u0 / (\u03b7o*h_PR), mass rate of fuel burned per unit net thrust output" },
        { "left": "Breguet Range Equation", "right": "R = [V / (g*TSFC)] * (L/D) * ln(Wi/Wf), analytical model predicting total unrefueled aircraft flight distance" },
        { "left": "Lift-to-Drag Ratio (L/D)", "right": "Aerodynamic efficiency factor measuring aircraft glide performance and aerodynamic lift generation ease" },
        { "left": "Fuel Lower Heating Value (h_PR)", "right": "Chemical thermal energy density (\u2248 43 MJ/kg for Jet-A kerosene) released during isobaric combustion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In aircraft flight mechanics, maximizing overall engine efficiency \u03b7o directly reduces the thrust specific fuel consumption, leading to a proportionate increase in aircraft flight ___.",
      "blankAnswer": "range",
      "blankDistractors": ["altitude", "weight", "drag"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Aerospace Propulsion & Gas Turbine Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Aircraft Propulsion & Gas Turbine Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Turbofan Thrust, Efficiencies Triad, Brayton Cycle & TSFC</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnF\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Turbofan Thrust (FN = 55.95 kN)</button><button id=\"btnEta\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Efficiency (\u03b7p=83.3%, \u03b7o=44.7%)</button><button id=\"btnTsfc\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Brayton (Tt3=678K) & Breguet Range</button></div><div id=\"propLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate turbofan thrust generation...</div><script>document.getElementById('btnF').onclick=()=>{document.getElementById('propLog').innerHTML='<b>1. TURBOFAN MOMENTUM THRUST SPLIT:</b><br>• Bypass Ratio: \\u03b1 = 9.00 | Core Air: \\u1e41_core = 50 kg/s, Bypass: \\u1e41_fan = 450 kg/s<br>• Core Thrust: 10.95 kN + Fan Thrust: 45.00 kN<br>• <b style=\"color:#10b981;\">Total Uninstalled Net Thrust: FN = 55.95 kN (Fan = 80.4%)!</b>';}; document.getElementById('btnEta').onclick=()=>{document.getElementById('propLog').innerHTML='<b>2. JET ENGINE EFFICIENCIES TRIAD:</b><br>• Propulsive: \\u03b7p = 2*u0 / (u9 + u0) = 500 / 600 = <b style=\"color:#10b981;\">83.33%!</b><br>• Thermal: \\u03b7th = 53.67%<br>• <b style=\"color:#38bdf8;\">Overall Flight Efficiency: \\u03b7o = \\u03b7th * \\u03b7p = 44.72%!</b>';}; document.getElementById('btnTsfc').onclick=()=>{document.getElementById('propLog').innerHTML='<b>3. JOULE-BRAYTON CYCLE \\& BREGUET RANGE:</b><br>• Compressor: Tt3 = 678 K | Turbine: Tt5 = 1102 K (Work Balance)<br>• TSFC: \\u1e41f / F = u0 / (\\u03b7o * h_PR) &rarr; <b style=\"color:#10b981;\">Low Fuel Burn!</b><br>• <b style=\"color:#38bdf8;\">Breguet Range: R = [V / (g*TSFC)] * (L/D) * ln(Wi / Wf)!</b><br>🏆 <b style=\"color:#10b981;\">05_Aerospace_and_Aeronautical_Engineering (ALL 4 SUBDISCIPLINES / ALL 4 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
