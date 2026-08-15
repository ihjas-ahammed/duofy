# Key to Flow: Conformal Mapping (Complex Analysis)

**Subject Area:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Conformal_Mapping`

---

## 📌 Core Concept & Mental Model
A mapping $w = f(z)$ is **conformal** at $z_0$ if it preserves both the **magnitude and orientation of angles** between intersecting curves. 

**Theorem:** A mapping is conformal at all points where $f(z)$ is holomorphic and its derivative is non-zero: $f'(z) \ne 0$.

**The Riemann Mapping Theorem (RMT):** Every simply connected, non-empty open proper subset $U \subsetneq \mathbb{C}$ can be conformally mapped bijectively onto the open unit disk $\mathbb{D} = \{w \in \mathbb{C} \mid |w| < 1\}$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Möbius (Linear Fractional) Transformations
Every Möbius transformation has the form:
$$f(z) = \frac{az + b}{cz + d} \quad (ad - bc \ne 0)$$
* **Four Elementary Decompositions:**
  1. Translation: $z \mapsto z + \frac{d}{c}$
  2. Inversion: $z \mapsto \frac{1}{z}$
  3. Dilation & Rotation: $z \mapsto -\frac{ad-bc}{c^2} z$
  4. Translation: $z \mapsto z + \frac{a}{c}$
* **Circle-Preserving Property:** Möbius transformations map **generalized circles** (straight lines and circles) to **generalized circles**.
* **Cross-Ratio Invariance:** For any 4 distinct points $z_1, z_2, z_3, z_4$:
  $$(w, w_1, w_2, w_3) = (z, z_1, z_2, z_3) \implies \frac{(w - w_1)(w_2 - w_3)}{(w - w_3)(w_2 - w_1)} = \frac{(z - z_1)(z_2 - z_3)}{(z - z_3)(z_2 - z_1)}$$

### 2. Canonical Conformal Mappings
* **Upper Half-Plane to Unit Disk (Cayley Transform):**
  $$w = f(z) = \frac{z - i}{z + i}$$
  (Maps $\mathbb{H} = \{\text{Im}(z) > 0\}$ bijectively to $\mathbb{D} = \{|w| < 1\}$, with real axis $\mathbb{R} \to \partial \mathbb{D}$).
* **Sector to Half-Plane:** $w = z^{\pi / \alpha}$ maps the wedge of angle $\alpha$ to the upper half-plane.
* **Strip to Half-Plane / Disk:** $w = e^{\pi z / a}$ maps horizontal strip $\{0 < \text{Im}(z) < a\}$ to $\mathbb{H}$.
* **Joukowsky Transform:** $w = \frac{1}{2}\left(z + \frac{1}{z}\right)$ maps circles to aerodynamic airfoils.

### 3. Top Recommended Resources
* **Visual & Intuitive:** *Visual Complex Analysis* by Tristan Needham (Chapters 3 & 6).
* **Standard Textbook:** *Complex Variables and Applications* by Brown & Churchill (Chapters 8–9).
* **Advanced Theory & RMT:** *Complex Analysis* by Joseph Bak & Donald J. Newman (Chapter 14).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you construct a unique Möbius transformation mapping 3 points $(z_1, z_2, z_3)$ to $(w_1, w_2, w_3)$ via cross-ratios?
- [ ] Can you map an infinite wedge or strip conformally to the unit disk $\mathbb{D}$?
- [ ] Can you verify whether a given transformation preserves circles and orientation?
- [ ] Can you use conformal mapping to solve Laplace's equation for steady-state 2D potential flows?
