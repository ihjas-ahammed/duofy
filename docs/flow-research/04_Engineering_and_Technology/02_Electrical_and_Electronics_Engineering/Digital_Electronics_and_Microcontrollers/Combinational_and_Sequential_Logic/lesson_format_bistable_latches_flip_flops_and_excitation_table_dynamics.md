# Duofy Reusable Lesson Format: Sequential Storage (Latches, Flip-Flops, & Excitation)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Digital_Electronics_and_Microcontrollers / Combinational_and_Sequential_Logic`  
**Lesson Format Type:** `bistable_latches_flip_flops_and_excitation_table_dynamics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through bistable multivibrators, level-sensitive latches vs edge-triggered master-slave flip-flops, race conditions, characteristic equations, and excitation transition tables in synchronous digital memory design (M. Morris Mano & Michael D. Ciletti *Digital Design* Chapter 5; John F. Wakerly Chapter 7): derive the **Four Canonical Flip-Flop Characteristic Equations**:
1. **D Flip-Flop (Data Delay):**
   $$\mathbf{Q(t+1) = D}$$
2. **T Flip-Flop (Toggle):**
   $$\mathbf{Q(t+1) = T \oplus Q = T \overline{Q} + \overline{T} Q}$$
3. **JK Flip-Flop (Universal Memory):**
   $$\mathbf{Q(t+1) = J \overline{Q} + \overline{K} Q}$$
   (eliminating the SR race hazard by toggling when $J = K = 1$);
4. **SR Flip-Flop (Set-Reset):**
   $$\mathbf{Q(t+1) = S + \overline{R} Q \quad (S \cdot R = 0 \text{ constraint})}$$
master the **Universal Flip-Flop Excitation Mapping Matrix**:
$$\begin{array}{|c|c|c|c|c|c|}
\hline
\textbf{Present State } Q & \textbf{Next State } Q_{\text{next}} & \textbf{D Input} & \textbf{T Input} & \textbf{J Input} & \textbf{K Input} \\
\hline
0 & 0 & 0 & 0 & 0 & X \ (\text{Don't Care}) \\
0 & 1 & 1 & 1 & 1 & X \\
1 & 0 & 0 & 1 & X & 1 \\
1 & 1 & 1 & 0 & X & 0 \\
\hline
\end{array}$$
(which serves as the mathematical foundation for synthesizing synchronous counter next-state logic).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Characteristic Equations ($Q_{\text{next}} = J\overline{Q} + \overline{K}Q$), Excitation Tables & Edge Triggering Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Synthesize Next-State Logic for a Synchronous Mod-4 Up Counter Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Flip-Flop Family / Operating Mode & Technical State Transition Signature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Flip-Flop Whose Next State Is Governed by the Characteristic Equation Q(t+1) = T XOR Q Is the ___ Flip-Flop (T / Toggle) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Synchronous Counter Problem: Determining the Required J-K Excitation Inputs for a State Transition Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Flip-Flop Dynamics & Excitation (Mano & Ciletti 2018; Wakerly 2018):
   - **Characteristic Formulations:**
     $$\mathbf{Q_D(t+1) = D \quad \Big| \quad Q_T(t+1) = T \oplus Q \quad \Big| \quad Q_{JK}(t+1) = J \overline{Q} + \overline{K} Q \quad \Big| \quad Q_{SR}(t+1) = S + \overline{R}Q}$$
   - **Excitation Transition Matrix:**
     $$\begin{array}{|c|c|c|c|c|c|}
     \hline
     \text{Transition } Q \to Q_{\text{next}} & \text{Required } D & \text{Required } T & \text{Required } J & \text{Required } K \\
     \hline
     \mathbf{0 \to 0} & 0 & 0 & \mathbf{0} & \mathbf{X} \\
     \mathbf{0 \to 1} & 1 & 1 & \mathbf{1} & \mathbf{X} \\
     \mathbf{1 \to 0} & 0 & 1 & \mathbf{X} & \mathbf{1} \\
     \mathbf{1 \to 1} & 1 & 0 & \mathbf{X} & \mathbf{0} \\
     \hline
     \end{array}$$
   - **The Edge-Triggering Invariant:** Edge-triggered flip-flops sample data **only during the infinitesimal clock edge transition ($\Delta t \to 0$)**, preventing level-sensitive latch race-around loops!
2. **Slide 2 (`ordering`):** Provide 5 steps to design a synchronous counter with JK flip-flops: (1) determine required state sequence (e.g. $00 \to 01 \to 10 \to 11 \to 00$), (2) create state transition table listing Present State $(Q_1, Q_0)$ and Next State $(Q_{1,\text{next}}, Q_{0,\text{next}})$, (3) look up JK excitation rules to fill in required inputs $(J_1, K_1, J_0, K_0)$, (4) plot required inputs on K-maps as functions of present state variables $Q_1, Q_0$, (5) derive simplified logic expressions for $J$ and $K$ and connect to flip-flop clock inputs!
3. **Slide 3 (`matching`):** Pair 4 concepts (D Flip-Flop $Q_{\text{next}}=D$, T Flip-Flop $Q_{\text{next}}=T \oplus Q$, JK Toggle Mode $J=K=1 \to \overline{Q}$, JK Excitation $0 \to 1 \implies J=1, K=X$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of T (or Toggle). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on JK flip-flop excitation: A synchronous counter requires a JK flip-flop to transition from present state $Q = 1$ to next state $Q_{\text{next}} = 0$ on the next clock pulse. What are the required values for inputs $J$ and $K$? ($Q = 1 \to Q_{\text{next}} = 0$; Characteristic equation: $Q_{\text{next}} = J \overline{Q} + \overline{K} Q = J(0) + \overline{K}(1) = \overline{K}$; We require $\overline{K} = 0 \implies \mathbf{K = 1}$; Because $J$ is multiplied by $\overline{Q} = 0$, $J$ can be either $0$ or $1$ without affecting the output, so $\mathbf{J = X\text{ (Don't Care)}}$; Required excitation: $\mathbf{J = X, K = 1}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bistable_latches_flip_flops_and_excitation_table_dynamics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bistable Flip-Flops \\& Excitation Dynamics (Morris Mano)**\n• **Characteristic Next-State Formulations:**\n$$\n\\mathbf{Q_D(t+1) = D \\quad \\Big| \\quad Q_T(t+1) = T \\oplus Q \\quad \\Big| \\quad \\mathbf{Q_{JK}(t+1) = J \\overline{Q} + \\overline{K} Q}}\n$$\n• **Universal Excitation Mapping Table:**\n$$\n\\begin{array}{|c|c|c|c|c|c|}\n\\hline\n\\textbf{Present State } Q & \\textbf{Next State } Q_{\\text{next}} & \\textbf{D Input} & \\textbf{T Input} & \\textbf{J Input} & \\textbf{K Input} \\\\\n\\hline\n\\mathbf{0} & \\mathbf{0} & 0 & 0 & \\mathbf{0} & \\mathbf{X \\ (\\text{Don't Care})} \\\\\n\\mathbf{0} & \\mathbf{1} & 1 & 1 & \\mathbf{1} & \\mathbf{X} \\\\\n\\mathbf{1} & \\mathbf{0} & 0 & 1 & \\mathbf{X} & \\mathbf{1} \\\\\n\\mathbf{1} & \\mathbf{1} & 1 & 0 & \\mathbf{X} & \\mathbf{0} \\\\\n\\hline\n\\end{array}\n$$\n• **The JK Universality Invariant:** When $J = K = 1$, the JK flip-flop **strictly toggles ($Q(t+1) = \\overline{Q}$)**, completely eliminating the invalid/forbidden race condition that plagues classic SR latches!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to synthesize the combinational next-state logic for a synchronous counter using JK flip-flops.",
      "orderItems": [
        "Construct the complete state transition diagram and sequence table for all counter states",
        "Form the Present State (Q) to Next State (Q_next) truth table for each flip-flop bit",
        "Apply the universal JK excitation rules to fill in the required J and K input values (including Don't Cares X)",
        "Plot Karnaugh maps for each J and K input as functions of the present state variables",
        "Extract the minimal Sum-of-Products logic equations for J and K and connect to the flip-flop inputs"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Flip-Flop Type to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "D Flip-Flop", "right": "Q(t+1) = D, single-input transparent data register copying input on active clock edge" },
        { "left": "T Flip-Flop", "right": "Q(t+1) = T ^ Q, binary toggle element used in ripple and synchronous binary counters" },
        { "left": "JK Flip-Flop Toggle Mode", "right": "J = 1 and K = 1, forcing output to invert state on every clock pulse" },
        { "left": "JK Excitation (1 \u2192 0)", "right": "J = X and K = 1, forcing a reset or toggle transition from logic 1 to logic 0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The flip-flop whose next state is governed by the characteristic equation Q(t+1) = T XOR Q is the ___ flip-flop.",
      "blankAnswer": "T",
      "blankDistractors": ["D", "JK", "SR"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a synchronous digital counter design, a JK flip-flop must transition from present state Q = 1 to next state Q_next = 0 upon the next clock pulse. What are the required values for inputs J and K?",
      "options": [
        { "text": "J = X (Don't Care) and K = 1 (Since Q=1, Q_next = J*0 + K_bar*1 = K_bar; to make Q_next = 0, K_bar must be 0 \u2192 K = 1; J has no effect since it multiplies Q_bar = 0, so J = X)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the JK flip-flop characteristic equation and excitation table (M. Morris Mano *Digital Design* Chapter 5). 1. **Recall the JK Characteristic Equation:** $$Q(t+1) = J \\overline{Q} + \\overline{K} Q$$ 2. **Substitute Present State $Q = 1$ (which means $\\overline{Q} = 0$):** $$Q(t+1) = J(0) + \\overline{K}(1) = \\overline{K}$$ 3. **Equate to Desired Next State $Q(t+1) = 0$:** $$\\overline{K} = 0 \\implies \\mathbf{K = 1}$$ 4. **Evaluate Input $J$:** - Because the term $J \\overline{Q} = J \\cdot 0 = 0$ regardless of whether $J = 0$ or $J = 1$, the value of $J$ is completely irrelevant! - Therefore, $\\mathbf{J = X\\text{ (Don't Care)}}$. 5. **Final Excitation Pair:** $$\\mathbf{J = X, \\quad K = 1}$$ Flawless sequential excitation derivation!" },
        { "text": "J = 0 and K = 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "J = 1 and K = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "J = 0 and K = X", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
