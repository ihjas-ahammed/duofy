# Duofy Reusable Lesson Format: Disinfection (Chlorination Chemistry & Chick-Watson CT)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Water_Purification_and_Treatment`  
**Lesson Format Type:** `water_disinfection_chlorination_chemistry_and_chick_watson_kinetics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the chemistry and microbial kinetics of drinking water disinfection, aqueous chlorine hydrolysis ($\text{Cl}_2 + \text{H}_2\text{O} \rightleftharpoons \text{HOCl} + \text{H}^+ + \text{Cl}^-$), hypochlorous acid dissociation equilibrium ($\text{HOCl} \rightleftharpoons \text{H}^+ + \text{OCl}^-$, $pK_a \approx 7.54$ at $25^\circ\text{C}$), comparative germicidal potency of free chlorine species ($\text{HOCl}$ is $80-100\times$ more effective than hypochlorite ion $\text{OCl}^-$), combined chlorine / chloramines formation, Harriet Chick and H. E. Watson's **Chick-Watson Inactivation Kinetics**, log-reduction calculations ($\text{Log Reduction} = \log_{10}(N_0 / N_t)$), and the EPA **$CT$ Concept ($C \times t_{10}$)** for Giardia and virus inactivation (Mackenzie L. Davis *Water and Wastewater Engineering* 2nd ed. Chapter 10; Metcalf & Eddy *Wastewater Engineering* Chapter 12; John C. Crittenden *MWH's Water Treatment* Chapter 17): formulate the **Chick-Watson Disinfection Kinetics Master Equation**:
$$\mathbf{\ln\left( \frac{N_t}{N_0} \right) = -k \cdot C^n \cdot t \Longleftrightarrow \mathbf{\log_{10}\left( \frac{N_t}{N_0} \right) = -\frac{k \cdot C^n \cdot t}{2.303}}}$$
where:
1. **$N_0, N_t$:** Initial and remaining concentration of viable pathogens at contact time $t$;
2. **$k$:** Disinfection rate coefficient;
3. **$C$:** Disinfectant residual concentration in $\text{mg/L}$;
4. **$n$:** Coefficient of dilution ($n \approx 1.0$ for free chlorine);
5. **$t$:** Contact time (or $t_{10}$ baffling hydraulic residence time);
derive the **Log-Reduction & Percent Inactivation Formulations**:
$$\mathbf{\text{Log Reduction} = \log_{10}\left( \frac{N_0}{N_t} \right) \quad \Big| \quad \mathbf{\% \text{ Inactivation} = \left( 1 - \frac{N_t}{N_0} \right) \times 100\%}}$$
- $1\text{-Log} = 90.0\% \ (N_t/N_0 = 0.10)$;
- $2\text{-Log} = 99.0\% \ (N_t/N_0 = 0.01)$;
- $3\text{-Log} = 99.9\% \ (N_t/N_0 = 0.001)$;
- $4\text{-Log} = 99.99\% \ (N_t/N_0 = 0.0001)$;
formulate the **Free Chlorine pH Speciation Ratio**:
$$\mathbf{\alpha_{\text{HOCl}} = \frac{[\text{HOCl}]}{[\text{HOCl}] + [\text{OCl}^-]} = \frac{1}{1 + \frac{K_a}{[\text{H}^+]}} = \frac{1}{1 + 10^{\text{pH} - pK_a}} \quad (\text{Enforces pH } \le 7.5 \text{ for Optimal Kill})}$$
and interact with live Coagulation mixer power calculator, Stokes' sedimentation simulator, Rapid sand backwash bed expansion visualizer, and Chick-Watson CT disinfection curve plotter widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chick-Watson Law ($\ln(N_t/N_0) = -k C t$), Chlorine Equilibrium ($\text{HOCl} \rightleftharpoons \text{OCl}^-$) & CT Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Required Chlorine CT and Contact Time for a 3-Log Giardia Inactivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Chlorine Disinfection Species / Parameter & Technical Chemical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Water Disinfection, Achieving a 3-Log (99.9%) Microbial Inactivation Requires the Ratio $N_t / N_0$ to Equal Exactly ___ (0.001 / One Thousandth / 10^-3) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Potable Water Purification Studio: Mixing, Sedimentation, Rapid Sand Filters & CT Disinfection Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "water_disinfection_chlorination_chemistry_and_chick_watson_kinetics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Chick-Watson disinfection law, and why is pH critical for chlorination efficiency?",
      "blankAnswer": "Disinfection Kinetics & Chlorination Chemistry (Davis & MWH): (1) CHICK-WATSON LAW: ln(Nt/N0) = -k * C^n * t \u2192 Log Reduction = log10(N0/Nt) = (k*C*t) / 2.303. (2) CT CONCEPT: CT = Disinfectant Concentration C (mg/L) * Effective Contact Time t10 (min). (3) CHLORINE EQUILIBRIUM: Cl2 + H2O \u21cc HOCl + H+ + Cl- \u21cc OCl- + H+ (pKa \u2248 7.54). (4) pH IMPORTANCE: Hypochlorous acid (HOCl) is 80-100x more potent germicide than hypochlorite ion (OCl-) because HOCl is neutral and easily penetrates negatively charged bacterial cell walls. At pH < 7.5, HOCl dominates, maximizing pathogen kill!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the required chlorine contact chamber volume to achieve regulatory pathogen inactivation.",
      "orderItems": [
        "Determine the target pathogen (e.g. Giardia cysts or Viruses) and regulatory log-reduction requirement (e.g. 3-log = 99.9%)",
        "Look up the required EPA CT value (in mg*min/L) based on minimum water temperature and operating pH",
        "Select an operational free chlorine residual concentration C (e.g. 1.50 mg/L) leaving the contact basin",
        "Calculate the required effective contact time: t10 = CT / C (where t10 is the time for 10% of water to pass through)",
        "Apply the basin baffling factor (BF = t10 / t_hydraulic \u2248 0.70) to determine total required hydraulic retention time and tank volume"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Disinfection Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Hypochlorous Acid (HOCl)", "right": "Uncharged, highly potent germicide dominating at pH < 7.5 that diffuses rapidly through cell membranes" },
        { "left": "Hypochlorite Ion (OCl-)", "right": "Negatively charged, weaker disinfectant dominating in alkaline water (pH > 8.0)" },
        { "left": "CT Product (C \u00d7 t10)", "right": "Regulatory measure representing disinfectant concentration multiplied by the 10th-percentile contact time" },
        { "left": "3-Log Inactivation (99.9%)", "right": "Pathogen kill reducing live microbial population to exactly one-thousandth (Nt/N0 = 0.001) of initial count" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In water disinfection, achieving a 3-log (99.9%) microbial inactivation requires the fraction Nt / N0 of surviving pathogens to equal exactly ___.",
      "blankAnswer": "0.001",
      "blankDistractors": ["0.01", "0.1", "0.0001"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Potable Water Purification Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Potable Water Purification Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Rapid Mixing, Hazen Sedimentation, Rapid Sand Filters & Chlorination</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnMix\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Rapid Mix (P = 32.0kW, Gt=40k)</button><button id=\"btnSed\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Clarifier (vs=8.99mm/s, 100%)</button><button id=\"btnFilt\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Sand Filters (Le=0.75m) & CT</button></div><div id=\"purLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Coagulation mixing power...</div><script>document.getElementById('btnMix').onclick=()=>{document.getElementById('purLog').innerHTML='<b>1. RAPID MIXING \\& VELOCITY GRADIENT:</b><br>• G = \\u221a[P / (\\u03bc*V)] = 800 s\u207b\u00b9<br>• Power: P = G\u00b2*\\u03bc*V = 640,000 * 0.001 * 50 = <b style=\"color:#10b981;\">32.0 kW!</b><br>• <b style=\"color:#38bdf8;\">Camp Number: Gt = 800 * 50 = 40,000!</b>';}; document.getElementById('btnSed').onclick=()=>{document.getElementById('purLog').innerHTML='<b>2. STOKES SEDIMENTATION \\& HAZEN CLARIFIER:</b><br>• vs = g*(\\u03c1p-\\u03c1w)*d\u00b2 / (18*\\u03bc) = <b style=\"color:#10b981;\">8.99 mm/s!</b><br>• Overflow Rate: v0 = Q/As = 4.00 mm/s<br>• Since vs > v0 &rarr; <b style=\"color:#38bdf8;\">100% Removal Efficiency!</b>';}; document.getElementById('btnFilt').onclick=()=>{document.getElementById('purLog').innerHTML='<b>3. RAPID SAND FILTERS \\& CT DISINFECTION:</b><br>• Filter Backwash: Le = L0*(1-\\u03b50)/(1-\\u03b5e) = 0.60*(0.60/0.48) = <b style=\"color:#10b981;\">0.75 m (25% Expansion)!</b><br>• Disinfection: ln(Nt/N0) = -k*C*t (EPA CT Concept)<br>• <b style=\"color:#38bdf8;\">3-Log Inactivation (99.9% Kill &rarr; Nt/N0 = 0.001)!</b><br>🏆 <b style=\"color:#10b981;\">Water_Purification_and_Treatment 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
