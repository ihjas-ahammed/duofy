# Duofy Reusable Lesson Format: Kepler's Laws and Orbital Eccentricity

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Central_Force_Motion_and_Planetary_Orbits`  
**Lesson Format Type:** `keplers_laws_and_orbital_eccentricity`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to solve the gravitational inverse-square **Kepler Problem** ($V(r) = -G M m / r$): formulate **Kepler's 3 Laws of Planetary Motion**, solve the Binet orbit equation for conic section trajectories $r(\theta) = \frac{p}{1 + e\cos\theta}$, evaluate the **Eccentricity Formula $e = \sqrt{1 + \frac{2 E L^2}{\mu k^2}}$**, and derive Kepler's Third Law ($T^2 \propto a^3$) from areal velocity $\frac{dA}{dt} = \frac{L}{2\mu}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kepler's Laws & Conic Section Orbit Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Kepler's 3rd Law T^2 proportional to a^3 Derivation | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Eccentricity Value e & Conic Section Trajectory Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Orbital Period for 4 AU Semimajor Axis Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Kepler's Second Law Areal Velocity Conservation Origin Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Kepler's Three Laws of Planetary Motion (Johannes Kepler, 1609-1619) and their Newtonian explanations:
   - **First Law (Ellipses):** Planets orbit the Sun in ellipses with the Sun at one focus:
     $$r(\theta) = \frac{p}{1 + e\cos\theta}, \qquad p = \frac{L^2}{\mu G M m} = a(1 - e^2)$$
   - **Second Law (Equal Areas):** A line joining a planet and the Sun sweeps out equal areas in equal intervals of time:
     $$\frac{dA}{dt} = \frac{L}{2\mu} = \text{const} \quad (\text{Direct consequence of Angular Momentum Conservation!})$$
   - **Third Law (Harmonic Law):** The square of the orbital period $T$ is proportional to the cube of the semimajor axis $a$:
     $$T^2 = \frac{4\pi^2}{G(M + m)} a^3$$
   - **Eccentricity Formula:** $e = \sqrt{1 + \frac{2 E L^2}{\mu k^2}}$ ($e=0$ Circle, $0 < e < 1$ Ellipse, $e=1$ Parabola, $e>1$ Hyperbola).
2. **Slide 2 (`concept_pieces`):** Deconstruct derivation of Kepler's Third Law $T^2 = \frac{4\pi^2}{\mu k} a^3$: (1) total area of an ellipse with semimajor axis $a$ and semiminor axis $b$ is $A = \pi a b$, (2) integrate constant areal velocity over full orbital period $T$: $A = \int_0^T \frac{dA}{dt} dt = \frac{L}{2\mu} T = \pi a b$, (3) solve for period: $T = \frac{2\mu \pi a b}{L} \implies T^2 = \frac{4\pi^2 \mu^2 a^2 b^2}{L^2}$, (4) use ellipse geometric identity $b^2 = a p = a \frac{L^2}{\mu k}$, (5) substitute $b^2$: $T^2 = \frac{4\pi^2 \mu^2 a^2}{L^2} \left(a \frac{L^2}{\mu k}\right) = \frac{4\pi^2 \mu}{k} a^3 = \frac{4\pi^2}{G(M+m)} a^3$!
3. **Slide 3 (`matching`):** Pair 4 conic section orbits ($e = 0$, $e = 0.5$, $e = 1.0$, $e = 2.0$) with their energy signatures and geometries ($E = -E_{\min}$ Circle, $E < 0$ Ellipse, $E = 0$ Parabola, $E > 0$ Hyperbola).
4. **Slide 4 (`numerical`):** Ask student: For a planet orbiting the Sun with semimajor axis $a = 4\text{ AU}$, calculate its orbital period $T$ in Earth years using Kepler's 3rd Law ($T^2 = a^3 \implies T = a^{3/2} = 4^{3/2} = (\sqrt{4})^3 = 2^3 = 8$ years, numeric answer: 8).
5. **Slide 5 (`quiz`):** Quiz on the physical foundation of Kepler's Second Law: Which fundamental physical conservation law is solely responsible for Kepler's Second Law (equal area in equal time)? (Conservation of ANGULAR MOMENTUM $\mathbf{L}$; because the gravitational force is central ($\mathbf{r} \times \mathbf{F} = \mathbf{0}$), torque is identically zero, meaning $\frac{dA}{dt} = \frac{L}{2\mu}$ is strictly constant for ANY central force, not just $1/r^2$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "keplers_laws_and_orbital_eccentricity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Kepler's Laws and Orbital Eccentricity**\n• **Kepler's 1st Law (Conic Section Orbits):**\n$$\nr(\\theta) = \\frac{p}{1 + e\\cos\\theta}, \\qquad p = \\frac{L^2}{\\mu G M m} = a(1 - e^2)\n$$\n• **Kepler's 2nd Law (Equal Areas in Equal Times):**\n$$\n\\frac{dA}{dt} = \\frac{L}{2\\mu} = \\text{const} \\quad (\\text{Conservation of Angular Momentum!})\n$$\n• **Kepler's 3rd Law (Harmonic Law):**\n$$\nT^2 = \\frac{4\\pi^2}{G(M + m)} a^3\n$$\n• **The Orbital Eccentricity Parameter $e$:**\n$$\ne = \\sqrt{1 + \\frac{2 E L^2}{\\mu k^2}}\n$$\n  - $e = 0$: Circle | $0 < e < 1$: Ellipse | $e = 1$: Parabola | $e > 1$: Hyperbola."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Total Ellipse Area):** Area of ellipse with semimajor axis $a$ and semiminor axis $b$ is $A = \\pi a b$.\n• **Step 2 (Integrate Areal Velocity):** $A = \\int_0^T \\frac{dA}{dt} dt = \\frac{L}{2\\mu} T = \\pi a b$.\n• **Step 3 (Solve for $T^2$):** $T^2 = \\frac{4\\pi^2 \\mu^2 a^2 b^2}{L^2}$.\n• **Step 4 (Substitute Semiminor Axis $b^2$):** From conic geometry, $b^2 = a p = a \\frac{L^2}{\\mu k}$.\n• **Step 5 (Derive Kepler's 3rd Law):**\n  $$T^2 = \\frac{4\\pi^2 \\mu^2 a^2}{L^2} \\left(a \\frac{L^2}{\\mu k}\\right) = \\frac{4\\pi^2 \\mu}{k} a^3 = \\frac{4\\pi^2}{G(M+m)} a^3!$$"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each orbital eccentricity e to its orbit trajectory and energy E.",
      "matchPairs": [
        { "left": "e = 0", "right": "Circular Orbit (E = -mu k^2 / (2 L^2) = E_min)" },
        { "left": "0 < e < 1", "right": "Elliptical Bound Orbit (E_min < E < 0)" },
        { "left": "e = 1", "right": "Parabolic Orbit (E = 0, exactly at escape velocity threshold)" },
        { "left": "e > 1", "right": "Hyperbolic Orbit (E > 0, unbound gravitational flyby)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Using Kepler's 3rd Law T^2 = a^3, calculate the orbital period T (in Earth years) for an asteroid orbiting the Sun with semimajor axis a = 4 AU: T = 4^{3/2}.",
      "numericAnswer": 8,
      "numericTolerance": 0
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What fundamental physical conservation law is directly responsible for Kepler's Second Law (a planet sweeps out equal areas in equal times)?",
      "options": [
        { "text": "CONSERVATION OF ANGULAR MOMENTUM (L = const); because central forces exert zero torque (tau = r x F = 0), the areal velocity dA/dt = L / (2 mu) is strictly constant for ANY central potential", "isCorrect": true, "explanation": "Correct! Kepler's second law is an exact consequence of angular momentum conservation, which holds true for all central force fields regardless of the force law." },
        { "text": "Conservation of linear momentum", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Conservation of electric charge", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Conservation of temperature", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
