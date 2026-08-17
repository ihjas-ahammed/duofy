# Duofy Reusable Lesson Format: Membrane Biophysics (Nernst Potential & Action Potentials)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Human_Physiology / Neurophysiology_and_Muscle_Mechanics`  
**Lesson Format Type:** `nernst_potential_and_action_potential_biophysics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the quantitative biophysics of cell membranes and neuronal excitability, the derivation and application of the **Nernst Equilibrium Potential ($E_{\text{ion}} = \frac{61.5}{z}\log_{10}\frac{[\text{Ion}]_{\text{out}}}{[\text{Ion}]_{\text{in}}}$ at body temperature $37^\circ\text{C}$)** for $K^+, Na^+, Ca^{2+}, Cl^-$, the **Goldman-Hodgkin-Katz (GHK) Equation** establishing resting membrane potential ($V_m \approx -70\text{ to } -85\text{ mV}$ due to high resting $K^+$ permeability $P_K \gg P_{Na}$ via leak channels and $3Na^+/2K^+$ ATPase electrogenic pumping), the voltage-gated ion channel gating kinetics of the **Action Potential** (rapid opening of $Na_V$ activation $m$-gates during Phase 0 upstroke $\to$ time-dependent closure of $Na_V$ inactivation $h$-gates and delayed opening of $K_V$ channels during Phase 1-2 repolarization $\to$ after-hyperpolarization Phase 3), and the biophysical definition of the **Absolute Refractory Period** (inactivated $h$-gates) versus the **Relative Refractory Period** (elevated $P_K$ requiring suprathreshold stimulus) (John E. Hall, Michael E. Hall *Guyton and Hall Textbook of Medical Physiology* 14th ed. Chapters 5 & 6; Linda S. Costanzo *Physiology* 7th ed. Chapter 1; Eric R. Kandel *Principles of Neural Science* 6th ed. Chapter 6): formulate the **Nernst Equilibrium Potential Master Formulation (at $37^\circ\text{C}$)**:
$$\mathbf{E_{\text{ion}} = \frac{61.5}{z} \log_{10}\left( \frac{[\text{Ion}]_{\text{extracellular}}}{[\text{Ion}]_{\text{intracellular}}} \right) \quad [\text{mV}]}$$
where:
1. **$z$:** Valence charge of the ion ($+1$ for $K^+, Na^+$; $+2$ for $Ca^{2+}$; $-1$ for $Cl^-$);
2. **$61.5\text{ mV}$:** Thermodynamic factor $\frac{2.303 R T}{F}$ calculated at human body temperature ($310.15\text{ K} = 37^\circ\text{C}$);
3. **Canonical Equilibrium Potentials:**
   - $\mathbf{E_{K^+} \approx -90\text{ mV}}$ ($[K^+]_o = 4.0\text{ mM}, [K^+]_i = 140.0\text{ mM}$);
   - $\mathbf{E_{Na^+} \approx +65\text{ mV}}$ ($[Na^+]_o = 145.0\text{ mM}, [Na^+]_i = 12.0\text{ mM}$);
   - $\mathbf{E_{Ca^{2+}} \approx +120\text{ mV}}$ ($[Ca^{2+}]_o = 2.4\text{ mM}, [Ca^{2+}]_i = 10^{-4}\text{ mM}$);
   - $\mathbf{E_{Cl^-} \approx -85\text{ mV}}$ ($[Cl^-]_o = 105.0\text{ mM}, [Cl^-]_i = 4.0\text{ mM}$);
master the **Voltage-Gated Sodium Channel ($Na_V$) Gating Matrix**:
$$\begin{array}{|l|c|c|c|l|}
\hline
\textbf{Action Potential State} & \textbf{Activation } m\textbf{-Gate} & \textbf{Inactivation } h\textbf{-Gate} & \text{Na}^+ \textbf{ Permeability} & \textbf{Refractory Status} \\
\hline
\mathbf{\text{Resting Potential } (-70\text{ mV})} & \mathbf{\text{CLOSED}} & \mathbf{\text{OPEN}} & \text{Low baseline} & \text{Excitable / Ready for stimulus} \\
\mathbf{\text{Upstroke Depolarization}} & \mathbf{\text{OPEN}} & \mathbf{\text{OPEN}} & \mathbf{\text{MASSIVE SURGE } (P_{Na} \uparrow\uparrow)} & \mathbf{\text{Absolute Refractory Period begins}} \\
\mathbf{\text{Peak / Early Repolarization}} & \text{OPEN} & \mathbf{\text{CLOSED (Inactivated)}} & \text{Zero flux} & \mathbf{\text{ABSOLUTE REFRACTORY (Cannot fire)}} \\
\mathbf{\text{After-Hyperpolarization}} & \text{CLOSED} & \mathbf{\text{OPEN (Reset)}} & \text{Low (} P_K \text{ dominates)} & \mathbf{\text{RELATIVE REFRACTORY (Needs high stimulus)}} \\
\hline
\end{array}$$
(proving that hyperkalemia depolarizes the baseline resting potential closer to threshold, which paradoxically inactivates $Na_V$ $h$-gates, causing fatal cardiac arrest in diastole).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nernst Equation ($E = \frac{61.5}{z}\log\frac{\text{out}}{\text{in}}$), GHK Resting Potential & $Na_V$ Gating Dynamics Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Nernst Potential for Potassium and Sodium Ions Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Action Potential Phase / Biophysical Gate & Technical Electrophysiological Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Period During an Action Potential When Absolutely No Second Action Potential Can Be Generated, Regardless of Stimulus Strength, Because Voltage-Gated Sodium Channel Inactivation $h$-Gates Are Closed Is the ___ Refractory Period (Absolute / Absolute Refractory) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Electrophysiology Problem: Computing the Nernst Equilibrium Potential for Potassium Ions Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Nernst Equilibrium & Action Potential Biophysics (Guyton 2021; Costanzo 2022):
   - **Biophysical Formulations:**
     $$\mathbf{E_{\text{ion}} = \frac{61.5}{z} \log_{10}\left( \frac{[\text{Ion}]_o}{[\text{Ion}]_i} \right) \quad \Big| \quad V_m \approx -70\text{ to } -85\text{ mV} \quad \Big| \quad E_{K^+} \approx -90\text{ mV} \quad \Big| \quad E_{Na^+} \approx +65\text{ mV}}$$
   - **The Inactivation Gate Invariant:**
     - The **Inactivation ($h$) gate** closes in a time-dependent manner at peak depolarization;
     - The $h$-gate CANNOT reopen until the membrane repolarizes back to resting levels;
     - This creates the **Absolute Refractory Period**, enforcing unidirectional forward propagation of action potentials!
2. **Slide 2 (`ordering`):** Provide 5 steps of an action potential cycle: (1) stimulus depolarizes membrane potential from $-70\text{ mV}$ to threshold ($-55\text{ mV}$), (2) voltage-gated $Na^+$ channel activation $m$-gates open rapidly, causing regenerative $Na^+$ influx toward $E_{Na^+}$, (3) at peak potential ($+35\text{ mV}$), $Na^+$ channel inactivation $h$-gates close while delayed rectifier $K^+$ channels open, (4) $K^+$ efflux repolarizes the membrane back toward negative potentials, (5) prolonged $K^+$ permeability causes transient after-hyperpolarization toward $E_{K^+}$ before $Na^+/K^+$ pumps and leak channels restore baseline!
3. **Slide 3 (`matching`):** Pair 4 concepts (Nernst Potential, Absolute Refractory Period, Relative Refractory Period, Sodium-Potassium ATPase) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Absolute (or Absolute Refractory). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating the Nernst equilibrium potential for potassium: A mammalian neuron has an intracellular potassium concentration of $[K^+]_i = 140.0\text{ mM}$ and an extracellular potassium concentration of $[K^+]_o = 4.0\text{ mM}$ at human body temperature ($37^\circ\text{C}$, $z = +1$).
   - Ratio:
     $\frac{[K^+]_o}{[K^+]_i} = \frac{4.0\text{ mM}}{140.0\text{ mM}} = \frac{1}{35.0} \approx 0.028571$;
   - $\log_{10}(0.028571) = -\log_{10}(35.0) \approx -1.544068$;
   - Nernst Equilibrium Potential:
     $E_{K^+} = \frac{61.5}{+1} \times (-1.544068) = \mathbf{-94.96\text{ mV} \approx -95.0\text{ mV}}$;
   - What is the equilibrium potential for potassium ($E_{K^+}$)? ($E_{K^+} = \mathbf{-95.0\text{ mV}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "nernst_potential_and_action_potential_biophysics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Nernst Potential \\& Action Potential Biophysics (Linda S. Costanzo)**\n• **Nernst Equilibrium Potential Formulation (at $37^\\circ\\text{C}$ Body Temp):**\n$$\n\\mathbf{E_{\\text{ion}} = \\frac{61.5}{z} \\log_{10}\\left( \\frac{[\\text{Ion}]_{\\text{extracellular}}}{[\\text{Ion}]_{\\text{intracellular}}} \\right) \\quad [\\text{mV}]}\n$$\n  - **$z$:** Valence charge ($+1$ for $K^+, Na^+$; $+2$ for $Ca^{2+}$; $-1$ for $Cl^-$);\n  - **$E_{K^+} \\approx -90\\text{ to } -95\\text{ mV}$:** High $[K^+]_i = 140\\text{ mM}$ vs low $[K^+]_o = 4\\text{ mM}$;\n  - **$E_{Na^+} \\approx +65\\text{ mV}$:** High $[Na^+]_o = 145\\text{ mM}$ vs low $[Na^+]_i = 12\\text{ mM}$;\n• **Voltage-Gated Sodium Channel ($Na_V$) Two-Gate Cycle:**\n  - **Resting ($-70\\text{ mV}$):** Activation ($m$) gate CLOSED; Inactivation ($h$) gate OPEN;\n  - **Upstroke:** Threshold ($-55\\text{ mV}$) triggers rapid $m$-gate OPENING $\\implies$ Massive $Na^+$ influx;\n  - **Peak (+$35\\text{ mV}$):** Time-dependent $h$-gate **CLOSURE (Inactivation)** $\\implies$ **Absolute Refractory Period**;\n• **The Refractory Invariant:** The $h$-inactivation gates **cannot reopen until the membrane repolarizes**, preventing retrograde action potential back-propagation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential electrophysiological phases of a neuronal action potential from initial resting state to post-spike recovery.",
      "orderItems": [
        "Resting membrane potential is maintained at -70 mV by high baseline K+ leak permeability and the 3Na+/2K+ ATPase pump",
        "Depolarizing stimulus reaches the -55 mV threshold, triggering rapid opening of voltage-gated Na+ channel activation m-gates",
        "Massive influx of Na+ drives the rapid Phase 0 depolarization upstroke toward the sodium equilibrium potential (+65 mV)",
        "At peak overshoot (+35 mV), Na+ inactivation h-gates close while delayed rectifier voltage-gated K+ channels open",
        "Efflux of K+ repolarizes the membrane, producing a transient after-hyperpolarization toward EK (-90 mV) before resetting"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Electrophysiological Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Nernst Potential (E_ion)", "right": "Transmembrane voltage that exactly balances the chemical concentration gradient for a specific single ion" },
        { "left": "Absolute Refractory Period", "right": "Time span during spike when Na+ inactivation h-gates are closed and no second action potential can fire" },
        { "left": "Relative Refractory Period", "right": "Post-spike interval where elevated K+ conductance requires a stronger-than-normal suprathreshold stimulus" },
        { "left": "Na+/K+ ATPase Pump", "right": "Electrogenic primary active transporter pumping 3 Na+ out and 2 K+ in to maintain baseline concentration gradients" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The period during an action potential when absolutely no second action potential can be generated, regardless of stimulus strength, because voltage-gated sodium channel inactivation h-gates are closed is the ___ refractory period.",
      "blankAnswer": "absolute",
      "blankDistractors": ["relative", "latent", "threshold"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A neuron has intracellular potassium [K+]i = 140.0 mM and extracellular potassium [K+]o = 4.0 mM at body temperature 37\u00b0C (z = +1). Ratio [K+]o/[K+]i = 4.0 / 140.0 = 1/35.0. log10(1/35.0) = -log10(35.0) \u2248 -1.544. EK = (61.5 / 1) * (-1.544) = -94.96 mV \u2248 -95.0 mV. What is the Nernst equilibrium potential for potassium (EK)?",
      "options": [
        { "text": "EK = -95.0 mV (EK = 61.5 * log10(4.0 / 140.0) = 61.5 * (-1.544) = -94.96 mV \u2248 -95.0 mV)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Nernst equation for potassium ions at body temperature ($37^\\circ\\text{C}$) (John E. Hall *Guyton and Hall Textbook of Medical Physiology* Chapter 5; Linda S. Costanzo *Physiology* Chapter 1). 1. **Identify Ion Parameters:** - Extracellular concentration: $[K^+]_o = 4.0\\text{ mM}$. - Intracellular concentration: $[K^+]_i = 140.0\\text{ mM}$. - Valence charge: $z = +1$. - Constant factor at $37^\\circ\\text{C}$: $61.5\\text{ mV}$. 2. **Calculate Concentration Ratio \\& Logarithm:** $$\\text{Ratio} = \\frac{[K^+]_o}{[K^+]_i} = \\frac{4.0\\text{ mM}}{140.0\\text{ mM}} = \\frac{1}{35.0} \\approx 0.028571$$ $$\\log_{10}(0.028571) = -\\log_{10}(35.0) = -1.544068$$ 3. **Evaluate Nernst Equilibrium Potential ($E_{K^+}$):** $$E_{K^+} = \\frac{61.5\\text{ mV}}{+1} \\times (-1.544068) = -94.9599\\text{ mV} \\approx \\mathbf{-95.0\\text{ mV}}$$ - This negative potential ($-95\\text{ mV}$) represents the electrical force inside the cell required to stop the outward chemical diffusion of $K^+$! Flawless Nernst potential derivation!" },
        { "text": "EK = +65.0 mV (This is the sodium equilibrium potential ENa)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "EK = -70.0 mV (This is the resting membrane potential Vm where both K+ and Na+ contribute)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "EK = 0.0 mV", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
