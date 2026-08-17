# Duofy Reusable Lesson Format: Packed Beds (Ergun Equation & Pressure Drop Modeling)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Fluid_Flow_and_Particle_Mechanics / Fluidization_and_Packed_Beds`  
**Lesson Format Type:** `ergun_equation_and_packed_bed_pressure_drop`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through fluid flow through stationary porous granular media, packed bed void fraction / porosity ($\epsilon$), particle shape sphericity ($\Phi_s = \frac{6 / d_p}{S_p / v_p} \le 1.0$), effective particle diameter ($d_p$), superficial fluid approach velocity ($u_0 = Q / A_{\text{bed}}$), interstitial pore velocity ($u = u_0 / \epsilon$), particle Reynolds number ($Re_p = \frac{\rho_f u_0 d_p}{\mu (1 - \epsilon)}$), Sabri Ergun's 1952 universal friction factor derivation combining the **Laminar Blake-Kozeny Viscous Term** and the **Turbulent Burke-Plummer Kinetic Energy Loss Term**, and pressure drop scaling ($\Delta P / L$) (Warren L. McCabe, Julian C. Smith, Peter Harriott *Unit Operations of Chemical Engineering* 7th ed. Chapter 6; Octave Levenspiel *Fluidization Engineering* Chapter 3; Sabri Ergun 1952): formulate the **Ergun Equation Master Formulation**:
$$\mathbf{\frac{\Delta P}{L} = 150 \frac{(1 - \epsilon)^2}{\epsilon^3} \frac{\mu \cdot u_0}{\Phi_s^2 \cdot d_p^2} + 1.75 \frac{1 - \epsilon}{\epsilon^3} \frac{\rho_f \cdot u_0^2}{\Phi_s \cdot d_p} \quad \left[\frac{\text{Pa}}{\text{m}}\right]}$$
where:
1. **$\Delta P / L$:** Frictional pressure drop per unit length of packed bed ($\text{Pa/m}$);
2. **$\epsilon$:** Bed void fraction or porosity ($\epsilon = \frac{V_{\text{void}}}{V_{\text{total}}} \approx 0.35 - 0.50$);
3. **$\Phi_s$:** Particle sphericity ($\Phi_s = 1.0$ for ideal spheres, $\Phi_s \approx 0.6 - 0.85$ for crushed rock/catalyst pellets);
4. **$d_p$:** Nominal particle diameter ($\text{m}$);
5. **$u_0$:** Superficial approach velocity of fluid ($\text{m/s}$);
6. **$\mu, \rho_f$:** Dynamic viscosity ($\text{Pa}\cdot\text{s}$) and mass density ($\text{kg/m}^3$) of permeating fluid;
derive the **Two Asymptotic Flow Regimes**:
- **Laminar Flow Limit ($Re_p < 10$, Blake-Kozeny Equation):**
  $$\mathbf{\frac{\Delta P}{L} \approx 150 \frac{(1 - \epsilon)^2}{\epsilon^3} \frac{\mu \cdot u_0}{\Phi_s^2 \cdot d_p^2} \quad \left(\Delta P \propto u_0^1 \text{ and } \Delta P \propto \frac{1}{d_p^2}\right)}$$
- **Highly Turbulent Limit ($Re_p > 1000$, Burke-Plummer Equation):**
  $$\mathbf{\frac{\Delta P}{L} \approx 1.75 \frac{1 - \epsilon}{\epsilon^3} \frac{\rho_f \cdot u_0^2}{\Phi_s \cdot d_p} \quad \left(\Delta P \propto u_0^2 \text{ and } \Delta P \propto \frac{1}{d_p^1}\right)}$$
