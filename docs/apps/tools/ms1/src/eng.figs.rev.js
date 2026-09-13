/* ══════════════════════════════════════════════════════════════════
   Review figures — built for the night before, not for study.
   Each one is a single glance: no chips, no steps, no animation.
   Whatever is on the canvas is the whole answer to one exam question.
   ══════════════════════════════════════════════════════════════════ */

/* small helpers shared by the review panels */
function rvPanel(ctx, x, y, w, h, title, col) {
  ctx.save();
  ctx.fillStyle = C.dark ? 'rgba(255,255,255,.028)' : 'rgba(0,0,0,.022)';
  ctx.strokeStyle = C.inkA(.13); ctx.lineWidth = 1;
  const r = 8;
  ctx.beginPath();
  ctx.moveTo(x + r, y); ctx.arcTo(x + w, y, x + w, y + h, r); ctx.arcTo(x + w, y + h, x, y + h, r);
  ctx.arcTo(x, y + h, x, y, r); ctx.arcTo(x, y, x + w, y, r); ctx.closePath();
  ctx.fill(); ctx.stroke();
  if (title) {
    ctx.fillStyle = col || C.ink; ctx.font = `600 11px ${FM}`;
    ctx.textAlign = 'center'; ctx.textBaseline = 'top';
    ctx.fillText(title, x + w / 2, y + 7);
  }
  ctx.restore();
}
const rvLineH = (lines, sz) => lines.reduce((h, L) => h + (L ? (sz || 10) + 4 : (sz || 10) * .5), 0);
function rvLines(ctx, lines, x, y, w, sz) {
  ctx.save(); ctx.textAlign = 'center'; ctx.textBaseline = 'top';
  let yy = y; const base = sz || 10;
  lines.forEach(L => {
    if (!L) { yy += base * .5; return; }
    const wt = L[2] ? '600 ' : '';
    let fs = base;
    ctx.font = wt + fs + `px ${FM}`;
    /* a column is narrow: shrink rather than spill over the panel edge */
    const tw = ctx.measureText(L[0]).width;
    if (tw > w) { fs = Math.max(7, fs * w / tw); ctx.font = wt + fs.toFixed(1) + `px ${FM}`; }
    ctx.fillStyle = L[1] || C.inkA(.78);
    ctx.fillText(L[0], x + w / 2, yy);
    yy += base + 4;
  });
  ctx.restore(); return yy;
}

