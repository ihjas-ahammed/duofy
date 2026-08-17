# Duofy Reusable Lesson Format: State Machines (Mealy vs Moore FSM Synthesis)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Digital_Electronics_and_Microcontrollers / Combinational_and_Sequential_Logic`  
**Lesson Format Type:** `synchronous_finite_state_machines_mealy_vs_moore_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through synchronous Finite State Machine ($\text{FSM}$) formal models, state encoding strategies (Binary, Gray, One-Hot), state reduction theorems, and the architectural comparison between Mealy and Moore state machine paradigms in digital hardware design (George H. Mealy 1955; Edward F. Moore 1956; M. Morris Mano & Michael D. Ciletti *Digital Design* Chapter 5; John F. Wakerly *Digital Design* Chapter 8): formulate the **Two Master FSM Mathematical Models**:
1. **Moore Machine:**
   $$\mathbf{\text{Next State: } S(t+1) = \delta(S(t), X(t)) \quad \Big| \quad \mathbf{\text{Output: } Y(t) = \lambda(S(t))}}$$
   - **Glitch-Free Synchronous Behavior:** Output depends **strictly on the present state registers $S(t)$**; output changes occur strictly on clock edges;
2. **Mealy Machine:**
   $$\mathbf{\text{Next State: } S(t+1) = \delta(S(t), X(t)) \quad \Big| \quad \mathbf{\text{Output: } Y(t) = \lambda(S(t), X(t))}}$$
   - **Immediate Single-Cycle Response:** Output depends **simultaneously on present state $S(t)$ and current inputs $X(t)$**; typically requires **fewer states** than Moore, but input glitches propagate directly to outputs;
master the **Four-Step FSM Synthesis Protocol**:
(1) Word Specification $\to$ (2) State Transition Diagram & Table $\to$ (3) State Minimization & One-Hot/Binary Assignment $\to$ (4) Flip-Flop Next-State and Output Combinational Logic Synthesis.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Moore ($Y = f(S)$) vs Mealy ($Y = f(S, X)$) FSM Models & State Synthesis Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Synthesize a Synchronous Sequence Detector FSM Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | FSM Architecture / State Encoding & Technical Implementation Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Finite State Machine Whose Outputs Depend Exclusively on the Present State and NOT on Current Inputs Is a ___ Machine (Moore) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Digital Design Problem: Comparing State Count and Output Timing for a '101' Sequence Detector Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Mealy vs Moore FSMs (Mano & Ciletti 2018; Mealy 1955; Moore 1956):
   - **FSM Mathematical Formulations:**
     $$\mathbf{\text{Moore: } Y(t) = \lambda(S(t)) \quad \Big| \quad \text{Mealy: } Y(t) = \lambda(S(t), X(t)) \quad \Big| \quad S(t+1) = \delta(S(t), X(t))}$$
   - **Mealy vs Moore Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{FSM Family} & \textbf{Output Dependency} & \textbf{Typical State Count} & \textbf{Timing \\& Glitch Vulnerability} \\
     \hline
     \mathbf{\text{Moore Machine}} & \mathbf{Present State Only } S(t) & \mathbf{N+1 \text{ states (e.g. 4 states for '101')}} & \mathbf{\text{Glitch-free, synchronous with clock edge}} \\
     \mathbf{\text{Mealy Machine}} & \mathbf{Present State } S(t) \textbf{ + Input } X(t) & \mathbf{N \text{ states (e.g. 3 states for '101')}} & \text{Reacts immediately; input noise passes to output} \\
     \hline
     \end{array}$$
   - **The State Count Invariant:** A sequence detector for an $N$-bit sequence requires **$N+1$ states in a Moore machine** and **$N$ states in a Mealy machine**!
2. **Slide 2 (`ordering`):** Provide 5 steps of FSM synthesis: (1) draw state transition diagram defining reset state and sequence progression, (2) construct state table mapping present state and input to next state and output, (3) assign binary codes to states (e.g. $S_0=00, S_1=01, S_2=10, S_3=11$), (4) plot K-maps for next-state flip-flop inputs ($D_1, D_0$) and output $Y$, (5) derive simplified Boolean expressions and build schematic with D flip-flops and logic gates!
3. **Slide 3 (`matching`):** Pair 4 concepts (Moore Output $Y=f(S)$, Mealy Output $Y=f(S,X)$, One-Hot Encoding $1\text{ flip-flop per state}$, State Minimization) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Moore. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Mealy vs Moore sequence detector: A digital engineer designs a synchronous sequence detector to detect the incoming bit string '101' with overlapping sequences allowed. How many states are required for a Moore implementation compared to a Mealy implementation, and when does the output $Y$ assert logic 1? (For an $N=3$ bit sequence ('101'): Moore requires **4 states** ($S_0$: Reset/Init, $S_1$: got '1', $S_2$: got '10', $S_3$: got '101' where output $Y=1$ is tied to state $S_3$); Mealy requires **3 states** ($S_0$: Reset, $S_1$: got '1', $S_2$: got '10' where output $Y=1$ asserts immediately on the transition arrow from $S_2$ when input $X=1$; Moore has 4 states, Mealy has 3 states).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "synchronous_finite_state_machines_mealy_vs_moore_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Synchronous Finite State Machines (Moore vs Mealy)**\n• **Mathematical Governing Equations:**\n$$\n\\mathbf{\\text{Moore: } Y(t) = \\lambda(S(t)) \\quad \\Big| \\quad \\text{Mealy: } Y(t) = \\lambda(S(t), X(t)) \\quad \\Big| \\quad S(t+1) = \\delta(S(t), X(t))}\n$$\n• **The 4 Fundamental Architectural Tradeoffs:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Performance Dimension} & \\textbf{Moore State Machine} & \\textbf{Mealy State Machine} \\\\\n\\hline\n\\mathbf{\\text{Output Definition}} & \\mathbf{Y = f(\\text{Present State})} & \\mathbf{Y = f(\\text{Present State, Current Inputs})} \\\\\n\\mathbf{\\text{Sequence Detector States}} & \\mathbf{N + 1 \\text{ States (for } N\\text{-bit pattern)}} & \\mathbf{N \\text{ States (Fewer flip-flops)}} \\\\\n\\mathbf{\\text{Output Timing}} & \\text{Changes strictly on clock edge} & \\text{Responds immediately in current cycle} \\\\\n\\mathbf{\\text{Glitch Sensitivity}} & \\mathbf{\\text{High immunity (Glitch-free)}} & \\text{Input glitches propagate directly to output} \\\\\n\\hline\n\\end{array}\n$$\n• **The Moore Timing Invariant:** Because Moore outputs depend **strictly on state flip-flop outputs**, they are fully isolated from asynchronous input glitches and change strictly synchronously with clock edges!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design and synthesize a synchronous Finite State Machine from a word specification.",
      "orderItems": [
        "Create the formal State Transition Diagram showing all states, input-driven transitions, and outputs",
        "Construct the complete State Table mapping Present State and Inputs to Next State and Output values",
        "Perform state reduction/minimization and assign binary or One-Hot state codes to flip-flop variables",
        "Plot Karnaugh maps for each flip-flop next-state input (D, JK, or T) and output logic functions",
        "Derive minimized Boolean equations and assemble the schematic with clock-synchronized flip-flops"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each FSM Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Moore Machine", "right": "Y = f(State), output depends exclusively on present state registers, ensuring glitch-free operation" },
        { "left": "Mealy Machine", "right": "Y = f(State, Input), output depends on present state and current input, saving states but prone to glitches" },
        { "left": "One-Hot State Encoding", "right": "Using exactly 1 flip-flop per state (e.g. 0001, 0010, 0100, 1000) to eliminate combinational decoding logic" },
        { "left": "Sequence Detector (N-bit)", "right": "Requires N+1 states in a Moore machine versus N states in a Mealy machine" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A finite state machine whose output depends exclusively on the present state and not on current inputs is a ___ machine.",
      "blankAnswer": "Moore",
      "blankDistractors": ["Mealy", "Turing", "Shannon"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A synchronous sequence detector is designed to detect the 3-bit binary pattern '101' in an incoming serial bitstream with overlapping sequences allowed. How many states are required for a Moore machine versus a Mealy machine implementation?",
      "options": [
        { "text": "Moore requires 4 states and Mealy requires 3 states (For N=3: Moore needs states for [Init, Got 1, Got 10, Got 101]; Mealy needs [Init, Got 1, Got 10] with output asserting on the transition arrow back to Got 1 when X=1)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Finite State Machine synthesis rules (M. Morris Mano & Michael D. Ciletti *Digital Design* Chapter 5). 1. **Moore Machine State Analysis ($N = 3$ bits '101'):** - $S_0$ (State 0): Reset / No matching bits (Output $Y = 0$). - $S_1$ (State 1): Detected initial '1' (Output $Y = 0$). - $S_2$ (State 2): Detected string '10' (Output $Y = 0$). - $S_3$ (State 3): Detected complete string '101' (Output $\\mathbf{Y = 1}$). - **Total Moore States = $N + 1 = 3 + 1 = \\mathbf{4\\text{ states}}$**. 2. **Mealy Machine State Analysis:** - $S_0$: Reset / No matching bits. - $S_1$: Detected '1'. - $S_2$: Detected '10'. - When in state $S_2$, if next input bit is $X = 1$, the complete sequence '101' is recognized immediately! The transition arrow loops back to $S_1$ with output label **$X/Y = 1/1$**. - **Total Mealy States = $N = \\mathbf{3\\text{ states}}$**. 3. **Summary Comparison:** Moore has **4 states** (glitch-free); Mealy has **3 states** (faster 1-cycle output assertion)!" },
        { "text": "Moore requires 3 states and Mealy requires 4 states", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both Moore and Mealy require exactly 3 states", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Moore requires 5 states and Mealy requires 2 states", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
