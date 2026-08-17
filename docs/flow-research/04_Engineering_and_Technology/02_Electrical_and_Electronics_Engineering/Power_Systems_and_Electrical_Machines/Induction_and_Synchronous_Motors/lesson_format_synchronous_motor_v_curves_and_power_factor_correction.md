# Duofy Reusable Lesson Format: Synchronous Condensers (V-Curves & Power Factor Control)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Induction_and_Synchronous_Motors`  
**Lesson Format Type:** `synchronous_motor_v_curves_and_power_factor_correction`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify synchronous motor excitation control, field current ($I_F$) modulation, phasor diagrams under varying excitation levels, characteristic V-curves (armature current $I_A$ versus field current $I_F$), and the application of over-excited synchronous motors as **Synchronous Condensers** for high-voltage transmission power factor correction and grid voltage stabilization (Stephen J. Chapman *Electric Machinery Fundamentals* Chapter 7; A. E. Fitzgerald *Electric Machinery* Chapter 5): master the **Phasor Equation & Constant Real Power Constraint**:
$$\mathbf{P = 3 V_{\phi} I_A \cos\theta = \text{Constant} \implies \mathbf{I_A \cos\theta = \text{Constant}} \quad \Big| \quad \mathbf{E_A \sin\delta = \text{Constant}}}$$
derive the **Three Distinct Field Excitation Regimes**:
1. **Under-Excitation ($\mathbf{E_A \cos\delta < V_{\phi}}$):**
   - Armature current lags terminal voltage ($\theta > 0, \ \text{PF lagging}$);
   - Motor acts as an **inductive load**, absorbing positive reactive power ($Q > 0$) from the grid;
2. **Normal Excitation ($\mathbf{E_A \cos\delta = V_{\phi}}$):**
   - Armature current is in phase with voltage ($\theta = 0, \ \text{PF} = 1.0$);
   - Armature current $I_A$ reaches its **absolute global minimum point on the V-Curve**;
3. **Over-Excitation ($\mathbf{E_A \cos\delta > V_{\phi}}$):**
   - Armature current leads terminal voltage ($\theta < 0, \ \text{PF leading}$);
   - Motor acts as a **capacitive bank**, supplying reactive power ($Q < 0$) into the grid;
