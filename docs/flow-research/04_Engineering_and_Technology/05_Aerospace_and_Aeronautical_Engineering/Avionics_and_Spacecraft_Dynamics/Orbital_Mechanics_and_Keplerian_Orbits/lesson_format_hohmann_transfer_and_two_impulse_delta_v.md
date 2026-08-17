# Duofy Reusable Lesson Format: Orbital Transfers (Hohmann Transfer & Two-Impulse Delta-V)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Avionics_and_Spacecraft_Dynamics / Orbital_Mechanics_and_Keplerian_Orbits`  
**Lesson Format Type:** `hohmann_transfer_and_two_impulse_delta_v`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the astrodynamics of co-planar orbital maneuvers, Walter Hohmann's 1925 **Two-Impulse Hohmann Transfer**, connecting an initial circular orbit of radius $r_1$ to an outer target circular orbit of radius $r_2$, the intermediate **Transfer Ellipse** with semi-major axis ($a_{\text{trans}} = \frac{r_1 + r_2}{2}$), the first prograde burn ($\Delta v_1$) at perigee $r_1$, the second prograde circularization burn ($\Delta v_2$) at apogee $r_2$, the total mission velocity budget ($\Delta v_{\text{total}} = \Delta v_1 + \Delta v_2$), and the one-way **Transfer Time ($t_{\text{trans}} = \frac{1}{2} T_{\text{trans}} = \pi \sqrt{a_{\text{trans}}^3 / \mu}$)** (Howard D. Curtis *Orbital Mechanics for Engineering Students* 4th ed. Chapter 6; Roger R. Bate *Fundamentals of Astrodynamics* Chapter 3; Walter Hohmann 1925): formulate the **Hohmann Transfer Master Velocity Formulation**:
$$\mathbf{a_{\text{trans}} = \frac{r_1 + r_2}{2} \quad \left[\text{km}\right]}$$
where:
1. **Initial Circular Speed at $r_1$:** $\mathbf{v_{\text{circ},1} = \sqrt{\frac{\mu}{r_1}}}$;
2. **Transfer Ellipse Perigee Velocity at $r_1$:** $\mathbf{v_{\text{trans},p} = \sqrt{\mu \left( \frac{2}{r_1} - \frac{1}{a_{\text{trans}}} \right)} = \sqrt{\frac{\mu}{r_1}} \sqrt{\frac{2 r_2}{r_1 + r_2}}}$;
3. **First Impulse ($\Delta v_1$ at Departure):**
   $$\mathbf{\Delta v_1 = v_{\text{trans},p} - v_{\text{circ},1} = \sqrt{\frac{\mu}{r_1}} \left( \sqrt{\frac{2 r_2}{r_1 + r_2}} - 1 \right)}$$
4. **Final Circular Speed at $r_2$:** $\mathbf{v_{\text{circ},2} = \sqrt{\frac{\mu}{r_2}}}$;
5. **Transfer Ellipse Apogee Velocity at $r_2$:** $\mathbf{v_{\text{trans},a} = \sqrt{\mu \left( \frac{2}{r_2} - \frac{1}{a_{\text{trans}}} \right)} = \sqrt{\frac{\mu}{r_2}} \sqrt{\frac{2 r_1}{r_1 + r_2}}}$;
6. **Second Impulse ($\Delta v_2$ at Arrival):**
   $$\mathbf{\Delta v_2 = v_{\text{circ},2} - v_{\text{trans},a} = \sqrt{\frac{\mu}{r_2}} \left( 1 - \sqrt{\frac{2 r_1}{r_1 + r_2}} \right)}$$
7. **Total Hohmann Transfer Velocity Requirement ($\Delta v_{\text{total}}$):**
   $$\mathbf{\Delta v_{\text{total}} = \Delta v_1 + \Delta v_2 \quad [\text{km/s}]}$$
8. **Transfer Time (Half-Period of Transfer Ellipse):**
   $$\mathbf{t_{\text{trans}} = \frac{1}{2} T_{\text{trans}} = \pi \sqrt{\frac{a_{\text{trans}}^3}{\mu}} \quad [\text{seconds}]}$$
