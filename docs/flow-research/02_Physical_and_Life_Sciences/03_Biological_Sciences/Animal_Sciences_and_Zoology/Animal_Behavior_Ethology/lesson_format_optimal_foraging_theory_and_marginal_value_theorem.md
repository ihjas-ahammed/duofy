# Duofy Reusable Lesson Format: Optimal Foraging Theory and Marginal Value Theorem

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Animal_Sciences_and_Zoology / Animal_Behavior_Ethology`  
**Lesson Format Type:** `optimal_foraging_theory_and_marginal_value_theorem`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid quantitative, graphical, and evolutionary mastery of economic foraging decisions in behavioral ecology: formulate **Optimal Foraging Theory (OFT)** maximizing the net rate of energy gain per unit time ($R = \frac{E}{T_{\text{total}}}$), master the **Marginal Value Theorem (MVT, Eric Charnov, 1976)** predicting the optimal patch residence time ($t_{\text{opt}}$) in depleting resource patches with diminishing returns, apply the **Geometric Tangent Rule** (drawing a tangent from travel time $t_{\text{travel}}$ on the negative x-axis to the cumulative energy gain curve $E(t)$), prove that **longer travel times dictate longer patch residence times**, analyze diet breadth selection ($E_1/h_1 > E_2/h_2$), and interact with live graphical MVT patch departure decision simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Optimal Foraging & Marginal Value Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Foraging Concept & Economic Principle Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Travel Time Shift Effect on Patch Residence Time Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | MVT Graphical Tangent Maximization Target Rate Variable Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Marginal Value Theorem & Patch Departure Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "optimal_foraging_theory_and_marginal_value_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Marginal Value Theorem (MVT) in Optimal Foraging Theory, and how does travel time affect patch residence time?",
      "blankAnswer": "Optimal Foraging Theory (OFT) models foraging behavior as an evolutionary optimization problem maximizing the net rate of energy gain: R = E_net / (t_travel + t_patch). The Marginal Value Theorem (Eric Charnov, 1976) predicts when an animal should depart a depleting resource patch exhibiting diminishing returns (where the marginal rate of energy intake dE/dt continuously falls). The Tangent Rule: If you plot cumulative energy gain E(t) versus patch time t, and draw a straight line from the travel time on the negative x-axis (-t_travel) tangent to the gain curve, the slope of this line represents the maximum long-term rate of energy intake (R_max), and the point of tangency defines the optimal patch residence time (t_opt). Key Predictions: (1) Longer Travel Time: Shifts the x-intercept further left, flattening the tangent slope and forcing the forager to STAY LONGER in the patch (higher t_opt). (2) Poor Quality Patches: Cause foragers to leave sooner if better patches are readily accessible!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each optimal foraging concept to its behavioral economic description.",
      "matchPairs": [
        { "left": "Marginal Value Theorem (MVT)", "right": "A forager should leave a patch when the instantaneous rate of energy intake drops to the average rate for the entire habitat" },
        { "left": "Geometric Tangent Rule", "right": "Draw a tangent line from -t_travel to E(t_patch) to find the slope that maximizes overall energy intake rate R" },
        { "left": "Increased Travel Time (t_travel increases)", "right": "Forces the animal to spend a longer time exploiting each individual resource patch (t_opt increases)" },
        { "left": "Diet Breadth Model (Profitability E/h)", "right": "A predator should add lower-quality prey only if the encounter rate with higher-quality prey falls below a critical threshold" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "According to Charnov's Marginal Value Theorem, if the travel time between resource patches increases significantly (e.g. food patches become widely separated in a desert), what should happen to the optimal time a bird spends foraging in each patch?",
      "options": [
        { "text": "The bird should spend SIGNIFICANTLY MORE TIME in each patch (patch residence time t_opt increases); because traveling is costly and time-consuming, the forager must extract more cumulative energy from each visited patch (depleting it further down to a lower marginal gain rate) to maximize overall long-term energy efficiency", "isCorrect": true, "explanation": "Correct! Graphically in the Marginal Value Theorem, increasing travel time t_travel shifts the starting point on the horizontal axis further to the left. The tangent line from this distant point strikes the concave diminishing-returns curve further to the right, dictating a longer optimal residence time t_opt in the patch." },
        { "text": "The bird should leave each patch immediately after 1 second", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Patch residence time is completely independent of travel time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The bird should stop eating permanently", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Marginal Value Theorem, a forager should abandon a patch when its instantaneous rate of energy intake falls below the average ___ intake rate for the entire environment.",
      "blankAnswer": "energy",
      "blankDistractors": ["mass", "predation", "mating"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Marginal Value Theorem Decision Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Marginal Value Theorem (MVT) Foraging Engine</h3><p>Forager: Stork | Habitat: Marshland Patches | Diminishing Gain: $E(t) = 100(1 - e^{-0.1 t})$</p><button id=\"mvtBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate MVT Optimal Departure Time</button><div id=\"mvtOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('mvtBtn').onclick=()=>{document.getElementById('mvtOut').innerText='MVT Optimization: (1) Short Travel Time (t_travel = 5 min) -> Optimal Patch Residence Time t_opt = 12.4 min (Leaves at high marginal gain). (2) Long Travel Time (t_travel = 30 min) -> Optimal Patch Residence Time t_opt = 28.1 min (Forager exploits patch deeply!). Matches Charnov\\'s tangent rule exactly!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
