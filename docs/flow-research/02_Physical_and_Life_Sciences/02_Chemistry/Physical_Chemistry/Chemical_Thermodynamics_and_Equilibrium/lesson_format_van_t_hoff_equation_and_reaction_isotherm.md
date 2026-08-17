# Duofy Reusable Lesson Format: van 't Hoff Equation and Reaction Isotherm

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Chemical_Thermodynamics_and_Equilibrium`  
**Lesson Format Type:** `van_t_hoff_equation_and_reaction_isotherm`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the thermodynamic derivation, graphical analysis, and temperature-dependent behavior of chemical equilibrium constants: formulate the **Gibbs Reaction Isotherm ($\Delta_r G = \Delta_r G^\circ + RT\ln Q$)**, derive the fundamental standard equilibrium condition ($\Delta_r G^\circ = -RT\ln K_{\text{eq}}$), apply the **Gibbs-Helmholtz Equation ($\frac{\partial(G/T)}{\partial T} = -\frac{H}{T^2}$)** to derive the differential and integrated **van 't Hoff Equation ($\frac{d\ln K}{dT} = \frac{\Delta_r H^\circ}{RT^2} \implies \ln K = -\frac{\Delta_r H^\circ}{R}\frac{1}{T} + \frac{\Delta_r S^\circ}{R}$)**, and quantify shifts in equilibrium constants with temperature for endothermic ($\Delta_r H^\circ > 0$, $K$ rises with $T$) vs exothermic ($\Delta_r H^\circ < 0$, $K$ falls with $T$) reactions (Le Chatelier's Principle).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Reaction Isotherm & van 't Hoff Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step van 't Hoff Equation Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | van 't Hoff Plot Slope / Intercept & Thermodynamic Parameter Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Standard Reaction Gibbs Energy and Equilibrium Constant Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Exothermic Haber Ammonia Synthesis Temperature Shift Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Reaction Isotherm & The van 't Hoff Equation (Jacobus van 't Hoff, 1884):
   - **The Reaction Isotherm:**
     $$\Delta_r G = \Delta_r G^\circ + RT \ln Q$$
     - At chemical equilibrium: $\Delta_r G = 0$ and $Q = K_{\text{eq}} \implies$
       $$\Delta_r G^\circ = -RT \ln K_{\text{eq}} \iff K_{\text{eq}} = e^{-\Delta_r G^\circ / RT}$$
   - **The van 't Hoff Differential Equation (from Gibbs-Helmholtz):**
     $$\frac{d\ln K_{\text{eq}}}{dT} = \frac{\Delta_r H^\circ}{RT^2}$$
   - **The Integrated Linear van 't Hoff Equation (Assuming constant $\Delta_r H^\circ, \Delta_r S^\circ$ over $\Delta T$):**
     $$\ln K_{\text{eq}} = -\frac{\Delta_r H^\circ}{R}\left(\frac{1}{T}\right) + \frac{\Delta_r S^\circ}{R}$$
     - $\text{Plot: } \ln K_{\text{eq}} \text{ vs } \frac{1}{T}$
     - $\text{Slope} = -\frac{\Delta_r H^\circ}{R}$
     - $\text{Y-Intercept} = \frac{\Delta_r S^\circ}{R}$
   - **Two-Point Temperature Form:**
     $$\ln\left(\frac{K_2}{K_1}\right) = -\frac{\Delta_r H^\circ}{R}\left(\frac{1}{T_2} - \frac{1}{T_1}\right) = \frac{\Delta_r H^\circ}{R}\left(\frac{T_2 - T_1}{T_1 T_2}\right)$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the van 't Hoff equation: (1) start with the thermodynamic definition connecting standard Gibbs energy and equilibrium constant: $\ln K = -\frac{\Delta_r G^\circ}{RT}$, (2) differentiate both sides with respect to temperature: $\frac{d\ln K}{dT} = -\frac{1}{R} \frac{d}{dT}\left(\frac{\Delta_r G^\circ}{T}\right)$, (3) apply the fundamental Gibbs-Helmholtz relation: $\left[\frac{\partial}{\partial T}\left(\frac{\Delta G}{T}\right)\right]_P = -\frac{\Delta H}{T^2}$, (4) substitute $-\frac{\Delta_r H^\circ}{T^2}$ into the derivative to obtain $\frac{d\ln K}{dT} = -\frac{1}{R}\left(-\frac{\Delta_r H^\circ}{T^2}\right) = \frac{\Delta_r H^\circ}{RT^2}$, (5) integrate between limits $(T_1, K_1)$ and $(T_2, K_2)$ to establish $\ln\left(\frac{K_2}{K_1}\right) = -\frac{\Delta_r H^\circ}{R}\left(\frac{1}{T_2} - \frac{1}{T_1}\right)$!
3. **Slide 3 (`matching`):** Pair 4 van 't Hoff plot features (Negative slope $-\Delta_r H^\circ/R < 0$, Positive slope $-\Delta_r H^\circ/R > 0$, Y-intercept $\Delta_r S^\circ/R$, Zero slope $\Delta_r H^\circ = 0$) with their physical meanings.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the slope of a linear van 't Hoff plot of ln(K) versus 1/T is equal to -Delta H° / R. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on temperature shift in exothermic Haber-Bosch ammonia synthesis ($\text{N}_2 + 3\text{H}_2 \rightleftharpoons 2\text{NH}_3, \ \Delta_r H^\circ = -92.4\text{ kJ/mol}$): When the reaction temperature is increased from $300\text{ K}$ to $700\text{ K}$, what happens to the equilibrium constant $K_p$? (Because the forward reaction is **strongly exothermic ($\Delta_r H^\circ < 0$)**, the van 't Hoff derivative $\frac{d\ln K}{dT} = \frac{\Delta_r H^\circ}{RT^2}$ is negative, so **$K_p$ drops drastically by several orders of magnitude**; industrial Haber reactors operate at $450^\circ\text{C}$ solely to accelerate reaction kinetics over iron catalysts, accepting a much lower equilibrium yield).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "van_t_hoff_equation_and_reaction_isotherm",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: van 't Hoff Equation and Reaction Isotherms**\n• **The Gibbs Reaction Isotherm:**\n$$\n\\Delta_r G = \\Delta_r G^\\circ + RT \\ln Q \\implies \\Delta_r G^\\circ = -RT \\ln K_{\\text{eq}}\n$$\n• **The Differential van 't Hoff Equation (via Gibbs-Helmholtz):**\n$$\n\\frac{d\\ln K_{\\text{eq}}}{dT} = \\frac{\\Delta_r H^\\circ}{RT^2}\n$$\n• **The Linear van 't Hoff Plot ($\\ln K_{\\text{eq}}$ vs $1/T$):**\n$$\n\\ln K_{\\text{eq}} = -\\frac{\\Delta_r H^\\circ}{R}\\left(\\frac{1}{T}\\right) + \\frac{\\Delta_r S^\\circ}{R}\n$$\n  - $\\text{Slope} = -\\frac{\\Delta_r H^\\circ}{R}, \\qquad \\text{Y-Intercept} = \\frac{\\Delta_r S^\\circ}{R}$.\n• **Le Chatelier Equilibrium Response:**\n  - **Endothermic ($\\Delta_r H^\\circ > 0$):** $K_{\\text{eq}}$ increases as $T$ increases (Slope $< 0$).\n  - **Exothermic ($\\Delta_r H^\\circ < 0$):** $K_{\\text{eq}}$ decreases as $T$ increases (Slope $> 0$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps deriving the van 't Hoff equation from the Gibbs-Helmholtz relation.",
      "orderItems": [
        "Express the equilibrium constant in terms of standard reaction Gibbs energy: ln(K) = -Delta_r G° / (R*T)",
        "Differentiate both sides with respect to temperature: d(ln K)/dT = -(1/R) * d/dT [Delta_r G° / T]",
        "Apply the fundamental Gibbs-Helmholtz equation: [∂/∂T (Delta G / T)]_P = -Delta H / T²",
        "Substitute -Delta_r H° / T² into the derivative to yield: d(ln K)/dT = -(1/R) * (-Delta_r H° / T²) = Delta_r H° / (R*T²)",
        "Integrate between T1 and T2 to obtain: ln(K2 / K1) = -(Delta_r H° / R) * (1/T2 - 1/T1)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each feature of a van 't Hoff plot (ln K vs 1/T) to its physical meaning.",
      "matchPairs": [
        { "left": "Negative Slope (Slope = -Delta H°/R < 0)", "right": "Endothermic reaction (Delta H° > 0); K increases with higher temperature" },
        { "left": "Positive Slope (Slope = -Delta H°/R > 0)", "right": "Exothermic reaction (Delta H° < 0); K decreases with higher temperature" },
        { "left": "Y-Axis Intercept", "right": "Standard reaction entropy divided by gas constant (Delta_r S° / R)" },
        { "left": "Horizontal Zero Slope (Slope = 0)", "right": "Thermoneutral reaction (Delta H° = 0); K is completely independent of temperature" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a linear van 't Hoff plot of ln(K) versus 1/T, the slope of the line is equal to -Delta H° divided by the universal gas constant ___.",
      "blankAnswer": "r",
      "blankDistractors": ["k", "h", "f"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "The Haber-Bosch synthesis of ammonia (N2(g) + 3H2(g) <-> 2NH3(g)) is strongly EXOTHERMIC (Delta_r H° = -92.4 kJ/mol). According to the van 't Hoff equation, what happens to the equilibrium constant K_p when the reactor temperature is increased from 300 K to 750 K?",
      "options": [
        { "text": "The equilibrium constant K_p DROPS DRAMATICALLY; because Delta_r H° is negative, d(ln K)/dT is negative, so adding thermal energy shifts the thermodynamic equilibrium back toward reactants (N2 and H2)", "isCorrect": true, "explanation": "Correct! By the van 't Hoff equation, for any exothermic reaction (Delta H° < 0), d(ln K)/dT = Delta H° / (RT²) < 0, meaning K must decrease as temperature rises. At 300 K, K_p is ~10⁵, but at 750 K (industrial operating conditions chosen purely to speed up kinetics over iron catalysts), K_p plummets to ~10⁻³." },
        { "text": "K_p increases exponentially because high temperature always increases all equilibrium constants", "isCorrect": false, "explanation": "Incorrect: Only endothermic reactions have K increasing with temperature." },
        { "text": "K_p remains completely unchanged because pressure is constant", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "K_p becomes zero instantaneously", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
