#!/usr/bin/env python3
"""
Generate the textbook-style optics plates for OPTICS_1.html.

Run:  python3 tools/make_diagrams.py
Writes assets/<name>.png and assets/<name>.webp for every figure defined below,
so the plates are reproducible and editable instead of hand-tuned SVG.
"""
import os, math
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, Rectangle, Circle, Polygon, Arc, FancyArrowPatch

ASSETS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "assets")

# ── palette, matched to the existing plates in assets/ ──────────────────────
INK    = "#12141A"
BLUE   = "#1F4FCC"
RED    = "#C0392B"
GREEN  = "#127A४7".replace("४","4")
GREEN  = "#127A47"
VIOLET = "#5B4BC4"
GREY   = "#5A6272"
GLASS  = "#CFE2F7"
FILM   = "#FBE7C0"
BOXBLU = "#EAF2FD"
BOXPNK = "#FDEEF0"
BOXGRN = "#EAF7EF"
EDGE   = "#7E8AA0"

def panel(ax, x, y, w, h, title, face=BOXBLU, ec=EDGE):
    ax.add_patch(FancyBboxPatch((x, y), w, h, boxstyle="round,pad=0.0,rounding_size=0.6",
                                fc="white", ec=ec, lw=1.1, zorder=1))
    ax.add_patch(FancyBboxPatch((x+0.3, y+h-1.05), min(w-0.6, 0.42*len(title)+1.2), 0.85,
                                boxstyle="round,pad=0.0,rounding_size=0.28",
                                fc=face, ec=ec, lw=0.9, zorder=2))
    ax.text(x+0.62, y+h-0.63, title, fontsize=9.5, weight="bold", color=INK, va="center", zorder=3)

def ray(ax, x1, y1, x2, y2, color=RED, lw=1.6, ls="-", head=True, z=5):
    if head:
        ax.add_patch(FancyArrowPatch((x1, y1), (x2, y2), arrowstyle="-|>", mutation_scale=11,
                                     color=color, lw=lw, linestyle=ls, shrinkA=0, shrinkB=0, zorder=z))
    else:
        ax.plot([x1, x2], [y1, y2], color=color, lw=lw, ls=ls, zorder=z, solid_capstyle="round")

def dim(ax, x1, y1, x2, y2, label, color=VIOLET, off=(0, 0.28), fs=9.5):
    ax.add_patch(FancyArrowPatch((x1, y1), (x2, y2), arrowstyle="<|-|>", mutation_scale=9,
                                 color=color, lw=1.1, shrinkA=0, shrinkB=0, zorder=6))
    ax.text((x1+x2)/2+off[0], (y1+y2)/2+off[1], label, fontsize=fs, color=color,
            ha="center", va="center", zorder=7)

def hatch_bar(ax, x, y, w, h, angle="v"):
    ax.add_patch(Rectangle((x, y), w, h, fc=INK, ec=INK, zorder=6))
    n = 9
    for i in range(n):
        if angle == "v":
            yy = y + h*i/(n-1)
            ax.plot([x+w, x+w+0.32], [yy, yy+0.22], color=GREY, lw=0.9, zorder=6)
        else:
            xx = x + w*i/(n-1)
            ax.plot([xx, xx+0.22], [y+h, y+h+0.32], color=GREY, lw=0.9, zorder=6)

def finish(fig, ax, name, title):
    ax.set_xlim(0, 40); ax.set_ylim(0, 27); ax.set_aspect("equal"); ax.axis("off")
    ax.add_patch(FancyBboxPatch((10.0, 25.3), 20.0, 1.5, boxstyle="round,pad=0.0,rounding_size=0.35",
                                fc="white", ec=INK, lw=1.4, zorder=3))
    ax.text(20, 26.05, title, fontsize=13, weight="bold", ha="center", va="center", color=INK, zorder=4)
    fig.subplots_adjust(0, 0, 1, 1)
    png = os.path.abspath(os.path.join(ASSETS, name + ".png"))
    fig.savefig(png, dpi=190, facecolor="white")
    plt.close(fig)
    os.system('magick "%s" -quality 92 "%s"' % (png, png.replace(".png", ".webp")))
    print("  wrote", os.path.basename(png), "and .webp")