/* ── the four bonds, side by side — the whole of Module I bonding in one strip ── */
FIGS.rv_bonds = {
  ar: .31, arN: .96,
  draw(ctx, W, H, st) {
    ctx.clearRect(0, 0, W, H); readPalette();
    const narrow = W < 560;
    const cols = narrow ? 2 : 4, rows = narrow ? 2 : 1;
    const pad = 8, cw = (W - pad * (cols + 1)) / cols, ch = (H - 26 - pad * (rows + 1)) / rows;
    const B = [
      { n: 'IONIC', col: C.prob,
        e: '600–1500 kJ/mol', ex: 'NaCl, MgO, Al₂O₃', k: 'non-directional',
        p: 'hard · brittle · high Tm · insulating' },
      { n: 'COVALENT', col: C.neg,
        e: '125–1200 kJ/mol', ex: 'diamond, Si, SiC', k: 'strongly directional',
        p: 'very hard · high Tm · low density' },
      { n: 'METALLIC', col: C.pos,
        e: '60–850 kJ/mol', ex: 'Fe, Cu, Al, W', k: 'non-directional',
        p: 'ductile · conducts heat + charge' },
      { n: 'SECONDARY', col: C.inkA(.6),
        e: '4–40 kJ/mol', ex: 'Ar, H₂O (ice), polymers', k: 'dipole–dipole',
        p: 'low Tm · soft · why polymers melt' }
    ];

    B.forEach((b, i) => {
      const cx0 = pad + (i % cols) * (cw + pad), cy0 = 22 + pad + Math.floor(i / cols) * (ch + pad);
      rvPanel(ctx, cx0, cy0, cw, ch, b.n, b.col);
      const tsz = narrow ? 9 : 9.5;
      const rows5 = [1, 1, 0, 1, 1].map(v => v ? 1 : null);
      const ty = cy0 + ch - 9 - rvLineH(rows5, tsz);       /* text hugs the foot */
      const mx = cx0 + cw / 2, my = (cy0 + 26 + ty) / 2, r = Math.min(cw * .11, (ty - cy0 - 30) * .30, 15);

      /* the pictogram — the part the eye actually remembers */
      if (i === 0) {                                   /* ionic: + and − , pull in every direction */
        ball(ctx, mx - r * 1.5, my, r, C.pos, C.posA, { txt: '+', tsz: r });
        ball(ctx, mx + r * 1.5, my, r * 1.25, C.neg, C.negA, { txt: '−', tsz: r });
        ctx.save(); ctx.strokeStyle = C.probA(.5); ctx.lineWidth = 1.2;
        /* clamp the rays to the free band, or on a phone they cross the title and the text */
        const band = Math.min(my - (cy0 + 26), ty - my) - 4;
        if (band >= r * 3.0) {                 /* too cramped to read? drop them rather than crowd the ions */
          for (let a = 0; a < 8; a++) {
            const th = a * Math.PI / 4;
            ctx.beginPath(); ctx.moveTo(mx + Math.cos(th) * r * 2.6, my + Math.sin(th) * r * 2.6);
            ctx.lineTo(mx + Math.cos(th) * Math.min(r * 3.4, band), my + Math.sin(th) * Math.min(r * 3.4, band)); ctx.stroke();
          }
        }
        ctx.restore();
      } else if (i === 1) {                            /* covalent: one shared pair, fixed angle */
        ball(ctx, mx - r * 1.6, my, r, C.negA(.85), C.negA, {});
        ball(ctx, mx + r * 1.6, my, r, C.negA(.85), C.negA, {});
        ctx.save(); ctx.fillStyle = C.ink;
        [-3.5, 3.5].forEach(dy => { ctx.beginPath(); ctx.arc(mx, my + dy, 2.6, 0, 7); ctx.fill(); });
        ctx.strokeStyle = C.negA(.55); ctx.lineWidth = 1.3; ctx.setLineDash([3, 3]);
        ctx.beginPath(); ctx.arc(mx - r * 1.6, my, r * 2.1, -1.05, -.12); ctx.stroke();
        ctx.restore();
        ctx.save(); ctx.fillStyle = C.negA(.85); ctx.font = `600 9px ${FM}`; ctx.textAlign = 'center';
        ctx.fillText('109.5°', mx + r * .1, my - r * 2.3); ctx.restore();
      } else if (i === 2) {                            /* metallic: cores adrift in an electron sea */
        ctx.save(); ctx.fillStyle = C.negA(.10);
        ctx.fillRect(mx - cw * .34, my - r * 1.9, cw * .68, r * 3.8); ctx.restore();
        [-1.5, -.5, .5, 1.5].forEach(k => ball(ctx, mx + k * r * 1.5, my, r * .72, C.pos, C.posA, { txt: '+', tsz: r * .7 }));
        ctx.save(); ctx.fillStyle = C.neg; const R = rng(4);
        for (let k = 0; k < 22; k++) {
          ctx.beginPath();
          ctx.arc(mx + (R() - .5) * cw * .66, my + (R() - .5) * r * 3.4, 2, 0, 7); ctx.fill();
        }
        ctx.restore();
      } else {                                         /* secondary: two weakly linked dipoles */
        [-1, 1].forEach(s => {
          const bx = mx + s * r * 2.0;
          ctx.save();
          const g = ctx.createLinearGradient(bx - r, 0, bx + r, 0);
          g.addColorStop(0, C.wallA(.30)); g.addColorStop(1, C.negA(.30));
          ctx.fillStyle = g; ctx.beginPath(); ctx.ellipse(bx, my, r * 1.05, r * .78, 0, 0, 7); ctx.fill();
          ctx.restore();
          ctx.save(); ctx.font = `600 9px ${FM}`; ctx.textAlign = 'center';
          ctx.fillStyle = C.wall; ctx.fillText('δ+', bx - r * .62, my + 3);
          ctx.fillStyle = C.neg; ctx.fillText('δ−', bx + r * .62, my + 3);
          ctx.restore();
        });
        ctx.save(); ctx.strokeStyle = C.inkA(.4); ctx.lineWidth = 1.4; ctx.setLineDash([2, 3]);
        ctx.beginPath(); ctx.moveTo(mx - r * .85, my); ctx.lineTo(mx + r * .85, my); ctx.stroke(); ctx.restore();
      }

      rvLines(ctx, [
        [b.e, b.col, 1],
        [b.k, C.inkA(.6)],
        null,
        [b.ex, C.inkA(.8)],
        [b.p, C.inkA(.55)]
      ], cx0 + 5, ty, cw - 10, tsz);
    });

    capBlock(ctx, [['four bonds, strongest first — bond energy sets melting point', C.ink]], 10, 6);
  }
};

