# Duofy Reusable Lesson Format: Heat Treatment (Quenching, Tempering, & Toughness)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Metallurgy_and_Phase_Diagrams / Iron_Carbon_Phase_Diagram`  
**Lesson Format Type:** `steel_heat_treatments_quenching_and_tempering_kinetics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the physical metallurgy of industrial steel heat treatments: **Full Annealing** (slow furnace cooling to yield soft coarse pearlite), **Normalizing** (air cooling to yield uniform fine pearlite), **Quenching** (rapid water/oil immersion to form high-hardness brittle martensite $\approx 65\text{ HRC}$), **Tempering** (sub-critical reheating between $250^\circ\text{C} - 650^\circ\text{C}$ to precipitate sub-micron spherical $\text{Fe}_3\text{C}$ particles in a ductile ferrite matrix forming **Tempered Martensite**), the trade-off between hardness and Charpy V-notch impact toughness, and the **Hollomon-Jaffe Tempering Parameter ($P = T \cdot [c + \log_{10}(t)]$ lock-in)** (William D. Callister Jr., David G. Rethwisch *Materials Science and Engineering: An Introduction* 10th ed. Chapter 10; Donald R. Askeland *The Science and Engineering of Materials* 7th ed. Chapter 12; John H. Hollomon & Leonard D. Jaffe 1945): formulate the **Hollomon-Jaffe Tempering Parameter Master Formulation**:
$$\mathbf{P_{\text{HJ}} = T \cdot \left[ c + \log_{10}(t) \right] \times 10^{-3} \quad (T \text{ in Kelvin}, \ t \text{ in hours}, \ c \approx 18 - 20)}$$
where:
1. **$P_{\text{HJ}}$:** Dimensionless thermal severity parameter governing martensite softening;
2. **$T$:** Absolute tempering temperature ($\text{K}$);
3. **$t$:** Isothermal holding time in hours;
4. **$c$:** Material constant ($\approx 19.5$ for plain carbon steels);
master the **Standard Steel Heat Treatment Comparison Matrix**:
$$\begin{array}{|l|l|l|l|l|}
\hline
\textbf{Heat Treatment} & \textbf{Heating Temp} & \textbf{Cooling Medium} & \textbf{Resulting Microstructure} & \textbf{Primary Engineering Goal} \\
\hline
\mathbf{\text{Full Annealing}} & A_3 + 50^\circ\text{C} & \mathbf{\text{Furnace (Very slow)}} & \text{Coarse Pearlite + }\alpha & \mathbf{\text{Maximize ductility, relieve residual stress}} \\
\mathbf{\text{Normalizing}} & A_3 + 50^\circ\text{C} & \mathbf{\text{Still Air (Moderate)}} & \text{Fine Pearlite + }\alpha & \mathbf{\text{Grain refinement, uniform strength}} \\
\mathbf{\text{Quenching}} & A_3 + 50^\circ\text{C} & \mathbf{\text{Water / Oil (Fast)}} & \mathbf{\text{Untempered Martensite}} & \mathbf{\text{Maximum achievable hardness (60-65 HRC)}} \\
\mathbf{\text{Tempering}} & \mathbf{250 - 650^\circ\text{C}} & \text{Air / Water} & \mathbf{\text{Tempered Martensite}} & \mathbf{\text{Restore impact toughness while keeping high strength}} \\
\hline
\end{array}$$
(proving that tempering transforms severely strained BCT martensite into microscopic spheroidal cementite in BCC ferrite, eliminating brittleness while retaining exceptional yield strength), and interact with live Fe-Fe3C phase diagram solver, Lever rule phase calculator, TTT transformation path tracer, and Quench & Temper hardness simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Heat Treatments (Anneal, Normalize, Quench, Temper) & Tempered Martensite Toughness Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Perform a Quench-and-Temper Heat Treatment on a Medium-Carbon Steel Drive Shaft Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Heat Treatment Process / Microstructural Transformation & Technical Engineering Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Heating As-Quenched Brittle Martensite to Temperatures Between 250°C and 650°C to Precipitate Fine Spheroidal Carbides and Restore Impact Toughness Is Known as ___ (Tempering / Temper) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Physical Metallurgy Studio: Fe-Fe3C Diagram, Lever Rule, TTT Curves & Heat Treatment Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "steel_heat_treatments_quenching_and_tempering_kinetics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why is as-quenched martensite rarely used in engineering without tempering, and what microstructural changes occur during tempering?",
      "blankAnswer": "Quench \\& Temper Metallurgy (Callister 2020; Askeland 2016): (1) AS-QUENCHED MARTENSITE: Extreme hardness (\u2248 65 HRC) but extremely brittle with high internal micro-strains; prone to catastrophic shatter under light impact. (2) TEMPERING MECHANISM: Reheating martensite to 250\u00b0C - 650\u00b0C allows trapped carbon to diffuse out of BCT lattice, precipitating millions of sub-micron spherical Fe3C particles embedded in a ductile BCC \u03b1-ferrite matrix. (3) TEMPERED MARTENSITE: Restores Charpy impact toughness and elongation while retaining high tensile yield strength, providing the gold standard microstructure for high-performance shafts, gears, and structural bolts!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of an industrial quench-and-temper heat treatment cycle for an automotive transmission gear.",
      "orderItems": [
        "Heat the medium-carbon steel above A3 (e.g. 850\u00b0C) to achieve complete homogeneous austenitization",
        "Quench rapidly in agitated oil or water at a cooling rate exceeding the critical cooling rate to form 100% BCT martensite",
        "Transfer as-quenched part to a tempering furnace heated to intermediate temperature (e.g. 450\u00b0C)",
        "Hold at tempering temperature for 1 to 2 hours to allow diffusion-driven precipitation of fine spherical Fe3C nanoparticles",
        "Cool to room temperature to obtain a final tough, fatigue-resistant Tempered Martensite microstructure"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Steel Heat Treatment to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Full Annealing", "right": "Furnace cooling from austenite region producing soft, coarse pearlite with maximum ductility and machinability" },
        { "left": "Normalizing", "right": "Still-air cooling producing uniform fine pearlite with refined grain structure and elevated yield strength" },
        { "left": "Quenching", "right": "Rapid liquid cooling exceeding critical cooling rate to trap carbon and freeze in 100% hard BCT martensite" },
        { "left": "Tempering", "right": "Sub-critical reheating (250\u00b0C - 650\u00b0C) converting brittle martensite into tough, impact-resistant Tempered Martensite" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Heating as-quenched brittle martensite to temperatures between 250\u00b0C and 650\u00b0C to precipitate fine spheroidal carbides and restore impact toughness is known as ___.",
      "blankAnswer": "tempering",
      "blankDistractors": ["annealing", "normalizing", "sintering"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Physical Metallurgy & Steel Heat Treatment Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Physical Metallurgy & Steel Phase Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Fe-Fe3C Diagram, Lever Rule, TTT Curves & Quench/Temper</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnLev\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Lever Rule (W_\u03b1=93.6%, W_Fe3C=6.4%)</button><button id=\"btnHyp\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Hypo 1030 (W_\u03b1'=62.3%, Pearlite=37.7%)</button><button id=\"btnTtt\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. TTT Kinetics & Tempered Martensite</button></div><div id=\"metLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Fe-Fe3C lever rule phase fractions...</div><script>document.getElementById('btnLev').onclick=()=>{document.getElementById('metLog').innerHTML='<b>1. FE-FE3C LEVER RULE PHASE FRACTIONS (1045 STEEL):</b><br>• Tie-line Span: 6.70 - 0.022 = 6.678 wt% C<br>• Ferrite Phase: W_\\u03b1 = (6.70 - 0.45) / 6.678 = <b style=\"color:#10b981;\">93.59%!</b><br>• <b style=\"color:#38bdf8;\">Cementite Phase: W_Fe3C = (0.45 - 0.022) / 6.678 = 6.41%!</b>';}; document.getElementById('btnHyp').onclick=()=>{document.getElementById('metLog').innerHTML='<b>2. HYPOEUTECTOID MICROCONSTITUENTS (1030 STEEL):</b><br>• Span: 0.76 - 0.022 = 0.738 wt% C<br>• Proeutectoid Ferrite: W_\\u03b1\\' = (0.76 - 0.30) / 0.738 = <b style=\"color:#10b981;\">62.33%!</b><br>• <b style=\"color:#38bdf8;\">Eutectoid Pearlite Colonies: W_pearlite = (0.30 - 0.022) / 0.738 = 37.67%!</b>';}; document.getElementById('btnTtt').onclick=()=>{document.getElementById('metLog').innerHTML='<b>3. TTT KINETICS \\& QUENCH/TEMPER TOUGHNESS:</b><br>• Isothermal Path: 50% Pearlite (600\u00b0C) + 50% Bainite (350\u00b0C)<br>• Rapid Quench: FCC \\u03b3 &rarr; BCT Martensite (65 HRC)<br>• <b style=\"color:#38bdf8;\">Tempering (450\u00b0C): Precipitates spherical Fe3C &rarr; High toughness!</b><br>🏆 <b style=\"color:#10b981;\">Metallurgy_and_Phase_Diagrams 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
