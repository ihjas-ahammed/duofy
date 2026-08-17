# Duofy Reusable Lesson Format: 8051 Interfaces (Interrupts, Vectors, & GPIO Design)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Digital_Electronics_and_Microcontrollers / Microcontrollers_8051_ARM_Architecture`  
**Lesson Format Type:** `8051_interrupt_structure_and_gpio_interfacing_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 8051 interrupt architecture, hardware vector table locations, Interrupt Enable ($\text{IE}$) and Interrupt Priority ($\text{IP}$) control registers, quasi-bidirectional General-Purpose Input/Output ($\text{GPIO}$) ports (Ports 0-3), and external hardware interfacing in embedded controllers (Muhammad Ali Mazidi *The 8051 Microcontroller and Embedded Systems* Chapters 4, 11): master the **8051 Five-Vector Interrupt Priority and Vector Table Map**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Interrupt Source} & \textbf{ROM Vector Address} & \textbf{Default Priority} & \textbf{Flag / Clearing Action} \\
\hline
\mathbf{\text{Reset (Power-On)}} & \mathbf{0000\text{H}} & \text{Highest} & \text{Hardware CPU initialization} \\
\mathbf{\text{External Interrupt 0 (}\overline{\text{INT0}}\text{)}} & \mathbf{0003\text{H}} & 1 & \text{IE0 (Auto-cleared in edge mode)} \\
\mathbf{\text{Timer 0 Overflow (TF0)}} & \mathbf{000B\text{H}} & 2 & \text{TF0 (Auto-cleared on vector jump)} \\
\mathbf{\text{External Interrupt 1 (}\overline{\text{INT1}}\text{)}} & \mathbf{0013\text{H}} & 3 & \text{IE1 (Auto-cleared in edge mode)} \\
\mathbf{\text{Timer 1 Overflow (TF1)}} & \mathbf{001B\text{H}} & 4 & \text{TF1 (Auto-cleared on vector jump)} \\
\mathbf{\text{Serial Port (RI / TI)}} & \mathbf{0023\text{H}} & 5 & \mathbf{\text{Must be cleared by SOFTWARE in ISR!}} \\
\hline
\end{array}$$
master the **8051 GPIO Port Internal Topologies**:
- **Port 0 (P0):** True open-drain bidirectional port; **requires external pull-up resistors ($10\text{ k}\Omega$)** for general I/O; doubles as multiplexed Low-Order Address/Data bus ($A_0\text{-}A_7 / D_0\text{-}D_7$);
- **Ports 1, 2, 3 (P1, P2, P3):** Quasi-bidirectional ports with internal pull-up FETs;
- **Input Read Protocol:** To configure any 8051 GPIO pin as an input, **firmware MUST first write logic '1' to the port latch register** to turn off the lower pull-down transistor.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 8051 Vector Table ($0003\text{H}, 000B\text{H}, \dots$), IE/IP Registers & Open-Drain Port 0 Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Configure and Enable 8051 Timer 0 Interrupt Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | 8051 Interrupt Vector / GPIO Pin Construct & Technical Hardware Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Only 8051 Interrupt Source Whose Hardware Request Flags (RI and TI) Must Be Cleared by Software in the ISR Is the ___ Interrupt (Serial / UART) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Embedded C / Assembly Problem: Configuring the IE Register to Enable External Interrupt 0 and Timer 0 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State 8051 Interrupts & Ports (Mazidi 2007):
   - **Vector Addresses & Control Registers:**
     $$\mathbf{\overline{\text{INT0}} \to 0003\text{H} \quad \Big| \quad \text{TF0} \to 000B\text{H} \quad \Big| \quad \overline{\text{INT1}} \to 0013\text{H} \quad \Big| \quad \text{TF1} \to 001B\text{H} \quad \Big| \quad \text{UART} \to 0023\text{H}}$$
   - **Interrupt Enable Register ($\text{IE} = 8\text{ bits}$):**
     $$\mathbf{\text{IE: } [\text{EA} \mid - \mid \text{ET2} \mid \text{ES} \mid \text{ET1} \mid \text{EX1} \mid \text{ET0} \mid \text{EX0}] \quad (\text{EA} = \text{Global Enable Bit})}$$
   - **Port 0 Pull-Up Invariant:** Port 0 is an **open-drain output**; to use it for general-purpose digital output driving LEDs or logic, **external $10\text{ k}\Omega$ pull-up resistors are mandatory**!
2. **Slide 2 (`ordering`):** Provide 5 steps to configure 8051 Timer 0 interrupt: (1) configure TMOD for Timer 0 mode (e.g. $01\text{H}$ for Mode 1 16-bit), (2) load initial timer count values into TH0 and TL0, (3) write to IE register with $\text{EA}=1$ and $\text{ET0}=1$ ($\text{IE} = 82\text{H}$), (4) start timer by setting $\text{TR0}=1$ in TCON, (5) write Interrupt Service Routine at vector location $000B\text{H}$ ending with the $\text{RETI}$ (Return from Interrupt) instruction!
3. **Slide 3 (`matching`):** Pair 4 concepts (Timer 0 Vector 000BH, Serial Vector 0023H, Port 0 Open-Drain, Global Interrupt Enable EA) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Serial (or UART). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on configuring 8051 IE register: An embedded engineer wants to enable the Global Interrupt system, External Interrupt 0 ($\overline{\text{INT0}}$), and Timer 0 Overflow Interrupt ($\text{TF0}$), while disabling all other interrupt sources. What hexadecimal byte must be loaded into the Interrupt Enable ($\text{IE}$) register? (Bit mapping of IE register: Bit 7: $\text{EA} = 1$; Bit 6: reserved $= 0$; Bit 5: $\text{ET2} = 0$; Bit 4: $\text{ES} = 0$; Bit 3: $\text{ET1} = 0$; Bit 2: $\text{EX1} = 0$; Bit 1: $\text{ET0} = 1$; Bit 0: $\text{EX0} = 1$; Binary bit pattern: $1000\ 0011_2$; Hexadecimal value: $\mathbf{83\text{H}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "8051_interrupt_structure_and_gpio_interfacing_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 8051 Interrupt Structure \\& GPIO Topologies (Mazidi)**\n• **Hardware Interrupt Vector Table Map (Fixed ROM Locations):**\n$$\n\\begin{array}{|l|c|l|}\n\\hline\n\\textbf{Interrupt Source} & \\textbf{Vector Location} & \\textbf{Hardware Flag Clearing Action} \\\\\n\\hline\n\\mathbf{\\text{Reset}} & \\mathbf{0000\\text{H}} & \\text{Initializes CPU core to startup state} \\\\\n\\mathbf{\\text{External 0 (}\\overline{\\text{INT0}}\\text{)}} & \\mathbf{0003\\text{H}} & \\text{IE0 automatically cleared on jump} \\\\\n\\mathbf{\\text{Timer 0 (TF0)}} & \\mathbf{000B\\text{H}} & \\text{TF0 automatically cleared on jump} \\\\\n\\mathbf{\\text{External 1 (}\\overline{\\text{INT1}}\\text{)}} & \\mathbf{0013\\text{H}} & \\text{IE1 automatically cleared on jump} \\\\\n\\mathbf{\\text{Timer 1 (TF1)}} & \\mathbf{001B\\text{H}} & \\text{TF1 automatically cleared on jump} \\\\\n\\mathbf{\\text{Serial Port (RI/TI)}} & \\mathbf{0023\\text{H}} & \\mathbf{\\text{MUST be cleared by SOFTWARE in ISR!}} \\\\\n\\hline\n\\end{array}\n$$\n• **Interrupt Enable Register (IE):** $\\mathbf{[\\text{EA} \\mid - \\mid \\text{ET2} \\mid \\text{ES} \\mid \\text{ET1} \\mid \\text{EX1} \\mid \\text{ET0} \\mid \\text{EX0}]}$ (Bit 7 $\\text{EA} = 1$ enables all unmasked interrupts);\n• **Port 0 Open-Drain Invariant:** Port 0 lacks internal pull-up FETs and **strictly requires external $10\\text{ k}\\Omega$ pull-up resistors** for general-purpose digital I/O!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to configure, enable, and service a Timer 0 overflow interrupt on the 8051 microcontroller.",
      "orderItems": [
        "Configure register TMOD to select Timer 0 operating mode (e.g. Mode 1 16-bit timer)",
        "Load initial countdown values into timer registers TH0 and TL0",
        "Load register IE with 82H to set global enable bit EA = 1 and Timer 0 enable bit ET0 = 1",
        "Set bit TR0 in register TCON to start the timer counting",
        "Write the Interrupt Service Routine (ISR) at vector address 000BH and terminate with the RETI instruction"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each 8051 Peripheral Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Vector 000BH", "right": "Fixed ROM entry address for the Timer 0 overflow interrupt service routine" },
        { "left": "Vector 0023H", "right": "Fixed ROM entry address for Serial UART receive (RI) and transmit (TI) interrupts" },
        { "left": "Global Interrupt Enable (EA)", "right": "Bit 7 of IE register, master gate switch enabling all individual unmasked interrupts" },
        { "left": "Port 0 External Pull-Ups", "right": "Mandatory 10 k\u03a9 resistors required because Port 0 has open-drain output drivers" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The only 8051 interrupt source whose hardware request flags (RI and TI) must be cleared by software in the ISR is the ___ interrupt.",
      "blankAnswer": "serial",
      "blankDistractors": ["timer", "external", "reset"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An embedded engineer wants to enable the Global Interrupt system (EA), External Interrupt 0 (EX0), and Timer 0 Overflow Interrupt (ET0), while keeping all other interrupt sources disabled. What hexadecimal value must be loaded into the IE register?",
      "options": [
        { "text": "IE = 83H (Binary 1000 0011b \u2192 Bit 7 [EA=1], Bit 1 [ET0=1], and Bit 0 [EX0=1] are set)", "isCorrect": true, "explanation": "Correct! Let's solve systematically by inspecting the bit layout of the 8051 Interrupt Enable (IE) register (Muhammad Ali Mazidi *The 8051 Microcontroller and Embedded Systems* Chapter 11). 1. **8051 Interrupt Enable (IE) Bit Positions:** - **Bit 7 (EA):** Global Enable/Disable (Set to $1$). - **Bit 6 (-):** Reserved (Set to $0$). - **Bit 5 (ET2):** Timer 2 Enable (8052 only, Set to $0$). - **Bit 4 (ES):** Serial Port Enable (Set to $0$). - **Bit 3 (ET1):** Timer 1 Enable (Set to $0$). - **Bit 2 (EX1):** External Interrupt 1 Enable (Set to $0$). - **Bit 1 (ET0):** Timer 0 Enable (Set to $1$). - **Bit 0 (EX0):** External Interrupt 0 Enable (Set to $1$). 2. **Construct the 8-Bit Binary Pattern:** $$\\text{IE} = 1000\\ 0011_2$$ 3. **Convert Binary to Hexadecimal:** - High Nibble: $1000_2 = 8_{16} = \\mathbf{8}$. - Low Nibble: $0011_2 = 2 + 1 = 3_{16} = \\mathbf{3}$. - **Hex Value = $\\mathbf{83\\text{H}}$ (or $0\\text{x}83$)**! Flawless 8051 interrupt register configuration!" },
        { "text": "IE = 82H (Enabling only Timer 0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "IE = 81H (Enabling only External 0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "IE = 03H (Forgetting Global Enable EA bit)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
