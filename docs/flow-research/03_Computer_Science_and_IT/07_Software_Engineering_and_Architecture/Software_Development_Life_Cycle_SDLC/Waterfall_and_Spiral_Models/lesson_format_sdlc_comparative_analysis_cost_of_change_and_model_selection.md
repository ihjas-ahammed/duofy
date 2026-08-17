# Duofy Reusable Lesson Format: SDLC Comparative Analysis (Cost of Change and Model Selection)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Development_Life_Cycle_SDLC / Waterfall_and_Spiral_Models`  
**Lesson Format Type:** `sdlc_comparative_analysis_cost_of_change_and_model_selection`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify comparative methodology selection, risk-complexity trade-offs, and the empirical mathematics of Boehm's Cost-of-Change curve across traditional software engineering processes (Barry W. Boehm 1981, *Software Engineering Economics*, Prentice Hall; Ian Sommerville *Software Engineering* Chapter 2; Roger Pressman Chapter 2): analyze **Boehm's Exponential Cost-of-Change Curve** proving that defects discovered during operations and maintenance cost **$100\times$ to $200\times$ more to remediate** than defects resolved during requirements analysis ($\text{Cost} \propto e^t$), evaluate a multi-criteria **Process Selection Matrix** matching project attributes (Requirement Clarity, System Criticality, Technical Uncertainty, Team Experience, Regulatory Auditing) against candidate lifecycles (**Waterfall, V-Model, Spiral, and Agile/Scrum**), and interact with live SDLC Process Selection Engine, Cost-of-Change Curve calculator, and Spiral Risk Simulation widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Boehm's Cost-of-Change Curve $\text{Cost}(t) \propto e^t$, SDLC Model Decision Matrix Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Project Profile / Environmental Constraint & Optimal SDLC Process Model Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Regulated, Safety-Critical Industries (Aerospace/Medical) Mandate the V-Model Over Pure Agile Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Cost to Repair a Software Defect Discovered in Maintenance Is Approximately ___ Times Higher than in Requirements (100 / 100x) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive SDLC Studio: Cost-of-Change Curve, Process Selection Matrix & Spiral Risk Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sdlc_comparative_analysis_cost_of_change_and_model_selection",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Boehm's Cost-of-Change curve, and what project factors determine whether to use Waterfall, V-Model, or Spiral?",
      "blankAnswer": "SDLC Comparative Analysis (Boehm 1981; Sommerville Ch 2): (1) BOEHM'S COST-OF-CHANGE CURVE: The cost to fix a software defect grows exponentially across the lifecycle: Requirements = 1x -> Design = 5x -> Coding = 10x -> System Testing = 20-50x -> Production Maintenance = 100x-200x! (2) MODEL SELECTION RULES: (a) Waterfall: Use when requirements are 100% stable, well-understood, and regulatory contracts require fixed-price milestones (e.g. government infrastructure). (b) V-Model: Use for safety-critical, compliance-driven domains where bidirectional traceability from requirement to verification is legally mandated (e.g. medical pacemakers, automotive brake control ISO 26262, avionics DO-178C). (c) Spiral: Use for massive, high-budget projects with unprecedented technical risks and heavy unknowns (e.g. next-gen defense radar, core enterprise cloud migration)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Real-World Project Scenario to its Optimal SDLC Process Model.",
      "matchPairs": [
        { "left": "Medical Infusion Pump Firmware", "right": "V-Model ensuring formal bidirectional verification from safety requirements to unit test execution" },
        { "left": "Multi-Billion Next-Gen Air Traffic Control", "right": "Spiral Model resolving massive concurrency and architectural risks through iterative prototyping" },
        { "left": "Standardized Database Migration with Fixed Specs", "right": "Waterfall Model executing linear phase-gated conversion of well-defined legacy schemas" },
        { "left": "Consumer Mobile Social App with Evolving Features", "right": "Agile/Scrum Model delivering iterative 2-week increments based on continuous user analytics" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why do international regulatory and safety standards for mission-critical software (such as ISO 26262 for automotive vehicles and DO-178C for commercial avionics) mandate strict V-Model processes with formal Traceability Matrices rather than informal rapid prototyping?",
      "options": [
        { "text": "In safety-critical systems where software failures could result in loss of human life, regulatory certification requires provable Bidirectional Traceability: every single safety requirement must link directly to an architectural design component, source code function, and passing formal verification test case; the V-Model provides a rigorous, auditable documentation chain ensuring 100% test coverage and proving that every safety hazard has been systematically tested and verified before deployment", "isCorrect": true, "explanation": "Correct! This is the primary reason the V-Model remains the global gold standard in regulated safety-critical systems engineering (Sommerville *Software Engineering* Section 2.1; ISO 26262; FAA DO-178C). 1. **The Legal & Safety Burden:** - In a smartphone app, a crash is an annoyance. - In an automated emergency braking system or flight control system, a null pointer exception kills people. - Regulatory bodies (FAA, FDA, ISO) require **strict legal proof** that the software is safe. 2. **The Bidirectional Traceability Matrix (RTM):** - Requirement `REQ-SAFETY-104`: *\"If brake pedal pressure exceeds 80 bar, ABS shall pulse within 15ms.\"* - Design `HLD-42`: Specifies the CAN bus ABS module interface. - Code `abs_ctrl.c`: Implements the C function. - Test `TEST-VAL-104`: Unit test verifying the 15ms timing constraint. 3. **The V-Model Guarantee:** - An auditor can trace from the requirement on the left branch $\\to$ across the V $\\to$ to the exact test execution log on the right branch. - Every line of code exists for an authorized requirement, and every requirement is provably tested with $100\\%$ branch coverage!" },
        { "text": "Because safety-critical computers are unable to run software with loops", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the V-Model prohibits developers from using version control systems", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Agile frameworks are legally outlawed in all countries", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to Boehm's Cost-of-Change curve, remediating a defect in the maintenance phase is approximately ___ times more expensive than in the requirements phase.",
      "blankAnswer": "100",
      "blankDistractors": ["2", "5", "10"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive SDLC Studio: Cost-of-Change & Selection Matrix",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>SDLC Process Decision Studio</h3><p>Project Profile: <b style=\"color:#38bdf8;\">Automotive Autonomous Braking (Safety-Critical)</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnCost\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Boehm Cost Curve (1x &rarr; 100x)</button><button id=\"btnMatrix\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Evaluate Process Matrix</button><button id=\"btnSpiral\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Run Spiral Risk Prototype</button></div><div id=\"sdlcLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate defect remediation costs...</div><script>document.getElementById('btnCost').onclick=()=>{document.getElementById('sdlcLog').innerHTML='<b>1. BOEHM COST-OF-CHANGE EXPONENTIAL CURVE:</b><br>• Requirements Phase: <b style=\"color:#10b981;\">$100 (1x)</b><br>• Design Phase: $500 (5x)<br>• Implementation Phase: $1,000 (10x)<br>• Integration Testing: $5,000 (50x)<br>• Production Maintenance: <b style=\"color:#ef4444;\">$10,000 - $20,000 (100x - 200x!)</b>';}; document.getElementById('btnMatrix').onclick=()=>{document.getElementById('sdlcLog').innerHTML='<b>2. PROCESS SELECTION MATRIX RESULT:</b><br>• Requirement Stability: HIGH | Safety Risk: CRITICAL<br>• Regulatory Mandate: ISO 26262 Automotive ASIL-D<br>🏆 <b style=\"color:#10b981;\">RECOMMENDED MODEL: V-Model (Bidirectional V&V)</b>';}; document.getElementById('btnSpiral').onclick=()=>{document.getElementById('sdlcLog').innerHTML='<b>3. SPIRAL MODEL RISK ANALYSIS (Q2):</b><br>• Identified Risk: Brake actuator response latency > 15ms<br>• Prototype Benchmark: Hardware-in-the-loop simulation<br>• Feasibility Verified: 8.4ms latency achieved in Q2!<br>🎉 <b style=\"color:#10b981;\">Risk neutralized before production investment!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
