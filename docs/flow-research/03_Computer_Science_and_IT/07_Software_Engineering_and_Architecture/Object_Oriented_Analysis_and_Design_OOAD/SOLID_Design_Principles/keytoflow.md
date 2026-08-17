# Key to Flow: SOLID Design Principles (SRP, OCP, LSP, ISP, & DIP)

**Subject Area:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Object_Oriented_Analysis_and_Design_OOAD / SOLID_Design_Principles`

---

## 📌 Core Concept & Mental Model
**Actor-Based Single Cohesion (SRP), Polymorphic Extension Invariance (OCP), Behavioral Contract Subtyping (Liskov Substitution LSP), Client-Specific Role Interfaces (ISP), and Architectural Abstraction Inversion (Dependency Inversion DIP)** govern robust, decoupled, and maintainable object-oriented software architecture (Robert C. Martin 2000 *Design Principles and Design Patterns*; Barbara Liskov & Jeannette Wing 1994 *A Behavioral Notion of Subtyping*, ACM TOPLAS; Bertrand Meyer *Object-Oriented Software Construction* 1988; Martin *Clean Architecture* 2017):
* **1. S — Single Responsibility Principle (SRP):**
  - *"A module should be responsible to one, and only one, actor (stakeholder/user group)."*
  - A class must have only **one reason to change**.
  - *Anti-Pattern:* An `Employee` class containing `calculatePay()` (CFO actor), `reportHours()` (COO actor), and `save()` (CTO database actor). If CFO modifies payroll logic, it riskily breaks COO timesheet reporting!
  - *Refactoring:* Separate into domain logic (`PayCalculator`), reporting (`HourReporter`), and persistence repository (`EmployeeRepository`).
* **2. O — Open/Closed Principle (OCP - Bertrand Meyer 1988):**
  - *"Software entities should be open for extension, but closed for modification."*
  - You must be able to extend system behavior by **adding new code**, without modifying existing tested source files.
  - *Mechanism:* Abstract strategy interfaces (e.g. `PaymentGateway`) where adding `CryptoPaymentGateway` requires zero modifications to the existing `CheckoutController`!
* **3. L — Liskov Substitution Principle (LSP - Barbara Liskov 1987 / Wing 1994):**
  - *"Subtypes must be substitutable for their base types without altering the correctness of the program."*
  - **The Behavioral Contract Invariants:**
    1. **Preconditions** cannot be strengthened in a subtype ($Pre_S \implies Pre_T$).
    2. **Postconditions** cannot be weakened in a subtype ($Post_S \implies Post_T$).
    3. **Invariants** of the supertype must be preserved.
  - *Classic Violation:* The **Square-Rectangle Problem** (A `Square` subclass inherits `setWidth(w)` and `setHeight(h)`. Setting `rect.setWidth(5)` and `rect.setHeight(10)` causes `rect.getArea()` to return 100 instead of 50, violating client assumptions!).
* **4. I — Interface Segregation Principle (ISP):**
  - *"Clients should not be forced to depend on methods that they do not use."*
  - Breaks monolithic "God Interfaces" into fine-grained, role-specific interfaces (e.g. splitting `MultiFunctionPrinter` into `Printer`, `Scanner`, and `Fax` interfaces).
* **5. D — Dependency Inversion Principle (DIP):**
  - *"High-level policy modules should not depend on low-level detail modules; both should depend on abstractions."*
  - Inverts traditional procedural dependency arrows: The business domain defines the interface (`OrderRepositoryInterface`), while the low-level database (`PostgresOrderRepository`) implements it (**Inversion of Control IoC** via Dependency Injection).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The SOLID Architectural Spectrum
* S $\to$ Cohesion & Actor Separation (1 Reason to Change).
* O $\to$ Polymorphic Extensibility (Interfaces/Abstract Classes).
* L $\to$ Behavioral Subtyping & Pre/Post Condition Contracts.
* I $\to$ Decoupled Interfaces (Role-specific vs Monolithic).
* D $\to$ Inversion of Control & Dependency Injection.

### 2. Top Recommended Resources
* **The Definitive Book:** *Clean Architecture: A Craftsman's Guide to Software Structure and Design* (Robert C. Martin, 2017).
* **The Academic Landmark:** *A Behavioral Notion of Subtyping* (Liskov & Wing, ACM TOPLAS 1994).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you identify the "actor" defining the single responsibility for a given class?
- [ ] Can you refactor a switch-statement conditional into an OCP-compliant strategy hierarchy?
- [ ] Can you mathematically prove why `Square extends Rectangle` violates the Liskov Substitution Principle?
- [ ] Can you trace how Dependency Inversion inverts the runtime dependency arrow between business logic and database drivers?
