# Duofy Reusable Lesson Format: Incipient Fluidization (Umf Velocity & Buoyant Weight)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Fluid_Flow_and_Particle_Mechanics / Fluidization_and_Packed_Beds`  
**Lesson Format Type:** `minimum_fluidization_velocity_and_bed_buoyant_weight`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the physical transition from a stationary packed bed to an incipiently **Fluidized Bed**, the fundamental force balance where upward hydrodynamic fluid drag exactly equals the net buoyant submerged weight of the particulate bed, the **Pressure Drop Invariant Plateau ($\Delta P_{\text{fluidized}} = \text{const}$)**, bed voidage at incipient fluidization ($\epsilon_{\text{mf}} \approx 0.40 - 0.45$), bed height at minimum fluidization ($L_{\text{mf}}$), the dimensionless **Archimedes Number ($Ar$)**, and analytical calculation of the **Minimum Fluidization Velocity ($u_{\text{mf}}$ or $U_{\text{mf}}$)** for both fine laminar particles and large turbulent grains (Warren L. McCabe *Unit Operations of Chemical Engineering* 7th ed. Chapter 7; Daizo Kunii, Octave Levenspiel *Fluidization Engineering* Chapter 3): formulate the **Fluidized Bed Buoyant Weight Balance Master Invariant**:
$$\mathbf{\Delta P_{\text{fluidized}} \cdot A = \text{Net Buoyant Weight of Bed} = V_{\text{bed}} (1 - \epsilon_{\text{mf}}) (\rho_p - \rho_f) g}$$
$$\mathbf{\frac{\Delta P_{\text{fluidized}}}{L_{\text{mf}}} = (1 - \epsilon_{\text{mf}}) \left( \rho_p - \rho_f \right) g \Longleftrightarrow \mathbf{\Delta P_{\text{fluidized}} = \frac{m_{\text{bed}} g}{A} \left( 1 - \frac{\rho_f}{\rho_p} \right)}}$$
where:
1. **$\Delta P_{\text{fluidized}}$:** Total bed pressure drop in Pascals ($\text{Pa}$), which remains **strictly constant** for all velocities $u_{\text{mf}} \le u_0 \le u_t$;
2. **$\rho_p, \rho_f$:** Particle and fluid densities ($\text{kg/m}^3$);
3. **$\epsilon_{\text{mf}}$:** Bed porosity at minimum fluidization;
4. **$L_{\text{mf}}$:** Bed height at minimum fluidization;
equating Ergun pressure drop to buoyant weight yields the **Dimensionless $u_{\text{mf}}$ Quadratic Formulation**:
$$\mathbf{1.75 \frac{Re_{p,\text{mf}}^2}{\Phi_s \epsilon_{\text{mf}}^3} + 150 \frac{1 - \epsilon_{\text{mf}}}{\Phi_s^2 \epsilon_{\text{mf}}^3} Re_{p,\text{mf}} = Ar \quad \left(Ar = \frac{d_p^3 \rho_f (\rho_p - \rho_f) g}{\mu^2}\right)}$$
for small laminar particles ($Re_{p,\text{mf}} < 20$):
$$\mathbf{u_{\text{mf}} = \frac{d_p^2 \left( \rho_p - \rho_f \right) g}{150 \mu} \left( \frac{\Phi_s^2 \epsilon_{\text{mf}}^3}{1 - \epsilon_{\text{mf}}} \right)}$$
(proving that beyond $u_{\text{mf}}$, increasing gas velocity does not increase pressure drop; instead, the bed expands upward to let gas pass smoothly around suspended grains).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Buoyant Force Balance ($\Delta P = (1-\epsilon_{\text{mf}})(\rho_p-\rho_f)g L_{\text{mf}}$) & Laminar $u_{\text{mf}} = \frac{d_p^2(\rho_p-\rho_f)g}{150\mu}\frac{\Phi_s^2\epsilon_{\text{mf}}^3}{1-\epsilon_{\text{mf}}}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Incipient Fluidization Pressure Drop and Umf Velocity Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Fluidization State / Force Balance Parameter & Technical Mechanical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Once a Granular Bed Transitions into the Fully Fluidized Regime ($u_0 > u_{\text{mf}}$), the Total Frictional Pressure Drop Across the Bed Remains Strictly ___ (Constant / Invariant / Unchanged) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Fluidization Reactor Problem: Computing Fluidized Delta P and Umf for a Sand Fluidized Bed Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Incipient Fluidization Mechanics (Kunii & Levenspiel 1991; McCabe 2005):
   - **Fluidization Formulations:**
     $$\mathbf{\Delta P_{\text{fluid}} = (1 - \epsilon_{\text{mf}})(\rho_p - \rho_f)g L_{\text{mf}} \quad \Big| \quad u_{\text{mf}} = \frac{d_p^2(\rho_p - \rho_f)g}{150\mu}\left(\frac{\Phi_s^2\epsilon_{\text{mf}}^3}{1 - \epsilon_{\text{mf}}}\right) \quad \Big| \quad Ar = \frac{d_p^3 \rho_f(\rho_p-\rho_f)g}{\mu^2}}$$
   - **Bed Operational Regimes Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Superficial Velocity } u_0 & \textbf{Hydrodynamic State} & \textbf{Pressure Drop Behavior } \Delta P \\
     \hline
     \mathbf{u_0 < u_{\text{mf}}} & \mathbf{\text{Fixed Packed Bed}} & \mathbf{\Delta P \text{ increases with velocity }} (\Delta P \propto u_0 + u_0^2) \\
     \mathbf{u_0 = u_{\text{mf}}} & \mathbf{\text{Incipient Fluidization}} & \mathbf{\text{Peak maximum }} \Delta P \text{ equals buoyant bed weight} \\
     \mathbf{u_{\text{mf}} < u_0 < u_t} & \mathbf{\text{Particulate / Bubbling Fluidized Bed}} & \mathbf{\Delta P = \text{Constant Plateau (Velocity-independent)}} \\
     u_0 > u_t & \text{Pneumatic Transport (Elutriation)} & \text{Particles blown out of column} \\
     \hline
     \end{array}$$
   - **The Plateau Invariant:** In a fluidized bed, **pressure drop $\Delta P$ is completely independent of superficial velocity $u_0$**; additional gas flow merely pushes particles further apart, increasing void fraction $\epsilon$ and expanding bed height $L$!
