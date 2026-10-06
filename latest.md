# What's New in v26.10.6 (Build 2126100601)

- **LaTeX Studio Image & Figure Uploading**:
  - Direct image file uploads (`.png`, `.jpg`, `.jpeg`, `.webp`, `.gif`, `.bmp`) into multi-file LaTeX workspaces via File Explorer drawer, AppBar, and dedicated tab bar action.
  - Image preview dialog showing thumbnail, file size, custom project path/filename, and instant insertion controls.
- **Inline \includegraphics & Figure Environment Generation**:
  - One-tap insertion of publication-grade `\begin{figure}[htbp]...\includegraphics...\caption...\label...\end{figure}` environments or inline macros.
  - Automatic `\usepackage{graphicx}` package injection into root LaTeX documents upon image insertion.
  - Dedicated "Insert Image into LaTeX" dialog to browse and embed existing project assets into active `.tex` documents with customizable widths (`0.5\textwidth`, `0.7\textwidth`, `0.85\textwidth`, `\textwidth`).
- **Interactive Image Viewer Workspace Tabs**:
  - Opening image files in the editor presents an interactive zoomable/pannable inspection canvas, image metadata, and quick action buttons for copying `\includegraphics` code, copying full figure blocks, replacing assets, and deleting files.
- **Quick LaTeX Accessory Toolbar**:
  - Horizontal scrollable quick-insert bar directly above the editor status bar for instant insertion of `[🖼️ Image]`, `[📤 Upload]`, `[\begin{figure}]`, `[\cite{...}]`, `[Equation]`, `[Align]`, `[\section]`, `[\subsection]`, `[\textbf{}]`, `[\textit{}]`, and `[Table]`.
- **Full Online & Offline Compiler Support**:
  - Base64 payload integration with the remote TeX Live compiler (`latex.ytotech.com`) for compiling documents with graphic assets.
  - Built-in offline PDF rendering fallback support for `\includegraphics` and `\caption` blocks using local memory images.
- **New Multi-File Template**:
  - Added "Research Paper (with Figures)" featuring embedded benchmark graphic assets and demonstration of `\usepackage{graphicx}` and `\includegraphics`.
