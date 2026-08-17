# Duofy Reusable Lesson Format: Spectrochemical Series and Spin States

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Coordination_Chemistry_and_Crystal_Field_Theory`  
**Lesson Format Type:** `spectrochemical_series_and_spin_states`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular orbital foundations and empirical hierarchy of ligand field strength: arrange ligands across the **Spectrochemical Series ($\text{I}^- < \text{Br}^- < \text{Cl}^- < \text{F}^- < \text{OH}^- < \text{H}_2\text{O} < \text{NH}_3 < \text{en} < \text{NO}_2^- < \text{CN}^- \approx \text{CO}$)**, classify ligands as **$\pi$-Donors (halides, small $\Delta_o$)**, **$\sigma$-Only Donors ($\text{NH}_3$)**, and **$\pi$-Acceptors ($\text{CO}, \text{CN}^-$, huge $\Delta_o$ via backbonding)**, evaluate the criterion for **High-Spin vs Low-Spin ($\Delta_o < P$ vs $\Delta_o > P$)**, and predict optical absorption wavelengths ($\Delta E = h\nu = \frac{hc}{\lambda} = \Delta_o$) and complementary visible colors.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Spectrochemical Series & MO Pi-Backbonding Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Ligand Field Strength Ranking Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Ligand Type & Molecular Orbital Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Maximum Ligand Field Splitting Pi-Acceptor Ligand Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Co(III) d6 Complex Color Shift from Water to Cyanide Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Spectrochemical Series & Ligand Field Theory (LFT):
   - **The Spectrochemical Series (Order of Increasing $\Delta_o$):**
     $$\text{I}^- < \text{Br}^- < \text{S}^{2-} < \text{Cl}^- < \text{F}^- < \text{OH}^- < \text{H}_2\text{O} < \text{NCS}^- < \text{NH}_3 < \text{en} < \text{bpy} < \text{NO}_2^- < \text{CN}^- \approx \text{CO}$$
   - **Molecular Orbital Foundations of Ligand Field Strength:**
     - **$\pi$-Donor Ligands (Halides, $\text{OH}^-, \text{H}_2\text{O}$):** Filled $p_\pi$ orbitals donate into metal $t_{2g}$, making $t_{2g}$ antibonding ($t_{2g}^*$) and raising its energy $\implies$ **decreases $\Delta_o$** (Weak Field, High-Spin!).
     - **$\sigma$-Only Donors ($\text{NH}_3, \text{en}$):** No $\pi$-symmetry orbitals $\implies$ intermediate $\Delta_o$.
     - **$\pi$-Acceptor Ligands ($\text{CO}, \text{CN}^-, \text{NO}^+$):** Empty $\pi^*$ antibonding orbitals receive electron density from metal $t_{2g}$ via **$\pi$-backbonding**, stabilizing $t_{2g}$ energetically $\implies$ **drastically increases $\Delta_o$** (Strong Field, Low-Spin!).
   - **High-Spin vs Low-Spin Criterion ($d^4-d^7$):**
     - $\Delta_o < P \implies$ **High-Spin** (Hund's rule favored).
     - $\Delta_o > P \implies$ **Low-Spin** (Aufbau pairing favored).
   - **Optical Color Connection:** Absorbed photon energy $\Delta E = \frac{hc}{\lambda_{\text{abs}}} = \Delta_o$.
2. **Slide 2 (`ordering`):** Provide 5 steps ranking common ligands in order of increasing crystal field splitting $\Delta_o$ (from weakest field $\pi$-donor to strongest field $\pi$-acceptor): (1) Iodide $\text{I}^-$ (weakest field $\pi$-donor, smallest $\Delta_o$), (2) Chloride $\text{Cl}^-$ (moderate $\pi$-donor halide), (3) Water $\text{H}_2\text{O}$ (weak $\pi$-donor, boundary field), (4) Ammonia $\text{NH}_3$ (pure $\sigma$-donor, intermediate field), (5) Carbon monoxide $\text{CO}$ / Cyanide $\text{CN}^-$ (strongest $\pi$-acceptor, maximum $\Delta_o$)!
3. **Slide 3 (`matching`):** Pair 4 ligands ($\text{Cl}^-$, $\text{NH}_3$, $\text{CO}$, $\text{en}$) with their electronic classification and effect on $\Delta_o$ ($\pi$-Donor / decreases $\Delta_o$, $\sigma$-Only donor / intermediate $\Delta_o$, $\pi$-Acceptor / maximizes $\Delta_o$ via backbonding, Bidentate chelating $\sigma$-donor).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that pi-acceptor ligands like carbon monoxide and cyanide produce the largest crystal field splitting Delta_o via pi-backbonding. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on optical absorption shifts: An octahedral cobalt(III) complex $[\text{Co}(\text{H}_2\text{O})_6]^{3+}$ absorbs red light ($\lambda \approx 650\text{ nm}$) and appears blue. When all water ligands are replaced by strong-field cyanide to form $[\text{Co}(\text{CN})_6]^{3-}$, what happens to the absorbed light wavelength $\lambda_{\text{abs}}$ and the complex's appearance? ($\lambda_{\text{abs}}$ drops to the deep UV/violet ($\lambda < 380\text{ nm}$); because $\text{CN}^-$ creates a huge $\Delta_o$, the energy gap $\Delta E = \frac{hc}{\lambda}$ is much larger, shifting absorption to very short wavelengths, making the complex appear pale yellow or colorless).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "spectrochemical_series_and_spin_states",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Spectrochemical Series and Ligand Field Theory**\n• **The Spectrochemical Series (Increasing $\\Delta_o$):**\n$$\n\\text{I}^- < \\text{Br}^- < \\text{Cl}^- < \\text{F}^- < \\text{OH}^- < \\text{H}_2\\text{O} < \\text{NH}_3 < \\text{en} < \\text{NO}_2^- < \\text{CN}^- \\approx \\text{CO}\n$$\n• **Molecular Orbital $\\pi$-Interaction Origin:**\n  - **$\\pi$-Donor Ligands (Halides, $\\text{OH}^-$):** Filled $p_\\pi$ orbitals raise metal $t_{2g}^* \\implies$ **Shrinks $\\Delta_o$** (Weak Field, High-Spin).\n  - **$\\sigma$-Only Donors ($\\text{NH}_3, \\text{en}$):** Intermediate $\\Delta_o$.\n  - **$\\pi$-Acceptor Ligands ($\\text{CO}, \\text{CN}^-$):** Empty $\\pi^*$ orbitals accept metal $d$-electrons ($\\pi$-backbonding), stabilizing $t_{2g} \\implies$ **Maximizes $\\Delta_o$** (Strong Field, Low-Spin).\n• **High-Spin vs Low-Spin Criterion ($d^4 - d^7$):**\n$$\n\\Delta_o < P \\implies \\text{High-Spin} \\qquad \\text{vs} \\qquad \\Delta_o > P \\implies \\text{Low-Spin}\n$$\n• **Optical Color:** $\\Delta_o = \\frac{hc}{\\lambda_{\\text{abs}}}$ *(Stronger field absorbs shorter wavelengths!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order these ligands in sequence of increasing crystal field splitting energy Delta_o (from weakest field to strongest field).",
      "orderItems": [
        "Iodide (I-) [Weakest field pi-donor ligand, smallest Delta_o]",
        "Chloride (Cl-) [Moderate pi-donor halide ligand]",
        "Water (H2O) [Weak pi-donor solvent ligand, boundary field]",
        "Ammonia (NH3) [Pure sigma-donor amine ligand, intermediate Delta_o]",
        "Carbon Monoxide (CO) / Cyanide (CN-) [Potent pi-acceptor ligands, maximum Delta_o]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ligand to its molecular orbital classification and ligand field effect.",
      "matchPairs": [
        { "left": "Chloride (Cl-)", "right": "pi-Donor ligand; filled p-orbitals destabilize t_2g*, reducing Delta_o (High-Spin)" },
        { "left": "Ammonia (NH3)", "right": "Pure sigma-donor ligand; non-participating in pi bonding, intermediate Delta_o" },
        { "left": "Carbon Monoxide (CO)", "right": "pi-Acceptor ligand; empty pi* orbitals stabilize t_2g via backbonding, maximizing Delta_o (Low-Spin)" },
        { "left": "Ethylenediamine (en)", "right": "Bidentate chelating sigma-donor; forms stable 5-membered chelate rings" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Ligands that act as strong pi-acceptors like carbon monoxide (CO) drastically increase Delta_o through the quantum mechanism of pi-___.",
      "blankAnswer": "backbonding",
      "blankDistractors": ["repulsion", "decay", "tunneling"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does substituting water ligands with cyanide ligands in [Co(H2O)6]3+ to form [Co(CN)6]3- cause the absorption wavelength to shift from 650 nm (red) down to 310 nm (ultraviolet)?",
      "options": [
        { "text": "Cyanide is a potent pi-acceptor ligand that dramatically increases the crystal field splitting energy Delta_o; because photon energy Delta E = hc/lambda = Delta_o, a much larger Delta_o requires higher-energy, shorter-wavelength photons (blue/UV shift)", "isCorrect": true, "explanation": "Correct! Delta_o is inversely proportional to absorption wavelength: Delta E = hc/lambda. Replacing weak-field H2O with strong-field CN- significantly increases Delta_o (by ~2.5x), which reduces the wavelength of absorbed light from ~650 nm down to ~310 nm, shifting the absorption out of the visible spectrum." },
        { "text": "Because cobalt changes its oxidation state to +1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because cyanide absorbs all electrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because water is magnetic and cyanide is not", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
