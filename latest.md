# What's New in v26.9.13 (Build 2127091302)

- **Tree Reader Auto-Advance & Accordion Sequence**:
  - Marking any topic completed automatically collapses the current topic and expands the next topic in sequence, smoothly scrolling it into focus.
- **Dedicated Styled Module Tags & Clean Headers**:
  - Replaced repetitive `"Module X: <Name>"` titles with a dedicated pill badge `[ • MODULE X ]` and separated clean module typography across Tree Reader, Module Selection, and Section Selection screens.
- **Per-Section Generate Button & Singular Generation**:
  - Added a prominent, real-time reactive `[ ✦ Generate Section Contents ]` button directly on every section card in Section Selection.
  - Resolved task scheduling race conditions in `GenerationManager` to enforce singular sequential section planning per course.
- **Dual Integration: Syllabus + Reference Textbook Ingestion**:
  - Enhanced both `generateUnitContent` and `generateUnitManifest` in `AIService` to simultaneously ingest syllabus curriculum requirements and reference textbook PDF excerpts under `[INTEGRATED SOURCES: SYLLABUS & REFERENCE TEXTBOOK]`.
- **Drill Arena & Analytics Redesign**:
  - **Drill Screen**: Hero masthead with `[ • DRILL LAB ]` pill kicker, mini statgrid (`SCOPE`, `POOL`, `PYQ`), scope selector with unit count pills, dedicated `[ EXAM PREP ]` `PYQ Practice` card, and 2-column mode cards.
  - **Analytics Screen**: Hero masthead with `[ • COURSE TELEMETRY ]` pill kicker, 4-metric `.statgrid` (`STREAK COUNT`, `TIME SPENT`, `AVG ACCURACY`, `TOTAL XP`) with color underline accents, and `CALIBRATION — CONFIDENCE VS ACCURACY` card with accuracy bars and telemetry graphs.

