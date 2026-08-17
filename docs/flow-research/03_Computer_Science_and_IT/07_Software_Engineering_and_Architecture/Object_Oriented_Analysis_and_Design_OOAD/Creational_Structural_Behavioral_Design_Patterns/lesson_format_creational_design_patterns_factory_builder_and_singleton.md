# Duofy Reusable Lesson Format: Creational Design Patterns (Factory, Builder, and Singleton)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Object_Oriented_Analysis_and_Design_OOAD / Creational_Structural_Behavioral_Design_Patterns`  
**Lesson Format Type:** `creational_design_patterns_factory_builder_and_singleton`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the object instantiation decoupling, multi-parameter construction patterns, and thread-safe instance lifecycles of Creational Design Patterns (Erich Gamma et al. 1994 GoF; Eric Freeman & Elisabeth Robson *Head First Design Patterns* Chapter 4 & 5): master the **Factory Method Pattern** (defining an interface for object creation while letting subclasses decide which concrete product to instantiate), master the **Abstract Factory Pattern** (creating families of related/dependent products without coupling to concrete classes), master the **Builder Pattern** (separating complex multi-step object construction from representation, eliminating the telescoping constructor anti-pattern with fluent chaining), and master the **Thread-Safe Singleton Pattern** (analyzing why naive singletons fail under concurrency and proving why **Double-Checked Locking with a `volatile` instance variable** prevents CPU instruction reordering).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Creational Pattern Matrix, Factory vs Builder vs Singleton Intent Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of a Thread-Safe Double-Checked Locking Singleton Instantiation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Creational Design Pattern / Construction Mechanism & Problem Context Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Pattern That Replaces Telescoping Multi-Parameter Constructors with Step-by-Step Chaining Is the ___ Pattern (Builder) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Concurrency Analysis: Why Double-Checked Locking Requires the Volatile Keyword Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Creational Patterns (GoF 1994):
   - **The Creational Pattern Intent Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Pattern} & \textbf{Core Intent} & \textbf{Primary Problem Solved} \\
     \hline
     \mathbf{\text{Factory Method}} & \text{Subclasses decide concrete product} & \text{Decouples creator from concrete classes} \\
     \mathbf{\text{Abstract Factory}} & \text{Creates families of related products} & \text{Prevents mixing incompatible UI components} \\
     \mathbf{\text{Builder}} & \text{Step-by-step fluent construction} & \mathbf{\text{Eliminates telescoping constructors (10 params)}} \\
     \mathbf{\text{Singleton}} & \text{Guarantees exactly one global instance} & \text{Coordinates shared resource (DB pool/Logger)} \\
     \hline
     \end{array}$$
   - **Thread-Safe Double-Checked Locking Code:**
     ```java
     private static volatile DatabaseConnection instance;
     public static DatabaseConnection getInstance() {
       if (instance == null) {
         synchronized (DatabaseConnection.class) {
           if (instance == null) { instance = new DatabaseConnection(); }
         }
       }
       return instance;
     }
     ```
