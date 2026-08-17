# Duofy Reusable Lesson Format: Respiratory Transport (Oxyhemoglobin Curve & Bohr Effect)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Human_Physiology / Cardiovascular_and_Respiratory_Physiology`  
**Lesson Format Type:** `oxyhemoglobin_dissociation_curve_and_bohr_effect`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the allosteric biochemistry and transport biophysics of hemoglobin, the sigmoidal **Oxygen-Hemoglobin Dissociation Curve** ($S$-shaped due to positive cooperativity of oxygen binding to the four heme subunits), the definition of $P_{50}$ (partial pressure of $O_2$ at which hemoglobin is $50\%$ saturated, normal $P_{50} \approx 26.8\text{ mmHg}$), physiological right-shifts versus left-shifts, the universal **"CADET face Right"** mnemonic (**C**arbon dioxide $\uparrow$, **A**cid / $\text{H}^+$ $\uparrow$ / $\text{pH} \downarrow$, 2,3-**D**PG $\uparrow$, **E**xercise $\uparrow$, **T**emperature $\uparrow$) decreasing $O_2$ affinity to facilitate peripheral tissue oxygen delivery, the **Bohr Effect** versus **Haldane Effect**, left-shifting conditions (**Fetal Hemoglobin HbF**, carbon monoxide poisoning **CO-Hb**, methemoglobinemia, hypothermia, alkalosis), and blood oxygen content calculations ($C_a O_2 = [1.34 \times [\text{Hb}] \times S_a O_2] + [0.003 \times P_a O_2]$) (John E. Hall, Michael E. Hall *Guyton and Hall Textbook of Medical Physiology* 14th ed. Chapter 41; Linda S. Costanzo *Physiology* 7th ed. Chapter 5; John B. West, Andrew M. Luks *West's Respiratory Physiology* 11th ed. Chapter 6): formulate the **Total Blood Oxygen Content Master Formulation ($C_a O_2$)**:
$$\mathbf{C_a O_2 = \left( 1.34 \times [\text{Hb}] \times \frac{S_a O_2}{100} \right) + \left( 0.0031 \times P_a O_2 \right) \quad [\text{mL } O_2 / 100\text{ mL Blood (vol\%)}]}$$
where:
1. **$[\text{Hb}]$:** Hemoglobin concentration in $\text{g/dL}$ (normal $\approx 15.0\text{ g/dL}$);
2. **$1.34$:** Hüfner's oxygen-binding capacity constant ($\text{mL } O_2 / \text{g Hb}$);
3. **$S_a O_2$:** Arterial oxyhemoglobin saturation percentage (normal $\approx 98\%$);
4. **$0.0031 \times P_a O_2$:** Physically dissolved oxygen in blood plasma ($\text{mL } O_2 / \text{dL}$);
master the **Oxygen-Hemoglobin Dissociation Curve Shift Matrix**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Curve Direction} & \textbf{Affinity for } O_2 & P_{50} \textbf{ Shift} & \textbf{Allosteric Modulators / Clinical Causes (CADET)} \\
\hline
\mathbf{\text{RIGHT SHIFT}} & \mathbf{\text{DECREASED (Unloads } O_2\text{)}} & \mathbf{P_{50} \uparrow \ (> 27\text{ mmHg})} & \mathbf{\uparrow \mathbf{C}O_2, \ \uparrow \mathbf{A}\text{cid (pH } \downarrow), \ \uparrow 2,3\text{-}\mathbf{D}\text{PG}, \ \uparrow \mathbf{E}\text{xercise}, \ \uparrow \mathbf{T}\text{emp (CADET)}} \\
\mathbf{\text{LEFT SHIFT}} & \mathbf{\text{INCREASED (Holds } O_2\text{)}} & \mathbf{P_{50} \downarrow \ (< 27\text{ mmHg})} & \mathbf{\downarrow CO_2, \ \uparrow \text{pH (Alkalosis)}, \ \downarrow 2,3\text{-DPG}, \ \downarrow \text{Temp}, \ \text{HbF, CO-Hb, Met-Hb}} \\
\hline
\end{array}$$
(proving that active skeletal muscle generates heat, $CO_2$, and lactic acid, shifting the local curve rightward to liberate maximal oxygen precisely where needed), and interact with live Left ventricular P-V loop simulator, Hemodynamic stroke volume/MAP calculator, Alveolar gas & A-a gradient solver, and Oxyhemoglobin CADET curve shift widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Oxyhemoglobin Curve Sigmoid Kinetics, $P_{50}$ & "CADET face Right" Shift Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Total Arterial Oxygen Content $C_a O_2$ Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Allosteric Effector / Clinical Hemoglobin State & Technical Physiological Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Phenomenon Whereby an Increase in Blood Carbon Dioxide Concentration and Acidity Lowers Hemoglobin's Affinity for Oxygen and Enhances Tissue Unloading Is Termed the ___ Effect (Bohr / Bohr Effect) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Cardiorespiratory Physiology Studio: P-V Loops, Hemodynamics, Alveolar Gas & Oxyhemoglobin Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "oxyhemoglobin_dissociation_curve_and_bohr_effect",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What causes the sigmoidal shape of the oxyhemoglobin curve, and what physiological factors shift the curve to the right (CADET)?",
      "blankAnswer": "Oxyhemoglobin Transport \\& Shifts (Guyton 2021; West 2021): (1) SIGMOIDAL KINETICS: Caused by positive cooperativity among the 4 heme iron subunits (binding of the 1st O2 induces a conformational shift from Tense T-state to Relaxed R-state, increasing affinity for subsequent O2 molecules). (2) P50: Normal partial pressure for 50% saturation is \u2248 26.8 mmHg. (3) RIGHT SHIFT (Decreased affinity, promotes tissue O2 unloading, P50 \u2191): Remember 'CADET face Right' \u2192 \u2191 CO2, \u2191 Acid (pH \u2193 / Bohr effect), \u2191 2,3-DPG, \u2191 Exercise, \u2191 Temperature! (4) LEFT SHIFT (Increased affinity, holds O2, P50 \u2193): \u2193 CO2, \u2191 pH (alkalosis), \u2193 2,3-DPG, \u2193 Temp, Fetal hemoglobin (HbF), Carbon Monoxide (CO-Hb)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the total oxygen content of arterial blood (CaO2).",
      "orderItems": [
        "Measure the patient's blood hemoglobin concentration [Hb] in grams per deciliter (e.g. 15.0 g/dL)",
        "Multiply hemoglobin concentration by H\u00fcfner's constant (1.34 mL O2 / g Hb) to compute maximum binding capacity",
        "Multiply binding capacity by arterial oxygen saturation fraction (SaO2 / 100) to find hemoglobin-bound oxygen",
        "Calculate dissolved plasma oxygen by multiplying arterial PaO2 by the solubility coefficient (0.0031 mL O2/dL/mmHg)",
        "Sum bound oxygen and dissolved oxygen to obtain total arterial oxygen content: CaO2 = (1.34 * [Hb] * SaO2) + (0.0031 * PaO2)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hemoglobin Transport State to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bohr Effect", "right": "High tissue CO2 and H+ promote O2 unloading by stabilizing the low-affinity Tense (T) deoxygenated state" },
        { "left": "Fetal Hemoglobin (HbF)", "right": "\u03b12\u03b32 globin tetramer lacking positive 2,3-BPG binding sites producing a LEFT shift to extract maternal O2" },
        { "left": "Carbon Monoxide (CO-Hb)", "right": "Binds heme with 240x affinity and locks remaining subunits in high-affinity state, causing a severe LEFT shift" },
        { "left": "2,3-Bisphosphoglycerate (2,3-BPG)", "right": "Glycolytic byproduct in RBCs that binds central cavity of deoxyhemoglobin, stabilizing T-state (Right shift)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The phenomenon whereby an increase in blood carbon dioxide concentration and acidity lowers hemoglobin's affinity for oxygen and enhances tissue unloading is termed the ___ effect.",
      "blankAnswer": "Bohr",
      "blankDistractors": ["Haldane", "Warburg", "Gibbs-Donnan"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Cardiorespiratory Physiology Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Cardiorespiratory Physiology Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">P-V Loops, Hemodynamics, Alveolar Gas & Oxyhemoglobin CADET</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnPv\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. P-V Loop (SV=84mL, EF=60%)</button><button id=\"btnAbg\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Alveolar Gas (A-a = 10 mmHg)</button><button id=\"btnHb\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Oxyhemoglobin CADET Shift</button></div><div id=\"phyLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate cardiac cycle P-V loops...</div><script>document.getElementById('btnPv').onclick=()=>{document.getElementById('phyLog').innerHTML='<b>1. CARDIAC P-V LOOP \\& HEMODYNAMICS:</b><br>• EDV = 140 mL, ESV = 56 mL &rarr; <b style=\"color:#10b981;\">SV = 84.0 mL, EF = 60.0%!</b><br>• MAP = 70 + (130-70)/3 = <b style=\"color:#38bdf8;\">90.0 mmHg!</b><br>• Poiseuille: r &rarr; r/2 &rarr; <b style=\"color:#10b981;\">Resistance R surges 16-fold!</b>';}; document.getElementById('btnAbg').onclick=()=>{document.getElementById('phyLog').innerHTML='<b>2. ALVEOLAR GAS EQUATION \\& A-a GRADIENT:</b><br>• PAO2 = 150 - (PaCO2/0.8) = 150 - (64/0.8) = <b style=\"color:#10b981;\">70.0 mmHg!</b><br>• <b style=\"color:#38bdf8;\">A-a Gradient = 70.0 - 60.0 = 10.0 mmHg (Normal < 15)!</b><br>• Diagnosis: Pure Alveolar Hypoventilation (Opioid overdose)!';}; document.getElementById('btnHb').onclick=()=>{document.getElementById('phyLog').innerHTML='<b>3. OXYHEMOGLOBIN CADET SHIFTS \\& BOHR EFFECT:</b><br>• RIGHT SHIFT (Unloads O2): <b style=\"color:#10b981;\">\u2191 CO2, \u2191 Acid (pH \u2193), \u2191 2,3-DPG, \u2191 Exercise, \u2191 Temp!</b><br>• LEFT SHIFT (Holds O2): \u2193 Temp, \u2191 pH, HbF (\u03b12\u03b32), Carbon Monoxide!<br>• CaO2 = (1.34 \u00d7 15 \u00d7 0.98) + (0.0031 \u00d7 100) = <b style=\"color:#38bdf8;\">20.0 vol%!</b><br>🏆 <b style=\"color:#10b981;\">Cardiovascular_and_Respiratory_Physiology 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
