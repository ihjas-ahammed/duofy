# Key to Flow: Derived Functors (Tor and Ext) (Homological Algebra)

**Subject Area:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Homological_Algebra / Derived_Functors_Tor_and_Ext`

---

## 📌 Core Concept & Mental Model
In algebra, fundamental functors like Tensor Product ($- \otimes_R B$) and Hom ($\text{Hom}_R(A, -)$) are only **half-exact**:
* $- \otimes_R B$ is **right-exact** (preserves cokernels, but destroys injectivity).
* $\text{Hom}_R(A, -)$ is **left-exact** (preserves kernels, but destroys surjectivity).

**Derived Functors** ($\text{Tor}_n^R(A, B)$ and $\text{Ext}_R^n(A, B)$) serve as **exactness error-correcting codes**. They measure the failure of exactness and repair short exact sequences into infinite **Long Exact Sequences**:
* **$\text{Tor}_1^R(A, B)$:** Measures "torsion" and failure of flatness.
* **$\text{Ext}_R^1(A, B)$:** Parametrizes module extensions $0 \to B \to E \to A \to 0$ and failure of projectivity/injectivity.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Resolution Pipeline (How to Compute)
1. **Choose a Resolution:**
   * For **Left Derived Functors** ($L_n F$, e.g., $\text{Tor}_n$): Replace $A$ with a **projective resolution** $\dots \to P_1 \to P_0 \to A \to 0$.
   * For **Right Derived Functors** ($R^n F$, e.g., $\text{Ext}^n$): Replace $B$ with an **injective resolution** $0 \to B \to I^0 \to I^1 \to \dots$ (or resolve $A$ projectively).
2. **Drop the Module:** Remove $A$ (or $B$) to form a punctured chain complex $P_\bullet$.
3. **Apply the Functor:** Compute $F(P_\bullet) = P_\bullet \otimes_R B$ (or $\text{Hom}_R(P_\bullet, B)$).
4. **Take Homology:** $\text{Tor}_n^R(A, B) = H_n(P_\bullet \otimes_R B)$, and $\text{Ext}_R^n(A, B) = H^n(\text{Hom}_R(P_\bullet, B))$.

### 2. Core Symmetries & Vanishing Theorems
* **Projective / Injective / Flat Vanishing:**
  * $A$ is projective $\iff \text{Ext}_R^1(A, B) = 0$ for all $B$.
  * $B$ is injective $\iff \text{Ext}_R^1(A, B) = 0$ for all $A$.
  * $A$ is flat $\iff \text{Tor}_1^R(A, B) = 0$ for all $B$.
* **Dimension Drop for PIDs:** Over a Principal Ideal Domain (like $\mathbb{Z}$ or $k[x]$), every submodule of a free module is free. Therefore, projective resolutions terminate at step 1:
  $$\text{Tor}_n^R(A, B) = 0 \quad \text{and} \quad \text{Ext}_R^n(A, B) = 0 \quad \text{for all } n \ge 2.$$

### 3. Canonical $\mathbb{Z}$-Module (Abelian Group) Calculations
* $\text{Tor}_1^{\mathbb{Z}}(\mathbb{Z}/m\mathbb{Z}, \mathbb{Z}/n\mathbb{Z}) \cong \mathbb{Z} / \gcd(m, n)\mathbb{Z}$.
* $\text{Ext}_{\mathbb{Z}}^1(\mathbb{Z}/m\mathbb{Z}, \mathbb{Z}/n\mathbb{Z}) \cong \mathbb{Z} / \gcd(m, n)\mathbb{Z}$.
* $\text{Tor}_1^{\mathbb{Z}}(\mathbb{Q}, \mathbb{Z}/n\mathbb{Z}) = 0$ ($\mathbb{Q}$ is a flat $\mathbb{Z}$-module).
* $\text{Ext}_{\mathbb{Z}}^1(\mathbb{Z}/n\mathbb{Z}, \mathbb{Z}) \cong \mathbb{Z}/n\mathbb{Z}$.

### 4. Top Recommended Resources
* **Student-Friendly & Clear:** *An Introduction to Homological Algebra* by Joseph Rotman (Chapters 6–7).
* **Definitive Reference:** *An Introduction to Homological Algebra* by Charles Weibel (Chapters 2–3).
* **Visual & Topological:** *Algebraic Topology* by Allen Hatcher (Universal Coefficient Theorem, Chapter 3).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute $\text{Tor}_1^{\mathbb{Z}}(\mathbb{Z}/12\mathbb{Z}, \mathbb{Z}/18\mathbb{Z})$?
- [ ] Can you compute $\text{Ext}_{\mathbb{Z}}^1(\mathbb{Z}/p\mathbb{Z}, \mathbb{Z}/p\mathbb{Z})$ and interpret its elements as extensions?
- [ ] Can you write down the long exact sequences of $\text{Tor}$ and $\text{Ext}$ for a given short exact sequence?
- [ ] Can you explain why $\text{Tor}_n(A, B) = 0$ for $n \ge 2$ over $\mathbb{Z}$?
