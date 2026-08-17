# Duofy Reusable Lesson Format: Template Method and Composite Patterns (The Hollywood Principle)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Object_Oriented_Analysis_and_Design_OOAD / Creational_Structural_Behavioral_Design_Patterns`  
**Lesson Format Type:** `template_method_and_composite_patterns_the_hollywood_principle`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify framework design inversion, recursive hierarchical tree processing, and pattern selection trade-offs (Erich Gamma et al. 1994 GoF; Eric Freeman & Elisabeth Robson *Head First Design Patterns* Chapters 8 & 9): master the **Template Method Pattern** (defining the invariant skeleton of an algorithm in a base class `final` method while deferring concrete steps or hooks to abstract subclass methods, embodying **The Hollywood Principle: "Don't call us, we'll call you"**), contrast Template Method (inheritance-based algorithmic invariance) with the Strategy Pattern (composition-based algorithmic interchangeability), master the **Composite Pattern** (structuring objects into tree hierarchies to represent part-whole structures, allowing clients to treat individual leaf elements e.g. `File` and composite branches e.g. `Directory` uniformly via a shared component interface), and interact with live GoF Pattern Selection matrix, Observer pub-sub event flow, and Command Undo/Redo stack simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Template Method Hollywood Principle Flow, Composite Tree Hierarchy Diagram Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Design Pattern Scenario / Structural Challenge & Optimal GoF Pattern Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Template Method Enforces the Hollywood Principle by Controlling Execution Flow in the Base Class Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Architectural Principle Where High-Level Frameworks Call Low-Level Components Is the ___ Principle (Hollywood) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Design Patterns Studio: Observer Pub-Sub, Command Undo/Redo & Composite Tree Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "template_method_and_composite_patterns_the_hollywood_principle",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Template Method pattern (Hollywood Principle), and how does the Composite pattern handle tree hierarchies?",
      "blankAnswer": "Advanced GoF Patterns (Gamma et al. 1994): (1) TEMPLATE METHOD: Base class defines the invariant skeleton of an algorithm in a non-overridable (final) method (e.g. step1() -> step2() -> step3()) and defers implementation of specific steps to abstract methods in subclasses. (2) THE HOLLYWOOD PRINCIPLE: 'Don't call us, we'll call you.' High-level base classes call low-level subclass operations, never vice-versa! (3) COMPOSITE PATTERN: Composes objects into tree structures to represent Part-Whole hierarchies. Both Leaf (File) and Composite (Directory containing sub-files/directories) implement the same Component interface (e.g. getSize(), display()). Clients treat single items and entire tree branches identically with zero 'if (isFolder)' checks!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Software Architecture Challenge to its Optimal GoF Design Pattern.",
      "matchPairs": [
        { "left": "Building a recursive GUI component tree (Panels containing Buttons & Panels)", "right": "Composite Pattern - Treats individual leaves and container branches uniformly" },
        { "left": "Data mining pipeline where extraction and cleanup are fixed but parsing varies", "right": "Template Method Pattern - Fixes algorithm skeleton in base class while deferring parsing" },
        { "left": "Supporting reversible document formatting actions (Bold, Italic, Delete)", "right": "Command Pattern - Encapsulates actions into objects with push/pop history stack" },
        { "left": "UI stock ticker updating multiple independent chart windows in real time", "right": "Observer Pattern - Broadcasts state change notifications to registered listeners" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the Template Method pattern embody the 'Hollywood Principle' (Don't call us, we'll call you), and how does this fundamentally invert standard procedural control flow?",
      "options": [
        { "text": "In traditional procedural programming, low-level custom code actively calls high-level utility libraries when needed; under the Template Method pattern, the high-level base class controls the master algorithm execution flow (the template method) and decides when to invoke the low-level subclass hooks and abstract steps; low-level components provide specific implementations but never directly control or invoke the overarching algorithm lifecycle", "isCorrect": true, "explanation": "Correct! This is Eric Freeman and Gang of Four's explanation of Inversion of Control in framework design (Freeman *Head First Design Patterns* Chapter 8; Gamma et al. 1994). 1. **The Traditional Procedural Model:** - You write a custom script: `val data = load(); val cleaned = Utility.clean(data); Utility.save(cleaned);`. - Your low-level code is in charge, calling the library when it wants. 2. **The Hollywood Framework Model (Template Method):** - The base class defines: ```java public final void processPipeline() { loadData(); validateData(); // Hook customParse(); // Abstract step subclass MUST implement writeData(); } ``` - The high-level base class owns `processPipeline()`. - The subclass implements only `customParse()`. - When the framework runs, the **base class calls your subclass method**! You do not call the framework; the framework calls you! 3. **The Architectural Benefit:** Prevents dependency rot and guarantees that critical lifecycle invariants (like authentication, error logging, and resource cleanup) are always executed in the exact correct order without relying on developer memory." },
        { "text": "Because Template Method only runs on computers located in California", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Hollywood Principle requires software to display movie animations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Template Method deletes all subclasses after execution", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The framework design principle stating 'Don't call us, we'll call you' is the ___ principle.",
      "blankAnswer": "Hollywood",
      "blankDistractors": ["Solid", "Dry", "Yagni"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Design Patterns Studio: Observer, Command & Composite",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>GoF Design Patterns Studio</h3><p>Architecture: <b style=\"color:#38bdf8;\">Observer Events & Command Undo Stack</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnObs\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Fire Observer Event</button><button id=\"btnCmd\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Execute Command & Push</button><button id=\"btnUndo\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Pop Stack & Undo</button></div><div id=\"patLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to trigger Observer publish/subscribe event...</div><script>document.getElementById('btnObs').onclick=()=>{document.getElementById('patLog').innerHTML='<b>1. OBSERVER PUBLISH / SUBSCRIBE:</b><br>• Subject.setState(\"PRICE_UPDATED: $142.50\")<br>• Broadcasted to 3 registered observers:<br>  - [ChartWidget] &rarr; Redrawn candlestick<br>  - [EmailAlertService] &rarr; Notification dispatched<br>  - [AuditLogger] &rarr; Logged to disk';}; document.getElementById('btnCmd').onclick=()=>{document.getElementById('patLog').innerHTML='<b>2. COMMAND PATTERN EXECUTE:</b><br>• ChangeFontCommand(size=24pt).execute()<br>• Pushed Command to History Stack [Depth: 1]<br>• Receiver TextCanvas updated font size!';}; document.getElementById('btnUndo').onclick=()=>{document.getElementById('patLog').innerHTML='<b>3. COMMAND PATTERN UNDO:</b><br>• Popped ChangeFontCommand from History Stack<br>• Executed command.undo() &rarr; Restored size=12pt<br>🎉 <b style=\"color:#10b981;\">Pristine state restored seamlessly via Command Stack!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
