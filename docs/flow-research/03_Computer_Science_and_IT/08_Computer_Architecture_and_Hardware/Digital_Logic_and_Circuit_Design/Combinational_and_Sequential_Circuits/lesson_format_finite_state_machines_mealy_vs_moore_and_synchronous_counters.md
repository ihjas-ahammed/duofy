# Duofy Reusable Lesson Format: Finite State Machines (Mealy vs Moore and Synchronous Counters)

**Target Topic:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Digital_Logic_and_Circuit_Design / Combinational_and_Sequential_Circuits`  
**Lesson Format Type:** `finite_state_machines_mealy_vs_moore_and_synchronous_counters`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify sequential state machine synthesis, sequence detection automata, and synchronous register architectures in digital system design (M. Morris Mano & Michael D. Ciletti *Digital Design* 6th ed. Chapter 5; David Money Harris & Sarah L. Harris *Digital Design and Computer Architecture* 2nd ed. Chapter 3): rigorously contrast **Mealy Finite State Machines ($\mathbf{Y = \lambda(S, X)}$)** (output is a function of both **Present State AND Present Inputs**; responds within the same clock cycle, uses fewer total states, but is susceptible to combinational input glitches) with **Moore Finite State Machines ($\mathbf{Y = \lambda(S)}$)** (output is a function of **Present State ONLY**; produces synchronous, glitch-free outputs aligned with clock transitions at the cost of a 1-cycle output latency), master **FSM Synthesis Pipelines** (State Diagram $\to$ State Table $\to$ State Encoding [Binary vs One-Hot vs Gray] $\to$ Flip-Flop Excitation Maps $\to$ Next-State Logic), master **Synchronous Up/Down Binary Counters & Ring/Johnson Counters**, and interact with live Carry Lookahead adder visualizer, MUX Boolean synthesizer, and FSM Sequence Detector widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mealy vs Moore FSM Block Diagram Comparison, One-Hot vs Binary State Encoding Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Synthesis of a Synchronous Sequence Detector ('101') FSM Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sequential FSM / Counter Construct & Exact Technical Architecture Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Finite State Machine Whose Outputs Depend Exclusively on the Present State Is a ___ Machine (Moore) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Sequential Logic Studio: CLA Adder, MUX Synthesizer & Mealy/Moore FSM Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "finite_state_machines_mealy_vs_moore_and_synchronous_counters",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the architectural difference between a Mealy and a Moore FSM, and what is One-Hot state encoding?",
      "blankAnswer": "FSM Architectures & Counters (Mano & Ciletti 2017): (1) MEALY MACHINE: Output Y = f(State S, Input X). Outputs depend on both present state AND current input. Reacts immediately in the same clock cycle; often requires fewer states; but outputs can glitch if input is noisy. (2) MOORE MACHINE: Output Y = f(State S). Outputs depend SOLELY on present state. Glitch-free, clean synchronous outputs; but output changes 1 clock cycle later. (3) ONE-HOT ENCODING: Uses 1 flip-flop per state (e.g. 4 states -> 0001, 0010, 0100, 1000). Highly favored in FPGAs because it requires ZERO next-state decoding logic, maximizing clock speed! (4) SYNCHRONOUS COUNTER: All flip-flops are clocked simultaneously by a single master clock, eliminating the ripple delay of asynchronous counters."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to synthesize a hardware Finite State Machine (FSM) detecting the sequence '101'.",
      "orderItems": [
        "Construct the formal State Transition Diagram showing states (S0: Init, S1: Got 1, S2: Got 10) and input transitions",
        "Derive the State Transition Table mapping Current State and Input X to Next State and Output Z",
        "Perform State Assignment (assigning binary codes or One-Hot vectors to states S0, S1, S2)",
        "Derive simplified Next-State Boolean equations for D Flip-Flops (D1, D0) using K-Maps",
        "Connect the combinational next-state gates to the flip-flop inputs and verify glitch-free sequence detection"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Sequential Machine Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Moore Machine", "right": "FSM where output is determined exclusively by current state, guaranteeing glitch-free outputs" },
        { "left": "Mealy Machine", "right": "FSM where output is determined by both current state and present input for single-cycle response" },
        { "left": "One-Hot State Encoding", "right": "State representation dedicating one flip-flop per state to eliminate next-state decoding gates in FPGAs" },
        { "left": "Johnson Counter", "right": "Modified ring counter with inverted feedback producing 2N distinct timing states from N flip-flops" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Finite State Machine whose output is determined strictly and solely by the current state is a ___ machine.",
      "blankAnswer": "Moore",
      "blankDistractors": ["Mealy", "Turing", "Shannon"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Sequential Logic Studio: CLA, MUX & FSM",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Combinational & Sequential Logic Studio</h3><p>Circuit: <b style=\"color:#38bdf8;\">Carry Lookahead Adder & '101' Sequence Detector FSM</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnCla\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Run 4-Bit CLA Adder</button><button id=\"btnMux\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. 4-to-1 MUX Selector</button><button id=\"btnFsm\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Clock '101' FSM Detector</button></div><div id=\"circLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to execute parallel Carry Lookahead addition...</div><script>document.getElementById('btnCla').onclick=()=>{document.getElementById('circLog').innerHTML='<b>1. CARRY LOOKAHEAD ADDER (4-Bit):</b><br>• G = A & B, P = A ^ B computed in 1 gate delay<br>• Carries C1, C2, C3, C4 generated simultaneously in 2 delays!<br>• Sum S = P ^ C produced &rarr; <b style=\"color:#10b981;\">Total Delay: 4 gate levels (O(1) speed!)</b>';}; document.getElementById('btnMux').onclick=()=>{document.getElementById('circLog').innerHTML='<b>2. 4-TO-1 MULTIPLEXER ROUTING:</b><br>• Select Lines: S1=1, S0=0 (Binary 2)<br>• Routed input I2 straight to output Y<br>• Synthesized Boolean function with 0 extra discrete gates!';}; document.getElementById('btnFsm').onclick=()=>{document.getElementById('circLog').innerHTML='<b>3. MOORE FSM SEQUENCE DETECTOR:</b><br>• Input bit stream clocked: 1 &rarr; 0 &rarr; 1<br>• State Transitions: S0 (Init) &rarr; S1 (Got 1) &rarr; S2 (Got 10) &rarr; S3 (Got 101)<br>• State S3 Output Z = 1 &rarr; <b style=\"color:#10b981;\">PATTERN 101 DETECTED!</b><br>🏆 <b style=\"color:#10b981;\">Glitch-free synchronous state transition complete!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
