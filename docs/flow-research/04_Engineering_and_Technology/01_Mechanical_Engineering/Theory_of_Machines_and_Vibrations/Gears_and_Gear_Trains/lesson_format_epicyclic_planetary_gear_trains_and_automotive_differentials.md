# Duofy Reusable Lesson Format: Epicyclic Gearing (Planetary Trains & Differentials)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Gears_and_Gear_Trains`  
**Lesson Format Type:** `epicyclic_planetary_gear_trains_and_automotive_differentials`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify planetary epicyclic kinematics, the relative tabular motion method, and automotive differential dynamics in mechanical power transmissions (Joseph E. Shigley et al. *Theory of Machines and Mechanisms* Chapter 8; Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 13): master **Epicyclic (Planetary) Gear Train Architecture** consisting of a central **Sun Gear ($S$)**, **Planet Gears ($P$)**, **Planet Carrier Arm ($A$)**, and outer internally-toothed **Ring / Annulus Gear ($R$)** with pitch geometry $\mathbf{d_R = d_S + 2 d_P \implies T_R = T_S + 2 T_P}$; master the **Relative Motion Tabular Method**:
1. Fix Planet Carrier Arm ($A = 0$), rotate Sun gear by $+x$ revolutions, computing relative speeds of Planet ($N_P/N_S = -T_S/T_P$) and Ring ($N_R/N_S = -T_S/T_R$);
2. Add $+y$ rigid-body revolutions to all components, yielding **Total Absolute Speeds**: $N_{\text{Arm}} = y$, $N_{\text{Sun}} = y + x$, and $\mathbf{N_{\text{Ring}} = y - x\left(\frac{T_S}{T_R}\right)}$;
master the **Master Epicyclic Relative Speed Formula**:
$$\mathbf{\frac{N_{\text{Ring}} - N_{\text{Arm}}}{N_{\text{Sun}} - N_{\text{Arm}}} = -\frac{T_{\text{Sun}}}{T_{\text{Ring}}}}$$
and analyze the **Automotive Differential Gearbox** (which delivers equal driving torque to both left and right road wheels while allowing wheel speed differentiation during vehicle cornering: $\mathbf{N_{\text{Carrier}} = \frac{N_{\text{Left}} + N_{\text{Right}}}{2}}$), and interact with live Involute profile generator, Undercutting tooth calculator, Compound train scaler, and Planetary gear train speed simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Epicyclic Planetary Formula ($\frac{N_R - N_A}{N_S - N_A} = -\frac{T_S}{T_R}$) & Automotive Differential Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Planetary Gear Component / Tabular Motion Step & Kinematic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why an Automotive Differential Requires Pinion Bevel Gears on a Rotating Carrier Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | In an Automotive Differential, the Rotational Speed of the Carrier Ring Gear Is Exactly the Mathematical ___ of the Left and Right Wheel Speeds (Average / Mean) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Gear Transmission Studio: Involute Teeth, Contact Ratio & Planetary Gearbox Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "epicyclic_planetary_gear_trains_and_automotive_differentials",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is an Epicyclic (Planetary) Gear Train, and how does the Tabular Method solve its speed ratios?",
      "blankAnswer": "Epicyclic Trains & Differentials (Shigley; Budynas): (1) PLANETARY ARCHITECTURE: Consists of Sun Gear (S), Planet Gears (P), Planet Carrier Arm (A), and Ring Annulus (R). Geometric constraint: T_R = T_S + 2*T_P. (2) TABULAR METHOD: Step 1: Fix Arm (A=0), give Sun +x revs -> Ring speed = -x*(T_S/T_R). Step 2: Add +y revs to all components. Absolute speeds: N_Arm = y, N_Sun = y + x, N_Ring = y - x*(T_S/T_R). (3) MASTER FORMULA: (N_Ring - N_Arm) / (N_Sun - N_Arm) = -T_Sun / T_Ring. (4) AUTOMOTIVE DIFFERENTIAL: Bevel epicyclic train that splits drive torque equally while allowing inner and outer wheels to turn at different speeds during cornering: N_Carrier = (N_Left + N_Right) / 2!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Epicyclic Gear Train Entity to its exact Technical Function.",
      "matchPairs": [
        { "left": "Sun Gear (S)", "right": "Central external gear located at the rotational axis of the planetary gearbox" },
        { "left": "Planet Carrier Arm (A)", "right": "Rotating structure supporting the planet gear shafts and transmitting arm torque" },
        { "left": "Ring / Annulus Gear (R)", "right": "Outer internally-toothed concentric gear meshing with all planet gears" },
        { "left": "Automotive Differential", "right": "Epicyclic bevel gear system averaging left and right wheel speeds during vehicle cornering" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In an automotive rear-axle differential gearbox, what kinematic mechanism enables the outer driving wheel to rotate faster than the inner driving wheel when a vehicle turns around a sharp curve?",
      "options": [
        { "text": "The engine drives the main crown ring gear (carrier), which houses free-spinning differential spider bevel pinion gears; when traveling straight, the pinions do not spin on their own pins and both axle side gears rotate at identical speeds (N_left = N_right = N_carrier); when the vehicle negotiates a turn, the inner wheel encounters higher rolling resistance and slows down, which causes the spider pinions to rotate on their pins, transferring extra rotational speed to the outer wheel while keeping the carrier speed strictly equal to the arithmetic average (N_carrier = (N_left + N_right) / 2) and splitting torque equally (50/50)", "isCorrect": true, "explanation": "Correct! This is Richard Budynas and Joseph Shigley's explanation of the automotive differential (*Shigley's Mechanical Engineering Design* Chapter 13). 1. **Straight-Line Driving:** - Both left and right wheels travel the exact same distance. - The spider bevel pinions do not rotate on their internal cross-pins ($N_{\\text{pinion/carrier}} = 0$). - Both wheels rotate at the exact speed of the ring gear carrier: $N_{\\text{left}} = N_{\\text{right}} = N_{\\text{carrier}}$. 2. **Vehicle Cornering (Turning):** - The outer wheel travels a larger turning arc radius than the inner wheel. - The inner wheel is forced to slow down by ground friction ($N_{\\text{left}} \\downarrow$). - This relative speed difference forces the differential bevel pinions to **spin on their own mounting pins**! - The spinning pinions add velocity to the outer wheel side gear ($N_{\\text{right}} \\uparrow$) by the exact amount lost by the inner wheel! 3. **The Kinematic Invariant:** $$N_{\\text{carrier}} = \\frac{N_{\\text{left}} + N_{\\text{right}}}{2}$$ 4. **Torque Balance:** Because the spider pinions act as balanced equal-arm levers, **torque is divided exactly $50/50$** between left and right wheels at all times!" },
        { "text": "Because the outer wheel is physically disconnected from the vehicle engine during turns", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the inner tire temporarily shrinks in diameter", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hydraulic oil pushes the car sideways", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an automotive differential, the rotational speed of the carrier ring gear is the mathematical ___ of the left and right wheel speeds.",
      "blankAnswer": "average",
      "blankDistractors": ["product", "difference", "square"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Gears & Transmissions Studio: Involute, Contact & Planetary",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Gears & Transmissions Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Involute Law, Contact Ratio, Compound & Planetary Gearboxes</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnInv\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Involute & Undercutting (T=18)</button><button id=\"btnComp\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Compound Train (i = 12)</button><button id=\"btnPlan\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Planetary Epicyclic Gearbox</button></div><div id=\"grLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to test involute gear geometry...</div><script>document.getElementById('btnInv').onclick=()=>{document.getElementById('grLog').innerHTML='<b>1. INVOLUTE GEAR TOOTH GEOMETRY:</b><br>• Pressure angle \\u03c6 = 20\\u00b0, Base circle: rb = rp * cos(20\\u00b0)<br>• Min teeth to avoid undercutting: <b style=\"color:#10b981;\">T_min = 2/sin^2(20\\u00b0) = 18 teeth!</b><br>• Contact Ratio CR = 1.50 (Smooth multi-tooth load sharing)!';}; document.getElementById('btnComp').onclick=()=>{document.getElementById('grLog').innerHTML='<b>2. COMPOUND TWO-STAGE REDUCTION:</b><br>• Motor: 1800 RPM @ 15 kW &rarr; Stage 1: 3:1 | Stage 2: 4:1<br>• Overall reduction: i_total = 12.0<br>• <b style=\"color:#38bdf8;\">Output: N_out = 150 RPM | Torque: \\u03c4 = 954.9 N\\u00b7m!</b>';}; document.getElementById('btnPlan').onclick=()=>{document.getElementById('grLog').innerHTML='<b>3. EPICYCLIC PLANETARY GEARBOX:</b><br>• Sun: Ts=20, Ring: Tr=80, Ring Fixed (NR = 0)<br>• (0 - NA) / (NS - NA) = -Ts / Tr &rarr; <b style=\"color:#10b981;\">NS / NA = 1 + Tr/Ts = 5.0!</b><br>• Differential Invariant: N_carrier = (N_left + N_right)/2<br>🏆 <b style=\"color:#10b981;\">Gears & Gear Trains 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
