# Duofy Reusable Lesson Format: Solar Thermal (Hottel-Whillier-Bliss Collector Model)

**Target Topic:** `04_Engineering_and_Technology / 09_Nuclear_and_Energy_Engineering / Renewable_Energy_Systems / Solar_Photovoltaics_and_Thermal`  
**Lesson Format Type:** `hottel_whillier_bliss_solar_thermal_collector_efficiency`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the thermodynamic and heat transfer analysis of solar thermal flat-plate collectors, the **Hottel-Whillier-Bliss (HWB) Governing Equation** for steady-state useful thermal energy gain ($q_u$), the **Collector Heat Removal Factor ($F_R$)**, the optical transmittance-absorptance product ($(\tau\alpha)$), the overall thermal heat loss coefficient ($U_L$), thermal efficiency ($\eta_{\text{th}} = \frac{q_u}{A_c G_T}$), the linear efficiency curve versus reduced temperature parameter ($\frac{T_{\text{in}} - T_{\text{amb}}}{G_T}$), and stagnation temperature calculations (John A. Duffie, William A. Beckman *Solar Engineering of Thermal Processes, Photovoltaics and Wind* 5th ed. Chapter 6; Soteris A. Kalogirou *Solar Energy Engineering* 2nd ed. Chapter 3; Hoyt C. Hottel, Austin Whillier, Raymond W. Bliss 1958): formulate the **Hottel-Whillier-Bliss (HWB) Useful Thermal Energy Gain Master Formulation**:
$$\mathbf{q_u = A_c F_R \left[ G_T (\tau \alpha) - U_L \left( T_{\text{in}} - T_{\text{amb}} \right) \right] \quad [\text{Watts}]}$$
where:
1. **$q_u$:** Rate of useful thermal energy collected by the circulating fluid ($\text{Watts}$);
2. **$A_c$:** Gross collector surface area ($\text{m}^2$);
3. **$F_R$:** Dimensionless collector heat removal factor ($0 < F_R \le 1.0$, typically $0.80 - 0.92$);
4. **$G_T$:** Global solar irradiance incident on the tilted collector plane ($\text{W/m}^2$);
5. **$(\tau\alpha)$:** Effective optical transmittance-absorptance product (typically $0.80 - 0.88$);
6. **$U_L$:** Overall heat loss coefficient to the surrounding ambient air ($\text{W}/\text{m}^2\cdot\text{K}$, typically $3.0 - 6.0\text{ W/m}^2\text{K}$);
7. **$T_{\text{in}}, T_{\text{amb}}$:** Inlet fluid temperature and ambient ambient air temperature ($^\circ\text{C}$ or $\text{K}$);
derive the **Solar Thermal Collector Efficiency Equation ($\eta_{\text{th}}$)**:
$$\mathbf{\eta_{\text{th}} = \frac{q_u}{A_c G_T} = F_R (\tau \alpha) - F_R U_L \left( \frac{T_{\text{in}} - T_{\text{amb}}}{G_T} \right)}$$
derive the **Collector Stagnation Temperature ($T_{\text{stagnation}}$ at $q_u = 0$)**:
$$\mathbf{T_{\text{stagnation}} = T_{\text{amb}} + \frac{G_T (\tau \alpha)}{U_L}}$$
(proving that thermal efficiency decreases linearly as fluid operating temperature rises due to increasing convection and radiation losses to ambient air).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | HWB Equation ($q_u = A_c F_R [G_T(\tau\alpha) - U_L(T_{\text{in}}-T_{\text{amb}})]$) & Linear Efficiency Curve Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Useful Thermal Gain, Efficiency, and Stagnation Temperature Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Solar Thermal Construct / Performance Parameter & Technical Engineering Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Hottel-Whillier-Bliss Model, the Dimensionless Factor $F_R$ That Relates the Actual Useful Energy Gain to the Maximum Possible Energy Gain if the Entire Absorber Plate Were at the Fluid Inlet Temperature Is Termed the Collector Heat ___ Factor (Removal / Heat Removal) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Solar Thermal Problem: Computing Useful Heat Gain and Efficiency for a Domestic Hot Water Flat-Plate Collector Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hottel-Whillier-Bliss Solar Thermal Mechanics (Duffie & Beckman 2020; Kalogirou 2014):
   - **Thermal Formulations:**
     $$\mathbf{q_u = A_c F_R [G_T (\tau\alpha) - U_L (T_{\text{in}} - T_{\text{amb}})] \quad \Big| \quad \eta_{\text{th}} = F_R(\tau\alpha) - F_R U_L \left(\frac{T_{\text{in}}-T_{\text{amb}}}{G_T}\right)}$$
   - **The Linear Efficiency Plot Invariants:**
     - $y$-intercept $= F_R(\tau\alpha)$ (Maximum optical efficiency when $T_{\text{in}} = T_{\text{amb}}$);
     - Slope $= -F_R U_L$ (Thermal loss gradient to ambient surroundings);
     - $x$-intercept $= \frac{(\tau\alpha)}{U_L}$ (Zero-efficiency stagnation operating point)!
