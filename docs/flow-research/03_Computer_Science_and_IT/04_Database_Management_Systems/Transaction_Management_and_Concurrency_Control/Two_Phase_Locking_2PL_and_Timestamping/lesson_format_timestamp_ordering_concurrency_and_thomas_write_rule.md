# Duofy Reusable Lesson Format: Timestamp Ordering Concurrency and Thomas' Write Rule

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Transaction_Management_and_Concurrency_Control / Two_Phase_Locking_2PL_and_Timestamping`  
**Lesson Format Type:** `timestamp_ordering_concurrency_and_thomas_write_rule`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify timestamp-based concurrency control, read/write timestamp validations, and obsolete write optimizations across non-locking serialization protocols (Philip A. Bernstein & Nathan Goodman 1981, *Concurrency Control in Distributed Database Systems*, ACM Computing Surveys; Robert H. Thomas 1979, *A Majority Consensus Approach to Concurrency Control for Multiple Copy Databases*, ACM TODS; Silberschatz Chapter 18.2; Elmasri & Navathe Chapter 21.3): master the **Timestamp Ordering (TO) Protocol** using unique monotonic transaction timestamps $\text{TS}(T_i)$ and per-item timestamps ($\mathbf{R\text{-TS}(Q)}$ [largest read timestamp] and $\mathbf{W\text{-TS}(Q)}$ [largest write timestamp]), evaluate the **Read Invariant** ($\text{TS}(T_i) < W\text{-TS}(Q) \implies \text{Rollback}$) and **Write Invariant**, formulate **Thomas' Write Rule (TWR)** where an obsolete write with $\text{TS}(T_i) < W\text{-TS}(Q)$ is **safely ignored and skipped without aborting the transaction**, and interact with live timestamp conflict and Thomas' write rule simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Basic Timestamp Ordering Rules, R-TS/W-TS Invariants, & Thomas' Write Rule Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Timestamp Ordering Rule / Condition & Protocol Action Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Thomas' Write Rule Safely Ignores Obsolete Writes Without Aborting Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Name of the Protocol That Uses Logical Clock Timestamps Rather Than Locks for Concurrency (Timestamp Ordering) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Timestamp Ordering & Thomas' Write Rule Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "timestamp_ordering_concurrency_and_thomas_write_rule",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Timestamp Ordering protocol, how do R-TS and W-TS work, and what is Thomas' Write Rule?",
      "blankAnswer": "Timestamp Ordering & Thomas' Write Rule (Bernstein & Goodman 1981; Thomas 1979; Silberschatz 18.2): (1) TIMESTAMP ORDERING (TO): Each transaction Ti receives unique monotonic timestamp TS(Ti). Protocol guarantees serialization order matches timestamp order! (2) DATA ITEM TIMESTAMPS: For each item Q: (a) W-TS(Q): Largest timestamp of any transaction that successfully executed write(Q). (b) R-TS(Q): Largest timestamp of any transaction that successfully executed read(Q). (3) READ RULE (Ti issues read(Q)): If TS(Ti) < W-TS(Q), Ti is attempting to read an overwritten obsolete value -> ABORT & ROLLBACK Ti! Else: execute read, set R-TS(Q) = max(R-TS(Q), TS(Ti)). (4) BASIC WRITE RULE (Ti issues write(Q)): If TS(Ti) < R-TS(Q) (a newer transaction already read older state) OR TS(Ti) < W-TS(Q) -> ABORT & ROLLBACK Ti! (5) THOMAS' WRITE RULE (TWR Optimization): If TS(Ti) < W-TS(Q), DO NOT ABORT Ti! Simply IGNORE and SKIP the write! Because a newer transaction with timestamp W-TS(Q) has already written a later value, Ti's write would have been overwritten anyway. Skipping it preserves view serializability and avoids costly transaction aborts!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Timestamp Ordering Scenario to its exact Protocol Action.",
      "matchPairs": [
        { "left": "Read: TS(Ti) < W-TS(Q)", "right": "Reject read and abort Ti because Ti needs a value that was already overwritten by a newer transaction" },
        { "left": "Read: TS(Ti) >= W-TS(Q)", "right": "Execute read successfully and update R-TS(Q) = max(R-TS(Q), TS(Ti))" },
        { "left": "Write: TS(Ti) < R-TS(Q)", "right": "Reject write and abort Ti because a younger transaction has already read the old value of Q" },
        { "left": "Thomas' Write Rule: TS(Ti) < W-TS(Q)", "right": "Ignore and discard Ti's obsolete write without aborting Ti, allowing the transaction to proceed" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is it mathematically sound for Thomas' Write Rule to simply ignore and discard an obsolete write operation (where TS(Ti) < W-TS(Q)) instead of aborting and restarting transaction Ti as required by Basic Timestamp Ordering?",
      "options": [
        { "text": "Because a newer transaction with timestamp W-TS(Q) > TS(Ti) has already written a newer value to item Q; under view serializability, any subsequent read operation with timestamp TS > W-TS(Q) would read the newer value anyway, meaning Ti's intermediate write would have been completely overwritten without ever being observed; thus, ignoring the write produces a schedule that is mathematically view equivalent to executing Ti in its timestamp order without the performance penalty of an abort", "isCorrect": true, "explanation": "Correct! This is Robert Thomas' famous 1979 optimization for timestamp ordering concurrency control (Silberschatz Section 18.2.2; Elmasri & Navathe Section 21.3). 1. **Basic Timestamp Ordering Strictness:** - In Basic TO, if $T_1$ with $\\text{TS}(T_1) = 100$ attempts to write to item $Q$, but $W\\text{-TS}(Q) = 200$ (written by $T_2$ with $\\text{TS} = 200$), the system panics, aborts $T_1$, and rolls it back. 2. **Thomas' Insight:** - Ask: *What would have happened if $T_1$ had executed on time?* - $T_1$ would have written $Q$ at timestamp $100$. - Then $T_2$ would have overwritten $Q$ at timestamp $200$. - Any subsequent transaction $T_3$ with $\\text{TS} = 250$ reading $Q$ would see $T_2$'s value! Nobody would ever read $T_1$'s value! 3. **The TWR Optimization:** - Since $T_2$'s value is already resting in $Q$, executing $T_1$'s write now would corrupt $Q$ with stale data. - But ABORTING $T_1$ is completely unnecessary! - We simply **ignore (drop) $T_1$'s write operation** and let $T_1$ continue executing! - The resulting schedule is **View Serializable**, drastically reducing abort rates and transaction latency." },
        { "text": "Because Thomas' Write Rule disables all disk writes and uses CPU cache only", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because obsolete writes are automatically forwarded to remote replica nodes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because timestamp ordering only works on read-only databases", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The optimization that allows obsolete writes to be ignored without aborting the transaction is ___'s Write Rule.",
      "blankAnswer": "Thomas",
      "blankDistractors": ["Gray", "Lamport", "Bernstein"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Timestamp Ordering & Thomas' Write Rule Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Timestamp Ordering Engine</h3><p>Item Q: <b style=\"color:#38bdf8;\">W-TS(Q) = 200</b> | <b style=\"color:#f59e0b;\">R-TS(Q) = 150</b></p><p>Incoming Tx: <b style=\"color:#ec4899;\">T_old (TS = 120)</b> issues Write(Q)</p><div style=\"display:flex; gap:6px;\"><button id=\"btnBasic\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Basic TO Action</button><button id=\"btnTwr\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">2. Thomas' Write Rule (TWR)</button></div><div id=\"toLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:320px; font-family:monospace; color:#fbbf24;\">Select protocol rule above...</div><script>document.getElementById('btnBasic').onclick=()=>{document.getElementById('toLog').innerHTML='<b>BASIC TIMESTAMP ORDERING:</b><br>• TS(T_old)=120 < W-TS(Q)=200<br>• ❌ <b>ABORT & ROLLBACK T_old!</b><br>• Reason: Obsolete write detected. High restart penalty.';}; document.getElementById('btnTwr').onclick=()=>{document.getElementById('toLog').innerHTML='<b>THOMAS\' WRITE RULE (TWR 1979):</b><br>• TS(T_old)=120 < W-TS(Q)=200<br>• ⚡ <b>SKIP & IGNORE WRITE! T_old CONTINUES!</b><br>• Reason: Newer write (TS=200) already superseded it. View serializability preserved with ZERO aborts!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
