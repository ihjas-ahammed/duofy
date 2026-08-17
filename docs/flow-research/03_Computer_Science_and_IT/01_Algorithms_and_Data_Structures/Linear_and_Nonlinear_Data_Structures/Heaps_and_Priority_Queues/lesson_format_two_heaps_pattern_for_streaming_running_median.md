# Duofy Reusable Lesson Format: Two-Heaps Pattern for Streaming Running Median

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Heaps_and_Priority_Queues`  
**Lesson Format Type:** `two_heaps_pattern_for_streaming_running_median`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid continuous stream partitioning, dual-priority-queue balancing, and online order statistics mastery (CLRS Chapter 6 & 9; Steven Skiena): master the **Two-Heaps Architecture** (**Max-Heap `leftHeap`** storing the smaller half of incoming numbers with $\text{max}(L) \le \text{min}(R)$, and **Min-Heap `rightHeap`** storing the larger half of numbers), formulate the **Size Equilibrium Invariant** ($\mathbf{|\text{size}(L) - \text{size}(R)| \le 1}$, keeping `leftHeap` with either equal size or exactly $+1$ element), prove that new number insertion runs in **$O(\log N)$ time** and median query runs in **instantaneous $O(1)$ time** ($\text{median} = L.\text{top()}$ if odd; $(\text{left}.\text{top}() + \text{right}.\text{top}()) / 2.0$ if even), and interact with live dynamic stream median visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Two-Heaps Dual Balance Invariant & O(1) Running Median Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Two-Heaps Stream Component & Algorithmic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Rebalancing Protocol When Heap Size Disparity Exceeds 1 Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Time Complexity of Finding the Current Median Using the Two-Heaps Structure (O(1)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Running Median Stream (Two Heaps) Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "two_heaps_pattern_for_streaming_running_median",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does the Two-Heaps algorithm maintain the running median of a data stream in O(log N) insert and O(1) query?",
      "blankAnswer": "Online Stream Order Statistics (Two-Heaps Pattern): (1) THE DUAL HEAP STRUCTURE: (a) Left Max-Heap: Stores the smaller 50% of elements (allows instant access to largest of small half). (b) Right Min-Heap: Stores the larger 50% of elements (allows instant access to smallest of large half). (2) THE 2 INVARIANTS: (a) Value Invariant: max(Left) <= min(Right). (b) Size Invariant: size(Left) == size(Right) OR size(Left) == size(Right) + 1. (3) INSERTION LOGIC (O(log N)): If num <= Left.top(), push to Left; else push to Right. If size(Left) > size(Right) + 1, pop Left.top() and push to Right. If size(Right) > size(Left), pop Right.top() and push to Left! (4) MEDIAN RETRIEVAL (O(1)): (a) If total elements odd: return Left.top(). (b) If total elements even: return (Left.top() + Right.top()) / 2.0! (5) EFFICIENCY: Eliminates O(N log N) full array re-sorting on every incoming stream item!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each component of the Two-Heaps Running Median algorithm to its exact purpose.",
      "matchPairs": [
        { "left": "Left Max-Heap", "right": "Holds the lower half of the data stream, exposing the largest lower element at the root" },
        { "left": "Right Min-Heap", "right": "Holds the upper half of the data stream, exposing the smallest upper element at the root" },
        { "left": "Odd Element Count Query", "right": "Directly returns the top element of the Left Max-Heap in instantaneous O(1) time" },
        { "left": "Even Element Count Query", "right": "Computes the arithmetic average of both heap roots (Left.top + Right.top) / 2.0 in O(1)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the Two-Heaps streaming median algorithm, what exact rebalancing action must be taken whenever inserting a new number causes size(Left Max-Heap) to become size(Right Min-Heap) + 2?",
      "options": [
        { "text": "Extract (pop) the maximum element from the Left Max-Heap and insert (push) it directly into the Right Min-Heap, restoring the size invariant so that size(Left) == size(Right) + 1", "isCorrect": true, "explanation": "Correct! The foundational invariant of the Two-Heaps streaming median algorithm is that the sizes of the two heaps must never differ by more than 1. Specifically, standard conventions maintain that either: 1. `size(Left) == size(Right)` (when the total count of elements is even), OR 2. `size(Left) == size(Right) + 1` (when the total count of elements is odd). If an incoming number is small, it gets pushed into the Left Max-Heap. If the Left Max-Heap now contains 2 more elements than the Right Min-Heap (`size(Left) == size(Right) + 2`), the median has shifted! The largest element in the Left Max-Heap (`Left.top()`) is popped and transferred into the Right Min-Heap (`Right.push(Left.pop())`). Both heaps are now balanced with `size(Left) == size(Right) + 1`, and the value invariant `max(Left) <= min(Right)` remains perfectly preserved." },
        { "text": "Delete all elements from the Right Min-Heap and rebuild from scratch", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Sort both heaps using quicksort in O(N^2) time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Do nothing because heaps do not need size balancing", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Using the Two-Heaps pattern, querying the current median of a dynamic stream of N numbers executes in O(___) time.",
      "blankAnswer": "1",
      "blankDistractors": ["log N", "N", "N log N"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Streaming Running Median (Two Heaps) Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Streaming Running Median (Two Heaps)</h3><p>Current Stream: <span id=\"stVals\" style=\"color:#94a3b8;\">[]</span></p><p>Median: <span id=\"medVal\" style=\"color:#10b981; font-size:1.3rem; font-weight:bold;\">-</span></p><div style=\"display:flex; gap:12px;\"><div style=\"border:1px solid #3b82f6; padding:8px; border-radius:4px;\">Left (Max-Heap): <span id=\"lHeap\" style=\"color:#38bdf8;\">[]</span></div><div style=\"border:1px solid #10b981; padding:8px; border-radius:4px;\">Right (Min-Heap): <span id=\"rHeap\" style=\"color:#4ade80;\">[]</span></div></div><div style=\"margin-top:10px;\"><button id=\"add5\" style=\"padding:6px 10px; margin:2px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">+ Add 5</button><button id=\"add15\" style=\"padding:6px 10px; margin:2px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">+ Add 15</button><button id=\"add1\" style=\"padding:6px 10px; margin:2px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">+ Add 1</button><button id=\"add3\" style=\"padding:6px 10px; margin:2px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">+ Add 3</button></div><script>let stream=[], L=[], R=[]; function addNum(x){stream.push(x); if(L.length===0||x<=L[0]){L.push(x); L.sort((a,b)=>b-a);} else{R.push(x); R.sort((a,b)=>a-b);} if(L.length>R.length+1){R.push(L.shift()); R.sort((a,b)=>a-b);} else if(R.length>L.length){L.push(R.shift()); L.sort((a,b)=>b-a);} update(); if(stream.length>=4&&window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');} function update(){document.getElementById('stVals').innerText='['+stream.join(', ')+']'; document.getElementById('lHeap').innerText='['+L.join(', ')+']'; document.getElementById('rHeap').innerText='['+R.join(', ')+']'; let med = (L.length>R.length)? L[0] : ((L[0]+R[0])/2.0); document.getElementById('medVal').innerText=med;} document.getElementById('add5').onclick=()=>addNum(5); document.getElementById('add15').onclick=()=>addNum(15); document.getElementById('add1').onclick=()=>addNum(1); document.getElementById('add3').onclick=()=>addNum(3);</script></div>"
    }
  ]
}
```
