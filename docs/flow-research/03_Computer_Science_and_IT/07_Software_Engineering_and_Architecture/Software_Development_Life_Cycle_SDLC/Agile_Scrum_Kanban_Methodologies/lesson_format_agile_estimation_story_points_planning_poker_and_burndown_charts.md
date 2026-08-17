# Duofy Reusable Lesson Format: Agile Estimation (Story Points, Planning Poker, and Burndown Charts)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Development_Life_Cycle_SDLC / Agile_Scrum_Kanban_Methodologies`  
**Lesson Format Type:** `agile_estimation_story_points_planning_poker_and_burndown_charts`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify relative effort estimation, cognitive bias mitigation, and sprint velocity tracking in Agile development (Mike Cohn 2005, *Agile Estimating and Planning*, Prentice Hall; James Grenning 2002 Planning Poker; Ken Schwaber): contrast **Relative Sizing (Story Points)** incorporating Complexity, Uncertainty, and Effort with flawed absolute hour estimates, master the **Fibonacci Sequence Scale ($\mathbf{1, 2, 3, 5, 8, 13, 21}$)** reflecting Weber's Law of just-noticeable differences, master the consensus-driven **Planning Poker Protocol** (simultaneous card revelation eliminating anchoring bias and prompting deep debate between highest and lowest estimators), track team capacity via **Historical Velocity ($\text{Story Points Completed per Sprint}$)**, analyze **Sprint Burndown Charts** (detecting scope creep, flatlines indicating roadblocks, and early completion trajectories), and interact with live Planning Poker consensus simulator, Kanban WIP flow board, and Sprint Burndown tracker widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Story Points Fibonacci Scale, Planning Poker Protocol, & Burndown Chart Flow Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Agile Estimation Metric / Visualization Tool & Functional Application Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Planning Poker Mandates Simultaneous Card Reveal to Prevent Anchoring Bias Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Chart Tracking Remaining Story Points Day-by-Day Against an Ideal Linear Path Is a ___ Chart (Burndown) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Agile Studio: Planning Poker Estimator, Kanban WIP Board & Sprint Burndown Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "agile_estimation_story_points_planning_poker_and_burndown_charts",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why do Agile teams use Fibonacci Story Points instead of hours, and how does Planning Poker eliminate cognitive bias?",
      "blankAnswer": "Agile Estimation & Tracking (Mike Cohn 2005): (1) STORY POINTS: A relative, unitless measure combining Complexity, Uncertainty, and Effort. Estimating hours fails because individual developer speeds vary 10x; however, all developers agree that Task B is 'roughly twice as complex as Task A' (Relative Sizing!). (2) FIBONACCI SCALE (1, 2, 3, 5, 8, 13, 21): Gaps widen exponentially because uncertainty increases with size (Weber-Fechner Law). (3) PLANNING POKER: Each developer privately selects a card and reveals simultaneously. Prevents Anchoring Bias (where the senior dev says '3 hours' and everyone agrees). The highest (13) and lowest (2) estimators explain their reasoning, uncovering hidden edge cases. (4) BURNDOWN CHART: Plots remaining Story Points vs days in sprint. Tracks actual progress against ideal linear trajectory to spot scope creep and blockers!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Agile Estimation Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Story Points (Fibonacci)", "right": "Relative unitless metric representing composite complexity, uncertainty, and development effort" },
        { "left": "Planning Poker", "right": "Consensus-based estimation game with simultaneous voting to eliminate anchoring and dominance bias" },
        { "left": "Team Velocity", "right": "Rolling average number of fully 'Done' story points delivered by a team per sprint iteration" },
        { "left": "Sprint Burndown Chart", "right": "Daily graph tracking remaining backlog effort against an ideal linear burn trajectory" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the Planning Poker estimation technique mandate that all developers privately select their estimate card and reveal them simultaneously, rather than voting sequentially around the table?",
      "options": [
        { "text": "Voting sequentially triggers severe Anchoring Bias and social conformity: if a vocal lead architect states 'this is a simple 2-point task', junior developers holding 8 or 13 cards immediately feel pressured to conform and suppress their concerns; simultaneous revelation forces everyone to think independently, exposing wide divergences (e.g. a junior sees a 13 due to missing database schemas while a senior sees a 2), prompting focused architectural dialogue that uncovers hidden project risks before Sprint Planning concludes", "isCorrect": true, "explanation": "Correct! This is James Grenning and Mike Cohn's psychological design behind Planning Poker (James Grenning 2002; Mike Cohn 2005 *Agile Estimating and Planning*). 1. **The Anchoring Cognitive Bias (Tversky & Kahneman):** - Human brains subconsciously anchor to the first number heard. - If Senior Dev says *\"That will take 3 hours\"*, everyone else's estimate clusters around 3. 2. **What Simultaneous Reveal Accomplishes:** - Card 1: 2. Card 2: 2. Card 3: 2. Card 4: **13**! - The Scrum Master immediately asks: *\"Developer 4, why did you vote 13 when everyone else voted 2?\"* - Developer 4 answers: *\"Because if you change this table schema, you will break the billing microservice and require database migration scripts across 5 environments!\"* - The team realizes: *\"Wow, we completely forgot about the billing service. It IS a 13!\"* 3. **The Outcome:** Planning Poker turns estimation from a boring administrative task into a **powerful risk-discovery mechanism**!" },
        { "text": "Because revealing cards one-by-one causes computer networks to disconnect", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Planning Poker is a legal gambling tournament", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Fibonacci numbers can only be pronounced simultaneously", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The chart tracking remaining Story Points daily against an ideal linear trajectory is a ___ chart.",
      "blankAnswer": "burndown",
      "blankDistractors": ["gantt", "pareto", "histogram"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Agile Studio: Planning Poker, Kanban & Burndown",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Agile Engineering Studio</h3><p>Sprint 24: <b style=\"color:#38bdf8;\">User Authentication Microservice</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnPoker\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Play Planning Poker</button><button id=\"btnKanban\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Enforce Kanban WIP</button><button id=\"btnBurn\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Track Sprint Burndown</button></div><div id=\"agileLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to execute Planning Poker...</div><script>document.getElementById('btnPoker').onclick=()=>{document.getElementById('agileLog').innerHTML='<b>1. PLANNING POKER SIMULTANEOUS REVEAL:</b><br>• Votes: [Dev A: 3, Dev B: 5, Dev C: 5, Dev D: 13]<br>• Debate: Dev D noted OAuth2 rate limit risks!<br>🏆 <b style=\"color:#38bdf8;\">Team Consensus reached at 8 Story Points!</b>';}; document.getElementById('btnKanban').onclick=()=>{document.getElementById('agileLog').innerHTML='<b>2. KANBAN PULL & LITTLE\\'S LAW:</b><br>• WIP Limit: 3 in Development, 2 in Review<br>• Little\\'s Law: Lead Time = WIP / Throughput = 4 / 2 = 2 Days!<br>🚀 <b style=\"color:#10b981;\">Context switching eliminated!</b>';}; document.getElementById('btnBurn').onclick=()=>{document.getElementById('agileLog').innerHTML='<b>3. SPRINT BURNDOWN TRAJECTORY:</b><br>• Day 1: 40 pts &rarr; Day 5: 22 pts &rarr; Day 10: 0 pts remaining<br>• Velocity: 40 pts delivered (100% Definition of Done!)<br>🎉 <b style=\"color:#10b981;\">Potentially Shippable Increment delivered to production!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
