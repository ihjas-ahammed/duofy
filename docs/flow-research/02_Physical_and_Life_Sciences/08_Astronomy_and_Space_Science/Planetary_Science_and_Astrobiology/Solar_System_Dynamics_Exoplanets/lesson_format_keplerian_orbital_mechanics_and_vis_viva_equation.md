# Duofy Reusable Lesson Format: Keplerian Orbital Mechanics and the Vis-Viva Equation

**Target Topic:** `02_Physical_and_Life_Sciences / 08_Astronomy_and_Space_Science / Planetary_Science_and_Astrobiology / Solar_System_Dynamics_Exoplanets`  
**Lesson Format Type:** `keplerian_orbital_mechanics_and_vis_viva_equation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the Newtonian two-body gravitational mechanics, orbital energy conservation, and conic trajectory velocities of planetary celestial mechanics (Johannes Kepler 1609; Isaac Newton 1687; Carl D. Murray): master the **Vis-Viva Equation ($v^2 = G M \left(\frac{2}{r} - \frac{1}{a}\right)$)** derived from specific orbital energy conservation ($\epsilon = -\frac{GM}{2a} = \frac{1}{2}v^2 - \frac{GM}{r}$), evaluate velocities at critical orbital positions (**Periapsis $r_p = a(1-e) \implies v_{\max} = \sqrt{\frac{GM}{a}\frac{1+e}{1-e}}$**, **Apoapsis $r_a = a(1+e) \implies v_{\min} = \sqrt{\frac{GM}{a}\frac{1-e}{1+e}}$**, and **Circular Speed $v_c = \sqrt{\frac{GM}{r}}$**), calculate parabolic **Escape Velocity ($v_{\text{esc}} = \sqrt{\frac{2GM}{R}} = \sqrt{2} v_c$)**, and apply the Newtonian form of **Kepler's Third Law ($P^2 = \frac{4\pi^2 a^3}{G(M_1 + M_2)}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Vis-Viva Equation, Specific Orbital Energy, & Escape Speed Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Planetary Velocity Transition from Perihelion to Aphelion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Orbital Trajectory Type / State & Specific Energy / Velocity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Multiplier Ratio Relating Escape Velocity to Circular Orbit Velocity Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Calculation of Velocity Change Required to Achieve Parabolic Escape Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Vis-Viva Equation & Keplerian Mechanics (Newton 1687; Murray & Dermott):
   - **Specific Orbital Energy Conservation ($\epsilon = \text{const}$):**
     $$\mathbf{\epsilon = \frac{1}{2}v^2 - \frac{GM}{r} = -\frac{GM}{2a} \iff v^2 = GM\left(\frac{2}{r} - \frac{1}{a}\right) \quad (\text{The Vis-Viva Equation})}$$
   - **Critical Orbital Velocities:**
     - **Circular Orbit ($a = r$):** $\mathbf{v_c = \sqrt{\frac{GM}{r}}}$.
     - **Parabolic Escape Trajectory ($a \to \infty, \epsilon = 0$):** $\mathbf{v_{\text{esc}} = \sqrt{\frac{2GM}{r}} = \sqrt{2} v_c \approx 1.414\ v_c}$.
     - **Elliptical Extremes (Eccentricity $e$):**
       $$\mathbf{v_{\text{perihelion}} = \sqrt{\frac{GM}{a} \left(\frac{1+e}{1-e}\right)} \quad (\text{Maximum Speed}) \qquad v_{\text{aphelion}} = \sqrt{\frac{GM}{a} \left(\frac{1-e}{1+e}\right)} \quad (\text{Minimum Speed})}$$
   - **Kepler's Third Law (Newtonian Generalization):**
     $$\mathbf{P^2 = \frac{4\pi^2 a^3}{G(M_\star + M_p)} \approx \frac{4\pi^2 a^3}{G M_\star}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of a comet's velocity and energy evolution along a highly eccentric elliptical orbit: (1) the comet whips past perihelion at closest approach (r = a(1-e)), reaching its absolute maximum orbital velocity and maximum kinetic energy, (2) moving outward against the Sun's gravitational field, gravitational potential energy increases while kinetic energy and velocity steadily drop, (3) the comet crosses the semi-latus rectum at distance r = a, where its velocity equals the circular velocity v_c, (4) the comet reaches aphelion at furthest distance (r = a(1+e)), slowing to its absolute minimum orbital velocity, (5) gravitational attraction pulls the comet back inward along the ellipse, converting potential energy back to kinetic energy as it accelerates toward perihelion!
3. **Slide 3 (`matching`):** Pair 4 conic orbit geometries (Bound Ellipse a>0, Circular Orbit a=r, Parabolic Escape a=infinity, Hyperbolic Unbound a<0) with their specific orbital energies.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that escape velocity is equal to the square root of 2 times circular orbital velocity (v_esc = sqrt(2) * v_c). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating the orbital period of an exoplanet orbiting a 4-solar-mass star: An exoplanet orbits a massive 4-solar-mass star ($M_\star = 4\ M_\odot$) at a semi-major axis of $a = 4\text{ AU}$. What is the orbital period ($P$) of this planet? (Using $P^2 = a^3 / M_\star$: $P^2 = 4^3 / 4 = 64 / 4 = 16 \implies \mathbf{P = \sqrt{16} = 4\text{ years}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "keplerian_orbital_mechanics_and_vis_viva_equation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Vis-Viva Equation & Orbital Mechanics**\n• **Specific Orbital Energy ($\\epsilon = \\text{const}$):**\n$$\n\\mathbf{\\epsilon = \\frac{1}{2}v^2 - \\frac{GM}{r} = -\\frac{GM}{2a} \\implies v^2 = GM \\left(\\frac{2}{r} - \\frac{1}{a}\\right) \\quad (\\text{Vis-Viva Equation})}\n$$\n• **The Velocity Hierarchy:**\n  - **Circular Velocity ($a=r$):** $\\mathbf{v_c = \\sqrt{\\frac{GM}{r}}}$.\n  - **Escape Velocity ($a \\to \\infty$):** $\\mathbf{v_{\\text{esc}} = \\sqrt{\\frac{2GM}{r}} = \\sqrt{2} v_c \\approx 1.414\\ v_c}$!\n  - **Perihelion Speed:** $v_{\\text{peri}} = \\sqrt{\\frac{GM}{a} \\frac{1+e}{1-e}}$ (Max) vs **Aphelion:** $v_{\\text{aph}} = \\sqrt{\\frac{GM}{a} \\frac{1-e}{1+e}}$ (Min).\n• **Newton's Kepler's 3rd Law:** $\\mathbf{\\left(\\frac{P}{1\\text{ yr}}\\right)^2 = \\frac{(a / 1\\text{ AU})^3}{M_\\star / M_\\odot}}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential dynamical phases of a comet executing one complete revolution along an eccentric elliptical orbit.",
      "orderItems": [
        "The comet passes perihelion at closest solar approach (r = a(1-e)), reaching maximum orbital velocity and kinetic energy",
        "Ascending outward against solar gravity, the comet decelerates as kinetic energy converts into gravitational potential energy",
        "The comet crosses semi-major axis distance r = a, where its instantaneous velocity equals local circular speed",
        "The comet reaches aphelion at maximum distance (r = a(1+e)), slowing to its absolute minimum orbital velocity",
        "Solar gravitational pull accelerates the descending comet back inward toward perihelion, completing the cycle"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each orbital trajectory classification to its exact specific orbital energy (epsilon).",
      "matchPairs": [
        { "left": "Bound Elliptical Orbit (a > 0)", "right": "Negative specific energy (epsilon < 0) where total mechanical energy is bound by gravity" },
        { "left": "Circular Orbit (a = r)", "right": "Constant distance and velocity with minimum possible bound specific energy (epsilon = -GM / 2r)" },
        { "left": "Parabolic Escape Trajectory (a = inf)", "right": "Zero specific energy (epsilon = 0) with instantaneous speed exactly equal to escape velocity" },
        { "left": "Unbound Hyperbolic Trajectory (a < 0)", "right": "Positive specific energy (epsilon > 0) carrying excess hyperbolic kinetic speed at infinity" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In celestial mechanics, the parabolic escape velocity from any circular orbit is equal to the square root of ___ times the circular orbital velocity.",
      "blankAnswer": "2",
      "blankDistractors": ["4", "10", "3"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An exoplanet is discovered orbiting a massive 4-solar-mass star (M_star = 4 M_Sun) at a semi-major axis distance of a = 4.0 Astronomical Units (AU). What is the orbital period (P) of this exoplanet in Earth years?",
      "options": [
        { "text": "P = 4.0 Earth years; calculated using Kepler's Third Law in solar system units: P^2 = a^3 / M_star = 4^3 / 4 = 64 / 4 = 16, taking the square root yields P = sqrt(16) = 4.0 years", "isCorrect": true, "explanation": "Correct! Kepler's Third Law generalized by Isaac Newton is expressed in Solar System convenient units as: (P / 1 yr)^2 = (a / 1 AU)^3 / (M_star / M_Sun). Here, the semi-major axis is a = 4.0 AU and the stellar mass is M_star = 4.0 M_Sun. Substituting these values into the equation: P^2 = (4.0)^3 / 4.0 = 64.0 / 4.0 = 16.0. Taking the square root of both sides gives: P = sqrt(16.0) = 4.0 Earth years. Notice that although the planet is four times farther out than Earth, the 4-fold stronger gravitational mass of the host star speeds up the orbital velocity, resulting in an orbital period of exactly 4 years (compared to 8 years if it were orbiting our Sun)." },
        { "text": "P = 64.0 Earth years because 4^3 = 64", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P = 1.0 Earth year because 4 divided by 4 equals 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P = 16.0 Earth years because you multiply 4 AU by 4 solar masses", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