# ══════════════════════════════════════════════════════════════════════════
def michelson():
    fig, ax = plt.subplots(figsize=(11.2, 7.6))

    # ── panel 1: the layout ────────────────────────────────────────────────
    panel(ax, 0.6, 7.0, 25.4, 17.6, "1.  Optical layout (division of amplitude)")

    G1x, G1y = 10.6, 18.4                       # beam splitter centre
    G2x  = 14.8                                 # compensating plate
    M1x  = 22.4                                 # movable mirror plane
    M2y  = 21.3                                 # fixed mirror

    ax.text(2.3, 20.6, "Extended\nsource  $S$", fontsize=9, color=INK, ha="center", va="center")
    ax.add_patch(Circle((2.3, 18.4), 0.62, fc="#FFE9A8", ec=INK, lw=1.1, zorder=6))
    for a in range(8):
        t = a*math.pi/4
        ax.plot([2.3+0.85*math.cos(t), 2.3+1.15*math.cos(t)],
                [18.4+0.85*math.sin(t), 18.4+1.15*math.sin(t)], color="#C9A227", lw=1.0, zorder=5)

    for cx, lab, fc in ((G1x, "$G_1$", "#BBD6F5"), (G2x, "$G_2$", GLASS)):
        ax.add_patch(Polygon([[cx-1.5, G1y-1.5], [cx-1.25, G1y-1.75],
                              [cx+1.75, G1y+1.25], [cx+1.5, G1y+1.5]],
                             closed=True, fc=fc, ec=BLUE, lw=1.2, zorder=6))
        ax.text(cx-1.9, G1y-2.3, lab, fontsize=11, color=BLUE, ha="center")
    ax.text(6.0, 15.9, "$G_1$ half-silvered\non the back face", fontsize=8, color=GREY, ha="center")
    ax.text(16.9, 15.9, "$G_2$ compensating\nplate (no coating)", fontsize=8, color=GREY, ha="center")

    hatch_bar(ax, G1x-2.0, M2y, 4.0, 0.30, angle="h")
    ax.text(G1x+2.7, M2y+0.15, "$M_2$  fixed", fontsize=10, color=INK, va="center")

    hatch_bar(ax, M1x, 16.4, 0.30, 4.0, angle="v")
    ax.text(M1x+1.4, 18.4, "$M_1$\nmovable", fontsize=10, color=INK, va="center", ha="left")
    ax.add_patch(FancyArrowPatch((M1x-0.8, 21.2), (M1x+1.2, 21.2), arrowstyle="<|-|>",
                                 mutation_scale=9, color=GREY, lw=1.0, zorder=6))
    ax.text(M1x+0.2, 21.8, "move by $d_0$", fontsize=8, color=GREY, ha="center")

    ax.plot([M1x-2.6, M1x-2.6], [16.4, 20.4], color=VIOLET, lw=1.8, ls=(0, (5, 3)), zorder=6)
    ax.text(M1x-2.6, 20.9, "$M_2'$", fontsize=10, color=VIOLET, ha="center")
    ax.add_patch(Rectangle((M1x-2.6, 16.4), 2.6, 4.0, fc=FILM, alpha=.8, ec="none", zorder=2))
    dim(ax, M1x-2.6, 15.9, M1x, 15.9, "$d$", off=(0, -0.6))
    ax.text(M1x-1.3, 14.6, "equivalent air film", fontsize=8, color=GREY, ha="center")

    ray(ax, 3.6, 18.4, G1x-0.7, 18.4, RED, 1.8)
    ray(ax, G1x, 18.9, G1x, M2y-0.15, RED, 1.8)
    ray(ax, G1x+0.55, M2y-0.15, G1x+0.55, 19.0, RED, 1.8, head=False)
    ray(ax, G1x+1.0, 18.4, M1x-0.2, 18.4, GREEN, 1.8)
    ray(ax, M1x-0.2, 17.9, G1x+0.6, 17.9, GREEN, 1.8, head=False)
    ray(ax, G1x, 17.6, G1x, 12.6, BLUE, 1.8)
    ax.add_patch(Circle((G1x, 11.8), 0.78, fc="#E8ECF4", ec=INK, lw=1.1, zorder=6))
    ax.text(G1x+1.3, 11.8, "eye / detector", fontsize=9, color=INK, va="center")
    ax.text(1.4, 9.2, "The beam that goes to $M_1$ crosses the glass of $G_1$ three times; the beam to $M_2$ crosses it once.\n"
                      "$G_2$ is an identical uncoated plate that restores the balance — without it, white-light fringes never appear.",
            fontsize=8.4, color=GREY, va="top")

    # ── panel 2: the equivalent air film ───────────────────────────────────
    panel(ax, 26.6, 15.0, 12.8, 9.6, "2.  Equivalent air film", face=BOXPNK)
    ax.plot([28.0, 36.6], [20.3, 20.3], color=INK, lw=2.4, zorder=5)
    ax.plot([28.0, 36.6], [18.1, 18.1], color=VIOLET, lw=2.0, ls=(0, (5, 3)), zorder=5)
    ax.add_patch(Rectangle((28.0, 18.1), 8.6, 2.2, fc=FILM, ec="none", zorder=2))
    ax.text(36.9, 20.3, "$M_1$",  fontsize=9.5, color=INK,    va="center")
    ax.text(36.9, 18.1, "$M_2'$", fontsize=9.5, color=VIOLET, va="center")
    dim(ax, 29.0, 18.1, 29.0, 20.3, "$d$", off=(-0.7, 0))
    ray(ax, 30.4, 22.6, 32.2, 20.3, RED, 1.5)
    ray(ax, 32.2, 20.3, 34.0, 22.6, RED, 1.5)
    ray(ax, 32.2, 20.3, 33.1, 18.1, GREEN, 1.5, head=False)
    ray(ax, 33.1, 18.1, 35.0, 22.4, GREEN, 1.5)
    ax.plot([32.2, 32.2], [19.7, 22.4], color=GREY, lw=0.9, ls=(0, (3, 3)), zorder=4)
    ax.add_patch(Arc((32.2, 20.3), 1.9, 1.9, theta1=90, theta2=128, color=GREY, lw=0.9, zorder=6))
    ax.text(31.5, 21.5, r"$\theta$", fontsize=10, color=INK)
    ax.text(28.0, 16.9, r"$\Delta = 2d\cos\theta$", fontsize=11.5, color=RED)
    ax.text(28.0, 15.9, r"bright:  $2d\cos\theta = m\lambda$", fontsize=9.5, color=INK)

    # ── panel 3: fringes ───────────────────────────────────────────────────
    panel(ax, 26.6, 1.0, 12.8, 13.2, "3.  Circular fringes", face=BOXGRN)
    cx, cy = 33.0, 8.0
    ax.add_patch(Circle((cx, cy), 4.0, fc="#F4F6FA", ec=EDGE, lw=1.0, zorder=3))
    for k in range(1, 8):
        r = 4.0*math.sqrt(k/7.0)
        ax.add_patch(Circle((cx, cy), r, fc="none", ec=INK, lw=1.9, zorder=4))
    ax.text(cx, 2.6, "fringes of equal inclination;\nthe centre has the highest order,\nrings collapse inwards as d decreases",
            fontsize=8.3, color=GREY, ha="center", va="center")

    # ── panel 4: what it measures ──────────────────────────────────────────
    panel(ax, 0.6, 1.0, 25.4, 5.4, "4.  What the instrument measures", face=BOXPNK)
    ax.text(1.4, 4.6, r"Wavelength — move $M_1$ by $d_0$, count $N$ fringes:", fontsize=9.2, color=INK)
    ax.text(2.2, 3.4, r"$2d_0 = N\lambda \;\Rightarrow\; \lambda = 2d_0/N$", fontsize=11.5, color=RED)
    ax.text(2.2, 2.0, r"$2(n-1)t = N\lambda$   (refractive index of a thin plate)", fontsize=9.2, color=INK)
    ax.text(14.0, 4.6, r"Close doublet — visibility vanishes every $\Delta d$:", fontsize=9.2, color=INK)
    ax.text(14.8, 3.4, r"$\Delta\lambda = \lambda^{2}/2\Delta d$", fontsize=11.5, color=RED)
    ax.text(14.8, 2.0, r"coherence length  $L_c = \lambda^{2}/\Delta\lambda$", fontsize=9.2, color=INK)

    finish(fig, ax, "diag-m2-michelson", "Michelson Interferometer: Layout, Equivalent Film and Fringes")