(proving that bed porosity enters both terms through the dramatic non-linear cubic denominator $\epsilon^3$, meaning that a small $10\%$ reduction in voidage nearly doubles the total pumping pressure drop).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ergun Equation ($\frac{\Delta P}{L} = 150\frac{(1-\epsilon)^2}{\epsilon^3}\frac{\mu u_0}{\Phi_s^2 d_p^2} + 1.75\frac{1-\epsilon}{\epsilon^3}\frac{\rho u_0^2}{\Phi_s d_p}$) & Asymptotes Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Pressure Drop Across a Fixed Catalytic Packed Bed Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Packed Bed Hydraulic Parameter / Flow Regime & Technical Fluid Dynamic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Ergun Equation, the Laminar Viscous Resistance Term Scales Inversely with the ___ of Particle Diameter ($d_p^2$) (Square / Second Power) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Chemical Engineering Problem: Computing Laminar and Turbulent Pressure Drop across a 2m Catalyst Column Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Ergun Equation Mechanics (Ergun 1952; McCabe, Smith, Harriott 2005):
   - **Pressure Drop Formulations:**
     $$\mathbf{\frac{\Delta P}{L} = 150 \frac{(1 - \epsilon)^2}{\epsilon^3} \frac{\mu u_0}{\Phi_s^2 d_p^2} + 1.75 \frac{1 - \epsilon}{\epsilon^3} \frac{\rho_f u_0^2}{\Phi_s d_p} \quad \Big| \quad Re_p = \frac{\rho_f u_0 d_p}{\mu (1 - \epsilon)} \quad \Big| \quad u_{\text{interstitial}} = \frac{u_0}{\epsilon}}$$
   - **Regimes Comparison Matrix:**
     $$\begin{array}{|l|c|l|l|}
     \hline
     \textbf{Flow Regime} & \textbf{Particle } Re_p & \textbf{Dominant Resistance Equation} & \textbf{Velocity Scaling} \\
     \hline
     \mathbf{\text{Laminar / Creeping}} & \mathbf{Re_p < 10} & \mathbf{\text{Blake-Kozeny Equation }} (150 \text{ term}) & \mathbf{\Delta P \propto u_0^1 \text{ and } \Delta P \propto d_p^{-2}} \\
     \mathbf{\text{Transition Zone}} & 10 \le Re_p \le 1000 & \text{Full Ergun Equation (Both terms significant)} & \Delta P = a u_0 + b u_0^2 \\
     \mathbf{\text{Highly Turbulent}} & \mathbf{Re_p > 1000} & \mathbf{\text{Burke-Plummer Equation }} (1.75 \text{ term}) & \mathbf{\Delta P \propto u_0^2 \text{ and } \Delta P \propto d_p^{-1}} \\
     \hline
     \end{array}$$
   - **The Porosity Cubic Invariant:** Bed voidage appears as **$\epsilon^3$ in the denominator** of both viscous and kinetic terms; compressing a packed bed from $\epsilon = 0.45$ to $\epsilon = 0.35$ increases pressure drop by more than **$260\%$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of packed bed pressure drop calculation: (1) extract superficial velocity $u_0 = Q / A_{\text{bed}}$, particle diameter $d_p$, sphericity $\Phi_s$, and bed porosity $\epsilon$, (2) extract fluid properties: dynamic viscosity $\mu$ and density $\rho_f$, (3) compute the laminar viscous Blake-Kozeny contribution: $(\Delta P / L)_{\text{visc}} = 150 \frac{(1-\epsilon)^2}{\epsilon^3} \frac{\mu u_0}{\Phi_s^2 d_p^2}$, (4) compute the turbulent inertial Burke-Plummer contribution: $(\Delta P / L)_{\text{inert}} = 1.75 \frac{1-\epsilon}{\epsilon^3} \frac{\rho_f u_0^2}{\Phi_s d_p}$, (5) sum both contributions and multiply by bed length $L$ to obtain total pressure drop $\Delta P = [(\Delta P/L)_{\text{visc}} + (\Delta P/L)_{\text{inert}}] \cdot L$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Ergun Equation, Blake-Kozeny Term, Burke-Plummer Term, Sphericity $\Phi_s$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Square (or Second Power). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Ergun pressure drop: A chemical reactor has a packed bed of spherical catalyst pellets ($\Phi_s = 1.0$) with $d_p = 2.0\text{ mm} = 0.0020\text{ m}$ ($d_p^2 = 4.0 \times 10^{-6}\text{ m}^2$), porosity $\epsilon = 0.40$ ($\epsilon^3 = 0.064$, $1 - \epsilon = 0.60$, $(1-\epsilon)^2 = 0.36$), and length $L = 2.0\text{ m}$. Liquid reactant flows at superficial velocity $u_0 = 0.050\text{ m/s}$ with $\rho_f = 1000.0\text{ kg/m}^3$ and $\mu = 0.0020\text{ Pa}\cdot\text{s} = 2.0 \times 10^{-3}\text{ kg/m}\cdot\text{s}$.
   - Viscous Blake-Kozeny term:
     $\frac{(1-\epsilon)^2}{\epsilon^3} = \frac{0.36}{0.064} = 5.625$;
     $(\Delta P/L)_{\text{visc}} = 150 \times 5.625 \times \frac{0.0020 \times 0.050}{4.0 \times 10^{-6}} = 843.75 \times \frac{0.00010}{4.0 \times 10^{-6}} = 843.75 \times 25.0 = \mathbf{21,093.75\text{ Pa/m}}$;
   - Inertial Burke-Plummer term:
     $\frac{1-\epsilon}{\epsilon^3} = \frac{0.60}{0.064} = 9.375$;
     $(\Delta P/L)_{\text{inert}} = 1.75 \times 9.375 \times \frac{1000.0 \times (0.050)^2}{0.0020} = 16.40625 \times \frac{1000.0 \times 0.0025}{0.0020} = 16.40625 \times 1250.0 = \mathbf{20,507.81\text{ Pa/m}}$;
   - Total pressure drop per meter: $\frac{\Delta P}{L} = 21,093.75 + 20,507.81 = \mathbf{41,601.56\text{ Pa/m}}$;
   - Total pressure drop across $L = 2.0\text{ m}$: $\Delta P = 41,601.56 \times 2.0 = \mathbf{83,203.12\text{ Pa} \approx 83.2\text{ kPa}}$;
   - What is the total pressure drop $\Delta P$ across the 2-meter bed? ($\Delta P = \mathbf{83.2\text{ kPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ergun_equation_and_packed_bed_pressure_drop",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Packed Bed Hydraulics \\& Ergun Equation (Sabri Ergun 1952)**\n• **Sabri Ergun Universal Pressure Drop Master Formulation:**\n$$\n\\mathbf{\\frac{\\Delta P}{L} = \\underbrace{150 \\frac{(1 - \\epsilon)^2}{\\epsilon^3} \\frac{\\mu \\cdot u_0}{\\Phi_s^2 \\cdot d_p^2}}_{\\text{Viscous (Blake-Kozeny)}} + \\underbrace{1.75 \\frac{1 - \\epsilon}{\\epsilon^3} \\frac{\\rho_f \\cdot u_0^2}{\\Phi_s \\cdot d_p}}_{\\text{Inertial (Burke-Plummer)}} \\quad \\left[\\frac{\\text{Pa}}{\\text{m}}\\right]}\n$$\n  - **$\\Delta P / L$:** Bed frictional pressure drop per unit height ($\\text{Pa/m}$);\n  - **$\\epsilon$:** Bed void fraction or porosity ($\\approx 0.35 - 0.45$);\n  - **$\\Phi_s$:** Particle sphericity factor ($\\le 1.0$);\n  - **$d_p$:** Characteristic particle diameter ($\\text{m}$);\n  - **$u_0$:** Superficial approach velocity ($\\text{m/s}$);\n  - **$\\mu, \\rho_f$:** Dynamic viscosity and density of flowing fluid;\n• **Particle Reynolds Number:** $\\mathbf{Re_p = \\frac{\\rho_f \\cdot u_0 \\cdot d_p}{\\mu (1 - \\epsilon)}}$\n• **The Porosity Cubic Invariant:** Bed voidage appears as **$\\epsilon^3$ in the denominator** of both viscous and turbulent terms; compressing a bed from $\\epsilon = 0.45$ to $\\epsilon = 0.35$ increases pumping pressure drop by over **$260\\%$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the total pressure drop across a fixed packed catalytic reactor bed.",
      "orderItems": [
        "Determine the superficial fluid approach velocity u0 = Q / A_bed, particle diameter dp, sphericity \u03a6s, and bed porosity \u03b5",
        "Extract the fluid physical properties: dynamic viscosity \u03bc and mass density \u03c1f at operating conditions",
        "Calculate the laminar viscous Blake-Kozeny contribution: (\u0394P/L)_visc = 150 * [ (1-\u03b5)^2 / \u03b5^3 ] * [ \u03bc*u0 / (\u03a6s^2 * dp^2) ]",
        "Calculate the turbulent inertial Burke-Plummer contribution: (\u0394P/L)_inert = 1.75 * [ (1-\u03b5) / \u03b5^3 ] * [ \u03c1f*u0^2 / (\u03a6s * dp) ]",
        "Sum both contributions and multiply by total bed length L to obtain overall reactor pressure drop: \u0394P = [ (\u0394P/L)_visc + (\u0394P/L)_inert ] * L"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Packed Bed Hydraulic Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Ergun Equation", "right": "Universal model combining viscous drag and kinetic eddy dissipation to predict pressure loss across porous media" },
        { "left": "Blake-Kozeny Term", "right": "Laminar regime term (150...) scaling linearly with fluid velocity and inversely with the square of diameter (dp^2)" },
        { "left": "Burke-Plummer Term", "right": "Turbulent regime term (1.75...) scaling quadratically with velocity (u0^2) and inversely with diameter (dp)" },
        { "left": "Particle Sphericity (\u03a6s)", "right": "Ratio of the surface area of an equivalent-volume sphere to the actual surface area of the particle" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Ergun equation, the laminar viscous resistance term scales inversely with the ___ of particle diameter.",
      "blankAnswer": "square",
      "blankDistractors": ["cube", "square root", "exponential"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2.0 m packed bed of spheres (\u03a6s = 1.0, dp = 2.0 mm, \u03b5 = 0.40 \u2192 \u03b5^3 = 0.064) has liquid flow at u0 = 0.050 m/s (\u03c1f = 1000 kg/m^3, \u03bc = 0.0020 Pa*s). Viscous term is (\u0394P/L)_visc = 21.09 kPa/m. Inertial term is (\u0394P/L)_inert = 20.51 kPa/m (\u0394P/L = 41.60 kPa/m). What is the total pressure drop \u0394P across the 2.0 m bed?",
      "options": [
        { "text": "\u0394P = 83.2 kPa (\u0394P = [21.094 + 20.508 kPa/m] * 2.0 m = 41.602 kPa/m * 2.0 m = 83.204 kPa \u2248 83.2 kPa)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Sabri Ergun packed bed pressure drop equation (Warren L. McCabe *Unit Operations of Chemical Engineering* Chapter 6). 1. **Identify Bed \\& Fluid Properties:** - Bed length: $L = 2.0\\text{ m}$. - Sphericity: $\\Phi_s = 1.00$. - Particle diameter: $d_p = 2.0\\text{ mm} = 0.0020\\text{ m} \\implies d_p^2 = \\mathbf{4.0 \\times 10^{-6}\\text{ m}^2}$. - Bed porosity: $\\epsilon = 0.40 \\implies \\epsilon^3 = (0.40)^3 = \\mathbf{0.064}$. - Solid fraction: $1 - \\epsilon = 1 - 0.40 = 0.60 \\implies (1 - \\epsilon)^2 = \\mathbf{0.36}$. - Superficial velocity: $u_0 = 0.050\\text{ m/s} \\implies u_0^2 = \\mathbf{0.0025\\text{ m}^2\\text{/s}^2}$. - Fluid properties: $\\rho_f = 1000.0\\text{ kg/m}^3, \\quad \\mu = 0.0020\\text{ Pa}\\cdot\\text{s}$. 2. **Calculate Laminar Viscous Pressure Gradient ($(\\Delta P/L)_{\\text{visc}}$):** - Porosity factor: $$\\frac{(1 - \\epsilon)^2}{\\epsilon^3} = \\frac{0.36}{0.064} = \\mathbf{5.625}$$ - Viscous term: $$\left(\\frac{\\Delta P}{L}\\right)_{\\text{visc}} = 150 \\times 5.625 \\times \\frac{(0.0020\\text{ Pa}\\cdot\\text{s}) \\times (0.050\\text{ m/s})}{(1.0)^2 \\times (4.0 \\times 10^{-6}\\text{ m}^2)}$$ $$\left(\\frac{\\Delta P}{L}\\right)_{\\text{visc}} = 843.75 \\times \\frac{0.00010}{4.0 \\times 10^{-6}} = 843.75 \\times 25.0 = \\mathbf{21,093.75\\text{ Pa/m} = 21.094\\text{ kPa/m}}$$ 3. **Calculate Turbulent Inertial Pressure Gradient ($(\\Delta P/L)_{\\text{inert}}$):** - Porosity factor: $$\\frac{1 - \\epsilon}{\\epsilon^3} = \\frac{0.60}{0.064} = \\mathbf{9.375}$$ - Inertial term: $$\left(\\frac{\\Delta P}{L}\\right)_{\\text{inert}} = 1.75 \\times 9.375 \\times \\frac{(1000.0\\text{ kg/m}^3) \\times (0.0025\\text{ m}^2\\text{/s}^2)}{(1.0) \\times (0.0020\\text{ m})}$$ $$\left(\\frac{\\Delta P}{L}\\right)_{\\text{inert}} = 16.40625 \\times 1250.0 = \\mathbf{20,507.81\\text{ Pa/m} = 20.508\\text{ kPa/m}}$$ 4. **Calculate Total Bed Pressure Drop ($\\Delta P$):** - Total gradient: $$\\frac{\\Delta P}{L} = 21,093.75 + 20,507.81 = \\mathbf{41,601.56\\text{ Pa/m} = 41.602\\text{ kPa/m}}$$ - Total pressure drop across $L = 2.0\\text{ m}$: $$\\Delta P = 41,601.56\\text{ Pa/m} \\times 2.0\\text{ m} = \\mathbf{83,203.12\\text{ Pa} = 83.203\\text{ kPa} \\approx 83.2\\text{ kPa}}$$ Flawless Ergun equation packed bed pressure drop derivation!" },
        { "text": "\u0394P = 41.6 kPa (Forgot to multiply by bed length L = 2.0 m)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394P = 21.1 kPa (Only calculated the viscous term)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394P = 166.4 kPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
