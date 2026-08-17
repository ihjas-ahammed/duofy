# Duofy Reusable Lesson Format: Verilog Assignments (Blocking vs Non-Blocking Semantics)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / Digital_VLSI_and_Verilog_VHDL`  
**Lesson Format Type:** `verilog_hdl_blocking_vs_nonblocking_and_cummings_guidelines`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the event-driven simulation semantics of Verilog HDL, IEEE 1364 stratified event queues (Active, Inactive, Non-Blocking Assignment $\text{NBA}$, Monitor), the critical distinction between Blocking (`=`) and Non-Blocking (`<=`) assignment operators, simulation-synthesis race conditions, and Clifford Cummings' four golden guidelines for synthesis-accurate RTL modeling (Clifford E. Cummings *Correct Methods for Adding Delays to Verilog Behavioral Models* SNUG; Samir Palnitkar *Verilog HDL* Chapter 7 & 9): master the **Verilog Assignment Operators**:
1. **Blocking Assignment (`=`):**
   - Evaluates the Right-Hand Side ($\text{RHS}$) and updates the Left-Hand Side ($\text{LHS}$) **immediately and synchronously before moving to the next line in the active queue**; models procedural sequential execution and **combinational logic**;
2. **Non-Blocking Assignment (`<=`):**
   - Evaluates the $\text{RHS}$ expressions of all non-blocking statements at the start of the time step, schedules the updates, and **commits all LHS assignments simultaneously at the end of the time step in the NBA queue**; models concurrent hardware flip-flops and **sequential logic**;
master **Cummings' 4 Golden Assignment Rules**:
1. **Rule 1:** When modeling **sequential logic**, use **non-blocking assignments (`<=`)**;
2. **Rule 2:** When modeling **combinational logic** with an `always` block, use **blocking assignments (`=`)**;
3. **Rule 3:** **NEVER mix** blocking (`=`) and non-blocking (`<=`) assignments in the same `always` block;
4. **Rule 4:** **NEVER assign** to the same variable from more than one `always` block.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Blocking (`=`), Non-Blocking (`<=`), NBA Queue & Cummings' Golden Rules Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Model a 3-Stage Shift Register Correctly in Verilog Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Verilog Operator / Simulation Queue Event & Technical Hardware Semantics Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Verilog RTL Design, All Sequential Edge-Triggered Flip-Flop Registers Must Be Modeled Using ___-Blocking Assignments (Non / Non-Blocking) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Digital Hardware RTL Problem: Debugging a Shift Register Race Condition Caused by Blocking Assignments Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Verilog Assignment Semantics (Cummings 2000; Palnitkar 2003):
   - **Assignment Syntax & Semantics:**
     $$\mathbf{\text{Sequential Flip-Flops: } \mathbf{Q <= D} \ (\text{Non-Blocking}) \quad \Big| \quad \text{Combinational Gates: } \mathbf{Y = A \& B} \ (\text{Blocking})}$$
   - **Cummings' Golden Rules Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Logic Type} & \textbf{Operator} & \textbf{Event Queue Region} & \textbf{Hardware Synthesized} \\
     \hline
     \mathbf{\text{Sequential Logic}} & \mathbf{\text{Non-Blocking (<=)}} & \mathbf{\text{NBA Region (Concurrent Update)}} & \mathbf{\text{D Flip-Flops / Edge-Triggered Registers}} \\
     \mathbf{\text{Combinational Logic}} & \mathbf{\text{Blocking (=)}} & \text{Active Region (Immediate)} & \text{Combinational Multiplexers / Logic Gates} \\
     \mathbf{\text{Continuous Net}} & \text{assign } Y = A \text{ ^ } B & \text{Active Region} & \text{Continuous Hardwired Logic Gates} \\
     \hline
     \end{array}$$
   - **The Shift Register Race Invariant:** Using blocking assignments (`=`) inside an edge-triggered sequential block (`always @(posedge clk) begin q1 = d; q2 = q1; end`) turns a 2-stage shift register into a **single transparent register in simulation**, creating a fatal simulation-synthesis mismatch!
