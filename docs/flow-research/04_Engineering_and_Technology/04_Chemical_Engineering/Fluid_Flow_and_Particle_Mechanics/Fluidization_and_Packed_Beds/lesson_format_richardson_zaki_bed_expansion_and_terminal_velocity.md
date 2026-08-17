# Duofy Reusable Lesson Format: Bed Expansion (Richardson-Zaki Law & Terminal Velocity)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Fluid_Flow_and_Particle_Mechanics / Fluidization_and_Packed_Beds`  
**Lesson Format Type:** `richardson_zaki_bed_expansion_and_terminal_velocity`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the mechanics of particulate fluidized bed expansion in liquid-solid and dense gas-solid systems, single-particle terminal free-fall settling velocity ($u_t$ via Stokes' law or Newton's drag law), J. F. Richardson and W. N. Zaki's 1954 **Bed Expansion Power Law ($\frac{u_0}{u_t} = \epsilon^n$)**, empirical determination of the expansion exponent ($n = 4.65$ in laminar creeping flow to $n = 2.39$ in fully turbulent flow), solid volume conservation linking expanded bed height ($L$) to operating void fraction ($\epsilon$), and freeboard height sizing (Warren L. McCabe *Unit Operations of Chemical Engineering* 7th ed. Chapter 7; J. F. Richardson & W. N. Zaki 1954): formulate the **Richardson-Zaki Bed Expansion Master Formulation**:
$$\mathbf{\frac{u_0}{u_t} = \epsilon^n \Longleftrightarrow \mathbf{\epsilon = \left( \frac{u_0}{u_t} \right)^{1/n}}}$$
where:
1. **$u_0$:** Superficial fluidizing velocity in $\text{m/s}$ ($u_{\text{mf}} \le u_0 \le u_t$);
2. **$u_t$:** Terminal free-settling velocity of an isolated single particle in $\text{m/s}$;
3. **$\epsilon$:** Operating bed porosity / void fraction at velocity $u_0$;
4. **$n$:** Richardson-Zaki expansion exponent:
   - **Laminar Stokes Regime ($Re_t < 0.2$):** $\mathbf{n = 4.65}$;
   - **Intermediate Transition Regime ($0.2 \le Re_t \le 500$):** $\mathbf{n = 4.45 \cdot Re_t^{-0.10}}$;
   - **Fully Turbulent Newton Regime ($Re_t > 500$):** $\mathbf{n = 2.39}$;
