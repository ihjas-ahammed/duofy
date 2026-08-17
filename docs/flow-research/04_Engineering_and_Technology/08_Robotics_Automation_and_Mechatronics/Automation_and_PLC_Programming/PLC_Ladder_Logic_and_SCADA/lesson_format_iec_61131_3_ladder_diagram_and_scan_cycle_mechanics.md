# Duofy Reusable Lesson Format: Industrial Automation (IEC 61131-3 & PLC Scan Cycles)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Automation_and_PLC_Programming / PLC_Ladder_Logic_and_SCADA`  
**Lesson Format Type:** `iec_61131_3_ladder_diagram_and_scan_cycle_mechanics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the architecture and deterministic execution of industrial Programmable Logic Controllers (PLCs), the **IEC 61131-3 International Programming Standard** (Ladder Diagram LD, Function Block Diagram FBD, Structured Text ST, Sequential Function Chart SFC), the 4-stage **PLC Cyclic Scan Execution Loop** (Physical Input Scan $\to$ Ladder Logic Execution $\to$ Output Image Table Write $\to$ Diagnostics & Communications), fundamental bit-level contact instructions (**XIC Examine If Closed / Normally Open `] [`**, **XIO Examine If Open / Normally Closed `]/[`**, **OTE Output Energize `( )`**), and memory image tables (Frank D. Petruzella *Programmable Logic Controllers* 5th ed. Chapters 1, 5, 6; IEC 61131-3 International Standard; Hugh Jack *Automating Manufacturing Systems with PLCs*): formulate the **PLC Cyclic Scan Cycle Time Master Formulation**:
$$\mathbf{T_{\text{scan}} = T_{\text{input\_scan}} + T_{\text{program\_exec}} + T_{\text{output\_write}} + T_{\text{housekeeping}} \quad [\text{milliseconds}]}$$
where:
1. **$T_{\text{scan}}$:** Total cyclic scan execution loop period ($1 - 10\text{ ms}$);
2. **$T_{\text{input\_scan}}$:** Time to copy physical input terminal voltages into Input Image Table memory;
3. **$T_{\text{program\_exec}}$:** Time to evaluate all ladder rungs sequentially from left-to-right, top-to-bottom;
4. **$T_{\text{output\_write}}$:** Time to update physical output terminal transistors/relays from Output Image Table memory;
master the **Fundamental Ladder Logic Contact & Coil Truth Table**:
$$\begin{array}{|l|c|c|l|}
\hline
\textbf{Instruction Name} & \textbf{Symbol} & \textbf{Memory Bit State} & \textbf{Rung Power Flow Continuity} \\
\hline
\mathbf{\text{XIC (Examine If Closed)}} & \mathbf{]\ [} & \mathbf{1 \ (\text{High / True})} & \mathbf{\text{TRUE (Conducts power across contact)}} \\
\text{XIC (Examine If Closed)} & ]\ [ & 0 \ (\text{Low / False}) & \text{FALSE (Blocks power flow)} \\
\mathbf{\text{XIO (Examine If Open)}} & \mathbf{]/[} & \mathbf{0 \ (\text{Low / False})} & \mathbf{\text{TRUE (Conducts power across contact)}} \\
\text{XIO (Examine If Open)} & ]/[ & 1 \ (\text{High / True}) & \text{FALSE (Blocks power flow)} \\
\mathbf{\text{OTE (Output Energize)}} & \mathbf{(\ )} & \text{Rung is TRUE} & \mathbf{\text{Sets referenced memory bit to } 1 \ (\text{Energized})} \\
\text{OTE (Output Energize)} & (\ ) & \text{Rung is FALSE} & \text{Resets referenced memory bit to } 0 \ (\text{De-energized}) \\
\hline
\end{array}$$
(proving that PLCs do not continuously poll physical wires during logic execution, but instead operate on buffered internal memory tables updated deterministically every scan cycle).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | IEC 61131-3, PLC Scan Cycle (Input $\to$ Program $\to$ Output) & XIC `] [`, XIO `]/[`, OTE `( )` Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution of a Single PLC Cyclic Scan Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | PLC Ladder Logic Instruction / Architecture Entity & Technical Industrial Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In PLC Ladder Logic Programming, the Examine If Closed (XIC) Instruction Symbolized by `] [` Evaluates as Logically TRUE When the Referenced Memory Address Holds a Binary Value of ___ (1 / One) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Automation Problem: Evaluating Rung Continuity and Output Coil States Across a PLC Scan Cycle Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State PLC Scan Cycle & Bit Logic Mechanics (Petruzella 2017; IEC 61131-3):
   - **Scan Cycle Formulations:**
     $$\mathbf{\text{Physical Inputs} \xrightarrow{\text{Scan}} \text{Input Table} \to \text{Execute Rungs (Left } \to \text{ Right, Top } \to \text{ Bottom)} \to \text{Output Table} \xrightarrow{\text{Write}} \text{Physical Actuators}}$$
   - **IEC 61131-3 Standard Languages Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{IEC Language} & \textbf{Format Paradigm} & \textbf{Primary Industrial Application} \\
     \hline
     \mathbf{\text{Ladder Diagram (LD)}} & \mathbf{\text{Graphical Relay Logic}} & \mathbf{\text{Discrete machine sequencing, interlocks, safety rungs}} \\
     \text{Function Block (FBD)} & Graphical Signal Flow & Continuous PID process control, motion control \\
     \mathbf{\text{Structured Text (ST)}} & \mathbf{\text{Textual Pascal/C syntax}} & \mathbf{\text{Complex mathematics, array sorting, string parsing}} \\
     \text{Sequential Function (SFC)} & Graphical State Machine & Multi-step batch processing and state transitions \\
     \hline
     \end{array}$$
   - **The Image Table Invariant:** If a physical input sensor changes voltage midway through ladder logic execution, the PLC **will not see the change until the NEXT scan cycle's input read phase**, ensuring deterministic state consistency across all rungs!
2. **Slide 2 (`ordering`):** Provide 5 steps of the PLC cyclic scan: (1) read voltage states of all physical input field devices and copy into the Input Image Table memory, (2) begin ladder program execution from the first rung, evaluating from left rail to right rail, (3) execute rungs top-to-bottom, updating internal bit registers and the Output Image Table, (4) write the updated Output Image Table bit states to physical output terminal relays/solenoids, (5) perform background housekeeping, watchdog timer resets, and industrial network communications before repeating cycle!
3. **Slide 3 (`matching`):** Pair 4 concepts (XIC Instruction, XIO Instruction, OTE Instruction, Input Image Table) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 1 (or One). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on evaluating ladder logic rung continuity: A conveyor sorting station has:
   - Proximity sensor `Prox_1` connected to memory address `I:1/0` (Object present $\implies \text{Bit} = \mathbf{1}$);
   - Optical photoeye `PE_1` connected to memory address `I:1/1` (Beam unbroken/clear $\implies \text{Bit} = \mathbf{0}$);
   - The ladder rung is: `---| Prox_1 |-------|/| PE_1 |----------------( Diverter_Sol )---` (XIC `Prox_1` in series with XIO `PE_1` driving OTE `Diverter_Sol`).
   - When an object triggers `Prox_1` ($\text{Bit} = 1$) and `PE_1` is clear ($\text{Bit} = 0$):
     - XIC `Prox_1` examines for `1` $\implies$ **TRUE**;
     - XIO `PE_1` examines for `0` $\implies$ **TRUE**;
     - Series AND connection $\implies$ Rung is **TRUE** $\implies$ OTE `Diverter_Sol` is energized ($\text{Bit} = \mathbf{1}$);
   - What is the logical status of the rung and the state of `Diverter_Sol`? (Rung is **TRUE** and `Diverter_Sol` is **Energized (1)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "iec_61131_3_ladder_diagram_and_scan_cycle_mechanics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: PLC Scan Cycles \\& IEC 61131-3 (Frank D. Petruzella)**\n• **Cyclic PLC Scan Cycle Master Formulation:**\n$$\n\\mathbf{T_{\\text{scan}} = T_{\\text{input\\_scan}} + T_{\\text{program\\_exec}} + T_{\\text{output\\_write}} + T_{\\text{housekeeping}} \\approx 1 - 10\\text{ ms}}\n$$\n• **Fundamental Bit-Level Contact \\& Coil Instructions:**\n  - **XIC (Examine If Closed, `] [`):** Evaluates to TRUE when referenced bit memory is **1 (High/Energized)**;\n  - **XIO (Examine If Open, `]/[`):** Evaluates to TRUE when referenced bit memory is **0 (Low/De-energized)**;\n  - **OTE (Output Energize, `( )`):** Sets referenced bit to 1 when rung is TRUE, resets to 0 when FALSE;\n• **IEC 61131-3 Programming Languages Suite:**\n  - **Ladder Diagram (LD):** Relay contact logic for discrete machine sequencing;\n  - **Structured Text (ST):** High-level textual Pascal/C code for complex mathematics and array algorithms;\n  - **Function Block (FBD) \\& Sequential Function Chart (SFC):** PID control and batch state machines;\n• **The Image Table Invariant:** The processor executes logic exclusively against **internal memory image tables**, isolating ladder execution from physical electrical noise during the scan cycle!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by a Programmable Logic Controller (PLC) during every single cyclic scan cycle.",
      "orderItems": [
        "Sample all physical input terminals and copy their digital voltage states into the Input Image Table memory",
        "Begin ladder logic evaluation starting at Rung 0, solving from left power rail to right power rail",
        "Execute rungs sequentially top-to-bottom, updating internal registers and the Output Image Table buffer",
        "Transfer updated Output Image Table bit states to physical output terminal modules to drive field actuators",
        "Perform background housekeeping routines, system diagnostics, watchdog resets, and industrial network communications"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each PLC Control Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "XIC Instruction (] [)", "right": "Examine If Closed instruction conducting power flow when referenced memory address bit is 1" },
        { "left": "XIO Instruction (]/[)", "right": "Examine If Open instruction conducting power flow when referenced memory address bit is 0" },
        { "left": "OTE Coil (( ))", "right": "Output Energize instruction setting target bit to 1 if rung continuity is true, and 0 if false" },
        { "left": "Input Image Table", "right": "Dedicated internal RAM area holding a snapshot of physical field sensor states updated once per scan" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In PLC ladder logic programming, the Examine If Closed (XIC) instruction symbolized by `] [` evaluates as logically TRUE when the referenced memory address holds a binary value of ___.",
      "blankAnswer": "1",
      "blankDistractors": ["0", "null", "undefined"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A conveyor station has proximity sensor Prox_1 (Bit = 1) and optical sensor PE_1 (Bit = 0). The ladder rung is: ---| Prox_1 |---|/| PE_1 |---( Diverter_Sol )---. XIC Prox_1 evaluates for 1 (True) and XIO PE_1 evaluates for 0 (True). Both contacts in series are True. What is the logical status of the rung and the state of Diverter_Sol?",
      "options": [
        { "text": "The rung is TRUE and Diverter_Sol is ENERGIZED (Bit = 1) (XIC Prox_1 is True because bit=1, and XIO PE_1 is True because bit=0; series continuity is complete)", "isCorrect": true, "explanation": "Correct! Let's evaluate the ladder logic rung systematically across the PLC scan cycle (Frank D. Petruzella *Programmable Logic Controllers* Chapter 5). 1. **Analyze Contact Instructions:** - Proximity Sensor `Prox_1` address contains `1`. - Instruction is **XIC (`] [`)**: \"Examine If Closed (is bit = 1?)\" $\\implies$ **TRUE** (conducts power). - Optical Photoeye `PE_1` address contains `0`. - Instruction is **XIO (`]/[`)**: \"Examine If Open (is bit = 0?)\" $\\implies$ **TRUE** (conducts power). 2. **Evaluate Series Rung Continuity:** - Both instructions in series evaluate to TRUE: $$\\text{Rung State} = \\text{XIC}(\\text{Prox\\_1}) \\land \\text{XIO}(\\text{PE\\_1}) = 1 \\land 1 = \\mathbf{1 \\ (\\text{TRUE})}$$ 3. **Determine Output Coil Action:** - The Output Energize instruction **OTE (`( )`)** receives power flow: $$\\text{Diverter\\_Sol} = \\mathbf{1 \\ (\\text{Energized})}$$ - The physical solenoid valve actuates, diverting the package down the branch lane! Flawless PLC ladder logic scan cycle evaluation!" },
        { "text": "The rung is FALSE and Diverter_Sol is DE-ENERGIZED (Assumed XIO PE_1 was false because bit=0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The rung is in an undefined floating state", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Diverter_Sol pulses on for 1 scan then turns off permanently", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
