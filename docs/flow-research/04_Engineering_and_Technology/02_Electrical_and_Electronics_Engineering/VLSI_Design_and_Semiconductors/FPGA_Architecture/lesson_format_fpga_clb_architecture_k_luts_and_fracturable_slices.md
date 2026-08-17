# Duofy Reusable Lesson Format: FPGA Logic Fabric (CLBs, K-LUTs, & Fracturable Slices)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / FPGA_Architecture`  
**Lesson Format Type:** `fpga_clb_architecture_k_luts_and_fracturable_slices`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the core logic fabric of modern Field-Programmable Gate Arrays (FPGAs), Configurable Logic Blocks (CLBs), $K$-input Look-Up Table ($K\text{-LUT}$) SRAM truth-table memory structures ($2^K$ bits), fracturable 6-LUT operation (dual 5-LUT mode), dedicated fast arithmetic carry lookahead chains (`CARRY4`/`CARRY8`), and the structural distinction between SLICEL (Logic) and SLICEM (Memory: Distributed RAM & 32-bit Shift Register `SRL32`) (Vaughn Betz, Jonathan Rose *Architecture and CAD for Deep-Submicron FPGAs*; Ian Kuon, Jonathan Rose *FPGA Architecture: Survey and Challenges*; Xilinx 7-Series CLB User Guide UG474): formulate the **$K$-LUT Truth Table Storage Capacity**:
$$\mathbf{N_{\text{SRAM bits}} = 2^K \quad (K=4 \implies 16\text{ bits}, \ K=6 \implies 64\text{ bits per LUT})}$$
derive the **Fracturable 6-LUT Dual Operation Modes**:
1. **Single 6-Input Mode:** Implements ANY arbitrary 6-variable Boolean function $Y = f(A_1, A_2, A_3, A_4, A_5, A_6)$ in a single LUT propagation delay ($t_{\text{lut}}$);
2. **Dual 5-Input Fractured Mode:** Fractures into **two independent 5-input LUTs** sharing up to 5 common inputs to generate two separate outputs ($O_5 = f_1(A_1..A_5)$ and $O_6 = f_2(A_1..A_5)$), doubling logic density;
master the **SLICEL vs SLICEM Microarchitecture Duality**:
$$\begin{array}{|l|c|c|c|l|}
\hline
\textbf{Slice Type} & \textbf{LUTs / FFs per Slice} & \textbf{Distributed RAM} & \textbf{Shift Register (SRL32)} & \textbf{Primary Functionality} \\
\hline
\mathbf{\text{SLICEL (Logic)}} & 4 \times 6\text{-LUTs} \ / \ 8 \text{ FFs} & \text{No} & \text{No} & \mathbf{\text{Pure Combinational / Sequential Logic}} \\
\mathbf{\text{SLICEM (Memory)}} & 4 \times 6\text{-LUTs} \ / \ 8 \text{ FFs} & \mathbf{\text{Yes (Up to } 256\text{ bits)}} & \mathbf{\text{Yes (32-bit delay shift)}} & \mathbf{\text{Small FIFOs, Pipeline registers, Lookups}} \\
\hline
\end{array}$$
(proving why modern FPGA architectures dedicate $\approx 25-30\%$ of slices to SLICEM to provide ultra-fast distributed memory without wasting large Block RAM blocks).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $K$-LUT ($2^K$ bits), Fracturable 6-LUT, Carry Chains & SLICEL vs SLICEM Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Map a Boolean Function into Fracturable 6-LUTs and Carry Chains Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | FPGA Logic Element / Slice Component & Technical Hardware Capability Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Modern 6-Input Look-Up Table Contains Exactly ___ SRAM Configuration Bits to Store Its Truth Table (64 / Sixty-Four) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | FPGA Architecture Problem: Calculating Total SRAM Bits and Fracturing for a 4-LUT CLB Slice Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State FPGA Logic Fabric & Slices (Betz & Rose 1999; Kuon & Rose 2007):
   - **LUT Capacity & Fracturability:**
     $$\mathbf{N_{\text{SRAM}} = 2^K \quad \Big| \quad \text{One } 6\text{-LUT} \iff \text{Two } 5\text{-LUTs with shared inputs} \quad \Big| \quad \text{SLICEM} = \text{LUT RAM / SRL32}}$$
   - **Slice Capability Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Hardware Element} & \textbf{Internal Architecture} & \textbf{Propagation Delay} & \textbf{Key Role} \\
     \hline
     \mathbf{6\text{-LUT}} & 64\text{ SRAM cells } + 64\text{-to-}1 \text{ MUX} & t_{\text{lut}} \approx 0.1 - 0.2\text{ ns} & \mathbf{\text{Arbitrary 6-input logic function}} \\
     \mathbf{\text{Dedicated Carry Chain}} & \text{Dedicated fast MUXCY / XORCY} & t_{\text{carry}} \approx 0.01\text{ ns/bit} & \mathbf{\text{High-speed arithmetic addition/subtraction}} \\
     \mathbf{\text{SLICEM SRL32}} & \text{Shift register dynamic addressing} & Clock-synchronized & \mathbf{\text{32-bit variable delay line in 1 LUT!}} \\
     \hline
     \end{array}$$
   - **The Look-Up Table Invariant:** A $K$-LUT computes *any* arbitrary Boolean function of $K$ variables in **exactly the same constant propagation delay ($t_{\text{lut}}$)**, whether the function is a simple 2-input AND or a complex 6-variable XOR parity tree!
