# Duofy Reusable Lesson Format: FPGA CAD Toolchain (Tech Mapping, P&R, & Timing Closure)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / FPGA_Architecture`  
**Lesson Format Type:** `fpga_cad_flow_technology_mapping_and_timing_closure`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the automated CAD toolchain pipeline that transforms high-level HDL into programming bitstreams for physical FPGAs: 1. Logic Synthesis, 2. Technology Mapping (FlowMap algorithm for depth-optimal $K$-LUT Directed Acyclic Graph covering), 3. Logic Packing/Clustering, 4. Placement (Simulated Annealing in VPR / Versatile Place and Route), 5. Routing (PathFinder negotiated congestion), 6. Static Timing Analysis ($\text{STA}$, Setup Slack $T_{\text{slack,setup}} = T_{\text{req}} - T_{\text{arr}} \ge 0$), and 7. Bitstream Generation (Vaughn Betz, Jonathan Rose *Architecture and CAD for Deep-Submicron FPGAs*; Jason Cong, Yuzheng Ding *FlowMap: An Optimal Technology Mapping Algorithm for Delay Optimization in Lookup-Table Based FPGA Designs* IEEE TCAD; Stephen Brown *Fundamentals of Digital Logic with Verilog* Chapter 10): master the **Six-Stage FPGA CAD Toolchain Pipeline**:
$$\mathbf{\text{Verilog / VHDL} \xrightarrow{\text{1. Synthesis}} \text{Gate DAG} \xrightarrow{\text{2. Tech Mapping}} \text{K-LUT Graph} \xrightarrow{\text{3. Packing}} \text{CLB Clusters} \xrightarrow{\text{4. Placement}} \text{Physical Coordinates} \xrightarrow{\text{5. Routing}} \text{Wires} \xrightarrow{\text{6. Bitstream}} \text{.bit File}}}$$
derive the **Static Timing Analysis (STA) Setup & Hold Timing Closure Equations**:
$$\mathbf{T_{\text{arr,setup}} = T_{\text{clk1}} + t_{\text{cq}} + t_{\text{comb,max}} \quad \Big| \quad \mathbf{T_{\text{req,setup}} = T_{\text{clk}} + T_{\text{clk2}} - t_{\text{su}} - t_{\text{jitter}}}}$$
$$\mathbf{T_{\text{slack,setup}} = T_{\text{req,setup}} - T_{\text{arr,setup}} \ge 0 \quad (\text{Timing Met if Slack } \ge 0)}$$
$$\mathbf{T_{\text{slack,hold}} = (t_{\text{cq}} + t_{\text{comb,min}} + T_{\text{clk1}}) - (T_{\text{clk2}} + t_{\text{hold}}) \ge 0}$$
(analyzing why negative setup slack $-\Delta$ can be fixed by lowering clock frequency $f_{\text{clk}}$ or inserting pipeline registers, whereas negative hold slack causes catastrophic fatal clock race failure independent of clock speed); and interact with live Fracturable 6-LUT simulator, PathFinder routing congestion visualizer, BRAM / DSP48E line buffer calculator, and FPGA CAD Timing Closure analyzer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CAD Flow (Synthesis $\to$ Map $\to$ Pack $\to$ Place $\to$ Route $\to$ Bitstream), FlowMap & STA Slack Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Achieve Timing Closure in an FPGA Synthesis Toolchain Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | FPGA CAD Stage / Timing Metric & Technical Transformation Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Static Timing Analysis, Timing Closure Is Successfully Met as Long as the Worst-Case Setup Slack Is Greater Than or Equal to ___ (Zero / 0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive FPGA Architecture & CAD Toolchain Studio: Fracturable 6-LUT, PathFinder, BRAM/DSP & Timing Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fpga_cad_flow_technology_mapping_and_timing_closure",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the 6 stages of the FPGA CAD compilation flow, and what is Static Timing Analysis (STA) Slack?",
      "blankAnswer": "FPGA CAD Flow & Timing Closure (Betz & Rose): (1) 6-STAGE CAD PIPELINE: HDL \u2192 Synthesis (gates) \u2192 Technology Mapping (FlowMap K-LUTs) \u2192 Packing (CLB clusters) \u2192 Placement (Simulated Annealing VPR) \u2192 Routing (PathFinder) \u2192 Bitstream Generation (.bit). (2) STATIC TIMING ANALYSIS (STA): Setup Slack = T_req - T_arr = (T_clk - t_su) - (t_cq + t_comb). Timing closure is met when Slack >= 0. Negative setup slack requires pipelining or lowering f_clk. (3) HOLD TIME: Hold Slack = (t_cq + t_comb,min) - t_hold >= 0; negative hold slack causes unrecoverable chip failure regardless of clock speed!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential stages of the complete FPGA CAD Compilation and Timing Closure toolchain.",
      "orderItems": [
        "Synthesize high-level Verilog/VHDL RTL code into a technology-independent Boolean gate netlist",
        "Perform Technology Mapping (e.g. FlowMap) to partition the gate DAG into depth-optimal K-LUT subgraphs",
        "Pack interconnected LUTs and flip-flops into localized physical Configurable Logic Block (CLB) clusters",
        "Execute Simulated Annealing Placement (e.g. VPR) to assign CLB clusters to physical grid coordinates (X, Y)",
        "Run the PathFinder Routing router to resolve congestion and verify that worst-case Setup Slack >= 0 before generating the .bit bitstream"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each FPGA CAD Compilation Stage to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Technology Mapping (FlowMap)", "right": "Converts generic Boolean logic gates into K-LUT truth tables while minimizing critical path logic depth" },
        { "left": "Placement (Simulated Annealing)", "right": "Assigns logic clusters to physical die coordinates to minimize total bounding-box wirelength" },
        { "left": "Routing (PathFinder)", "right": "Selects specific wire segments and switch box settings to legally interconnect all physical nets" },
        { "left": "Setup Slack (T_req - T_arr)", "right": "Safety margin between required arrival time and data path delay; must be >= 0 for correct clocking" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In static timing analysis, timing closure is successfully achieved as long as the worst-case setup slack is greater than or equal to ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "negative"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive FPGA Architecture & CAD Toolchain Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>FPGA Architecture & CAD Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">6-LUTs, PathFinder Routing, Hardened BRAM/DSP & STA</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnLut\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Fracturable 6-LUT (2x 5-LUTs)</button><button id=\"btnRout\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. PathFinder Routing & BRAM/DSP</button><button id=\"btnCad\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. CAD Flow & Timing Closure (Slack\u22650)</button></div><div id=\"fpgaLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate FPGA logic fabric...</div><script>document.getElementById('btnLut').onclick=()=>{document.getElementById('fpgaLog').innerHTML='<b>1. FPGA LOGIC FABRIC:</b><br>• 6-LUT Truth Table: 2^6 = 64 SRAM bits!<br>• Fracturing: <b style=\"color:#10b981;\">1x 6-LUT &harr; 2x 5-LUTs (Doubles logic density)!</b><br>• SLICEM: LUT Distributed RAM & SRL32 shift registers!';}; document.getElementById('btnRout').onclick=()=>{document.getElementById('fpgaLog').innerHTML='<b>2. INTERCONNECT \\& HARDENED SILICON:</b><br>• PathFinder Cost: c_n = (b_n + h_n)*p_n (Negotiated congestion)<br>• BRAM 36Kb: <b style=\"color:#38bdf8;\">2K x 18 mode fits 1920-pixel video lines!</b><br>• DSP48E: 25x18 mult + 48-bit accumulator (>750 MHz)!';}; document.getElementById('btnCad').onclick=()=>{document.getElementById('fpgaLog').innerHTML='<b>3. CAD FLOW \\& TIMING CLOSURE:</b><br>• Flow: Synthesis &rarr; Tech Map &rarr; Pack &rarr; Place &rarr; Route &rarr; Bitstream<br>• STA: <b style=\"color:#10b981;\">Setup Slack = T_req - T_arr \\u2265 0 (Timing Met)!</b><br>🏆 <b style=\"color:#10b981;\">02_Electrical_and_Electronics_Engineering (ALL 8 SUBDISCIPLINES) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
