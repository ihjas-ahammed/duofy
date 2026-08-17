# Duofy Reusable Lesson Format: Deterministic Turing Machines and Configuration Transitions

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Turing_Machines_and_Computability / Turing_Machine_Formulations`  
**Lesson Format Type:** `deterministic_turing_machines_and_configuration_transitions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the formal 7-tuple mathematical structure, instantaneous configuration syntax, and discrete state-transition mechanics of Deterministic Turing Machines (Alan M. Turing 1936; Michael Sipser Chapter 3.1): master the **7-Tuple Definition ($M = (Q, \Sigma, \Gamma, \delta, q_0, q_{\text{accept}}, q_{\text{reject}})$)** where $\Gamma$ contains the blank symbol $\text{\textvisiblespace}$ ($\Sigma \subset \Gamma$), decode the **Deterministic Transition Function ($\mathbf{\delta: Q \times \Gamma \to Q \times \Gamma \times \{L, R\}})$**, formulate **Instantaneous Configurations ($\mathbf{u q v}$ meaning: current state is $q$, tape contents are $u v$, and tape head points to the first symbol of $v$)**, trace step-by-step configuration transitions ($u a q_i b v \vdash u q_j a c v$ on left move; $u a q_i b v \vdash u a c q_j v$ on right move), and trace Turing machines deciding non-regular languages such as $L = \{w \# w \mid w \in \{0, 1\}^*\}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DTM 7-Tuple Architecture, Transition Function Signature, & Configuration Syntax Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Configuration Trajectory Deciding String Equality w # w Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Turing Machine Formal 7-Tuple Component & Mathematical Invariant Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Special Tape Symbol Representing Unwritten Infinite Cells (Blank) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Meaning of Configuration Notation u q v in Turing Machine State Formalisms Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Deterministic Turing Machines (Turing 1936; Sipser Section 3.1):
   - **The 7-Tuple Mathematical Definition:** $M = (Q, \Sigma, \Gamma, \delta, q_0, q_{\text{accept}}, q_{\text{reject}})$ where:
     - $Q$: Finite set of states; $\Sigma$: Input alphabet ($\text{\textvisiblespace} \notin \Sigma$).
     - $\Gamma$: Tape alphabet where $\Sigma \subset \Gamma$ and blank symbol $\text{\textvisiblespace} \in \Gamma$.
     - $\mathbf{\delta: Q \times \Gamma \to Q \times \Gamma \times \{L, R\}}$ (Deterministic transition mapping).
     - $q_0 \in Q$: Start state; $q_{\text{accept}} \in Q$: Unique accept state; $q_{\text{reject}} \in Q$: Unique reject state ($q_{\text{accept}} \ne q_{\text{reject}}$).
   - **Instantaneous Configuration ($u q v$):**
     - String $u \in \Gamma^*$ is tape to the left of the head.
     - State $q \in Q$ is current state.
     - String $v \in \Gamma^*$ is tape from head position to the rightmost non-blank symbol.
   - **Configuration Transition ($\vdash$):**
     - If $\delta(q_i, b) = (q_j, c, R) \implies u a q_i b v \vdash u a c q_j v$.
     - If $\delta(q_i, b) = (q_j, c, L) \implies u a q_i b v \vdash u q_j a c v$.
2. **Slide 2 (`ordering`):** Provide 5 steps of a Turing Machine deciding language $L = \{w \# w \mid w \in \{0, 1\}^*\}$ on input "01#01": (1) start in configuration q0 01#01, cross off the first symbol '0' by writing marker 'x' and transitioning to state q_seen0, (2) move tape head right past remaining characters and delimiter '#' into the second half of the tape, (3) locate the first unmarked symbol '0' after '#', verify it matches '0', and replace it with marker 'x', (4) move tape head left all the way back across '#' to the first unmarked symbol in the first half ('1'), (5) repeat zigzag matching until all symbols on both sides of '#' are crossed off with 'x', entering configuration q_accept!
3. **Slide 3 (`matching`):** Pair 4 TM formal components (Input Alphabet Sigma, Tape Alphabet Gamma, Transition Function delta, Reject State q_reject) with their mathematical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that unwritten infinite tape cells contain the blank symbol. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the formal configuration notation $u q v$: In standard theoretical computer science configuration notation, if a Turing machine is in configuration $1011 q_4 001$, what is the exact physical position of the tape head and what character is currently being scanned? (The tape contents are $1011001$, the current state is $q_4$, and **the tape head is scanning the character `'0'` immediately to the right of $q_4$ (the fifth character on the tape)**; the prefix $1011$ is to the left of the head, and $001$ begins at the head position).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "deterministic_turing_machines_and_configuration_transitions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Deterministic Turing Machines (DTM) (Turing 1936)**\n• **The Formal 7-Tuple ($M = (Q, \\Sigma, \\Gamma, \\delta, q_0, q_{\\text{accept}}, q_{\\text{reject}})$):**\n$$\n\\mathbf{\\delta: Q \\times \\Gamma \\to Q \\times \\Gamma \\times \\{L, R\\} \\qquad (\\text{Read } \\to \\text{ Write, Move Head } L/R, \\text{ Change State})}\n$$\n• **Instantaneous Configuration Notation ($u q v$):**\n$$\n\\mathbf{u = \\text{Tape left of head}} \\ ; \\quad \\mathbf{q = \\text{Current State}} \\ ; \\quad \\mathbf{v = \\text{Tape under and right of head}}\n$$\n• **Step Transitions ($\\vdash$):**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{Head Movement} & \\textbf{Configuration Step} \\\\\n\\hline\n\\mathbf{\\text{Right Move } (R)} & u a q_i b v \\vdash u a c q_j v \\quad (\\text{if } \\delta(q_i, b) = (q_j, c, R)) \\\\\n\\mathbf{\\text{Left Move } (L)} & u a q_i b v \\vdash u q_j a c v \\quad (\\text{if } \\delta(q_i, b) = (q_j, c, L)) \\\\\n\\hline\n\\end{array}\n$$\n• **Halting States:** Reaching $q_{\\text{accept}}$ or $q_{\\text{reject}}$ **instantly terminates execution**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of a Turing Machine configuration trajectory deciding the string equality language L = {w # w}.",
      "orderItems": [
        "Initialize in start configuration q0 01#01, cross off the leading symbol '0' by writing marker 'x', transitioning to state q_zero",
        "Sweep tape head rightward across intermediate symbols and skip past the central delimiter character '#'",
        "Locate the first unmarked symbol after '#', verify it matches expected character '0', and overwrite it with marker 'x'",
        "Move tape head leftward across the tape until returning to the leftmost remaining unmarked character in the first half",
        "Repeat zigzag match sweeps until all symbols are verified and replaced with 'x', transitioning to configuration q_accept"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Turing Machine formal 7-tuple component to its exact mathematical specification.",
      "matchPairs": [
        { "left": "Input Alphabet (Sigma)", "right": "Finite set of input symbols allowed in initial string; excludes the blank symbol" },
        { "left": "Tape Alphabet (Gamma)", "right": "Superset of input alphabet containing special scratchpad markers and the blank character" },
        { "left": "Transition Function (delta)", "right": "Deterministic mapping Q x Gamma -> Q x Gamma x {L, R} dictating next step actions" },
        { "left": "Dedicated Reject State", "right": "Unique halting state that immediately ceases computation and rejects the input string" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Turing Machine, the infinitely many empty tape cells extending to the right are filled with the ___ symbol.",
      "blankAnswer": "blank",
      "blankDistractors": ["null", "zero", "stop"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In standard theoretical computer science configuration notation, if a Turing Machine is in configuration 1011 q4 001, what is the exact position of the tape head and what character is currently being scanned?",
      "options": [
        { "text": "The tape contents are 1011001, the internal state of the machine is q4, and the tape head is currently positioned over and scanning the character '0' immediately to the right of q4 (the fifth character on the tape); the string 1011 represents the tape contents to the left of the head", "isCorrect": true, "explanation": "Correct! This is the standard configuration notation developed in computability theory (Michael Sipser Section 3.1). In formal Turing Machine semantics, a configuration is written as $u q v$, where: 1. $u \\in \\Gamma^*$ represents the string of tape characters strictly to the left of the read/write tape head. 2. $q \\in Q$ represents the current control state of the finite state controller. 3. $v \\in \\Gamma^*$ represents the string of tape characters from the current tape head position extending to the right (up to the last non-blank symbol). 4. Crucially, the tape head is ALWAYS positioned directly over the FIRST symbol of string $v$. In the configuration $1011 q_4 001$: The string to the left of the head is $1011$ (length 4). The state is $q_4$. The string starting at the head is $001$. Therefore, the tape head is positioned over index 5 (the first zero of $001$). The total active tape content is $1011001$." },
        { "text": "The tape head is positioned over the number 4", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The tape head is positioned at the very first character '1'", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The machine has crashed because q4 is not a valid binary digit", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
