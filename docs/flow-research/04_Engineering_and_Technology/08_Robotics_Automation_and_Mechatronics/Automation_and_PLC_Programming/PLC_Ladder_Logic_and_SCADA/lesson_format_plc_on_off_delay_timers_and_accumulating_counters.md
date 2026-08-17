# Duofy Reusable Lesson Format: Industrial Timing (TON, TOF Timers & CTU Counters)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Automation_and_PLC_Programming / PLC_Ladder_Logic_and_SCADA`  
**Lesson Format Type:** `plc_on_off_delay_timers_and_accumulating_counters`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through temporal control and discrete event counting in PLC ladder logic, **Timer On-Delay (TON)** (delayed turn-on), **Timer Off-Delay (TOF)** (delayed turn-off), **Retentive Timer (RTO)** with Reset instruction (`RES`), internal status bits (**Enable `EN`**, **Timer Timing `TT`**, **Done `DN`**), preset values (`PRE`), accumulated elapsed time (`ACC`), timebase scaling ($1.0\text{ s}, 0.1\text{ s}, 0.01\text{ s}$), and **Up-Counters (CTU)** / **Down-Counters (CTD)** for packaging, batching, and machine cycle tracking (Frank D. Petruzella *Programmable Logic Controllers* 5th ed. Chapters 7 & 8; Hugh Jack *Automating Manufacturing Systems with PLCs*): formulate the **TON (Timer On-Delay) Status Bit Logic Master Formulations**:
$$\mathbf{\text{EN} = 1 \iff \text{Rung-In is TRUE}}$$
$$\mathbf{\text{TT} = 1 \iff (\text{Rung-In is TRUE}) \land (\text{ACC} < \text{PRE})}$$
$$\mathbf{\text{DN} = 1 \iff (\text{Rung-In is TRUE}) \land (\text{ACC} \ge \text{PRE})}$$
where:
1. **`ACC` (Accumulator):** Current elapsed time increments every scan while rung is TRUE; resets to `0` when rung goes FALSE (non-retentive TON);
2. **`PRE` (Preset):** Target duration in timebase units (e.g. $\text{PRE} = 50$ with timebase $0.1\text{ s} \implies \mathbf{5.0\text{ seconds}}$);
3. **`DN` (Done Bit):** Transitions to `1` when $\text{ACC} \ge \text{PRE}$, turning on downstream actuators;
master the **Timer Instruction Comparison Matrix**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{Timer Instruction} & \textbf{When Rung Goes TRUE} & \textbf{When Rung Goes FALSE} & \textbf{Primary Industrial Application} \\
\hline
\mathbf{\text{TON (On-Delay)}} & \text{Begins accumulating; DN=1 when ACC}\ge\text{PRE} & \mathbf{\text{Resets ACC=0, DN=0 instantly}} & \mathbf{\text{Lube pump pressure delay, motor stagger start}} \\
\mathbf{\text{TOF (Off-Delay)}} & \mathbf{\text{DN=1 immediately; ACC=0}} & \mathbf{\text{Begins timing; DN stays 1 until ACC}\ge\text{PRE}} & \mathbf{\text{Cooling fan rundown, exhaust purge after shutdown}} \\
\mathbf{\text{RTO (Retentive)}} & \text{Accumulates; DN=1 when ACC}\ge\text{PRE} & \mathbf{\text{Freezes ACC at current value; retains state}} & \mathbf{\text{Total machine operating runtime, maintenance hour meter}} \\
\mathbf{\text{CTU (Up-Counter)}} & \mathbf{\text{Increments ACC on 0}\to\text{1 false-to-true edge}} & \text{Retains ACC value; requires RES instruction} & \mathbf{\text{Bottling conveyor pack count (e.g. 24 cans/case)}} \\
\hline
\end{array}$$
(proving that choosing between TON and TOF determines whether the programmed delay occurs at system start-up or during system shutdown).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TON On-Delay (`EN`, `TT`, `DN`), TOF Off-Delay & CTU Up-Counters Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Program a 5-Second Pre-Lube Pump Delay Before Motor Start Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | PLC Timing/Counting Entity / Bit Register & Technical Automation Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a PLC Timer On-Delay (TON) Instruction, the Timer Timing Bit ___ Evaluates as TRUE (1) Only While the Rung Is True and the Accumulator ACC Is Actively Incrementing Toward the Preset PRE (TT / Timer Timing) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Control Problem: Calculating Elapsed Time and Status Bit States for a TON Timer Rung Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State PLC Timers & Counters Mechanics (Petruzella 2017; Jack 2008):
   - **Timing Bit Formulations:**
     $$\mathbf{\text{EN} = \text{RungIn} \quad \Big| \quad \text{TT} = \text{RungIn} \land (\text{ACC} < \text{PRE}) \quad \Big| \quad \text{DN} = \text{RungIn} \land (\text{ACC} \ge \text{PRE}) \quad \Big| \quad t_{\text{elapsed}} = \text{ACC} \times \text{Timebase}}$$
   - **The Non-Retentive vs Retentive Invariant:**
     - In standard **TON/TOF**, if the rung goes false for even a single scan, `ACC` resets to `0`;
     - In **RTO (Retentive)**, `ACC` freezes and preserves elapsed time during power loss or rung false, requiring an explicit `RES` (Reset) instruction to clear!
