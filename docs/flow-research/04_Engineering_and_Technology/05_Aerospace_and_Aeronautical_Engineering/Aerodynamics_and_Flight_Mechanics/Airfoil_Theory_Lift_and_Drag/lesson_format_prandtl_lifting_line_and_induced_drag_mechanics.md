# Duofy Reusable Lesson Format: 3D Wings (Prandtl Lifting-Line & Induced Drag)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Aerodynamics_and_Flight_Mechanics / Airfoil_Theory_Lift_and_Drag`  
**Lesson Format Type:** `prandtl_lifting_line_and_induced_drag_mechanics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the transition from 2D infinite-span airfoils to realistic finite 3D aircraft wings, Ludwig Prandtl's 1918 **Lifting-Line Theory**, trailing wingtip vortex generation, the downward **Downwash Velocity ($w(y)$)**, the geometric **Induced Angle of Attack ($\alpha_i = w / V_\infty$)**, effective angle of attack ($\alpha_{\text{eff}} = \alpha - \alpha_i$), **Induced Drag Coefficient ($C_{D,i}$)**, wing **Aspect Ratio ($AR = b^2 / S = b / \bar{c}$)**, Oswald span efficiency factor ($e \le 1.0$), and the proof of minimum induced drag for an elliptical lift distribution ($e = 1.0$) (John D. Anderson Jr. *Fundamentals of Aerodynamics* 6th ed. Chapter 5; Ludwig Prandtl 1918): formulate the **Prandtl Induced Drag Coefficient Master Formulation**:
$$\mathbf{C_{D,i} = \frac{C_L^2}{\pi \cdot AR \cdot e} \quad \left(AR = \frac{b^2}{S}, \ e \le 1.0\right)}$$
where:
1. **$C_{D,i}$:** 3D wing induced drag coefficient (drag due to lift generation);
2. **$C_L$:** Total 3D wing lift coefficient;
3. **$AR = \frac{b^2}{S}$:** Wing aspect ratio ($b = \text{wingspan}, S = \text{planform wing area}$);
4. **$e$:** Oswald wing planform span efficiency factor ($e = 1.00$ for elliptical wings such as the Supermarine Spitfire; $e \approx 0.80 - 0.90$ for rectangular/tapered wings);
derive the **Induced Drag Force Equation ($D_i$)**:
$$\mathbf{D_i = C_{D,i} \cdot q_\infty \cdot S = \left( \frac{C_L^2}{\pi \cdot AR \cdot e} \right) \left( \frac{1}{2} \rho_\infty V_\infty^2 S \right) = \frac{2 L^2}{\pi \cdot \rho_\infty V_\infty^2 b^2 \cdot e}}$$
derive the **Finite Wing 3D Lift Curve Slope ($a = \frac{dC_L}{d\alpha}$)**:
$$\mathbf{a = \frac{a_0}{1 + \frac{a_0}{\pi \cdot AR \cdot e_1}} = \frac{2\pi}{1 + \frac{2}{AR}} \quad [\text{rad}^{-1}] \quad (\text{proving } a < a_0 \text{ due to downwash})}$$
(proving that high aspect ratio wings ($AR \to 25-30$) virtually eliminate induced drag, while low aspect ratio wings ($AR < 4$) suffer catastrophic induced drag penalties at high lift).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Downwash ($w$), Induced AoA ($\alpha_i$), Induced Drag ($C_{D,i} = \frac{C_L^2}{\pi AR e}$) & $a = \frac{2\pi}{1 + 2/AR}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Wing Aspect Ratio, Induced Drag Coefficient, and Total Induced Drag Force Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Finite Wing Aerodynamic Construct / Vortex Parameter & Technical Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Prandtl's Lifting-Line Theory, the Theoretical Minimum Induced Drag for Any Wing of Given Span and Lift Occurs When the Spanwise Lift Distribution Is Perfectly ___ (Elliptical / Elliptic) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Aircraft Wing Design Problem: Calculating Induced Drag Coefficient CDi and Induced Drag Force Di for a Jet Transport Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Prandtl Lifting-Line Mechanics (Prandtl 1918; Anderson 2016):
   - **3D Wing Formulations:**
     $$\mathbf{C_{D,i} = \frac{C_L^2}{\pi AR e} \quad \Big| \quad D_i = \frac{2 L^2}{\pi \rho_\infty V_\infty^2 b^2 e} \quad \Big| \quad a = \frac{a_0}{1 + \frac{a_0}{\pi AR e_1}} \quad \Big| \quad \alpha_i = \frac{C_L}{\pi AR e}}$$
   - **Aspect Ratio ($AR$) Impact Matrix ($C_L = 1.0, e = 0.85$):**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Aircraft Wing Category} & \textbf{Aspect Ratio } AR & \textbf{Induced Drag } C_{D,i} & \textbf{Aerodynamic Flight Role} \\
     \hline
     \mathbf{\text{High-Performance Sailplane (Glider)}} & \mathbf{25.0 - 32.0} & \mathbf{0.012 - 0.015} & \mathbf{\text{Near-zero induced drag; ultra-high } L/D > 50} \\
     \mathbf{\text{Commercial Airliner (Boeing 787)}} & \mathbf{9.0 - 11.0} & \mathbf{0.035 - 0.040} & \text{Optimal fuel efficiency / gate wingspan balance} \\
     \text{General Aviation (Cessna 172)} & 7.0 - 8.0 & 0.045 - 0.055 & Good structural weight / climb performance \\
     \mathbf{\text{Supersonic Fighter (Delta Wing)}} & \mathbf{2.0 - 3.5} & \mathbf{0.120 - 0.180} & \mathbf{\text{Extreme induced drag; low wave drag at Mach } > 1} \\
     \hline
     \end{array}$$
   - **The Induced Drag Inverse Velocity Invariant:** Induced drag force scales inversely with velocity squared (**$D_i \propto 1/V_\infty^2$**); flying slowly at high lift (takeoff and landing) generates maximum induced drag, which drops rapidly at high cruise speeds!
2. **Slide 2 (`ordering`):** Provide 5 steps of induced drag calculation: (1) determine wingspan $b$, wing planform area $S$, and compute aspect ratio $AR = b^2 / S$, (2) identify total wing lift coefficient $C_L$ and Oswald span efficiency factor $e \approx 0.85$, (3) compute induced drag coefficient: $C_{D,i} = \frac{C_L^2}{\pi \cdot AR \cdot e}$, (4) calculate freestream dynamic pressure: $q_\infty = \frac{1}{2}\rho_\infty V_\infty^2$, (5) multiply by wing area to get induced drag force: $D_i = C_{D,i} \cdot q_\infty \cdot S$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Prandtl Induced Drag $C_{D,i}$, Downwash Velocity $w$, Oswald Factor $e$, Wing Aspect Ratio $AR$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Elliptical (or Elliptic). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating induced drag: A regional jet has wing area $S = 60.0\text{ m}^2$, wingspan $b = 24.0\text{ m}$ (Aspect ratio $AR = \frac{b^2}{S} = \frac{24.0^2}{60.0} = \frac{576.0}{60.0} = \mathbf{9.60}$), Oswald factor $e = 0.850$, and total lift coefficient $C_L = 0.600$ at cruise ($V_\infty = 200.0\text{ m/s}, \rho_\infty = 0.500\text{ kg/m}^3$).
   - Dynamic pressure: $q_\infty = \frac{1}{2} \rho_\infty V_\infty^2 = \frac{1}{2} \times 0.500 \times (200.0)^2 = 0.250 \times 40,000 = \mathbf{10,000.0\text{ Pa} = 10.0\text{ kPa}}$;
   - Lift coefficient squared: $C_L^2 = (0.600)^2 = \mathbf{0.360}$;
   - Denominator: $\pi \cdot AR \cdot e = \pi \times 9.60 \times 0.850 = \pi \times 8.160 = \mathbf{25.6354}$;
   - Induced drag coefficient: $C_{D,i} = \frac{0.360}{25.6354} = \mathbf{0.014043 \approx 0.01404}$;
   - Induced drag force: $D_i = C_{D,i} \cdot q_\infty \cdot S = 0.014043 \times 10,000.0\text{ Pa} \times 60.0\text{ m}^2 = 140.43 \times 60.0 = \mathbf{8425.7\text{ N} \approx 8.43\text{ kN}}$;
   - What is the induced drag coefficient $C_{D,i}$ and the induced drag force $D_i$? ($C_{D,i} = \mathbf{0.0140}$ and $D_i = \mathbf{8.43\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "prandtl_lifting_line_and_induced_drag_mechanics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 3D Wings \\& Prandtl Lifting-Line Theory (Ludwig Prandtl 1918)**\n• **Prandtl Induced Drag Coefficient Master Formulation:**\n$$\n\\mathbf{C_{D,i} = \\frac{C_L^2}{\\pi \\cdot AR \\cdot e} \\quad \\left(AR = \\frac{b^2}{S} = \\frac{b}{\\bar{c}}, \\ e \\le 1.0\\right)}\n$$\n  - **$C_{D,i}$:** Induced drag coefficient resulting from wingtip vortex downwash;\n  - **$C_L$:** Total 3D aircraft wing lift coefficient;\n  - **$AR = b^2 / S$:** Wing aspect ratio;\n  - **$e$:** Oswald span efficiency factor ($e = 1.00$ for ideal elliptical lift distribution);\n• **Induced Drag Force Formulation ($D_i$):**\n$$\n\\mathbf{D_i = C_{D,i} \\cdot q_\\infty \\cdot S = \\frac{2 L^2}{\\pi \\cdot \\rho_\\infty V_\\infty^2 b^2 \\cdot e} \\quad [\\text{Newtons}]}\n$$\n• **Finite Wing 3D Lift Curve Slope Formulation ($a$):**\n$$\n\\mathbf{a = \\frac{dC_L}{d\\alpha} = \\frac{a_0}{1 + \\frac{a_0}{\\pi \\cdot AR \\cdot e_1}} = \\frac{2\\pi}{1 + \\frac{2}{AR}} \\quad [\\text{rad}^{-1}]}\n$$\n• **The Velocity Inversion Invariant:** Induced drag force scales **inversely with airspeed squared ($D_i \\propto 1/V_\\infty^2$)**; at slow takeoff speeds, induced drag constitutes over $80\\%$ of total aircraft resistance, dropping to $<20\\%$ at high-speed cruise!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the induced drag coefficient and total induced drag force on a finite 3D aircraft wing.",
      "orderItems": [
        "Determine the wingspan b and wing planform area S to compute the wing aspect ratio: AR = b^2 / S",
        "Extract the flight operating conditions: air density \u03c1\u221e, airspeed V\u221e, and required lift coefficient CL",
        "Determine the Oswald span efficiency factor e based on wing taper ratio and planform geometry",
        "Calculate the 3D induced drag coefficient from Prandtl's formula: C_Di = CL^2 / (\u03c0 * AR * e)",
        "Calculate freestream dynamic pressure q\u221e = 0.5*\u03c1\u221e*V\u221e^2 and compute total induced drag force: Di = C_Di * q\u221e * S"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each 3D Wing Aerodynamic Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Induced Drag (C_Di)", "right": "C_Di = CL^2 / (\u03c0*AR*e), unavoidable aerodynamic drag penalty created by downward vortex downwash" },
        { "left": "Wing Aspect Ratio (AR)", "right": "AR = b^2 / S, ratio of wingspan to average chord measuring slender wing geometry" },
        { "left": "Downwash Velocity (w)", "right": "Downward vertical component of flow imparted on oncoming air by trailing wingtip vortices" },
        { "left": "Elliptical Wing Planform", "right": "Ideal geometric shape (e.g. Supermarine Spitfire) achieving maximum span efficiency e = 1.00" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Prandtl's lifting-line theory, the theoretical minimum induced drag for any wing of given span and lift occurs when the spanwise lift distribution is perfectly ___.",
      "blankAnswer": "elliptical",
      "blankDistractors": ["rectangular", "triangular", "circular"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A regional jet has S = 60.0 m^2, b = 24.0 m (AR = 24^2 / 60 = 576 / 60 = 9.60), e = 0.850, and CL = 0.600 (CL^2 = 0.360). In cruise, V\u221e = 200.0 m/s and \u03c1\u221e = 0.500 kg/m^3 (q\u221e = 0.5 * 0.5 * 200^2 = 10,000 Pa). \u03c0*AR*e = \u03c0*9.60*0.85 = 25.635. What is the induced drag coefficient C_Di and the total induced drag force Di?",
      "options": [
        { "text": "C_Di = 0.0140 and Di = 8.43 kN (C_Di = 0.360 / 25.6354 = 0.014043 \u2248 0.0140; Di = 0.014043 * 10,000 Pa * 60.0 m^2 = 8425.8 N \u2248 8.43 kN)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Ludwig Prandtl's lifting-line induced drag theory (John D. Anderson Jr. *Fundamentals of Aerodynamics* Chapter 5). 1. **Calculate Geometric Wing Aspect Ratio ($AR$):** - Wingspan: $b = 24.0\\text{ m}$. - Wing planform area: $S = 60.0\\text{ m}^2$. $$AR = \\frac{b^2}{S} = \\frac{(24.0\\text{ m})^2}{60.0\\text{ m}^2} = \\frac{576.0}{60.0} = \\mathbf{9.600}$$ 2. **Calculate Induced Drag Coefficient ($C_{D,i}$):** - Lift coefficient: $C_L = 0.600 \\implies C_L^2 = (0.600)^2 = \\mathbf{0.3600}$. - Oswald span efficiency factor: $e = 0.850$. - Denominator: $$\\pi \\cdot AR \\cdot e = \\pi \\times 9.600 \\times 0.850 = \\pi \\times 8.160 = \\mathbf{25.635396}$$ - Prandtl induced drag equation: $$C_{D,i} = \\frac{C_L^2}{\\pi \\cdot AR \\cdot e} = \\frac{0.3600}{25.635396} = \\mathbf{0.0140431 \\approx 0.01404}$$ 3. **Calculate Freestream Dynamic Pressure ($q_\\infty$):** - Flight speed: $V_\\infty = 200.0\\text{ m/s} \\implies V_\\infty^2 = 40,000\\text{ m}^2\\text{/s}^2$. - Air density at cruise altitude: $\\rho_\\infty = 0.500\\text{ kg/m}^3$. $$q_\\infty = \\frac{1}{2} \\rho_\\infty V_\\infty^2 = \\frac{1}{2} \\times 0.500\\text{ kg/m}^3 \\times 40,000\\text{ m}^2\\text{/s}^2 = \\mathbf{10,000.0\\text{ Pa} = 10.0\\text{ kPa}}$$ 4. **Calculate Total Induced Drag Force ($D_i$):** $$D_i = C_{D,i} \\cdot q_\\infty \\cdot S = 0.0140431 \\times 10,000.0\\text{ Pa} \\times 60.0\\text{ m}^2$$ $$D_i = 140.431\\text{ N/m}^2 \\times 60.0\\text{ m}^2 = \\mathbf{8425.86\\text{ N} = 8.426\\text{ kN} \\approx 8.43\\text{ kN}}$$ Flawless 3D wing aspect ratio and Prandtl induced drag derivation!" },
        { "text": "C_Di = 0.0281 and Di = 16.85 kN", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C_Di = 0.0140 and Di = 140.4 N (Forgot to multiply by wing area S)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C_Di = 0.0070 and Di = 4.21 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
