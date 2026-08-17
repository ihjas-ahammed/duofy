# Key to Flow: Image Filtering & Edge Detection (Gaussian Blur, Sobel Gradients, Canny Pipeline, & LoG)

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Computer_Vision / Image_Filtering_and_Edge_Detection`

---

## 📌 Core Concept & Mental Model
**2D Spatial Domain Convolutions ($g(x,y) = (f * h)(x,y)$), Isotropic Gaussian Smoothing ($G(x,y) = \frac{1}{2\pi\sigma^2} e^{-\frac{x^2+y^2}{2\sigma^2}}$), Edge-Preserving Bilateral Filtering ($w_s \cdot w_r$), Discrete Differential Gradient Operators (Sobel $G_x, G_y$), Multi-Stage Optimal Edge Extraction (Canny: NMS Thinning + Double Threshold Hysteresis), and Second-Order Zero-Crossing Operators (Laplacian of Gaussian LoG & Difference of Gaussians DoG)** govern digital image processing and low-level computer vision (Rafael Gonzalez & Richard Woods *Digital Image Processing*; Richard Szeliski *Computer Vision: Algorithms and Applications* Chapters 3–4; John F. Canny 1986 *A Computational Approach to Edge Detection*, IEEE TPAMI):
* **1. Spatial Linear vs Edge-Preserving Smoothing:**
  - **2D Discrete Convolution:**
    $$\mathbf{g(x, y) = \sum_{u=-k}^k \sum_{v=-k}^k h(u, v) f(x-u, y-v)}$$
  - **Gaussian Blur (Low-Pass Filter):** Isotropic spatial Gaussian kernel removes high-frequency Gaussian noise, but blurs sharp edge boundaries.
  - **Bilateral Filter (Edge-Preserving):** Combines spatial domain closeness with photometric range intensity similarity:
    $$\mathbf{I_{\text{filtered}}(p) = \frac{1}{W_p} \sum_{q \in S} I(q) \cdot \mathbf{\exp\left(-\frac{\|p - q\|^2}{2\sigma_s^2}\right)} \cdot \mathbf{\exp\left(-\frac{\|I(p) - I(q)\|^2}{2\sigma_r^2}\right)}}$$
    - If pixel $q$ is across an edge ($|I(p) - I(q)|$ is large), range weight drops to $0$, preserving crisp edge contours!
* **2. First-Order Differential Gradient Operators (Sobel & Scharr):**
  - Image Gradient Vector: $\mathbf{\nabla f = \begin{bmatrix} G_x \\ G_y \end{bmatrix} = \begin{bmatrix} \frac{\partial f}{\partial x} \\ \frac{\partial f}{\partial y} \end{bmatrix}}$.
  - **Gradient Magnitude (Edge Strength):**
    $$\mathbf{M(x, y) = \|\nabla f\| = \sqrt{G_x^2 + G_y^2} \approx |G_x| + |G_y|}$$
  - **Gradient Orientation (Direction of Steepest Intensity Increase):**
    $$\mathbf{\theta(x, y) = \arctan\left(\frac{G_y}{G_x}\right)} \qquad (\text{Edge tangent is perpendicular: } \theta \pm 90^\circ)$$
  - **Sobel $3\times 3$ Kernels:**
    $$K_x = \begin{pmatrix} -1 & 0 & +1 \\ -2 & 0 & +2 \\ -1 & 0 & +1 \end{pmatrix} \qquad ; \qquad K_y = \begin{pmatrix} -1 & -2 & -1 \\ 0 & 0 & 0 \\ +1 & +2 & +1 \end{pmatrix}$$
* **3. The Canny Edge Detector (John F. Canny 1986):**
  - Optimized for 3 criteria: (1) Low error rate, (2) Precise edge localization, (3) Single response per edge.
  - **The 5 Sequential Steps:**
    1. **Gaussian Smoothing:** $\sigma$ suppresses high-frequency sensor noise.
    2. **Sobel Gradient Computation:** Calculates magnitude $M(x,y)$ and quantized angle $\theta \in \{0^\circ, 45^\circ, 90^\circ, 135^\circ\}$.
    3. **Non-Maximum Suppression (NMS):** Thinning step suppressing all pixels that are not local maxima along their 1D gradient direction line.
    4. **Double Thresholding:** Classifies pixels into Strong ($M \ge T_{\text{high}}$), Weak ($T_{\text{low}} \le M < T_{\text{high}}$), and Non-edge ($M < T_{\text{low}}$).
    5. **Edge Tracking by Hysteresis:** Retains weak edge pixels **if and only if** they are 8-connected to a strong edge.
* **4. Second-Order Operators (Laplacian, LoG, & DoG):**
  - **Laplacian:** $\nabla^2 f = \frac{\partial^2 f}{\partial x^2} + \frac{\partial^2 f}{\partial y^2}$ (Detects edges at **Zero-Crossings**).
  - **Laplacian of Gaussian (LoG - "Mexican Hat"):** $\nabla^2 (G * f) = (\nabla^2 G) * f$.
  - **Difference of Gaussians (DoG):** Efficient approximation of LoG: $\text{DoG} = G_{\sigma_1} - G_{\sigma_2} \approx (k-1)\sigma^2 \nabla^2 G$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Edge Detection Progression
* Smoothing $\to$ Box Filter $\to$ Gaussian Kernel ($w_s$) $\to$ Bilateral Filter ($w_s \cdot w_r$).
* 1st Order Gradients $\to$ Finite Differences $\to$ Sobel ($G_x, G_y$) $\to$ Magnitude $M$ & Orientation $\theta$.
* Thinning & Hysteresis $\to$ Canny NMS + Double Thresholding.
* 2nd Order Zero-Crossings $\to$ Laplacian $\to$ LoG $\to$ Difference of Gaussians (DoG / SIFT).

### 2. Top Recommended Resources
* **The Computer Vision Textbook:** *Computer Vision: Algorithms and Applications* (Richard Szeliski), Chapter 3 (Image Processing) and Chapter 4 (Feature Detection).
* **The Classical Paper:** *A Computational Approach to Edge Detection* (John F. Canny, IEEE TPAMI 1986).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute 2D convolution with a $3\times 3$ Sobel kernel on a simple image patch?
- [ ] Can you explain why Bilateral filtering preserves sharp edges while Gaussian blur smears them?
- [ ] Can you trace all 5 steps of the Canny edge detection pipeline?
- [ ] Can you explain how Non-Maximum Suppression thins thick gradient ridges into 1-pixel edges?