2. **Slide 2 (`ordering`):** Provide 5 steps of timer implementation: (1) create TON timer instruction with tag `T4:0`, setting timebase to $0.1\text{ s}$ and preset `PRE = 50` ($5.0\text{ seconds}$), (2) place start condition (e.g. `Lube_Pressure_OK`) on the timer rung to energize Enable bit `EN`, (3) monitor Timer Timing bit `T4:0.TT` to flash an illuminated "Pre-Lube Warming" indicator on the operator HMI, (4) when accumulator reaches `ACC = 50`, Done bit `T4:0.DN` sets to `1`, (5) use an XIC contact addressed to `T4:0.DN` on the next rung to energize the main spindle drive motor starter coil!
3. **Slide 3 (`matching`):** Pair 4 concepts (Timer Preset PRE, Timer Accumulator ACC, Done Bit DN, Timer Timing Bit TT) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of TT (or Timer Timing). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on TON timer states: A lubrication pump system uses a TON instruction with Timebase $= 1.0\text{ s}$ and Preset $\text{PRE} = 10\text{ s}$. The start rung becomes true and remains true continuously for $6.0\text{ seconds}$ ($\text{ACC} = 6$).
   - At $t = 6\text{ s}$:
     - Is the rung true? Yes $\implies \text{EN} = \mathbf{1}$;
     - Is $\text{ACC} < \text{PRE}$ ($6 < 10$)? Yes $\implies \text{TT} = \mathbf{1}$;
     - Is $\text{ACC} \ge \text{PRE}$ ($6 \ge 10$)? No $\implies \text{DN} = \mathbf{0}$;
   - What are the states of the Enable (`EN`), Timer Timing (`TT`), and Done (`DN`) bits at $t = 6\text{ s}$? ($\text{EN} = \mathbf{1}, \text{TT} = \mathbf{1}, \text{DN} = \mathbf{0}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "plc_on_off_delay_timers_and_accumulating_counters",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: PLC Timers \\& Accumulating Counters (Frank D. Petruzella)**\n• **Timer On-Delay (TON) Status Bit Master Formulations:**\n$$\n\\mathbf{\\text{EN} = \\text{RungIn} \\quad \\Big| \\quad \\text{TT} = \\text{RungIn} \\land (\\text{ACC} < \\text{PRE}) \\quad \\Big| \\quad \\text{DN} = \\text{RungIn} \\land (\\text{ACC} \\ge \\text{PRE})}\n$$\n  - **`PRE` (Preset):** Target time limit (e.g. $\\text{PRE} = 100$ with timebase $0.1\\text{ s} \\implies 10.0\\text{ seconds}$);\n  - **`ACC` (Accumulator):** Current elapsed time count;\n  - **`EN` (Enable Bit):** Set to 1 whenever rung power flow is TRUE;\n  - **`TT` (Timer Timing Bit):** Set to 1 only while timer is actively timing ($\\text{ACC} < \\text{PRE}$);\n  - **`DN` (Done Bit):** Set to 1 when $\\text{ACC} \\ge \\text{PRE}$, turning on downstream logic;\n• **Timer Architectural Distinctions:**\n  - **TON (On-Delay):** Delays output turn-on until input condition persists continuously for `PRE` seconds;\n  - **TOF (Off-Delay):** Turns output ON immediately, but delays output shutoff for `PRE` seconds after input goes false;\n  - **RTO (Retentive):** Holds accumulated time across rung dropouts; requires explicit `RES` instruction to reset;\n• **The Non-Retentive Reset Invariant:** In a standard TON timer, if the input rung goes false for even a single $2\\text{ ms}$ scan, the **accumulator instantly resets to $\\text{ACC} = 0$**, enforcing complete temporal continuity!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to program a 5-second pre-lube delay before starting a heavy industrial motor spindle.",
      "orderItems": [
        "Insert a TON instruction named T4:0, setting Timebase to 0.1 s and Preset PRE to 50 (5.0 seconds)",
        "Place the Lube_Pump_Run contact on the timer rung so the timer begins timing when lubrication starts",
        "Use the Timer Timing contact ] T4:0.TT [ on a parallel rung to illuminate a flashing 'Pre-Lube Active' pilot light",
        "Allow the timer accumulator ACC to increment from 0 to 50 as 5.0 seconds elapse",
        "Place an XIC contact addressed to ] T4:0.DN [ in series with the main Spindle_Motor coil to start spindle rotation"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each PLC Timer/Counter Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Preset Value (PRE)", "right": "Target duration or count threshold that the accumulator must reach to energize the Done bit" },
        { "left": "Accumulator (ACC)", "right": "Internal register tracking current elapsed time ticks or input pulse counts since last reset" },
        { "left": "Timer Timing Bit (TT)", "right": "Status bit that is TRUE exclusively while the timer is actively counting and ACC < PRE" },
        { "left": "Done Bit (DN)", "right": "Status bit that turns TRUE when the accumulator reaches or exceeds the preset value (ACC \u2265 PRE)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a PLC Timer On-Delay (TON) instruction, the timer timing bit ___ evaluates as TRUE (1) only while the rung is true and the accumulator ACC is actively incrementing toward the preset PRE.",
      "blankAnswer": "TT",
      "blankDistractors": ["EN", "DN", "RES"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A TON timer instruction (Timebase = 1.0 s, PRE = 10 s) is energized when its rung becomes true, and the rung remains continuously true for 6.0 seconds (ACC = 6). What are the exact logical states of the Enable (EN), Timer Timing (TT), and Done (DN) status bits at t = 6.0 s?",
      "options": [
        { "text": "EN = 1, TT = 1, and DN = 0 (Rung is true \u2192 EN = 1; actively timing with ACC = 6 < 10 \u2192 TT = 1; not yet finished \u2192 DN = 0)", "isCorrect": true, "explanation": "Correct! Let's analyze the TON timer bit behavior systematically (Frank D. Petruzella *Programmable Logic Controllers* Chapter 7). 1. **Analyze Input Condition \\& Parameters:** - Timer Type: **TON (Timer On-Delay)**. - Preset: $\\text{PRE} = 10\\text{ seconds}$. - Current elapsed time: $\\text{ACC} = 6\\text{ seconds}$. - Rung power flow is currently: **TRUE**. 2. **Evaluate Enable Bit (`EN`):** - The `EN` bit mirrors rung continuity: $$\\text{EN} = \\text{RungIn} = \\mathbf{1 \\ (\\text{TRUE})}$$ 3. **Evaluate Timer Timing Bit (`TT`):** - The `TT` bit is TRUE when rung is true and $\\text{ACC} < \\text{PRE}$: $$\\text{TT} = \\text{RungIn} \\land (\\text{ACC} < \\text{PRE}) = 1 \\land (6 < 10) = 1 \\land 1 = \\mathbf{1 \\ (\\text{TRUE})}$$ 4. **Evaluate Done Bit (`DN`):** - The `DN` bit is TRUE only when $\\text{ACC} \\ge \\text{PRE}$: $$\\text{DN} = \\text{RungIn} \\land (\\text{ACC} \\ge \\text{PRE}) = 1 \\land (6 \\ge 10) = 1 \\land 0 = \\mathbf{0 \\ (\\text{FALSE})}$$ - At $t = 10\\text{ s}$, `TT` will drop to `0` and `DN` will flip to `1`! Flawless PLC timer status bit logic derivation!" },
        { "text": "EN = 1, TT = 0, and DN = 1 (Assumed the timer was already finished at 6s)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "EN = 0, TT = 0, and DN = 0 (Assumed timer de-energized)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "EN = 1, TT = 1, and DN = 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
