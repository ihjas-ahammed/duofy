# Duofy Reusable Lesson Format: Fermi Energy and Sommerfeld Free Electron Gas

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Thermodynamics_and_Statistical_Physics / Quantum_Statistics_Fermi_Dirac_Bose_Einstein`  
**Lesson Format Type:** `fermi_energy_and_sommerfeld_free_electron_gas`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantum mechanics of degenerate electron gases: formulate the 3D density of states $g(\epsilon) = \frac{V}{2\pi^2}\left(\frac{2m}{\hbar^2}\right)^{3/2}\sqrt{\epsilon}$, derive the **Fermi Energy ($E_F = \frac{\hbar^2}{2m}(3\pi^2 n)^{2/3}$)**, **Fermi Wavevector ($k_F = (3\pi^2 n)^{1/3}$)**, and **Fermi Temperature ($T_F = E_F/k_B$)**, calculate total ground-state energy $U_0 = \frac{3}{5} N E_F$ and quantum degeneracy pressure $P_0 = \frac{2}{5} n E_F$, apply the **Sommerfeld Expansion** to prove that only electrons within $\sim k_B T$ of the Fermi surface contribute to thermal excitation, and derive the linear **Electronic Heat Capacity ($C_V = \frac{\pi^2}{2} N k_B \frac{T}{T_F}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fermi Sphere & Sommerfeld Gas Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fermi Energy Integral Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Electron Gas Parameter & Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Total Ground State Energy Fractional Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Classical Dulong-Petit Failure and Linear Electronic Heat Capacity Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Sommerfeld Free Electron Theory of Metals (Arnold Sommerfeld, 1928):
   - **3D Density of States ($g_s = 2$ for spin-1/2 electrons):**
     $$g(\epsilon) = \frac{V}{2\pi^2} \left(\frac{2m}{\hbar^2}\right)^{3/2} \sqrt{\epsilon}$$
   - **Fermi Parameters at $T = 0\text{ K}$:**
     $$k_F = (3\pi^2 n)^{1/3}, \qquad E_F = \frac{\hbar^2 k_F^2}{2m} = \frac{\hbar^2}{2m} (3\pi^2 n)^{2/3}, \qquad T_F = \frac{E_F}{k_B}$$
   - **Total Ground State Energy & Degeneracy Pressure:**
     $$U_0 = \int_0^{E_F} \epsilon \, g(\epsilon) \, d\epsilon = \frac{3}{5} N E_F, \qquad P_0 = -\left(\frac{\partial U_0}{\partial V}\right)_N = \frac{2}{3} \frac{U_0}{V} = \frac{2}{5} n E_F$$
   - **Electronic Heat Capacity ($T \ll T_F \sim 50,000\text{ K}$):**
     $$C_{\text{el}} = \frac{\pi^2}{2} N k_B \left( \frac{T}{T_F} \right) = \gamma T \qquad (\text{Linear in } T!).$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving $E_F = \frac{\hbar^2}{2m}(3\pi^2 n)^{2/3}$: (1) set up the total particle count integral at $T = 0$: $N = \int_0^{E_F} g(\epsilon) d\epsilon$, (2) substitute density of states $g(\epsilon) = \frac{V}{2\pi^2}\left(\frac{2m}{\hbar^2}\right)^{3/2}\epsilon^{1/2}$: $N = \frac{V}{2\pi^2}\left(\frac{2m}{\hbar^2}\right)^{3/2} \int_0^{E_F} \epsilon^{1/2} d\epsilon$, (3) evaluate the power integral: $\int_0^{E_F} \epsilon^{1/2} d\epsilon = \frac{2}{3} E_F^{3/2}$, (4) simplify the particle density $n = N/V = \frac{1}{3\pi^2}\left(\frac{2m}{\hbar^2}\right)^{3/2} E_F^{3/2}$, (5) invert the equation to solve for Fermi energy: $E_F = \frac{\hbar^2}{2m}(3\pi^2 n)^{2/3}$!
3. **Slide 3 (`matching`):** Pair 4 electron gas quantities ($E_F$, $k_F$, $U_0$, $C_{\text{el}}$) with their algebraic expressions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the total ground-state energy U_0 of an ideal 3D Fermi gas is 3/5 * N * E_F. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why classical physics failed to explain the heat capacity of metals: Classical equipartition predicted that free conduction electrons would contribute $\frac{3}{2} k_B$ per electron to heat capacity (vastly overestimating experiment at room temperature). Why does the quantum Sommerfeld model predict a much smaller, linear heat capacity $C_{\text{el}} \propto T$? (Because the Pauli exclusion principle freezes all electrons deep in the Fermi sea; ONLY the tiny fraction of electrons within a thermal energy window $\sim k_B T$ of the Fermi surface ($\frac{T}{T_F} \sim \frac{300\text{ K}}{50,000\text{ K}} \approx 0.006 \approx 0.6\%$) can be thermally excited into unoccupied states).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fermi_energy_and_sommerfeld_free_electron_gas",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fermi Energy and the Sommerfeld Free Electron Gas**\n• **Fermi Parameters ($T = 0\\text{ K}$):**\n$$\nk_F = (3\\pi^2 n)^{1/3}, \\qquad E_F = \\frac{\\hbar^2}{2m} (3\\pi^2 n)^{2/3}, \\qquad T_F \\equiv \\frac{E_F}{k_B}\n$$\n• **Ground-State Energy & Degeneracy Pressure:**\n$$\nU_0 = \\frac{3}{5} N E_F, \\qquad P_0 = \\frac{2}{5} n E_F = \\frac{2}{3} \\frac{U_0}{V}\n$$\n  *(A Fermi gas exerts massive quantum degeneracy pressure even at absolute zero!).*\n• **Electronic Heat Capacity ($T \\ll T_F$):**\n$$\nC_{\\text{el}} = \\frac{\\pi^2}{2} N k_B \\left( \\frac{T}{T_F} \\right) = \\gamma T\n$$\n  *(Only electrons within a thermal band $\\sim k_B T$ around $E_F$ participate in excitation!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the density of states integral steps deriving the Fermi energy E_F = (hbar^2 / 2m) * (3 pi^2 n)^(2/3).",
      "orderItems": [
        "Set up the total particle count integral at absolute zero: N = int_0^{E_F} g(epsilon) d(epsilon)",
        "Substitute the 3D density of states for spin-1/2 electrons: g(epsilon) = (V / [2 pi^2]) * (2m / hbar^2)^(3/2) * sqrt(epsilon)",
        "Perform the definite integration: int_0^{E_F} sqrt(epsilon) d(epsilon) = (2/3) * E_F^(3/2)",
        "Equate total particle density: n = N/V = (1 / [3 pi^2]) * (2m / hbar^2)^(3/2) * E_F^(3/2)",
        "Invert the algebraic expression to solve for the Fermi energy: E_F = (hbar^2 / 2m) * (3 pi^2 n)^(2/3)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each degenerate Fermi gas property to its mathematical formula.",
      "matchPairs": [
        { "left": "Fermi Wavevector k_F", "right": "(3 * pi^2 * n)^(1/3)" },
        { "left": "Ground State Total Energy U_0", "right": "(3/5) * N * E_F" },
        { "left": "Quantum Degeneracy Pressure P_0", "right": "(2/5) * n * E_F = (2/3) * (U_0 / V)" },
        { "left": "Sommerfeld Electronic Heat Capacity", "right": "(pi^2 / 2) * N * k_B * (T / T_F) (linear in temperature T)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The average energy per electron in a 3D degenerate Fermi gas at 0 Kelvin is ___ / 5 * E_F.",
      "blankAnswer": "3",
      "blankDistractors": ["1", "2", "4"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the electronic heat capacity of metals at room temperature ~100 times smaller than the classical prediction of (3/2) N k_B?",
      "options": [
        { "text": "Because the Pauli exclusion principle freezes all electrons deep below the Fermi surface; ONLY the tiny fraction of electrons within a thermal energy slice ~k_B T around E_F (a fraction T / T_F ≈ 300 K / 50,000 K ≈ 0.6%) can absorb heat and jump into unoccupied states", "isCorrect": true, "explanation": "Correct! Below E_F - k_B T, all quantum states are 100% occupied, preventing electrons from accepting small thermal energy packets. Only electrons within ~k_B T of the Fermi surface have nearby empty states to scatter into, suppressing heat capacity by a factor of (T / T_F)." },
        { "text": "Because electrons do not possess mass", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because metals are insulators at room temperature", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because electrons cannot absorb photons", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
