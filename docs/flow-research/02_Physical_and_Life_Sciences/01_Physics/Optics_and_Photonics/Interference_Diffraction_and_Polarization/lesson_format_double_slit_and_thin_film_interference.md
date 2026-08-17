# Duofy Reusable Lesson Format: Double-Slit and Thin-Film Interference

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Optics_and_Photonics / Interference_Diffraction_and_Polarization`  
**Lesson Format Type:** `double_slit_and_thin_film_interference`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the wave superposition of coherent light: derive **Young's Double-Slit Equation ($d\sin\theta = m\lambda$)**, compute fringe spacing $\beta = \frac{\lambda D}{d}$, evaluate the intensity profile $I(\theta) = I_0 \cos^2\left(\frac{\pi d\sin\theta}{\lambda}\right)$, analyze **Thin-Film Interference (Newton's Rings, Soap Bubbles)** with $\pi$ reflection phase shifts, and calculate minimum thicknesses for **Anti-Reflective Coatings ($t = \frac{\lambda_0}{4n_{\text{film}}}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Double-Slit & Thin-Film Superposition Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Anti-Reflective Coating Thickness Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Interference Condition & Optical Path Difference Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Quarter-Wave Anti-Reflective Film Thickness Denominator Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Phase Shift on Reflection at Denser Optical Boundary Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Coherent Wave Superposition Principles (Thomas Young, 1801):
   - **Young's Double Slit (Separation $d$, screen distance $D \gg d$):**
     - **Path Difference:** $\Delta = d\sin\theta \approx d \frac{y}{D}$.
     - **Bright Fringes (Constructive):** $d\sin\theta = m\lambda \implies y_m = m \frac{\lambda D}{d}$ ($m = 0, \pm 1, \pm 2, \dots$).
     - **Fringe Width:** $\beta = \frac{\lambda D}{d}$.
     - **Intensity Distribution:** $I(\theta) = 4 I_1 \cos^2\left(\frac{\pi d\sin\theta}{\lambda}\right)$.
   - **Thin-Film Interference (Thickness $t$, index $n$):**
     - Optical Path Difference: $\Delta = 2 n t \cos\theta_t \pm \frac{\lambda_0}{2}$ (if one ray reflects from a denser medium with higher index $n_2 > n_1$, it undergoes a $\pi$ phase shift / $\lambda_0/2$ path addition).
     - **Anti-Reflective Coating Condition (Air $n_0=1 \to$ Film $n_1 \to$ Glass $n_2 > n_1$):** Both reflections have $\pi$ shifts; destructive cancellation occurs when $2 n_1 t = \frac{\lambda_0}{2} \implies t_{\text{min}} = \frac{\lambda_0}{4 n_1}$.
2. **Slide 2 (`ordering`):** Provide 5 steps finding optimal anti-reflective coating thickness: (1) light hits air-film boundary ($n_{\text{air}} < n_{\text{film}}$), reflecting ray 1 with $\pi$ phase shift ($\lambda_0/2$), (2) light hits film-glass boundary ($n_{\text{film}} < n_{\text{glass}}$), reflecting ray 2 also with $\pi$ phase shift ($\lambda_0/2$), (3) since both reflections experience identical $\pi$ phase shifts, their relative reflection phase difference is zero ($\Delta\phi_{\text{refl}} = 0$), (4) destructive interference between the two rays requires the round-trip optical path difference to be an odd half-wavelength: $2 n_{\text{film}} t = \frac{\lambda_0}{2}$, (5) solve for minimum coating thickness: $t = \frac{\lambda_0}{4 n_{\text{film}}}$ (Quarter-wave coating!)!
3. **Slide 3 (`matching`):** Pair 4 interference systems (Young's Double Slit, Thin Soap Bubble in Air, Anti-Reflective Coated Lens, Michelson Mirror Displacement $\Delta d$) with their constructive/destructive condition formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the minimum thickness of a quarter-wave anti-reflective coating is lambda_0 / (4 * n). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the reflection phase shift: When light traveling in air ($n_1 = 1.0$) reflects off the surface of glass ($n_2 = 1.5$), what phase change does the reflected electric field undergo? (A phase shift of EXACTLY $\pi$ radians ($180^\circ$), equivalent to adding an optical path length of $\lambda_0 / 2$, because reflection at an interface with higher optical refractive index ($n_2 > n_1$) acts like a wave reflecting off a fixed boundary).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "double_slit_and_thin_film_interference",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Double-Slit and Thin-Film Wave Interference**\n• **Young's Double-Slit Experiment (Thomas Young, 1801):**\n  - **Bright Fringes (Constructive):** $d\\sin\\theta = m\\lambda \\implies y_m = m \\frac{\\lambda D}{d}$.\n  - **Fringe Spacing:** $\\beta = \\frac{\\lambda D}{d}$.\n  - **Intensity Profile:** $I(\\theta) = I_0 \\cos^2\\left(\\frac{\\pi d \\sin\\theta}{\\lambda}\\right)$.\n• **Thin-Film Interference (Film Thickness $t$, Index $n$):**\n$$\n\\text{Optical Path Difference: } \\Delta = 2 n t \\cos\\theta_t \\pm \\frac{\\lambda_0}{2} \\quad (\\text{if 1 reflection has } \\pi \\text{ shift})\n$$\n• **Quarter-Wave Anti-Reflective Coating:** $t_{\\text{min}} = \\frac{\\lambda_0}{4 n_{\\text{film}}}$ (for $n_{\\text{air}} < n_{\\text{film}} < n_{\\text{glass}}$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the optical wave steps deriving the minimum thickness of an anti-reflective coating t = lambda_0 / (4 n_film).",
      "orderItems": [
        "Light reflects at air-to-film interface (n_air < n_film), gaining a phase shift of pi (half-wavelength lambda_0 / 2)",
        "Transmitted light reflects at film-to-glass interface (n_film < n_glass), also gaining a phase shift of pi",
        "Observe that both reflections experience identical pi phase shifts, so the net reflection phase shift difference is zero",
        "Set the optical path difference 2 * n_film * t equal to an odd half-wavelength lambda_0 / 2 for total destructive interference",
        "Solve for the minimum film thickness to find the quarter-wave layer: t = lambda_0 / (4 * n_film)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each interference system to its path condition.",
      "matchPairs": [
        { "left": "Young's Double Slit Bright Fringe", "right": "d * sin(theta) = m * lambda" },
        { "left": "Young's Double Slit Dark Fringe", "right": "d * sin(theta) = (m + 1/2) * lambda" },
        { "left": "Quarter-Wave Optical Coating", "right": "t = lambda_0 / (4 * n_film) (destructively cancels reflected light)" },
        { "left": "Michelson Interferometer Fringe Shift", "right": "Moving one mirror by Delta d shifts 2 * Delta d / lambda fringes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The minimum thickness of a destructive anti-reflective optical coating is t = lambda_0 / (___ * n_film).",
      "blankAnswer": "4",
      "blankDistractors": ["2", "1", "8"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What phase change occurs when light traveling through air (n = 1.0) reflects from the surface of a glass lens (n = 1.5)?",
      "options": [
        { "text": "A phase shift of EXACTLY pi radians (180°), equivalent to adding an optical path length of lambda_0 / 2, because reflection from a medium with higher refractive index (denser) acts like a wave on a string reflecting off a rigid boundary", "isCorrect": true, "explanation": "Correct! By Fresnel equations (or fixed-end boundary mechanics), whenever light reflects from a medium of higher refractive index (n_2 > n_1), the reflected electric field flips sign, acquiring an instantaneous pi phase change." },
        { "text": "Zero phase change (0 radians)", "isCorrect": false, "explanation": "Incorrect: True only when reflecting from a lower index medium (n_2 < n_1)." },
        { "text": "A phase shift of pi/2 radians (90°)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A phase shift of 2*pi radians", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
