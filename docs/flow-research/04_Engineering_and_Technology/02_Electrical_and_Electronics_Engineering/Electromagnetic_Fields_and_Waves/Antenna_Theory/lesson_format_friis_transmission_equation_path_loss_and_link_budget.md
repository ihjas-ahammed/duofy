# Duofy Reusable Lesson Format: Wireless Link Budgets (Friis Equation & Free-Space Path Loss)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electromagnetic_Fields_and_Waves / Antenna_Theory`  
**Lesson Format Type:** `friis_transmission_equation_path_loss_and_link_budget`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through electromagnetic power propagation in free space, transmitting power density, receiving effective aperture, Free-Space Path Loss ($\text{FSPL}$), and the Friis Transmission Equation for wireless telecommunication link budgets (Harald T. Friis 1946; Constantine A. Balanis *Antenna Theory* Chapter 2; Theodore S. Rappaport *Wireless Communications: Principles and Practice* Chapter 3): derive the **Friis Transmission Equation**:
$$\mathbf{\frac{P_r}{P_t} = G_t \cdot G_r \left( \frac{\lambda}{4\pi R} \right)^2 = \frac{P_t G_t A_{e,r}}{4\pi R^2} = \frac{A_{e,t} A_{e,r}}{\lambda^2 R^2}}$$
where $P_t$ is transmit power, $G_t$ and $G_r$ are dimensionless antenna power gains, $\lambda$ is free-space wavelength, and $R$ is transmission separation distance; derive the **Decibel (dBm / dB) Link Budget Master Equation**:
$$\mathbf{P_r\text{(dBm)} = P_t\text{(dBm)} + G_t\text{(dBi)} + G_r\text{(dBi)} - \mathbf{\text{FSPL(dB)}}}$$
where **Free-Space Path Loss ($\text{FSPL}$)** is:
$$\mathbf{\text{FSPL(dB)} = 20\log_{10}\left(\frac{4\pi R}{\lambda}\right) = 20\log_{10}(R) + 20\log_{10}(f) + 20\log_{10}\left(\frac{4\pi}{c}\right)}$$
(proving why higher carrier frequencies suffer greater free-space path loss for fixed-gain antennas due to smaller physical effective aperture $A_e \propto \lambda^2$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Friis Formula ($\frac{P_r}{P_t} = G_t G_r (\frac{\lambda}{4\pi R})^2$), FSPL & Link Budget Decibels Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Received Power in a Wireless Satellite Link Budget Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Link Budget Parameter / Power Metric & Technical Communication Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Natural Geometric Attenuation of Electromagnetic Power Spreading Spherically Over Distance Is Free-Space Path ___ (Loss / FSPL) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Satellite Communication Link Budget Problem: Calculating Received Power Pr in dBm at 2.4 GHz Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Friis Equation & Path Loss (Friis 1946; Balanis 2016; Rappaport 2002):
   - **Friis Transmission Formulations:**
     $$\mathbf{\frac{P_r}{P_t} = G_t G_r \left(\frac{\lambda}{4\pi R}\right)^2 \quad \Big| \quad P_r\text{(dBm)} = P_t\text{(dBm)} + G_t\text{(dBi)} + G_r\text{(dBi)} - \text{FSPL(dB)}}$$
   - **FSPL Formulations:**
     $$\mathbf{\text{FSPL} = \left(\frac{4\pi R}{\lambda}\right)^2 \Longleftrightarrow \mathbf{\text{FSPL(dB)} = 32.44 + 20\log_{10}(R\text{[km]}) + 20\log_{10}(f\text{[MHz]})}}$$
   - **The Inverse-Square Invariant:** Doubling the propagation distance $R \to 2R$ adds **strictly $+6.02\text{ dB}$ of path loss** ($20\log_{10}(2) \approx 6.02\text{ dB}$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of wireless link budget evaluation: (1) convert transmitter power from Watts to dBm ($P_t\text{(dBm)} = 10\log_{10}(P_t / 1\text{ mW})$), (2) calculate wavelength $\lambda = c / f$ and determine link distance $R$, (3) compute Free-Space Path Loss $\text{FSPL(dB)} = 20\log_{10}\left(\frac{4\pi R}{\lambda}\right)$, (4) sum transmitter power, antenna gains $G_t, G_r$, and subtract cable losses and path loss to find $P_r\text{(dBm)}$, (5) compare received power $P_r$ against receiver sensitivity threshold to ensure link margin $> 10\text{ dB}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Friis Formula, Free-Space Path Loss FSPL, EIRP $P_t G_t$, Receiver Sensitivity) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Loss (or FSPL). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating received power via link budget: A Wi-Fi 2.4 GHz link ($f = 2.4\text{ GHz} = 2400\text{ MHz}$, $\lambda = 0.125\text{ m}$) transmits over distance $R = 100\text{ meters}$. The transmitter outputs power $P_t = 100\text{ mW} = \mathbf{+20.0\text{ dBm}}$ through a transmit antenna with gain $G_t = 3.0\text{ dBi}$. The receiver antenna has gain $G_r = 3.0\text{ dBi}$. What is the Free-Space Path Loss $\text{FSPL}$ in dB, and what is the received power $P_r$ in dBm? ($\text{FSPL} = 20\log_{10}\left(\frac{4\pi(100)}{0.125}\right) = 20\log_{10}\left(\frac{1256.637}{0.125}\right) = 20\log_{10}(10,053.1) \approx 20(4.0023) = \mathbf{80.05\text{ dB} \approx 80.0\text{ dB}}$; $P_r\text{(dBm)} = P_t + G_t + G_r - \text{FSPL} = 20.0 + 3.0 + 3.0 - 80.05 = \mathbf{-54.05\text{ dBm} \approx -54.0\text{ dBm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "friis_transmission_equation_path_loss_and_link_budget",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Friis Transmission \\& Free-Space Link Budgets (Harald T. Friis 1946)**\n• **The Friis Transmission Formulation:**\n$$\n\\mathbf{\\frac{P_r}{P_t} = G_t \\cdot G_r \\left( \\frac{\\lambda}{4\\pi R} \\right)^2 = \\frac{P_t G_t A_{e,r}}{4\\pi R^2} \\quad \\left(\\text{EIRP} = P_t G_t\\right)}\n$$\n• **Decibel Link Budget Master Equation:**\n$$\n\\mathbf{P_r\\text{(dBm)} = P_t\\text{(dBm)} + G_t\\text{(dBi)} + G_r\\text{(dBi)} - \\mathbf{\\text{FSPL(dB)}}}\n$$\n• **Free-Space Path Loss (FSPL):**\n$$\n\\mathbf{\\text{FSPL(dB)} = 20\\log_{10}\\left(\\frac{4\\pi R}{\\lambda}\\right) = 32.44 + 20\\log_{10}(R\\text{[km]}) + 20\\log_{10}(f\\text{[MHz]})}\n$$\n• **The 6-dB Doubling Invariant:** Doubling the distance $R \\to 2R$ adds **strictly $+6.02\\text{ dB}$ of path loss**, reducing received power by **75\\% (factor of 4)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the received power and link margin of a wireless communication system.",
      "orderItems": [
        "Convert transmitter power from Watts to decibels-milliwatts: Pt(dBm) = 10 * log10(Pt / 1mW)",
        "Determine the signal carrier frequency f and calculate the free-space wavelength: lambda = c / f",
        "Compute the Free-Space Path Loss across distance R: FSPL(dB) = 20 * log10(4*pi*R / lambda)",
        "Sum transmitter power and antenna gains and subtract path loss: Pr(dBm) = Pt(dBm) + Gt(dBi) + Gr(dBi) - FSPL(dB)",
        "Compare received power Pr against receiver sensitivity to verify positive link margin (Margin = Pr - P_sensitivity >= 10 dB)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Wireless Link Budget Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Friis Formula", "right": "Pr/Pt = Gt*Gr*(\u03bb / 4\u03c0R)^2, fundamental equation governing free-space power transmission" },
        { "left": "Free-Space Path Loss (FSPL)", "right": "Geometric attenuation resulting from spherical spreading of electromagnetic wave power" },
        { "left": "EIRP (Equivalent Isotropic Radiated Power)", "right": "EIRP = Pt * Gt, effective apparent power radiated by transmitter in the peak direction" },
        { "left": "Link Margin", "right": "Safety buffer (Pr - P_sensitivity) ensuring reliable link operation against fading" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The geometric attenuation of electromagnetic power spreading spherically across space is Free-Space Path ___.",
      "blankAnswer": "loss",
      "blankDistractors": ["gain", "impedance", "reflection"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2.4 GHz Wi-Fi link (\u03bb = 0.125 m) operates over distance R = 100 m. The transmitter produces Pt = 100 mW (+20.0 dBm) with Gt = 3.0 dBi. The receiver antenna has gain Gr = 3.0 dBi. What is the Free-Space Path Loss FSPL and the received power Pr in dBm?",
      "options": [
        { "text": "FSPL = 80.05 dB (~80.0 dB) and Pr = -54.05 dBm (~-54.0 dBm) (FSPL = 20*log10(4*\u03c0*100 / 0.125) = 80.05 dB; Pr = +20.0 dBm + 3.0 dBi + 3.0 dBi - 80.05 dB = -54.05 dBm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Friis Transmission Equation and link budget decibels (Harald Friis 1946; Constantine Balanis *Antenna Theory* Chapter 2). 1. **Calculate Free-Space Path Loss (FSPL):** $$\\text{FSPL} = \\left( \\frac{4\\pi R}{\\lambda} \\right)^2 = \\left( \\frac{4\\pi \\times 100\\text{ m}}{0.125\\text{ m}} \\right)^2 = \\left( \\frac{1256.637}{0.125} \\right)^2 = (10,053.096)^2$$ $$\\text{FSPL(dB)} = 20 \\log_{10}(10,053.096) = 20 \\times 4.0023 = \\mathbf{80.046\\text{ dB} \\approx 80.05\\text{ dB}}$$ 2. **Calculate Received Power ($P_r$) via Link Budget:** $$P_r\\text{(dBm)} = P_t\\text{(dBm)} + G_t\\text{(dBi)} + G_r\\text{(dBi)} - \\text{FSPL(dB)}$$ $$P_r\\text{(dBm)} = +20.0\\text{ dBm} + 3.0\\text{ dBi} + 3.0\\text{ dBi} - 80.05\\text{ dB} = 26.0 - 80.05 = \\mathbf{-54.05\\text{ dBm}}$$ 3. **Receiver Sensitivity Verification:** - Standard Wi-Fi receivers have a sensitivity threshold of $-85\\text{ dBm}$. - Link Margin $= -54.05\\text{ dBm} - (-85.0\\text{ dBm}) = \\mathbf{+30.95\\text{ dB}}$, ensuring an ultra-reliable, high-throughput wireless link!" },
        { "text": "FSPL = 60.00 dB and Pr = -34.00 dBm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FSPL = 100.00 dB and Pr = -74.00 dBm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FSPL = 80.05 dB and Pr = +54.05 dBm (Sign error)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
