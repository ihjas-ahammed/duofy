# Duofy Reusable Lesson Format: Heterogeneous Catalysis (Langmuir-Hinshelwood vs Eley-Rideal)

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Polymer_and_Materials_Chemistry / Nanomaterials_and_Surface_Chemistry`  
**Lesson Format Type:** `heterogeneous_catalysis_langmuir_hinshelwood_vs_eley_rideal`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the microscopic kinetic pathways and rate laws of heterogeneous surface catalysis: contrast the **Langmuir-Hinshelwood (L-H) Mechanism** (both reactants $A$ and $B$ must chemisorb to adjacent surface sites before undergoing surface reaction: $\text{Rate} = k \theta_A \theta_B = \frac{k K_A K_B P_A P_B}{(1 + K_A P_A + K_B P_B)^2}$) with the **Eley-Rideal (E-R) Mechanism** (an adsorbed reactant $A$ directly reacts upon collision with gas-phase molecule $B$: $\text{Rate} = k \theta_A P_B = \frac{k K_A P_A P_B}{1 + K_A P_A}$), analyze the diagnostic **Rate Maximum with Increasing Partial Pressure in L-H Kinetics (Surface Poisoning/Competitive Inhibition)**, and formulate the **Sabatier Principle (Paul Sabatier, Nobel Prize 1912)** (optimal catalytic activity at intermediate adsorption binding energy, Volcano Plots).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | L-H vs E-R Catalytic Mechanisms Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Langmuir-Hinshelwood Catalytic Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Catalytic Mechanism & Kinetic Diagnostic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Volcano Plot Optimal Catalytic Binding Principle Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High Partial Pressure Kinetic Rate Suppression in L-H Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Heterogeneous Catalytic Mechanisms & The Sabatier Principle:
   - **Langmuir-Hinshelwood (L-H) Mechanism:**
     $$A(g) + * \xrightleftharpoons{} A^*, \quad B(g) + * \xrightleftharpoons{} B^*, \quad A^* + B^* \xrightarrow{k} P^* \xrightarrow{} P(g) + 2*$$
     $$\text{Rate}_{\text{L-H}} = k \theta_A \theta_B = \frac{k K_A K_B P_A P_B}{(1 + K_A P_A + K_B P_B)^2}$$
     - **Diagnostic Feature:** Exhibits a **Rate Maximum**! If $P_A \to \infty$, $A$ completely covers the surface ($\theta_A \to 1, \theta_B \to 0$), starving the surface of adsorbed $B$ and suppressing the reaction rate ($\text{Rate} \propto 1/P_A$).
   - **Eley-Rideal (E-R) Mechanism:**
     $$A(g) + * \xrightleftharpoons{} A^*, \quad A^* + B(g) \xrightarrow{k} P(g) + *$$
     $$\text{Rate}_{\text{E-R}} = k \theta_A P_B = \frac{k K_A P_A P_B}{1 + K_A P_A}$$
     - **Diagnostic Feature:** Rate increases **monotonically and linearly** with $P_B$ at all pressures; never suppressed by high $P_B$.
   - **The Sabatier Principle & Volcano Plots:**
     - The interaction between catalyst and substrate must be "just right" — neither too weak (reactants fail to adsorb) nor too strong (products fail to desorb and poison the catalyst), producing characteristic volcano-shaped activity curves.
2. **Slide 2 (`ordering`):** Provide 5 steps of the Langmuir-Hinshelwood oxidation of carbon monoxide on a platinum catalyst ($\text{CO} + \frac{1}{2}\text{O}_2 \to \text{CO}_2$): (1) gas-phase $\text{CO}$ and $\text{O}_2$ diffuse toward the exposed metallic platinum surface, (2) $\text{CO}$ adsorbs molecularly onto vacant platinum sites while $\text{O}_2$ undergoes dissociative chemisorption into two adsorbed oxygen atoms ($\text{O}^*$), (3) adsorbed $\text{CO}^*$ and adsorbed $\text{O}^*$ diffuse across the surface until they encounter adjacent neighboring sites, (4) surface reaction occurs between adjacent $\text{CO}^*$ and $\text{O}^*$ to form a weakly bound $\text{CO}_2^*$ complex, (5) carbon dioxide ($\text{CO}_2$) immediately desorbs into the gas phase, regenerating two clean, vacant active platinum sites for the next catalytic cycle!
3. **Slide 3 (`matching`):** Pair 4 heterogeneous catalysis concepts (Langmuir-Hinshelwood, Eley-Rideal, Sabatier Volcano Peak, Mars-van Krevelen) with their definitions and rate equations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the principle stating optimal catalytic activity occurs at intermediate adsorption strength is the Sabatier principle. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on L-H competitive surface inhibition: In the catalytic reaction between gas $A$ and gas $B$ over a solid catalyst, increasing the partial pressure of $A$ ($P_A$) initially increases the reaction rate, but further increases in $P_A$ to very high values cause the reaction rate to DROP towards zero. What mechanism does this prove? (This proves the **Langmuir-Hinshelwood (L-H) Mechanism**; because the reaction requires both $A$ and $B$ to be chemisorbed on adjacent sites, very high $P_A$ causes species $A$ to monopolize all surface active sites ($\theta_A \to 1$), displacing $B$ from the surface ($\theta_B \to 0$) and causing self-poisoning of the reaction).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "heterogeneous_catalysis_langmuir_hinshelwood_vs_eley_rideal",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Heterogeneous Catalysis (Langmuir-Hinshelwood vs. Eley-Rideal)**\n• **Langmuir-Hinshelwood (L-H) Pathway:**\n  - Both reactants $A$ and $B$ must adsorb to adjacent surface sites:\n$$\n\\text{Rate} = k \\theta_A \\theta_B = \\frac{k K_A K_B P_A P_B}{(1 + K_A P_A + K_B P_B)^2}\n$$\n  - **Diagnostic Feature:** Exhibits a **Rate Maximum**! Excess $P_A$ monopolizes surface sites ($\\theta_A \\to 1, \\theta_B \\to 0$), suppressing the rate ($\\text{Rate} \\propto 1/P_A$).\n• **Eley-Rideal (E-R) Pathway:**\n  - Adsorbed $A^*$ reacts directly with collision from gas-phase $B(g)$:\n$$\n\\text{Rate} = k \\theta_A P_B = \\frac{k K_A P_A P_B}{1 + K_A P_A}\n$$\n  - **Diagnostic Feature:** Rate increases **monotonically/linearly with $P_B$** at all pressures.\n• **Sabatier Volcano Principle (1912):** Optimal catalysis requires **intermediate binding energy**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps of the Langmuir-Hinshelwood catalytic oxidation of CO on a platinum surface.",
      "orderItems": [
        "Gas-phase carbon monoxide (CO) and oxygen (O_2) diffuse from the bulk gas to the platinum catalyst surface",
        "CO chemisorbs molecularly and O_2 undergoes dissociative chemisorption to form adsorbed oxygen atoms (O*)",
        "Adsorbed CO* and O* species diffuse across the surface until they occupy adjacent neighboring platinum sites",
        "Elementary bimolecular surface reaction forms an activated, weakly bound carbon dioxide intermediate (CO_2*)",
        "Carbon dioxide rapidly desorbs into the gas phase, liberating two clean vacant platinum sites to continue the cycle"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each heterogeneous catalytic mechanism to its defining operational characteristic.",
      "matchPairs": [
        { "left": "Langmuir-Hinshelwood (L-H) Mechanism", "right": "Bimolecular reaction between two adsorbed species on adjacent sites; exhibits rate maximum" },
        { "left": "Eley-Rideal (E-R) Mechanism", "right": "Direct collision between a gas-phase molecule and an adsorbed surface species; rate linear in gas pressure" },
        { "left": "Sabatier Principle (Volcano Plot)", "right": "Maximum catalytic turnover occurs at intermediate bond strength between catalyst and adsorbate" },
        { "left": "Mars-van Krevelen Mechanism", "right": "Reactant oxidizes by consuming lattice oxygen atoms, followed by catalyst regeneration with O2 gas" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The fundamental concept in heterogeneous catalysis stating that optimal catalyst efficiency occurs at intermediate adsorption strength is the ___ principle.",
      "blankAnswer": "sabatier",
      "blankDistractors": ["lechatelier", "arrhenius", "pauling"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a catalytic reaction A(g) + B(g) -> Products over a metal catalyst, increasing the partial pressure of A (P_A) at first accelerates the reaction, but at very high P_A, the reaction rate drops sharply toward zero. What mechanism does this prove?",
      "options": [
        { "text": "The LANGMUIR-HINSHELWOOD (L-H) MECHANISM; because the reaction requires both A and B to be simultaneously adsorbed on adjacent surface sites, high P_A causes A to monopolize all vacant sites (theta_A -> 1), completely starving the surface of adsorbed B (theta_B -> 0) and suppressing the reaction rate", "isCorrect": true, "explanation": "Correct! In the Langmuir-Hinshelwood rate law Rate = k*K_A*K_B*P_A*P_B / (1 + K_A*P_A + K_B*P_B)², the denominator contains (K_A*P_A)². At very high P_A, the denominator grows as (P_A)², overpowering the linear P_A in the numerator and causing the rate to drop as 1/P_A. This self-poisoning through competitive site exclusion is the hallmark proof of an L-H mechanism." },
        { "text": "The Eley-Rideal mechanism", "isCorrect": false, "explanation": "Incorrect: In E-R, gas B does not compete for surface sites, so increasing P_A never drops the rate to zero." },
        { "text": "A homogeneous gas explosion", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A zero-order photochemical process", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