2. **Slide 2 (`ordering`):** Provide 5 steps of solar thermal collector analysis: (1) determine collector physical aperture area $A_c$, optical product $(\tau\alpha)$, and loss coefficient $U_L$, (2) record environmental solar irradiance $G_T$, ambient temperature $T_{\text{amb}}$, and fluid inlet temperature $T_{\text{in}}$, (3) calculate net absorbed solar radiation: $S = G_T (\tau\alpha)$, (4) calculate thermal heat losses to surroundings: $Q_{\text{loss}} = U_L (T_{\text{in}} - T_{\text{amb}})$, (5) apply the heat removal factor $F_R$ to compute useful thermal output $q_u = A_c F_R (S - Q_{\text{loss}})$ and thermal efficiency $\eta_{\text{th}} = q_u / (A_c G_T)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Heat Removal Factor $F_R$, Optical Product $\tau\alpha$, Overall Loss Coefficient $U_L$, Stagnation Temperature $T_{\text{stag}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Removal (or Heat Removal). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating useful heat gain and efficiency for a flat-plate solar thermal collector: A flat-plate collector has area $A_c = 2.50\text{ m}^2$, heat removal factor $F_R = 0.850$, optical product $(\tau\alpha) = 0.800$, and loss coefficient $U_L = 4.00\text{ W/m}^2\cdot\text{K}$. On a sunny afternoon, tilted solar irradiance is $G_T = 800.0\text{ W/m}^2$, ambient air is $T_{\text{amb}} = 20.0^\circ\text{C}$, and inlet fluid enters at $T_{\text{in}} = 50.0^\circ\text{C}$ ($\Delta T = T_{\text{in}} - T_{\text{amb}} = 50.0 - 20.0 = \mathbf{30.0^\circ\text{C}}$).
   - Absorbed optical flux:
     $S = G_T (\tau\alpha) = 800.0 \times 0.800 = \mathbf{640.0\text{ W/m}^2}$;
   - Thermal loss flux:
     $Q_{\text{loss}} = U_L \Delta T = 4.00\text{ W/m}^2\text{K} \times 30.0\text{ K} = \mathbf{120.0\text{ W/m}^2}$;
   - Net flux:
     $S - Q_{\text{loss}} = 640.0 - 120.0 = \mathbf{520.0\text{ W/m}^2}$;
   - Useful heat gain:
     $q_u = A_c F_R (S - Q_{\text{loss}}) = 2.50\text{ m}^2 \times 0.850 \times 520.0\text{ W/m}^2 = 2.125 \times 520.0 = \mathbf{1105.0\text{ W} = 1105\text{ W}}$;
   - Total incident solar power:
     $P_{\text{solar}} = A_c G_T = 2.50 \times 800.0 = \mathbf{2000.0\text{ W}}$;
   - Thermal efficiency:
     $\eta_{\text{th}} = \frac{1105.0\text{ W}}{2000.0\text{ W}} \times 100\% = \mathbf{0.5525 \times 100\% = 55.25\% \approx 55.3\%}$;
   - What are the useful thermal gain $q_u$ and thermal efficiency $\eta_{\text{th}}$? ($q_u = \mathbf{1105\text{ W}}$ and $\eta_{\text{th}} = \mathbf{55.3\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hottel_whillier_bliss_solar_thermal_collector_efficiency",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hottel-Whillier-Bliss (HWB) Solar Thermal Model (Duffie \\& Beckman)**\n• **HWB Useful Thermal Energy Gain Master Formulation:**\n$$\n\\mathbf{q_u = A_c F_R \\left[ G_T (\\tau \\alpha) - U_L \\left( T_{\\text{in}} - T_{\\text{amb}} \\right) \\right] \\quad [\\text{Watts}]}\n$$\n  - **$F_R$ (Heat Removal Factor):** Dimensionless factor ($0.80 - 0.92$) relating actual gain to maximum possible gain if plate were at $T_{\\text{in}}$;\n  - **$G_T$:** Incident solar irradiance on tilted collector surface ($\\text{W/m}^2$);\n  - **$(\\tau\\alpha)$:** Effective optical transmittance-absorptance product;\n  - **$U_L$:** Overall heat loss coefficient ($\\text{W}/\\text{m}^2\\cdot\\text{K}$);\n  - **$T_{\\text{in}}, T_{\\text{amb}}$:** Fluid inlet temperature and ambient air temperature;\n• **Solar Thermal Collector Efficiency Equation ($\\eta_{\\text{th}}$):**\n$$\n\\mathbf{\\eta_{\\text{th}} = \\frac{q_u}{A_c G_T} = F_R (\\tau \\alpha) - F_R U_L \\left( \\frac{T_{\\text{in}} - T_{\\text{amb}}}{G_T} \\right)}\n$$\n• **The Linear Characteristic Invariant:** Plotting $\\eta_{\\text{th}}$ versus reduced temperature $(\\Delta T / G_T)$ yields a **straight line** whose $y$-intercept is maximum optical efficiency $F_R(\\tau\\alpha)$ and whose negative slope is the heat loss metric $-F_R U_L$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the useful heat gain and thermal conversion efficiency of a flat-plate solar thermal collector.",
      "orderItems": [
        "Gather collector parameters: aperture area Ac, heat removal factor FR, optical product (\u03c4\u03b1), and loss coefficient UL",
        "Record operating conditions: tilted irradiance GT, ambient air temperature Tamb, and inlet fluid temperature Tin",
        "Compute the absorbed optical radiation per unit area: S = GT * (\u03c4\u03b1)",
        "Compute the thermal heat loss rate per unit area: Q_loss = UL * (Tin - Tamb)",
        "Multiply net energy by area and heat removal factor to compute useful heat gain: qu = Ac * FR * (S - Q_loss)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Solar Thermal Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Heat Removal Factor (FR)", "right": "Dimensionless ratio measuring how effectively circulating fluid extracts heat from the absorber plate" },
        { "left": "Transmittance-Absorptance (\u03c4\u03b1)", "right": "Fraction of incident solar light transmitted through glass glazing and absorbed by selective black coating" },
        { "left": "Overall Loss Coefficient (UL)", "right": "Total convection and infrared radiation heat loss conductance from collector to surrounding ambient air" },
        { "left": "Stagnation Temperature (Tstag)", "right": "Maximum equilibrium temperature reached when fluid circulation stops and useful heat gain qu drops to zero" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Hottel-Whillier-Bliss model, the dimensionless factor FR that relates the actual useful energy gain to the maximum possible energy gain if the entire absorber plate were at the fluid inlet temperature is termed the collector heat ___ factor.",
      "blankAnswer": "removal",
      "blankDistractors": ["loss", "absorption", "transfer"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A solar thermal collector has Ac = 2.50 m^2, FR = 0.850, (\u03c4\u03b1) = 0.800, and UL = 4.00 W/m^2*K. GT = 800.0 W/m^2, Tamb = 20.0\u00b0C, and Tin = 50.0\u00b0C (\u0394T = 30.0 K). S = 800*0.8 = 640.0 W/m^2. Q_loss = 4.00*30.0 = 120.0 W/m^2. Net flux = 640 - 120 = 520.0 W/m^2. qu = 2.50 * 0.850 * 520.0 = 1105.0 W. Total solar power = 2.50 * 800 = 2000.0 W. \u03b7_th = 1105.0 / 2000.0 = 55.25%. What are the useful heat gain qu and efficiency \u03b7_th?",
      "options": [
        { "text": "qu = 1105 W and \u03b7_th = 55.3% (qu = 2.50 m^2 * 0.850 * [640 - 120] W/m^2 = 1105.0 W; \u03b7_th = 1105 / 2000 * 100% = 55.25% \u2248 55.3%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Hottel-Whillier-Bliss (HWB) solar thermal equations (John A. Duffie & William A. Beckman *Solar Engineering of Thermal Processes* Chapter 6; Soteris A. Kalogirou *Solar Energy Engineering* Chapter 3). 1. **Identify Operating Conditions \\& Thermal Parameters:** - Collector area: $A_c = 2.50\\text{ m}^2$. - Heat removal factor: $F_R = 0.850$. - Optical product: $(\\tau\\alpha) = 0.800$. - Loss coefficient: $U_L = 4.00\\text{ W/m}^2\\cdot\\text{K}$. - Incident irradiance: $G_T = 800.0\\text{ W/m}^2$. - Temperature difference: $$\\Delta T = T_{\\text{in}} - T_{\\text{amb}} = 50.0^\\circ\\text{C} - 20.0^\\circ\\text{C} = \\mathbf{30.0\\text{ K}}$$ 2. **Calculate Absorbed Optical Flux \\& Thermal Losses:** - Absorbed optical solar flux: $$S = G_T (\\tau\\alpha) = 800.0\\text{ W/m}^2 \\times 0.800 = \\mathbf{640.0\\text{ W/m}^2}$$ - Thermal convection/radiation loss flux: $$Q_{\\text{loss}} = U_L \\Delta T = 4.00\\text{ W/m}^2\\cdot\\text{K} \\times 30.0\\text{ K} = \\mathbf{120.0\\text{ W/m}^2}$$ - Net flux available: $$S - Q_{\\text{loss}} = 640.0\\text{ W/m}^2 - 120.0\\text{ W/m}^2 = \\mathbf{520.0\\text{ W/m}^2}$$ 3. **Calculate Useful Thermal Power Output ($q_u$):** $$q_u = A_c F_R (S - Q_{\\text{loss}}) = 2.50\\text{ m}^2 \\times 0.850 \\times 520.0\\text{ W/m}^2$$ $$q_u = 2.125\\text{ m}^2 \\times 520.0\\text{ W/m}^2 = \\mathbf{1105.0\\text{ W} = 1105\\text{ W}}$$ 4. **Calculate Thermal Collector Efficiency ($\\eta_{\\text{th}}$):** - Total incident solar radiant flux: $$P_{\\text{solar}} = A_c G_T = 2.50\\text{ m}^2 \\times 800.0\\text{ W/m}^2 = \\mathbf{2000.0\\text{ W}}$$ $$\\eta_{\\text{th}} = \\frac{q_u}{P_{\\text{solar}}} \\times 100\\% = \\frac{1105.0\\text{ W}}{2000.0\\text{ W}} \\times 100\\% = \\mathbf{55.25\\% \\approx 55.3\\%}$$ Flawless Hottel-Whillier-Bliss solar thermal collector derivation!" },
        { "text": "qu = 1600 W and \u03b7_th = 80.0% (Ignored thermal heat loss to ambient air)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "qu = 520 W and \u03b7_th = 26.0% (Forgot collector area and FR factor)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "qu = 2000 W and \u03b7_th = 100.0%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