# ══════════════════════════════════════════════════════════════════════════
def division():
    fig, ax = plt.subplots(figsize=(11.2, 7.6))

    # ── A: division of wavefront ───────────────────────────────────────────
    panel(ax, 0.6, 8.0, 19.0, 16.6, "A.  Division of WAVEFRONT")
    ax.text(1.4, 22.6, "one wavefront, sampled at two different PLACES",
            fontsize=9, color=GREY, style="italic")

    Sx, Sy = 2.6, 15.6
    ax.add_patch(Circle((Sx, Sy), 0.34, fc=INK, ec=INK, zorder=7))
    ax.text(Sx-0.1, Sy-1.1, "$S$", fontsize=11, color=INK, ha="center")
    for r in (2.2, 3.4, 4.6, 5.8):
        ax.add_patch(Arc((Sx, Sy), 2*r, 2*r, theta1=-52, theta2=52,
                         color=GREY, lw=0.9, ls=(0, (4, 3)), zorder=3))
    ax.text(Sx+3.0, Sy+5.2, "spherical\nwavefronts", fontsize=8.2, color=GREY, ha="center")

    bx = 9.0                                   # the double-slit screen
    for y0, h in ((17.9, 3.5), (15.1, 1.9), (10.0, 4.3)):
        ax.add_patch(Rectangle((bx, y0), 0.55, h, fc="#D8DEE9", ec=INK, lw=1.0, zorder=6))
    s1y, s2y = 17.5, 14.7
    for y, c, lab in ((s1y, RED, "$S_1$"), (s2y, GREEN, "$S_2$")):
        ax.add_patch(Circle((bx+0.27, y), 0.22, fc=c, ec=c, zorder=8))
        ax.text(bx+1.05, y, lab, fontsize=10, color=c, va="center")
    ray(ax, Sx+0.5, Sy, bx-0.1, s1y, RED, 1.3, head=False)
    ray(ax, Sx+0.5, Sy, bx-0.1, s2y, GREEN, 1.3, head=False)

    scx = 18.4
    ax.add_patch(Polygon([[bx+0.55, s1y], [scx, 21.0], [scx, 11.4], [bx+0.55, s2y]],
                         closed=True, fc="#FFF3CE", ec="none", alpha=.85, zorder=2))
    ax.text(13.6, 16.1, "region of\noverlap", fontsize=8.6, color="#9A7B12", ha="center", zorder=4)
    for y, c in ((s1y, RED), (s2y, GREEN)):
        ray(ax, bx+0.55, y, scx, 21.0 if y == s1y else 11.4, c, 1.3)
        ray(ax, bx+0.55, y, scx, 11.4 if y == s1y else 21.0, c, 1.3)
    ax.plot([scx, scx], [10.6, 21.8], color=INK, lw=2.2, zorder=6)
    ax.text(scx-0.3, 10.0, "screen", fontsize=8.5, color=GREY, ha="center")

    ax.text(1.4, 9.0, "Needs a NARROW source — the two samples must come from\n"
                      "the same wavefront.\n"
                      "Young's slits · Fresnel's two mirrors · biprism · Lloyd's mirror",
            fontsize=8.6, color=INK, va="top")

    # ── B: division of amplitude ───────────────────────────────────────────
    panel(ax, 20.2, 8.0, 19.2, 16.6, "B.  Division of AMPLITUDE", face=BOXPNK)
    ax.text(21.0, 22.6, "one beam, split at one SURFACE into two of smaller amplitude",
            fontsize=9, color=GREY, style="italic")

    fx0, fx1, fy0, fy1 = 21.2, 38.6, 12.6, 15.8
    ax.add_patch(Rectangle((fx0, fy0), fx1-fx0, fy1-fy0, fc=FILM, ec="#C9A227", lw=1.2, zorder=3))
    ax.text(35.4, 14.2, "film   $n_2$,  thickness $d$", fontsize=9, color=INK, ha="center", zorder=6)
    ax.text(21.6, 16.4, "$n_1$", fontsize=9.5, color=GREY)
    ax.text(21.6, 11.8, "$n_1$", fontsize=9.5, color=GREY)

    B = (27.4, fy1)
    ray(ax, 23.6, 20.6, B[0], B[1], RED, 1.8)
    ax.text(23.0, 21.0, "incident,  amplitude $a$", fontsize=8.6, color=RED)
    ray(ax, B[0], B[1], 31.2, 20.6, RED, 1.8)
    ax.text(31.4, 20.7, "$a r_1$", fontsize=10, color=RED)
    D = (29.2, fy0)
    F = (31.0, fy1)
    ray(ax, B[0], B[1], D[0], D[1], GREEN, 1.7, head=False)
    ray(ax, D[0], D[1], F[0], F[1], GREEN, 1.7, head=False)
    ray(ax, F[0], F[1], 34.8, 20.6, GREEN, 1.7)
    ax.text(34.9, 20.7, "$a t_1 r_2 t_2$", fontsize=10, color=GREEN)
    ray(ax, D[0], D[1], 31.0, 10.0, BLUE, 1.7)
    ax.text(31.2, 10.0, "$a t_1 t_2$", fontsize=10, color=BLUE)
    ax.plot([B[0], B[0]], [fy1-0.6, 19.6], color=GREY, lw=0.9, ls=(0, (3, 3)), zorder=4)
    ax.add_patch(Arc((B[0], B[1]), 2.2, 2.2, theta1=90, theta2=126, color=GREY, lw=0.9, zorder=6))
    ax.text(B[0]-1.1, B[1]+1.5, r"$\theta$", fontsize=10, color=INK)
    ax.add_patch(Arc((B[0], B[1]), 2.0, 2.0, theta1=249, theta2=270, color=GREY, lw=0.9, zorder=6))
    ax.text(B[0]+0.35, B[1]-1.3, r"$\theta'$", fontsize=10, color=INK)

    ax.text(21.0, 9.0, "Works with a BROAD, extended source — both beams leave the\n"
                       "same point of the wavefront.\n"
                       "Thin films · wedge · Newton's rings · Michelson · AR coatings",
            fontsize=8.6, color=INK, va="top")

    # ── the discriminating question ────────────────────────────────────────
    panel(ax, 0.6, 1.0, 38.8, 5.8, "How to tell them apart in one line", face=BOXGRN)
    ax.text(1.6, 5.2, "Ask where the two beams come from.", fontsize=10, weight="bold", color=INK)
    ax.text(1.6, 4.0, "Two different parts of the same wavefront  →  division of wavefront  →  needs a narrow slit.",
            fontsize=9.2, color=INK)
    ax.text(1.6, 2.9, "The same part, split by a partly-reflecting surface  →  division of amplitude  →  extended source is fine.",
            fontsize=9.2, color=INK)
    ax.text(1.6, 1.7, "That single sentence is worth a mark whenever an arrangement is named in the paper.",
            fontsize=8.6, color=GREY, style="italic")

    finish(fig, ax, "diag-m2-division", "The Two Ways of Producing Coherent Beams")
