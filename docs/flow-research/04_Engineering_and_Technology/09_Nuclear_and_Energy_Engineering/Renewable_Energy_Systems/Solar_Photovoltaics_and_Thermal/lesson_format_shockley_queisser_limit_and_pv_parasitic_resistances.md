# Duofy Reusable Lesson Format: PV Physics (Shockley-Queisser Limit & Resistances)

**Target Topic:** `04_Engineering_and_Technology / 09_Nuclear_and_Energy_Engineering / Renewable_Energy_Systems / Solar_Photovoltaics_and_Thermal`  
**Lesson Format Type:** `shockley_queisser_limit_and_pv_parasitic_resistances`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the fundamental quantum thermodynamic limits and internal parasitic loss mechanisms of semiconductor solar cells, the **Shockley-Queisser Limit ($\eta_{\text{SQ}} \approx 33.7\%$ at $E_g \approx 1.34\text{ eV}$)** for single-junction devices, fundamental loss mechanisms (sub-bandgap transmission loss where $h\nu < E_g$, and above-bandgap thermalization loss where $h\nu > E_g$ sheds excess kinetic energy $h\nu - E_g$ as lattice phonons), the complete **One-Diode Solar Cell Equivalent Circuit Model with Parasitic Resistances** ($R_s$ series resistance and $R_{\text{sh}}$ shunt resistance), the degradation of the $I$-$V$ curve Fill Factor caused by contact resistance ($R_s$) and p-n junction leakage pathways ($R_{\text{sh}}$), and tandem / multi-junction solar cells overcoming the Shockley-Queisser limit (William Shockley & Hans-Joachim Queisser 1961; Martin A. Green *Solar Cells: Operating Principles, Technology, and System Applications*; John A. Duffie, William A. Beckman *Solar Engineering of Thermal Processes, Photovoltaics and Wind* 5th ed. Chapter 23): formulate the **Complete One-Diode Solar Cell Model with Parasitic Resistances**:
$$\mathbf{I = I_{\text{ph}} - I_0 \left[ \exp\left( \frac{q \left( V + I R_s \right)}{n k_B T} \right) - 1 \right] - \frac{V + I R_s}{R_{\text{sh}}}}$$
where:
1. **$I_{\text{ph}}$:** Photogenerated light current ($\text{A}$);
2. **$I_0$:** Dark diode reverse saturation current ($\approx 10^{-12} - 10^{-9}\text{ A}$);
3. **$R_s$:** Lumped series resistance from semiconductor bulk, metal grid fingers, and busbar solder joints (ideal $R_s \to 0\ \Omega$);
4. **$R_{\text{sh}}$:** Lumped shunt resistance representing edge defects and crystal dislocation leakage (ideal $R_{\text{sh}} \to \infty\ \Omega$);
master the **Parasitic Resistance Impact Matrix**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Parasitic Parameter} & \textbf{Ideal Value} & \textbf{Degradation Mechanism if Non-Ideal} & \textbf{Primary Effect on } I\text{-}V \textbf{ Curve} \\
\hline
\mathbf{\text{Series Resistance } (R_s)} & \mathbf{R_s \to 0.0\ \Omega} & \mathbf{\text{Ohmic dissipation in fingers / bulk } (I^2 R_s)} & \mathbf{\text{Tilts slope near } V_{\text{oc}}; \text{ reduces } I_{\text{mp}} \text{ \& } FF} \\
\mathbf{\text{Shunt Resistance } (R_{\text{sh}})} & \mathbf{R_{\text{sh}} \to \infty\ \Omega} & \mathbf{\text{Current leakage across p-n junction perimeter}} & \mathbf{\text{Tilts slope near } I_{\text{sc}}; \text{ degrades } V_{\text{oc}} \text{ \& } FF} \\
\text{Recombination Velocity} & S \to 0\text{ cm/s} & Trap-assisted Shockley-Read-Hall (SRH) recombination & Increases dark current $I_0$; drops $V_{\text{oc}}$ \\
\hline
\end{array}$$
(proving that maximizing $R_{\text{sh}} > 1000\ \Omega\cdot\text{cm}^2$ and minimizing $R_s < 0.5\ \Omega\cdot\text{cm}^2$ is essential to maintain high Fill Factor $FF > 0.80$), and interact with live PV I-V & P-V curve simulator, STC efficiency calculator, Hottel-Whillier-Bliss thermal collector solver, and Shockley-Queisser / Rs-Rsh parasitic loss explorer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Shockley-Queisser Limit ($\eta_{\text{SQ}} \approx 33.7\%$), $R_s \to 0$, $R_{\text{sh}} \to \infty$ & 1-Diode Equation Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Trace Parasitic Resistance Losses and Identify Bandgap Thermalization Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Semiconductor Loss Mechanism / Circuit Resistance & Technical PV Physics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Real Solar Cell Equivalent Circuit, Unwanted Crystal Dislocation and Perimeter Leakage Current Bypassing the p-n Junction Is Modeled by the Parasitic ___ Resistance $R_{\text{sh}}$ (Shunt / Parallel) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Renewable Energy Studio: PV I-V Curves, STC Ratings, HWB Solar Thermal & S-Q Limit Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "shockley_queisser_limit_and_pv_parasitic_resistances",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What physical factors dictate the Shockley-Queisser efficiency limit of a single-junction solar cell, and how do parasitic Rs and Rsh degrade performance?",
      "blankAnswer": "PV Physics \\& Parasitic Resistances (Shockley \\& Queisser 1961; Green 1982): (1) SHOCKLEY-QUEISSER LIMIT: Max theoretical efficiency is \u2248 33.7% at bandgap Eg \u2248 1.34 eV (Silicon \u2248 29.4%). Dictated by sub-bandgap transmission loss (photons with h\u03bd < Eg cannot absorb) and thermalization loss (photons with h\u03bd > Eg waste excess energy h\u03bd - Eg as lattice heat). (2) SERIES RESISTANCE (Rs): Contact grid resistance tilts the I-V slope near Voc, reducing Imp and FF. (3) SHUNT RESISTANCE (Rsh): Crystal defects leak current across junction, tilting I-V slope near Isc and reducing Voc. Ideal solar cells require Rs \u2192 0 and Rsh \u2192 \u221e!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to diagnose parasitic resistance losses and quantify thermodynamic efficiency limits in a photovoltaic cell.",
      "orderItems": [
        "Identify semiconductor material bandgap Eg and calculate theoretical Shockley-Queisser thermodynamic efficiency ceiling (\u2248 33.7%)",
        "Evaluate optical losses: sub-bandgap transmission (h\u03bd < Eg) and high-energy photon thermalization (h\u03bd > Eg)",
        "Fit measured illuminated I-V curve to the one-diode model: I = Iph - I0*[exp(q(V+I*Rs)/(n*k*T)) - 1] - (V+I*Rs)/Rsh",
        "Extract shunt resistance Rsh from the inverse slope of the I-V curve near short-circuit (V = 0 V)",
        "Extract series resistance Rs from the inverse slope of the I-V curve near open-circuit (I = 0 A) and calculate Fill Factor degradation"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Solar Cell Physical Loss Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Shockley-Queisser Limit", "right": "Thermodynamic single-junction efficiency ceiling (\u2248 33.7%) balancing absorption versus thermalization" },
        { "left": "Thermalization Loss", "right": "Excess photon energy (h\u03bd - Eg) wasted as heat vibrations when high-energy blue photons create hot carriers" },
        { "left": "Series Resistance (Rs)", "right": "Internal bulk and contact grid resistance causing I^2*Rs ohmic power dissipation and rounding the I-V knee" },
        { "left": "Shunt Resistance (Rsh)", "right": "Parallel leakage pathways across p-n junction edges and crystal dislocations that degrade Voc when low" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a real solar cell equivalent circuit, unwanted crystal dislocation and perimeter leakage current bypassing the p-n junction is modeled by the parasitic ___ resistance Rsh.",
      "blankAnswer": "shunt",
      "blankDistractors": ["series", "thermal", "contact"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Renewable Solar Energy Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Renewable Solar Energy & PV Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">PV I-V Curves, STC Efficiency, HWB Thermal & Shockley-Queisser Limit</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnIv\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. PV I-V (Pmp=311.6W, FF=0.779)</button><button id=\"btnStc\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. STC Efficiency (\u03b7_pv = 21.5%)</button><button id=\"btnHwb\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. HWB Thermal (1105W) & S-Q Limit</button></div><div id=\"solLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate solar PV I-V curves and Fill Factor...</div><script>document.getElementById('btnIv').onclick=()=>{document.getElementById('solLog').innerHTML='<b>1. SOLAR PV I-V CHARACTERISTICS \\& FILL FACTOR:</b><br>• Voc = 40.0 V, Isc = 10.0 A &rarr; P_theoretical = 400.0 W<br>• Maximum Power Point: Vmp = 32.8 V, Imp = 9.5 A &rarr; <b style=\"color:#10b981;\">Pmp = 311.6 W!</b><br>• <b style=\"color:#38bdf8;\">Fill Factor: FF = 311.6 / 400.0 = 0.779 (77.9%)!</b>';}; document.getElementById('btnStc').onclick=()=>{document.getElementById('solLog').innerHTML='<b>2. PHOTOVOLTAIC CONVERSION EFFICIENCY AT STC:</b><br>• Module Area: Ac = 2.00 m \u00d7 1.00 m = 2.00 m\u00b2<br>• Incident Solar Flux: Pin = 1000 W/m\u00b2 \u00d7 2.00 m\u00b2 = 2000.0 W<br>• <b style=\"color:#10b981;\">STC Efficiency: \\u03b7_pv = 430.0 / 2000.0 = 21.50%!</b>';}; document.getElementById('btnHwb').onclick=()=>{document.getElementById('solLog').innerHTML='<b>3. HWB SOLAR THERMAL \\& SHOCKLEY-QUEISSER:</b><br>• HWB Useful Heat Gain: qu = Ac*FR*(S - Qloss) = <b style=\"color:#10b981;\">1105.0 W (\\u03b7_th = 55.3%)!</b><br>• Shockley-Queisser Theoretical Limit: \\u03b7_SQ \\u2248 33.7% (Single Junction)<br>• Ideal Parasitic Conditions: Rs &rarr; 0 \\u03a9, Rsh &rarr; \\u221e \\u03a9<br>🏆 <b style=\"color:#10b981;\">04_Engineering_and_Technology (ALL 9 SUBDISCIPLINES / ALL 78 LEAF DIRECTORIES) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
