# Duofy Reusable Lesson Format: 8051 Architecture (Memory Map, Timers, & UART Baud)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Digital_Electronics_and_Microcontrollers / Microcontrollers_8051_ARM_Architecture`  
**Lesson Format Type:** `8051_microcontroller_memory_map_timers_and_uart_baud_rate`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the classic 8051 8-bit Harvard microcontroller internal architecture, the 128-byte internal RAM layout (Register Banks 0-3, Bit-Addressable RAM, Scratchpad), Special Function Registers ($\text{SFRs}$), Timer 0/Timer 1 operating modes (Mode 1 16-bit vs Mode 2 8-bit auto-reload), and serial UART baud rate calculations in embedded firmware (Muhammad Ali Mazidi *The 8051 Microcontroller and Embedded Systems* Chapters 2, 5, 9, 10): master the **8051 Internal RAM Map (128 Bytes: 00H to 7FH)**:
1. **00H - 1FH (32 Bytes):** 4 Register Banks (Bank 0 to Bank 3), each containing 8 registers ($R_0 \text{ to } R_7$);
2. **20H - 2FH (16 Bytes):** Bit-Addressable RAM (128 individual bit addresses $00\text{H} \text{ to } 7\text{FH}$ for flag handling without masking);
3. **30H - 7FH (80 Bytes):** General purpose scratchpad RAM and ascending stack area;
derive the **Timer 1 Mode 2 (8-Bit Auto-Reload) UART Baud Rate Equation**:
$$\mathbf{\text{Baud Rate} = \frac{2^{\text{SMOD}}}{32} \times \frac{f_{\text{machine}}}{256 - \text{TH1}} = \frac{2^{\text{SMOD}}}{32} \times \frac{f_{\text{osc}} / 12}{256 - \text{TH1}} = \frac{2^{\text{SMOD}} \times f_{\text{osc}}}{384 \times (256 - \text{TH1})}}$$
solve for the **Timer Reload Register $\text{TH1}$ ($\mathbf{\text{when } \text{SMOD} = 0}$)**:
$$\mathbf{\text{TH1} = 256 - \frac{f_{\text{osc}}}{384 \times \text{Baud Rate}}}$$
(proving why an $11.0592\text{ MHz}$ crystal is used universally to obtain exact integer reload values $\text{TH1} = -3 = 0\text{FDH}$ for $9600\text{ baud}$ with $0.00\%$ timing error).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 8051 RAM Map (Banks, Bit-RAM), Machine Cycle ($f_{\text{osc}}/12$) & UART Baud Rate Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Initialize 8051 Timer 1 in Mode 2 for 9600 Baud Serial Transmission Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | 8051 Memory Section / Register & Technical Hardware Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Classic 8051 Architecture, One Machine Cycle Consists of Exactly ___ Oscillator Clock Periods (12 / Twelve) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Embedded Firmware Problem: Calculating TH1 for 9600 Baud with an 11.0592 MHz Crystal Oscillator Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State 8051 Architecture & Baud Rate (Mazidi 2007):
   - **8051 Memory & Baud Formulations:**
     $$\mathbf{\text{TH1} = 256 - \frac{f_{\text{osc}} \cdot 2^{\text{SMOD}}}{384 \cdot \text{Baud}} \quad \Big| \quad f_{\text{machine}} = \frac{f_{\text{osc}}}{12} \quad \Big| \quad \text{Baud} = \frac{2^{\text{SMOD}} f_{\text{osc}}}{384 (256 - \text{TH1})}}$$
   - **8051 Internal RAM Map Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Address Range} & \textbf{Size} & \textbf{Section Name} & \textbf{Special Capabilities} \\
     \hline
     \mathbf{00\text{H} - 1\text{FH}} & 32 \text{ bytes} & \mathbf{\text{Register Banks 0-3}} & \text{Switched via RS1, RS0 in PSW (R0-R7)} \\
     \mathbf{20\text{H} - 2\text{FH}} & \mathbf{16 \text{ bytes}} & \mathbf{\text{Bit-Addressable RAM}} & \mathbf{128 \text{ individually addressable bits } (00\text{H}-7\text{FH})} \\
     \mathbf{30\text{H} - 7\text{FH}} & 80 \text{ bytes} & \text{General Scratchpad} & \text{Data buffer storage and software stack} \\
     \mathbf{80\text{H} - \text{FFH}} & 128 \text{ bytes} & \text{Special Function Regs} & \text{ACC, B, PSW, DPTR, TMOD, SCON, Ports} \\
     \hline
     \end{array}$$
   - **The Ascending Stack Invariant:** In the 8051, the Stack Pointer (SP) **increments before a PUSH** and **decrements after a POP** (default reset $\text{SP} = 07\text{H}$, placing first push at $08\text{H}$ in Bank 1)!
