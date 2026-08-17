# Duofy Reusable Lesson Format: Wire Antennas (Half-Wave Dipole & Quarter-Wave Monopole)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electromagnetic_Fields_and_Waves / Antenna_Theory`  
**Lesson Format Type:** `half_wave_dipole_quarter_wave_monopole_and_radiation_resistance`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through sinusoidal current distributions, radiation resistance derivations, and Image Theory transformations for canonical half-wave ($\lambda/2$) dipoles and quarter-wave ($\lambda/4$) monopoles over ground planes (Heinrich Hertz 1888; Constantine A. Balanis *Antenna Theory: Analysis and Design* Chapter 4; Warren L. Stutzman Chapter 2 & 5): derive the **Half-Wave Resonant Dipole Parameters ($l = \lambda/2$)**:
$$\mathbf{I(z') = I_0 \cos(k z') \quad \Big| \quad \mathbf{E}_\theta = j \frac{\eta I_0 e^{-jkr}}{2\pi r} \left[ \frac{\cos\left(\frac{\pi}{2}\cos\theta\right)}{\sin\theta} \right]}$$
$$\mathbf{P_{\text{rad}} = \int_0^{2\pi}\int_0^\pi \frac{|E_\theta|^2}{2\eta} r^2 \sin\theta \, d\theta \, d\phi \implies \mathbf{R_{\text{rad}} = \frac{2 P_{\text{rad}}}{I_0^2} \approx 73.13\,\Omega \ (Z_{\text{in}} = 73.13 + j42.5\,\Omega)}}$$
$$\mathbf{D_0 = 1.643 \Longleftrightarrow \mathbf{D_0 = 2.15\text{ dBi}}}$$
derive the **Quarter-Wave Monopole over Infinite PEC Ground Plane ($l = \lambda/4$)** via **Electromagnetic Image Theory**:
- Monopole creates an identical mirror image in the lower hemisphere, radiating identically into the upper $2\pi$ hemisphere;
- Radiates **half the total power for the same feed current**: $\mathbf{P_{\text{rad,mono}} = \frac{1}{2} P_{\text{rad,dipole}}}$;
- Yields **half the input radiation resistance**: $\mathbf{R_{\text{rad,mono}} = \frac{73.13\,\Omega}{2} \approx 36.56\,\Omega}$;
- Doubles the upper-hemisphere directivity: $\mathbf{D_{0,\text{mono}} = 2 \times 1.643 = 3.286 \Longleftrightarrow \mathbf{5.16\text{ dBi}}}$!

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Half-Wave Dipole ($R_{\text{rad}}=73.13\,\Omega, D_0=2.15\text{ dBi}$) & Monopole Image Theory Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Derivation of Monopole Resistance and Directivity Using Image Theory Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Wire Antenna Type / Image Theory Transformation & Technical Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Theoretical Radiation Resistance of a Center-Fed Resonant Half-Wave Dipole in Free Space Is Approximately ___ Ohms (73 / 73.13) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mobile Antenna Engineering Problem: Evaluating Radiation Resistance and Directivity of a Roof Monopole Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Half-Wave Dipole & Quarter-Wave Monopole (Balanis 2016; Stutzman 2012):
   - **Wire Antennas Invariant Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Antenna Type} & \textbf{Physical Length } l & \textbf{Radiation Resistance } R_{\text{rad}} & \textbf{Directivity } D_0 & \textbf{Half-Power Beamwidth (HPBW)} \\
     \hline
     \mathbf{\text{Hertzian Dipole}} & l \ll \lambda & R_{\text{rad}} = 80\pi^2 (l/\lambda)^2 & D_0 = 1.50 \ (1.76\text{ dBi}) & \text{HPBW} = 90^\circ \\
     \mathbf{\text{Half-Wave Dipole}} & \mathbf{l = \lambda/2} & \mathbf{R_{\text{rad}} \approx 73.13\,\Omega} & \mathbf{D_0 = 1.643 \ (2.15\text{ dBi})} & \mathbf{\text{HPBW} = 78^\circ} \\
     \mathbf{\text{Quarter-Wave Monopole}} & \mathbf{l = \lambda/4 \ (\text{PEC})} & \mathbf{R_{\text{rad}} \approx 36.56\,\Omega} & \mathbf{D_0 = 3.286 \ (5.16\text{ dBi})} & \mathbf{\text{HPBW} = 39^\circ \ (\text{Upper Hem})} \\
     \hline
     \end{array}$$
   - **Image Theory Invariant:** The PEC ground plane reflects the lower hemisphere power back into the upper hemisphere, **doubling directivity ($+3\text{ dB}$) and halving input radiation resistance**!
