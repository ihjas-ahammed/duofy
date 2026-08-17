# Duofy Reusable Lesson Format: Structural Design Patterns (Adapter, Decorator, Facade, and Proxy)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Object_Oriented_Analysis_and_Design_OOAD / Creational_Structural_Behavioral_Design_Patterns`  
**Lesson Format Type:** `structural_design_patterns_adapter_decorator_facade_and_proxy`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through composition-based interface transformation, dynamic behavior augmentation, subsystem encapsulation, and access control wrappers in Structural Design Patterns (Erich Gamma et al. 1994 GoF; Eric Freeman & Elisabeth Robson *Head First Design Patterns* Chapters 3, 7, & 11): master the **Adapter Pattern** (converting the incompatible interface of an Adaptee into the Target interface expected by clients), master the **Decorator Pattern** (attaching additional responsibilities to an object dynamically via recursive composition wrappers, satisfying OCP without class explosion e.g. Java I/O Streams), master the **Facade Pattern** (providing a simplified unified high-level interface over a complex subsystem of interdependent classes), and master the **Proxy Pattern** (providing a surrogate placeholder to control access to a target object: **Virtual Proxy [lazy loading], Remote Proxy [RPC stubs], and Protection Proxy [RBAC authorization]**).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Structural Wrapper Taxonomy (Adapter vs Decorator vs Facade vs Proxy) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Recursive Execution Through a Chain of Wrapped Decorator Objects Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Structural Design Pattern / Wrapper Category & Architectural Intent Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Pattern That Dynamically Adds Responsibilities to an Object via Recursive Wrapping Is the ___ Pattern (Decorator) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Comparative Analysis: How Adapter, Decorator, and Proxy Differ in Intent Despite Identical Wrapper Structures Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Structural Patterns (GoF 1994; Freeman Ch 3, 7, 11):
   - **The Wrapper Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Structural Pattern} & \textbf{Interface Modification} & \textbf{Behavioral Change} & \textbf{Core Intent} \\
     \hline
     \mathbf{\text{Adapter}} & \mathbf{\text{CHANGES interface}} & \text{Preserves existing behavior} & \text{Bridges incompatible APIs} \\
     \mathbf{\text{Decorator}} & \mathbf{\text{PRESERVES interface}} & \mathbf{\text{ADDS new responsibilities}} & \text{Dynamic runtime augmentation} \\
     \mathbf{\text{Facade}} & \mathbf{\text{SIMPLIFIES interface}} & \text{Coordinates subsystem} & \text{Hides complex multi-class wiring} \\
     \mathbf{\text{Proxy}} & \mathbf{\text{PRESERVES interface}} & \mathbf{\text{CONTROLS object access}} & \text{Lazy loading / Security / Remote RPC} \\
     \hline
     \end{array}$$
   - **The Decorator Composition Invariant:**
     $$\mathbf{\texttt{new CompressionDecorator(new EncryptionDecorator(new FileDataSource(\"data.txt\"))) } \implies \text{Open/Closed!}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of Decorator recursive execution: (1) client invokes writeData() on outermost CompressionDecorator wrapper, (2) CompressionDecorator compresses byte stream in memory, (3) CompressionDecorator forwards compressed bytes to inner EncryptionDecorator via wrapped interface, (4) EncryptionDecorator encrypts bytes with AES key, (5) EncryptionDecorator forwards cipher bytes to core FileDataSource which writes raw bytes to disk!
3. **Slide 3 (`matching`):** Pair 4 concepts (Adapter, Decorator, Facade, Proxy) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Decorator pattern. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on distinguishing Adapter, Decorator, and Proxy: In object-oriented software architecture, the Adapter, Decorator, and Proxy patterns often have nearly identical UML class structures (each wraps an underlying object); how do their underlying architectural intents fundamentally differ? (An **Adapter** changes an incompatible interface to match what a client expects without adding new behavior; a **Decorator** preserves the exact same interface while dynamically adding new behaviors or responsibilities to an object at runtime; a **Proxy** preserves the exact same interface while controlling access to the underlying object (such as deferring expensive instantiation via lazy loading, checking security permissions, or handling network communication across a remote RPC boundary)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "structural_design_patterns_adapter_decorator_facade_and_proxy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: GoF Structural Patterns — The Wrapper Taxonomy (Gamma et al. 1994)**\n• **Comparative Wrapper Architecture Matrix (Freeman *Head First*):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Pattern} & \\textbf{Interface Relationship} & \\textbf{Behavior Modification} & \\textbf{Primary Architectural Intent} \\\\\n\\hline\n\\mathbf{\\text{Adapter}} & \\mathbf{\\text{CHANGES Interface}} & \\text{Preserves core logic} & \\text{Bridges incompatible 3rd-party APIs} \\\\\n\\mathbf{\\text{Decorator}} & \\mathbf{\\text{PRESERVES Interface}} & \\mathbf{\\text{ADDS Dynamic Behavior}} & \\mathbf{\\text{Extends responsibilities without subclassing}} \\\\\n\\mathbf{\\text{Facade}} & \\mathbf{\\text{SIMPLIFIES Interface}} & \\text{Orchestrates subsystem} & \\text{Hides complex multi-service interactions} \\\\\n\\mathbf{\\text{Proxy}} & \\mathbf{\\text{PRESERVES Interface}} & \\mathbf{\\text{CONTROLS Object Access}} & \\mathbf{\\text{Lazy loading, security guards, remote RPC}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Decorator Composition Invariant:**\n  - Replaces exponential class inheritance explosion with **recursive object wrapping**:\n$$\n\\mathbf{\\texttt{new BufferedStream(new GzipStream(new CryptoStream(new FileStream())))}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when data flows through a chained Decorator wrapper hierarchy during a file write operation.",
      "orderItems": [
        "The client application invokes writeData() on the outermost CompressionDecorator instance",
        "The CompressionDecorator executes its compression algorithm on the payload bytes",
        "The CompressionDecorator forwards the compressed payload to the wrapped EncryptionDecorator via the shared DataSource interface",
        "The EncryptionDecorator encrypts the compressed bytes using an AES cryptographic key",
        "The EncryptionDecorator delegates the final encrypted byte stream to the core FileDataSource which commits bytes to physical disk"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Structural Design Pattern to its exact Architectural Purpose.",
      "matchPairs": [
        { "left": "Adapter Pattern", "right": "Converts incompatible legacy interface signatures into client-expected target contracts" },
        { "left": "Decorator Pattern", "right": "Dynamically attaches responsibilities to objects at runtime using recursive composition wrappers" },
        { "left": "Facade Pattern", "right": "Exposes a clean unified high-level interface to simplify interaction with a complex subsystem" },
        { "left": "Virtual Proxy", "right": "Surrogate placeholder deferring instantiation of expensive heavyweight objects until first accessed" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The structural pattern that attaches dynamic responsibilities to an object via recursive wrapping is the ___ pattern.",
      "blankAnswer": "Decorator",
      "blankDistractors": ["Adapter", "Facade", "Bridge"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In object-oriented software engineering, the Adapter, Decorator, and Proxy patterns often share identical structural composition (each wraps an underlying object); how do their underlying architectural intents fundamentally differ?",
      "options": [
        { "text": "An Adapter converts an incompatible interface into a target interface expected by clients without altering underlying behavior; a Decorator retains the exact same interface while dynamically augmenting the wrapped object with new runtime responsibilities (e.g. compression, encryption); a Proxy retains the exact same interface while controlling access to the underlying object (such as deferring expensive instantiation via lazy loading, checking security authorization, or managing network RPC serialization)", "isCorrect": true, "explanation": "Correct! This is one of the classic conceptual distinctions emphasized in Gang of Four design patterns (Gamma et al. 1994; Freeman *Head First Design Patterns* Chapter 7 & 11). 1. **The Structural Similarity:** - All three patterns use composition: Class `Wrapper` holds a reference `target` and implements a method `doWork() { target.doWork(); }`. - If you look only at the UML diagram without reading the method contracts, they look almost identical! 2. **The Crucial Distinction in INTENT:** - **Adapter:** Intent is *Translation*. The client expects `interface Target { void request(); }` but the legacy class has `class Adaptee { void specificRequest(); }`. The adapter translates the method call. - **Decorator:** Intent is *Enhancement*. The client has `interface Coffee { double cost(); }`. `MilkDecorator` wraps `SimpleCoffee` to add $\\$0.50$ to the cost. The interface NEVER changes, but the behavior is enhanced! - **Proxy:** Intent is *Access Control*. `HighResImageProxy` wraps `RealImage`. It doesn't change the interface and it doesn't add coffee toppings; it simply waits until `display()` is called before loading the $500\\text{ MB}$ image from disk (Lazy Loading Virtual Proxy). 3. **The Golden Rule:** Design patterns are classified by **INTENT**, not by static structure!" },
        { "text": "Because Adapter is for databases, Decorator is for UI, and Proxy is for operating systems", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Proxy patterns can only be executed on multi-core computers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Decorators require deleting the base class", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
