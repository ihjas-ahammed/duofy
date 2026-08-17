# Key to Flow: GoF Design Patterns (Creational, Structural, & Behavioral)

**Subject Area:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Object_Oriented_Analysis_and_Design_OOAD / Creational_Structural_Behavioral_Design_Patterns`

---

## 📌 Core Concept & Mental Model
**Encapsulated Object Instantiation (Creational: Factory Method, Abstract Factory, Builder, Singleton), Composition-Based Interface Adaptation & Augmentation (Structural: Adapter, Decorator, Facade, Composite, Proxy), and Loosely Coupled Communication & Control Flow (Behavioral: Observer, Strategy, Command, State, Template Method / Hollywood Principle)** govern Gang of Four (GoF) object-oriented design patterns (Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides 1994 *Design Patterns: Elements of Reusable Object-Oriented Software*; Eric Freeman & Elisabeth Robson *Head First Design Patterns*):
* **1. Creational Patterns (Object Instantiation Decoupling):**
  - **Factory Method:** Subclasses decide which concrete class to instantiate via virtual factory methods.
  - **Abstract Factory:** Creates families of related/dependent objects (e.g. `MacButton`, `MacCheckbox` vs `WinButton`, `WinCheckbox`) without coupling to concrete classes.
  - **Builder:** Separates the complex step-by-step construction of an object from its representation (`User.builder().name("Alice").age(30).build()`).
  - **Singleton:** Enforces exactly one class instance with global access point (Double-Checked Locking with `volatile` instance to prevent instruction reordering).
* **2. Structural Patterns (Class & Object Composition):**
  - **Adapter:** Bridges incompatible interfaces by wrapping an adaptee in a target interface wrapper (e.g. converting `XMLService` into `JSONParser`).
  - **Decorator:** Recursively wraps an object to dynamically add runtime responsibilities without modifying original source code (e.g. `new GzipOutputStream(new BufferedOutputStream(new FileOutputStream()))`).
  - **Facade:** Exposes a simple high-level interface hiding a complex messy subsystem (e.g. `HomeTheaterFacade.watchMovie()` coordinating projector, amplifier, screen, lights).
  - **Composite:** Composes objects into tree structures representing part-whole hierarchies; allows clients to treat individual objects (`File`) and groups (`Directory`) uniformly via shared interface.
  - **Proxy:** Controls access to an object via a surrogate placeholder (Lazy Loading Virtual Proxy, Remote RPC Proxy, Protection Proxy).
* **3. Behavioral Patterns (Object Communication & Responsibility):**
  - **Observer:** One-to-many publish-subscribe event notification; when Subject state changes, all registered Observers update automatically (`subject.notifyObservers()`).
  - **Strategy:** Encapsulates interchangeable algorithm families behind a common interface; enables runtime algorithm switching (e.g. `SortStrategy`, `CompressionStrategy`).
  - **Command:** Encapsulates an action/request as an object (`execute()`, `undo()`); enables request queuing, undo/redo stacks, and macro recording.
  - **State:** Allows an object to alter its behavior when internal state changes, encapsulating finite state machines into dedicated State objects without monolithic `switch(state)` blocks.
  - **Template Method:** Outlines algorithmic skeleton in a base class, deferring specific steps to subclasses (**The Hollywood Principle: "Don't call us, we'll call you"**).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Pattern Intent Taxonomy
* Creational $\to$ How objects are created (Hiding `new`).
* Structural $\to$ How classes/objects are composed (Wrappers & Trees).
* Behavioral $\to$ How objects communicate & divide algorithms (Decoupled Interactions).
* Golden Rule $\to$ "Favor Object Composition over Class Inheritance" & "Program to an Interface, not an Implementation".

### 2. Top Recommended Resources
* **The Original Bible:** *Design Patterns: Elements of Reusable Object-Oriented Software* (Gamma, Helm, Johnson, Vlissides, Addison-Wesley 1994).
* **The Visual Guide:** *Head First Design Patterns* (Eric Freeman & Elisabeth Robson, O'Reilly 2nd ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you contrast Abstract Factory (family creation) with Factory Method (single method)?
- [ ] Can you distinguish Decorator (adds behavior) from Adapter (changes interface) and Proxy (controls access)?
- [ ] Can you diagram the Command pattern's undo/redo execution stack?
- [ ] Can you explain why Template Method embodies the Hollywood Principle?
