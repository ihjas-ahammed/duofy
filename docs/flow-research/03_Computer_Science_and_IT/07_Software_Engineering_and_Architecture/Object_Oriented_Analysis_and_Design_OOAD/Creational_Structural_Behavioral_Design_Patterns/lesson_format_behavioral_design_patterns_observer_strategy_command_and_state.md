# Duofy Reusable Lesson Format: Behavioral Design Patterns (Observer, Strategy, Command, and State)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Object_Oriented_Analysis_and_Design_OOAD / Creational_Structural_Behavioral_Design_Patterns`  
**Lesson Format Type:** `behavioral_design_patterns_observer_strategy_command_and_state`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through decoupled object communication, runtime algorithm composition, reversible command encapsulation, and finite state machine transitions in Behavioral Design Patterns (Erich Gamma et al. 1994 GoF; Eric Freeman & Elisabeth Robson *Head First Design Patterns* Chapters 1, 2, 6, & 10): master the **Observer Pattern** (defining a 1-to-many publish-subscribe dependency so that when Subject state changes, all registered Observers are notified automatically via `update()`), master the **Strategy Pattern** (encapsulating a family of interchangeable algorithms behind a common interface, allowing runtime swapping of behavior), master the **Command Pattern** (encapsulating a request as an object containing `execute()` and `undo()` methods, enabling transaction logs, job queues, and multi-level undo/redo stacks), and master the **State Pattern** (allowing an object to alter its behavior when internal state changes by encapsulating state-specific transitions into distinct State classes without monolithic `switch (currentState)` statements).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Behavioral Pattern Matrix (Observer, Strategy, Command, State), Command Undo Stack Diagram | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of an Undoable Action via the Command Pattern History Stack Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Behavioral Design Pattern / Communication Construct & Architectural Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Pattern That Encapsulates a Request as an Object with `execute()` and `undo()` Methods Is the ___ Pattern (Command) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why the State Pattern Eliminates Fragile Monolithic Conditional Transitions Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Behavioral Patterns (GoF 1994; Freeman Ch 1, 2, 6, 10):
   - **The Behavioral Pattern Intent Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Behavioral Pattern} & \textbf{Core Intent} & \textbf{Key Methods / Classes} \\
     \hline
     \mathbf{\text{Observer}} & \text{1-to-many publish/subscribe notification} & \texttt{attach()}, \ \texttt{detach()}, \ \texttt{notify()} \\
     \mathbf{\text{Strategy}} & \text{Interchangeable algorithm family at runtime} & \texttt{setStrategy(Strategy s)}, \ \texttt{execute()} \\
     \mathbf{\text{Command}} & \mathbf{\text{Encapsulates request as object with undo/redo}} & \mathbf{\texttt{execute()}, \ \texttt{undo()}, \ \text{HistoryStack}} \\
     \mathbf{\text{State}} & \mathbf{\text{Alters behavior when internal state changes}} & \mathbf{\text{Context} \to \text{State interface (No } \texttt{switch}\text{!)}} \\
     \hline
     \end{array}$$
   - **The Command Pattern Undo Stack Invariant:**
     $$\mathbf{\text{History Stack: } [\text{Cmd}_1, \text{Cmd}_2, \text{Cmd}_3] \xrightarrow{\text{Undo}} \text{Cmd}_3.\text{undo}() \implies \text{Pristine state restored!}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of Command Pattern undo execution: (1) client configures ConcreteCommand with receiver object and parameter state, (2) invoker (e.g. GUI Button) triggers command.execute(), (3) command executes action on receiver and pushes itself onto the history stack, (4) user presses Ctrl+Z triggering invoker.undoLastCommand(), (5) invoker pops command from history stack and invokes command.undo() to reverse previous state!
3. **Slide 3 (`matching`):** Pair 4 concepts (Observer, Strategy, Command, State) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Command pattern. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how the State pattern eliminates conditional spaghetti: Why is refactoring a finite state machine (e.g. a Vending Machine or TCP connection) into the GoF State Pattern superior to managing transitions with a monolithic `switch (currentState)` statement in every class method? (In a switch-based implementation, every method in the class must contain a large `switch (currentState)` conditional with cases for every state; **adding a new state requires modifying and testing every single method in the class (violating OCP and inviting missed edge cases); the State pattern encapsulates all state-specific behaviors and transition logic into dedicated polymorphic State classes**, allowing new states to be added as isolated new classes without altering existing state transitions).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "behavioral_design_patterns_observer_strategy_command_and_state",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: GoF Behavioral Design Patterns (Gamma et al. 1994)**\n• **Behavioral Interaction \\& Decoupling Matrix (Freeman *Head First*):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Pattern} & \\textbf{Interaction Mechanism} & \\textbf{Primary Decoupling Goal} \\\\\n\\hline\n\\mathbf{\\text{Observer}} & \\text{1-to-many event notification via } \\texttt{notify()} & \\text{Decouples Subject from dynamic Subscriber list} \\\\\n\\mathbf{\\text{Strategy}} & \\text{Algorithm encapsulation behind shared Interface} & \\text{Enables runtime swapping of business rules} \\\\\n\\mathbf{\\text{Command}} & \\mathbf{\\text{Encapsulates request into object with } \\texttt{execute()}/\\texttt{undo()}} & \\mathbf{\\text{Enables transaction queues, logging, \\& undo stacks}} \\\\\n\\mathbf{\\text{State}} & \\mathbf{\\text{Encapsulates state transitions into State objects}} & \\mathbf{\\text{Eliminates monolithic } \\texttt{switch(state)} \\text{ conditionals}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Command History Stack Invariant:**\n$$\n\\mathbf{\\text{Execute: } \\text{Stack.push}(C) \\land C.\\text{execute}() \\qquad ; \\qquad \\text{Undo: } C_{\\text{top}} = \\text{Stack.pop}() \\land C_{\\text{top}}.\\text{undo}()}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when an action is executed and subsequently reversed using the Command Pattern.",
      "orderItems": [
        "Client instantiates a ConcreteCommand object, passing target Receiver references and state parameters",
        "An Invoker UI component (e.g. Button) triggers command.execute(), delegating work to the Receiver",
        "The executed command object saves pre-execution snapshot state and pushes itself onto the Command History Stack",
        "The user triggers the Undo action, causing the Invoker to pop the most recent command from the History Stack",
        "The popped command executes its undo() method, restoring the Receiver back to its exact prior state"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Behavioral Design Pattern to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Observer Pattern", "right": "Pub-Sub event mechanism notifying dynamic listener lists whenever subject state mutates" },
        { "left": "Strategy Pattern", "right": "Interchangeable algorithm objects injected into context classes to satisfy Open/Closed Principle" },
        { "left": "Command Pattern", "right": "Objectified method invocation encapsulating all parameters needed to execute or revert an action" },
        { "left": "State Pattern", "right": "Polymorphic state classes encapsulating finite state transitions without switch-case branching" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The behavioral pattern that encapsulates a request as an object with execute() and undo() methods is the ___ pattern.",
      "blankAnswer": "Command",
      "blankDistractors": ["Strategy", "Observer", "Iterator"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is refactoring a finite state machine (e.g. an Order Processing workflow: Pending -> Paid -> Shipped -> Delivered) into the GoF State Pattern superior to managing state transitions with monolithic switch statements?",
      "options": [
        { "text": "In a switch-based design, every single method in the context class must contain a large switch(currentState) block; adding a new state requires modifying and re-testing every single method across the entire class (violating OCP and risking missed transition edge cases); the State pattern encapsulates all state-specific behaviors and valid transition rules into independent polymorphic State classes, allowing new states to be introduced simply by creating a new class without touching existing state implementations", "isCorrect": true, "explanation": "Correct! This is Eric Freeman and Gang of Four's definitive demonstration of the State Pattern (Freeman *Head First Design Patterns* Chapter 10; Gamma et al. 1994). 1. **The Switch Statement Nightmare:** - Suppose an `Order` has 4 states: `Pending`, `Paid`, `Shipped`, `Delivered`. - The `Order` class has 5 actions: `pay()`, `cancel()`, `ship()`, `refund()`, `deliver()`. - Every action contains: ```java void ship() { switch(state) { case PENDING: throw new Error(\"Pay first!\"); case PAID: state = SHIPPED; break; case SHIPPED: throw new Error(\"Already shipped!\"); case DELIVERED: throw new Error(\"Already delivered!\"); } } ``` - If you add a 5th state (`Backordered`), you MUST open and edit **all 5 methods**! If you forget one switch case, your system has a silent logic bug. 2. **The State Pattern Solution:** - Create `interface OrderState { void pay(Order o); void ship(Order o); ... }`. - Create 4 classes: `PendingState`, `PaidState`, `ShippedState`, `DeliveredState`. - `Order.ship()` simply calls: `currentState.ship(this);`! 3. **The Result:** Zero switch statements, clean encapsulation of transition rules, and adding a `BackorderedState` is 100% Open/Closed compliant!" },
        { "text": "Because switch statements in modern CPUs are 1,000 times slower than method calls", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the State pattern allows computers to travel backwards in time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because switch statements can only be compiled on 16-bit systems", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
