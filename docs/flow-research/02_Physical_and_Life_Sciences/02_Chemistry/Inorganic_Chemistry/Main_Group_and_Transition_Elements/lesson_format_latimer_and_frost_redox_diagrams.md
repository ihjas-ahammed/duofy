# Duofy Reusable Lesson Format: Latimer and Frost Redox Diagrams

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Main_Group_and_Transition_Elements`  
**Lesson Format Type:** `latimer_and_frost_redox_diagrams`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid graphical intuition and thermodynamic calculation of variable oxidation state stability: interpret **Latimer Diagrams** (reduction potentials $E^\circ$ between sequential oxidation states), calculate non-adjacent potentials via Gibbs Free Energy summation ($E_{\text{net}}^\circ = \frac{\sum n_i E_i^\circ}{\sum n_i}$), evaluate the **Disproportionation Criterion ($E_{\text{right}}^\circ > E_{\text{left}}^\circ$)**, construct and read **Frost Diagrams ($nE^\circ$ vs Oxidation State $N$)**, identify **Thermodynamic Sinks (Valleys / Local Minima)** vs **Disproportionation Centers (Peaks / Convex Points)**, and interact with live manganese oxidation state redox diagrams ($\text{Mn}^{\text{VII}} \to \text{Mn}^0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Latimer & Frost Diagrams Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Redox Diagram Feature & Thermodynamic Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Non-Adjacent Latimer Standard Reduction Potential Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Latimer Diagram Disproportionation Relative Potential Inequality Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Manganese Latimer and Frost Diagram Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "latimer_and_frost_redox_diagrams",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do Latimer and Frost diagrams quantify the thermodynamic stability and disproportionation of variable oxidation states?",
      "blankAnswer": "A Latimer Diagram summarizes standard reduction potentials E° along a horizontal series of decreasing oxidation states (e.g. ClO4- -> ClO3- -> HClO2 -> HClO -> Cl2 -> Cl-). Because potentials are non-additive, non-adjacent potentials are calculated via Delta G° = -n F E°: E°_net = (sum n_i * E°_i) / (sum n_i). An intermediate state spontaneously DISPROPORTIONATES if E°_right > E°_left (reduction to the right is more favorable than reduction of the species on the left). A Frost Diagram plots Delta G° / F = -n E° (relative free energy) against oxidation number N: (1) Species at the lowest point (valleys/minima) are thermodynamic sinks (most stable), (2) Species lying above the tie-line between its neighbors (convex peaks) spontaneously disproportionate, (3) Steep positive slopes represent powerful oxidizing couples, and steep negative slopes represent powerful reducing couples!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each feature of a Frost diagram (nE° vs oxidation state) to its thermodynamic meaning.",
      "matchPairs": [
        { "left": "Lowest Point / Deep Valley in Diagram", "right": "Thermodynamic sink (most stable oxidation state in the chemical system)" },
        { "left": "Point Located Above Tie-Line of Neighbors (Convex Peak)", "right": "Thermodynamically unstable toward spontaneous disproportionation" },
        { "left": "Point Located Below Tie-Line of Neighbors (Concave Dip)", "right": "Thermodynamically favored product of comproportionation" },
        { "left": "Steep Upward Slope from Left to Right", "right": "High positive reduction potential (powerful oxidizing agent)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "In an acidic Latimer diagram: Fe(III) --(+0.77 V, 1e⁻)--> Fe(II) --(-0.44 V, 2e⁻)--> Fe(0). Calculate the standard reduction potential E° (in Volts) for the direct 3-electron reduction Fe(III) + 3e⁻ -> Fe(0): E° = [ (1 * 0.77) + (2 * -0.44) ] / 3 (round to 3 decimal places).",
      "numericAnswer": -0.037,
      "numericTolerance": 0.005
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Latimer diagram, an intermediate oxidation state undergoes spontaneous disproportionation if the standard potential to its right is ___ than the potential to its left.",
      "blankAnswer": "greater",
      "blankDistractors": ["smaller", "negative", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Manganese Frost Diagram Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Manganese Redox Stability Engine (pH = 0)</h3><p>States: $\\text{MnO}_4^-\\ (\\text{VII}) \\to \\text{MnO}_4^{2-}\\ (\\text{VI}) \\to \\text{MnO}_2\\ (\\text{IV}) \\to \\text{Mn}^{3+}\\ (\\text{III}) \\to \\text{Mn}^{2+}\\ (\\text{II}) \\to \\text{Mn}^0$</p><button id=\"rdxBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Evaluate Stability of Manganate (Mn-VI) and Mn(III)</button><div id=\"rdxOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('rdxBtn').onclick=()=>{document.getElementById('rdxOut').innerText='Frost Diagram Analysis Complete: (1) Mn(VI) and Mn(III) sit on convex peaks above neighboring tie-lines -> Spontaneously disproportionate! (3 MnO4²⁻ + 4 H⁺ -> 2 MnO4⁻ + MnO2 + 2 H2O). (2) Mn²⁺ sits at the absolute minimum valley of the Frost curve -> Thermodynamic sink (most stable species in acidic solution).'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
