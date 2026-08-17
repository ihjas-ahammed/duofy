# Duofy Reusable Lesson Format: Industrial Circuits (Motor Seal-In & Electrical Interlocks)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Automation_and_PLC_Programming / PLC_Ladder_Logic_and_SCADA`  
**Lesson Format Type:** `motor_start_stop_seal_in_and_interlock_circuits`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the industrial safety and operational design of 3-phase AC induction motor starter circuits in PLC ladder logic, the **Three-Wire Start/Stop Control Circuit**, the **Seal-In / Holding Contact Parallel Branch** (`Motor_Run` sealing across momentary `Start_PB`), hardware fail-safe wiring conventions (physical Normally Closed `Stop_PB` and `E-Stop` buttons wired with XIC instructions in ladder logic), thermal overload protection (`OL`), and bidirectional forward/reverse motor starter **Electrical and Software Interlocking Rungs** preventing disastrous line-to-line three-phase short circuits (Frank D. Petruzella *Programmable Logic Controllers* 5th ed. Chapters 6 & 7; Hugh Jack *Automating Manufacturing Systems with PLCs*): formulate the **Fail-Safe Motor Starter Seal-In Boolean Master Formulation**:
$$\mathbf{\text{Motor\_Run} = \left( \text{Start\_PB} \lor \text{Motor\_Run} \right) \land \text{Stop\_PB} \land \text{E\_Stop} \land \overline{\text{Overload\_Fault}}}$$
where for physical hardware buttons wired fail-safe:
1. **`Start_PB` (Physical NO Button):** Bit = `0` at rest, transitions to `1` when operator presses button;
2. **`Stop_PB` (Physical NC Button):** Bit = `1` at rest (conducts $24\text{ VDC}$), transitions to `0` when pressed;
3. **`E_Stop` (Physical NC Mushroom Button):** Bit = `1` healthy, transitions to `0` when tripped;
4. **`Motor_Run` (Parallel Seal-In Contact):** Maintains rung power after momentary `Start_PB` is released;
master the **Forward / Reverse Interlocked Motor Starter Rung Architecture**:
$$\mathbf{\text{Forward\_Contactor} = \left( \text{Fwd\_Start} \lor \text{Forward\_Contactor} \right) \land \text{Stop\_PB} \land \mathbf{\text{XIO}(\text{Reverse\_Contactor})}}$$
$$\mathbf{\text{Reverse\_Contactor} = \left( \text{Rev\_Start} \lor \text{Reverse\_Contactor} \right) \land \text{Stop\_PB} \land \mathbf{\text{XIO}(\text{Forward\_Contactor})}}$$
(proving that the XIO interlock contact immediately cuts power to the opposing contactor coil, physically and logically preventing both contactors from pulling in simultaneously).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Motor Start/Stop Seal-In Circuit, Fail-Safe NC Wiring & Forward/Reverse Interlocks Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution of a Motor Start/Stop Cycle with Seal-In Latching and E-Stop Trip Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Motor Starter Circuit Construct / Safety Component & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In PLC Ladder Logic, a Contact Placed in Parallel with the Momentary Start Pushbutton to Maintain Current Flow After the Button Is Released Is Known as a ___-In Contact (Seal / Seal-In / Holding) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Control Problem: Tracing Rung Continuity During Momentary Start Press, Release, and Stop Press Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Motor Starter Seal-In & Interlock Mechanics (Petruzella 2017; Jack 2008):
   - **Ladder Circuit Formulations:**
     $$\mathbf{\text{MTR} = (\text{Start} \lor \text{MTR}) \land \text{Stop} \land \text{E-Stop} \quad \Big| \quad \text{Fwd} = (\text{Start\_Fwd} \lor \text{Fwd}) \land \overline{\text{Rev}}}$$
   - **The Fail-Safe NC Wiring Invariant:**
     - Physical Stop and E-Stop pushbuttons are wired **Normally Closed (NC)**;
     - Under healthy operation, $24\text{ VDC}$ reaches the PLC input $\implies$ Input Bit $= \mathbf{1}$;
     - In ladder logic, programmed as **XIC (`] [`)**; if a field wire breaks, input drops to `0`, the XIC contact opens, and the motor immediately shuts down safely!