2. **Slide 2 (`ordering`):** Provide 5 steps to configure 8051 UART for 9600 baud: (1) load TMOD with $20\text{H}$ to configure Timer 1 in Mode 2 (8-bit auto-reload), (2) load TH1 and TL1 with reload value $-3 = 0\text{FDH}$ for 9600 baud (with $f_{\text{osc}} = 11.0592\text{ MHz}$), (3) load SCON with $50\text{H}$ to select 8-bit UART Mode 1 and set REN bit to enable serial reception, (4) set TR1 bit (in TCON) to 1 to start Timer 1 running, (5) write character byte to SBUF and poll the TI transmit interrupt flag until set!
3. **Slide 3 (`matching`):** Pair 4 concepts (Bit-Addressable RAM 20H-2FH, Timer 1 Mode 2 Auto-Reload, SMOD Bit in PCON, 11.0592 MHz Crystal) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 12 (or Twelve). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating 8051 TH1 reload value: An 8051 microcontroller is clocked with an $f_{\text{osc}} = 11.0592\text{ MHz}$ crystal. The serial port operates in Mode 1 with $\text{SMOD} = 0$ at standard baud rate $= 9600\text{ baud}$. What is the exact decimal and hexadecimal value loaded into register $\text{TH1}$? ($\text{TH1} = 256 - \frac{f_{\text{osc}}}{384 \times \text{Baud}} = 256 - \frac{11,059,200}{384 \times 9600} = 256 - \frac{11,059,200}{3,686,400} = 256 - 3 = \mathbf{253\text{ (Decimal)}} = \mathbf{0\text{FDH}\text{ (Hexadecimal)}} = -3\text{ in two's complement}$; Exact integer with $0.00\%$ baud error).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "8051_microcontroller_memory_map_timers_and_uart_baud_rate",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 8051 Architecture \\& UART Baud Generation (Mazidi)**\n• **Timer 1 Mode 2 (8-Bit Auto-Reload) UART Baud Rate Formulation:**\n$$\n\\mathbf{\\text{Baud Rate} = \\frac{2^{\\text{SMOD}}}{32} \\times \\frac{f_{\\text{osc}} / 12}{256 - \\text{TH1}} = \\frac{2^{\\text{SMOD}} \\times f_{\\text{osc}}}{384 \\times (256 - \\text{TH1})}}\n$$\n• **Solving for Reload Value $\\text{TH1}$ (with $\\text{SMOD} = 0$):**\n$$\n\\mathbf{\\text{TH1} = 256 - \\frac{f_{\\text{osc}}}{384 \\times \\text{Baud Rate}}}\n$$\n• **The 8051 Internal 128-Byte RAM Map Layout:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Address Range} & \\textbf{Size} & \\textbf{Section Name} & \\textbf{Hardware Architectural Function} \\\\\n\\hline\n\\mathbf{00\\text{H} - 1\\text{FH}} & 32\\text{ B} & \\mathbf{\\text{4 Register Banks (0-3)}} & \\text{Banks containing 8 registers each (R0-R7)} \\\\\n\\mathbf{20\\text{H} - 2\\text{FH}} & \\mathbf{16\\text{ B}} & \\mathbf{\\text{Bit-Addressable RAM}} & \\mathbf{128 \\text{ direct bit addresses (00H-7FH) for single-bit flags}} \\\\\n\\mathbf{30\\text{H} - 7\\text{FH}} & 80\\text{ B} & \\text{Scratchpad \\& Stack} & \\text{Ascending software stack and general variables} \\\\\n\\mathbf{80\\text{H} - \\text{FFH}} & 128\\text{ B} & \\text{Special Function Regs} & \\text{Directly mapped peripheral registers (ACC, P0-P3)} \\\\\n\\hline\n\\end{array}\n$$\n• **The 11.0592 MHz Invariant:** Standard crystals of $11.0592\\text{ MHz}$ divide cleanly into $28,800\\text{ Hz}$ machine overflow rates, yielding **strictly integer reload values with $0.00\\%$ baud error**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to initialize the 8051 UART for 9600 baud serial communication using Timer 1 in Mode 2.",
      "orderItems": [
        "Load register TMOD with 20H to configure Timer 1 as an 8-bit auto-reload timer (Mode 2)",
        "Load registers TH1 and TL1 with reload value 0FDH (-3 decimal) for 9600 baud at 11.0592 MHz",
        "Load register SCON with 50H to select 8-bit UART Mode 1 and set the REN bit to enable reception",
        "Set the TR1 bit (in TCON) to logic 1 to start Timer 1 running",
        "Write data bytes into transmission buffer SBUF and poll the TI interrupt flag until transmission completes"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each 8051 Architectural Feature to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bit-Addressable RAM (20H-2FH)", "right": "16 bytes providing 128 individual bit addresses for single-bit Boolean flags" },
        { "left": "Timer 1 Mode 2 Auto-Reload", "right": "TMOD = 20H, automatically copying TH1 into TL1 upon every 8-bit overflow to generate UART clock" },
        { "left": "11.0592 MHz Crystal", "right": "Standard embedded clock frequency producing exact integer timer divisor for 9600 baud" },
        { "left": "Ascending Stack (SP)", "right": "8051 stack pointer incrementing before every PUSH and decrementing after every POP" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the classic 8051 microcontroller architecture, one machine cycle consists of exactly ___ oscillator clock periods.",
      "blankAnswer": "12",
      "blankDistractors": ["4", "8", "16"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An 8051 microcontroller is clocked with an f_osc = 11.0592 MHz crystal. The serial UART operates in 8-bit Mode 1 with SMOD = 0 at standard 9600 baud. What is the exact value loaded into reload register TH1?",
      "options": [
        { "text": "TH1 = 253 decimal (0FDH or -3) (TH1 = 256 - (11,059,200 / (384 * 9600)) = 256 - 3 = 253 = 0FDH)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using 8051 UART baud rate equations (Muhammad Ali Mazidi *The 8051 Microcontroller and Embedded Systems* Chapter 10). 1. **Recall the Timer 1 Mode 2 Reload Equation:** $$\\text{TH1} = 256 - \\frac{f_{\\text{osc}} \\times 2^{\\text{SMOD}}}{384 \\times \\text{Baud Rate}}$$ 2. **Substitute Operating Parameters:** - Crystal frequency $f_{\\text{osc}} = 11,059,200\\text{ Hz}$. - $\\text{SMOD} = 0 \\implies 2^0 = 1$. - Desired $\\text{Baud Rate} = 9600\\text{ baud}$. 3. **Evaluate the Fraction:** $$\\text{Divisor} = 384 \\times 9600 = 3,686,400$$ $$\\text{Count} = \\frac{11,059,200}{3,686,400} = \\mathbf{3.000000}$$ 4. **Calculate TH1:** $$\\text{TH1} = 256 - 3 = \\mathbf{253\\text{ (Decimal)}} = \\mathbf{0\\text{FDH}\\text{ (Hexadecimal)}} = \\mathbf{-3\\text{ (in 2's complement)}}$$ 5. **Baud Rate Error:** Because the quotient is an **exact integer (3.0)**, the resulting transmission speed is precisely $9600.00\\text{ baud}$ with **zero timing jitter or framing errors**!" },
        { "text": "TH1 = 244 decimal (0F4H or -12)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "TH1 = 250 decimal (0FAH or -6)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "TH1 = 256 decimal (000H)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
