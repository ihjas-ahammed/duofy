# Duofy Reusable Lesson Format: SystemVerilog RTL (Explicit Blocks & Latch Prevention)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / Digital_VLSI_and_Verilog_VHDL`  
**Lesson Format Type:** `systemverilog_always_comb_vs_always_ff_and_latch_avoidance`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through modern SystemVerilog (IEEE 1800) RTL design constructs, explicit process blocks (`always_comb`, `always_ff`, `always_latch`), EDA linting enforcement, unintentional transparent latch inference hazards, and standard coding patterns to guarantee pure glitch-free combinational logic (Stuart Sutherland *SystemVerilog for Design* 2nd ed. Chapter 6; Samir Palnitkar *Verilog HDL* Chapter 7): formulate the **Three Specialized SystemVerilog Procedural Blocks**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{Construct} & \textbf{Target Hardware} & \textbf{Sensitivity List} & \textbf{EDA Compiler Enforcement} \\
\hline
\mathbf{\text{always\_comb}} & \mathbf{\text{Combinational Logic}} & \mathbf{\text{Automatic inferred (all RHS inputs)}} & \mathbf{\text{Issues compile error if latch is inferred}} \\
\mathbf{\text{always\_ff}} & \mathbf{\text{Sequential Flip-Flops}} & \mathbf{\text{Strictly edge-triggered } (posedge / negedge)} & \mathbf{\text{Flags missing clocks or combinational paths}} \\
\mathbf{\text{always\_latch}} & \text{Level-Sensitive Latch} & \text{Level-sensitive enable} & \text{Confirms intentional latch design intent} \\
\hline
\end{array}$$
master the **Unintended Latch Inference Root Causes & Cure**:
- **Root Cause:** In combinational logic, if an output signal is NOT assigned a value under all possible conditions (e.g. an `if` without an `else`, or a `case` statement missing branches without a `default`), the synthesizer assumes the designer wants the circuit to "remember" its prior state, inferring a hardware **D-Latch**;
- **The Golden Cure:**
  1. Always provide complete `if ... else` branches;
  2. Always provide a `default` case in every `case` statement;
  3. **Best Practice Default Assignment Pattern:** Initialize all outputs to safe default values at the **very first line** of the `always_comb` block:
     ```systemverilog
     always_comb begin
         // Default assignment prevents ALL latches:
         alu_out = 32'b0;
         zero_flag = 1'b0;
         case (opcode)
             // explicit opcode decoding...
         endcase
     end
     ```

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SystemVerilog Blocks (`always_comb`, `always_ff`), Latch Pitfall & Default Pattern Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Write a Clean, Latch-Free 4-to-1 Multiplexer in SystemVerilog Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | SystemVerilog Construct / Latch Cause & Technical Synthesis Outcome Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Incomplete If-Else Branching or Missing Default Cases in a Combinational Always Block Infers an Unintentional Hardware ___ (Latch / Transparent Latch) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Silicon RTL Problem: Identifying and Fixing a Latch Bug in a SystemVerilog ALU Decoder Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SystemVerilog RTL Constructs (Sutherland 2006; IEEE 1800):
   - **SystemVerilog Block Syntax:**
     $$\mathbf{\text{always\_comb begin ... end} \quad \Big| \quad \text{always\_ff @(posedge clk or negedge rst\_n) begin ... end}}$$
   - **Construct Comparison Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Legacy Verilog-95/2001} & \textbf{SystemVerilog IEEE 1800} & \textbf{Safety Benefit} \\
     \hline
     always @* & \mathbf{\text{always\_comb}} & \mathbf{\text{Triggers at time 0; verifies zero latches inferred}} \\
     always @(posedge clk) & \mathbf{\text{always\_ff @(posedge clk)}} & \mathbf{\text{Enforces single clock domain; forbids combinational leaks}} \\
     always @(en or d) & \mathbf{\text{always\_latch}} & \text{Validates intentional transparent latch architecture} \\
     \hline
     \end{array}$$
   - **The Latch Prevention Invariant:** In an `always_comb` block, setting default assignments at line 1 **guarantees $100\%$ that no transparent latches can ever be synthesized**, regardless of complex nested branching!
