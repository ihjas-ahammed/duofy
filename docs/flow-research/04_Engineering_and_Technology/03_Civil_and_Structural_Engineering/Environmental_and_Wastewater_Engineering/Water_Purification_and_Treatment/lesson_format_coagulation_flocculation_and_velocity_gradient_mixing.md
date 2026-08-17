# Duofy Reusable Lesson Format: Coagulation & Mixing (Velocity Gradients & Camp Numbers)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Water_Purification_and_Treatment`  
**Lesson Format Type:** `coagulation_flocculation_and_velocity_gradient_mixing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through chemical coagulation and physical flocculation in potable water treatment, colloidal stability (electrical double layer and negative zeta potential $\approx -15\text{ to } -30\text{ mV}$), metal coagulant hydrolyzing chemistry (Alum $\text{Al}_2(\text{SO}_4)_3 \cdot 14\text{H}_2\text{O}$ and Ferric Chloride $\text{FeCl}_3$), charge neutralization and sweep flocculation mechanisms, Thomas R. Camp and P. C. Stein's **Velocity Gradient ($G$)**, mixing power dissipation ($P$), and the dimensionless **Camp Collision Number ($G \cdot t$)** for rapid mix and tapered flocculator tanks (Mackenzie L. Davis *Water and Wastewater Engineering* 2nd ed. Chapter 6; John C. Crittenden *MWH's Water Treatment* Chapter 9): formulate the **Camp-Stein Velocity Gradient ($G$) Master Equation**:
$$\mathbf{G = \sqrt{\frac{P}{\mu \cdot V}} \quad [\text{s}^{-1}] \Longleftrightarrow \mathbf{P = G^2 \cdot \mu \cdot V \quad [\text{Watts}]}}$$
where:
1. **$P$:** Mechanical power dissipated into the water in Watts ($\text{W}$);
2. **$\mu$:** Dynamic viscosity of water ($\mu \approx 1.002 \times 10^{-3}\text{ Pa}\cdot\text{s}$ at $20^\circ\text{C}$);
3. **$V$:** Tank liquid volume in cubic meters ($V = Q \cdot t_{\text{detention}}$);
4. **$t$:** Hydraulic retention time in seconds;
derive the **Dimensionless Camp Collision Number ($Gt$)**:
$$\mathbf{\text{Camp Number} = G \cdot t = \left(\sqrt{\frac{P}{\mu V}}\right) t}$$
master the **Process Operating Regime Guidelines**:
- **Rapid Mixing Tank:** $G = 700 - 1000\text{ s}^{-1}, \ t = 30 - 60\text{ s}, \ Gt \approx 20,000 - 60,000$ (intense turbulence to disperse hydrolyzing coagulant ions in $< 1\text{ s}$ before precipitate formation);
- **Tapered 3-Stage Flocculator:** Stage 1 ($G_1 \approx 50\text{ s}^{-1}$), Stage 2 ($G_2 \approx 30\text{ s}^{-1}$), Stage 3 ($G_3 \approx 15\text{ s}^{-1}$), total $t = 20 - 45\text{ min}$, $Gt \approx 20,000 - 100,000$ (tapered mixing prevents high shear from tearing fragile growing flocs apart).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Velocity Gradient ($G = \sqrt{P/(\mu V)}$), Power ($P = G^2 \mu V$) & Camp Number ($Gt$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size a Rapid Mix Tank and Determine Mixer Impeller Power Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Coagulation / Flocculation Parameter & Technical Water Treatment Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Three-Stage Flocculation Basin, the Velocity Gradient $G$ Is Gradually Reduced in Each Successive Chamber to Prevent Floc ___ (Shear / Breakage / Tear) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Water Engineering Problem: Calculating Required Mixer Motor Power for a 50m^3 Rapid Mix Basin Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Coagulation & Velocity Gradient Mechanics (Camp 1943; Davis 2020):
   - **Mixing & Power Formulations:**
     $$\mathbf{G = \sqrt{\frac{P}{\mu V}} \quad \Big| \quad P = G^2 \mu V \quad \Big| \quad Gt = G \cdot t \quad \Big| \quad \text{Alum: } \text{Al}_2(\text{SO}_4)_3 \cdot 14\text{H}_2\text{O} \to 2\text{Al}^{3+} + 3\text{SO}_4^{2-}}$$
   - **Rapid Mix vs Flocculation Comparison Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Unit Process} & \textbf{Velocity Gradient } G & \textbf{Detention Time } t & \textbf{Camp Number } Gt & \textbf{Primary Physical Objective} \\
     \hline
     \mathbf{\text{Rapid Mix Basin}} & \mathbf{700 - 1000\text{ s}^{-1}} & \mathbf{30 - 60\text{ s}} & \mathbf{20,000 - 60,000} & \mathbf{\text{Instantaneous coagulant dispersion & charge neutralization}} \\
     \mathbf{\text{Flocculator (Stage 1)}} & 50 - 60\text{ s}^{-1} & 10 - 15\text{ min} & 30,000 - 50,000 & \text{Microfloc collision and initial agglomeration} \\
     \mathbf{\text{Flocculator (Stage 2)}} & 30 - 40\text{ s}^{-1} & 10 - 15\text{ min} & 20,000 - 35,000 & \text{Macrofloc consolidation with moderate shearing} \\
     \mathbf{\text{Flocculator (Stage 3)}} & \mathbf{15 - 20\text{ s}^{-1}} & \mathbf{10 - 15\text{ min}} & \mathbf{10,000 - 20,000} & \mathbf{\text{Gentle sweeping growth without floc breakage}} \\
     \hline
     \end{array}$$
   - **The Tapering Invariant:** Floc strength decreases as floc size grows ($d_{\text{floc}} \uparrow \implies \text{shear threshold } \tau_{\text{crit}} \downarrow$); reducing $G$ along the flow path is **mandatory to prevent floc breakup** before entering the clarifier!
2. **Slide 2 (`ordering`):** Provide 5 steps of rapid mix tank design: (1) determine design water flow rate $Q$ and target detention time $t = 30-60\text{ s}$, (2) compute tank volume $V = Q \cdot t$, (3) select target velocity gradient $G$ (e.g. $800\text{ s}^{-1}$) and obtain dynamic viscosity $\mu$ at water design temperature, (4) calculate required water power dissipation: $P = G^2 \mu V$, (5) compute required mixer electric motor power: $P_{\text{motor}} = P / \eta_{\text{impeller}}$ (where efficiency $\eta \approx 0.80$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Velocity Gradient $G$, Camp Number $Gt$, Zeta Potential Neutralization, Tapered Flocculation) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Breakage (or Shear / Tear). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating mixer power: A municipal rapid mix tank treats a flow of $Q = 1.0\text{ m}^3\text{/s}$ with a detention time $t = 50.0\text{ s}$ ($V = 50.0\text{ m}^3$). The target velocity gradient is $G = 800.0\text{ s}^{-1}$ and dynamic viscosity of water is $\mu = 1.00 \times 10^{-3}\text{ Pa}\cdot\text{s} = 0.0010\text{ N}\cdot\text{s/m}^2$.
   - Velocity gradient squared: $G^2 = (800.0)^2 = \mathbf{640,000\text{ s}^{-2}}$;
   - Water power dissipation: $P = G^2 \mu V = 640,000 \times 0.0010 \times 50.0 = 640.0 \times 50.0 = \mathbf{32,000\text{ W} = 32.0\text{ kW}}$;
   - Camp collision number: $Gt = 800.0\text{ s}^{-1} \times 50.0\text{ s} = \mathbf{40,000}$ (falls in optimal $20,000 - 60,000$ range);
   - What is the power transferred to the water $P$ and the Camp collision number $Gt$? ($P = \mathbf{32.0\text{ kW}}$ and $Gt = \mathbf{40,000}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "coagulation_flocculation_and_velocity_gradient_mixing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Mixing Hydraulics \\& Velocity Gradients (Camp \\& Stein)**\n• **Velocity Gradient Master Formulation ($G$):**\n$$\n\\mathbf{G = \\sqrt{\\frac{P}{\\mu \\cdot V}} \\quad [\\text{s}^{-1}] \\Longleftrightarrow \\mathbf{P = G^2 \\cdot \\mu \\cdot V \\quad [\\text{Watts}]}}\n$$\n  - **$P$:** Power dissipated in water ($\\text{W}$);\n  - **$\\mu$:** Water dynamic viscosity ($\\approx 1.002 \\times 10^{-3}\\text{ Pa}\\cdot\\text{s}$ at $20^\\circ\\text{C}$);\n  - **$V$:** Tank liquid volume ($\\text{m}^3$);\n• **Dimensionless Camp Collision Number Formulation ($Gt$):**\n$$\n\\mathbf{Gt = G \\cdot t \\quad (t = \\text{Hydraulic Retention Time in seconds})}\n$$\n• **Process Operational Thresholds:**\n  - **Rapid Mix Basin:** $G = 700 - 1000\\text{ s}^{-1}, \\ t = 30 - 60\\text{ s}, \\ Gt = 20,000 - 60,000$;\n  - **Tapered Flocculator:** $G_1 = 50 \\to G_2 = 30 \\to G_3 = 15\\text{ s}^{-1}, \\ t = 20 - 45\\text{ min}, \\ Gt = 10^4 - 10^5$;\n• **The Floc Shear Invariant:** Large flocs have fragile inter-particle polymer bridges; **tapering $G$ downward from Stage 1 to Stage 3** promotes collision while preventing hydrodynamic shear breakup!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a mechanical rapid mixing tank for municipal water coagulation.",
      "orderItems": [
        "Determine the design plant volumetric flow rate Q and select target rapid mix detention time t (30 to 60 seconds)",
        "Calculate the required mixing basin volume: V = Q * t",
        "Select target velocity gradient G (700 to 1000 s^-1) and extract water dynamic viscosity \u03bc at minimum design temperature",
        "Calculate the net mechanical mixing power transferred to the water: P = G^2 * \u03bc * V",
        "Compute the Camp collision index G*t and apply motor efficiency (\u03b7 \u2248 0.80) to size the electric drive motor: P_motor = P / \u03b7"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Coagulation & Flocculation Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Velocity Gradient (G)", "right": "G = \u221a[P / (\u03bc*V)], rate of change of fluid velocity over distance measuring mixing shear intensity" },
        { "left": "Camp Number (Gt)", "right": "Dimensionless index measuring the total cumulative opportunity for inter-particle collisions" },
        { "left": "Charge Neutralization", "right": "Adsorption of trivalent metal ions (Al3+, Fe3+) to collapse the negative colloidal zeta potential" },
        { "left": "Tapered Flocculation", "right": "Progressive stepwise reduction of mixing energy (G1 \u2192 G2 \u2192 G3) preventing hydrodynamic floc breakup" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a three-stage flocculation basin, the velocity gradient G is gradually reduced in each successive chamber to prevent floc ___.",
      "blankAnswer": "breakage",
      "blankDistractors": ["settling", "dissolution", "neutralization"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rapid mix tank treats water flow Q = 1.0 m^3/s with detention time t = 50.0 s (V = 50.0 m^3). Target velocity gradient is G = 800.0 s^-1 and water viscosity is \u03bc = 0.0010 Pa*s. What is the power P dissipated in the water and the dimensionless Camp collision number Gt?",
      "options": [
        { "text": "P = 32.0 kW and Gt = 40,000 (P = G^2 * \u03bc * V = 800^2 * 0.0010 * 50.0 = 640,000 * 0.0010 * 50.0 = 32,000 W = 32.0 kW; Gt = 800 * 50 = 40,000)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Camp-Stein velocity gradient and power formulations (Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 6). 1. **Identify Basin Hydraulic \\& Physical Parameters:** - Volumetric flow rate: $Q = 1.0\\text{ m}^3\\text{/s}$. - Detention time: $t = 50.0\\text{ s}$. - Rapid mix basin volume: $$V = Q \\times t = 1.0\\text{ m}^3\\text{/s} \\times 50.0\\text{ s} = \\mathbf{50.0\\text{ m}^3}$$ - Target velocity gradient: $G = 800.0\\text{ s}^{-1}$. - Dynamic viscosity of water: $\\mu = 1.00 \\times 10^{-3}\\text{ Pa}\\cdot\\text{s} = 0.0010\\text{ N}\\cdot\\text{s/m}^2$. 2. **Calculate Required Mixing Power Dissipated in Water ($P$):** - Square of velocity gradient: $$G^2 = (800.0\\text{ s}^{-1})^2 = \\mathbf{640,000\\text{ s}^{-2}}$$ - Camp-Stein power equation: $$P = G^2 \\cdot \\mu \\cdot V = 640,000\\text{ s}^{-2} \\times (0.0010\\text{ Pa}\\cdot\\text{s}) \\times 50.0\\text{ m}^3$$ $$P = 640.0 \\times 50.0 = \\mathbf{32,000\\text{ Watts} = 32.0\\text{ kW}}$$ 3. **Calculate Dimensionless Camp Collision Number ($Gt$):** $$Gt = G \\cdot t = 800.0\\text{ s}^{-1} \\times 50.0\\text{ s} = \\mathbf{40,000}$$ 4. **Design Check:** - The calculated Camp number $Gt = 40,000$ falls perfectly within the standard rapid mix specification range ($20,000 - 60,000$), ensuring complete coagulant dispersion! Flawless mixing hydraulics and velocity gradient derivation!" },
        { "text": "P = 40.0 kW and Gt = 40,000", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P = 32.0 kW and Gt = 800 (Forgot to multiply by detention time)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P = 64.0 kW and Gt = 80,000", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
