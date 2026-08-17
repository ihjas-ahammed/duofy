# Duofy Reusable Lesson Format: Orbital Dynamics (Vis-Viva Equation & Specific Energy)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Avionics_and_Spacecraft_Dynamics / Orbital_Mechanics_and_Keplerian_Orbits`  
**Lesson Format Type:** `vis_viva_equation_and_orbital_energy_conservation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the two-body gravitational problem, the standard gravitational parameter ($\mu = GM = 398,600.44\text{ km}^3\text{/s}^2$ for Earth), specific kinetic energy ($\frac{1}{2}v^2$), specific gravitational potential energy ($-\frac{\mu}{r}$), total **Specific Mechanical Energy ($\mathcal{E} = -\frac{\mu}{2a}$)**, the fundamental **Vis-Viva Equation** relating instantaneous speed ($v$) to orbital position radius ($r$) and semi-major axis ($a$), perigee and apogee velocities ($v_p, v_a$), and circular velocity ($v_{\text{circ}} = \sqrt{\mu/r}$) (Howard D. Curtis *Orbital Mechanics for Engineering Students* 4th ed. Chapter 2; Roger R. Bate *Fundamentals of Astrodynamics* Chapter 1): formulate the **Vis-Viva Orbital Velocity Master Formulation**:
$$\mathbf{v^2 = \mu \left( \frac{2}{r} - \frac{1}{a} \right) \Longleftrightarrow \mathbf{v(r) = \sqrt{\mu \left( \frac{2}{r} - \frac{1}{a} \right)} \quad \left[\frac{\text{km}}{\text{s}}\right]}}$$
where:
1. **$v$:** Instantaneous orbital velocity ($\text{km/s}$);
2. **$\mu = G M$:** Standard gravitational parameter of the primary body ($\text{km}^3\text{/s}^2$);
3. **$r$:** Instantaneous radial distance from the center of the primary body ($\text{km}$);
4. **$a$:** Semi-major axis of the Keplerian orbit ($\text{km}$);
formulate the **Specific Mechanical Energy Invariant ($\mathcal{E}$)**:
$$\mathbf{\mathcal{E} = \frac{v^2}{2} - \frac{\mu}{r} = -\frac{\mu}{2a} \quad \left[\frac{\text{km}^2}{\text{s}^2}\right] = \text{Constant along entire orbit}}$$
derive the **Perigee and Apogee Velocities for an Elliptical Orbit ($0 < e < 1$)**:
$$\mathbf{v_p = \sqrt{\frac{\mu}{a} \left( \frac{1 + e}{1 - e} \right)} = \sqrt{\frac{\mu (2 a - r_p)}{a \cdot r_p}} \quad \Big| \quad \mathbf{v_a = \sqrt{\frac{\mu}{a} \left( \frac{1 - e}{1 + e} \right)} = \sqrt{\frac{\mu (2 a - r_a)}{a \cdot r_a}}}}$$
(proving that the semi-major axis $a$ is the unique geometric signature of an orbit's total energy; any two orbits around the same planet with the same $a$ have identical total specific orbital energy regardless of eccentricity $e$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Vis-Viva Equation ($v^2 = \mu(\frac{2}{r} - \frac{1}{a})$), Specific Energy ($\mathcal{E} = -\frac{\mu}{2a}$) & Perigee/Apogee Speeds Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Specific Energy, Perigee Speed, and Apogee Speed of an Elliptic Orbit Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Orbital Velocity Parameter / Conic State & Technical Astrodynamic Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Total Specific Mechanical Energy $\mathcal{E}$ of Any Closed Keplerian Elliptical Orbit Around a Central Planet Depends Exclusively on the Orbit's Semi-___ Axis $a$ (Major / Semi-major) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Space Mission Problem: Computing Velocity at Perigee and Apogee for a Highly Elliptical Earth Satellite Orbit Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Vis-Viva & Orbital Energy Mechanics (Curtis 2020; Bate, Mueller, White 1971):
   - **Energy Formulations:**
     $$\mathbf{v^2 = \mu\left(\frac{2}{r} - \frac{1}{a}\right) \quad \Big| \quad \mathcal{E} = \frac{v^2}{2} - \frac{\mu}{r} = -\frac{\mu}{2a} \quad \Big| \quad v_{\text{circ}} = \sqrt{\frac{\mu}{r}} \quad \Big| \quad r_p = a(1-e), \ r_a = a(1+e)}$$
   - **Conic Energy Comparison Matrix ($\mu = 398,600\text{ km}^3\text{/s}^2$):**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Conic Orbit Trajectory} & \textbf{Eccentricity } e & \textbf{Semi-Major Axis } a & \textbf{Specific Energy } \mathcal{E} & \textbf{Velocity at Radius } r \\
     \hline
     \mathbf{\text{Circular Orbit}} & \mathbf{e = 0.0} & \mathbf{a = r} & \mathbf{\mathcal{E} = -\frac{\mu}{2r} < 0} & \mathbf{v = \sqrt{\frac{\mu}{r}}} \\
     \mathbf{\text{Elliptical Orbit}} & \mathbf{0 < e < 1.0} & \mathbf{a > 0} & \mathbf{\mathcal{E} = -\frac{\mu}{2a} < 0} & \mathbf{v = \sqrt{\mu\left(\frac{2}{r} - \frac{1}{a}\right)}} \\
     \mathbf{\text{Parabolic Escape}} & \mathbf{e = 1.0} & \mathbf{a \to \infty} & \mathbf{\mathcal{E} = 0.0} & \mathbf{v_{\text{esc}} = \sqrt{\frac{2\mu}{r}} = \sqrt{2} v_{\text{circ}}} \\
     \text{Hyperbolic Flyby} & e > 1.0 & a < 0 & \mathcal{E} > 0 & v = \sqrt{\mu\left(\frac{2}{r} + \frac{1}{|a|}\right)} \\
     \hline
     \end{array}$$
   - **The Specific Energy Invariant:** Total specific mechanical energy is **conserved at every second along the trajectory ($\mathcal{E} = \text{constant}$)**; kinetic energy surges at perigee as gravitational potential energy reaches its deepest negative minimum!
2. **Slide 2 (`ordering`):** Provide 5 steps of orbital velocity calculation: (1) determine primary gravitational parameter $\mu$ (e.g. $398,600\text{ km}^3\text{/s}^2$ for Earth), (2) calculate perigee radius $r_p = R_E + h_p$ and apogee radius $r_a = R_E + h_a$, (3) compute semi-major axis: $a = (r_p + r_a) / 2$, (4) compute specific mechanical energy: $\mathcal{E} = -\mu / (2a)$, (5) evaluate instantaneous velocity at any radius $r$ using Vis-Viva: $v = \sqrt{\mu(2/r - 1/a)}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Vis-Viva Equation, Specific Energy $\mathcal{E} = -\frac{\mu}{2a}$, Perigee Radius $r_p = a(1-e)$, Circular Speed $v_{\text{circ}} = \sqrt{\frac{\mu}{r}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Major (or Semi-major). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating perigee and apogee velocities: An Earth satellite ($\mu = 398,600.0\text{ km}^3\text{/s}^2$, $R_E = 6378.0\text{ km}$) is in an elliptical orbit with perigee altitude $h_p = 622.0\text{ km}$ ($r_p = 6378.0 + 622.0 = \mathbf{7000.0\text{ km}}$) and apogee altitude $h_a = 21,622.0\text{ km}$ ($r_a = 6378.0 + 21,622.0 = \mathbf{28,000.0\text{ km}}$).
   - Semi-major axis: $a = \frac{r_p + r_a}{2} = \frac{7000.0 + 28,000.0}{2} = \frac{35,000.0}{2} = \mathbf{17,500.0\text{ km}}$;
   - Perigee velocity:
     $v_p = \sqrt{\mu \left( \frac{2}{r_p} - \frac{1}{a} \right)} = \sqrt{398,600 \left( \frac{2}{7000} - \frac{1}{17,500} \right)} = \sqrt{398,600 \left( \frac{10 - 2}{35,000} \right)} = \sqrt{398,600 \left( \frac{8}{35,000} \right)} = \sqrt{\frac{3,188,800}{35,000}} = \sqrt{91.10857} = \mathbf{9.545\text{ km/s} \approx 9.55\text{ km/s}}$;
   - Apogee velocity:
     $v_a = \sqrt{\mu \left( \frac{2}{r_a} - \frac{1}{a} \right)} = \sqrt{398,600 \left( \frac{2}{28,000} - \frac{1}{17,500} \right)} = \sqrt{398,600 \left( \frac{5 - 4}{70,000} \right)} = \sqrt{398,600 \left( \frac{1}{70,000} \right)} = \sqrt{5.69428} = \mathbf{2.386\text{ km/s} \approx 2.39\text{ km/s}}$;
   - What are the orbital velocities at perigee $v_p$ and at apogee $v_a$? ($v_p = \mathbf{9.55\text{ km/s}}$ and $v_a = \mathbf{2.39\text{ km/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "vis_viva_equation_and_orbital_energy_conservation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Vis-Viva Equation \\& Orbital Energy Conservation (Howard D. Curtis)**\n• **Vis-Viva Orbital Velocity Master Formulation:**\n$$\n\\mathbf{v^2 = \\mu \\left( \\frac{2}{r} - \\frac{1}{a} \\right) \\Longleftrightarrow v(r) = \\sqrt{\\mu \\left( \\frac{2}{r} - \\frac{1}{a} \\right)} \\quad \\left[\\frac{\\text{km}}{\\text{s}}\\right]}\n$$\n  - **$v$:** Instantaneous spacecraft speed ($\\text{km/s}$);\n  - **$\\mu = GM$:** Primary body gravitational parameter ($398,600\\text{ km}^3\\text{/s}^2$ for Earth);\n  - **$r$:** Radial distance from planetary center ($\\text{km}$);\n  - **$a$:** Orbit semi-major axis ($\\text{km}$);\n• **Specific Mechanical Energy Formulation ($\\mathcal{E}$):**\n$$\n\\mathbf{\\mathcal{E} = \\frac{v^2}{2} - \\frac{\\mu}{r} = -\\frac{\\mu}{2a} \\quad \\left[\\frac{\\text{km}^2}{\\text{s}^2}\\right]}\n$$\n• **Perigee \\& Apogee Velocity Formulas ($0 < e < 1$):**\n$$\n\\mathbf{v_p = \\sqrt{\\frac{\\mu}{a} \\left( \\frac{1 + e}{1 - e} \\right)}} \\quad \\Big| \\quad \\mathbf{v_a = \\sqrt{\\frac{\\mu}{a} \\left( \\frac{1 - e}{1 + e} \\right)}}\n$$\n• **The Energy Signature Invariant:** The semi-major axis $a$ is an immutable measure of an orbit's total specific energy; **all orbits around Earth with the same $a$ possess identical specific energy $\\mathcal{E}$**, irrespective of their eccentricity $e$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the specific mechanical energy, perigee velocity, and apogee velocity of an elliptical satellite orbit.",
      "orderItems": [
        "Extract the primary body standard gravitational parameter \u03bc (398,600 km^3/s^2 for Earth)",
        "Determine the perigee radius r_p = R_E + h_p and apogee radius r_a = R_E + h_a from given orbital altitudes",
        "Calculate the orbital semi-major axis: a = (r_p + r_a) / 2",
        "Calculate the total specific mechanical energy: \u03b5 = - \u03bc / (2 * a)",
        "Apply the Vis-Viva equation to compute instantaneous velocities: v_p = \u221a[ \u03bc * (2/r_p - 1/a) ] and v_a = \u221a[ \u03bc * (2/r_a - 1/a) ]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Astrodynamics Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Vis-Viva Equation", "right": "v^2 = \u03bc*(2/r - 1/a), fundamental energy conservation relation governing orbital velocity at any position" },
        { "left": "Specific Orbital Energy (\u03b5)", "right": "\u03b5 = v^2/2 - \u03bc/r = -\u03bc/(2a), constant specific mechanical energy uniquely determined by semi-major axis" },
        { "left": "Perigee (Periapsis)", "right": "Point of closest orbital approach to primary body where gravitational potential is lowest and velocity is maximum" },
        { "left": "Apogee (Apoapsis)", "right": "Point of farthest orbital distance from primary body where gravitational potential is highest and velocity is minimum" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The total specific mechanical energy \u03b5 of any closed Keplerian elliptical orbit around a central planet depends exclusively on the orbit's semi-___ axis a.",
      "blankAnswer": "major",
      "blankDistractors": ["minor", "latus", "focal"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An Earth satellite (\u03bc = 398,600 km^3/s^2) has perigee radius r_p = 7000.0 km and apogee radius r_a = 28,000.0 km. Semi-major axis is a = (7000 + 28000)/2 = 17,500.0 km. Using Vis-Viva: v_p^2 = 398,600 * (2/7000 - 1/17500) = 398,600 * (8/35000) = 91.109 km^2/s^2; v_a^2 = 398,600 * (2/28000 - 1/17500) = 398,600 * (1/70000) = 5.694 km^2/s^2. What are the perigee and apogee velocities v_p and v_a?",
      "options": [
        { "text": "v_p = 9.55 km/s and v_a = 2.39 km/s (v_p = \u221a91.109 = 9.545 \u2248 9.55 km/s; v_a = \u221a5.694 = 2.386 \u2248 2.39 km/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Vis-Viva energy conservation equation (Howard D. Curtis *Orbital Mechanics for Engineering Students* Chapter 2; Roger R. Bate *Fundamentals of Astrodynamics* Chapter 1). 1. **Identify Orbit Parameters \\& Gravitational Constant:** - Earth gravitational parameter: $\\mu = 398,600.0\\text{ km}^3\\text{/s}^2$. - Perigee radius: $r_p = 7000.0\\text{ km}$. - Apogee radius: $r_a = 28,000.0\\text{ km}$. - Semi-major axis: $$a = \\frac{r_p + r_a}{2} = \\frac{7000.0 + 28,000.0}{2} = \\frac{35,000.0}{2} = \\mathbf{17,500.0\\text{ km}}$$ 2. **Calculate Velocity at Perigee ($v_p$):** - Vis-Viva equation at $r = r_p = 7000.0\\text{ km}$: $$v_p^2 = \\mu \\left( \\frac{2}{r_p} - \\frac{1}{a} \\right) = 398,600 \\left( \\frac{2}{7000.0} - \\frac{1}{17,500.0} \\right)$$ $$v_p^2 = 398,600 \\left( \\frac{10 - 2}{35,000.0} \\right) = 398,600 \\times \\left( \\frac{8}{35,000.0} \\right) = \\frac{3,188,800.0}{35,000.0} = \\mathbf{91.10857\\text{ km}^2\\text{/s}^2}$$ $$v_p = \\sqrt{91.10857} = \\mathbf{9.5451\\text{ km/s} \\approx 9.55\\text{ km/s}}$$ 3. **Calculate Velocity at Apogee ($v_a$):** - Vis-Viva equation at $r = r_a = 28,000.0\\text{ km}$: $$v_a^2 = \\mu \\left( \\frac{2}{r_a} - \\frac{1}{a} \\right) = 398,600 \\left( \\frac{2}{28,000.0} - \\frac{1}{17,500.0} \\right)$$ $$v_a^2 = 398,600 \\left( \\frac{5 - 4}{70,000.0} \\right) = 398,600 \\times \\left( \\frac{1}{70,000.0} \\right) = \\mathbf{5.694286\\text{ km}^2\\text{/s}^2}$$ $$v_a = \\sqrt{5.694286} = \\mathbf{2.3863\\text{ km/s} \\approx 2.39\\text{ km/s}}$$ Flawless Vis-Viva velocity and orbital energy derivation!" },
        { "text": "v_p = 7.55 km/s and v_a = 3.77 km/s (Assumed circular velocities)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v_p = 11.20 km/s and v_a = 1.41 km/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v_p = 9.55 km/s and v_a = 4.77 km/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
