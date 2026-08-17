# Duofy Reusable Lesson Format: Clay Consolidation (Terzaghi 1D Theory & Settlement)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Shear_Strength_and_Slope_Stability`  
**Lesson Format Type:** `terzaghi_one_dimensional_consolidation_and_settlement`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Karl Terzaghi's 1925 theory of **One-Dimensional Consolidation**, the dissipation of excess pore water pressure ($u$) over time, the oedometer $e - \log\sigma'$ compression curve, compression index ($C_c$), recompression / swell index ($C_s$), pre-consolidation pressure ($\sigma_p'$), Overconsolidation Ratio ($\text{OCR} = \sigma_p' / \sigma_0'$), primary consolidation settlement ($S_c$), coefficient of consolidation ($c_v$), and dimensionless time factor ($T_v$) (Braja M. Das *Principles of Geotechnical Engineering* 9th ed. Chapter 11; Karl Terzaghi *Theoretical Soil Mechanics* Chapter 13): formulate the **Terzaghi 1D Consolidation Governing Differential Equation**:
$$\mathbf{\frac{\partial u}{\partial t} = c_v \frac{\partial^2 u}{\partial z^2} \quad \left(c_v = \frac{k}{\gamma_w \cdot m_v} = \text{Coefficient of Consolidation}\right)}$$
derive the **Primary Consolidation Settlement ($S_c$) Equations**:
1. **Normally Consolidated ($NC$) Clay ($\mathbf{\sigma_0' = \sigma_p', \ \text{OCR} = 1.0}$):**
   $$\mathbf{S_c = \frac{C_c \cdot H_0}{1 + e_0} \log_{10}\left( \frac{\sigma_0' + \Delta\sigma'}{\sigma_0'} \right)}$$
2. **Overconsolidated ($OC$) Clay ($\mathbf{\sigma_0' < \sigma_p', \ \text{OCR} > 1.0}$):**
   - Case A ($\sigma_0' + \Delta\sigma' \le \sigma_p'$): $\mathbf{S_c = \frac{C_s \cdot H_0}{1 + e_0} \log_{10}\left( \frac{\sigma_0' + \Delta\sigma'}{\sigma_0'} \right)}$
   - Case B ($\sigma_0' + \Delta\sigma' > \sigma_p'$): $\mathbf{S_c = \frac{C_s \cdot H_0}{1 + e_0} \log_{10}\left( \frac{\sigma_p'}{\sigma_0'} \right) + \frac{C_c \cdot H_0}{1 + e_0} \log_{10}\left( \frac{\sigma_0' + \Delta\sigma'}{\sigma_p'} \right)}$
