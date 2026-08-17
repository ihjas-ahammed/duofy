# Duofy Reusable Lesson Format: Frequency-Dependent Selection and Evolutionary Game Theory

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Natural_Selection_and_Adaptation`  
**Lesson Format Type:** `frequency_dependent_selection_and_evolutionary_game_theory`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through frequency-dependent evolutionary dynamics and game-theoretic optimization in population biology (John Maynard Smith & George R. Price 1973; R.A. Fisher 1930): contrast **Negative Frequency-Dependent Selection (Rare-Morph Advantage)** maintaining balanced genetic polymorphisms with **Positive Frequency-Dependent Selection (Common-Morph Advantage)** fixing dominant warning patterns, formulate **Evolutionary Game Theory** using payoff matrices, calculate the **Evolutionary Stable Strategy (ESS)** in the classic **Hawk-Dove Game** ($V < C \implies p_{\text{Hawk}} = V/C$), and analyze classic biological paradigms (scale-eating cichlid fish jaw asymmetry *Perissodus microlepis*, Fisherian $1:1$ sex ratio evolution, and Batesian vs Müllerian mimicry).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Frequency-Dependent Selection & Game Theory Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Negative Frequency-Dependent Oscillation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Evolutionary Scenario & Game Theoretic / Selection Category Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Uninvadable Behavioral Phenotype Acronym ESS Full Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hawk-Dove Game ESS Equilibrium Calculation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Frequency-Dependent Selection & Evolutionary Game Theory:
   - **Frequency-Dependent Selection (FDS):**
     1. **Negative FDS (Rare-Morph Advantage):**
        - Fitness $w_i$ decreases as morph frequency $p_i$ increases ($w_i \propto 1/p_i$).
        - **Dynamic Consequence:** Drives negative feedback oscillations that converge to a **Stable Balanced Polymorphism** (e.g. Lake Tanganyika scale-eating cichlid *Perissodus microlepis*: left-mouthed and right-mouthed morphs oscillate stably around $50:50$).
     2. **Positive FDS (Common-Morph Advantage):**
        - Fitness increases as frequency increases ($w_i \propto p_i$).
        - **Dynamic Consequence:** Drives the common morph to fixation ($p \to 1$); purges rare variants (e.g. Müllerian mimicry in *Heliconius* butterflies sharing identical warning patterns).
   - **Evolutionary Stable Strategy (ESS, Maynard Smith 1973):**
     - A behavioral strategy that, if adopted by a population, cannot be invaded by any alternative rare mutant strategy:
       $$E(S, S) > E(T, S) \quad \text{or if } E(S, S) = E(T, S), \text{ then } E(S, T) > E(T, T)$$
   - **The Hawk-Dove Game ($V = \text{Resource Value}, C = \text{Injury Cost}$ with $C > V$):**
     $$\begin{array}{c|cc}
     & \textbf{Hawk} & \textbf{Dove} \\
     \hline
     \textbf{Hawk} & (V - C)/2 & V \\
     \textbf{Dove} & 0 & V/2 \\
     \end{array}$$
     - **Mixed ESS:** Stable proportion of Hawks: $\mathbf{p_{\text{Hawk}} = \frac{V}{C}}$.
2. **Slide 2 (`ordering`):** Provide 5 steps of negative frequency-dependent selection in scale-eating fish: (1) left-bending jaw morphs (which attack prey fish from the right flank) are rare in the lake ($p_{\text{left}} = 0.20$), (2) prey fish learn to vigilantly guard their left flank against the common right-bending morphs, neglecting their right flank, (3) rare left-mouthed fish achieve high feeding success and produce more surviving offspring (high relative fitness), (4) left-mouthed morph frequency increases over generations until it becomes common ($p_{\text{left}} = 0.80$), (5) prey fish switch their vigilance to guard their right flank, depressing left-mouthed fitness and causing the morph frequency to oscillate back toward the $50:50$ equilibrium!
3. **Slide 3 (`matching`):** Pair 4 biological phenomena (Scale-eating cichlid left/right jaws, Fisher's 1:1 sex ratio, Müllerian butterfly mimicry, Hawk-Dove resource contest) with their theoretical mechanisms.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in evolutionary game theory, a strategy that resists invasion by any mutant strategy is termed an evolutionary stable strategy (abbreviated ESS). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing Hawk-Dove ESS: In a population of animals competing for a food territory of value $V = 40$ units, escalated fights between Hawks inflict an injury cost of $C = 100$ units. Doves display without fighting. What is the stable equilibrium percentage of Hawks in this population under Maynard Smith's evolutionary game theory? (The mixed ESS requires $p_{\text{Hawk}} = V / C = 40 / 100 = \mathbf{0.40\ (40\%\text{ Hawks})}$; at this frequency, the average fitness payoff of playing Hawk equals the average payoff of playing Dove, stabilizing the mixed population).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "frequency_dependent_selection_and_evolutionary_game_theory",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Frequency-Dependent Selection and Evolutionary Game Theory**\n• **1. Negative Frequency-Dependent Selection (NFDS):**\n  - Fitness is inversely related to frequency ($w_i \\propto 1/p_i$).\n  - **Outcome:** Maintains **Stable Balanced Polymorphism** (e.g. scale-eating fish $50:50$ left/right jaw asymmetry; Fisherian $1:1$ sex ratios).\n• **2. Positive Frequency-Dependent Selection (PFDS):**\n  - Fitness increases with frequency ($w_i \\propto p_i$).\n  - **Outcome:** Fixes common morphs; eliminates rare morphs (e.g. Müllerian mimicry warning patterns).\n• **Evolutionary Stable Strategy (ESS, Maynard Smith 1973):**\n  - A behavioral strategy that cannot be invaded by any rare mutant alternative.\n• **The Hawk-Dove Contest Game ($V = \\text{Value}, C = \\text{Cost}$ with $C > V$):**\n$$\n\\text{Payoff Matrix: } \\text{Hawk vs Hawk} = \\frac{V - C}{2}, \\quad \\text{Hawk vs Dove} = V, \\quad \\text{Dove vs Dove} = \\frac{V}{2}\n$$\n  - **Mixed ESS Frequency:** $\\mathbf{p_{\\text{Hawk}} = \\frac{V}{C}}$ (Stable equilibrium mix of fighters and displayers!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the cyclical dynamics of negative frequency-dependent selection in scale-eating cichlid fish.",
      "orderItems": [
        "Left-mouthed morphs attacking prey from the right side are rare in the lake population (p = 0.20)",
        "Prey fish learn to guard their left flank against the common right-mouthed predators, leaving their right flank undefended",
        "Rare left-mouthed morphs enjoy high hunting success and superior reproductive fitness due to prey inattention",
        "Over successive generations, left-mouthed fish increase in frequency until they become the dominant majority (p = 0.80)",
        "Prey fish adapt by switching vigilance to their right flank, reducing left-mouthed fitness and driving frequency back toward 50:50"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each biological phenomenon to its evolutionary game-theoretic mechanism.",
      "matchPairs": [
        { "left": "Scale-Eating Cichlid Asymmetry", "right": "Negative Frequency-Dependent Selection (rare jaw morph has hunting advantage)" },
        { "left": "Fisherian 1:1 Sex Ratio Evolution", "right": "Negative Frequency-Dependent Selection (rarer sex has higher individual mating success)" },
        { "left": "Heliconius Butterfly Müllerian Mimicry", "right": "Positive Frequency-Dependent Selection (predators learn common aposematic pattern faster)" },
        { "left": "Hawk-Dove Territorial Conflict", "right": "Mixed Evolutionary Stable Strategy (ESS) where fraction of aggressive Hawks equals V/C" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In evolutionary game theory, a behavioral strategy that cannot be invaded by any alternative mutant strategy is termed an evolutionary ___ strategy (ESS).",
      "blankAnswer": "stable",
      "blankDistractors": ["unstable", "random", "dominant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a Hawk-Dove game model of animal aggression, competing for a mating territory of value V = 30 units carries a severe injury cost in escalated Hawk-Hawk combat of C = 100 units. What is the stable evolutionary equilibrium percentage of Hawks in this population?",
      "options": [
        { "text": "30% Hawks (and 70% Doves); by Maynard Smith's ESS formula p_Hawk = V / C = 30 / 100 = 0.30, at which point the average fitness payoff of playing Hawk exactly equals the payoff of playing Dove", "isCorrect": true, "explanation": "Correct! When injury cost exceeds resource value (C > V), pure Hawk is not an ESS because in an all-Hawk population, the average payoff is (V - C)/2 = (30 - 100)/2 = -35 (everyone gets injured), allowing non-violent Doves (payoff = 0) to invade. The stable mixed ESS occurs where expected fitness payoffs equalize: E(Hawk) = E(Dove), which yields p_Hawk = V / C = 30 / 100 = 0.30 (30% Hawks, 70% Doves)." },
        { "text": "100% Hawks (everyone fights to death)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0% Hawks (nobody fights ever)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "70% Hawks", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
