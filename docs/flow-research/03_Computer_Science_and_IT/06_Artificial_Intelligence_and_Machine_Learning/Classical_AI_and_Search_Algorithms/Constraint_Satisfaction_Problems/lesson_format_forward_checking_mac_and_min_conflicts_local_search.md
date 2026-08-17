# Duofy Reusable Lesson Format: Forward Checking, MAC, and Min-Conflicts Local Search

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Constraint_Satisfaction_Problems`  
**Lesson Format Type:** `forward_checking_mac_and_min_conflicts_local_search`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify interleaved search-with-inference techniques and local repair optimization algorithms across Constraint Satisfaction Problems (Russell & Norvig *AIMA* Chapter 6.3.2 & 6.4; Steven Minton, Mark Johnston, Philip Philips, Philip Laird 1992 *Min-Conflicts Local Search*): contrast **Forward Checking (pruning inconsistent values only from the direct unassigned neighbors of a newly assigned variable, detecting domain wipes $|D_k| = 0$)** with **Maintaining Arc Consistency (MAC: executing a full AC-3 propagation cycle on incoming neighbor arcs after every assignment, detecting subtle non-local domain contradictions that Forward Checking misses)**, master **Local Search for CSPs: The Min-Conflicts Algorithm** (initializing a complete random assignment and iteratively picking conflicted variables to reassign the value that minimizes total constraint violations), and analyze why Min-Conflicts solves massive combinatorial instances (e.g. the $n = 1,000,000\text{-Queens}$ problem) in almost linear $\mathcal{O}(n)$ time, and interact with live Forward Checking domain shrinkage and Min-Conflicts N-Queens repair simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Forward Checking vs MAC Arc Propagation, Min-Conflicts Algorithm Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | CSP Inference / Local Search Technique & Operational Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Maintaining Arc Consistency (MAC) Detects Failures That Forward Checking Misses Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Local Search Heuristic That Iteratively Minimizes Constraint Violations Across Conflicted Variables (Min-Conflicts) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Forward Checking vs Min-Conflicts N-Queens Repair Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "forward_checking_mac_and_min_conflicts_local_search",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do Forward Checking and MAC differ in inference depth, and how does the Min-Conflicts local search algorithm work?",
      "blankAnswer": "CSP Inference & Min-Conflicts (Russell & Norvig *AIMA* 6.3.2-6.4; Minton et al. 1992): (1) FORWARD CHECKING: Whenever variable X is assigned value v, it looks ahead to direct unassigned neighbors Y and deletes any value in D_Y that violates a constraint with (X=v). Fails when any D_Y becomes empty (0 choices). (2) MAINTAINING ARC CONSISTENCY (MAC): Significantly stronger than Forward Checking! After assigning X=v, it runs the full AC-3 algorithm on all arcs (Y, X). If D_Y is reduced, it propagates the ripple reduction to D_Y's neighbors (Z, Y). Detects contradictions that Forward Checking is completely blind to! (3) MIN-CONFLICTS LOCAL SEARCH: Starts with a COMPLETE (but inconsistent) assignment of all variables. In each step: (i) Randomly select a variable involved in at least 1 constraint conflict. (ii) Reassign that variable the value that minimizes total constraint violations (min-conflicts). Solves the 1,000,000-Queens problem in almost linear time O(n)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each CSP Search & Inference Technique to its exact Technical Mechanism.",
      "matchPairs": [
        { "left": "Forward Checking", "right": "Simple look-ahead pruning inconsistent values only from the direct immediate neighbors of the assigned variable" },
        { "left": "Maintaining Arc Consistency (MAC)", "right": "Interleaved inference running AC-3 across the entire network to propagate multi-hop domain reductions" },
        { "left": "Min-Conflicts Local Search", "right": "Iterative hill-climbing repair algorithm selecting conflicted variables and reassigning least-conflicted values" },
        { "left": "Domain Wipeout (|D| = 0)", "right": "Immediate trigger causing backtracking search to reject the current partial assignment" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the Map Coloring problem for Australia with colors {Red, Green, Blue}, variable Western Australia (WA) is assigned Red, and Queensland (Q) is assigned Green. Why does Maintaining Arc Consistency (MAC) immediately detect a dead-end failure on Northern Territory (NT) and South Australia (SA), whereas simple Forward Checking fails to detect the failure?",
      "options": [
        { "text": "Forward Checking only checks constraints directly connected to newly assigned variables, reducing NT's domain to {Blue} (due to WA=Red) and reducing SA's domain to {Blue} (due to WA=Red and Q=Green); because neither domain is empty (|D| > 0), Forward Checking reports success; however, NT and SA share an unassigned neighbor constraint (NT != SA); MAC propagates AC-3 across arc (SA, NT), discovers that if NT takes Blue then SA has zero legal choices remaining, and immediately flags an unavoidable contradiction without wasting search steps", "isCorrect": true, "explanation": "Correct! This is the classic textbook illustration of why MAC is vastly superior to simple Forward Checking (Russell & Norvig *AIMA* Section 6.3.2). 1. **What Forward Checking Does:** - Assign `WA = Red` $\\implies D(\\text{NT}) = \\{\\text{Green, Blue}\\}$, $D(\\text{SA}) = \\{\\text{Green, Blue}\\}$. - Assign `Q = Green` $\\implies D(\\text{NT}) = \\{\\text{Blue}\\}$, $D(\\text{SA}) = \\{\\text{Blue}\\}$. - Forward Checking looks at each neighbor: $D(\\text{NT})$ has 1 value, $D(\\text{SA})$ has 1 value, $D(\\text{NSW})$ has 2 values. - None of the domains are empty ($|D| \\ne 0$). - Forward Checking happily says: *'Looks great! Keep going!'* 2. **What Actually Happens:** - NT and SA are adjacent ($NT \\ne SA$). - Both are forced to be **Blue**! This is an immediate, fatal contradiction. - Forward Checking is **blind to constraints between two unassigned variables**! 3. **The MAC Solution:** - After assigning `Q = Green`, MAC runs AC-3 on arc $(SA, NT)$. - For value `Blue` in $D(\\text{SA})$, is there a non-Blue value in $D(\\text{NT})$? (No, $D(\\text{NT})$ is only $\\{\\text{Blue}\\}$!). - AC-3 deletes `Blue` from $D(\\text{SA}) \\implies D(\\text{SA}) = \\emptyset$. - MAC detects the dead-end immediately and backtracks before exploring useless deeper assignments!" },
        { "text": "Because Australia has too many kangaroos for Forward Checking to work", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because MAC can only run on 64-bit operating systems", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Forward Checking does not support the color Green", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The local search repair algorithm that iteratively chooses the value minimizing constraint violations is Min-___.",
      "blankAnswer": "Conflicts",
      "blankDistractors": ["Max", "Values", "Domains"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Forward Checking & Min-Conflicts N-Queens Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>CSP Inference & Local Search Engine</h3><div style=\"display:flex; gap:6px;\"><button id=\"btnFc\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Test Forward Checking (Blind)</button><button id=\"btnMac\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Test MAC (AC-3 Ripple)</button><button id=\"btnMinC\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Min-Conflicts (4-Queens)</button></div><div id=\"cspLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Select an inference or search technique...</div><script>document.getElementById('btnFc').onclick=()=>{document.getElementById('cspLog').innerHTML='<b>FORWARD CHECKING (Australia Map):</b><br>• WA=Red &rarr; NT:{G,B}, SA:{G,B}<br>• Q=Green &rarr; NT:{Blue}, SA:{Blue}<br>⚠️ Forward Checking missed NT != SA clash (Domains not empty)!';}; document.getElementById('btnMac').onclick=()=>{document.getElementById('cspLog').innerHTML='<b>MAINTAINING ARC CONSISTENCY (MAC):</b><br>• AC-3 evaluates arc (SA, NT):<br>&nbsp;&nbsp;SA=Blue requires non-Blue in NT (None exists!)<br>&nbsp;&nbsp;&rarr; Pruned Blue from SA &rarr; <b style=\"color:#ef4444;\">D(SA) = &empty; (EMPTY DOMAIN!)</b><br>🛡️ MAC caught dead-end instantly, saving hundreds of backtrack steps!';}; document.getElementById('btnMinC').onclick=()=>{document.getElementById('cspLog').innerHTML='<b>MIN-CONFLICTS LOCAL REPAIR (N-Queens):</b><br>• Initial State: [Q1=1, Q2=1, Q3=1, Q4=1] (Conflicts: 6)<br>• Iteration 1: Moved Q2 to Row 3 (Conflicts: 2)<br>• Iteration 2: Moved Q4 to Row 2 (Conflicts: 0)<br>🎉 <b style=\"color:#10b981;\">Solved in 2 repair steps! Scalable to N=1,000,000 queens in O(N) time!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
