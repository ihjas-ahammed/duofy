# Duofy Reusable Lesson Format: Elastic Rebound and Gutenberg-Richter Recurrence

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Seismology_and_Earthquake_Geophysics`  
**Lesson Format Type:** `elastic_rebound_and_gutenberg_richter_recurrence`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid geophysical, statistical, and hazard-forecasting mastery of earthquake source physics and frequency-magnitude scaling (Harry Fielding Reid 1910; Beno Gutenberg & Charles F. Richter 1944): master **Reid's Elastic Rebound Theory** (inter-seismic frictional locking $\to$ steady elastic strain accumulation in crustal rocks $\to$ overcoming static frictional strength $\to$ sudden dynamic rupture and rebound releasing stored elastic strain energy as seismic waves and permanent fault offset), formulate the **Gutenberg-Richter Recurrence Law ($\log_{10}N = a - bM$)**, interpret the global **$b$-value ($b \approx 1.0 \implies$ for every 1-unit increase in magnitude, there are $10\times$ fewer earthquakes)**, evaluate stress drops and seismic recurrence intervals, and interact with live elastic rebound and Gutenberg-Richter earthquake frequency simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Elastic Rebound Theory & Gutenberg-Richter Law Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Seismic Hazard Parameter & Geophysical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Gutenberg-Richter b-Value and Earthquake Frequency Ratio Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Universal Constant b-Value Magnitude Frequency Slope Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Elastic Rebound Cycle & Gutenberg-Richter Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "elastic_rebound_and_gutenberg_richter_recurrence",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Reid's Elastic Rebound Theory and how does the Gutenberg-Richter Law quantify earthquake frequency?",
      "blankAnswer": "Earthquake mechanics and statistical seismology combine source physics with power-law distributions: (1) REID'S ELASTIC REBOUND THEORY (Harry Fielding Reid 1910, formulated after the 1906 San Francisco earthquake): Relative tectonic plate motion applies continuous shear stress across a locked fault zone. Frictional resistance ('stick-slip' mechanics) prevents continuous sliding, causing crustal rock on both sides of the fault to deform elastically like a bending wooden ruler. Over decades to centuries, immense elastic strain energy accumulates. When tectonic shear stress finally exceeds the static frictional shear strength of the fault asperities, the fault ruptures catastrophically. The strained rock snaps back ('rebounds') into an unstrained shape, releasing the stored elastic energy as radiated seismic waves and permanent surface offset (slip). (2) THE GUTENBERG-RICHTER RECURRENCE LAW (1944): In any seismically active region, the cumulative number of earthquakes (N) with magnitude >= M follows a universal power-law: log10(N) = a - b*M (where 'a' describes overall regional seismic productivity, and 'b' is the slope). Across the globe, b is remarkably constant at b ≈ 1.0! This means for every 1-unit increase in earthquake magnitude, there are exactly 10 times fewer earthquakes (e.g. for every single M 7.0 earthquake, a region experiences ~10 M 6.0 events, ~100 M 5.0 events, and ~1,000 M 4.0 events)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each earthquake recurrence concept to its geophysical definition.",
      "matchPairs": [
        { "left": "Elastic Rebound Theory (Reid 1910)", "right": "Model stating that earthquakes result from the sudden release of elastic strain accumulated across locked faults" },
        { "left": "Gutenberg-Richter Law (log N = a - bM)", "right": "Empirical power-law relationship describing the frequency of earthquakes as a function of magnitude" },
        { "left": "The b-Value (~1.0)", "right": "Universal scaling parameter dictating a tenfold drop in earthquake frequency per integer magnitude increase" },
        { "left": "Stick-Slip Friction", "right": "Frictional mechanics where faults remain locked until static friction fails, causing sudden dynamic slip" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A regional seismic monitoring network in California records approximately 1,000 magnitude 3.0 earthquakes in a given year. If the region follows the standard Gutenberg-Richter law with a typical b-value of b = 1.0, approximately how many magnitude 6.0 earthquakes should the region expect per year?",
      "options": [
        { "text": "1 magnitude 6.0 earthquake per year; because each unit increase in magnitude reduces frequency by a factor of 10 (10^(b*Delta M)), an increase of 3 magnitude units (from M 3.0 to M 6.0) reduces the frequency by a factor of 10³ = 1,000 (1,000 / 1,000 = 1)", "isCorrect": true, "explanation": "Correct! The Gutenberg-Richter law is written as log10(N) = a - b*M, which can be rearranged in ratio form between two magnitudes M1 and M2 as: N(M2) / N(M1) = 10^(-b*(M2 - M1)). Here, M1 = 3.0, M2 = 6.0, Delta M = 3.0, and b = 1.0. Therefore: N(6.0) = N(3.0) × 10^(-1.0 × 3.0) = 1,000 × 10^(-3) = 1,000 × (1/1000) = 1 earthquake per year. This demonstrates the immense predictive power of the Gutenberg-Richter law in probabilistic seismic hazard assessment (PSHA)." },
        { "text": "100 magnitude 6.0 earthquakes per year", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Zero earthquakes ever again", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "10,000 magnitude 6.0 earthquakes per year", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Gutenberg-Richter recurrence relationship (log N = a - b*M), the universal slope constant characterizing the global frequency-magnitude distribution is approximately b = ___.",
      "blankAnswer": "1.0",
      "blankDistractors": ["0.1", "5.0", "10.0"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Elastic Rebound & Gutenberg-Richter Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Elastic Rebound & Gutenberg-Richter Seismology Engine</h3><p>Fault State: Locked | Tectonic Strain Accumulating: 30 mm/year</p><button id=\"rebBtn\" style=\"padding:8px 16px; margin:4px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Trigger Elastic Rebound Rupture</button><button id=\"grBtn\" style=\"padding:8px 16px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Gutenberg-Richter Distribution</button><div id=\"seisOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Seismic Engine Ready...</div><script>document.getElementById('rebBtn').onclick=()=>{document.getElementById('seisOut').innerText='Elastic Rebound Triggered: Static friction breached -> 4.5 meters coseismic slip along 300 km fault segment -> Mw 7.8 Megathrust Earthquake! Stored strain released!';}; document.getElementById('grBtn').onclick=()=>{document.getElementById('seisOut').innerText='Gutenberg-Richter (b=1.0): Per 10,000 M2 events -> 1,000 M3 -> 100 M4 -> 10 M5 -> 1 M6 -> 0.1 M7 (1 every 10 years)! Power-law scaling confirmed!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