/* ── the well's shape → three properties. One picture, three exam answers. ── */
FIGS.rv_well = {
  ar: .46, arN: .74,
  draw(ctx, W, H, st) {
    ctx.clearRect(0, 0, W, H); readPalette();
    const P = Plot(ctx, W, H, { l: 30, r: 16, t: 46, b: 26 });
    P.dom(.62, 3.1).ran(-1.35, .62);
    const A = 1, n = 9, E = r => -A / r + (A / n) / Math.pow(r, n), E0 = E(1);

    P.axes({}); P.clip();
    P.curve(E, C.neg, 2.8);
    P.vline(1, C.inkA(.25), 1, [3, 3]);

    /* 1 — depth = bonding energy = melting point */
    P.arrow(1.0, 0, 1.0, E0, C.prob, 1.8);
    P.hline(E0, C.probA(.4), 1, [3, 3]);
    P.label(1.06, -.30, ' E₀  depth → melting point', C.prob, { b: 1, sz: 10.5 });

    /* 2 — curvature at the bottom = stiffness */
    const k = A * (n - 1);
    P.curve(r => E0 + .5 * k * (r - 1) * (r - 1), C.amber, 1.6, [4, 3], .84, 1.16);
    P.label(1.05, E0 - .17, 'curvature → stiffness E', C.amber, { b: 1, sz: 10.5 });

    /* 3 — the lop-sided walls = thermal expansion */
    const lv = [.28, .50].map(f => E0 * (1 - f));   /* deep enough that both turning points stay in view */
    const mids = [[1, E0]];
    lv.forEach(L => {
      const f = r => E(r) - L, bis = (a, b) => { for (let i = 0; i < 60; i++) { const m = (a + b) / 2; (f(a) * f(m) <= 0) ? b = m : a = m; } return (a + b) / 2; };
      const a = bis(.6, 1), b = bis(1, 30);
      P.seg(a, L, b, L, C.wallA(.7), 1.3); mids.push([(a + b) / 2, L]);
    });
    ctx.save(); ctx.strokeStyle = C.wall; ctx.lineWidth = 1.8; ctx.setLineDash([2, 3]); ctx.beginPath();
    mids.forEach((q, j) => j ? ctx.lineTo(P.X(q[0]), P.Y(q[1])) : ctx.moveTo(P.X(q[0]), P.Y(q[1])));
    ctx.stroke(); ctx.restore();
    P.label(2.02, -.16, 'lop-sided → expansion α', C.wall, { b: 1, sz: 10.5 });

    P.unclip();
    P.label(1, .66, ' r₀', C.inkA(.6), { sz: 10.5, b: 1 });
    P.text(W - 18, H - 40, 'r →', C.inkA(.5), { align: 'right', sz: 10 });
    capBlock(ctx, [
      ['one curve answers three questions', C.ink],
      ['deep → high Tm  ·  sharply curved → stiff  ·  asymmetric → expands', C.inkA(.65)]
    ], 10, 6);
  }
};

