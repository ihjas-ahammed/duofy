# Duofy Reusable Lesson Format: Amdahl's Law and Multicore Speedup Limits

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / Process_Management_and_Concurrency / Threads_and_POSIX_Pthreads`  
**Lesson Format Type:** `amdahls_law_and_multicore_speedup_limits`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify theoretical multicore scaling bounds, serial fraction bottlenecks, and diminishing returns across Amdahl's Law and Gustafson's Law (Gene M. Amdahl 1967, *Validity of the Single Processor Approach to Achieving Large Scale Computing Capabilities*, AFIPS; John L. Gustafson 1988; Abraham Silberschatz et al. *Operating System Concepts* Chapter 4.1.4): master the closed-form **Amdahl's Law Speedup Formula ($\mathbf{S(N) = \frac{1}{(1 - p) + \frac{p}{N}}}$ where $p \in [0, 1]$ is the parallelizable fraction and $N$ is the number of CPU processing cores)**, evaluate the **Asymptotic Speedup Ceiling as $N \to \infty$ ($\mathbf{S_{\text{max}} = \frac{1}{1 - p}}$)** showing that the serial fraction $(1 - p)$ strictly limits maximum acceleration, calculate diminishing marginal returns from adding CPU cores, compare with **Gustafson-Barsis's Law for Scaled Speedup ($S(N) = N - (1-p)(N-1)$)**, and interact with live multicore CPU scaling and Amdahl asymptote simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Amdahl's Law Formula, Serial Fraction Bottleneck, & Asymptotic Ceiling Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Parallel Scaling Parameter / Law & Mathematical Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why a 5% Serial Fraction Caps Maximum Speedup at 20x Regardless of Core Count Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Name of the Parallel Scaling Law Formulated by Gene Amdahl in 1967 (Amdahl) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Amdahl's Law Multicore Scaling Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "amdahls_law_and_multicore_speedup_limits",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Amdahl's Law and how does the serial portion of an application limit maximum parallel speedup?",
      "blankAnswer": "Amdahl's Law & Parallel Scaling Limits (Gene Amdahl 1967; Silberschatz Chapter 4.1.4): (1) THE MATHEMATICAL FORMULA: Given parallel portion p (0 <= p <= 1), serial portion (1 - p), and N CPU cores: Speedup S(N) = 1 / ((1 - p) + (p / N))! (2) THE ASYMPTOTIC SPEEDUP CEILING: As the number of processors N approaches infinity (N -> infinity), the term p / N approaches 0: Max_Speedup = 1 / (1 - p)! (3) THE SERIAL BOTTLENECK: The serial portion (1 - p) strictly caps the maximum speedup achievable! Examples: (a) If 10% is serial (p = 0.90) -> Max speedup is 1 / 0.10 = 10x! (b) If 5% is serial (p = 0.95) -> Max speedup is 1 / 0.05 = 20x (even with 1,000,000 CPU cores)! (4) GUSTAFSON'S LAW (SCALED SPEEDUP - 1988): Observes that in practice, as processing power increases, problem sizes expand, increasing the parallel fraction p and allowing higher speedup S = N - (1 - p)(N - 1)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Parallel Computing scaling concept to its exact mathematical property.",
      "matchPairs": [
        { "left": "Amdahl's Speedup Formula: S(N)", "right": "1 / ((1 - p) + p/N); calculates overall speedup on a fixed workload using N parallel processors" },
        { "left": "Asymptotic Ceiling: 1 / (1 - p)", "right": "Upper mathematical limit on speedup as processor count N approaches infinity" },
        { "left": "Serial Portion (1 - p)", "right": "Inherently non-parallelizable code fraction (initialization, I/O, locks) that dictates scaling limits" },
        { "left": "Gustafson's Law (Scaled Speedup)", "right": "Considers workloads that scale up in size with more processors: S = N - (1 - p)(N - 1)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "An application has a serial fraction of 5% (meaning 95% of the execution time can be perfectly parallelized). What is the maximum theoretical speedup achievable by this application if we run it on a supercomputer with 1,000,000 CPU cores?",
      "options": [
        { "text": "At most 20x speedup; by Amdahl's Law, as N -> infinity, the maximum possible speedup is capped at 1 / (1 - p) = 1 / 0.05 = 20; even with one million processors, the 5% serial portion alone consumes 1/20th of the original baseline runtime and cannot be accelerated, capping total speedup at 20x", "isCorrect": true, "explanation": "Correct! This is the defining counter-intuitive lesson of Amdahl's Law (Silberschatz Section 4.1.4). 1. Given parameters: - Parallel portion $p = 0.95$. - Serial portion $(1 - p) = 0.05$ ($5\\%$). - Processor count $N = 1,000,000$. 2. Apply Amdahl's Law formula: $S(N) = \\frac{1}{(1 - p) + \\frac{p}{N}} = \\frac{1}{0.05 + \\frac{0.95}{1,000,000}} = \\frac{1}{0.05 + 0.00000095} = \\frac{1}{0.05000095} \\approx 19.9996\\times$. 3. As $N \\to \\infty$, the term $\\frac{p}{N} \\to 0$, giving the asymptotic ceiling: $S_{\\text{max}} = \\frac{1}{1 - p} = \\frac{1}{0.05} = 20\\times$. 4. Intuition: Suppose the original program took 100 seconds (5 seconds serial, 95 seconds parallel). On a supercomputer with infinite processors, the 95 parallel seconds vanish to 0 seconds. BUT the 5 serial seconds must still execute sequentially on a single core! Total runtime becomes 5 seconds. $\\text{Speedup} = \\frac{100\\text{ s}}{5\\text{ s}} = 20\\times$. You can NEVER exceed a $20\\times$ speedup regardless of how many millions of dollars are spent on additional hardware." },
        { "text": "1,000,000x speedup", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "950,000x speedup", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "95x speedup", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The famous 1967 law establishing that maximum speedup is bounded by the serial portion of an application is ___'s Law.",
      "blankAnswer": "Amdahl",
      "blankDistractors": ["Moore", "Metcalfe", "Little"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Amdahl's Law Multicore Scaling Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Amdahl's Law Scaling Calculator</h3><div style=\"margin-bottom:8px;\">Parallel Fraction (p): <input id=\"pVal\" type=\"range\" min=\"0.5\" max=\"0.99\" step=\"0.01\" value=\"0.90\" style=\"width:140px;\"> <span id=\"pDisp\" style=\"color:#38bdf8;\">0.90 (90%)</span></div><div style=\"margin-bottom:12px;\">Cores (N): <input id=\"nVal\" type=\"range\" min=\"1\" max=\"128\" step=\"1\" value=\"8\" style=\"width:140px;\"> <span id=\"nDisp\" style=\"color:#38bdf8;\">8 cores</span></div><div id=\"amdOut\" style=\"border:1px solid #475569; padding:12px; border-radius:6px; min-width:300px; font-family:monospace; color:#10b981;\">Calculating...</div><script>function calc(){let p=parseFloat(document.getElementById('pVal').value); let N=parseInt(document.getElementById('nVal').value); document.getElementById('pDisp').innerText=p.toFixed(2)+' ('+Math.round(p*100)+'%)'; document.getElementById('nDisp').innerText=N+' cores'; let s = 1.0 / ((1.0 - p) + (p / N)); let maxS = 1.0 / (1.0 - p); document.getElementById('amdOut').innerHTML='Speedup with '+N+' cores: <b>'+s.toFixed(2)+'x</b><br>Asymptotic Max (N -> ∞): <b>'+maxS.toFixed(2)+'x</b><br>Parallel Efficiency: '+((s/N)*100).toFixed(1)+'%'; if(N>=16 && window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');} document.getElementById('pVal').oninput=calc; document.getElementById('nVal').oninput=calc; calc();</script></div>"
    }
  ]
}
```
