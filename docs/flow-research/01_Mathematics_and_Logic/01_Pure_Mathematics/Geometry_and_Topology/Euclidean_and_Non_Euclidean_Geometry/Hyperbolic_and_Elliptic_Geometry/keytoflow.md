# Key to Flow: Hyperbolic and Elliptic Geometry (Non-Euclidean Geometry)

**Subject Area:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry / Hyperbolic_and_Elliptic_Geometry`

---

## 📌 Core Concept & Mental Model
**Non-Euclidean Geometries** arise by modifying Euclid's Parallel Postulate, creating spaces characterized by their constant Gaussian curvature $K$:
* **Hyperbolic Geometry ($K = -1 < 0$, Lobachevsky / Bolyai / Gauss):** Given a line $\ell$ and a point $P \notin \ell$, there are **infinitely many** lines through $P$ parallel to (disjoint from) $\ell$.
  * **Angle Defect & Area (Gauss-Bonnet):** $\operatorname{Area}(\triangle ABC) = \pi - (\alpha + \beta + \gamma)$.
  * **Ideal Triangles:** Triangles with vertices on the boundary circle have angle sum $0 + 0 + 0 = 0$ and maximal area $\pi$.
* **Elliptic / Spherical Geometry ($K = +1/R^2 > 0$, Riemann):** Lines are great circles; any two lines meet in two antipodal points (or one point on $\mathbb{RP}^2$). There are **no parallel lines**.
  * **Spherical Excess & Area (Girard's Theorem):** $\operatorname{Area}(\triangle ABC) = R^2 (\alpha + \beta + \gamma - \pi)$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Canonical Models of the Hyperbolic Plane $\mathbb{H}^2$
1. **Poincaré Disk Model $(\mathbb{D}, ds^2 = \frac{4(dx^2 + dy^2)}{(1 - x^2 - y^2)^2})$:** Conformal (angle-preserving) unit disk. Geodesics are diameters and circular arcs orthogonal to the boundary circle $\partial \mathbb{D}$.
2. **Poincaré Upper Half-Plane $(\mathbb{H}^2, ds^2 = \frac{dx^2 + dy^2}{y^2})$:** Conformal upper half plane $y > 0$. Geodesics are vertical lines and semicircles orthogonal to $y = 0$.
   * **Isometry Group:** $\operatorname{PSL}(2, \mathbb{R})$ acting by Möbius transformations $z \mapsto \frac{az + b}{cz + d}$.
3. **Klein-Beltrami Model:** Geodesics are straight Euclidean chords, but angles are distorted (non-conformal).
4. **Hyperboloid / Minkowski Model:** Upper sheet of $-x_0^2 + x_1^2 + x_2^2 = -1$ in Minkowski space $\mathbb{R}^{2, 1}$.

### 2. Trigonometry & Comparison Formulas
* **Hyperbolic Law of Cosines:** $\cosh(c) = \cosh(a)\cosh(b) - \sinh(a)\sinh(b)\cos(C)$.
* **Spherical Law of Cosines:** $\cos(c) = \cos(a)\cos(b) + \sin(a)\sin(b)\cos(C)$.
* **Circumference of Circle of Radius $r$:**
  * Hyperbolic: $C = 2\pi \sinh(r)$ (grows exponentially with radius).
  * Spherical: $C = 2\pi \sin(r)$ (shrinks after the equator).
  * Euclidean: $C = 2\pi r$ (linear growth).

### 3. Top Recommended Resources
* **The Modern Accessible Text:** *Geometry with an Introduction to Cosmic Topology* by Michael P. Hitchman.
* **Classical Depth:** *Euclidean and Non-Euclidean Geometries: Development and History* by Marvin J. Greenberg.
* **Geometric Intuition:** *Visual Differential Geometry and Forms* by Tristan Needham (Chapters 21–25).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute the hyperbolic area of a triangle given its interior angles $\alpha, \beta, \gamma$?
- [ ] Can you compute the spherical excess and surface area of a spherical triangle on the Earth?
- [ ] Can you find the geodesic line passing through two given points in the Poincaré Upper Half Plane?
- [ ] Can you use Möbius transformations in $\operatorname{PSL}(2, \mathbb{R})$ to map any geodesic to the imaginary axis?