2. **Slide 2 (`ordering`):** Provide 5 steps of writing a latch-free 4:1 multiplexer: (1) declare logic inputs `in0, in1, in2, in3`, select `sel[1:0]`, and output `out`, (2) open an `always_comb` block, (3) write top default assignment `out = in0;`, (4) implement full `case (sel)` statement covering cases `2'b00, 2'b01, 2'b10, 2'b11` with `default: out = in0;`, (5) run synthesis lint checks to confirm zero latches are generated!
3. **Slide 3 (`matching`):** Pair 4 concepts (`always_comb`, `always_ff`, Missing `else` branch, Default assignment `out = 0`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Latch (or Transparent Latch). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on fixing a latch in an ALU: The following code has an unintentional latch bug:
   ```systemverilog
   always_comb begin
       if (opcode == 2'b00)
           res = a + b;
       else if (opcode == 2'b01)
           res = a - b;
       else if (opcode == 2'b10)
           res = a & b;
       // Missing case for opcode == 2'b11!
   end
   ```
   Why does the synthesis tool infer a latch on `res`, and what is the best clean fix? (Because when `opcode == 2'b11`, `res` is not assigned any new value; hardware must hold its previous value, forcing the synthesizer to insert a level-sensitive **D-Latch** on `res`; adding `else res = a | b;` or a default assignment `res = 32'b0;` at the top of the block completely resolves the issue).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "systemverilog_always_comb_vs_always_ff_and_latch_avoidance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: SystemVerilog RTL Blocks \\& Latch Elimination (Stuart Sutherland)**\n• **The 3 Dedicated SystemVerilog Procedural Blocks:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Construct} & \\textbf{Target Circuit} & \\textbf{EDA Linting \\& Synthesis Rule} \\\\\n\\hline\n\\mathbf{\\text{always\\_comb}} & \\mathbf{\\text{Combinational Logic}} & \\mathbf{\\text{Flags compiler warnings if unintended latches are inferred}} \\\\\n\\mathbf{\\text{always\\_ff}} & \\mathbf{\\text{Sequential Flip-Flops}} & \\mathbf{\\text{Strictly enforces edge-triggered clock list; rejects combinational paths}} \\\\\n\\mathbf{\\text{always\\_latch}} & \\text{Level-Sensitive Latch} & \\text{Explicitly confirms intentional latch design intent} \\\\\n\\hline\n\\end{array}\n$$\n• **The Unintended Latch Danger:** If a combinational signal is not assigned across all input conditions (e.g. missing `else` or missing `default`), synthesis inserts a **transparent latch**, causing timing violations, glitches, and testability failures!\n• **The Default Assignment Pattern:**\n$$\n\\mathbf{\\text{Initialize all outputs to safe defaults at Line 1 of } \\text{always\\_comb} \\implies \\mathbf{\\text{Guarantees ZERO Inferred Latches!}}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct a clean, latch-free 4-to-1 Multiplexer in SystemVerilog.",
      "orderItems": [
        "Declare input logic ports (in0, in1, in2, in3), 2-bit select (sel), and output logic (mux_out)",
        "Declare an explicit combinational block: always_comb begin",
        "Set an initial default output assignment at line 1: mux_out = in0; to eliminate all possibility of latch inference",
        "Implement a fully specified case (sel) construct covering 2'b00, 2'b01, 2'b10, 2'b11 with an explicit default clause",
        "Run EDA synthesis linting to verify that pure combinational multiplexer gates are synthesized with zero latches"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each SystemVerilog RTL Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "always_comb", "right": "SystemVerilog combinational block that triggers at time 0 and verifies zero latches are inferred" },
        { "left": "always_ff", "right": "SystemVerilog sequential block strictly requiring edge-triggered clock/reset sensitivity lists" },
        { "left": "Missing Else Branch", "right": "Coding defect that forces the synthesizer to insert an unwanted transparent latch to preserve state" },
        { "left": "Line-1 Default Assignment", "right": "Coding pattern that guarantees every variable is defined before any conditional branching" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Incomplete if-else branching or missing default cases in a combinational always block infers an unintentional hardware ___.",
      "blankAnswer": "latch",
      "blankDistractors": ["multiplexer", "resistor", "counter"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A designer writes the following SystemVerilog ALU logic:\n\nalways_comb begin\n    if (opcode == 2'b00)      res = a + b;\n    else if (opcode == 2'b01) res = a - b;\n    else if (opcode == 2'b10) res = a & b;\nend\n\nWhy does the synthesis tool infer a hardware latch on 'res', and how is it fixed?",
      "options": [
        { "text": "Because opcode == 2'b11 is not handled, the circuit must 'remember' the previous value of 'res', forcing synthesis to insert a transparent D-latch; fixed by adding a final 'else res = a ^ b;' branch or setting 'res = 0;' at the top of the block", "isCorrect": true, "explanation": "Correct! This is Stuart Sutherland's quintessential SystemVerilog synthesis trap (*SystemVerilog for Design* Chapter 6). 1. **The Incomplete Condition:** - The variable `opcode` is a 2-bit signal with four possible states: `2'b00, 2'b01, 2'b10, 2'b11`. - The code specifies actions for `00`, `01`, and `10`, but **omits `11`**. 2. **The Hardware Consequence:** - Hardware definition rule: A combinational output must depend solely on instantaneous current inputs. - If `opcode == 2'b11`, the code does not tell the hardware what `res` should be. - Therefore, the synthesis tool must infer a **transparent latch** (storage element) that retains whatever value `res` had previously! 3. **The Dangers of Latches in ASICs:** - Latches are sensitive to level-based glitching, complicate static timing analysis (STA), and make automatic test pattern generation (ATPG) extremely difficult. 4. **The Fix:** - Add a catch-all `else` branch or initialize `res = 32'b0;` at the very beginning of the `always_comb` block!" },
        { "text": "Because always_comb cannot be used with if-else statements", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because arithmetic operations '+' and '-' cannot be combined with bitwise '&'", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 2-bit opcodes require always_ff instead of always_comb", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