2. **Slide 2 (`ordering`):** Provide 5 steps of mapping logic into FPGA slices: (1) synthesize Boolean equations into generic logic gates, (2) run technology mapping to partition equations into 6-input subgraphs, (3) pair compatible 5-input functions into fracturable dual-output 6-LUTs to maximize density, (4) route arithmetic carry chains through dedicated `CARRY4` silicon logic, (5) pack packed LUTs and edge-triggered D flip-flops into CLB slices!
3. **Slide 3 (`matching`):** Pair 4 concepts (6-LUT Fracturing, SLICEM Slice, Dedicated Carry Chain `CARRY4`, SRL32 Mode) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 64 (or Sixty-Four). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating LUT SRAM capacity and slice utilization: A modern FPGA CLB contains 2 slices, each equipped with four 6-input fracturable LUTs (8 total 6-LUTs per CLB). How many total SRAM configuration bits are contained within the LUTs of a single CLB, and how many distinct 5-input Boolean functions can a single CLB implement if all 6-LUTs operate in fractured dual-output mode? (Each 6-LUT requires $2^6 = \mathbf{64\text{ SRAM bits}}$; 8 LUTs per CLB $\implies 8 \times 64 = \mathbf{512\text{ SRAM bits}}$; In fractured mode, each 6-LUT implements two 5-input functions $\implies 8 \times 2 = \mathbf{16\text{ distinct 5-input functions}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fpga_clb_architecture_k_luts_and_fracturable_slices",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: FPGA Logic Fabric \\& Fracturable Slices (Betz \\& Rose)**\n• **$K$-LUT Truth Table Memory Capacity:**\n$$\n\\mathbf{N_{\\text{SRAM bits}} = 2^K \\quad (K=4 \\implies 16\\text{ bits}, \\ K=6 \\implies 64\\text{ bits per LUT})}\n$$\n• **Fracturable 6-LUT Dual Operation Modes:**\n  - **Single 6-Input Mode:** Computes ANY arbitrary 6-variable function $Y = f(A_1..A_6)$ in constant delay $t_{\\text{lut}}$;\n  - **Dual 5-Input Mode:** Fractures into **two 5-input LUTs** sharing up to 5 inputs to generate 2 outputs, doubling packing density!\n• **SLICEL vs SLICEM Functional Duality:**\n  - **SLICEL (Logic):** Pure Boolean logic, dedicated arithmetic carry chains (`CARRY4/8`), wide multiplexers, and flip-flops;\n  - **SLICEM (Memory):** In addition to logic, allows LUTs to be configured as **Distributed RAM (64/256 bits)** or **32-bit Shift Registers (`SRL32`)**!\n• **The Constant Delay Invariant:** A $K$-LUT evaluates *any* arbitrary Boolean function of $K$ variables in **identical constant delay ($t_{\\text{lut}}$)**, making LUT delay completely independent of function complexity!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to map a complex digital arithmetic datapath into FPGA CLB slices.",
      "orderItems": [
        "Synthesize high-level HDL code into an optimized gate-level Directed Acyclic Graph (DAG)",
        "Perform technology mapping (e.g. FlowMap) to partition logic gates into optimal 6-input K-LUT subgraphs",
        "Identify compatible 5-input logic subgraphs and pack them into dual-output fracturable 6-LUTs",
        "Map high-speed adder carry propagation to dedicated hardened fast carry chain multiplexers (CARRY4/8)",
        "Pack paired LUTs and flip-flops into CLB slices and assign to SLICEL or SLICEM blocks based on memory requirements"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each FPGA Logic Fabric Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "6-LUT Fracturing", "right": "Splitting a single 6-input LUT into two independent 5-input LUTs with shared inputs to double logic density" },
        { "left": "SLICEM Slice", "right": "Memory-capable slice allowing LUTs to operate as 64-bit distributed RAM or 32-bit shift registers (SRL32)" },
        { "left": "Dedicated Carry Chain (CARRY4)", "right": "Hardened lookahead silicon path bypassing regular LUTs to perform sub-nanosecond arithmetic addition" },
        { "left": "SRL32 Mode", "right": "Configuring a single LUT as a 32-cycle programmable delay pipeline without using flip-flops" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A modern 6-input Look-Up Table contains exactly ___ SRAM configuration bits to store its complete truth table.",
      "blankAnswer": "64",
      "blankDistractors": ["16", "32", "128"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A modern FPGA Configurable Logic Block (CLB) contains 2 slices, each having four 6-input fracturable LUTs (8 total 6-LUTs per CLB). How many total SRAM configuration bits are contained within the LUTs of one CLB, and how many distinct 5-input logic functions can it implement in fractured mode?",
      "options": [
        { "text": "512 SRAM bits and 16 distinct 5-input functions (Each 6-LUT has 2^6 = 64 SRAM bits \u2192 8 * 64 = 512 bits; in fractured dual mode, each 6-LUT implements two 5-LUT functions \u2192 8 * 2 = 16 functions)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using FPGA logic block microarchitecture principles (Vaughn Betz & Jonathan Rose *Architecture and CAD for Deep-Submicron FPGAs*). 1. **Calculate SRAM Capacity per 6-LUT:** - A $K$-input LUT requires $2^K$ static memory cells (SRAM configuration bits) to store the $2^K$ output entries of its complete truth table: $$N_{\\text{SRAM,lut}} = 2^6 = \\mathbf{64\\text{ SRAM bits}}$$ 2. **Calculate Total CLB LUT Configuration Storage:** - A CLB has 2 slices $\\times$ 4 LUTs/slice $= \\mathbf{8\\text{ total 6-LUTs}}$. - Total SRAM capacity: $$N_{\\text{SRAM,total}} = 8 \\times 64\\text{ bits} = \\mathbf{512\\text{ SRAM bits}}$$ 3. **Calculate Maximum 5-Input Logic Capacity (Fractured Mode):** - In modern architectures (like Xilinx 7-Series / UltraScale and Intel Stratix / Agilex ALMs), a 6-LUT is fracturable: it can operate as **two independent 5-input LUTs** (sharing up to 5 inputs) feeding separate output pins ($O_5, O_6$). - Total 5-input functions implementable in 1 CLB: $$N_{\\text{funcs}} = 8 \\times 2 = \\mathbf{16\\text{ distinct 5-input Boolean functions}}$$ 4. **Architectural Benefit:** This allows CAD tools to achieve near $100\\%$ logic density by packing smaller 2-to-5 input functions into unused halves of 6-LUTs! Flawless FPGA CLB analysis!" },
        { "text": "256 SRAM bits and 8 distinct functions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1024 SRAM bits and 32 distinct functions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "512 SRAM bits and 8 distinct functions", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