/* ── the defect zoo by dimensionality — the Module II spine ── */
FIGS.rv_defects = {
  ar: .30, arN: .92,
  draw(ctx, W, H, st) {
    ctx.clearRect(0, 0, W, H); readPalette();
    const narrow = W < 560;
    const cols = narrow ? 2 : 4, rows = narrow ? 2 : 1;
    const pad = 8, cw = (W - pad * (cols + 1)) / cols, ch = (H - 26 - pad * (rows + 1)) / rows;
    const T = [
      ['0-D  POINT', C.prob, ['vacancy · self-interstitial', 'substitutional · interstitial solute', 'N_v = N exp(−Q_v/kT)']],
      ['1-D  LINEAR', C.wall, ['edge: b ⊥ line, extra half-plane', 'screw: b ∥ line, helical ramp', 'carries plastic slip']],
      ['2-D  INTERFACIAL', C.pos, ['grain boundary · twin', 'external surface', 'θ = b/D for a tilt wall']],
      ['3-D  VOLUME', C.neg, ['pores · cracks', 'inclusions', 'second-phase particles']]
    ];

    T.forEach((t, i) => {
      const x0 = pad + (i % cols) * (cw + pad), y0 = 22 + pad + Math.floor(i / cols) * (ch + pad);
      rvPanel(ctx, x0, y0, cw, ch, t[0], t[1]);
      const tsz = narrow ? 8.5 : 9.5;
      const ty = y0 + ch - 9 - rvLineH([1, 1, 1], tsz);     /* text hugs the foot */
      const gx = x0 + cw / 2, gy = (y0 + 26 + ty) / 2;
      const s = Math.min(cw / 8.4, (ty - y0 - 30) * .26), rr = s * .40;
      const at = (ax, ay, col) => { ctx.save(); ctx.fillStyle = col || C.posA(.85); ctx.strokeStyle = C.inkA(.55); ctx.lineWidth = 1; ctx.beginPath(); ctx.arc(ax, ay, rr, 0, 7); ctx.fill(); ctx.stroke(); ctx.restore(); };

      if (i === 0) {                                   /* a vacancy and a crowded interstitial */
        for (let a = -2; a <= 2; a++) for (let b = -1; b <= 1; b++) {
          if (a === -1 && b === 0) continue;            /* the missing atom */
          at(gx + a * s, gy + b * s);
        }
        ctx.save(); ctx.strokeStyle = C.prob; ctx.lineWidth = 1.6; ctx.setLineDash([2, 2]);
        ctx.beginPath(); ctx.arc(gx - s, gy, rr, 0, 7); ctx.stroke(); ctx.restore();
        at(gx + s * .5, gy + s * .5, C.probA(.95));     /* squeezed between sites */
      } else if (i === 1) {                            /* the extra half-plane and its ⊥ */
        for (let a = -2; a <= 2; a++) for (let b = -1; b <= 1; b++) {
          if (b === 1 && a === 0) continue;             /* half-plane stops here */
          at(gx + a * s + (b === 1 ? (a > 0 ? -s * .18 : s * .18) : 0), gy + b * s, a === 0 && b < 1 ? C.wallA(.95) : null);
        }
        ctx.save(); ctx.strokeStyle = C.wall; ctx.lineWidth = 1.5;
        ctx.beginPath(); ctx.moveTo(gx - s * 2.4, gy + s * .5); ctx.lineTo(gx + s * 2.4, gy + s * .5); ctx.stroke();
        ctx.fillStyle = C.wall; ctx.font = `700 13px ${FM}`; ctx.textAlign = 'center'; ctx.textBaseline = 'middle';
        ctx.fillText('⊥', gx, gy + s * 1.02); ctx.restore();
      } else if (i === 2) {                            /* two grains meeting at a mismatched seam */
        ctx.save();
        ctx.beginPath(); ctx.rect(gx - s * 2.6, gy - s * 1.5, s * 5.2, s * 3); ctx.clip();
        for (let a = -3; a <= 0; a++) for (let b = -2; b <= 2; b++) at(gx + a * s * .92, gy + b * s * .92);
        const ca = Math.cos(.55), sa = Math.sin(.55);
        for (let a = 0; a <= 3; a++) for (let b = -3; b <= 3; b++) {
          const px = a * s * .92, py = b * s * .92;
          at(gx + px * ca - py * sa + s * .5, gy + px * sa + py * ca);
        }
        ctx.restore();
        ctx.save(); ctx.strokeStyle = C.pos; ctx.lineWidth = 2;
        ctx.beginPath(); ctx.moveTo(gx + s * .1, gy - s * 1.5); ctx.lineTo(gx + s * .1, gy + s * 1.5); ctx.stroke();
        ctx.strokeStyle = C.inkA(.18); ctx.lineWidth = 1;
        ctx.strokeRect(gx - s * 2.6, gy - s * 1.5, s * 5.2, s * 3); ctx.restore();
      } else {                                         /* a pore swallowing whole rows */
        for (let a = -2; a <= 2; a++) for (let b = -1; b <= 1; b++) {
          if (Math.hypot(a, b * 1.1) < 1.25) continue;
          at(gx + a * s, gy + b * s);
        }
        ctx.save(); ctx.fillStyle = C.negA(.16); ctx.strokeStyle = C.neg; ctx.lineWidth = 1.4;
        ctx.beginPath(); ctx.arc(gx, gy, s * 1.05, 0, 7); ctx.fill(); ctx.stroke(); ctx.restore();
      }

      rvLines(ctx, t[2].map((L, j) => [L, j === 2 ? t[1] : C.inkA(.72), j === 2]),
        x0 + 5, ty, cw - 10, tsz);
    });

    capBlock(ctx, [['every defect the syllabus asks for, sorted by dimension', C.ink]], 10, 6);
  }
};

