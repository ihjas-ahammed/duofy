# Duofy Reusable Lesson Format: Pipelined Datapaths (Retiming, Throughput, & Latency)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / Digital_VLSI_and_Verilog_VHDL`  
**Lesson Format Type:** `pipelined_datapath_design_retiming_throughput_and_latency`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify high-performance digital VLSI datapath design, combinational critical path delay analysis, pipeline register insertion, register retiming, and the fundamental architectural tradeoffs between **Throughput** ($f_{\text{max}}$) and **Latency** ($N \times T_{\text{clk}}$) in hardware accelerators and microprocessor execution units (David A. Patterson & John L. Hennessy *Computer Organization and Design* Chapter 4; Neil Weste & David Harris *CMOS VLSI Design* Chapter 10; Jan M. Rabaey *Digital Integrated Circuits* Chapter 7): formulate the **Non-Pipelined vs Pipelined Timing Equations**:
1. **Non-Pipelined Single-Cycle Datapath:**
   $$\mathbf{T_{\text{clk,unpipe}} \ge t_{\text{comb,total}} + t_{\text{cq}} + t_{\text{su}} \implies \mathbf{f_{\text{max,unpipe}} = \frac{1}{T_{\text{clk,unpipe}}}} \quad \Big| \quad \mathbf{\text{Latency} = T_{\text{clk,unpipe}}}}$$
2. **$N$-Stage Pipelined Datapath (with balanced stages $t_{\text{stage}} = t_{\text{comb,total}} / N$):**
   $$\mathbf{T_{\text{clk,pipe}} \ge \max(t_{\text{stage},i}) + t_{\text{cq}} + t_{\text{su}} \implies \mathbf{f_{\text{max,pipe}} = \frac{1}{T_{\text{clk,pipe}}}} \quad \Big| \quad \mathbf{\text{Latency} = N \times T_{\text{clk,pipe}}}}$$