2. **Slide 2 (`ordering`):** Provide 5 steps of $u_{\text{mf}}$ calculation: (1) determine particle diameter $d_p$, density $\rho_p$, sphericity $\Phi_s$, and bed mass $m_{\text{bed}}$, (2) calculate fluidized bed pressure drop from buoyant weight: $\Delta P = (1 - \epsilon_{\text{mf}})(\rho_p - \rho_f)g L_{\text{mf}}$, (3) compute the dimensionless Archimedes number: $Ar = \frac{d_p^3 \rho_f (\rho_p - \rho_f) g}{\mu^2}$, (4) verify laminar regime ($Ar < 10^3 \implies Re_{p,\text{mf}} < 20$), (5) calculate minimum fluidization velocity: $u_{\text{mf}} = \frac{d_p^2 (\rho_p - \rho_f) g}{150 \mu} \left(\frac{\Phi_s^2 \epsilon_{\text{mf}}^3}{1 - \epsilon_{\text{mf}}}\right)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Minimum Fluidization Velocity $u_{\text{mf}}$, Buoyant Bed Weight $\Delta P$, Archimedes Number $Ar$, Terminal Velocity $u_t$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Constant (or Invariant / Unchanged). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating fluidized $\Delta P$ and $u_{\text{mf}}$: A fluidized bed reactor with cross-sectional area $A = 0.50\text{ m}^2$ contains silica sand particles ($\Phi_s = 1.0, d_p = 0.20\text{ mm} = 2.0 \times 10^{-4}\text{ m} \implies d_p^2 = 4.0 \times 10^{-8}\text{ m}^2$, $\rho_p = 2500.0\text{ kg/m}^3$) fluidized by ambient air ($\rho_f = 1.20\text{ kg/m}^3 \approx 0, \mu = 1.80 \times 10^{-5}\text{ Pa}\cdot\text{s}$). At minimum fluidization, bed height is $L_{\text{mf}} = 1.0\text{ m}$ and porosity is $\epsilon_{\text{mf}} = 0.45$ ($\epsilon_{\text{mf}}^3 = (0.45)^3 = 0.091125$, $1 - \epsilon_{\text{mf}} = 0.55$).
   - Buoyant density difference: $\rho_p - \rho_f = 2500.0 - 1.2 \approx \mathbf{2498.8\text{ kg/m}^3 \approx 2500\text{ kg/m}^3}$;
   - Fluidized bed pressure drop:
     $\Delta P = (1 - \epsilon_{\text{mf}}) (\rho_p - \rho_f) g L_{\text{mf}} = 0.55 \times 2500.0 \times 9.81 \times 1.0 = 1375.0 \times 9.81 = \mathbf{13,488.75\text{ Pa} = 13.49\text{ kPa}}$;
   - Porosity ratio: $\frac{\epsilon_{\text{mf}}^3}{1 - \epsilon_{\text{mf}}} = \frac{0.091125}{0.55} = \mathbf{0.165682}$;
   - Minimum fluidization velocity $u_{\text{mf}}$:
     $u_{\text{mf}} = \frac{d_p^2 (\rho_p - \rho_f) g}{150 \mu} \times 0.165682 = \frac{(4.0 \times 10^{-8}) \times 2500.0 \times 9.81}{150 \times (1.80 \times 10^{-5})} \times 0.165682 = \frac{9.81 \times 10^{-4}}{0.00270} \times 0.165682 = 0.36333 \times 0.165682 = \mathbf{0.0602\text{ m/s} = 6.02\text{ cm/s}}$;
   - What is the fluidized pressure drop $\Delta P$ and the minimum fluidization velocity $u_{\text{mf}}$? ($\Delta P = \mathbf{13.5\text{ kPa}}$ and $u_{\text{mf}} = \mathbf{0.060\text{ m/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "minimum_fluidization_velocity_and_bed_buoyant_weight",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Incipient Fluidization \\& Force Balances (Kunii \\& Levenspiel)**\n• **Fluidized Bed Buoyant Weight Balance Master Formulation:**\n$$\n\\mathbf{\\Delta P_{\\text{fluidized}} = (1 - \\epsilon_{\\text{mf}}) \\left( \\rho_p - \\rho_f \\right) g \\cdot L_{\\text{mf}} = \\frac{m_{\\text{bed}} g}{A} \\left( 1 - \\frac{\\rho_f}{\\rho_p} \\right) \\quad [\\text{Pa}]}\n$$\n  - **$\\Delta P_{\\text{fluidized}}$:** Total bed pressure drop, remaining **constant** across the entire fluidized regime ($u_{\\text{mf}} \\le u_0 \\le u_t$);\n  - **$\\epsilon_{\\text{mf}}$:** Bed voidage at incipient fluidization ($\\approx 0.40 - 0.45$);\n  - **$L_{\\text{mf}}$:** Bed height at minimum fluidization ($\\text{m}$);\n• **Laminar Minimum Fluidization Velocity ($u_{\\text{mf}}$ for $Re_{p,\\text{mf}} < 20$):**\n$$\n\\mathbf{u_{\\text{mf}} = \\frac{d_p^2 \\left( \\rho_p - \\rho_f \\right) g}{150 \\mu} \\left( \\frac{\\Phi_s^2 \\epsilon_{\\text{mf}}^3}{1 - \\epsilon_{\\text{mf}}} \\right) \\quad [\\text{m/s}]}\n$$\n• **The Pressure Plateau Invariant:** In a fully fluidized bed, **pressure drop is completely independent of superficial velocity**; increasing gas flow simply lifts particles higher, expanding voidage $\\epsilon$ while total frictional resistance equals buoyant bed weight!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the incipient fluidization pressure drop and minimum fluidization velocity of a powder bed.",
      "orderItems": [
        "Extract particle diameter dp, solid density \u03c1p, sphericity \u03a6s, and bed total mass m_bed (or height L_mf)",
        "Determine the bed porosity at incipient fluidization \u03b5_mf (\u2248 0.45) and fluid viscosity \u03bc and density \u03c1f",
        "Calculate the constant fluidized bed pressure drop: \u0394P = (1 - \u03b5_mf) * (\u03c1p - \u03c1f) * g * L_mf",
        "Compute the dimensionless Archimedes number Ar = [ dp^3 * \u03c1f * (\u03c1p - \u03c1f) * g ] / \u03bc^2 to confirm laminar flow regime",
        "Calculate the minimum fluidization velocity: u_mf = [ dp^2 * (\u03c1p - \u03c1f) * g / (150*\u03bc) ] * [ \u03a6s^2 * \u03b5_mf^3 / (1 - \u03b5_mf) ]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fluidization Force Balance Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Minimum Fluidization (u_mf)", "right": "Superficial fluid velocity where upward hydrodynamic drag exactly balances net buoyant particle weight" },
        { "left": "Pressure Plateau (\u0394P_fluid)", "right": "\u0394P = (1-\u03b5_mf)*(\u03c1p-\u03c1f)*g*L_mf, velocity-independent constant pressure drop across the entire fluidized regime" },
        { "left": "Archimedes Number (Ar)", "right": "Dimensionless ratio comparing buoyant gravitational forces to viscous hydrodynamic forces" },
        { "left": "Terminal Velocity (ut)", "right": "Upper velocity limit where fluid drag exceeds particle weight, causing pneumatic elutriation from bed" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Once a granular bed transitions into the fully fluidized regime (u0 > u_mf), the total frictional pressure drop across the bed remains strictly ___.",
      "blankAnswer": "constant",
      "blankDistractors": ["linear", "zero", "exponential"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A bed of sand spheres (\u03a6s = 1.0, dp = 0.20 mm, \u03c1p = 2500 kg/m^3) is fluidized by air (\u03c1f \u2248 0, \u03bc = 1.80 \u00d7 10^-5 Pa*s). At minimum fluidization, L_mf = 1.0 m and \u03b5_mf = 0.45 (\u03b5_mf^3 / (1 - \u03b5_mf) = 0.091125 / 0.55 = 0.1657). What is the fluidized pressure drop \u0394P and the minimum fluidization velocity u_mf?",
      "options": [
        { "text": "\u0394P = 13.5 kPa and u_mf = 0.060 m/s (\u0394P = 0.55 * 2500 * 9.81 * 1.0 = 13,489 Pa = 13.49 kPa; u_mf = [(2 \u00d7 10^-4)^2 * 2500 * 9.81 / (150 * 1.8 \u00d7 10^-5)] * 0.16568 = [9.81 \u00d7 10^-4 / 0.00270] * 0.16568 = 0.3633 * 0.16568 = 0.0602 m/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the incipient fluidization force balance and laminar $u_{\\text{mf}}$ formula (Warren L. McCabe *Unit Operations of Chemical Engineering* Chapter 7; Kunii & Levenspiel *Fluidization Engineering* Chapter 3). 1. **Calculate Fluidized Bed Pressure Drop ($\\Delta P_{\\text{fluidized}}$):** - Given parameters: $L_{\\text{mf}} = 1.0\\text{ m}, \\quad \\epsilon_{\\text{mf}} = 0.45 \\implies 1 - \\epsilon_{\\text{mf}} = \\mathbf{0.55}$. - Particle density: $\\rho_p = 2500.0\\text{ kg/m}^3$ (neglecting gas density $\\rho_f \\ll \\rho_p$). - Gravitational acceleration: $g = 9.81\\text{ m/s}^2$. $$\\Delta P_{\\text{fluidized}} = (1 - \\epsilon_{\\text{mf}}) \\cdot \\rho_p \\cdot g \\cdot L_{\\text{mf}}$$ $$\\Delta P_{\\text{fluidized}} = 0.55 \\times 2500.0\\text{ kg/m}^3 \\times 9.81\\text{ m/s}^2 \\times 1.0\\text{ m} = \\mathbf{13,488.75\\text{ Pa} = 13.489\\text{ kPa} \\approx 13.5\\text{ kPa}}$$ 2. **Calculate Minimum Fluidization Velocity ($u_{\\text{mf}}$):** - Particle diameter: $d_p = 0.20\\text{ mm} = 2.0 \\times 10^{-4}\\text{ m} \\implies d_p^2 = \\mathbf{4.0 \\times 10^{-8}\\text{ m}^2}$. - Gas dynamic viscosity: $\\mu = 1.80 \\times 10^{-5}\\text{ Pa}\\cdot\\text{s}$. - Porosity factor: $$\\frac{\\epsilon_{\\text{mf}}^3}{1 - \\epsilon_{\\text{mf}}} = \\frac{(0.45)^3}{1 - 0.45} = \\frac{0.091125}{0.55} = \\mathbf{0.1656818}$$ - Small particle laminar $u_{\\text{mf}}$ relation: $$u_{\\text{mf}} = \\frac{d_p^2 \\cdot \\rho_p \\cdot g}{150 \\cdot \\mu} \\left( \\frac{\\Phi_s^2 \\epsilon_{\\text{mf}}^3}{1 - \\epsilon_{\\text{mf}}} \\right)$$ $$u_{\\text{mf}} = \\frac{(4.0 \\times 10^{-8}\\text{ m}^2) \\times (2500.0\\text{ kg/m}^3) \\times 9.81\\text{ m/s}^2}{150 \\times (1.80 \\times 10^{-5}\\text{ Pa}\\cdot\\text{s})} \\times (1.0)^2 \\times 0.1656818$$ $$u_{\\text{mf}} = \\left( \\frac{9.81 \\times 10^{-4}}{0.00270} \\right) \\times 0.1656818 = 0.363333\\text{ m/s} \\times 0.1656818 = \\mathbf{0.06020\\text{ m/s} \\approx 0.060\\text{ m/s} = 6.02\\text{ cm/s}}$$ Flawless fluidized bed pressure drop and minimum fluidization velocity derivation!" },
        { "text": "\u0394P = 24.5 kPa and u_mf = 0.120 m/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394P = 13.5 kPa and u_mf = 0.363 m/s (Forgot porosity factor)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394P = 6.7 kPa and u_mf = 0.030 m/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