2. **Slide 2 (`ordering`):** Provide 5 steps of Double-Checked Locking Singleton execution: (1) thread enters getInstance() and checks if volatile instance is null without acquiring lock, (2) if null, thread enters synchronized block to acquire class-level mutex lock, (3) thread executes second null check inside lock to protect against race conditions, (4) thread instantiates object: allocates memory, executes constructor, and sets volatile reference, (5) lock is released and all subsequent threads immediately receive cached instance in first check with zero lock contention!
3. **Slide 3 (`matching`):** Pair 4 concepts (Factory Method, Abstract Factory, Builder, Singleton) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Builder pattern. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Double-Checked Locking requires `volatile`: In Java/C++, why does implementing the Singleton pattern with Double-Checked Locking require the instance variable to be declared `volatile`? (Creating a new object `new Helper()` is not an atomic operation—it consists of: 1. Allocate memory, 2. Run constructor, 3. Point reference to memory; **without `volatile`, modern compilers and CPU architectures can reorder instructions (executing 1 $\to$ 3 $\to$ 2), pointing the reference to uninitialized memory BEFORE the constructor finishes; a concurrent Thread B executing the first unsynchronized `if (instance == null)` check will see a non-null reference and attempt to use a partially constructed, corrupt object**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "creational_design_patterns_factory_builder_and_singleton",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: GoF Creational Design Patterns (Gamma et al. 1994)**\n• **Creational Pattern Intent Taxonomy (Freeman *Head First*):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Creational Pattern} & \\textbf{Instantiation Intent} & \\textbf{Solves Anti-Pattern} \\\\\n\\hline\n\\mathbf{\\text{Factory Method}} & \\text{Subclasses decide concrete product to instantiate} & \\text{Hard-coded } \\texttt{new ConcreteProduct()} \\\\\n\\mathbf{\\text{Abstract Factory}} & \\mathbf{\\text{Creates FAMILIES of related/dependent products}} & \\text{Mixing incompatible Mac \\& Windows UI widgets} \\\\\n\\mathbf{\\text{Builder}} & \\mathbf{\\text{Step-by-step construction of complex objects}} & \\mathbf{\\text{Telescoping constructor with 10 null parameters}} \\\\\n\\mathbf{\\text{Singleton}} & \\text{Guarantees exactly ONE class instance globally} & \\text{Uncontrolled access to shared Hardware/DB Pool} \\\\\n\\hline\n\\end{array}\n$$\n• **The Thread-Safe Double-Checked Locking Invariant:**\n  - Must use **`volatile` keyword** to prevent **CPU instruction reordering** during object allocation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when a thread invokes getInstance() in a Double-Checked Locking Singleton.",
      "orderItems": [
        "Thread enters getInstance() and performs the first unsynchronized check 'if (instance == null)' to avoid lock overhead",
        "If instance is null, the thread acquires the class-level synchronization mutex lock",
        "The thread executes the second null check 'if (instance == null)' inside the synchronized block to prevent race conditions",
        "The thread allocates memory, runs constructor, and safely publishes the reference to the volatile instance variable",
        "The thread exits the synchronized block, allowing all subsequent threads to bypass locking entirely via the first check"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Creational Design Pattern to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Factory Method", "right": "Virtual creation method in an abstract creator allowing subclasses to choose concrete product type" },
        { "left": "Abstract Factory", "right": "Interface producing entire product suites (e.g. MacButton + MacCheckbox) ensuring consistent theme styling" },
        { "left": "Builder Pattern", "right": "Fluent API constructing immutable objects incrementally with step methods before calling build()" },
        { "left": "Double-Checked Singleton", "right": "Thread-safe lazy initialization using dual null checks and volatile memory barriers to minimize lock contention" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The creational pattern that avoids telescoping constructors by enabling step-by-step method chaining is the ___ pattern.",
      "blankAnswer": "Builder",
      "blankDistractors": ["Factory", "Prototype", "Singleton"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In multi-threaded software engineering (e.g. Java/C++), why does the Double-Checked Locking Singleton pattern strictly require the instance reference to be declared with the 'volatile' keyword?",
      "options": [
        { "text": "Object instantiation (instance = new Singleton()) is a 3-step non-atomic sequence: (1) allocate memory, (2) execute constructor, and (3) assign reference to allocated address; without the volatile memory barrier, CPU and compiler optimizations can reorder execution into (1 -> 3 -> 2), assigning the reference before the constructor runs; a concurrent Thread B executing the first unsynchronized null check sees a non-null instance and immediately returns a partially constructed, corrupted object to the caller, causing unpredictable runtime crashes", "isCorrect": true, "explanation": "Correct! This is one of the most famous concurrency pitfalls in software engineering (Manson, Pugh, & Adve *The Java Memory Model*, POPL 2005; Goetz et al. *Java Concurrency in Practice*). 1. **The 3-Step Assembly Breakdown:** - `instance = new Singleton()` compiles to 3 distinct CPU operations: - Step 1: `mem = allocate_memory(sizeof(Singleton));` - Step 2: `ctor(mem);` (Initializes fields inside memory). - Step 3: `instance = mem;` (Sets pointer). 2. **The Out-of-Order Instruction Reordering:** - Under the as-if-serial semantics of single-threaded CPUs, the compiler is permitted to reorder Step 2 and Step 3: - Step 1: Allocate memory. - **Step 3: Point `instance` to memory address!** (Now `instance != null`). - Step 2: Execute constructor. 3. **The Race Condition Disaster:** - Thread A is between Step 3 and Step 2. - Thread B calls `getInstance()`. - Thread B executes the outer check: `if (instance == null)`. It evaluates to **FALSE** because `instance` already holds a memory address! - Thread B immediately returns `instance` and calls `instance.queryDatabase()`. - But Thread A has NOT finished initializing the fields yet! Thread B accesses uninitialized garbage memory $\\implies$ **Immediate System Crash!** 4. **The Volatile Solution:** The `volatile` keyword creates a **memory acquire-release barrier (happens-before relationship)**, strictly forbidding CPUs from reordering writes past the volatile assignment." },
        { "text": "Because volatile makes the program run 1,000 times faster", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because volatile prevents the operating system from deleting the source code", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Singletons are legally required to use volatile in all programming languages", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
