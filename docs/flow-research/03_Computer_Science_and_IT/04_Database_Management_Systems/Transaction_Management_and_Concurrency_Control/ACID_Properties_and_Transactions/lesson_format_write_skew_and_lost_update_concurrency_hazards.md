# Duofy Reusable Lesson Format: Write Skew and Lost Update Concurrency Hazards

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Transaction_Management_and_Concurrency_Control / ACID_Properties_and_Transactions`  
**Lesson Format Type:** `write_skew_and_lost_update_concurrency_hazards`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify race condition hazard patterns, subtle multi-transaction dependency bugs, and mitigation strategies across Snapshot Isolation and Serializable levels (Hal Berenson et al. 1995 *A Critique of ANSI SQL Isolation Levels*; Alan Fekete et al. 2005 *Making Snapshot Isolation Serializable*, ACM TODS; Martin Kleppmann DDIA Chapter 7): master the **Lost Update Hazard** (two concurrent transactions execute a Read-Modify-Write cycle on the same record; one write clobbers and silently overwrites the other; mitigated via **Atomic SQL Updates `UPDATE ... SET x = x + 1`** or **Explicit Pessimistic Locking `SELECT ... FOR UPDATE`**), master the **Write Skew Anomaly** (a subtle multi-row hazard where two concurrent transactions read overlapping data states and make conflicting updates to *disjoint* rows, violating a global business invariant; e.g. the **Doctors-on-Call invariant**, Meeting Room double booking, Username uniqueness race), and analyze **Serializable Snapshot Isolation (SSI)** and **Materializing Conflicts**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lost Updates vs Write Skew Formal Invariant, Hospital Doctors Example Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Concurrency Hazard / Mitigation Strategy & Mechanical Remedy Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Snapshot Isolation Fails to Detect or Prevent Write Skew Anomalies Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The SQL Locking Clause Used to Explicitly Acquire Exclusive Row Locks on Read (SELECT FOR UPDATE) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Doctors-on-Call Write Skew & SELECT FOR UPDATE Race Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "write_skew_and_lost_update_concurrency_hazards",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are Lost Updates and Write Skew anomalies, and why does Snapshot Isolation fail to stop Write Skew?",
      "blankAnswer": "Lost Update & Write Skew Concurrency Hazards (Berenson 1995; Fekete 2005; DDIA Chapter 7): (1) LOST UPDATE (G1c): Occurs during Read-Modify-Write cycles (e.g. counter increment, editing a shared wiki page). Tx 1 and Tx 2 both read balance = $100. Tx 1 writes $150. Tx 2 writes $120. Tx 2 silently clobbers Tx 1's write! Fix: Atomic updates (UPDATE t SET bal = bal + 50) OR SELECT ... FOR UPDATE (pessimistic lock). (2) WRITE SKEW ANOMALY: A generalized race condition where Tx 1 and Tx 2 read overlapping premise data, but UPDATE DIFFERENT DISJOINT ROWS, violating a global business invariant! (3) THE CANONICAL HOSPITAL EXAMPLE: Rule: At least 1 doctor must be on call. Doctors Alice and Bob are on call (count = 2). Alice checks count (2 >= 2, OK) and updates Alice.on_call = false. Simultaneously, Bob checks count (2 >= 2, OK) and updates Bob.on_call = false. Both transactions COMMIT! Result: 0 doctors on call (Invariant broken!). (4) WHY SNAPSHOT ISOLATION FAILS: Snapshot Isolation only detects write-write conflicts on the SAME row. Because Alice modified Alice's row and Bob modified Bob's row, Snapshot Isolation sees no conflict! Fix: True Serializable Isolation (SSI) or explicit SELECT ... FOR UPDATE locking."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Concurrency Hazard / Mitigation Strategy to its exact technical description.",
      "matchPairs": [
        { "left": "Lost Update Anomaly", "right": "Two concurrent transactions execute Read-Modify-Write on the same row; the second write overwrites the first" },
        { "left": "Write Skew Anomaly", "right": "Two transactions read overlapping state and update disjoint rows, violating a cross-row integrity constraint" },
        { "left": "SELECT ... FOR UPDATE", "right": "Pessimistic row-locking clause forcing concurrent readers to wait, preventing Read-Modify-Write clobbering" },
        { "left": "Serializable Snapshot Isolation (SSI)", "right": "Optimistic concurrency algorithm tracking read-write anti-dependency (rw-antidependency) cycles" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A hospital database operates under Snapshot Isolation (Repeatable Read in PostgreSQL/Oracle). The business rule states: 'At least one doctor must remain on call at all times.' Currently, Dr. Alice and Dr. Bob are on call (count = 2). Both doctors simultaneously submit requests to go off call. Why does Snapshot Isolation allow BOTH transactions to commit successfully, leaving ZERO doctors on call?",
      "options": [
        { "text": "Under Snapshot Isolation, the database engine only aborts transactions that experience a direct Write-Write conflict on the exact same row (First-Committer-Wins); because Alice's transaction updates Alice's row (setting Alice.on_call = false) while Bob's transaction updates Bob's row (setting Bob.on_call = false), the two transactions modify completely disjoint rows, causing Snapshot Isolation to detect zero row conflicts and successfully commit both, resulting in a catastrophic Write Skew invariant violation", "isCorrect": true, "explanation": "Correct! This is Alan Fekete and Martin Kleppmann's famous 'Doctors on Call' write skew anomaly (Martin Kleppmann DDIA Chapter 7; Alan Fekete et al. TODS 2005). 1. **The Invariant:** `COUNT(doctors WHERE on_call = true) >= 1`. 2. **Initial State:** Alice and Bob are on call (`count = 2`). 3. **The Race Condition:** - Transaction 1 (Alice): Queries `SELECT COUNT(*) FROM Doctors WHERE on_call = true;` $\implies$ Returns `2`. Since $2 \ge 2$, Alice is allowed to leave. Alice executes `UPDATE Doctors SET on_call = false WHERE name = 'Alice';`. - Transaction 2 (Bob): Queries `SELECT COUNT(*) FROM Doctors WHERE on_call = true;` $\implies$ Returns `2` (from Bob's point-in-time snapshot). Since $2 \ge 2$, Bob is allowed to leave. Bob executes `UPDATE Doctors SET on_call = false WHERE name = 'Bob';`. 4. **Why Snapshot Isolation FAILS:** - Snapshot Isolation enforces the **'First Committer Wins'** rule for writes to the SAME record. - Alice modified the tuple for 'Alice'. - Bob modified the tuple for 'Bob'. - Because the modified rows are completely disjoint, Snapshot Isolation detects ZERO write-write conflicts! - Both transactions execute `COMMIT` successfully. 5. **The Disastrous Result:** `COUNT(*) = 0`. Zero doctors are on call! 6. **The Remedy:** - Use true `SERIALIZABLE` isolation (which detects SI write skew cycles via SSI). - OR use explicit pessimistic locking: `SELECT * FROM Doctors WHERE on_call = true FOR UPDATE;`." },
        { "text": "Because hospitals are exempt from SQL ACID properties", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because doctors cannot have boolean attributes in relational databases", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Snapshot Isolation automatically aborts read-only queries", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To prevent lost updates during a read-modify-write cycle in SQL, developers use the pessimistic locking clause SELECT ... FOR ___.",
      "blankAnswer": "UPDATE",
      "blankDistractors": ["SHARE", "READ", "WRITE"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Doctors-on-Call Write Skew Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Write Skew Race Condition Engine</h3><p>Hospital Invariant: <b style=\"color:#f87171;\">At least 1 Doctor On Call!</b></p><p>Current State: Alice: <b id=\"docA\" style=\"color:#34d399;\">ON CALL</b> | Bob: <b id=\"docB\" style=\"color:#34d399;\">ON CALL</b> (Total = 2)</p><button id=\"skewBtn\" style=\"padding:6px 12px; margin:3px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">1. Trigger Concurrent Off-Call Under Snapshot Isolation</button><button id=\"fixBtn\" style=\"padding:6px 12px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">2. Use SELECT FOR UPDATE (Pessimistic Fix)</button><div id=\"skewLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Select an option above to simulate...</div><script>document.getElementById('skewBtn').onclick=()=>{document.getElementById('docA').innerText='OFF CALL'; document.getElementById('docA').style.color='#94a3b8'; document.getElementById('docB').innerText='OFF CALL'; document.getElementById('docB').style.color='#94a3b8'; document.getElementById('skewLog').innerHTML='⚠️ <b>WRITE SKEW DISASTER OCCURRED!</b><br>• Alice Tx checked count (2 >= 2, OK) -> set Alice OFF.<br>• Bob Tx checked count (2 >= 2, OK) -> set Bob OFF.<br>• Snapshot Isolation saw no row conflict (disjoint rows modified).<br>• Result: <b>0 DOCTORS ON CALL! (Invariant Broken!)</b>';}; document.getElementById('fixBtn').onclick=()=>{document.getElementById('docA').innerText='OFF CALL'; document.getElementById('docA').style.color='#94a3b8'; document.getElementById('docB').innerText='ON CALL'; document.getElementById('docB').style.color='#34d399'; document.getElementById('skewLog').innerHTML='✅ <b>FIXED VIA SELECT ... FOR UPDATE:</b><br>• Alice acquired exclusive lock on both rows.<br>• Bob was forced to WAIT until Alice committed.<br>• When Bob ran query, count was 1, so Bob request was REJECTED.<br>• Result: <b>1 Doctor remains On Call! Safe!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
