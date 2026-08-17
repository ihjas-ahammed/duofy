# Duofy Reusable Lesson Format: RISC-V Instruction Encoding Formats (R, I, S, B, U, J-Types)

**Target Topic:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Microprocessors_and_RISC_CISC_Architectures / RISC_V_and_ARM_Architectures`  
**Lesson Format Type:** `risc_v_instruction_encoding_formats_r_i_s_b_u_j_types`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through fixed-width binary bitfield layouts, hardware decoding symmetry, and immediate bit-scrambling rationale across the 6 canonical RISC-V instruction formats (David Patterson & Andrew Waterman *The RISC-V Reader* Chapter 2; David Money Harris & Sarah L. Harris *Digital Design and Computer Architecture: RISC-V Edition* Chapter 6): master **R-type (Register-Register)**, **I-type (Immediate / Load)**, **S-type (Store)**, **B-type (Branch)**, **U-type (Upper Immediate / LUI)**, and **J-type (Unconditional Jump / JAL)**; analyze the microarchitectural brilliance of **Fixed Register Bit Positions** (source registers `rs1` at $[19:15]$ and `rs2` at $[24:20]$, destination register `rd` at $[11:7]$, and `opcode` at $[6:0]$ across all formats, allowing register reads to execute simultaneously with opcode decoding), analyze why the immediate field is split in S-type and B-type formats to keep `rs1` and `rs2` in static bit locations, and perform manual binary-to-hex instruction decoding.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RISC-V 6 Instruction Formats (R, I, S, B, U, J) 32-Bit Field Layout Diagram Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Binary Decoding of a 32-Bit RISC-V Instruction Word into Assembly Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | RISC-V Instruction Format (R, I, S, B, U, J) & Structural Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In RISC-V, the Format Used for Conditional Branch Instructions (e.g. BEQ, BNE) Is the ___-Type (B) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hardware Architecture Analysis: Why RISC-V Splits Store/Branch Immediates to Fix Register Bit Locations Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State RISC-V Instruction Formats (Patterson & Waterman 2017):
   - **The 6 32-Bit Instruction Bitfield Formats:**
     $$\begin{array}{|l|c|c|c|c|c|c|}
     \hline
     \textbf{Format} & \mathbf{[31:25]} & \mathbf{[24:20]} & \mathbf{[19:15]} & \mathbf{[14:12]} & \mathbf{[11:7]} & \mathbf{[6:0]} \\
     \hline
     \mathbf{\text{R-type}} & \text{funct7 (7b)} & \text{rs2 (5b)} & \text{rs1 (5b)} & \text{funct3 (3b)} & \text{rd (5b)} & \text{opcode (7b)} \\
     \mathbf{\text{I-type}} & \text{imm[11:0] (12b)} & - & \text{rs1 (5b)} & \text{funct3 (3b)} & \text{rd (5b)} & \text{opcode (7b)} \\
     \mathbf{\text{S-type}} & \text{imm[11:5] (7b)} & \text{rs2 (5b)} & \text{rs1 (5b)} & \text{funct3 (3b)} & \text{imm[4:0] (5b)} & \text{opcode (7b)} \\
     \mathbf{\text{B-type}} & \text{imm[12,10:5]} & \text{rs2 (5b)} & \text{rs1 (5b)} & \text{funct3 (3b)} & \text{imm[4:1,11]} & \text{opcode (7b)} \\
     \mathbf{\text{U-type}} & \text{imm[31:12] (20b)} & - & - & - & \text{rd (5b)} & \text{opcode (7b)} \\
     \mathbf{\text{J-type}} & \text{imm[20,10:1,11,19:12]} & - & - & - & \text{rd (5b)} & \text{opcode (7b)} \\
     \hline
     \end{array}$$
   - **Sign-Extension Invariant:** Bit **31** is ALWAYS the sign bit in every single format!
2. **Slide 2 (`ordering`):** Provide 5 steps of decoding `0x00A585B3`: (1) convert hex word `0x00A585B3` to 32-bit binary: `0000000 01010 01011 000 01011 0110011`, (2) extract opcode bits [6:0] = `0110011` (binary 51), identifying an R-type integer ALU instruction, (3) extract destination register rd bits [11:7] = `01011` (x11) and funct3 bits [14:12] = `000` (ADD/SUB), (4) extract source registers rs1 bits [19:15] = `01011` (x11) and rs2 bits [24:20] = `01010` (x10), (5) inspect funct7 bits [31:25] = `0000000` (ADD) and synthesize complete assembly instruction: `ADD x11, x11, x10`!
3. **Slide 3 (`matching`):** Pair 4 concepts (R-type Format, I-type Format, S-type Format, B-type Format) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that conditional branches use B-type format. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why immediate is split in S/B types: In RISC-V, why are the immediate offset bits deliberately split into two separate pieces (bits [31:25] and bits [11:7] in S-type; bits [31, 30:25, 11:8, 7] in B-type) rather than keeping them contiguous at the high end of the instruction word? (To ensure that **the register source specifiers (`rs1` at bits [19:15] and `rs2` at bits [24:20]) remain at the exact same physical bit locations across ALL instruction formats**; this allows the hardware to feed bits [19:15] and [24:20] directly into the register file read ports **in parallel during the instruction fetch/decode cycle before the opcode is even decoded**, completely eliminating register multiplexing delays on the processor's critical timing path).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "risc_v_instruction_encoding_formats_r_i_s_b_u_j_types",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: RISC-V 32-Bit Instruction Bitfield Topology (Patterson \\& Waterman)**\n• **The 6 Canonical RISC-V Instruction Formats:**\n$$\n\\begin{array}{|l|c|c|c|c|c|c|}\n\\hline\n\\textbf{Format} & \\mathbf{[31:25]} & \\mathbf{[24:20]} & \\mathbf{[19:15]} & \\mathbf{[14:12]} & \\mathbf{[11:7]} & \\mathbf{[6:0]} \\\\\n\\hline\n\\mathbf{\\text{R-Type (Reg)}} & \\text{funct7 (7b)} & \\mathbf{rs2 (5b)} & \\mathbf{rs1 (5b)} & \\text{funct3 (3b)} & \\mathbf{rd (5b)} & \\text{opcode (7b)} \\\\\n\\mathbf{\\text{I-Type (Imm)}} & \\text{imm[11:0] (12b)} & - & \\mathbf{rs1 (5b)} & \\text{funct3 (3b)} & \\mathbf{rd (5b)} & \\text{opcode (7b)} \\\\\n\\mathbf{\\text{S-Type (Store)}} & \\text{imm[11:5] (7b)} & \\mathbf{rs2 (5b)} & \\mathbf{rs1 (5b)} & \\text{funct3 (3b)} & \\text{imm[4:0] (5b)} & \\text{opcode (7b)} \\\\\n\\mathbf{\\text{B-Type (Branch)}} & \\text{imm[12,10:5]} & \\mathbf{rs2 (5b)} & \\mathbf{rs1 (5b)} & \\text{funct3 (3b)} & \\text{imm[4:1,11]} & \\text{opcode (7b)} \\\\\n\\mathbf{\\text{U-Type (Upper)}} & \\text{imm[31:12] (20b)} & - & - & - & \\mathbf{rd (5b)} & \\text{opcode (7b)} \\\\\n\\mathbf{\\text{J-Type (Jump)}} & \\text{imm[20,10:1,11,19:12]} & - & - & - & \\mathbf{rd (5b)} & \\text{opcode (7b)} \\\\\n\\hline\n\\end{array}\n$$\n• **Hardware Symmetry Invariants:**\n  - $\\mathbf{rs1}$ is ALWAYS bits $[19:15]$, $\\mathbf{rs2}$ is ALWAYS bits $[24:20]$, $\\mathbf{rd}$ is ALWAYS bits $[11:7]$!\n  - Bit $\\mathbf{31}$ is ALWAYS the sign bit for sign extension across every format!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to decode the 32-bit machine word 0x00A585B3 into RISC-V assembly.",
      "orderItems": [
        "Convert the hexadecimal word 0x00A585B3 into 32-bit binary: 0000000 01010 01011 000 01011 0110011",
        "Extract opcode bits [6:0] = 0110011 (decimal 51), identifying an R-type integer ALU computation",
        "Extract destination register rd bits [11:7] = 01011 (register x11 / a1) and funct3 bits [14:12] = 000 (ADD/SUB operation)",
        "Extract source register rs1 bits [19:15] = 01011 (x11) and source register rs2 bits [24:20] = 01010 (x10 / a0)",
        "Inspect funct7 bits [31:25] = 0000000 (specifying ADD) to produce the final assembly instruction: ADD x11, x11, x10"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each RISC-V Instruction Format to its exact Structural Purpose.",
      "matchPairs": [
        { "left": "R-Type Format", "right": "Register-to-register arithmetic and logical operations (ADD, SUB, XOR, SLT)" },
        { "left": "I-Type Format", "right": "Immediate arithmetic and memory load instructions (ADDI, LW, JALR)" },
        { "left": "S-Type Format", "right": "Memory store instructions encoding base address rs1, source data rs2, and split immediate" },
        { "left": "B-Type Format", "right": "Conditional branch instructions encoding PC-relative branch target offsets (BEQ, BNE, BLT)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In RISC-V, the format used for conditional branch instructions like BEQ and BNE is the ___-type format.",
      "blankAnswer": "B",
      "blankDistractors": ["R", "I", "U"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In the RISC-V ISA, why did the architects deliberately split the immediate offset field across two separate bit locations in S-type and B-type instructions rather than keeping the immediate contiguous?",
      "options": [
        { "text": "To keep the source register specifiers (rs1 at bits [19:15] and rs2 at bits [24:20]) and destination specifier (rd at bits [11:7]) in the exact same physical bit positions across all instruction formats; this allows the hardware to route instruction bits directly into the register file read ports immediately upon instruction fetch in parallel with opcode decoding, eliminating complex multiplexers and gate delays on the processor's critical timing path", "isCorrect": true, "explanation": "Correct! This is David Patterson and Andrew Waterman's brilliant hardware optimization in RISC-V (*The RISC-V Reader* Chapter 2). 1. **The Legacy MIPS / ARM Problem:** - In older RISC architectures (like MIPS), different instruction formats put register specifiers in different bit locations (e.g. `rt` moved between bits $[20:16]$ and bits $[15:11]$). - The CPU had to wait for the opcode decoder to figure out the instruction type before it could configure a multiplexer to route bits to the register file! - This added $1-2\\text{ gate delays}$ to the critical path on every instruction fetch. 2. **The RISC-V Solution (Hardware Symmetry):** - `rs1` is ALWAYS bits $[19:15]$. - `rs2` is ALWAYS bits $[24:20]$. - `rd` is ALWAYS bits $[11:7]$. - The wires from the Instruction Register are physically hardwired **straight into the Register File read ports**! 3. **The Trade-off:** - In Store instructions (`SW rs2, imm(rs1)`), there is no `rd` destination register. - So RISC-V uses bits $[11:7]$ to store `imm[4:0]`. - The immediate is split in half on the silicon die, but assembling it in hardware requires **only simple wiring with ZERO logic gates**! Blazing fast clock speed achieved!" },
        { "text": "Because splitting the immediate prevents microprocessors from overheating", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because immediate fields can only hold 4 bits in digital computers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because contiguous immediates are strictly illegal under open-source software licenses", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
