# Duofy Reusable Lesson Format: Supervisory Control (SCADA, HMI, & OPC-UA Protocols)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Automation_and_PLC_Programming / PLC_Ladder_Logic_and_SCADA`  
**Lesson Format Type:** `scada_hmi_architecture_and_opc_ua_industrial_networking`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify supervisory plant-wide industrial automation architecture, **Supervisory Control and Data Acquisition (SCADA)** systems, **Human-Machine Interfaces (HMI)**, the **OPC Unified Architecture (OPC-UA)** communication standard (IEC 62541), client-server information models, industrial fieldbus protocols (**Modbus TCP/IP**, **EtherNet/IP**, **PROFINET**), tag databases (`Tank1_Level_PV`, `Pump_Speed_SP`), real-time alarm management (ISA 18.2 priority bands: Critical, High, Medium, Low), historical data logging / trending, and Purdue Enterprise Reference Architecture (PERA / ISA-95 levels 0 to 4) (Frank D. Petruzella *Programmable Logic Controllers* 5th ed. Chapter 14; OPC Foundation IEC 62541 Standard; ISA-18.2 Alarm Management Standard; Stuart A. Boyer *SCADA: Supervisory Control and Data Acquisition* 4th ed.): formulate the **Purdue Model (ISA-95) Industrial Automation Hierarchy**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{ISA-95 Level} & \textbf{System Layer} & \textbf{Hardware / Software Entity} & \textbf{Primary Operational Function} \\
\hline
\mathbf{\text{Level 4}} & \mathbf{\text{Enterprise Network}} & \text{ERP (SAP / Oracle), Business Logistics} & \text{Supply chain, plant orders, financial tracking} \\
\mathbf{\text{Level 3}} & \mathbf{\text{Operations (MES)}} & \text{Manufacturing Execution Systems, Historians} & \text{Batch scheduling, production tracking, OEE} \\
\mathbf{\text{Level 2}} & \mathbf{\text{Supervisory Control}} & \mathbf{\text{SCADA Servers, Central Control Room HMIs}} & \mathbf{\text{Plant-wide monitoring, alarm management, setpoints}} \\
\mathbf{\text{Level 1}} & \mathbf{\text{Direct Control}} & \mathbf{\text{PLCs, PACs, DCS Controllers, Dedicated HMIs}} & \mathbf{\text{Real-time deterministic loop execution (1-10 ms)}} \\
\mathbf{\text{Level 0}} & \mathbf{\text{Field Process}} & \mathbf{\text{Sensors (4-20 mA), Actuators (VFDs, Valves)}} & \mathbf{\text{Physical manufacturing process, pressure, flow}} \\
\hline
\end{array}$$
master the **Industrial Communication Protocols Matrix**:
$$\begin{array}{|l|l|l|l|l|}
\hline
\textbf{Protocol} & \textbf{Standard} & \textbf{Transport Layer} & \textbf{Security} & \textbf{Primary Industrial Role} \\
\hline
\mathbf{\text{OPC-UA}} & \mathbf{\text{IEC 62541}} & \mathbf{\text{TCP/IP (Port 4840) / HTTPS}} & \mathbf{\text{X.509 Certs, TLS, AES-256}} & \mathbf{\text{Vendor-neutral SCADA-to-PLC data exchange}} \\
\mathbf{\text{Modbus TCP}} & Modbus.org & \text{TCP/IP (Port 502)} & None (Plaintext) & Legacy field instrumentation telemetry \\
\mathbf{\text{EtherNet/IP}} & ODVA / CIP & TCP/IP \& UDP (Port 2222/44818) & CIP Security & Allen-Bradley / Rockwell PLC automation \\
\mathbf{\text{PROFINET}} & PI / IEC 61158 & Ethernet Layer 2 (RT / IRT) & Netload security & Siemens S7 PLC deterministic motion control \\
\hline
\end{array}$$
(proving that OPC-UA provides a platform-independent, object-oriented information model with end-to-end cryptographic encryption bridging multi-vendor PLCs directly to enterprise SCADA platforms), and interact with live PLC scan cycle simulator, Motor start/stop seal-in circuit tracer, TON/TOF timer state evaluator, and SCADA/OPC-UA tag monitor widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SCADA / HMI Architecture, ISA-95 Purdue Hierarchy & OPC-UA Security Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Map PLC Tags, Configure an OPC-UA Server, and Design a SCADA HMI Screen Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | SCADA Network Entity / Industrial Protocol & Technical Automation Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Platform-Independent, Secure Industrial Standard Defined by IEC 62541 for Connecting PLCs Directly to SCADA and Enterprise Systems Is Known as OPC-___ (UA / Unified Architecture) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Industrial Automation & SCADA Studio: Scan Cycles, Seal-In Circuits, Timers & OPC-UA Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "scada_hmi_architecture_and_opc_ua_industrial_networking",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the role of OPC-UA in modern SCADA architecture, and how does it map data across the ISA-95 automation hierarchy?",
      "blankAnswer": "SCADA \\& OPC-UA Architecture (Boyer 2016; Petruzella 2017; IEC 62541): (1) SCADA ROLE: Supervisory Control and Data Acquisition provides high-level operator visualization, historical data archiving, setpoint dispatch, and alarm annunciation across entire manufacturing plants. (2) OPC-UA (IEC 62541): Open Platform Communications Unified Architecture is the platform-independent, object-oriented industrial middleware standard with built-in X.509 certificates and AES-256 encryption. (3) ISA-95 INTEGRATION: Bridges Level 1 real-time PLCs (hosting OPC-UA tag servers) to Level 2 SCADA supervisory screens and Level 3 MES historians without vendor lock-in!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to configure a SCADA Human-Machine Interface (HMI) connecting to an industrial PLC via OPC-UA.",
      "orderItems": [
        "Program PLC control logic and expose target memory variables as public tags (e.g. Tank1_Level_PV, Valve_Cmd)",
        "Enable the embedded OPC-UA server in the PLC and configure cryptographic endpoint security (X.509 certs, port 4840)",
        "Configure the SCADA software as an OPC-UA client and browse the PLC tag namespace tree",
        "Bind SCADA graphical UI elements (e.g. animated tank fill gauge, start/stop buttons) to corresponding OPC tags",
        "Configure ISA-18.2 alarm priority setpoints (High-High, Low-Low) and verify bidirectional supervisory control"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each SCADA / Industrial Networking Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "OPC-UA Protocol (IEC 62541)", "right": "Secure, vendor-neutral industrial client-server standard for cross-platform data exchange" },
        { "left": "SCADA Historian", "right": "High-speed time-series database archiving process tag data for regulatory compliance and trend analysis" },
        { "left": "ISA-18.2 Alarm Standard", "right": "Industrial guidelines classifying alarm priority bands (Critical, High, Medium, Low) to prevent operator flood" },
        { "left": "HMI Graphical Interface", "right": "Operator workstation screen presenting real-time plant animations, numerical setpoints, and manual override buttons" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The platform-independent, secure industrial standard defined by IEC 62541 for connecting PLCs directly to SCADA and enterprise systems is known as OPC-___.",
      "blankAnswer": "UA",
      "blankDistractors": ["DA", "TCP", "RTU"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Industrial Automation & SCADA Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Industrial Automation & SCADA Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Scan Cycles, Motor Seal-In, TON Timers & OPC-UA SCADA</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnScan\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Scan & Logic (XIC 1 & XIO 0 &rarr; OTE 1)</button><button id=\"btnSeal\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Motor Seal-In (Fail-Safe NC Stop)</button><button id=\"btnOpc\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. TON Timer (TT=1, DN=0) & OPC-UA</button></div><div id=\"plcLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate PLC scan cycles and bit instructions...</div><script>document.getElementById('btnScan').onclick=()=>{document.getElementById('plcLog').innerHTML='<b>1. PLC SCAN CYCLE \\& BIT LOGIC:</b><br>• Input Scan: Prox_1 = 1, PE_1 = 0 &rarr; Input Table Memory<br>• Logic: XIC(Prox_1) \\u2227 XIO(PE_1) = 1 \\u2227 1 = <b style=\"color:#10b981;\">TRUE!</b><br>• <b style=\"color:#38bdf8;\">OTE Diverter_Sol = 1 (Energized in Output Table)!</b>';}; document.getElementById('btnSeal').onclick=()=>{document.getElementById('plcLog').innerHTML='<b>2. THREE-WIRE MOTOR STARTER SEAL-IN:</b><br>• Motor_Run = (Start \\u2228 Motor_Run) \\u2227 Stop_PB \\u2227 E_Stop<br>• Fail-Safe Wiring: Physical NC Stop delivers 24V (Bit=1)<br>• <b style=\"color:#10b981;\">Pressing Stop sets Bit=0 &rarr; XIC Stop opens &rarr; Motor stops!</b>';}; document.getElementById('btnOpc').onclick=()=>{document.getElementById('plcLog').innerHTML='<b>3. TON TIMERS \\& OPC-UA SCADA:</b><br>• TON Timer (PRE=10s, ACC=6s): <b style=\"color:#10b981;\">EN=1, TT=1, DN=0!</b><br>• OPC-UA (IEC 62541): Secure X.509 client-server tag streaming to SCADA HMI<br>🏆 <b style=\"color:#10b981;\">08_Robotics_Automation_and_Mechatronics (ALL 3 SUBDISCIPLINES) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
