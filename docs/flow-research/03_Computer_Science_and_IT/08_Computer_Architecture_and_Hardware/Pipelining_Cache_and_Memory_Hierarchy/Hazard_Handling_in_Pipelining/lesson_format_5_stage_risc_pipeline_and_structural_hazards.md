# Duofy Reusable Lesson Format: 5-Stage RISC Pipeline (and Structural Hazards)

**Target Topic:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Pipelining_Cache_and_Memory_Hierarchy / Hazard_Handling_in_Pipelining`  
**Lesson Format Type:** `5_stage_risc_pipeline_and_structural_hazards`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through overlapped instruction execution, pipeline registers, stage balancing, and structural resource conflicts in microprocessors (David A. Patterson & John L. Hennessy *Computer Organization and Design* Chapter 4; Hennessy & Patterson *Computer Architecture: A Quantitative Approach*): master the classic **5-Stage RISC Pipeline** (**IF:** Instruction Fetch, **ID:** Instruction Decode & Register Read, **EX:** Execute ALU / Address Calculation, **MEM:** Memory Access Data Cache, **WB:** Write-Back to Register File), analyze the role of **Pipeline Registers (IF/ID, ID/EX, EX/MEM, MEM/WB)** in decoupling stage timing and preserving control vectors, master **Throughput and Speedup Formulas ($\mathbf{\text{Throughput} \approx 1 \text{ inst/cycle}}, \ \mathbf{\text{Speedup} \approx k = 5}$)**, analyze the physical root causes of **Structural Hazards** (hardware resource collisions e.g. simultaneous memory access for instruction fetch and data read), and evaluate the **Harvard Split-Cache Architecture** (separate L1 I-Cache and L1 D-Cache) and **Dual-Port Register Files** (split clock phase: write in first half, read in second half) as structural hazard eliminations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The Classic 5-Stage RISC Pipeline Diagram & Structural Hazard Resolution Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Progression of an ALU Instruction Across the 5 Pipeline Stages Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pipeline Stage / Structural Isolation Mechanism & Hardware Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Classic 5-Stage RISC Pipeline, the Stage Where Computed ALU Results Are Written to the Register File Is ___ (WB / Write-Back) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis: Why Unified Von Neumann Caches Cause Severe Structural Hazards in Pipelined CPUs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State 5-Stage RISC Pipeline (Patterson & Hennessy Ch 4):
   - **The 5 Pipeline Stages Taxonomy:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Stage} & \textbf{Name} & \textbf{Key Hardware Components Active} & \textbf{Primary Operation} \\
     \hline
     \mathbf{\text{IF}} & \text{Instruction Fetch} & \text{PC, Instruction Memory (I-Cache), Adder} & \text{Fetch 32-bit inst; } \text{PC} \leftarrow \text{PC} + 4 \\
     \mathbf{\text{ID}} & \text{Instruction Decode} & \text{Register File (Read Ports), Control Logic, Sign-Ext} & \text{Read } rs1, rs2\text{; Decode opcode} \\
     \mathbf{\text{EX}} & \text{Execute / ALU} & \text{ALU, Branch Addr Adder, Forwarding MUXes} & \text{ALU math; Compute Eff Address} \\
     \mathbf{\text{MEM}} & \text{Memory Access} & \text{Data Memory (D-Cache)} & \text{Read/Write RAM for LW / SW} \\
     \mathbf{\text{WB}} & \text{Write-Back} & \text{Register File (Write Port)} & \text{Write result into destination } rd \\
     \hline
     \end{array}$$
   - **Structural Hazard Resolution Invariant:**
     - Memory Structural Conflict $\implies$ **Harvard Architecture (Separate L1 I-Cache and L1 D-Cache)**.
     - Register File Structural Conflict $\implies$ **Split-Phase Clocking: Writes happen on First Half-Cycle ($\uparrow$), Reads on Second Half-Cycle ($\downarrow$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of instruction progression for `ADD x3, x1, x2`: (1) Cycle 1 (IF): Instruction Fetch unit reads 32-bit machine word from I-Cache and increments PC to PC+4, storing into IF/ID register, (2) Cycle 2 (ID): Decoder parses opcode and simultaneously reads registers x1 and x2 from Register File, latching into ID/EX register, (3) Cycle 3 (EX): ALU performs addition of operands (x1 + x2) in single clock cycle, latching sum into EX/MEM register, (4) Cycle 4 (MEM): Arithmetic instruction passes result through MEM stage with zero memory access, latching into MEM/WB register, (5) Cycle 5 (WB): Write-Back multiplexer routes ALU sum into destination register x3 during the first half of clock cycle, completing execution!
3. **Slide 3 (`matching`):** Pair 4 concepts (IF Stage, ID Stage, EX Stage, WB Stage) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of WB (Write-Back) stage. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on unified memory structural hazards: In a single-core 5-stage pipelined processor, why does using a single unified L1 cache (for both instructions and data) trigger a severe structural hazard every time a Load (`LW`) or Store (`SW`) instruction executes? (In a pipelined CPU, the Instruction Fetch (IF) stage must access memory every single clock cycle to fetch the next sequential instruction word; **when an earlier Load or Store instruction reaches the Memory Access (MEM) stage simultaneously, both the IF stage and MEM stage demand access to the same unified memory port; because single-ported memory cannot perform two simultaneous reads/writes at distinct addresses in the same clock cycle, the pipeline is forced to stall the IF stage (inserting a bubble), lowering throughput**; separating L1 into independent I-Cache and D-Cache eliminates this conflict entirely).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "5_stage_risc_pipeline_and_structural_hazards",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Classic 5-Stage RISC Pipeline (Patterson \\& Hennessy)**\n• **Pipelining Hardware Stages \\& Responsibilities:**\n$$\n\\begin{array}{|c|l|l|l|}\n\\hline\n\\textbf{Stage} & \\textbf{Stage Name} & \\textbf{Active Hardware Units} & \\textbf{Key Operation} \\\\\n\\hline\n\\mathbf{\\text{IF}} & \\text{Instruction Fetch} & \\text{Instruction Cache, PC, PC+4 Adder} & \\text{Fetches 32-bit word; } \\text{PC} \\leftarrow \\text{PC}+4 \\\\\n\\mathbf{\\text{ID}} & \\text{Instruction Decode} & \\text{Register File (Read), Control Decoder, SignExt} & \\text{Reads } rs1, rs2\\text{; Decodes control vectors} \\\\\n\\mathbf{\\text{EX}} & \\text{Execute / ALU} & \\text{ALU, Forwarding Multiplexers, ALU Control} & \\text{Performs ALU math / Effective Address} \\\\\n\\mathbf{\\text{MEM}} & \\text{Memory Access} & \\text{Data Cache (D-Cache)} & \\text{Executes RAM Read (LW) / Write (SW)} \\\\\n\\mathbf{\\text{WB}} & \\text{Write-Back} & \\text{Register File (Write Port)} & \\text{Writes final result into destination } rd \\\\\n\\hline\n\\end{array}\n$$\n• **Structural Hazard Elimination Invariants:**\n  - **Memory Conflict:** Solved via **Harvard Architecture (Split L1 I-Cache \\& D-Cache)**!\n  - **Register Conflict:** Solved via **Split-Phase Clocking: Writes in 1st half-cycle ($\\uparrow$), Reads in 2nd half ($\\downarrow$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential clock cycle transitions executed by an arithmetic instruction (ADD x3, x1, x2) in a 5-stage RISC pipeline.",
      "orderItems": [
        "Cycle 1 (IF): Instruction Fetch unit retrieves the 32-bit ADD machine word from I-Cache and advances PC to PC+4",
        "Cycle 2 (ID): Instruction Decoder extracts register indices and reads operands x1 and x2 from the dual-port Register File",
        "Cycle 3 (EX): Arithmetic Logic Unit (ALU) computes the binary sum (x1 + x2) and latches the result into the EX/MEM register",
        "Cycle 4 (MEM): ADD instruction bypasses Data Cache (D-Cache) and propagates the sum directly into the MEM/WB register",
        "Cycle 5 (WB): Write-Back multiplexer routes the computed sum into destination register x3 during the first half of the clock cycle"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Pipeline Stage / Structural Isolation Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "IF (Instruction Fetch)", "right": "Retrieves the 32-bit machine instruction from L1 Instruction Cache using the Program Counter" },
        { "left": "ID (Instruction Decode)", "right": "Extracts opcode control signals, sign-extends immediate fields, and reads source registers" },
        { "left": "EX (Execute / ALU)", "right": "Executes arithmetic/logical operations and calculates effective memory addresses or branch targets" },
        { "left": "Harvard Split Cache", "right": "Separates L1 into dedicated Instruction and Data caches to eliminate memory structural hazards" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the classic 5-stage RISC pipeline, the final stage where computed results are written into the register file is the ___-Back stage.",
      "blankAnswer": "Write",
      "blankDistractors": ["Memory", "Execute", "Decode"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a 5-stage pipelined microprocessor, why does using a single unified L1 cache (shared for both instructions and data) trigger a severe Structural Hazard every time a Load (LW) or Store (SW) instruction executes?",
      "options": [
        { "text": "In a 5-stage pipeline, the Instruction Fetch (IF) stage must access memory every single clock cycle to fetch the next instruction in sequence; when an earlier Load or Store instruction simultaneously reaches the Memory Access (MEM) stage, both the IF stage (fetching an instruction) and the MEM stage (reading/writing data) demand access to the same unified memory port; because single-ported memory cannot perform two independent read/write operations at different memory addresses in the same clock cycle, the processor is forced to stall the IF stage, inserting a 1-cycle pipeline bubble and reducing throughput", "isCorrect": true, "explanation": "Correct! This is David Patterson and John Hennessy's defining example of a structural hazard (*Computer Organization and Design* Chapter 4 *The Processor*). 1. **The Conflict on Single-Ported Unified Memory:** - In Cycle 4: Instruction 1 (`LW x1, 0(x2)`) is in the **MEM stage** (reading data from address `0x1000`). - In the exact same Cycle 4: Instruction 4 (`ADD x5, x6, x7`) is in the **IF stage** (fetching instruction from PC `0x0040`). - Both stages require memory access in the exact same $250\\text{ picoseconds}$! - Single-ported unified cache cannot satisfy both requests. 2. **The Resulting Penalty:** - The hardware must stall Instruction 4 in IF. - A $1\\text{-cycle bubble}$ is injected into the pipeline, degrading CPI above $1.0$. 3. **The Harvard Architecture Solution:** - Modern CPUs build **separate L1 Instruction Cache (I-Cache)** and **L1 Data Cache (D-Cache)**. - IF reads I-Cache; MEM reads D-Cache simultaneously with **ZERO structural stalls**!" },
        { "text": "Because unified caches permanently corrupt all integer variables", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Load and Store instructions require alternating current", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because pipelining is mathematically impossible on silicon chips", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