2. **Slide 2 (`ordering`):** Provide 5 steps of monopole analysis: (1) replace the infinite PEC ground plane with a virtual mirror image of the $\lambda/4$ monopole in the lower hemisphere, (2) observe that the combined physical-plus-image antenna forms an equivalent $\lambda/2$ dipole in free space, (3) recognize that fields and radiation intensity $U(\theta,\phi)$ in the upper hemisphere ($0 \le \theta \le \pi/2$) are identical to the dipole, (4) integrate radiated power over upper hemisphere only to find $P_{\text{rad,mono}} = \frac{1}{2} P_{\text{rad,dipole}}$, (5) compute monopole radiation resistance $R_{\text{rad}} = 73.13 / 2 = 36.56\,\Omega$ and directivity $D_0 = 2 \times 1.643 = 3.286$ ($5.16\text{ dBi}$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Half-Wave Dipole $R_{\text{rad}}=73.13\,\Omega$, Quarter-Wave Monopole $R_{\text{rad}}=36.56\,\Omega$, Monopole Directivity $5.16\text{ dBi}$, Infinitesimal Dipole $80\pi^2(l/\lambda)^2$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 73 (or 73.13). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on comparing dipole and monopole: A vehicular communications system uses a quarter-wave monopole antenna ($l = \lambda/4$) mounted on the metal roof of a car (acting as an ideal PEC ground plane). Driven by feed current amplitude $I_0 = 2.0\text{ A}$, what is the total radiated power $P_{\text{rad}}$ and the directivity $D_0$ of the monopole in dBi? ($R_{\text{rad}} = \frac{73.13\,\Omega}{2} \approx 36.565\,\Omega$; $P_{\text{rad}} = \frac{1}{2} I_0^2 R_{\text{rad}} = \frac{1}{2} (2.0\text{ A})^2 \times (36.565\,\Omega) = \frac{1}{2}(4)(36.565) = \mathbf{73.13\text{ Watts}}$; Directivity $D_0 = 2 \times 1.643 = 3.286 \implies 10\log_{10}(3.286) = \mathbf{5.16\text{ dBi}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "half_wave_dipole_quarter_wave_monopole_and_radiation_resistance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Canonical Wire Antennas \\& Image Theory (Constantine Balanis)**\n• **Half-Wave Resonant Dipole Formulations ($l = \\lambda/2$):**\n$$\n\\mathbf{E_\\theta(r,\\theta) = j \\frac{\\eta I_0 e^{-jkr}}{2\\pi r} \\left[ \\frac{\\cos\\left(\\frac{\\pi}{2}\\cos\\theta\\right)}{\\sin\\theta} \\right] \\implies \\mathbf{R_{\\text{rad}} \\approx 73.13\\,\\Omega \\quad | \\quad D_0 = 1.643 \\ (2.15\\text{ dBi})}}\n$$\n• **Quarter-Wave Monopole over Infinite PEC Ground Plane ($l = \\lambda/4$):**\n  - By **Electromagnetic Image Theory**, the PEC ground plane reflects the lower hemisphere;\n  - Radiates into upper hemisphere ($2\\pi$ steradians) with **half the total power**:\n$$\n\\mathbf{P_{\\text{rad,mono}} = \\frac{1}{2} P_{\\text{rad,dipole}} \\implies \\mathbf{R_{\\text{rad,mono}} = \\frac{73.13\\,\\Omega}{2} \\approx 36.56\\,\\Omega}}\n$$\n$$\n\\mathbf{D_{0,\\text{mono}} = 2 \\times D_{0,\\text{dipole}} = 2 \\times 1.643 = \\mathbf{3.286 \\ (5.16\\text{ dBi})}}\n$$\n• **The Ground Plane Invariant:** A ground plane **halves the input resistance and doubles the directivity (+3 dB)** because all radiated energy is concentrated into the upper hemisphere!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate the radiation resistance and directivity of a quarter-wave monopole using Image Theory.",
      "orderItems": [
        "Replace the infinite PEC ground plane with a virtual mirror image monopole of equal length in the lower hemisphere",
        "Formulate the equivalent full half-wave dipole in free space carrying identical peak feed current I0",
        "Recognize that radiated field E(theta, phi) in the upper hemisphere is identical to the free-space dipole",
        "Integrate radiation intensity over the upper 2*pi hemisphere to find that radiated power is halved: P_rad,mono = 0.5 * P_rad,dipole",
        "Calculate monopole input radiation resistance: R_rad = 73.13 / 2 = 36.56 \u03a9 and directivity: D0 = 2 * 1.643 = 3.286 (5.16 dBi)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Wire Antenna Configuration to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Half-Wave Dipole (l = \u03bb/2)", "right": "Rrad \u2248 73.13 \u03a9, D0 = 1.643 (2.15 dBi), donut radiation pattern in free space" },
        { "left": "Quarter-Wave Monopole (l = \u03bb/4)", "right": "Rrad \u2248 36.56 \u03a9, D0 = 3.286 (5.16 dBi), radiating into upper 2\u03c0 hemisphere over ground" },
        { "left": "Infinitesimal Hertzian Dipole", "right": "Rrad = 80*\u03c0^2*(l/\u03bb)^2, D0 = 1.50 (1.76 dBi), electrically short wire antenna" },
        { "left": "Ground Plane Directivity Boost", "right": "+3.01 dB (2x factor) directivity increase from geometric hemispherical power confinement" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The theoretical radiation resistance of a center-fed resonant half-wave dipole in free space is approximately ___ ohms.",
      "blankAnswer": "73",
      "blankDistractors": ["50", "377", "120"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A quarter-wave monopole antenna (l = \u03bb/4) is mounted on a vehicular metal roof (ideal PEC ground plane). Driven by feed current peak amplitude I0 = 2.0 A, what is the total radiated power P_rad and the directivity D0 of the monopole?",
      "options": [
        { "text": "P_rad = 73.13 W and D0 = 5.16 dBi (R_rad = 73.13 / 2 = 36.565 \u03a9, P_rad = 0.5 * (2.0 A)^2 * 36.565 \u03a9 = 73.13 W, and D0 = 2 * 1.643 = 3.286 \u2192 5.16 dBi)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Image Theory and wire antenna equations (Constantine Balanis *Antenna Theory* Chapter 4). 1. **Determine Monopole Radiation Resistance ($R_{\\text{rad}}$):** - By Image Theory, a quarter-wave monopole over PEC ground has **half the resistance of a half-wave dipole**: $$R_{\\text{rad}} = \\frac{R_{\\text{rad,dipole}}}{2} = \\frac{73.13\\,\\Omega}{2} = \\mathbf{36.565\\,\\Omega}$$ 2. **Calculate Radiated Power ($P_{\\text{rad}}$):** $$P_{\\text{rad}} = \\frac{1}{2} I_0^2 R_{\\text{rad}} = \\frac{1}{2} (2.0\\text{ A})^2 \\times (36.565\\,\\Omega) = \\frac{1}{2} (4.0) \\times 36.565 = \\mathbf{73.13\\text{ Watts}}$$ 3. **Calculate Monopole Directivity ($D_0$):** - The ground plane confines all energy into the upper hemisphere ($2\\pi$ steradians), doubling the directivity: $$D_0 = 2 \\times D_{0,\\text{dipole}} = 2 \\times 1.643 = \\mathbf{3.286}$$ - In decibels over isotropic: $$D_0\\text{(dBi)} = 10 \\log_{10}(3.286) = \\mathbf{5.16\\text{ dBi}}$$ - (Notice that $2.15\\text{ dBi} + 3.01\\text{ dB} = \\mathbf{5.16\\text{ dBi}}$)! Flawless monopole analysis!" },
        { "text": "P_rad = 146.26 W and D0 = 2.15 dBi", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_rad = 36.56 W and D0 = 1.76 dBi", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_rad = 73.13 W and D0 = 2.15 dBi", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
