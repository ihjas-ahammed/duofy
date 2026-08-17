# Duofy Reusable Lesson Format: Multiplexers, Demultiplexers, Decoders, and Priority Encoders

**Target Topic:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Digital_Logic_and_Circuit_Design / Combinational_and_Sequential_Circuits`  
**Lesson Format Type:** `multiplexers_demultiplexers_decoders_and_priority_encoders`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through data routing, address decoding, and universal Boolean function synthesis in MSI (Medium-Scale Integration) combinational logic (M. Morris Mano & Michael D. Ciletti *Digital Design* 6th ed. Chapter 4; David Money Harris & Sarah L. Harris *Digital Design and Computer Architecture* 2nd ed. Chapter 2): master **Multiplexers (MUX $2^n \to 1$)** (using $n$ select lines $S_{n-1}\dots S_0$ to route one of $2^n$ data inputs to a single output line), master the **Universal Logic Generator Property of Multiplexers** (implementing any arbitrary $n$-variable Boolean function using a single $2^{n-1} \to 1$ MUX by connecting $n-1$ variables to select lines and the remaining variable/constants to data inputs), master **Demultiplexers (DEMUX $1 \to 2^n$)**, master **Binary Decoders ($n \to 2^n$) with Enable** (memory address decoding generating individual minterm lines), and master **Priority Encoders ($2^n \to n$)** (resolving multiple simultaneous active inputs by outputting the binary code of the highest-order active line along with a Valid $V$ flag for interrupt vector controllers).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | MUX $2^n \to 1$, Decoder $n \to 2^n$, Priority Encoder $2^n \to n$ Truth Table & Synthesis Reference Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Implementation of a 3-Variable Boolean Function $F(A,B,C) = \sum m(1,2,6,7)$ on a 4-to-1 MUX Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Combinational MSI Logic Building Block & Primary Architectural Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Combinational Routing Circuit That Directs 1 of $2^n$ Inputs to a Single Output Line Is a ___ (Multiplexer / MUX) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Priority Encoders Are Essential for CPU Hardware Interrupt Controllers Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State MUX, Decoders, Encoders (Mano & Ciletti Ch 4):
   - **MSI Combinational Building Blocks Taxonomy:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Circuit Type} & \textbf{Inputs} & \textbf{Outputs} & \textbf{Primary Hardware Application} \\
     \hline
     \mathbf{\text{Multiplexer (MUX)}} & 2^n \text{ Data} + n \text{ Select} & 1 & \mathbf{\text{ALU bus selection, Universal Logic Generator}} \\
     \mathbf{\text{Demultiplexer (DEMUX)}} & 1 \text{ Data} + n \text{ Select} & 2^n & \text{Serial-to-parallel data distribution} \\
     \mathbf{\text{Decoder (with Enable)}} & n \text{ Address Lines} & 2^n \text{ (Minterms)} & \mathbf{\text{Memory address decoding (Chip Select)}} \\
     \mathbf{\text{Priority Encoder}} & 2^n \text{ Request Lines} & n + \text{Valid } (V) & \mathbf{\text{CPU Hardware Interrupt Request (IRQ) arbiter}} \\
     \hline
     \end{array}$$
   - **4-to-1 MUX Equation:**
     $$\mathbf{Y = I_0 \overline{S_1}\overline{S_0} + I_1 \overline{S_1}S_0 + I_2 S_1\overline{S_0} + I_3 S_1 S_0}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of implementing $F(A,B,C) = \sum m(1,2,6,7)$ with 4-to-1 MUX: (1) assign top two variables $A$ and $B$ to MUX select inputs $S_1$ and $S_0$, (2) construct 4-row implementation table for inputs $I_0 (AB=00), I_1 (AB=01), I_2 (AB=10), I_3 (AB=11)$, (3) evaluate column $I_0$ covering minterms 0 and 1: since only $m_1$ is 1, set $I_0 = C$, (4) evaluate $I_1$ ($m_2, m_3 \implies m_2$ is 1 so $I_1 = \overline{C}$), $I_2$ ($m_4, m_5 \implies 0$), $I_3$ ($m_6, m_7 \implies 1$), (5) connect signals $C, \overline{C}, 0, 1$ to MUX data inputs $I_0, I_1, I_2, I_3$, synthesizing function $F$ with zero external logic gates!
3. **Slide 3 (`matching`):** Pair 4 concepts (4-to-1 MUX, 3-to-8 Decoder, Priority Encoder with Valid Bit, Demultiplexer) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Multiplexer. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Priority Encoders in Interrupt Controllers: Why do CPU interrupt controllers (such as the ARM GIC or x86 APIC) use a Priority Encoder rather than a standard binary encoder to process incoming peripheral hardware interrupt requests (IRQs)? (A standard binary encoder produces garbage corrupted outputs if more than one input line is asserted simultaneously (e.g. if IRQ 2 and IRQ 5 fire at the same microsecond); **a Priority Encoder resolves simultaneous multiple requests deterministically by encoding the binary vector of only the highest-priority asserted line while asserting a Valid bit $V=1$, allowing the CPU to instantly service the most critical hardware interrupt (e.g. power failure or disk error) before lower-priority interrupts**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "multiplexers_demultiplexers_decoders_and_priority_encoders",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: MSI Combinational Logic Primitives (Mano \\& Ciletti 2017)**\n• **Core Combinational Building Block Matrix:**\n$$\n\\begin{array}{|l|c|c|l|}\n\\hline\n\\textbf{Building Block} & \\textbf{Input Count} & \\textbf{Output Count} & \\textbf{Primary Computer Architecture Role} \\\\\n\\hline\n\\mathbf{\\text{Multiplexer (MUX)}} & 2^n \\text{ Data} + n \\text{ Select} & 1 & \\mathbf{\\text{Data bus routing; Universal Logic Synthesis}} \\\\\n\\mathbf{\\text{Demultiplexer (DEMUX)}} & 1 \\text{ Data} + n \\text{ Select} & 2^n & \\text{Serial data distributor / deserializer} \\\\\n\\mathbf{\\text{Binary Decoder}} & n \\text{ Address lines} & 2^n \\text{ Minterms} & \\mathbf{\\text{Memory row address decoding (Chip Select)}} \\\\\n\\mathbf{\\text{Priority Encoder}} & 2^n \\text{ Request lines} & n + \\text{Valid } (V) & \\mathbf{\\text{CPU Hardware Interrupt Request (IRQ) arbitration}} \\\\\n\\hline\n\\end{array}\n$$\n• **4-to-1 MUX Boolean Synthesis Equation:**\n$$\n\\mathbf{Y = I_0 \\overline{S_1}\\overline{S_0} + I_1 \\overline{S_1}S_0 + I_2 S_1\\overline{S_0} + I_3 S_1 S_0}\n$$\n• **Universal MUX Invariant:** Any $n$-variable Boolean function can be implemented using a single $\\mathbf{2^{n-1} \\to 1}$ **Multiplexer** with zero external gates!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to synthesize F(A,B,C) = Sum_m(1, 2, 6, 7) using a 4-to-1 Multiplexer.",
      "orderItems": [
        "Assign the most significant Boolean variables A and B to MUX select lines S1 and S0 respectively",
        "Construct the MUX implementation table with columns corresponding to inputs I0 (AB=00), I1 (AB=01), I2 (AB=10), I3 (AB=11)",
        "Evaluate column I0 covering minterms m0 and m1: since m1=1 and m0=0, the required input signal is C",
        "Evaluate remaining columns: column I1 (m2=1, m3=0 -> C'), column I2 (m4=0, m5=0 -> 0), column I3 (m6=1, m7=1 -> 1)",
        "Connect signals C, C', 0, and 1 to MUX data inputs I0, I1, I2, I3, completing full logic synthesis with zero external gates"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Combinational Building Block to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "4-to-1 Multiplexer", "right": "Selects 1 of 4 data inputs and routes it to a single output based on a 2-bit select code" },
        { "left": "3-to-8 Decoder", "right": "Activates exactly 1 of 8 output lines corresponding to a 3-bit binary address input" },
        { "left": "4-to-2 Priority Encoder", "right": "Encodes the index of the highest-order active input line and asserts a Valid bit V=1" },
        { "left": "Demultiplexer (DEMUX)", "right": "Takes a single input data line and routes it to 1 of 2^n output lines via select signals" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The combinational routing circuit that selects one of many input signals and forwards it to a single output line is a ___.",
      "blankAnswer": "multiplexer",
      "blankDistractors": ["decoder", "encoder", "flip-flop"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why do microprocessor interrupt controllers (such as the ARM GIC or Intel APIC) use a Priority Encoder rather than a standard binary encoder to arbitrate incoming peripheral hardware interrupt requests (IRQs)?",
      "options": [
        { "text": "A standard binary encoder requires that exactly one single input line is active at any time; if multiple peripheral devices (such as a network card, keyboard, and timer) assert interrupt requests simultaneously, a standard encoder produces an invalid, corrupted binary output code; a Priority Encoder resolves multiple simultaneous active requests deterministically by encoding only the index of the highest-priority asserted line while asserting a Valid bit V=1, guaranteeing that critical high-priority interrupts (like power failure or hardware faults) are serviced immediately ahead of lower-priority requests", "isCorrect": true, "explanation": "Correct! This is M. Morris Mano and David Money Harris's defining operational analysis of priority encoders in computer systems (Mano & Ciletti *Digital Design* Chapter 4; Harris & Harris *Digital Design and Computer Architecture* Chapter 2). 1. **The Standard Encoder Failure Mode:** - Suppose inputs $D_2 (0100)$ and $D_1 (0010)$ are both HIGH at the same instant (two peripherals asking for CPU attention). - A standard 4-to-2 encoder ORs the bits: Output $= 01 + 10 = \\mathbf{11_2} = \\text{Interrupt 3}$! - The CPU incorrectly jumps to the Interrupt 3 handler (e.g. disk driver) even though Interrupt 3 never fired! 2. **The Priority Encoder Solution:** - Priority is assigned: $D_3 > D_2 > D_1 > D_0$. - If $D_2$ and $D_1$ are both asserted: The encoder ignores $D_1$ and outputs **$10_2$ (Interrupt 2)**! - It also asserts **Valid Bit $V=1$** (which distinguishes *\"Interrupt 0 is firing\"* from *\"No interrupts are firing at all\"*). 3. **The Architectural Impact:** Guarantees deterministic, rock-solid hardware interrupt arbitration inside every modern CPU!" },
        { "text": "Because standard encoders can only be manufactured in vacuum tubes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Priority Encoders eliminate the need for CPU registers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because standard binary encoders require alternating current to operate", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