derive the **Consolidation Rate & Time Factor ($T_v$)**:
$$\mathbf{T_v = \frac{c_v \cdot t}{H_{dr}^2} \quad \left(H_{dr} = \frac{H_0}{2} \text{ for Two-Way Drainage, } H_{dr} = H_0 \text{ for One-Way Drainage}\right)}$$
(proving why doubling the clay layer drainage path $H_{dr}$ quadruples the time required to reach $90\%$ consolidation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Terzaghi PDE ($\frac{\partial u}{\partial t} = c_v \frac{\partial^2 u}{\partial z^2}$), Settlement ($S_c$) & Time Factor ($T_v = \frac{c_v t}{H_{dr}^2}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Primary Consolidation Settlement for a Clay Stratum Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Consolidation Parameter / Curve Property & Technical Geotechnical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | If a Saturated Clay Layer Has Permeable Sand Boundaries at Both the Top and Bottom, Its Maximum Drainage Path $H_{dr}$ Equals Exactly ___ of the Layer Thickness (Half / 0.5) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Foundation Engineering Problem: Calculating Primary Consolidation Settlement for a 4m Normally Consolidated Clay Layer Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Terzaghi 1D Consolidation (Terzaghi 1925; Das 2018):
   - **Consolidation & Settlement Formulations:**
     $$\mathbf{\frac{\partial u}{\partial t} = c_v \frac{\partial^2 u}{\partial z^2} \quad \Big| \quad S_c = \frac{C_c H_0}{1 + e_0} \log_{10}\left(\frac{\sigma_0' + \Delta\sigma'}{\sigma_0'}\right) \quad \Big| \quad T_v = \frac{c_v t}{H_{dr}^2} \quad \Big| \quad \text{OCR} = \frac{\sigma_p'}{\sigma_0'}}$$
   - **Consolidation State Matrix:**
     $$\begin{array}{|l|c|l|l|}
     \hline
     \textbf{Soil Consolidation State} & \textbf{OCR Value} & \textbf{Effective Stress Condition} & \textbf{Governing Slope Index} \\
     \hline
     \mathbf{\text{Normally Consolidated (NC)}} & \mathbf{\text{OCR} = 1.0} & \sigma_0' = \sigma_p' \ (\text{Current stress is historic maximum}) & \mathbf{C_c \ (\text{Virgin Compression Index})} \\
     \mathbf{\text{Overconsolidated (OC)}} & \mathbf{\text{OCR} > 1.0} & \sigma_0' < \sigma_p' \ (\text{Past stress was higher; e.g. glaciers}) & \mathbf{C_s \ (\text{Swell/Recompression Index } \approx \frac{1}{5} C_c)} \\
     \mathbf{\text{Underconsolidated}} & \text{OCR} < 1.0 & \text{Currently settling under self-weight} & \text{Excess pore pressure active} \\
     \hline
     \end{array}$$
   - **The Drainage Path Invariant:** Because consolidation time $t = \frac{T_v H_{dr}^2}{c_v}$ scales with the **square of the drainage path $H_{dr}^2$**, single-drainage layers settle **4 times slower** than double-drainage layers of identical thickness!
2. **Slide 2 (`ordering`):** Provide 5 steps of consolidation analysis: (1) determine initial effective overburden pressure $\sigma_0'$ at the mid-depth of the clay layer, (2) compute stress increase $\Delta\sigma'$ caused by foundation loads, (3) compare $\sigma_0'$ and $\sigma_0' + \Delta\sigma'$ against pre-consolidation pressure $\sigma_p'$ to check $\text{NC}$ vs $\text{OC}$ state, (4) evaluate primary consolidation settlement $S_c$ using $C_c$ and/or $C_s$, (5) compute time factor $T_v = c_v t / H_{dr}^2$ to determine the rate of settlement over months or years!
3. **Slide 3 (`matching`):** Pair 4 concepts (Compression Index $C_c$, Swell Index $C_s$, Drainage Distance $H_{dr}$, Time Factor $T_v$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Half (or 0.5). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating primary settlement: A normally consolidated ($NC$) clay layer of thickness $H_0 = 4.0\text{ m}$ has initial void ratio $e_0 = 0.80$ and compression index $C_c = 0.36$. The initial effective overburden stress at mid-depth is $\sigma_0' = 100.0\text{ kPa}$. A structural foundation increases the stress by $\Delta\sigma' = 100.0\text{ kPa}$ (so final stress $\sigma_0' + \Delta\sigma' = 200.0\text{ kPa}$). Given $\log_{10}(200 / 100) = \log_{10}(2.0) \approx 0.30103$. What is the total primary consolidation settlement $S_c$? ($S_c = \frac{C_c \cdot H_0}{1 + e_0} \log_{10}\left(\frac{\sigma_0' + \Delta\sigma'}{\sigma_0'}\right) = \frac{0.36 \times 4.0\text{ m}}{1 + 0.80} \times \log_{10}\left(\frac{200}{100}\right) = \frac{1.44\text{ m}}{1.80} \times 0.30103 = 0.80\text{ m} \times 0.30103 = 0.2408\text{ m} = \mathbf{240.8\text{ mm} \approx 241\text{ mm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "terzaghi_one_dimensional_consolidation_and_settlement",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Terzaghi 1D Consolidation \\& Primary Settlement (Karl Terzaghi)**\n• **Terzaghi 1D Consolidation Differential Equation:**\n$$\n\\mathbf{\\frac{\\partial u}{\\partial t} = c_v \\frac{\\partial^2 u}{\\partial z^2} \\quad \\left(c_v = \\frac{k}{\\gamma_w \\cdot m_v}\\right)}\n$$\n• **Primary Consolidation Settlement Formulations ($S_c$):**\n  - **Normally Consolidated Clay ($\\mathbf{\\sigma_0' = \\sigma_p', \\ \\text{OCR} = 1.0}$):**\n$$\n\\mathbf{S_c = \\frac{C_c \\cdot H_0}{1 + e_0} \\log_{10}\\left( \\frac{\\sigma_0' + \\Delta\\sigma'}{\\sigma_0'} \\right)}\n$$\n  - **Overconsolidated Clay ($\\mathbf{\\text{OCR} > 1.0}$):** Uses $C_s$ up to $\\sigma_p'$ and $C_c$ beyond $\\sigma_p'$;\n• **Consolidation Rate \\& Dimensionless Time Factor ($T_v$):**\n$$\n\\mathbf{T_v = \\frac{c_v \\cdot t}{H_{dr}^2} \\quad \\left(H_{dr} = \\frac{H_0}{2} \\text{ for 2-Way Drainage}, \\ H_{dr} = H_0 \\text{ for 1-Way}\\right)}\n$$\n• **The Drainage Geometry Invariant:** Consolidation time scales with **$H_{dr}^2$**; doubling the drainage distance **quadruples ($4\\times$) the time required** to reach target consolidation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate primary consolidation settlement and time rate of settlement for a clay foundation stratum.",
      "orderItems": [
        "Compute the initial in-situ vertical effective overburden stress \u03c30' at the middle depth of the clay layer",
        "Determine the net stress increase \u0394\u03c3' induced at the clay mid-depth using Boussinesq or 2:1 stress distribution",
        "Compare \u03c30' and (\u03c30' + \u0394\u03c3') against the pre-consolidation pressure \u03c3p' to classify the clay as NC or OC",
        "Calculate primary consolidation settlement: Sc = [Cc * H0 / (1 + e0)] * log10((\u03c30' + \u0394\u03c3') / \u03c30')",
        "Determine the maximum drainage distance Hdr (H0/2 for two-way) and compute time t = (Tv * Hdr^2) / cv"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Soil Consolidation Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Compression Index (Cc)", "right": "Slope of the virgin e-log\u03c3' loading curve governing large plastic consolidation deformation in NC clays" },
        { "left": "Recompression Index (Cs)", "right": "Slope of the elastic unloading-reloading loop in OC clays (Cs \u2248 0.1 to 0.2 times Cc)" },
        { "left": "Overconsolidation Ratio (OCR)", "right": "OCR = \u03c3p' / \u03c30', ratio of maximum historic past overburden pressure to current in-situ effective stress" },
        { "left": "Drainage Path (Hdr)", "right": "Longest distance a water molecule must travel to escape to a permeable drainage boundary" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "If a saturated clay layer has permeable sand boundaries at both the top and bottom, its maximum drainage path Hdr equals exactly ___ of the layer thickness.",
      "blankAnswer": "half",
      "blankDistractors": ["double", "all", "one-fourth"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A normally consolidated clay stratum (H0 = 4.0 m, e0 = 0.80, Cc = 0.36) has initial effective stress \u03c30' = 100.0 kPa at mid-depth. A building load adds \u0394\u03c3' = 100.0 kPa (final stress = 200.0 kPa, log10(200/100) = log10(2) = 0.30103). What is the total primary consolidation settlement Sc of the layer?",
      "options": [
        { "text": "Sc = 240.8 mm (0.241 m) (Sc = [0.36 * 4.0 / (1 + 0.80)] * log10(200 / 100) = (1.44 / 1.80) * 0.30103 = 0.80 * 0.30103 = 0.2408 m = 240.8 mm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Terzaghi's primary consolidation settlement formula for Normally Consolidated clays (Braja M. Das *Principles of Geotechnical Engineering* Chapter 11). 1. **Identify the Given Geotechnical Parameters:** - Layer thickness: $H_0 = 4.0\\text{ m}$. - Initial void ratio: $e_0 = 0.80$. - Virgin compression index: $C_c = 0.36$. - Initial effective overburden stress: $\\sigma_0' = 100.0\\text{ kPa}$. - Net stress increment: $\\Delta\\sigma' = 100.0\\text{ kPa}$. - Final effective stress: $\\sigma_f' = \\sigma_0' + \\Delta\\sigma' = 100.0 + 100.0 = 200.0\\text{ kPa}$. 2. **Calculate the Stress Ratio Logarithm:** $$\\log_{10}\\left(\\frac{\\sigma_0' + \\Delta\\sigma'}{\\sigma_0'}\\right) = \\log_{10}\\left(\\frac{200.0\\text{ kPa}}{100.0\\text{ kPa}}\\right) = \\log_{10}(2.0) = \\mathbf{0.30103}$$ 3. **Evaluate Primary Consolidation Settlement ($S_c$):** $$S_c = \\frac{C_c \\cdot H_0}{1 + e_0} \\log_{10}\\left( \\frac{\\sigma_0' + \\Delta\\sigma'}{\\sigma_0'} \\right)$$ $$S_c = \\left( \\frac{0.36 \\times 4.0\\text{ m}}{1 + 0.80} \\right) \\times 0.30103 = \\left( \\frac{1.440\\text{ m}}{1.800} \\right) \\times 0.30103$$ $$S_c = (0.8000\\text{ m}) \\times 0.30103 = \\mathbf{0.240824\\text{ m} = 240.82\\text{ mm} \\approx 241\\text{ mm}}$$ Flawless 1D primary consolidation settlement derivation!" },
        { "text": "Sc = 481.6 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Sc = 120.4 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Sc = 301.0 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
