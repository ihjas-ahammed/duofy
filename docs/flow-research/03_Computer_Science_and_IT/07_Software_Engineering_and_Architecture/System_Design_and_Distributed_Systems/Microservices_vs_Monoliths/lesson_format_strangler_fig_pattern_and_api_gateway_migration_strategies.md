# Duofy Reusable Lesson Format: Strangler Fig Pattern and API Gateway Migration Strategies

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / System_Design_and_Distributed_Systems / Microservices_vs_Monoliths`  
**Lesson Format Type:** `strangler_fig_pattern_and_api_gateway_migration_strategies`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify legacy modernization, traffic interception gateways, and risk-controlled monolith-to-microservices migration strategies (Martin Fowler 2004 *StranglerFigApplication*; Sam Newman 2020 *Monolith to Microservices: Evolutionary Patterns to Transform Your Monolith*; Chris Richardson 2018): analyze why "Big Bang" complete system rewrites are statistically notorious for catastrophic project failure (budget overruns, scope creep, moving targets, and catastrophic go-live outages), master the **Strangler Fig Pattern** (placing an **API Gateway / Reverse Proxy** in front of the legacy monolith, intercepting client traffic, and incrementally carving out vertical slices of business functionality into autonomous microservices while routing remaining traffic to the monolith until the legacy core shrinks to zero and is safely decommissioned), and interact with live Microservices Decomposition sandbox, Saga Transaction Compensation simulator, and CQRS Event Stream projector widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Strangler Fig Pattern Migration Lifecycle Diagram & API Gateway Interception Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Migration Technique / Architecture Component & Modernization Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Incremental Strangler Fig Migration Decisively Outperforms High-Risk Big-Bang Rewrites Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Architectural Migration Pattern That Incrementally Replaces a Monolith via an Interception Proxy Is the Strangler ___ Pattern (Fig) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Distributed Architecture Studio: Microservices Splitter, Saga Compensator & CQRS Projector Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "strangler_fig_pattern_and_api_gateway_migration_strategies",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Strangler Fig pattern, and why does an API Gateway make incremental migration possible?",
      "blankAnswer": "Strangler Fig Pattern & API Gateways (Martin Fowler 2004; Sam Newman 2020): (1) THE STRANGLER FIG PATTERN: Named after strangler figs that seed in the upper branches of a host tree and grow down until the host tree dies and rots away. In software: You incrementally replace legacy monolith functionality by extracting small vertical slices into new microservices. (2) THE API GATEWAY INTERCEPTION: Place a reverse proxy (e.g. NGINX, Kong, Envoy) in front of the monolith. Initially, 100% of traffic routes to the monolith. As new microservices (e.g. /auth, /cart) are built, the Gateway selectively re-routes matching URL paths to the new services! (3) THE REASON OVER BIG BANG: Big-bang rewrites take 3 years, cost millions, and fail because legacy business requirements keep moving. Strangler Fig delivers immediate production value in 2-week agile increments with near-zero risk!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Migration Construct to its exact Technical Role.",
      "matchPairs": [
        { "left": "Strangler Fig Pattern", "right": "Incremental migration strategy gradually replacing legacy monolith functions with microservices" },
        { "left": "API Gateway Interception", "right": "Reverse proxy placed in front of monolith to dynamically route specific URL paths to new microservices" },
        { "left": "Branch by Abstraction", "right": "Refactoring technique introducing an internal interface layer within code to swap legacy logic seamlessly" },
        { "left": "Anti-Corruption Layer (ACL)", "right": "Translation layer isolating new microservices from legacy domain models and database schemas" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is Martin Fowler's Strangler Fig pattern considered the gold standard for enterprise monolith modernization, whereas 'Big Bang' rewrites have a notoriously high project failure rate?",
      "options": [
        { "text": "Big-bang rewrites attempt to recreate years of complex, undocumented legacy business rules from scratch in a parallel multi-year project; during the rewrite, the legacy production system continues evolving, creating a moving target that leads to missed deadlines, massive budget blowouts, and high-risk cutover outages; the Strangler Fig pattern delivers working microservices incrementally every sprint, routing live traffic slice-by-slice through an API Gateway, validating business value in production immediately while keeping risk and rollback scope minimal", "isCorrect": true, "explanation": "Correct! This is Martin Fowler and Sam Newman's primary modernization thesis (Martin Fowler *StranglerFigApplication*; Sam Newman *Monolith to Microservices* Chapter 1). 1. **The Big-Bang Rewrite Fallacy:** - Company announces: *\"We are halting all new features for 2 years to rewrite our monolith in Go and Kubernetes!\"* - What happens in reality: Year 2 arrives. The new system is only $60\\%$ complete. - Meanwhile, the business was forced to patch the legacy monolith with 500 new features $\\implies$ The new system is already obsolete before launch! - When they finally attempt a 'Big Bang' weekend cutover: Everything crashes and they roll back in humiliation. 2. **The Strangler Fig Success:** - Step 1: Put an API Gateway in front of Monolith. - Step 2: Extract just ONE feature: `POST /notifications` into a microservice. - Step 3: Configure Gateway to route `/notifications` to the new service. - Step 4: Validate in production! Total time: 2 weeks. - Repeat step-by-step for 12 months until the monolith contains zero traffic and can be cleanly shut down!" },
        { "text": "Because Big Bang rewrites require writing code in binary machine code", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Strangler Fig pattern can only be implemented in Python", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because API Gateways are legally required to block legacy software", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The evolutionary pattern that incrementally replaces a legacy monolith by intercepting traffic is the Strangler ___ pattern.",
      "blankAnswer": "Fig",
      "blankDistractors": ["Tree", "Vine", "Oak"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Distributed Architecture Studio: Saga & CQRS",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Distributed Architecture Studio</h3><p>Workflow: <b style=\"color:#38bdf8;\">Saga Transaction & CQRS Read Model</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnSagaFail\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Trigger Saga Inventory Failure</button><button id=\"btnCompensate\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Execute Compensating Rollback</button><button id=\"btnCqrs\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Project Event to CQRS Read DB</button></div><div id=\"sagaLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to trigger distributed Saga transaction...</div><script>document.getElementById('btnSagaFail').onclick=()=>{document.getElementById('sagaLog').innerHTML='<b>1. SAGA FORWARD TRANSACTION:</b><br>• [Tx 1] OrderService &rarr; Order #1042 created (PENDING)<br>• [Tx 2] PaymentService &rarr; Charged $120.00 to Card<br>• [Tx 3] InventoryService &rarr; <b style=\"color:#ef4444;\">FAIL: Item Out of Stock!</b>';}; document.getElementById('btnCompensate').onclick=()=>{document.getElementById('sagaLog').innerHTML='<b>2. COMPENSATING ROLLBACK:</b><br>• [Comp 2] PaymentService.refund($120.00) &rarr; SUCCESS<br>• [Comp 1] OrderService.cancelOrder(1042) &rarr; STATUS: CANCELLED<br>• <b style=\"color:#10b981;\">Distributed consistency restored cleanly!</b>';}; document.getElementById('btnCqrs').onclick=()=>{document.getElementById('sagaLog').innerHTML='<b>3. CQRS READ MODEL PROJECTION:</b><br>• Event Store appended: OrderCancelledEvent<br>• Background Projector consumed event from Kafka<br>• Updated Elasticsearch Read DB materialized view in 12ms!<br>🏆 <b style=\"color:#10b981;\">Client queries show updated state with 0 cross-service SQL joins!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
