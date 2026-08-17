# Duofy Reusable Lesson Format: CNC Programming (G-Code Interpolations & Coordinate Systems)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / CNC_Machining_and_Tool_Life`  
**Lesson Format Type:** `cnc_g_code_programming_interpolations_and_coordinate_systems`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify computer numerical control (CNC) automated part manufacturing, ISO 6983 standard G-code/M-code programming, interpolation kinematics, and coordinate reference frames in CNC lathe and mill machining (ISO 6983 / EIA RS-274-D; Serope Kalpakjian & Steven R. Schmid *Manufacturing Engineering and Technology* Chapter 37; Mikell P. Groover *Fundamentals of Modern Manufacturing* Chapter 37): contrast **Absolute Positioning ($\mathbf{G90}$, all coordinates referenced from a fixed workpiece zero datum $X_0, Y_0, Z_0$)** vs **Incremental Positioning ($\mathbf{G91}$, each coordinate move referenced relative to current cutter tool position)**; master **Primary G-Code Motion Commands**:
1. **$\mathbf{G00}$ (Rapid Non-Cutting Positioning):** Drives servo motors at maximum traverse rate without cutting metal;
2. **$\mathbf{G01}$ (Linear Cutting Interpolation):** Moves tool in a straight line at controlled feed rate $F$ ($\text{mm/min}$ or $\text{mm/rev}$);
3. **$\mathbf{G02}$ (Circular Interpolation Clockwise CW)** & **$\mathbf{G03}$ (Circular Interpolation Counter-Clockwise CCW):** Cuts circular contours and corner fillets using radius $\mathbf{R}$ or arc center offsets $\mathbf{I, J, K}$;
master **Spindle Velocity Control**:
$$\mathbf{\text{G96 S\dots (Constant Surface Speed in m/min: } N = \frac{1000 v}{\pi D}\text{ increases RPM as tool approaches center)}} \quad \text{vs} \quad \mathbf{\text{G97 S\dots (Fixed RPM Mode)}}$$
master **Auxiliary M-Codes ($\mathbf{M03}$ Spindle CW, $\mathbf{M05}$ Spindle Stop, $\mathbf{M06}$ Automatic Tool Change, $\mathbf{M08/M09}$ Coolant On/Off, $\mathbf{M30}$ Program End & Rewind)**, and interact with live Merchant's circle solver, Taylor tool life optimizer, Spindle power calculator, and CNC G-code visual toolpath simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CNC G-Code Matrix (G00/G01/G02/G03, G90/G91, G96/G97) & M-Codes Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | CNC Preparatory G-Code / M-Code & Controller Machine Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Constant Surface Speed (G96) Is Essential When Facing a Large Diameter Disk on a CNC Lathe Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The ISO G-Code Command for Clockwise Circular Interpolation Is ___ (G02 / G2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive CNC Machining & Tool Life Studio: Merchant's Circle, Taylor Life, Power & G-Code Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cnc_g_code_programming_interpolations_and_coordinate_systems",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the core ISO G-Codes, M-Codes, and Coordinate Modes in CNC Machining?",
      "blankAnswer": "CNC Programming (Kalpakjian; Groover): (1) MOTION CODES: G00 (Rapid traverse without cutting), G01 (Linear cutting at feed F), G02 (Circular interpolation Clockwise CW), G03 (Circular interpolation Counter-Clockwise CCW). (2) COORDINATE MODES: G90 (Absolute coordinates from part origin datum), G91 (Incremental coordinates from current tool position). (3) SPINDLE CONTROL: G96 (Constant Surface Speed CSS, auto-adjusting RPM N = 1000*v / (\u03c0*D)), G97 (Direct constant RPM). (4) AUXILIARY M-CODES: M03 (Spindle CW), M05 (Spindle Stop), M06 (Tool Change), M08 (Coolant On), M09 (Coolant Off), M30 (Program End and Rewind)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each ISO CNC G-Code / M-Code to its exact Controller Action.",
      "matchPairs": [
        { "left": "G01 X... Z... F...", "right": "Linear cutting motion along a straight trajectory at programmed feed rate F" },
        { "left": "G02 X... Z... R...", "right": "Clockwise circular arc cutting interpolation using specified fillet radius R" },
        { "left": "G90 Coordinate Mode", "right": "Absolute positioning where all axis target coordinates reference a single workpiece origin" },
        { "left": "G96 S... Mode", "right": "Constant surface speed control dynamically ramping spindle RPM as workpiece diameter changes" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In precision CNC lathe turning, why is the Constant Surface Speed mode (G96) universally commanded when performing facing cuts from the outer rim (e.g. D = 200 mm) down to the center axis (D = 0 mm)?",
      "options": [
        { "text": "As the cutting tool travels radially inward from the outer diameter toward the center, the cutting diameter D continuously decreases; under a fixed rotational RPM (G97), the linear surface cutting velocity (v = \u03c0*D*N / 1000) would collapse toward zero, causing severe surface roughness degradation, built-up edge formation, and tool chatter; in contrast, G96 dynamically accelerates the spindle RPM in real time to maintain a constant optimal cutting velocity v, ensuring uniform surface finish (Ra) and consistent tool life across the entire face", "isCorrect": true, "explanation": "Correct! This is Serope Kalpakjian and Mikell Groover's fundamental explanation for CNC constant surface speed programming (*Manufacturing Engineering and Technology* Chapter 37; *Fundamentals of Modern Manufacturing* Chapter 37). 1. **The Kinematic Velocity Formula:** $$v = \\frac{\\pi D N}{1000} \\implies N = \\frac{1000 v}{\\pi D}$$ 2. **The Problem with Fixed RPM (G97):** - If spindle speed is fixed at $N = 500\\text{ RPM}$: - At outer diameter $D = 200\\text{ mm}$, $v = \\frac{\\pi (200)(500)}{1000} \\approx \\mathbf{314\\text{ m/min}}$ (Optimal). - At inner diameter $D = 20\\text{ mm}$, $v = \\frac{\\pi (20)(500)}{1000} \\approx \\mathbf{31.4\\text{ m/min}}$ ($90\\%$ velocity loss!). - At center $D = 0\\text{ mm}$, $v = 0\\text{ m/min}$! 3. **The G96 Advantage:** - G96 continuously increases spindle RPM as $D$ shrinks ($N \\propto 1/D$). - This maintains constant cutting speed $v = 300\\text{ m/min}$ and constant chip shear mechanics, producing a mirror-flat uniform surface finish!" },
        { "text": "Because CNC machines cannot rotate at fixed speeds", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because G96 disables electrical coolant pumps to save power", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because tools melt if the spindle speed changes during a cut", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The standard ISO G-code command for clockwise circular cutting interpolation is ___.",
      "blankAnswer": "G02",
      "blankDistractors": ["G00", "G01", "G03"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive CNC Machining & Tool Life Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>CNC Machining & Tool Life Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Merchant's Circle, Taylor Tool Life, Power & CNC G-Code</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnMerch\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Merchant Shear (\u03c6 = 28.3\u00b0)</button><button id=\"btnTay\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Taylor Life (T=4 min @ 200m/min)</button><button id=\"btnCnc\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Spindle Power & CNC G-Code</button></div><div id=\"cncLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Merchant cutting mechanics...</div><script>document.getElementById('btnMerch').onclick=()=>{document.getElementById('cncLog').innerHTML='<b>1. MERCHANT ORTHOGONAL CUTTING:</b><br>• t0 = 0.25mm, tc = 0.50mm &rarr; rc = 0.50, \\u03b1 = +10\\u00b0<br>• tan(\\u03c6) = (0.5*cos10\\u00b0) / (1 - 0.5*sin10\\u00b0) = 0.5392<br>• <b style=\"color:#10b981;\">Shear Angle: \\u03c6 = 28.33\\u00b0 (Primary Shear Zone)!</b>';}; document.getElementById('btnTay').onclick=()=>{document.getElementById('cncLog').innerHTML='<b>2. TAYLOR TOOL LIFE (v*T^n = C):</b><br>• Carbide n = 0.25, v1 = 100 m/min &rarr; T1 = 64 min<br>• Doubling speed to v2 = 200 m/min &rarr; <b style=\"color:#38bdf8;\">T2 = 4.0 min!</b><br>• Minimum cost speed optimization v_opt prevents excessive tool wear!';}; document.getElementById('btnCnc').onclick=()=>{document.getElementById('cncLog').innerHTML='<b>3. SPINDLE POWER \\& CNC G-CODE:</b><br>• Turning Power: uc=3.0 J/mm^3, MRR=1500 mm^3/s &rarr; P_motor = 5.625 kW<br>• CNC G-Code: G90 G96 S200 M03 | G00 X50 Z2 | G01 Z-40 F0.25 | G02 X60 Z-45 R5 | M30<br>🏆 <b style=\"color:#10b981;\">CNC Machining and Tool Life 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
