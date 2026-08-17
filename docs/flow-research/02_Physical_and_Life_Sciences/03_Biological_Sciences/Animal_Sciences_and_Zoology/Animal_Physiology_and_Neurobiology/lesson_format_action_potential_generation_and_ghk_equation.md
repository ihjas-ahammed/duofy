# Duofy Reusable Lesson Format: Action Potential Generation and the GHK Equation

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Animal_Sciences_and_Zoology / Animal_Physiology_and_Neurobiology`  
**Lesson Format Type:** `action_potential_generation_and_ghk_equation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the electrophysiological biophysics of neuronal excitability and action potential dynamics (Alan Hodgkin & Andrew Huxley, Nobel Prize in Physiology or Medicine 1963): calculate resting membrane potential ($V_m \approx -70\text{ mV}$) using the **Goldman-Hodgkin-Katz (GHK) Equation** balancing $\text{K}^+$, $\text{Na}^+$, and $\text{Cl}^-$ permeabilities, trace the sequential gates of voltage-gated $\text{Na}^+$ (activation and inactivation gates) and $\text{K}^+$ channels during the **Depolarization, Repolarization, and Hyperpolarization Phases**, distinguish the **Absolute vs Relative Refractory Periods**, and formulate **Saltatory Conduction** along myelinated axons through Nodes of Ranvier.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GHK Equation & Action Potential Biophysics Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Action Potential Voltage-Gated Ion Channel Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Action Potential Phase & Ion Channel State Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Myelinated Axon Fast Impulse Conduction Mode Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Absolute Refractory Period Sodium Inactivation Gate Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Electrophysiology & The GHK Voltage Equation:
   - **The Goldman-Hodgkin-Katz (GHK) Voltage Equation:**
     $$V_m = \frac{RT}{F} \ln\left( \frac{P_{\text{K}}[\text{K}^+]_{\text{out}} + P_{\text{Na}}[\text{Na}^+]_{\text{out}} + P_{\text{Cl}}[\text{Cl}^-]_{\text{in}}}{P_{\text{K}}[\text{K}^+]_{\text{in}} + P_{\text{Na}}[\text{Na}^+]_{\text{in}} + P_{\text{Cl}}[\text{Cl}^-]_{\text{out}}} \right)$$
     - **Resting State ($-70\text{ mV}$):** $P_{\text{K}} : P_{\text{Na}} : P_{\text{Cl}} = 1.0 : 0.04 : 0.45$ (Resting potential sits close to $E_{\text{K}} = -90\text{ mV}$ due to open $\text{K}^+$ leak channels).
   - **The 4 Phases of an Action Potential:**
     1. **Threshold Trigger ($-55\text{ mV}$):** Voltage sensor ($S_4$ helix) triggers opening of voltage-gated $\text{Na}^+$ channels (Nav).
     2. **Depolarization ($P_{\text{Na}} \gg P_{\text{K}}$):** Explosive inward $\text{Na}^+$ current drives membrane potential toward $E_{\text{Na}} \approx +60\text{ mV}$ (peaking at $+30\text{ mV}$).
     3. **Repolarization:** Ball-and-chain inactivation gate closes Nav channels ($P_{\text{Na}} \to 0$); delayed rectifier voltage-gated $\text{K}^+$ channels (Kv) open, causing rapid outward $\text{K}^+$ efflux.
     4. **Hyperpolarization & Refractory Period:** Slow closing of Kv channels dips $V_m$ to $-80\text{ mV}$ (undershoot) before $\text{Na}^+/\text{K}^+$-ATPase ($3\text{Na}^+\text{ out} / 2\text{K}^+\text{ in}$) and leak channels restore resting baseline.
