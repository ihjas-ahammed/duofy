# Duofy Reusable Lesson Format: Physical Layout (Stick Diagrams & Euler Path Sharing)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / CMOS_Inverter_Physics_and_Layout`  
**Lesson Format Type:** `cmos_stick_diagrams_euler_path_and_diffusion_sharing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through physical CMOS integrated circuit layout design, color-coded layer conventions (Mead-Conway $\lambda$-rules: Green/Yellow for Diffusion, Red for Polysilicon, Blue for Metal-1, Black X for Contacts), symbolic Stick Diagrams, and graph-theoretic Euler Path optimization to maximize source-drain diffusion sharing and eliminate layout area breaks in complex standard cells like AND-OR-INVERT ($\text{AOI21}, \text{AOI22}$) (Carver Mead & Lynn Conway 1980; Neil Weste & David Harris *CMOS VLSI Design* Chapter 1 & 3; Sung-Mo Kang *CMOS Digital Integrated Circuits* Chapter 6): formulate the **Mead-Conway Layer Hierarchy**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{Layout Layer} & \textbf{Standard Color} & \textbf{Material} & \textbf{Mask Role / Connectivity} \\
\hline
\mathbf{\text{n-Diffusion / Active}} & \text{Green} & n^+\text{-doped silicon} & \text{NMOS source and drain regions} \\
\mathbf{\text{p-Diffusion / Active}} & \text{Yellow (or Orange)} & p^+\text{-doped silicon} & \text{PMOS source and drain regions} \\
\mathbf{\text{Polysilicon}} & \text{Red} & \text{Polycrystalline silicon} & \text{Transistor Gate control lines} \\
\mathbf{\text{Metal-1}} & \text{Blue} & \text{Aluminum / Copper} & \text{Power rails } (V_{DD}, \text{GND}) \text{ and interconnects} \\
\mathbf{\text{Contact / Via}} & \text{Black Cross (X)} & \text{Tungsten plug} & \text{Inter-layer vertical connection} \\
\hline
\end{array}$$
derive the **Euler Path Graph-Theoretic Optimization Protocol**:
1. Draw dual circuit graphs for the **Pull-Down Network (PDN)** and **Pull-Up Network (PUN)** where nodes represent circuit electrical nets and edges represent transistor gates labeled by input literals $(A, B, C, D)$;
2. Find a common **Euler Path** that traverses **EVERY single edge (transistor) exactly once** in both PDN and PUN in the identical gate sequence;
3. Route the continuous polysilicon gate lines in that sequence across parallel, unbroken horizontal diffusion strips:
$$\mathbf{\text{Continuous Diffusion Stripe} \implies \mathbf{\text{Diffusion Breaks} = 0} \implies \mathbf{\text{Minimum Silicon Area \& Parasitic Capacitance}}}$$
(proving that an optimized Euler path ordering completely eliminates diffusion isolation gaps, reducing cell area by up to $30\%$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mead-Conway Layers, Stick Diagram Rules & Euler Path Graph Optimization Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Construct an Area-Optimized Stick Diagram for an AOI21 Complex Gate Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Layout Layer / Stick Diagram Entity & Technical Mask Rule Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Continuous Graph Path That Traverses Every Single Transistor Edge in a CMOS Network Exactly Once Is an ___ Path (Euler / Eulerian) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Silicon Layout Problem: Identifying Common Euler Path Gate Ordering for an AOI22 Gate Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Stick Diagrams & Euler Paths (Mead & Conway 1980; Weste & Harris 2011):
   - **Layer Colors & Graph Rules:**
     $$\mathbf{\text{Diffusion (Green/Yellow)} \times \text{Polysilicon (Red)} \implies \mathbf{\text{MOSFET Transistor Channel}}}$$
   - **Euler Path Sequence Invariant:**
     $$\mathbf{\text{Euler Path Sequence: } (g_1 \to g_2 \to \dots \to g_n) \iff \text{Continuous unbroken diffusion strip with shared source/drain nodes}}$$
   - **The Transistor Overlap Rule:** Whenever a red polysilicon line crosses over a green/yellow diffusion strip, a **MOSFET transistor is physically formed**; no contacts are needed at the gate intersection!
2. **Slide 2 (`ordering`):** Provide 5 steps of Euler path layout: (1) construct dual graphs for Pull-Down Network (NMOS) and Pull-Up Network (PMOS), (2) identify a common Euler path traversing all transistor edges in identical order (e.g. $A-B-C-D$), (3) draw parallel horizontal $p$-diffusion and $n$-diffusion continuous stripes, (4) place vertical red polysilicon lines running across both stripes in the Euler path order, (5) place metal-1 power rails ($V_{DD}$ top, $\text{GND}$ bottom) and connect source/drain contacts with blue metal-1 wires to form logic output!
3. **Slide 3 (`matching`):** Pair 4 concepts (Euler Path Ordering, Polysilicon Crossing Diffusion, Diffusion Sharing, Metal-1 Power Rails) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Euler (or Eulerian). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Euler path for AOI21 gate: An AND-OR-INVERT gate realizes logic $Y = \overline{A \cdot B + C}$. Its pull-down network has NMOS transistors $A$ and $B$ in series, placed in parallel with transistor $C$. Which of the following polysilicon gate sequences represents a valid common Euler path that allows unbroken diffusion sharing across both PMOS and NMOS stripes? (PDN graph edges: series branch has $A$ and $B$, parallel branch has $C$; Nodes are GND, internal node $X$, and output $Y$; Path traversing each edge once: Start at GND $\to$ cross edge $C \to$ reach $Y \to$ cross edge $A \to$ reach $X \to$ cross edge $B \to$ reach GND; Traversal order: $\mathbf{C - A - B}$ or reverse $\mathbf{B - A - C}$; Sequence **A - B - C** or **C - A - B** forms a valid uninterrupted Euler path with **zero diffusion breaks**!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cmos_stick_diagrams_euler_path_and_diffusion_sharing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CMOS Stick Diagrams \\& Euler Path Optimization (Mead \\& Conway)**\n• **Standard Color-Coded Layer Hierarchy:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Layer} & \\textbf{Color Convention} & \\textbf{Physical Layout Role} \\\\\n\\hline\n\\mathbf{\\text{n-Diffusion / p-Diffusion}} & \\text{Green (NMOS) / Yellow (PMOS)} & \\text{Transistor Source \\& Drain active regions} \\\\\n\\mathbf{\\text{Polysilicon}} & \\mathbf{\\text{Red Lines}} & \\mathbf{\\text{Transistor Gate controls (Forms MOS at crossing)}} \\\\\n\\mathbf{\\text{Metal-1}} & \\text{Blue Lines} & \\text{Power rails (VDD top, GND bottom) \\& Routing} \\\\\n\\mathbf{\\text{Contact Cut}} & \\text{Black Cross (X)} & \\text{Inter-layer vertical ohmic connections} \\\\\n\\hline\n\\end{array}\n$$\n• **Euler Path Optimization Theorem:**\n$$\n\\mathbf{\\text{Common Euler Path } (g_1 \\to g_2 \\to \\dots \\to g_N) \\implies \\mathbf{\\text{Diffusion Breaks} = 0 \\implies \\text{Minimum Cell Area}}}\n$$\n• **The Diffusion Sharing Invariant:** If adjacent transistors share an identical electrical node (e.g. series source-drain connection), placing them consecutively in the layout **merges their diffusion regions into a single continuous strip**, eliminating contacts and slashing parasitic junction capacitance by up to $50\\%$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to create a compact, area-optimized CMOS stick diagram for a complex logic gate using the Euler Path method.",
      "orderItems": [
        "Construct the dual schematic graphs for the Pull-Down Network (NMOS) and Pull-Up Network (PMOS)",
        "Identify a single common Euler Path that traverses every transistor edge exactly once in both graphs in identical sequence",
        "Draw two continuous parallel horizontal diffusion strips: p-diffusion at the top and n-diffusion at the bottom",
        "Place vertical polysilicon gate lines cutting across both diffusion strips in the exact order dictated by the Euler Path",
        "Connect VDD and GND metal-1 power rails and route internal contacts to complete the output node connection"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Physical Layout Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Euler Path Sequence", "right": "Ordered list of transistor gate inputs enabling unbroken continuous diffusion layout without isolation cuts" },
        { "left": "Polysilicon over Diffusion", "right": "Physical intersection that creates a functional MOSFET channel without requiring contact cuts" },
        { "left": "Diffusion Sharing", "right": "Merging adjacent source and drain regions of connected transistors to minimize cell width and parasitic capacitance" },
        { "left": "Metal-1 Power Rails", "right": "Horizontal supply tracks (VDD at top, GND at bottom) providing low-resistance current distribution" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A continuous graph path that traverses every single transistor edge in a CMOS logic network exactly once is an ___ path.",
      "blankAnswer": "Euler",
      "blankDistractors": ["Hamiltonian", "Dijkstra", "Voronoi"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An AOI21 complex CMOS gate implements the logic function Y = (A * B + C)'. The NMOS network has transistors A and B in series, connected in parallel with transistor C. Which gate ordering represents a valid common Euler path that allows unbroken diffusion sharing across both PMOS and NMOS stripes?",
      "options": [
        { "text": "C - A - B (or B - A - C) (Traverses edge C from GND to Y, then edge A to internal node X, then edge B back to GND; visiting all 3 transistors with 0 diffusion breaks)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Euler Path graph method (Neil Weste & David Harris *CMOS VLSI Design* Chapter 3). 1. **Analyze the Pull-Down Network (PDN):** - Transistors $A$ and $B$ are connected in **series** between output node $Y$ and ground ($\text{GND}$), sharing internal node $X$. - Transistor $C$ is connected in **parallel** between output node $Y$ and $\text{GND}$. - Graph nodes: $\\{\text{GND}, X, Y\\}$. - Graph edges: $A$ (between $Y$ and $X$), $B$ (between $X$ and $\text{GND}$), $C$ (between $Y$ and $\text{GND}$). 2. **Analyze the Pull-Up Network (PUN):** - Transistors $A$ and $B$ are connected in **parallel** with each other, and this parallel pair is placed in **series** with transistor $C$ to $V_{DD}$. 3. **Find the Common Euler Path:** - Trace path on PDN graph: - Start at $\text{GND} \\to$ traverse edge $\\mathbf{C} \\to$ reach node $Y$. - From node $Y \\to$ traverse edge $\\mathbf{A} \\to$ reach internal node $X$. - From node $X \\to$ traverse edge $\\mathbf{B} \\to$ return to node $\text{GND}$. - Traversal sequence: $\\mathbf{C \\to A \\to B}$ (or reversed $\\mathbf{B \\to A \\to C}$). 4. **Physical Layout Result:** - Running polysilicon lines in order $[C, A, B]$ enables **one single continuous, uninterrupted diffusion strip** for both PMOS and NMOS with **zero diffusion cuts ($0$ breaks)**! Flawless Euler path layout synthesis!" },
        { "text": "A - C - B (Causes a broken diffusion gap)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "B - C - A (Requires isolation spacing)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "None, an AOI21 gate always requires 2 diffusion cuts", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