2. **Slide 2 (`ordering`):** Provide 5 steps of motor start/stop operation: (1) verify healthy physical safety circuit where NC E-Stop and Stop buttons deliver 24VDC (bit = 1), (2) operator presses momentary Start pushbutton closing NO contact (bit = 1), (3) PLC solves rung to TRUE, energizing motor starter coil `Motor_M1` (bit = 1), (4) operator releases Start pushbutton (bit = 0), but parallel seal-in contact `] Motor_M1 [` maintains rung power, (5) operator presses physical NC Stop pushbutton dropping voltage to 0V (bit = 0), opening XIC Stop contact and breaking the seal-in loop!
3. **Slide 3 (`matching`):** Pair 4 concepts (Seal-In Holding Contact, Hardware NC Stop Button, Software Interlock XIO, Thermal Overload OL) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Seal (or Seal-In / Holding). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on motor starter circuit behavior: A motor starter rung consists of:
   - Momentary Start button (physical NO wired to `I:1/0`);
   - Stop button (physical NC wired to `I:1/1`, at rest $\text{Bit} = \mathbf{1}$);
   - Parallel seal-in contact `] O:2/0 [` across Start;
   - Output coil `O:2/0` (`Motor_Contactor`).
   - The motor is currently running ($\text{O:2/0} = 1$) with the Start button released ($\text{I:1/0} = 0$). An operator presses the physical Stop button ($\text{I:1/1}$ drops from $1 \to 0$). What happens to the ladder rung and motor contactor across the next PLC scan?
     - When Stop button is pressed, $\text{I:1/1}$ becomes `0`;
     - In the ladder rung, XIC `Stop_PB` (`I:1/1`) examines for `1`, which is now **FALSE**;
     - The series circuit breaks, forcing the rung to **FALSE**;
     - Output coil `O:2/0` is written to `0` (de-energized), extinguishing the parallel seal-in branch;
   - What happens to the motor? (Rung becomes **FALSE**, `Motor_Contactor` **De-energizes (0)**, and the motor safely stops).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "motor_start_stop_seal_in_and_interlock_circuits",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Industrial Motor Starters \\& Seal-In Circuits (Frank D. Petruzella)**\n• **Fail-Safe Three-Wire Motor Starter Master Formulation:**\n$$\n\\mathbf{\\text{Motor\\_Run} = \\left( \\text{Start\\_PB} \\lor \\text{Motor\\_Run} \\right) \\land \\text{Stop\\_PB} \\land \\text{E\\_Stop} \\land \\overline{\\text{Overload\\_Fault}}}\n$$\n• **The Fail-Safe Physical Wiring Convention:**\n  - **Stop \\& E-Stop Pushbuttons:** Wired as physical **Normally Closed (NC)** hardware contacts delivering $24\\text{ VDC}$ (Input Bit = 1) under normal healthy operation;\n  - **Programmed as XIC (`] [`):** If a field wire snaps or cuts, the input drops to 0, opening the XIC contact and instantly halting the motor!\n• **Forward / Reverse Mutual Software Interlocking:**\n$$\n\\mathbf{\\text{Fwd\\_Coil} = (\\text{Start\\_F} \\lor \\text{Fwd\\_Coil}) \\land \\text{Stop} \\land \\mathbf{\\text{XIO}(\\text{Rev\\_Coil})}}\n$$\n• **The Seal-In Invariant:** The parallel contact `] Motor_Run [` maintains current flow after the momentary Start button springs back to 0, locking the motor in the running state until a stop event occurs!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of an industrial motor start, seal-in latch, and stop sequence in PLC ladder logic.",
      "orderItems": [
        "Confirm healthy safety state where physical NC Stop and E-Stop buttons deliver 24VDC to PLC inputs (Bit = 1)",
        "Operator depresses momentary Start button, setting input Bit = 1 and completing true logic path to output coil",
        "PLC energizes the motor contactor output coil (Bit = 1), closing physical 3-phase line contacts to spin motor",
        "Operator releases momentary Start button (Bit = 0), but parallel seal-in contact ] Motor [ sustains rung continuity",
        "Operator presses physical NC Stop button, setting input Bit = 0, opening XIC Stop contact and breaking the seal-in loop"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Motor Starter Circuit Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Seal-In Holding Contact", "right": "Parallel NO contact addressed to the output coil maintaining rung power after momentary start release" },
        { "left": "Fail-Safe NC Stop Wiring", "right": "Hardware NC contact holding input bit at 1 so wire severance immediately de-energizes the motor safely" },
        { "left": "Software Interlock (XIO)", "right": "Normally closed contact addressed to opposing coil preventing forward and reverse contactors energizing together" },
        { "left": "Thermal Overload (OL)", "right": "Bimetallic heater contact opening if motor draws excessive sustained current to prevent stator burnout" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In PLC ladder logic, a contact placed in parallel with the momentary start pushbutton to maintain current flow after the button is released is known as a ___-in contact.",
      "blankAnswer": "seal",
      "blankDistractors": ["lock", "time", "break"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A motor starter circuit has momentary Start_PB (I:1/0 = 0), NC Stop_PB (I:1/1 = 1), parallel seal-in contact ] O:2/0 [, and output coil O:2/0 (Motor). The motor is running (O:2/0 = 1). An operator pushes the physical NC Stop_PB (I:1/1 drops from 1 to 0). What happens across the next PLC scan?",
      "options": [
        { "text": "XIC Stop_PB becomes FALSE, breaking rung continuity and de-energizing Motor (O:2/0 = 0) (Input bit drops to 0, opening the XIC contact, resetting output O:2/0 to 0 and dropping the seal-in branch)", "isCorrect": true, "explanation": "Correct! Let's trace the motor starter de-energization sequence (Frank D. Petruzella *Programmable Logic Controllers* Chapter 6). 1. **Initial Running State:** - Start button is released: $\\text{I:1/0} = 0$. - Stop button is unpressed (healthy $24\\text{ VDC}$ NC closed): $\\text{I:1/1} = 1$. - Motor output coil is energized: $\\text{O:2/0} = 1$. - Parallel seal-in contact `] O:2/0 [` is TRUE, sustaining power flow. 2. **Operator Presses Stop Button:** - Pressing the physical Normally Closed (NC) pushbutton mechanically opens the circuit, dropping input voltage to $0\\text{ VDC}$. - Input Image Table updates: $\\text{I:1/1} \\to \\mathbf{0}$. 3. **Ladder Logic Evaluation:** - The rung contains XIC `Stop_PB` (`I:1/1`), which tests for `1`. - Since $\\text{I:1/1} = 0$, XIC `Stop_PB` evaluates to **FALSE**. - Series continuity across the rung is severed: $$\\text{Rung State} = (\\text{Start} \\lor \\text{Motor}) \\land \\text{Stop} = (0 \\lor 1) \\land 0 = 1 \\land 0 = \\mathbf{0 \\ (\\text{FALSE})}$$ 4. **Output Coil Action:** - OTE `O:2/0` is written to `0` (de-energized). - The parallel contact `] O:2/0 [` opens, ensuring the motor stays stopped even after the Stop button is released! Flawless motor start/stop seal-in logic derivation!" },
        { "text": "The motor remains running because the seal-in contact bypasses the Stop button (False; Stop button is in series with the entire branch)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The PLC enters a fault halt state", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The motor reverses direction", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
