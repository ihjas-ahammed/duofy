# Duofy Reusable Lesson Format: Nuclear Shell Model and Magic Numbers

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Nuclear_and_Particle_Physics / Nuclear_Structure_Radioactivity_and_Fission_Fusion`  
**Lesson Format Type:** `nuclear_shell_model_and_magic_numbers`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantum mechanics of nuclear single-particle levels: explain the origin of **Magic Numbers (2, 8, 20, 28, 50, 82, 126)**, formulate the **Woods-Saxon Potential** with strong attractive **Spin-Orbit Coupling ($\hat{V}_{SO} = -f(r)\mathbf{L}\cdot\mathbf{S}$)** (Maria Goeppert Mayer & J. Hans D. Jensen, 1949), calculate spin-orbit energy splittings $\Delta E_{SO} \propto (2\ell + 1)$, and predict ground-state nuclear spins and parities $J^P = j^\pi$ for odd-A nuclei using the **Extreme Single-Particle Shell Model**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nuclear Shell Model & Spin-Orbit Coupling Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Spin-Orbit Expectation Value Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Nucleus Isotope & Ground-State Spin-Parity J^P Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Highest Classical Nuclear Magic Number Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Origin of Magic Numbers 28, 50, 82, 126 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Nuclear Shell Model (Maria Goeppert Mayer & J. Hans D. Jensen, Nobel Prize 1963):
   - **Nuclear Magic Numbers:** Nuclei with $Z$ or $N = 2, 8, 20, 28, 50, 82, 126$ possess extraordinary binding stability, high first-excited state energies, and zero quadrupole moments (e.g. doubly-magic $^{4}\text{He}, ^{16}\text{O}, ^{40}\text{Ca}, ^{48}\text{Ca}, ^{208}\text{Pb}$).
   - **The Single-Particle Hamiltonian:**
     $$\hat{H} = -\frac{\hbar^2}{2m}\nabla^2 + V_{\text{WS}}(r) - f(r) \mathbf{L} \cdot \mathbf{S}$$
   - **The Woods-Saxon Potential:** $V_{\text{WS}}(r) = \frac{-V_0}{1 + e^{(r-R)/a}}$.
   - **Spin-Orbit Splitting:** Total angular momentum $\mathbf{j} = \mathbf{\ell} + \mathbf{s}$ splits each orbital $\ell$ into two subshells: $j = \ell + 1/2$ (shifted downward in energy by $-\frac{\hbar^2}{2}\ell$) and $j = \ell - 1/2$ (shifted upward by $+\frac{\hbar^2}{2}(\ell + 1)$).
   - **Subshell Capacity:** $2j + 1$ nucleons per $(n, \ell, j)$ level.
2. **Slide 2 (`ordering`):** Provide 5 steps calculating the spin-orbit expectation value $\langle \mathbf{L} \cdot \mathbf{S} \rangle$: (1) start with total angular momentum operator: $\mathbf{J} = \mathbf{L} + \mathbf{S}$, (2) square both sides: $\mathbf{J}^2 = \mathbf{L}^2 + \mathbf{S}^2 + 2 \mathbf{L} \cdot \mathbf{S}$, (3) isolate the scalar product: $\mathbf{L} \cdot \mathbf{S} = \frac{1}{2}(\mathbf{J}^2 - \mathbf{L}^2 - \mathbf{S}^2)$, (4) evaluate eigenvalue in coupled basis $|j, \ell, s\rangle$ with $s = 1/2$: $\langle \mathbf{L} \cdot \mathbf{S} \rangle = \frac{\hbar^2}{2} [j(j+1) - \ell(\ell+1) - 3/4]$, (5) for $j = \ell + 1/2$, find $\langle \mathbf{L}\cdot\mathbf{S}\rangle = +\frac{\hbar^2}{2}\ell$, while for $j = \ell - 1/2$, find $\langle \mathbf{L}\cdot\mathbf{S}\rangle = -\frac{\hbar^2}{2}(\ell + 1)$!
3. **Slide 3 (`matching`):** Pair 4 odd-A isotopes ($^{17}\text{O}$ (8 protons, 9 neutrons), $^{15}\text{N}$ (7 protons, 8 neutrons), $^{13}\text{C}$ (6 protons, 7 neutrons), $^{41}\text{Ca}$ (20 protons, 21 neutrons)) with their ground-state spin-parities ($5/2^+$ ($1d_{5/2}$), $1/2^-$ ($1p_{1/2}^{-1}$), $1/2^-$ ($1p_{1/2}$), $7/2^-$ ($1f_{7/2}$)).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the highest known magic number 126 (found in Lead-208 with N=126). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how spin-orbit coupling explains magic numbers: Why did simple 3D harmonic oscillator and square well potentials predict magic numbers 2, 8, 20, 40, 70, but FAIL to explain 28, 50, 82, 126? (Because strong attractive **Spin-Orbit Coupling ($\mathbf{L}\cdot\mathbf{S}$)** pushes the state with highest angular momentum and $j = \ell + 1/2$ (like $1f_{7/2}, 1g_{9/2}, 1h_{11/2}, 1i_{13/2}$) down into the shell below, creating large new energy gaps at exactly 28, 50, 82, and 126).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nuclear_shell_model_and_magic_numbers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Nuclear Shell Model and Magic Numbers**\n• **Nuclear Magic Numbers:** $2, 8, 20, 28, 50, 82, 126$ (closed shell stability).\n• **The Single-Particle Hamiltonian:**\n$$\n\\hat{H} = -\\frac{\\hbar^2}{2m}\\nabla^2 + V_{\\text{WS}}(r) - f(r) \\mathbf{L} \\cdot \\mathbf{S}\n$$\n• **Spin-Orbit Splitting (Mayer & Jensen, 1949):**\n  - For orbital $\\ell$, states split into $j = \\ell + 1/2$ and $j = \\ell - 1/2$.\n  - Subshell with $j = \\ell + 1/2$ is **lowered significantly in energy** by $-\\frac{\\hbar^2}{2}\\ell$, crossing into lower oscillator shells and opening large energy gaps at 28, 50, 82, and 126!\n• **Single-Particle Spin & Parity:** $J^P = j^\\pi$, where $\\pi = (-1)^\\ell$ for odd unpaired nucleon."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the quantum operator steps evaluating the spin-orbit expectation value <L . S>.",
      "orderItems": [
        "Express total angular momentum operator: J = L + S",
        "Square both sides of the vector operator: J^2 = L^2 + S^2 + 2 L . S",
        "Isolate the scalar product: L . S = (1/2) * (J^2 - L^2 - S^2)",
        "Act on coupled eigenstate |j, l, s> with s = 1/2 to extract eigenvalues: <L . S> = (hbar^2 / 2) * [ j(j+1) - l(l+1) - 3/4 ]",
        "Substitute j = l + 1/2 to find positive shift +(hbar^2 / 2) * l (which lowers energy due to negative potential prefactor -f(r))"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each odd-A isotope to its ground-state spin and parity J^P from the shell model.",
      "matchPairs": [
        { "left": "Oxygen-17 (8 protons, 9 neutrons)", "right": "5/2+ (unpaired 9th neutron in 1d_5/2 orbital, l=2 => parity +)" },
        { "left": "Nitrogen-15 (7 protons, 8 neutrons)", "right": "1/2- (proton hole in 1p_1/2 orbital, l=1 => parity -)" },
        { "left": "Calcium-41 (20 protons, 21 neutrons)", "right": "7/2- (unpaired 21st neutron in 1f_7/2 orbital, l=3 => parity -)" },
        { "left": "Lead-208 (82 protons, 126 neutrons)", "right": "0+ (doubly magic even-even nucleus, all nucleons paired to J=0)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The highest classic experimental nuclear magic number (exhibited by the 126 neutrons in Lead-208) is ___.",
      "blankAnswer": "126",
      "blankDistractors": ["82", "50", "184"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did the 3D Harmonic Oscillator fail to predict the magic numbers 28, 50, 82, and 126 until Mayer and Jensen introduced Spin-Orbit coupling?",
      "options": [
        { "text": "Harmonic oscillator energy shells have degeneracies at 2, 8, 20, 40, 70; strong attractive SPIN-ORBIT COUPLING (-V_so L·S) lowers the highest-j state (e.g. 1f_7/2, 1g_9/2, 1h_11/2) into the lower shell, creating the real physical gaps at 28, 50, 82, and 126", "isCorrect": true, "explanation": "Correct! Without spin-orbit coupling, the gaps occur at harmonic oscillator levels (2, 8, 20, 40...). The strong spin-orbit force depresses states with j = l + 1/2 by an amount proportional to (2l+1), shifting them across major oscillator shells and opening the true observed nuclear magic gaps." },
        { "text": "Because neutrons do not have mass", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because harmonic oscillators only work in one dimension", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because nuclei have zero spin", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
