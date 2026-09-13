# QM_1 source parts
`../../QM_1.html` is the canonical single-file deliverable (self-contained; shares standalone).
These are the editable source parts that were inlined into it:
- `QM_1.data.js`   — station content model (window.STATIONS)
- `QM_1.engine.js` — framework, canvas diagram engine, retrieval, Firebase RTDB sync
Rebuild: replace the two inline <script> blocks in QM_1.html with these, or re-inline.
Progress DB: task-dominion RTDB (open rules), path `ssc_qm_mod12/<syncId>`.
Host: firebase project data-science-ef878, site ssc-data-science-qm.