2. **Slide 2 (`ordering`):** Provide 5 steps to model a 3-stage shift register: (1) declare 1-bit registers `q1, q2, q3` and clock/reset signals, (2) write sequential sensitivity list `always @(posedge clk or negedge rst_n)`, (3) handle asynchronous active-low reset to clear all registers to zero, (4) use non-blocking statements `q1 <= d; q2 <= q1; q3 <= q2;`, (5) synthesize the design to verify that 3 cascaded D flip-flops are inferred by the EDA synthesis compiler!
3. **Slide 3 (`matching`):** Pair 4 concepts (Non-Blocking Operator `<=`, Blocking Operator `=`, NBA Event Queue, Continuous Assignment `assign`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Non (or Non-Blocking). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on debugging blocking assignment race: A junior engineer writes the following Verilog code intended to implement a 2-stage pipelined shift register:
   ```verilog
   always @(posedge clk) begin
       q1 = d;
       q2 = q1;
   end
   ```
   What circuit behavior occurs in an IEEE-compliant Verilog simulator during a clock edge, and why does this cause a simulation-synthesis mismatch? (Because blocking assignments `=` execute immediately in top-to-bottom procedural order, `q1` updates to `d` instantly; then `q2` immediately reads the newly updated value of `q1` in the very same time step! Consequently, `q2` gets `d` in 1 clock cycle instead of 2 cycles in simulation; however, hardware synthesis tools infer two flip-flops, creating a **catastrophic simulation-synthesis race mismatch**; the fix is using non-blocking `<=`!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "verilog_hdl_blocking_vs_nonblocking_and_cummings_guidelines",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Verilog Assignment Semantics \\& Cummings' Rules (Clifford Cummings)**\n• **The 2 Core Assignment Operators:**\n$$\n\\mathbf{\\text{Blocking Assignment ( = ): } \\text{Immediate update in Active queue} \\implies \\mathbf{\\text{Use for COMBINATIONAL Logic}}}\n$$\n$$\n\\mathbf{\\text{Non-Blocking Assignment ( <= ): } \\text{Deferred concurrent update in NBA queue} \\implies \\mathbf{\\text{Use for SEQUENTIAL Logic}}}\n$$\n• **Cummings' 4 Golden Assignment Rules:**\n  1. When modeling **sequential logic**, use **non-blocking assignments (`<=`)**;\n  2. When modeling **combinational logic** in an `always` block, use **blocking assignments (`=`)**;\n  3. **NEVER mix** blocking (`=`) and non-blocking (`<=`) in the same `always` block;\n  4. **NEVER assign** to the same variable from more than one `always` block!\n• **The Simulation-Synthesis Invariant:** In edge-triggered sequential blocks, using blocking `=` assignments forces immediate serial execution in simulation, turning multi-stage shift registers into a **single cycle transparent pass-through** and causing fatal silicon mismatches!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to write a race-free 3-stage shift register in synthesizable Verilog HDL.",
      "orderItems": [
        "Declare input signals (clk, rst_n, d) and output registers (q1, q2, q3) using standard Verilog reg/logic types",
        "Formulate the edge-triggered sequential sensitivity list: always @(posedge clk or negedge rst_n)",
        "Implement active-low asynchronous reset logic to initialize all flip-flop registers to zero: if (!rst_n)",
        "Assign the cascading shift stages concurrently using non-blocking operators: q1 <= d; q2 <= q1; q3 <= q2;",
        "Run RTL simulation to verify that input data d requires exactly 3 clock cycles to propagate to q3"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Verilog Assignment Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Non-Blocking Operator (<=)", "right": "Evaluates RHS concurrently and schedules LHS update in NBA queue; mandatory for flip-flops" },
        { "left": "Blocking Operator (=)", "right": "Evaluates and commits assignment immediately; mandatory for combinational always blocks" },
        { "left": "Continuous Assignment (assign)", "right": "Hardwired combinational net equation continuously driven whenever any input changes" },
        { "left": "NBA Event Region", "right": "Simulation queue phase where all scheduled non-blocking updates commit simultaneously" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Verilog RTL design, all sequential edge-triggered flip-flop registers must be modeled using ___-blocking assignments.",
      "blankAnswer": "non",
      "blankDistractors": ["active", "static", "latch"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A designer writes the following Verilog code intended for a 2-stage pipeline register:\n\nalways @(posedge clk) begin\n    q1 = d;\n    q2 = q1;\nend\n\nWhat behavior occurs in an IEEE-compliant simulator, and why does this cause a simulation-synthesis mismatch?",
      "options": [
        { "text": "In simulation, blocking '=' updates q1 immediately, so q2 samples the new value of q1 in the same clock edge, propagating 'd' to 'q2' in only 1 cycle (behaving like a single register); but synthesis tools infer 2 cascaded flip-flops (2 cycles latency), creating a catastrophic simulation-synthesis mismatch (fixed by using non-blocking '<=')", "isCorrect": true, "explanation": "Correct! This is Clifford Cummings' most famous classic demonstration of Verilog race hazards (*Nonblocking Assignments in Verilog GUI* SNUG). 1. **Simulator Execution Semantics:** - Because the blocking assignment `q1 = d;` is used, the variable `q1` is updated **immediately in the Active event queue**. - The next line `q2 = q1;` executes immediately afterward in procedural order, reading the **NEW, updated value of `q1`**. - As a result, data `d` flows from input all the way through to `q2` in **one single clock edge (0 delay)**! 2. **Hardware Synthesis Semantics:** - The synthesis compiler interprets two edge-triggered dependencies and instantiates **two physical D flip-flops in series**. - In actual silicon, data `d` takes **two clock cycles** to reach `q2`. 3. **The Disaster:** - RTL simulation passes unit tests expecting 1-cycle latency, but the manufactured chip fails in hardware with 2-cycle latency! - **The Golden Fix:** Always write `q1 <= d; q2 <= q1;` using non-blocking assignments!" },
        { "text": "The code causes a syntax error and cannot compile", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "In simulation, q1 and q2 oscillate infinitely between 0 and 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The synthesizer ignores the clk signal and creates a continuous wire", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
