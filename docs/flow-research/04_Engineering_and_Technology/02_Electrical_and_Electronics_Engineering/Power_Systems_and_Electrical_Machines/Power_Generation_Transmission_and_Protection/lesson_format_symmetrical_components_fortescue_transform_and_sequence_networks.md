# Duofy Reusable Lesson Format: Symmetrical Components (Fortescue Transform & Sequence Networks)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Power_Systems_and_Electrical_Machines / Power_Generation_Transmission_and_Protection`  
**Lesson Format Type:** `symmetrical_components_fortescue_transform_and_sequence_networks`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical decomposition of unbalanced three-phase power systems into three sets of balanced symmetrical components: Positive Sequence ($a\text{-}b\text{-}c$ phase sequence), Negative Sequence ($a\text{-}c\text{-}b$ reversed phase sequence), and Zero Sequence (three identical unshifted in-phase components), the complex $120^\circ$ rotation operator ($a = e^{j 120^\circ}$), and the synthesis of uncoupled sequence impedance networks ($Z_1, Z_2, Z_0$) in power system analysis (Charles LeGeyt Fortescue 1918; Hadi Saadat *Power System Analysis* Chapter 10; J. Duncan Glover *Power System Analysis and Design* Chapter 8): formulate the **Fortescue Transformation Matrix Formulation**:
$$\mathbf{\begin{bmatrix} I_a \\ I_b \\ I_c \end{bmatrix} = \begin{bmatrix} 1 & 1 & 1 \\ 1 & a^2 & a \\ 1 & a & a^2 \end{bmatrix} \begin{bmatrix} I_{a0} \\ I_{a1} \\ I_{a2} \end{bmatrix} \Longleftrightarrow \mathbf{\begin{bmatrix} I_{a0} \\ I_{a1} \\ I_{a2} \end{bmatrix} = \frac{1}{3} \begin{bmatrix} 1 & 1 & 1 \\ 1 & a & a^2 \\ 1 & a^2 & a \end{bmatrix} \begin{bmatrix} I_a \\ I_b \\ I_c \end{bmatrix}}}$$
where the complex phasor operator $a$ is defined as:
$$\mathbf{a = 1 \angle 120^\circ = -\frac{1}{2} + j \frac{\sqrt{3}}{2} \quad \Big| \quad a^2 = 1 \angle 240^\circ = -\frac{1}{2} - j \frac{\sqrt{3}}{2} \quad \Big| \quad 1 + a + a^2 = 0}$$
master the **Three Sequence Components**:
1. **Positive Sequence ($I_{a1}, I_{b1} = a^2 I_{a1}, I_{c1} = a I_{a1}$):** Balanced set with normal phase sequence $a\text{-}b\text{-}c$; represents normal balanced power generation;
2. **Negative Sequence ($I_{a0}, I_{b2} = a I_{a2}, I_{c2} = a^2 I_{a2}$):** Balanced set with reversed phase sequence $a\text{-}c\text{-}b$; produces counter-rotating magnetic fields causing rotor heating;
3. **Zero Sequence ($I_{a0} = I_{b0} = I_{c0}$):** Three identical phasors in-phase; flow requires a physical ground return path ($I_n = I_a + I_b + I_c = 3 I_{a0}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fortescue Transform ($I_{012} = \mathbf{A}^{-1} I_{abc}$), Operator $a = e^{j 120^\circ}$ & Sequence Networks Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Resolve Unbalanced Phase Currents into Sequence Components Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sequence Component / Network Parameter & Technical Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a 4-Wire Three-Phase System, the Neutral Ground Return Current In Equals Exactly ___ Times the Zero Sequence Current Ia0 (Three / 3) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Unbalanced Grid Problem: Computing Zero, Positive, and Negative Sequence Currents from Phase Currents Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Fortescue Transform & Sequence Networks (Fortescue 1918; Saadat 2010):
   - **Transformation Formulations:**
     $$\mathbf{I_{012} = \frac{1}{3}\begin{bmatrix} 1 & 1 & 1 \\ 1 & a & a^2 \\ 1 & a^2 & a \end{bmatrix} \begin{bmatrix} I_a \\ I_b \\ I_c \end{bmatrix} \quad \Big| \quad a = e^{j 120^\circ} \quad \Big| \quad a^2 = e^{j 240^\circ} \quad \Big| \quad 1 + a + a^2 = 0}$$
   - **Sequence Component Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Sequence Set} & \textbf{Phase Shift Sequence} & \textbf{Physical Nature} & \textbf{Network Source} \\
     \hline
     \mathbf{\text{Positive } (I_1)} & I_{a1}, \ I_{b1} = I_{a1}\angle -120^\circ, \ I_{c1} = I_{a1}\angle +120^\circ & \text{Balanced normal rotation } a\text{-}b\text{-}c & \mathbf{\text{Internal generator EMF } (E_a)} \\
     \mathbf{\text{Negative } (I_2)} & I_{a2}, \ I_{b2} = I_{a2}\angle +120^\circ, \ I_{c2} = I_{a2}\angle -120^\circ & \text{Reverse rotation } a\text{-}c\text{-}b \text{ (2x freq on rotor)} & \text{Passive impedance only } (Z_2) \\
     \mathbf{\text{Zero } (I_0)} & \mathbf{I_{a0} = I_{b0} = I_{c0} \ (\text{Zero Phase Shift})} & \mathbf{\text{Unbalanced ground return: } I_n = 3 I_{a0}} & \mathbf{\text{Passes only through grounded neutrals}} \\
     \hline
     \end{array}$$
   - **The Neutral Current Invariant:** Zero-sequence currents are identical across all three phases; therefore, the neutral current is **strictly equal to $3 I_{a0}$**; in ungrounded 3-wire systems, zero sequence current **cannot physically exist ($I_{a0} = 0$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of symmetrical components calculation: (1) express unbalanced phase currents $I_a, I_b, I_c$ in complex polar form, (2) compute zero-sequence current $I_{a0} = \frac{1}{3}(I_a + I_b + I_c)$, (3) compute positive-sequence current $I_{a1} = \frac{1}{3}(I_a + a I_b + a^2 I_c)$, (4) compute negative-sequence current $I_{a2} = \frac{1}{3}(I_a + a^2 I_b + a I_c)$, (5) verify completeness: $I_a = I_{a0} + I_{a1} + I_{a2}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Complex Operator $a = 1\angle 120^\circ$, Zero Sequence $I_{a0} = I_n/3$, Positive Sequence $I_{a1}$, Negative Sequence $I_{a2}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Three (or 3). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating symmetrical components: In an unbalanced 3-phase system, the measured phase currents are $I_a = 10 \angle 0^\circ\text{ A}$, $I_b = 0\text{ A}$, and $I_c = 0\text{ A}$ (single-phase load). What is the zero-sequence current $I_{a0}$, positive-sequence current $I_{a1}$, and negative-sequence current $I_{a2}$? ($I_{a0} = \frac{1}{3}(10\angle 0^\circ + 0 + 0) = \mathbf{\frac{10}{3}\angle 0^\circ\text{ A} \approx 3.33\angle 0^\circ\text{ A}}$; $I_{a1} = \frac{1}{3}(10\angle 0^\circ + a(0) + a^2(0)) = \mathbf{\frac{10}{3}\angle 0^\circ\text{ A} \approx 3.33\angle 0^\circ\text{ A}}$; $I_{a2} = \frac{1}{3}(10\angle 0^\circ + a^2(0) + a(0)) = \mathbf{\frac{10}{3}\angle 0^\circ\text{ A} \approx 3.33\angle 0^\circ\text{ A}}$; All three sequence components are identical: $I_{a0} = I_{a1} = I_{a2} = \mathbf{3.33\angle 0^\circ\text{ A}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "symmetrical_components_fortescue_transform_and_sequence_networks",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fortescue Symmetrical Components (Charles Fortescue 1918)**\n• **Transformation Matrix Formulations:**\n$$\n\\mathbf{\\begin{bmatrix} I_{a0} \\\\ I_{a1} \\\\ I_{a2} \\end{bmatrix} = \\frac{1}{3} \\begin{bmatrix} 1 & 1 & 1 \\\\ 1 & a & a^2 \\\\ 1 & a^2 & a \\end{bmatrix} \\begin{bmatrix} I_a \\\\ I_b \\\\ I_c \\end{bmatrix} \\Longleftrightarrow \\mathbf{\\begin{bmatrix} I_a \\\\ I_b \\\\ I_c \\end{bmatrix} = \\begin{bmatrix} 1 & 1 & 1 \\\\ 1 & a^2 & a \\\\ 1 & a & a^2 \\end{bmatrix} \\begin{bmatrix} I_{a0} \\\\ I_{a1} \\\\ I_{a2} \\end{bmatrix}}}\n$$\n• **The Complex Phasor Operator ($a$):**\n$$\n\\mathbf{a = 1 \\angle 120^\\circ = -0.5 + j 0.866 \\quad \\Big| \\quad a^2 = 1 \\angle 240^\\circ = -0.5 - j 0.866 \\quad \\Big| \\quad \\mathbf{1 + a + a^2 = 0}}\n$$\n• **The 3 Sequence Sets:**\n  - **Positive Sequence ($I_{a1}$):** Balanced $a\\text{-}b\\text{-}c$ rotation driven by generator internal EMF;\n  - **Negative Sequence ($I_{a2}$):** Balanced $a\\text{-}c\\text{-}b$ reversed rotation creating double-frequency rotor currents;\n  - **Zero Sequence ($I_{a0}$):** In-phase triplets strictly requiring a ground return: $\\mathbf{I_n = 3 I_{a0}}$!\n• **The Neutral Invariant:** In ungrounded 3-wire systems with no neutral connection, zero-sequence current **cannot flow under any circumstance ($I_{a0} = 0$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to decompose unbalanced three-phase currents into their symmetrical sequence components.",
      "orderItems": [
        "Record the complex phasor magnitudes and angles of the three unbalanced phase currents: Ia, Ib, and Ic",
        "Compute the zero-sequence component by averaging the three phase currents: Ia0 = (1/3) * (Ia + Ib + Ic)",
        "Compute the positive-sequence component using the forward operator: Ia1 = (1/3) * (Ia + a*Ib + a^2*Ic)",
        "Compute the negative-sequence component using the reverse operator: Ia2 = (1/3) * (Ia + a^2*Ib + a*Ic)",
        "Verify accuracy by reconstructing the original phase A current: Ia = Ia0 + Ia1 + Ia2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Sequence Network Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Positive Sequence (Ia1)", "right": "Balanced three-phase components with normal a-b-c rotation energized by internal generator EMFs" },
        { "left": "Negative Sequence (Ia2)", "right": "Balanced three-phase components with reversed a-c-b rotation produced exclusively by unbalance" },
        { "left": "Zero Sequence (Ia0)", "right": "Three identical in-phase currents whose sum flows through the grounded neutral return path In = 3*Ia0" },
        { "left": "Phasor Operator (a)", "right": "a = 1\u2220120\u00b0, complex operator rotating any phasor by 120\u00b0 counter-clockwise" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a four-wire three-phase system, the neutral ground return current In equals exactly ___ times the zero-sequence current Ia0.",
      "blankAnswer": "3",
      "blankDistractors": ["1", "6", "1.732"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In an unbalanced three-phase power circuit, an open conductor results in phase currents Ia = 10\u22200\u00b0 A, Ib = 0 A, and Ic = 0 A. What are the sequence components Ia0, Ia1, and Ia2?",
      "options": [
        { "text": "Ia0 = 3.33\u22200\u00b0 A, Ia1 = 3.33\u22200\u00b0 A, and Ia2 = 3.33\u22200\u00b0 A (Ia0 = (1/3)(10+0+0) = 3.33\u22200\u00b0; Ia1 = (1/3)(10+0+0) = 3.33\u22200\u00b0; Ia2 = (1/3)(10+0+0) = 3.33\u22200\u00b0; all three sequence components are strictly equal)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Fortescue's symmetrical components equations (Hadi Saadat *Power System Analysis* Chapter 10). 1. **Calculate Zero-Sequence Component ($I_{a0}$):** $$I_{a0} = \\frac{1}{3} (I_a + I_b + I_c) = \\frac{1}{3} (10\\angle 0^\\circ + 0 + 0) = \\mathbf{\\frac{10}{3}\\angle 0^\\circ\\text{ A} \\approx 3.333\\angle 0^\\circ\\text{ A}}$$ 2. **Calculate Positive-Sequence Component ($I_{a1}$):** $$I_{a1} = \\frac{1}{3} (I_a + a I_b + a^2 I_c) = \\frac{1}{3} (10\\angle 0^\\circ + a(0) + a^2(0)) = \\mathbf{\\frac{10}{3}\\angle 0^\\circ\\text{ A} \\approx 3.333\\angle 0^\\circ\\text{ A}}$$ 3. **Calculate Negative-Sequence Component ($I_{a2}$):** $$I_{a2} = \\frac{1}{3} (I_a + a^2 I_b + a I_c) = \\frac{1}{3} (10\\angle 0^\\circ + a^2(0) + a(0)) = \\mathbf{\\frac{10}{3}\\angle 0^\\circ\\text{ A} \\approx 3.333\\angle 0^\\circ\\text{ A}}$$ 4. **Verification:** $$I_a = I_{a0} + I_{a1} + I_{a2} = 3.333 + 3.333 + 3.333 = \\mathbf{10.0\\angle 0^\\circ\\text{ A}}$$ 5. **Theoretical Insight:** A single-phase load on a 3-phase grid excites **equal quantities of positive, negative, and zero sequence currents**!" },
        { "text": "Ia0 = 10.0\u22200\u00b0 A, Ia1 = 0 A, and Ia2 = 0 A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ia0 = 0 A, Ia1 = 5.0\u22200\u00b0 A, and Ia2 = 5.0\u22200\u00b0 A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ia0 = 3.33\u22200\u00b0 A, Ia1 = 6.67\u22200\u00b0 A, and Ia2 = 0 A", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