(proving that for radius ratios $r_2 / r_1 < 11.94$, the Hohmann transfer represents the absolute minimum propellant energy trajectory connecting any two concentric circular orbits).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Transfer Ellipse ($a_{\text{trans}} = \frac{r_1+r_2}{2}$), $\Delta v_1, \Delta v_2$ & Transfer Time ($t_{\text{trans}} = \pi\sqrt{\frac{a^3}{\mu}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Burn Impulses Delta v1 and Delta v2 and Transfer Time for a LEO-to-GEO Hohmann Transfer Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hohmann Transfer Parameter / Orbital Milestone & Technical Astrodynamic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Time Required to Complete a Hohmann Orbital Transfer Equals Exactly One-___ of the Orbital Period of the Transfer Ellipse (Half / 1/2 / Half-Period) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Space Mission Design Problem: Calculating Delta v1, Delta v2, and Total Delta v for a LEO to GEO Satellite Insertion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hohmann Transfer Mechanics (Hohmann 1925; Curtis 2020; Vallado 2013):
   - **Transfer Formulations:**
     $$\mathbf{a_{\text{trans}} = \frac{r_1+r_2}{2} \quad \Big| \quad \Delta v_1 = \sqrt{\frac{\mu}{r_1}}\left(\sqrt{\frac{2r_2}{r_1+r_2}} - 1\right) \quad \Big| \quad \Delta v_2 = \sqrt{\frac{\mu}{r_2}}\left(1 - \sqrt{\frac{2r_1}{r_1+r_2}}\right) \quad \Big| \quad t_{\text{trans}} = \pi\sqrt{\frac{a_{\text{trans}}^3}{\mu}}}$$
   - **Hohmann Transfer Trajectory Matrix (LEO to GEO):**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Maneuver Milestone} & \textbf{Radius } r & \textbf{Speed Change } \Delta v & \textbf{Propulsion Engine Action} \\
     \hline
     \mathbf{\text{Initial Orbit (LEO)}} & \mathbf{r_1 = 6,700\text{ km}} & v_1 = 7.713\text{ km/s} & Spacecraft in stable low circular orbit \\
     \mathbf{\text{Burn 1 (Perigee Kick)}} & \mathbf{r_1 = 6,700\text{ km}} & \mathbf{\Delta v_1 \approx 2.44\text{ km/s}} & \mathbf{\text{Prograde burn to enter GTO transfer ellipse}} \\
     \text{Coasting Phase (GTO)} & r_1 \to r_2 & \text{No thrust} & Spacecraft coasts for $t_{\text{trans}} \approx 5.27\text{ hours}$ \\
     \mathbf{\text{Burn 2 (Apogee Kick)}} & \mathbf{r_2 = 42,164\text{ km}} & \mathbf{\Delta v_2 \approx 1.47\text{ km/s}} & \mathbf{\text{Prograde burn to circularize at GEO altitude}} \\
     \hline
     \end{array}$$
   - **The Tangency Invariant:** Hohmann transfer burns occur **strictly tangential to the flight path at apsides ($\gamma = 0$)**; performing burns tangentially maximizes the rate of change of orbital mechanical energy ($d\mathcal{E}/dt = \vec{v} \cdot \vec{T}/m$), achieving optimal fuel efficiency (the Oberth effect)!
2. **Slide 2 (`ordering`):** Provide 5 steps of Hohmann transfer calculation: (1) determine departure radius $r_1$ and destination radius $r_2$, (2) calculate semi-major axis of transfer ellipse: $a_{\text{trans}} = (r_1 + r_2) / 2$, (3) compute departure burn impulse: $\Delta v_1 = \sqrt{\mu(2/r_1 - 1/a_{\text{trans}})} - \sqrt{\mu / r_1}$, (4) compute arrival circularization burn: $\Delta v_2 = \sqrt{\mu / r_2} - \sqrt{\mu(2/r_2 - 1/a_{\text{trans}})}$, (5) sum impulses $\Delta v_{\text{total}} = \Delta v_1 + \Delta v_2$ and compute transfer duration: $t_{\text{trans}} = \pi \sqrt{a_{\text{trans}}^3 / \mu}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Transfer Ellipse $a_{\text{trans}}$, Perigee Burn $\Delta v_1$, Apogee Burn $\Delta v_2$, Transfer Time $t_{\text{trans}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Half (or 1/2 / Half-Period). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Hohmann transfer $\Delta v$: An Earth satellite ($\mu = 398,600.0\text{ km}^3\text{/s}^2$) transfers from a circular parking orbit at $r_1 = 7000.0\text{ km}$ to a higher circular orbit at $r_2 = 28,000.0\text{ km}$.
   - Transfer ellipse semi-major axis: $a_{\text{trans}} = \frac{7000.0 + 28,000.0}{2} = \mathbf{17,500.0\text{ km}}$;
   - Initial circular speed: $v_{\text{circ},1} = \sqrt{\frac{398,600}{7000}} = \sqrt{56.94286} = \mathbf{7.5460\text{ km/s}}$;
   - Transfer perigee speed: $v_{\text{trans},p} = \sqrt{398,600 \left( \frac{2}{7000} - \frac{1}{17,500} \right)} = \sqrt{91.10857} = \mathbf{9.5451\text{ km/s}}$;
   - First burn: $\Delta v_1 = 9.5451 - 7.5460 = \mathbf{1.9991\text{ km/s} \approx 2.00\text{ km/s}}$;
   - Final circular speed: $v_{\text{circ},2} = \sqrt{\frac{398,600}{28,000}} = \sqrt{14.23571} = \mathbf{3.7730\text{ km/s}}$;
   - Transfer apogee speed: $v_{\text{trans},a} = \sqrt{398,600 \left( \frac{2}{28,000} - \frac{1}{17,500} \right)} = \sqrt{5.694286} = \mathbf{2.3863\text{ km/s}}$;
   - Second burn: $\Delta v_2 = 3.7730 - 2.3863 = \mathbf{1.3867\text{ km/s} \approx 1.39\text{ km/s}}$;
   - Total $\Delta v$: $\Delta v_{\text{total}} = 1.9991 + 1.3867 = \mathbf{3.3858\text{ km/s} \approx 3.39\text{ km/s}}$;
   - What are the burn impulses $\Delta v_1, \Delta v_2$, and the total $\Delta v_{\text{total}}$? ($\Delta v_1 = \mathbf{2.00\text{ km/s}}, \Delta v_2 = \mathbf{1.39\text{ km/s}}, \Delta v_{\text{total}} = \mathbf{3.39\text{ km/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hohmann_transfer_and_two_impulse_delta_v",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Orbital Transfers \\& Hohmann Maneuver (Walter Hohmann 1925)**\n• **Transfer Ellipse Semi-Major Axis Master Formulation:**\n$$\n\\mathbf{a_{\\text{trans}} = \\frac{r_1 + r_2}{2} \\quad [\\text{km}]}\n$$\n• **Two-Impulse Hohmann Velocity Changes ($\\Delta v_1, \\Delta v_2$):**\n$$\n\\mathbf{\\Delta v_1 = \\sqrt{\\frac{\\mu}{r_1}} \\left( \\sqrt{\\frac{2 r_2}{r_1 + r_2}} - 1 \\right)} \\quad \\Big| \\quad \\mathbf{\\Delta v_2 = \\sqrt{\\frac{\\mu}{r_2}} \\left( 1 - \\sqrt{\\frac{2 r_1}{r_1 + r_2}} \\right)}\n$$\n  - **$\\Delta v_{\\text{total}} = \\Delta v_1 + \\Delta v_2$:** Total mission velocity budget ($\\text{km/s}$);\n• **Transfer Time Formulation (Half Orbital Period):**\n$$\n\\mathbf{t_{\\text{trans}} = \\frac{1}{2} T_{\\text{trans}} = \\pi \\sqrt{\\frac{a_{\\text{trans}}^3}{\\mu}} \\quad [\\text{seconds}]}\n$$\n• **The Tangential Efficiency Invariant:** All Hohmann burns occur **strictly tangential to the flight trajectory at apsides**, maximizing orbital mechanical energy change per unit propellant mass (Oberth Effect) to establish the minimum fuel transfer!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to execute a co-planar Hohmann transfer between two circular orbits of radii r1 and r2.",
      "orderItems": [
        "Determine the initial circular orbit radius r1 and target circular orbit radius r2",
        "Calculate the semi-major axis of the transfer ellipse: a_trans = (r1 + r2) / 2",
        "Perform first prograde burn \u0394v1 at perigee: \u0394v1 = \u221a[\u03bc*(2/r1 - 1/a_trans)] - \u221a(\u03bc/r1) to inject into transfer orbit",
        "Coast along the elliptical transfer trajectory for transfer duration t_trans = \u03c0 * \u221a(a_trans^3 / \u03bc)",
        "Perform second prograde burn \u0394v2 at apogee: \u0394v2 = \u221a(\u03bc/r2) - \u221a[\u03bc*(2/r2 - 1/a_trans)] to circularize in target orbit"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hohmann Transfer Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Transfer Ellipse (a_trans)", "right": "a_trans = (r1 + r2) / 2, intermediate Keplerian orbit tangent to both initial and final circular orbits" },
        { "left": "Departure Burn (\u0394v1)", "right": "Prograde velocity boost applied at perigee r1 to raise apoapsis from r1 to target altitude r2" },
        { "left": "Arrival Burn (\u0394v2)", "right": "Prograde velocity boost applied at apogee r2 to circularize the spacecraft at target orbit radius" },
        { "left": "Transfer Time (t_trans)", "right": "t_trans = \u03c0*\u221a(a_trans^3/\u03bc), exact time of flight representing one half-period of the transfer ellipse" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The time required to complete a Hohmann orbital transfer equals exactly one-___ of the orbital period of the transfer ellipse.",
      "blankAnswer": "half",
      "blankDistractors": ["third", "fourth", "quarter"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A satellite (\u03bc = 398,600 km^3/s^2) transfers from r1 = 7000.0 km (v_circ,1 = 7.55 km/s) to r2 = 28,000.0 km (v_circ,2 = 3.77 km/s). For a_trans = 17,500 km, transfer speeds are v_trans,p = 9.55 km/s and v_trans,a = 2.39 km/s. \u0394v1 = 9.55 - 7.55 = 2.00 km/s and \u0394v2 = 3.77 - 2.39 = 1.38 km/s. What is the total velocity budget \u0394v_total?",
      "options": [
        { "text": "\u0394v_total = 3.39 km/s (\u0394v_total = \u0394v1 + \u0394v2 = 2.00 km/s + 1.39 km/s = 3.39 km/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the two-impulse Hohmann transfer equations (Howard D. Curtis *Orbital Mechanics for Engineering Students* Chapter 6; Roger R. Bate *Fundamentals of Astrodynamics* Chapter 3). 1. **Identify Geometric Radii \\& Transfer Orbit Semi-Major Axis:** - Earth gravitational parameter: $\\mu = 398,600.0\\text{ km}^3\\text{/s}^2$. - Initial radius: $r_1 = 7000.0\\text{ km}$. - Final radius: $r_2 = 28,000.0\\text{ km}$. - Transfer semi-major axis: $$a_{\\text{trans}} = \\frac{r_1 + r_2}{2} = \\frac{7000.0 + 28,000.0}{2} = \\mathbf{17,500.0\\text{ km}}$$ 2. **Calculate First Burn Impulse ($\\Delta v_1$):** - Circular speed at $r_1$: $$v_{\\text{circ},1} = \\sqrt{\\frac{\\mu}{r_1}} = \\sqrt{\\frac{398,600.0}{7000.0}} = \\mathbf{7.54598\\text{ km/s}}$$ - Transfer perigee speed at $r_1$: $$v_{\\text{trans},p} = \\sqrt{\\mu \\left( \\frac{2}{r_1} - \\frac{1}{a_{\\text{trans}}} \\right)} = \\sqrt{398,600 \\left( \\frac{2}{7000.0} - \\frac{1}{17,500.0} \\right)} = \\mathbf{9.54508\\text{ km/s}}$$ - First impulse: $$\\Delta v_1 = v_{\\text{trans},p} - v_{\\text{circ},1} = 9.54508 - 7.54598 = \\mathbf{1.99910\\text{ km/s} \\approx 2.00\\text{ km/s}}$$ 3. **Calculate Second Burn Impulse ($\\Delta v_2$):** - Circular speed at $r_2$: $$v_{\\text{circ},2} = \\sqrt{\\frac{\\mu}{r_2}} = \\sqrt{\\frac{398,600.0}{28,000.0}} = \\mathbf{3.77303\\text{ km/s}}$$ - Transfer apogee speed at $r_2$: $$v_{\\text{trans},a} = \\sqrt{\\mu \\left( \\frac{2}{r_2} - \\frac{1}{a_{\\text{trans}}} \\right)} = \\sqrt{398,600 \\left( \\frac{2}{28,000.0} - \\frac{1}{17,500.0} \\right)} = \\mathbf{2.38627\\text{ km/s}}$$ - Second impulse: $$\\Delta v_2 = v_{\\text{circ},2} - v_{\\text{trans},a} = 3.77303 - 2.38627 = \\mathbf{1.38676\\text{ km/s} \\approx 1.39\\text{ km/s}}$$ 4. **Calculate Total Velocity Budget ($\\Delta v_{\\text{total}}$):** $$\\Delta v_{\\text{total}} = \\Delta v_1 + \\Delta v_2 = 1.99910 + 1.38676 = \\mathbf{3.38586\\text{ km/s} \\approx 3.39\\text{ km/s}}$$ Flawless Hohmann orbital transfer $\\Delta v$ derivation!" },
        { "text": "\u0394v_total = 1.99 km/s (Forgot circularization burn \u0394v2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394v_total = 6.78 km/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394v_total = 4.50 km/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