/* ── X-ray diffraction: the geometry, the two selection rules, and the trap ── */
FIGS.rv_xrd = {
  ar: .33, arN: 1.12,
  draw(ctx, W, H, st) {
    ctx.clearRect(0, 0, W, H); readPalette();
    const narrow = W < 560;
    const lw = narrow ? W - 16 : W * .52, top = 24;
    const lh = narrow ? Math.round((H - top - 22) * .46) : H - top - 10;

    /* left: two planes, one path difference */
    rvPanel(ctx, 8, top, lw, lh, null);
    const yA = top + lh * .30, yB = top + lh * .64, x0 = 20, x1 = 8 + lw - 12;
    ctx.save();
    ctx.strokeStyle = C.inkA(.35); ctx.lineWidth = 1.2; ctx.setLineDash([4, 4]);
    [yA, yB].forEach(y => { ctx.beginPath(); ctx.moveTo(x0, y); ctx.lineTo(x1, y); ctx.stroke(); });
    ctx.restore();
    for (let x = x0 + 14; x < x1 - 6; x += (x1 - x0) / 7) {
      ball(ctx, x, yA, 4.6, C.pos, C.posA, {}); ball(ctx, x, yB, 4.6, C.pos, C.posA, {});
    }
    const mx = (x0 + x1) / 2, dx = Math.min(lh * .26, (yA - top - 12) / 1.25);
    arrowPx(ctx, mx - dx * 1.6, yA - dx * 1.25, mx, yA, C.neg, 1.9, 8);
    arrowPx(ctx, mx, yA, mx + dx * 1.6, yA - dx * 1.25, C.neg, 1.9, 8);
    arrowPx(ctx, mx - dx * 1.6 + 6, yB - dx * 1.25 + 6, mx + 6, yB, C.amber, 1.9, 8);
    arrowPx(ctx, mx + 6, yB, mx + dx * 1.6 + 6, yB - dx * 1.25 + 6, C.amber, 1.9, 8);
    ctx.save();
    ctx.strokeStyle = C.wall; ctx.lineWidth = 1.6; ctx.setLineDash([3, 3]);
    ctx.beginPath(); ctx.moveTo(mx - dx * .62, yA + (yB - yA) * .50); ctx.lineTo(mx + 6, yB);
    ctx.lineTo(mx + dx * .62 + 6, yA + (yB - yA) * .50); ctx.stroke(); ctx.restore();
    ctx.save();
    ctx.strokeStyle = C.prob; ctx.lineWidth = 1.4;
    ctx.beginPath(); ctx.moveTo(x0 + 4, yA); ctx.lineTo(x0 + 4, yB); ctx.stroke(); ctx.restore();
    ctx.save();
    ctx.fillStyle = C.prob; ctx.font = `600 11px ${FM}`; ctx.textAlign = 'left'; ctx.textBaseline = 'middle';
    ctx.fillText(' d', x0 + 6, (yA + yB) / 2);
    ctx.fillStyle = C.neg; ctx.fillText('θ', mx - dx * .78, yA - 9);
    ctx.fillStyle = C.wall; ctx.font = `600 10px ${FM}`; ctx.textAlign = 'center';
    ctx.fillText('extra path = 2d sin θ', mx + 4, yB + 16);
    ctx.restore();
    ctx.save(); ctx.textAlign = 'center'; ctx.fillStyle = C.ink; ctx.font = `600 13px ${FD}`;
    ctx.textBaseline = 'top'; ctx.fillText('n λ = 2 d sin θ', 8 + lw / 2, yB + 38); ctx.restore();

    /* right: which reflections actually show up, and the one that eats marks */
    const rx = narrow ? 8 : lw + 16, ry = narrow ? top + lh + 12 : top,
      rw = narrow ? W - 16 : W - lw - 24, rh = narrow ? H - ry - 10 : lh;
    rvPanel(ctx, rx, ry, rw, rh, null);
    let yy = ry + 12;
    const line = (txt, col, sz, b) => {
      ctx.save(); ctx.textAlign = 'left'; ctx.textBaseline = 'top';
      ctx.font = (b ? '600 ' : '') + (sz || 10.5) + `px ${FM}`; ctx.fillStyle = col || C.inkA(.8);
      ctx.fillText(txt, rx + 12, yy); ctx.restore(); yy += (sz || 10.5) + 6;
    };
    line('WHICH PEAKS APPEAR', C.inkA(.5), 9.5, 1); yy += 2;
    line('BCC   h+k+l  must be EVEN', C.pos, 11, 1);
    line('       110  200  211  220', C.inkA(.6), 10);
    yy += 4;
    line('FCC   h,k,l  all ODD or all EVEN', C.neg, 11, 1);
    line('       111  200  220  311', C.inkA(.6), 10);
    yy += 8;
    ctx.save();
    ctx.fillStyle = C.wallA(.12); ctx.strokeStyle = C.wallA(.5); ctx.lineWidth = 1;
    ctx.beginPath(); ctx.rect(rx + 8, yy - 3, rw - 16, 46); ctx.fill(); ctx.stroke(); ctx.restore();
    yy += 3;
    line('⚠  the x-axis of a diffractogram', C.wall, 10, 1);
    line('    is 2θ.  HALVE IT before Bragg.', C.wall, 10, 1);
    yy += 10;
    line('d = a / √(h²+k²+l²)', C.ink, 11, 1);

    capBlock(ctx, [['diffraction, end to end', C.ink]], 10, 6);
  }
};
