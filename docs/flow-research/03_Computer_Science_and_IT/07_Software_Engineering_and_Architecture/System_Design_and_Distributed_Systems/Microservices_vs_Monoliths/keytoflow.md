# Key to Flow: Distributed Architecture (Microservices, DDD, Sagas, CQRS, & Strangler Fig)

**Subject Area:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / System_Design_and_Distributed_Systems / Microservices_vs_Monoliths`

---

## 📌 Core Concept & Mental Model
**Domain-Driven Bounded Context Boundaries (DDD & Database-per-Service), Event-Driven Distributed Transaction Management (Saga Pattern with Choreography/Orchestration & Compensating Actions), Read/Write Asymmetric Scalability (CQRS & Immutable Event Sourcing), and Incremental Legacy Decomposition (The Strangler Fig Pattern with API Gateway Routing)** govern enterprise distributed systems and microservice architectures (Chris Richardson 2018 *Microservices Patterns*; Sam Newman 2021 *Building Microservices* 2nd ed.; Eric Evans 2003 *Domain-Driven Design*; Martin Fowler *MonolithFirst* & *StranglerFigApplication*):
* **1. Monoliths vs Microservices & Domain-Driven Design (DDD):**
  - **Monolith:** Single deployable artifact with unified in-memory ACID database transactions. Simpler initially, but suffers from team scaling bottlenecks and deployment coupling as codebase grows.
  - **Microservices:** Independently deployable services organized around **DDD Bounded Contexts**.
  - **The Database-per-Service Rule:** Each microservice strictly encapsulates its private datastore (No shared database anti-pattern!). Inter-service communication occurs strictly via public APIs or asynchronous message streams.
* **2. Distributed Transactions: The Saga Pattern:**
  - Traditional 2-Phase Commit (2PC) is non-viable in cloud environments (blocking coordinator, synchronous locking, poor availability).
  - **The Saga Pattern:** A sequence of local transactions coordinated across services:
    $$\mathbf{\text{Local Tx 1 (OrderService)}} \to \mathbf{\text{Local Tx 2 (PaymentService)}} \to \mathbf{\text{Local Tx 3 (InventoryService)}}$$
    - **Choreography:** Services publish domain events; downstream services react autonomously without a central orchestrator.
    - **Orchestration:** A central **Saga Orchestrator** manages the state machine, sending command messages to participants.
    - **Compensating Transactions (Rollback):** If Step 3 fails (e.g. out of stock), the Saga triggers compensating undo actions in reverse: $\mathbf{\text{RefundPayment}} \to \mathbf{\text{CancelOrder}}$.
* **3. CQRS & Event Sourcing (ES):**
  - **CQRS (Command Query Responsibility Segregation):** Separates Write operations (**Commands** mutating domain state) from Read operations (**Queries** reading specialized denormalized projections).
  - **Event Sourcing (ES):** Persists the state of a domain entity as an **append-only immutable sequence of events** (`OrderCreated`, `ItemAdded`, `PaymentReceived`), enabling 100% complete audit trails, time-travel debugging, and zero-loss projection rebuilding.
* **4. Migration via The Strangler Fig Pattern (Martin Fowler):**
  - Avoids high-risk "Big Bang" rewrites.
  - Deploys an **API Gateway** in front of the legacy monolith.
  - Incrementally extracts bounded contexts into new microservices, configuring the API Gateway to route specific endpoint traffic to the new services while legacy traffic continues to the monolith, until the monolith is gradually "strangled" and safely decommissioned.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Distributed Systems Continuum
* Monolith vs Microservices $\to$ Shared Database Anti-Pattern $\to$ Database-per-Service.
* Data Consistency $\to$ 2PC Failure $\to$ Saga Pattern (Choreography vs Orchestration) + Compensating Transactions.
* Read/Write Scaling $\to$ CQRS + Event Sourcing (Append-Only Event Store $\to$ Materialized Views).
* Evolution $\to$ The Strangler Fig Pattern (API Gateway $\to$ Incremental Route Shifting).

### 2. Top Recommended Resources
* **The Definitive Book:** *Microservices Patterns: With examples in Java* (Chris Richardson, Manning 2018).
* **The Architectural Guide:** *Building Microservices: Designing Fine-Grained Systems* (Sam Newman, O'Reilly 2nd ed. 2021).
* **The Foundational Domain Guide:** *Domain-Driven Design: Tackling Complexity in the Heart of Software* (Eric Evans, Addison-Wesley 2003).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you map a business domain into DDD Bounded Contexts with Database-per-Service isolation?
- [ ] Can you trace a multi-service Saga transaction with forward steps and backward compensating rollbacks?
- [ ] Can you contrast Saga Choreography with Saga Orchestration?
- [ ] Can you diagram how the Strangler Fig pattern migrates a monolith to microservices via an API Gateway?