2. **Slide 2 (`ordering`):** Provide 5 steps of the action potential cycle: (1) graded synaptic depolarization reaches the axon hillock threshold of $-55\text{ mV}$, (2) activation gates of voltage-gated $\text{Na}^+$ channels snap open, producing massive $\text{Na}^+$ influx and rapid depolarization toward $+30\text{ mV}$, (3) voltage-gated $\text{Na}^+$ channel inactivation gates close (ball-and-chain mechanism), terminating $\text{Na}^+$ entry, (4) delayed-rectifier voltage-gated $\text{K}^+$ channels open fully, allowing rapid $\text{K}^+$ efflux to repolarize the membrane, (5) prolonged $\text{K}^+$ efflux causes after-hyperpolarization undershoot ($-80\text{ mV}$) before $\text{K}^+$ channels close and resting $-70\text{ mV}$ is re-established!
3. **Slide 3 (`matching`):** Pair 4 phases (Resting Potential, Depolarization Peak, Absolute Refractory Period, Relative Refractory Period) with their ion channel status and permeability states.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the rapid leaping of action potentials from one node of Ranvier to the next along a myelinated axon is called saltatory conduction. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the biophysical origin of the Absolute Refractory Period: Why is it physically impossible to elicit a second action potential during the Absolute Refractory Period, regardless of how strong the stimulus is? (Because the **inactivation gates ('h-gates' or ball-and-chain) of voltage-gated $\text{Na}^+$ channels are closed and locked**, and the channels cannot be re-opened by voltage until the membrane repolarizes to reset the inactivation gates back to the closed-but-excitable state).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "action_potential_generation_and_ghk_equation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Action Potential Dynamics and the GHK Equation**\n• **The Goldman-Hodgkin-Katz (GHK) Equation:**\n$$\nV_m = \\frac{RT}{F} \\ln\\left( \\frac{P_{\\text{K}}[\\text{K}^+]_{\\text{out}} + P_{\\text{Na}}[\\text{Na}^+]_{\\text{out}} + P_{\\text{Cl}}[\\text{Cl}^-]_{\\text{in}}}{P_{\\text{K}}[\\text{K}^+]_{\\text{in}} + P_{\\text{Na}}[\\text{Na}^+]_{\\text{in}} + P_{\\text{Cl}}[\\text{Cl}^-]_{\\text{out}}} \\right)\n$$\n  - **Resting State ($-70\\text{ mV}$):** $P_{\\text{K}} \\gg P_{\\text{Na}}$ (dominated by $\\text{K}^+$ leak channels).\n• **The Action Potential Sequence:**\n  1. **Threshold ($-55\\text{ mV}$):** Voltage-gated $\\text{Na}^+$ channels (Nav) open.\n  2. **Depolarization:** Massive $\\text{Na}^+$ influx surges potential toward $+30\\text{ mV}$ ($P_{\\text{Na}} \\gg P_{\\text{K}}$).\n  3. **Repolarization:** Nav inactivation gates close; Delayed rectifier Kv channels open ($\\text{K}^+$ efflux).\n  4. **Hyperpolarization ($-80\\text{ mV}$):** Kv channels close slowly, producing after-hyperpolarization.\n• **Saltatory Conduction:** Action potential leaps between **Nodes of Ranvier** in myelinated axons ($v \\le 120\\text{ m/s}$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the electrophysiological events occurring during an action potential.",
      "orderItems": [
        "Excitatory synaptic input depolarizes the neuronal membrane to the critical threshold potential (-55 mV)",
        "Activation gates of voltage-gated Na⁺ channels snap open, producing massive inward Na⁺ current and spike depolarization (+30 mV)",
        "The ball-and-chain inactivation gates of voltage-gated Na⁺ channels close, terminating Na⁺ influx",
        "Delayed-rectifier voltage-gated K⁺ channels open fully, allowing rapid outward K⁺ efflux to repolarize the membrane",
        "Prolonged K⁺ efflux causes an after-hyperpolarization undershoot (-80 mV) before channels close to restore resting potential"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each action potential phase to its precise ion channel configuration.",
      "matchPairs": [
        { "left": "Resting Membrane Potential (-70 mV)", "right": "P_K >> P_Na; K⁺ leak channels open, voltage-gated Na⁺/K⁺ channels closed" },
        { "left": "Depolarization Upswing (-55 mV to +30 mV)", "right": "Voltage-gated Na⁺ activation gates open; massive inward Na⁺ flux" },
        { "left": "Absolute Refractory Period", "right": "Voltage-gated Na⁺ channels inactivated (locked by inactivation gate; unexcitable)" },
        { "left": "Relative Refractory Period", "right": "Na⁺ channels reset to closed state, but delayed K⁺ channels remain open (hyperpolarized)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The rapid jumping of an action potential from one node of Ranvier to the next along a myelinated axon is called ___ conduction.",
      "blankAnswer": "saltatory",
      "blankDistractors": ["continuous", "synaptic", "tonic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is it biologically impossible for any stimulus, no matter how strong, to trigger a second action potential during the Absolute Refractory Period?",
      "options": [
        { "text": "The inactivation gates ('ball-and-chain' h-gates) of voltage-gated Na⁺ channels are closed and locked, rendering the channels completely unresponsive until the membrane repolarizes to reset them back to the closed-yet-activatable state", "isCorrect": true, "explanation": "Correct! Voltage-gated Na⁺ channels have two separate gates: an activation (m) gate and an inactivation (h) gate. At the peak of an action potential, the inactivation gate closes, plugging the pore. In this inactivated state, the channel physically cannot reopen until the membrane repolarizes below threshold, resetting the inactivation gate. This enforces unidirectional propagation and sets the maximum firing frequency of neurons." },
        { "text": "Because all intracellular ATP has been permanently exhausted", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the axon myelin sheath melts during the spike", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because potassium ions are completely depleted from the body", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