derive the **Throughput Metric**:
$$\mathbf{\text{Throughput} = \frac{\text{Results Produced}}{\text{Unit Time}} = \mathbf{f_{\text{max,pipe}} \approx N \times f_{\text{max,unpipe}} \ (\text{When } t_{\text{cq}}, t_{\text{su}} \ll t_{\text{stage}})}}$$
master the **Pipeline Hazards & Overhead Invariant**:
- Pipelining dramatically multiplies **throughput** ($N\times$ frequency boost), but slightly increases individual item **total latency** due to flip-flop clock-to-Q ($t_{\text{cq}}$) and setup time ($t_{\text{su}}$) overhead at each stage boundary;
- Inserting pipeline registers requires hazard detection (data forwarding, stall bubbles, and branch prediction) in control logic;
and interact with live Verilog non-blocking race visualizer, SystemVerilog latch detector, FSM two-process animator, and Pipelined datapath throughput optimizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Pipelining Theory ($T_{\text{clk}} \ge t_{\text{stage}} + t_{\text{cq}} + t_{\text{su}}$), Throughput ($f_{\text{clk}}$) vs Latency ($N \cdot T_{\text{clk}}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Pipelined Datapath Component / Performance Metric & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Inserting 4 Balanced Pipeline Stages Boosts Hardware Throughput ~4x While Increasing Latency Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Number of Useful Data Outputs Processed per Second by a Digital Hardware Accelerator Is Its ___ (Throughput / Bandwidth) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Digital VLSI & Verilog HDL Studio: Blocking Races, Latch Detection, FSM & Pipeline Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pipelined_datapath_design_retiming_throughput_and_latency",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Pipelining, and how does it balance Throughput and Latency in digital hardware?",
      "blankAnswer": "Pipelining & Datapath Retiming (Hennessy & Patterson): (1) PIPELINING: Inserting edge-triggered registers to divide a long combinational delay (t_comb) into N shorter stages. (2) CLOCK PERIOD: T_clk >= max(t_stage,i) + t_cq + t_su. (3) THROUGHPUT: Throughput = 1 / T_clk = f_max. Dividing into N balanced stages boosts throughput by ~Nx! (4) LATENCY: Total time for a single item to finish = N * T_clk. Total latency increases slightly due to register overhead (t_cq + t_su). (5) RETIMING: Moving registers across logic gates to equalize stage delays without changing functionality!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Pipelining Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Throughput (f_clk)", "right": "Number of completed data outputs produced per second: Throughput = 1 / T_clk" },
        { "left": "Latency (N * T_clk)", "right": "Total time elapsed from when a specific input enters stage 1 until its result emerges from stage N" },
        { "left": "Register Overhead", "right": "t_cq + t_su, fixed physical delay introduced at every pipeline stage boundary" },
        { "left": "Retiming", "right": "CAD optimization technique shifting registers across combinational logic to minimize critical path delay" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A non-pipelined floating-point multiplier has a combinational delay of 12.0 ns (t_cq = 0.5 ns, t_su = 0.5 ns \u2192 T_clk = 13.0 ns, f_max = 76.9 MHz, Latency = 13.0 ns). An engineer splits the logic into 4 perfectly balanced 3.0 ns pipeline stages. What are the new clock period, maximum clock frequency (throughput), and total latency?",
      "options": [
        { "text": "T_clk = 4.0 ns, f_max = 250.0 MHz, and Latency = 16.0 ns (T_clk = 3.0 ns + 0.5 ns + 0.5 ns = 4.0 ns; f_max = 1 / 4.0 ns = 250 MHz (3.25x throughput boost); Latency = 4 stages * 4.0 ns = 16.0 ns)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using pipelined datapath timing formulas (Patterson & Hennessy *Computer Organization and Design* Chapter 4). 1. **Non-Pipelined Baseline:** - Clock period: $$T_{\\text{clk,unpipe}} = t_{\\text{comb}} + t_{\\text{cq}} + t_{\\text{su}} = 12.0\\text{ ns} + 0.5\\text{ ns} + 0.5\\text{ ns} = \\mathbf{13.0\\text{ ns}}$$ - Throughput: $$f_{\\text{max}} = \\frac{1}{13.0\\text{ ns}} = \\mathbf{76.92\\text{ MHz}}$$ - Latency: $$1 \\times 13.0\\text{ ns} = \\mathbf{13.0\\text{ ns}}$$ 2. **4-Stage Pipelined Datapath:** - Combinational delay per stage: $$t_{\\text{stage}} = \\frac{12.0\\text{ ns}}{4} = 3.0\\text{ ns}$$ - New clock period: $$T_{\\text{clk,pipe}} = t_{\\text{stage}} + t_{\\text{cq}} + t_{\\text{su}} = 3.0\\text{ ns} + 0.5\\text{ ns} + 0.5\\text{ ns} = \\mathbf{4.0\\text{ ns}}$$ - New maximum clock frequency (Throughput): $$f_{\\text{max,pipe}} = \\frac{1}{4.0\\text{ ns}} = \\mathbf{250.0\\text{ MHz}}$$ - Speedup: $$\\frac{250.0\\text{ MHz}}{76.92\\text{ MHz}} = \\mathbf{3.25\\times\\text{ higher throughput!}}$$ 3. **Total Latency for One Calculation:** - Total time through 4 stages: $$\\text{Latency} = N \\times T_{\\text{clk,pipe}} = 4 \\times 4.0\\text{ ns} = \\mathbf{16.0\\text{ ns}}$$ 4. **Architectural Insight:** Notice how throughput increased from $76.9\\text{ M ops/sec}$ to $250\\text{ M ops/sec}$ ($+225\\%$), while individual latency increased modestly from $13\\text{ ns}$ to $16\\text{ ns}$ due to the flip-flop overhead! Flawless pipelining analysis!" },
        { "text": "T_clk = 3.0 ns, f_max = 333.3 MHz, and Latency = 12.0 ns (Forgot flip-flop overhead)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T_clk = 6.0 ns, f_max = 166.7 MHz, and Latency = 24.0 ns", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T_clk = 13.0 ns, f_max = 76.9 MHz, and Latency = 52.0 ns", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The number of useful data outputs processed per second by a pipelined digital hardware accelerator is its ___.",
      "blankAnswer": "throughput",
      "blankDistractors": ["latency", "propagation", "capacitance"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Digital VLSI & Verilog HDL Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Digital VLSI & Verilog HDL Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Blocking Races, Latch Avoidance, FSMs & Pipelining</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnAssign\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Non-Blocking (<=) vs Blocking (=)</button><button id=\"btnLatch\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. always_comb & Latch Prevention</button><button id=\"btnPipe\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Pipelining (fmax=250MHz)</button></div><div id=\"hdlLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Verilog assignment rules...</div><script>document.getElementById('btnAssign').onclick=()=>{document.getElementById('hdlLog').innerHTML='<b>1. CUMMINGS GOLDEN ASSIGNMENT RULES:</b><br>• Sequential Logic: <b style=\"color:#10b981;\">Non-blocking <= (NBA queue)!</b><br>• Combinational: Blocking =<br>• Never mix in same block to avoid simulation races!';}; document.getElementById('btnLatch').onclick=()=>{document.getElementById('hdlLog').innerHTML='<b>2. SYSTEMVERILOG LATCH PREVENTION:</b><br>• always_comb & always_ff explicit intent<br>• <b style=\"color:#38bdf8;\">Line-1 Default Assignment Pattern eliminates all latches!</b><br>• 2-Process FSM: always_ff state + always_comb decoder';}; document.getElementById('btnPipe').onclick=()=>{document.getElementById('hdlLog').innerHTML='<b>3. PIPELINED DATAPATH ARCHITECTURE:</b><br>• 4-Stage Multiplier: <b style=\"color:#10b981;\">f_max = 250 MHz (3.25x boost)!</b><br>• Latency: 16.0 ns (4 stages * 4.0 ns)<br>• Retiming balances delays across register boundaries<br>🏆 <b style=\"color:#10b981;\">Digital_VLSI_and_Verilog_VHDL 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
