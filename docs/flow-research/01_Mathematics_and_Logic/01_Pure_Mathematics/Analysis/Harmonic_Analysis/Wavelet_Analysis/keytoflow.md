# Key to Flow: Wavelet Analysis (Harmonic Analysis)

**Subject Area:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Wavelet_Analysis`

---

## 📌 Core Concept & Mental Model
**Wavelet Analysis** overcomes the fundamental limitation of the Fourier Transform (infinite time support, zero time-localization) by decomposing $L^2(\mathbb{R})$ using scaled and translated "small waves":
$$\psi_{j, k}(t) = 2^{j/2} \psi(2^j t - k), \quad j, k \in \mathbb{Z}$$
* **Continuous Wavelet Transform (CWT):**
  $$W_\psi f(a, b) = \frac{1}{\sqrt{|a|}} \int_{-\infty}^\infty f(t) \overline{\psi\left(\frac{t - b}{a}\right)} dt$$
* **Multiresolution Analysis (MRA, Mallat & Meyer):** A nested sequence of closed subspaces $\dots \subset V_{-1} \subset V_0 \subset V_1 \subset V_2 \subset \dots$ of $L^2(\mathbb{R})$ such that:
  1. $\bigcap_{j \in \mathbb{Z}} V_j = \{0\}$ and $\overline{\bigcup_{j \in \mathbb{Z}} V_j} = L^2(\mathbb{R})$.
  2. $f(t) \in V_j \iff f(2t) \in V_{j+1}$.
  3. $f(t) \in V_0 \iff f(t - k) \in V_0$ for all $k \in \mathbb{Z}$.
  4. There exists a **scaling function** (father wavelet) $\phi \in V_0$ such that $\{\phi(t - k)\}_{k \in \mathbb{Z}}$ is an orthonormal basis of $V_0$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Two-Scale Dilation Equations & Filter Banks
* **Scaling Dilation Equation:** $\phi(t) = \sqrt{2} \sum_{k} h_k \phi(2t - k)$ (Low-pass filter $h_k$).
* **Wavelet Dilation Equation:** $\psi(t) = \sqrt{2} \sum_{k} g_k \phi(2t - k)$ where $g_k = (-1)^k \overline{h_{1 - k}}$ (High-pass filter $g_k$).
* **Wavelet Detail Subspaces $W_j$:** $V_{j+1} = V_j \oplus W_j$, so $L^2(\mathbb{R}) = \bigoplus_{j \in \mathbb{Z}} W_j$.

### 2. Canonical Wavelet Families
1. **Haar Wavelet (1909):** $\phi = \mathbf{1}_{[0, 1)}$, $\psi(t) = \mathbf{1}_{[0, 1/2)}(t) - \mathbf{1}_{[1/2, 1)}(t)$. Compactly supported, discontinuous.
2. **Daubechies Wavelets (db$N$):** Maximally flat scaling filters with compact support of length $2N - 1$ and $N$ vanishing moments ($\int t^p \psi(t) dt = 0$ for $0 \le p < N$).
3. **Meyer Wavelets:** Infinitely differentiable $C^\infty$ with compact frequency support.
4. **Symlets & Coiflets:** Near-symmetric compactly supported wavelets.

### 3. Practical Processing & Denoising
* **Fast Wavelet Transform (FWT / Mallat's Algorithm):** Pyramidal cascade of convolutions and downsampling by 2 in $\mathcal{O}(N)$ time (faster than $\mathcal{O}(N \log N)$ FFT!).
* **Donoho-Johnstone Wavelet Shrinkage:** Soft thresholding $\eta_\lambda(w) = \operatorname{sgn}(w)(|w| - \lambda)_+$ with universal threshold $\lambda = \sigma \sqrt{2 \ln N}$.

### 4. Top Recommended Resources
* **The Master Work:** *Ten Lectures on Wavelets* by Ingrid Daubechies.
* **The Signal Processing Bible:** *A Wavelet Tour of Signal Processing: The Sparse Way* by Stéphane Mallat.
* **Accessible Mathematics:** *An Introduction to Wavelets* by Charles K. Chui.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you verify the 5 MRA axioms for the Haar scaling function?
- [ ] Can you compute the low-pass $h_k$ and high-pass $g_k$ filter coefficients for Daubechies db1 and db2?
- [ ] Can you prove that $N$ vanishing moments implies polynomial signals of degree $< N$ have zero wavelet detail coefficients?
- [ ] Can you apply Donoho's universal soft thresholding to denoise a 1D discrete signal?