formulate the **Bed Height Expansion from Solid Mass Conservation**:
$$\mathbf{L = L_{\text{mf}} \left( \frac{1 - \epsilon_{\text{mf}}}{1 - \epsilon} \right) = L_0 \left( \frac{1 - \epsilon_0}{1 - \epsilon} \right)}$$
and interact with live Ergun pressure drop calculator, Minimum fluidization force balance visualizer, Geldart powder classification mapper, and Richardson-Zaki bed expansion simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Richardson-Zaki Law ($\frac{u_0}{u_t} = \epsilon^n$), Exponent $n=4.65$ & Bed Height ($L = L_{\text{mf}}\frac{1-\epsilon_{\text{mf}}}{1-\epsilon}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Terminal Velocity, Operating Voidage, and Expanded Bed Height Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Bed Expansion Construct / Settling Regime & Technical Hydrodynamic Parameter Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Under Richardson-Zaki's Bed Expansion Law in the Laminar Creeping Flow Regime ($Re_t < 0.2$), the Empirical Expansion Exponent $n$ Equals Exactly ___ (4.65 / Four point six five) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Chemical Fluidization Studio: Ergun Pressure Drop, Umf, Geldart Regimes & Richardson-Zaki Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "richardson_zaki_bed_expansion_and_terminal_velocity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Richardson-Zaki equation, and how does a fluidized bed expand with increasing fluid velocity?",
      "blankAnswer": "Richardson-Zaki Bed Expansion Mechanics (Richardson & Zaki 1954): (1) POWER LAW: u0 / ut = \u03b5^n \u2192 \u03b5 = (u0 / ut)^(1/n), relating superficial velocity u0 and terminal velocity ut to bed voidage \u03b5. (2) EXPONENT n: n = 4.65 for laminar flow (Ret < 0.2); n = 2.39 for turbulent flow (Ret > 500). (3) BED EXPANSION: By conservation of solid particle volume, expanded height L = L_mf * (1 - \u03b5_mf) / (1 - \u03b5). As velocity u0 approaches terminal velocity ut, \u03b5 \u2192 1.0 and the bed expands toward infinite height before particles elutriate!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the expanded height of a particulate fluidized bed at an elevated operating velocity.",
      "orderItems": [
        "Calculate the single-particle terminal free-settling velocity ut using Stokes' Law or Newton's drag law",
        "Determine the particle terminal Reynolds number Ret = (\u03c1f * ut * dp) / \u03bc to establish the Richardson-Zaki exponent n (e.g. n = 4.65)",
        "Calculate the operating bed void fraction from the Richardson-Zaki power law: \u03b5 = (u0 / ut)^(1/n)",
        "Extract the incipient fluidization state parameters: static bed height L_mf and voidage \u03b5_mf",
        "Calculate the expanded fluidized bed height: L = L_mf * [ (1 - \u03b5_mf) / (1 - \u03b5) ] and size column freeboard"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fluidized Bed Expansion Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Richardson-Zaki Law", "right": "u0/ut = \u03b5^n, empirical power-law correlating superficial fluid velocity to bed voidage during expansion" },
        { "left": "Laminar Exponent (n = 4.65)", "right": "Characteristic expansion index for creeping flow (Ret < 0.2) governed by viscous boundary layer interactions" },
        { "left": "Turbulent Exponent (n = 2.39)", "right": "Asymptotic expansion index for highly turbulent flow (Ret > 500) where form drag dominates" },
        { "left": "Solid Volume Conservation", "right": "L*(1 - \u03b5) = L_mf*(1 - \u03b5_mf) = constant, physical law dictating bed height expansion as porosity opens" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under Richardson-Zaki's bed expansion law in the laminar creeping flow regime (Ret < 0.2), the empirical expansion exponent n equals exactly ___.",
      "blankAnswer": "4.65",
      "blankDistractors": ["2.39", "1.0", "3.0"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Chemical Fluidization Engineering Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Fluidization Engineering & Particle Mechanics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Ergun Equation, Incipient Umf, Geldart Regimes & Richardson-Zaki</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnErg\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Ergun Equation (\u0394P = 83.2 kPa)</button><button id=\"btnUmf\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Umf Force Balance (0.060 m/s)</button><button id=\"btnRz\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Geldart A & Richardson-Zaki (n=4.65)</button></div><div id=\"flLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate packed bed Ergun pressure drop...</div><script>document.getElementById('btnErg').onclick=()=>{document.getElementById('flLog').innerHTML='<b>1. SABRI ERGUN PACKED BED HYDRAULICS:</b><br>• \\u0394P/L = 150*[(1-\\u03b5)\u00b2/\\u03b5\u00b3]*[\\u03bcu0/dp\u00b2] + 1.75*[(1-\\u03b5)/\\u03b5\u00b3]*[\\u03c1u0\u00b2/dp]<br>• Viscous: 21.09 kPa/m + Inertial: 20.51 kPa/m<br>• <b style=\"color:#10b981;\">Total Bed \\u0394P (L=2.0m) = 83.2 kPa!</b>';}; document.getElementById('btnUmf').onclick=()=>{document.getElementById('flLog').innerHTML='<b>2. INCIPIENT FLUIDIZATION FORCE BALANCE:</b><br>• Buoyant Weight: \\u0394P = (1 - \\u03b5_mf)*(\\u03c1p - \\u03c1f)*g*L_mf = <b style=\"color:#10b981;\">13.5 kPa (Constant Plateau)!</b><br>• Laminar Umf = [dp\u00b2*(\\u03c1p-\\u03c1f)*g / (150*\\u03bc)] * [\\u03b5_mf\u00b3/(1-\\u03b5_mf)]<br>• <b style=\"color:#38bdf8;\">Minimum Fluidization Velocity: Umf = 0.060 m/s (6.0 cm/s)!</b>';}; document.getElementById('btnRz').onclick=()=>{document.getElementById('flLog').innerHTML='<b>3. GELDART REGIMES \\& BED EXPANSION:</b><br>• Geldart Group A: 30-100 \\u03bcm FCC catalyst &rarr; <b style=\"color:#10b981;\">Smooth expansion before bubbling (umb > umf)!</b><br>• Richardson-Zaki Law: u0 / ut = \\u03b5\u2074\u00b7\u2076\u2075 &rarr; \\u03b5 = (u0 / ut)\u00b9\u1420\u2074\u00b7\u2076\u2075<br>• <b style=\"color:#38bdf8;\">Solid Volume Conservation: L = L_mf * (1-\\u03b5_mf) / (1-\\u03b5)!</b><br>🏆 <b style=\"color:#10b981;\">Fluid_Flow_and_Particle_Mechanics 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
