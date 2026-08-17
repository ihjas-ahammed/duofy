# Duofy Reusable Lesson Format: Vibration Isolation (Transmissibility & Critical Shaft Whirling)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Free_and_Forced_Mechanical_Vibrations`  
**Lesson Format Type:** `vibration_isolation_force_transmissibility_and_shaft_whirling`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify vibration isolation mounting design, force transmissibility, damping trade-offs, and critical shaft whirling speeds in rotating turbomachinery (Singiresu S. Rao *Mechanical Vibrations* Chapter 9; William T. Thomson *Theory of Vibration with Applications* Chapter 3; Henry H. Jeffcott 1919): master the **Force Transmissibility Ratio ($\mathbf{TR}$)**:
$$\mathbf{TR = \frac{F_{\text{transmitted}}}{F_{\text{excitation}}} = \sqrt{\frac{1 + (2\zeta r)^2}{(1 - r^2)^2 + (2\zeta r)^2}} \quad \left(r = \frac{\omega}{\omega_n}\right)}$$
prove the **Vibration Isolation Invariant**:
$$\mathbf{\text{Vibration Isolation Exists } (TR < 1) \quad \Longleftrightarrow \quad \mathbf{r = \frac{\omega}{\omega_n} > \sqrt{2}}}$$
(proving why vibration isolation is physically impossible when $r < \sqrt{2}$ where $TR > 1$ amplifies transmitted forces, requiring engineers to design flexible mounts with low natural frequencies $\mathbf{\omega_n < \frac{\omega}{\sqrt{2}}}$); master the **Damping Paradox in Isolation** (adding damping reduces peak resonant forces when passing through $r=1$ during machine startup, but **slightly degrades isolation performance at operating speeds $\mathbf{r > \sqrt{2}}$**); master the **Jeffcott Rotor Model and Critical Whirling Speed of Rotating Shafts**:
$$\mathbf{r_{\text{whirl}} = \frac{e \cdot r^2}{\sqrt{(1 - r^2)^2 + (2\zeta r)^2}} \implies \mathbf{\omega_{\text{critical}} = \omega_n = \sqrt{\frac{k}{m}}}}$$
(analyzing why disk center of mass flips $180^\circ$ to rotate about its own geometric center when spinning above critical speed $r \gg 1$), and interact with live SDOF decay oscillator, Resonant magnification curve plotter, Transmissibility isolator designer, and Jeffcott shaft whirling animator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Force Transmissibility ($TR = \sqrt{\frac{1+(2\zeta r)^2}{(1-r^2)^2+(2\zeta r)^2}}$) & Shaft Whirling ($\omega_{\text{cr}} = \omega_n$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Vibration Isolation Parameter / Rotor Dynamic State & Technical Physical Effect Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Vibration Isolation Requires the Operating Frequency Ratio to Strictly Exceed \sqrt{2} Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Vibration Isolation (TR < 1) Occurs If and Only If the Frequency Ratio r = \omega / \omega_n Is Strictly Greater Than the Square Root of ___ (2 / Two) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Mechanical Vibrations Studio: SDOF Regimes, Resonance, Transmissibility & Shaft Whirling Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "vibration_isolation_force_transmissibility_and_shaft_whirling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Force Transmissibility (TR), when does Vibration Isolation occur, and what is Critical Shaft Whirling?",
      "blankAnswer": "Isolation & Whirling (Singiresu S. Rao; William Thomson): (1) TRANSMISSIBILITY RATIO: TR = F_trans / F_0 = sqrt((1 + (2\u03b6r)^2) / ((1 - r^2)^2 + (2\u03b6r)^2)) where r = \u03c9 / \u03c9n. (2) ISOLATION INVARIANT: Vibration isolation (TR < 1) occurs IF AND ONLY IF r > sqrt(2) (~1.414). When r < sqrt(2), TR > 1 and transmitted force is amplified! (3) DAMPING PARADOX: Damping is vital to limit peak force during startup through resonance (r=1), but for r > sqrt(2), increasing damping slightly INCREASES transmitted force. (4) WHIRLING OF SHAFTS (Jeffcott Rotor): Out-of-balance rotating shafts bow out into violent whirling orbits. The Critical Whirling Speed matches the lateral natural frequency: \u03c9_critical = \u03c9n = sqrt(k/m). Above critical speed (r >> 1), the rotor self-centers, rotating stably around its center of mass!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Vibration Isolation / Rotor Dynamics Term to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Transmissibility (TR)", "right": "Ratio of dynamic force transmitted to the foundation to the excitation force generated by the machine" },
        { "left": "Isolation Threshold (r = sqrt(2))", "right": "Boundary where TR = 1 regardless of damping ratio, above which vibration reduction occurs" },
        { "left": "Critical Whirling Speed (\u03c9_cr)", "right": "\u03c9_cr = sqrt(k / m), the rotational speed where unbalance excitation matches shaft lateral resonance" },
        { "left": "Self-Centering Regime (r >> 1)", "right": "Supercritical rotor behavior where the shaft shifts to rotate about its exact center of mass" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In structural and machinery foundation engineering, why MUST the operating frequency ratio satisfy r = \u03c9 / \u03c9n > sqrt(2) (approximately r > 1.414) in order to achieve effective vibration isolation (TR < 1)?",
      "options": [
        { "text": "Evaluating the transmissibility equation TR = sqrt((1 + (2\u03b6r)^2) / ((1 - r^2)^2 + (2\u03b6r)^2)) reveals that at r = sqrt(2), the denominator term (1 - r^2)^2 = (1 - 2)^2 = 1, making the numerator and denominator identical so that TR = 1.0 for all damping values; for any operating frequency ratio below sqrt(2) (r < 1.414), TR is strictly greater than 1.0, meaning the elastic mount actually amplifies dynamic forces transmitted into the floor; effective vibration reduction (TR < 1.0) occurs only in the supercritical zone r > sqrt(2), requiring soft mounts with low natural frequencies", "isCorrect": true, "explanation": "Correct! This is Singiresu S. Rao and William Thomson's mathematical proof of vibration isolation (*Mechanical Vibrations* Chapter 9). 1. **Analyze the Transmissibility Equation:** $$TR = \\sqrt{\\frac{1 + (2\\zeta r)^2}{(1 - r^2)^2 + (2\\zeta r)^2}}$$ 2. **Evaluate at $r = \\sqrt{2}$ ($r^2 = 2$):** - Numerator: $1 + (2\\zeta r)^2$. - Denominator: $(1 - 2)^2 + (2\\zeta r)^2 = (-1)^2 + (2\\zeta r)^2 = 1 + (2\\zeta r)^2$. - Therefore, at $r = \\sqrt{2}$, **$TR = 1.0$ for ANY damping ratio $\\zeta$**! 3. **The Two Regimes:** - **Subcritical Zone ($r < \\sqrt{2}$):** $(1 - r^2)^2 < 1 \\implies$ Denominator is smaller than numerator $\\implies \\mathbf{TR > 1.0}$ (**Vibration is amplified!**). - **Supercritical Isolation Zone ($r > \\sqrt{2}$):** $(1 - r^2)^2 > 1 \\implies$ Denominator is larger than numerator $\\implies \\mathbf{TR < 1.0}$ (**Vibration is successfully isolated!**). 4. **Engineering Rule:** To achieve $90\\%$ isolation ($TR = 0.10$), engineers typically design mounts such that $r = \\frac{\\omega}{\\omega_n} \\ge 3.0$ to $4.0$!" },
        { "text": "Because square root of 2 is the speed of sound in steel", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because foundation concrete disintegrates at frequency ratios below 1.414", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because motors cannot spin at frequencies below the natural frequency", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Vibration isolation (TR < 1) is achieved if and only if the operating frequency ratio r = \u03c9 / \u03c9n is strictly greater than the square root of ___.",
      "blankAnswer": "2",
      "blankDistractors": ["3", "4", "5"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Mechanical Vibrations Studio: SDOF, Resonance & Isolation",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Mechanical Vibrations & Dynamics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">SDOF Damping, Resonant MF, Transmissibility & Whirling</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnSdof\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. SDOF Free Damping (\u03b6 = 0.20)</button><button id=\"btnRes\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Resonant MF (10x Peak)</button><button id=\"btnIso\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Vibration Isolation (r > \u221a2)</button></div><div id=\"vibLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate SDOF damped vibration...</div><script>document.getElementById('btnSdof').onclick=()=>{document.getElementById('vibLog').innerHTML='<b>1. SDOF UNDERDAMPED FREE VIBRATION:</b><br>• m=100kg, k=40kN/m &rarr; \\u03c9n = 20 rad/s<br>• c = 800 N\\u00b7s/m &rarr; \\u03b6 = 0.20 (Underdamped)<br>• <b style=\"color:#10b981;\">\\u03c9d = \\u03c9n * sqrt(1 - \\u03b6^2) = 19.60 rad/s!</b>';}; document.getElementById('btnRes').onclick=()=>{document.getElementById('vibLog').innerHTML='<b>2. HARMONIC FORCED RESONANCE (r = 1.0):</b><br>• Excitation matches natural frequency (r = 1.0)<br>• Phase lag: <b style=\"color:#38bdf8;\">\\u03c6 = 90\\u00b0 (Force in phase with velocity!)</b><br>• Dynamic Amplification: MF_res = 1/(2\\u03b6) = 10.0x static!';}; document.getElementById('btnIso').onclick=()=>{document.getElementById('vibLog').innerHTML='<b>3. VIBRATION ISOLATION \\& SHAFT WHIRLING:</b><br>• Isolation boundary: <b style=\"color:#10b981;\">r > sqrt(2) = 1.414 (TR < 1.0)</b><br>• Operating at r = 3.5 &rarr; TR = 0.088 (91.2% Force Isolation!)<br>• Jeffcott Rotor: Above \\u03c9_cr, shaft self-centers on mass center!<br>🏆 <b style=\"color:#10b981;\">Theory of Machines & Vibrations 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
