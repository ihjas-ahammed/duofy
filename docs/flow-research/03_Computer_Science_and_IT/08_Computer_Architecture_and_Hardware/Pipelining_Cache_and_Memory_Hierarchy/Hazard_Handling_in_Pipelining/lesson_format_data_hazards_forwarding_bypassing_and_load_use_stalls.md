# Duofy Reusable Lesson Format: Data Hazards (Forwarding, Bypassing, and Load-Use Stalls)

**Target Topic:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Pipelining_Cache_and_Memory_Hierarchy / Hazard_Handling_in_Pipelining`  
**Lesson Format Type:** `data_hazards_forwarding_bypassing_and_load_use_stalls`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through data dependency resolution, hardware forwarding units, and unavoidable load-use latency bubbles in pipelined execution (David A. Patterson & John L. Hennessy *Computer Organization and Design* Chapter 4; Hennessy & Patterson *Computer Architecture: A Quantitative Approach*): master **Read-After-Write (RAW) True Data Hazards** (when an instruction attempts to read a register operand before a preceding instruction has written its result back to the register file), master **Hardware Forwarding / Bypassing** (adding bypass data paths from EX/MEM and MEM/WB pipeline registers directly into the inputs of the EX stage ALU multiplexers using forwarding control equations: $\mathbf{\text{ForwardA / ForwardB = 10 (EX hazard) or 01 (MEM hazard)}}$, eliminating RAW stalls with zero bubbles for ALU-ALU sequences), master the **Load-Use Data Hazard Invariant** (proving why a `Load` instruction followed immediately by an instruction consuming that loaded value cannot be solved by forwarding alone because data is not available until the end of the MEM stage, requiring the **Hazard Detection Unit to insert exactly 1 hardware stall cycle / NOP bubble**), and evaluate compiler instruction scheduling optimization.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RAW Data Hazards & Hardware Forwarding Paths vs Load-Use Stall Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Cycle-by-Cycle Execution of a Forwarded ALU-to-ALU Data Hazard Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Data Hazard Type / Mitigation Circuit & Exact Hardware Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Hardware Technique That Routes an ALU Output Directly to a Subsequent Stage Without Writing to Registers Is ___ (Forwarding / Bypassing) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis: Why a Load-Use Data Hazard CANNOT Be Solved by Forwarding Alone Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Data Hazards & Forwarding (Patterson & Hennessy Ch 4):
   - **Data Hazard Resolution Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Instruction Sequence} & \textbf{Data Dependency} & \textbf{Naive Stall Cost} & \textbf{Hardware Optimization} \\
     \hline
     \mathbf{\text{ALU } \to \text{ ALU (Consecutive)}} & \text{RAW on Register } rd & 2 \text{ Stall Cycles} & \mathbf{\text{EX/MEM } \to \text{ EX Forwarding (0 Stalls!)}} \\
     \mathbf{\text{ALU } \to \text{ ALU (Distance 2)}} & \text{RAW on Register } rd & 1 \text{ Stall Cycle} & \mathbf{\text{MEM/WB } \to \text{ EX Forwarding (0 Stalls!)}} \\
     \mathbf{\text{Load } \to \text{ ALU (Consecutive)}} & \mathbf{\text{Load-Use RAW}} & \mathbf{2 \text{ Stall Cycles}} & \mathbf{\text{1-Cycle Hardware Bubble + Forwarding}} \\
     \hline
     \end{array}$$
   - **Forwarding Unit Control Equations:**
     $$\mathbf{\text{EX Hazard: If } (\text{EX/MEM.RegWrite} \land (\text{EX/MEM.RegisterRd} \neq 0) \land (\text{EX/MEM.RegisterRd} == \text{ID/EX.RegisterRs1})) \implies \text{ForwardA} = 10}$$
   - **Load-Use Hazard Detection Unit:**
     $$\mathbf{\text{If } (\text{ID/EX.MemRead} \land ((\text{ID/EX.RegisterRd} == \text{IF/ID.RegisterRs1}) \lor (\text{ID/EX.RegisterRd} == \text{IF/ID.RegisterRs2}))) \implies \mathbf{\text{Inject 1 Stall Cycle!}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of executing `ADD x1, x2, x3` followed by `SUB x4, x1, x5`: (1) Cycle 1: `ADD` instruction is fetched in IF stage, (2) Cycle 2: `ADD` in ID reads x2 and x3 while `SUB` is fetched in IF, (3) Cycle 3: `ADD` computes sum in EX stage while `SUB` in ID stage reads stale x1 from register file, (4) Cycle 4: `ADD` moves to MEM; Forwarding Unit detects RAW dependency and routes ALU sum from EX/MEM register directly into ALU input for `SUB` in EX stage, (5) `SUB` computes subtraction using freshly forwarded x1 without stalling a single clock cycle!
3. **Slide 3 (`matching`):** Pair 4 concepts (RAW Data Hazard, EX-to-EX Forwarding, Load-Use Hazard, Pipeline Bubble) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Forwarding (or Bypassing). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Load-Use cannot be solved by forwarding alone: In a 5-stage classic RISC pipeline, why is it physically impossible to resolve a consecutive Load-Use data hazard (`LW x1, 0(x2)` followed immediately by `ADD x3, x1, x4`) using hardware forwarding alone without inserting a 1-cycle stall bubble? (In the pipelined execution timeline, the Load instruction does not retrieve the data from the Data Memory (D-Cache) until the **end of its MEM stage (end of Clock Cycle 4)**; the subsequent `ADD` instruction requires the operand at the **beginning of its EX stage (beginning of Clock Cycle 4)**; **because data cannot be forwarded backwards in physical time, the pipeline hardware must stall the ADD instruction in the ID stage for exactly 1 clock cycle, allowing the Load instruction to finish its MEM stage so the data can then be forwarded from MEM/WB into the EX stage in Cycle 5**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "data_hazards_forwarding_bypassing_and_load_use_stalls",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Data Hazards \\& Forwarding Logic (Patterson \\& Hennessy)**\n• **Data Hazard Resolution \\& Stall Cost Matrix:**\n$$\n\\begin{array}{|l|l|c|l|}\n\\hline\n\\textbf{Instruction Sequence} & \\textbf{RAW Dependency} & \\textbf{Stalls (No Forward)} & \\textbf{Pipelined Hardware Solution} \\\\\n\\hline\n\\mathbf{\\text{ALU } \\to \\text{ ALU (Consecutive)}} & \\text{RAW on } rd \\to rs1 & 2 \\text{ Cycles} & \\mathbf{\\text{EX/MEM } \\to \\text{ EX Forwarding (0 Stalls!)}} \\\\\n\\mathbf{\\text{ALU } \\to \\text{ ALU (Distance 2)}} & \\text{RAW on } rd \\to rs1 & 1 \\text{ Cycle} & \\mathbf{\\text{MEM/WB } \\to \\text{ EX Forwarding (0 Stalls!)}} \\\\\n\\mathbf{\\text{Load } \\to \\text{ ALU (Consecutive)}} & \\mathbf{\\text{Load-Use RAW}} & \\mathbf{2 \\text{ Cycles}} & \\mathbf{\\text{1-Cycle Bubble (Stall) + Forwarding}} \\\\\n\\hline\n\\end{array}\n$$\n• **Load-Use Hazard Detection Unit Equation:**\n$$\n\\mathbf{\\text{If } (\\text{ID/EX.MemRead} \\land ((\\text{ID/EX.RegisterRd} == \\text{IF/ID.RegisterRs1}) \\lor (\\text{ID/EX.RegisterRd} == \\text{IF/ID.RegisterRs2}))) \\implies \\mathbf{\\text{Stall 1 Cycle!}}}\n$$\n• **Hardware Forwarding Invariant:** Forwards data directly from pipeline registers without waiting for the Write-Back stage!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when hardware forwarding resolves a RAW hazard between ADD x1, x2, x3 and SUB x4, x1, x5 with zero stalls.",
      "orderItems": [
        "Cycle 1: The ADD instruction is fetched from I-Cache in the IF stage while the Program Counter advances to PC+4",
        "Cycle 2: ADD is decoded in ID stage reading x2 and x3, while SUB instruction is fetched in IF stage",
        "Cycle 3: ADD computes the binary sum (x2 + x3) in the EX stage, while SUB in ID stage decodes its registers",
        "Cycle 4: Forwarding Unit detects EX/MEM.RegisterRd == ID/EX.RegisterRs1, setting ForwardA=10 to route the ADD result directly into ALU input",
        "Cycle 4: SUB executes its subtraction in EX stage using the forwarded x1 value with ZERO pipeline stall cycles"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Data Hazard Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "RAW (Read-After-Write)", "right": "True data dependency where an instruction needs an operand before a prior instruction writes it" },
        { "left": "Hardware Forwarding Unit", "right": "Combinational multiplexer network routing ALU outputs from EX/MEM or MEM/WB back to EX inputs" },
        { "left": "Load-Use Hazard", "right": "Condition where an instruction immediately consumes data fetched by a prior load instruction" },
        { "left": "Hazard Detection Unit", "right": "Logic unit freezing IF/ID pipeline registers and inserting a NOP bubble when a load-use occurs" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The microarchitectural technique that routes an ALU output directly to a subsequent stage without writing to the register file first is ___.",
      "blankAnswer": "forwarding",
      "blankDistractors": ["pipelining", "branching", "decoding"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a classic 5-stage RISC pipeline, why is it physically impossible to resolve a consecutive Load-Use data hazard (LW x1, 0(x2) followed immediately by ADD x3, x1, x4) using hardware forwarding alone without inserting a 1-cycle stall bubble?",
      "options": [
        { "text": "In the pipelined execution timeline, the Load instruction (LW) does not retrieve the data from the Data Memory (D-Cache) until the END of its Memory Access (MEM) stage in Clock Cycle 4; the dependent ADD instruction requires that operand at the BEGINNING of its Execution (EX) stage in Clock Cycle 4; because data cannot physically travel backward in time, the Hazard Detection Unit must stall the ADD instruction for exactly 1 clock cycle (freezing IF and ID stages and injecting a NOP bubble into EX), allowing the Load instruction to complete its MEM stage so the data can then be forwarded from MEM/WB to EX in Clock Cycle 5", "isCorrect": true, "explanation": "Correct! This is John Hennessy and David Patterson's famous 'time machine' impossibility proof for load-use hazards (*Computer Organization and Design* Chapter 4 *The Processor*). 1. **The Timeline of Consecutive Load-Use:** - Cycle 1: `LW` is in IF. - Cycle 2: `LW` in ID $\\mid$ `ADD` in IF. - Cycle 3: `LW` in EX $\\mid$ `ADD` in ID. - **Cycle 4:** `LW` is in MEM $\\mid$ `ADD` is in EX! 2. **Why Forwarding Fails in Cycle 4:** - When does `LW` produce the loaded value from RAM? At the **very end of Cycle 4 (MEM stage)**! - When does `ADD` need the operand for its ALU calculation? At the **start of Cycle 4 (EX stage)**! - Forwarding would require data from the future (end of Cycle 4) to be sent to the past (start of Cycle 4). A physical impossibility! 3. **The 1-Cycle Stall Solution:** - The Hazard Detection Unit stalls `ADD` in ID for Cycle 4 (injecting a `NOP` bubble into EX). - In Cycle 5: `LW` is in WB (data ready!) and `ADD` enters EX. - Data is forwarded from `MEM/WB` into `EX` smoothly with only **$1\\text{ stall cycle}$** instead of $2$!" },
        { "text": "Because Load instructions can only write data to the Program Counter", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hardware forwarding units are prohibited from connecting to memory", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the ALU cannot perform addition after a memory load", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