and formulate **Synchronous Condenser Grid Power Factor Correction**:
$$\mathbf{Q_{\text{syn\_cond}} = - \left( Q_{\text{plant,inductive}} - P_{\text{plant}} \tan(\theta_{\text{target}}) \right)}$$
(proving how an unloaded over-excited synchronous motor provides smooth, infinitely variable reactive power compensation without discrete capacitor bank switching steps); and interact with live Induction motor power flow calculator, Torque-speed curve animator, Synchronous power-angle simulator, and Interactive Synchronous V-Curve explorer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | V-Curves ($I_A$ vs $I_F$), Under/Over-Excitation Phasors & Synchronous Condenser Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Excitation State / Operating Mode & Technical Grid Impact Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Over-Excited Synchronous Motors Draw Leading Current and Act as Synchronous Condensers Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | An Unloaded Over-Excited Synchronous Motor Connected to a Power Grid Solely to Supply Leading Reactive Power for Voltage Support Is a Synchronous ___ (Condenser / Capacitor) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive AC Machinery Studio: Induction Power Flow, Torque-Speed, Power Angle & V-Curves Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "synchronous_motor_v_curves_and_power_factor_correction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are Synchronous Motor V-Curves, and how does field excitation IF control power factor?",
      "blankAnswer": "Synchronous Motor V-Curves (Stephen Chapman): (1) V-CURVES: Plots of Armature Current IA vs Field Current IF at constant mechanical loads. (2) NORMAL EXCITATION: Occurs at unity power factor (PF = 1.0) where IA reaches its absolute minimum value. (3) UNDER-EXCITED (Low IF): Back EMF EA is small; motor draws LAGGING current, absorbing reactive power Q > 0 like an inductor. (4) OVER-EXCITED (High IF): Back EMF EA exceeds V\u03c6; motor draws LEADING current, generating reactive power Q < 0 like a capacitor. (5) SYNCHRONOUS CONDENSER: An unloaded over-excited synchronous motor supplying variable capacitive VARs to correct industrial factory power factors!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Excitation State to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Normal Excitation (Unity PF)", "right": "EA*cos\u03b4 = V\u03c6, armature current IA is in-phase with voltage and reaches absolute minimum magnitude" },
        { "left": "Over-Excitation (Leading PF)", "right": "EA*cos\u03b4 > V\u03c6, motor supplies reactive power (Q < 0) acting as a synchronous capacitor" },
        { "left": "Under-Excitation (Lagging PF)", "right": "EA*cos\u03b4 < V\u03c6, motor absorbs reactive power (Q > 0) from the grid like an inductor" },
        { "left": "Synchronous Condenser", "right": "Unloaded synchronous machine dedicated to providing continuously variable reactive power support" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In heavy manufacturing plants dominated by inductive loads (such as hundreds of induction motors operating at 0.75 lagging PF), why is an over-excited synchronous motor frequently installed to drive a constant-speed compressor?",
      "options": [
        { "text": "An over-excited synchronous motor generates an internal back EMF EA that exceeds the stator phase voltage (EA*cos\u03b4 > V\u03c6), forcing armature current IA to lead terminal voltage; this allows the motor to deliver useful mechanical shaft power to the compressor while simultaneously supplying leading reactive power (VARs) into the plant electrical bus, canceling the lagging inductive reactive power drawn by induction motors and correcting the overall factory power factor toward unity (1.0) without utility penalty charges", "isCorrect": true, "explanation": "Correct! This is Stephen Chapman's classic practical application of synchronous motor excitation control (*Electric Machinery Fundamentals* Chapter 7). 1. **The Industrial Factory Problem:** - Typical manufacturing facilities operate dozens of large **induction motors**, which inherently consume lagging reactive power ($Q_{\\text{ind}} > 0$) to establish their magnetic fields, depressing factory power factor to $0.70-0.80\\text{ lagging}$. - Electric utilities charge heavy financial penalties for low power factor. 2. **The Synchronous Motor Dual-Use Solution:** - By increasing the DC field excitation current $I_F$, the internal voltage $E_A$ rises. - Phasor relation: $j X_s \\mathbf{I_A} = \\mathbf{V_\\phi} - \\mathbf{E_A}$. - When $E_A \\cos\\delta > V_\\phi$, the armature current $\\mathbf{I_A}$ is forced to **lead the voltage phasor $\\mathbf{V_\\phi}$**. 3. **The Economic Benefit:** - The synchronous motor delivers **100% of its rated mechanical torque** to heavy machinery (compressors, pumps, rock crushers) while acting as a **giant, infinitely adjustable capacitor bank** that cleans up the entire factory grid!" },
        { "text": "Because synchronous motors do not require any AC power", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because over-excited motors generate DC voltage on the stator", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because induction motors cannot run without synchronous motors in parallel", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An unloaded over-excited synchronous motor connected to a power grid solely to supply leading reactive power for voltage support is a synchronous ___.",
      "blankAnswer": "condenser",
      "blankDistractors": ["generator", "resistor", "transformer"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive AC Machinery & Motor Dynamics Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>AC Machinery & Motors Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Induction Power Flow, Torque-Speed, Power Angle & V-Curves</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnInd\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Induction Power Flow (s=0.05)</button><button id=\"btnTrq\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Torque-Speed (\u03c4max=85 N\u00b7m)</button><button id=\"btnSyn\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Synchronous V-Curves & \u03b4=19\u00b0</button></div><div id=\"motLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate induction motor...</div><script>document.getElementById('btnInd').onclick=()=>{document.getElementById('motLog').innerHTML='<b>1. INDUCTION MOTOR POWER FLOW:</b><br>• Pag = 25 kW, s = 0.050 (1710 RPM)<br>• <b style=\"color:#10b981;\">P_rcu = s*Pag = 1.25 kW (Rotor Copper Loss)!</b><br>• P_conv = (1-s)*Pag = 23.75 kW (Pout = 23.25 kW / 31.2 HP)!';}; document.getElementById('btnTrq').onclick=()=>{document.getElementById('motLog').innerHTML='<b>2. INDUCTION TORQUE-SPEED CURVE:</b><br>• s_max = R2\\\' / \\u221a(Rth^2 + Xth^2) = 0.099 (1621 RPM)<br>• <b style=\"color:#38bdf8;\">\\u03c4max = 85.0 N\\u00b7m (Strictly independent of R2\\\')!</b><br>• Increasing R2\\\' shifts peak to s=1.0 for crane starting!';}; document.getElementById('btnSyn').onclick=()=>{document.getElementById('motLog').innerHTML='<b>3. SYNCHRONOUS MOTORS \\& V-CURVES:</b><br>• P_max = 153.5 kW (@ \\u03b4 = 90\u00b0), Operating \\u03b4 = 19.0\u00b0<br>• Under-excited: Lagging PF (absorbs Q)<br>• Over-excited: <b style=\"color:#10b981;\">Leading PF &rarr; Synchronous Condenser!</b><br>🏆 <b style=\"color:#10b981;\">Induction_and_Synchronous_Motors 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
