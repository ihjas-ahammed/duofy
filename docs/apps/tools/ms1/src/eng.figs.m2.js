/* ══════════════ Module II figures — crystals, defects, microstructure ══════════════ */

/* ── solidification stages of a polycrystalline material (Callister Fig 3.19) ── */
FIGS.solidification = {
  ar: (w, st) => st.opt.stage === 'all' ? (w < 540 ? 1.12 : .33) : (w < 540 ? .75 : .48),
  arN: 1.12, opt: { stage: 'all' },
  chips: [
    { sep: 'stage' },
    { label: 'all 4 stages', set: { stage: 'all' } },
    { label: '(a) nuclei', set: { stage: 'a' } },
    { label: '(b) growth', set: { stage: 'b' } },
    { label: '(c) impingement', set: { stage: 'c' } },
    { label: '(d) grain boundaries', set: { stage: 'd' } }
  ],
  draw(ctx, W, H, st) {
    const stage = st.opt.stage, narrow = W < 540;
    ctx.clearRect(0, 0, W, H);
    const R = rng(42);
    const key = 'sol_' + W + '_' + H;
    if (!st.memo[key]) {
      const seeds = [
        [0.2, 0.3], [0.35, 0.75], [0.65, 0.25], [0.8, 0.7],
        [0.15, 0.85], [0.5, 0.5], [0.85, 0.2], [0.4, 0.15]
      ];
      const angles = seeds.map(() => R() * Math.PI * 2);
      st.memo[key] = { seeds, angles };
    }
    const { seeds, angles } = st.memo[key];

    const stages = stage === 'all' ? ['a', 'b', 'c', 'd'] : [stage];
    const n = stages.length;
    const cols = n === 4 ? (narrow ? 2 : 4) : 1;
    const rows = Math.ceil(n / cols);
    const pw = (W - (cols + 1) * 8) / cols;
    const ph = (H - (rows + 1) * 8 - 24) / rows;

    const titles = {
      a: '(a) Nuclei form in melt',
      b: '(b) Crystallites grow',
      c: '(c) Grains impinge',
      d: '(d) Polycrystalline grains (etched)'
    };

    stages.forEach((stg, idx) => {
      const c = idx % cols, r = Math.floor(idx / cols);
      const x0 = 8 + c * (pw + 8), y0 = 24 + r * (ph + 8);

      ctx.save();
      ctx.fillStyle = C.plotBg || C.bg;
      ctx.strokeStyle = C.rule || C.grid;
      ctx.lineWidth = 1.2;
      ctx.fillRect(x0, y0, pw, ph);
      ctx.strokeRect(x0, y0, pw, ph);

      ctx.fillStyle = C.ink;
      ctx.textAlign = 'left';
      let tf = 11;                                   /* "(d) Polycrystalline grains (etched)" overflowed its panel */
      ctx.font = '600 ' + tf + 'px ' + FD;
      const tw = ctx.measureText(titles[stg]).width;
      if (tw > pw - 12) { tf = Math.max(7.5, tf * (pw - 12) / tw); ctx.font = '600 ' + tf.toFixed(1) + 'px ' + FD; }
      ctx.fillText(titles[stg], x0 + 6, y0 + 14);

      const cx = x0 + pw / 2, cy = y0 + 16 + (ph - 16) / 2;
      const rad = Math.min(pw, ph - 16) * 0.42;

      ctx.save();
      ctx.beginPath();
      ctx.arc(cx, cy, rad, 0, Math.PI * 2);
      ctx.clip();
      ctx.fillStyle = C.panel || C.bg;
      ctx.fillRect(cx - rad, cy - rad, rad * 2, rad * 2);

      if (stg === 'a') {
        seeds.forEach((s, i) => {
          const sx = cx - rad + s[0] * rad * 2, sy = cy - rad + s[1] * rad * 2;
          ctx.fillStyle = C.pos;
          ctx.strokeStyle = C.ink;
          ctx.lineWidth = 1;
          const sz = 7;
          ctx.save();
          ctx.translate(sx, sy);
          ctx.rotate(angles[i]);
          ctx.fillRect(-sz / 2, -sz / 2, sz, sz);
          ctx.strokeRect(-sz / 2, -sz / 2, sz, sz);
          ctx.restore();
        });
      } else if (stg === 'b') {
        seeds.forEach((s, i) => {
          const sx = cx - rad + s[0] * rad * 2, sy = cy - rad + s[1] * rad * 2;
          ctx.save();
          ctx.translate(sx, sy);
          ctx.rotate(angles[i]);
          const sz = 24;
          ctx.fillStyle = C.posA ? C.posA(0.35) : 'rgba(176,98,36,0.35)';
          ctx.strokeStyle = C.pos;
          ctx.lineWidth = 1.4;
          ctx.fillRect(-sz / 2, -sz / 2, sz, sz);
          ctx.strokeRect(-sz / 2, -sz / 2, sz, sz);
          ctx.strokeStyle = C.posA ? C.posA(0.6) : 'rgba(176,98,36,0.6)';
          ctx.lineWidth = 0.8;
          for (let g = -sz / 2 + 4; g < sz / 2; g += 5) {
            ctx.beginPath(); ctx.moveTo(g, -sz / 2); ctx.lineTo(g, sz / 2); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(-sz / 2, g); ctx.lineTo(sz / 2, g); ctx.stroke();
          }
          ctx.restore();
        });
      } else if (stg === 'c' || stg === 'd') {
        const vorSeeds = seeds.map(s => [cx - rad + s[0] * rad * 2, cy - rad + s[1] * rad * 2]);
        const step = 3;
        for (let gx = cx - rad; gx <= cx + rad; gx += step) {
          for (let gy = cy - rad; gy <= cy + rad; gy += step) {
            if (Math.hypot(gx - cx, gy - cy) > rad) continue;
            let best = 0, bd = 1e9;
            vorSeeds.forEach((vs, vi) => {
              const d = Math.hypot(gx - vs[0], gy - vs[1]);
              if (d < bd) { bd = d; best = vi; }
            });
            ctx.fillStyle = stg === 'c'
              ? (best % 2 === 0 ? (C.posA ? C.posA(0.2) : '#f0e0d0') : (C.blueA ? C.blueA(0.2) : '#d0e0f0'))
              : (best % 3 === 0 ? (C.panel || '#eaeaea') : (best % 3 === 1 ? (C.bench || '#ffffff') : (C.panel2 || '#dfdfdf')));
            ctx.fillRect(gx, gy, step, step);
          }
        }
        for (let vi = 0; vi < vorSeeds.length; vi++) {
          for (let vj = vi + 1; vj < vorSeeds.length; vj++) {
            const A = vorSeeds[vi], B = vorSeeds[vj];
            const mx = (A[0] + B[0]) / 2, my = (A[1] + B[1]) / 2;
            const dx = B[0] - A[0], dy = B[1] - A[1];
            const len = Math.hypot(dx, dy);
            if (len > rad * 1.1) continue;
            const nx = -dy / len, ny = dx / len;
            ctx.strokeStyle = stg === 'd' ? (C.ink || '#111') : (C.wall || '#c00');
            ctx.lineWidth = stg === 'd' ? 2.2 : 1.4;
            ctx.beginPath();
            ctx.moveTo(mx - nx * 24, my - ny * 24);
            ctx.lineTo(mx + nx * 24, my + ny * 24);
            ctx.stroke();
          }
        }
      }

      ctx.restore();
      ctx.strokeStyle = C.axis || C.dim;
      ctx.lineWidth = 1.5;
      ctx.beginPath();
      ctx.arc(cx, cy, rad, 0, Math.PI * 2);
      ctx.stroke();

      ctx.restore();
    });
  }
};

/* ── Directional Elastic Modulus (Anisotropy) in Single Crystals (Callister Table 3.7) ── */
FIGS.anisotropy = {
  ar: .48, arN: .95, opt: { mat: 'Cu' },
  chips: [
    { sep: 'material' },
    { label: 'Copper (highly anisotropic)', set: { mat: 'Cu' } },
    { label: 'Iron (anisotropic)', set: { mat: 'Fe' } },
    { label: 'Aluminum (mild)', set: { mat: 'Al' } },
    { label: 'Tungsten (isotropic)', set: { mat: 'W' } }
  ],
  draw(ctx, W, H, st) {
    const mat = st.opt.mat, narrow = W < 520;
    ctx.clearRect(0, 0, W, H);
    const DATA = {
      Cu: { name: 'Copper', E100: 66.7, E110: 130.3, E111: 191.1, ratio: '2.87×', col: C.pos },
      Fe: { name: 'α-Iron', E100: 125.0, E110: 210.5, E111: 272.7, ratio: '2.18×', col: C.blue },
      Al: { name: 'Aluminum', E100: 63.7, E110: 72.6, E111: 76.1, ratio: '1.19×', col: C.green },
      W:  { name: 'Tungsten', E100: 384.6, E110: 384.6, E111: 384.6, ratio: '1.00× (isotropic)', col: C.amber }
    };
    const cur = DATA[mat] || DATA.Cu;

    const pw = narrow ? W : W * 0.58;
    const P = Plot(ctx, pw, H, { l: 20, r: 20, t: 36, b: 30 });
    P.clear();
    const maxE = Math.max(cur.E111, cur.E100) * 1.35;
    P.dom(-maxE, maxE).ran(-maxE, maxE);

    const circles = [100, 200, 300, 400].filter(v => v <= maxE);
    circles.forEach(r => {
      ctx.strokeStyle = C.grid;
      ctx.lineWidth = 0.8;
      ctx.beginPath();
      ctx.arc(P.X(0), P.Y(0), Math.abs(P.X(r) - P.X(0)), 0, Math.PI * 2);
      ctx.stroke();
      P.text(P.X(0) + 4, P.Y(r) - 2, r + ' GPa', C.faint, { d: 1, sz: 9 });
    });

    P.line(-maxE, 0, maxE, 0, C.axis, 1);
    P.line(0, -maxE, 0, maxE, C.axis, 1);
    P.label(maxE * 0.88, 0, ' [100]', C.ink, { b: 1, sz: 11 });
    P.label(0, maxE * 0.88, ' [010]', C.ink, { b: 1, sz: 11 });
    P.label(maxE * 0.65, maxE * 0.65, ' [110]', C.prob, { b: 1, sz: 11 });

    ctx.beginPath();
    const pts = 120;
    for (let i = 0; i <= pts; i++) {
      const a = (i / pts) * Math.PI * 2;
      const sin2 = Math.sin(2 * a);
      const val = cur.E100 + (cur.E110 - cur.E100) * (sin2 * sin2);
      const x = val * Math.cos(a), y = val * Math.sin(a);
      if (i === 0) ctx.moveTo(P.X(x), P.Y(y));
      else ctx.lineTo(P.X(x), P.Y(y));
    }
    ctx.closePath();
    ctx.fillStyle = cur.col ? (C[cur.col + 'A'] ? C[cur.col + 'A'](0.2) : 'rgba(176,98,36,0.18)') : 'rgba(176,98,36,0.18)';
    ctx.fill();
    ctx.strokeStyle = cur.col || C.pos;
    ctx.lineWidth = 2.4;
    ctx.stroke();

    P.text(P.box.x0, 10, cur.name + ' — Elastic Modulus Directional Surface (001) Plane', C.ink, { d: 1, b: 1, sz: 12 });

    if (!narrow) {
      const sx = pw + 10, sy = 40;
      ctx.font = '600 13px ' + FD;
      ctx.fillStyle = C.ink;
      ctx.textAlign = 'left';
      ctx.fillText('Directional Modulus E (GPa)', sx, sy);

      const rows = [
        ['[100] cube edge', cur.E100 + ' GPa'],
        ['[110] face diagonal', cur.E110 + ' GPa'],
        ['[111] body diagonal', cur.E111 + ' GPa'],
        ['Anisotropy ratio E₁₁₁/E₁₀₀', cur.ratio]
      ];
      let ry = sy + 28;
      rows.forEach(([k, v], i) => {
        ctx.font = '11.5px ' + FD;
        ctx.fillStyle = C.dim;
        ctx.fillText(k, sx, ry);
        ctx.font = '600 12px ' + FM;
        ctx.fillStyle = i === 3 ? C.wall : C.ink;
        ctx.fillText(v, sx + 175, ry);
        ry += 24;
      });

      ry += 10;
      ctx.font = '11px ' + FD;
      ctx.fillStyle = C.dim;
      const wrapTxt = mat === 'W'
        ? 'Tungsten is uniquely isotropic (ratio 1.00); its stiffness is identical in all directions.'
        : cur.name + ' is stiffest along the close-packed body diagonal [111] and most compliant along [100].';
      ctx.fillText(wrapTxt, sx, ry, W - sx - 20);
    }
  }
};

/* ── Bragg's Law & Wave Interference (Callister Fig 3.20 & 3.21) ── */
FIGS.bragg = {
  ar: .65, arN: 1.05, opt: { thDeg: 30, dVal: 0.28 },
  chips: [
    { sep: 'angle θ' },
    { label: 'θ = 30° (Bragg peak)', set: { thDeg: 30 } },
    { label: 'θ = 24° (destructive off-peak)', set: { thDeg: 24 } },
    { label: 'θ = 36° (destructive off-peak)', set: { thDeg: 36 } }
  ],
  draw(ctx, W, H, st) {
    const narrow = W < 540;
    ctx.clearRect(0, 0, W, H);
    const th = (st.opt.thDeg * Math.PI) / 180;
    const d = 55;                                    /* plane spacing in world units, for the drawing */
    const lam = 2 * d * Math.sin((30 * Math.PI) / 180);       /* same λ in world units, for the wave */
    const dNM = st.opt.dVal;                         /* the same spacing in nm, for the numbers */
    const lamNM = 2 * dNM * Math.sin((30 * Math.PI) / 180);   /* λ set so θ = 30° is the n = 1 peak */
    const pathNM = 2 * dNM * Math.sin(th);

    const pw = narrow ? W : W * 0.65;
    const ph = narrow ? H * 0.62 : H;
    const P = Plot(ctx, pw, ph, { l: 20, r: 20, t: 34, b: 24 });
    P.clear().dom(-100, 100).ran(-70, 70);

    P.text(12, 10, 'nλ = 2d sin θ   ·   d = ' + dNM.toFixed(2) + ' nm,  λ = ' + lamNM.toFixed(3) + ' nm   →   2d sin θ = ' + pathNM.toFixed(3) + ' nm', C.ink, { d: 1, b: 1, sz: 12 });

    const yA = 20, yB = yA - d;

    P.line(-90, yA, 90, yA, C.rule, 1.2, [4, 4]);
    P.line(-90, yB, 90, yB, C.rule, 1.2, [4, 4]);
    P.label(92, yA, 'Plane 1', C.faint, { sz: 10 });
    P.label(92, yB, 'Plane 2', C.faint, { sz: 10 });

    for (let x = -80; x <= 80; x += 32) {
      P.circle(x, yA, 5.5, C.pos, C.ink, 1);
      P.circle(x, yB, 5.5, C.pos, C.ink, 1);
    }

    P.arrow(-85, yA, -85, yB, C.prob, 1.5);
    P.arrow(-85, yB, -85, yA, C.prob, 1.5);
    P.label(-88, (yA + yB) / 2, 'd', C.prob, { b: 1, sz: 11, align: 'right' });

    const Lray = 75;
    const xIn = -Lray * Math.cos(th), yIn = yA + Lray * Math.sin(th);
    const xOut = Lray * Math.cos(th), yOut = yA + Lray * Math.sin(th);
    P.arrow(xIn, yIn, 0, yA, C.blue, 2);
    P.arrow(0, yA, xOut, yOut, C.blue, 2);

    const xIn2 = -Lray * Math.cos(th), yIn2 = yB + Lray * Math.sin(th);
    const xOut2 = Lray * Math.cos(th), yOut2 = yB + Lray * Math.sin(th);
    P.arrow(xIn2, yIn2, 0, yB, C.amber, 2);
    P.arrow(0, yB, xOut2, yOut2, C.amber, 2);

    const sDist = d * Math.sin(th);
    const Sx = -sDist * Math.cos(th), Sy = yB + sDist * Math.sin(th);
    const Tx = sDist * Math.cos(th), Ty = yB + sDist * Math.sin(th);

    P.line(0, yA, Sx, Sy, C.wall, 1.5, [3, 2]);
    P.line(0, yA, Tx, Ty, C.wall, 1.5, [3, 2]);
    P.circle(Sx, Sy, 2.5, C.wall);
    P.circle(Tx, Ty, 2.5, C.wall);
    P.label(Sx - 4, Sy - 3, 'S', C.wall, { b: 1, sz: 10 });
    P.label(Tx + 4, Ty - 3, 'T', C.wall, { b: 1, sz: 10 });
    P.label(0, yB - 8, 'Q', C.ink, { b: 1, sz: 10 });

    P.label(-35, yA + 5, 'θ=' + st.opt.thDeg + '°', C.blue, { sz: 10 });

    const pathDiff = 2 * d * Math.sin(th);
    const isBragg = Math.abs(st.opt.thDeg - 30) < 1;

    const rx0 = narrow ? 16 : pw + 10, rw = narrow ? W - 32 : W - rx0 - 15;
    const cyWave = narrow ? H * 0.78 : H * 0.52;
    ctx.font = '600 12px ' + FD;
    ctx.fillStyle = C.ink;
    ctx.textAlign = 'left';
    ctx.fillText('Scattered Wave Interference', rx0, narrow ? H * 0.65 : 30);

    ctx.strokeStyle = C.grid;
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(rx0, cyWave);
    ctx.lineTo(rx0 + rw, cyWave);
    ctx.stroke();

    ctx.beginPath();
    const wavePts = 80;
    const phaseDiff = (pathDiff / lam) * Math.PI * 2;
    const amp = isBragg ? (narrow ? 22 : 34) : Math.max(3, Math.abs(Math.cos(phaseDiff / 2)) * (narrow ? 22 : 34));

    for (let i = 0; i <= wavePts; i++) {
      const wx = rx0 + (i / wavePts) * rw;
      const wy = cyWave - Math.sin((i / wavePts) * Math.PI * 4) * amp;
      if (i === 0) ctx.moveTo(wx, wy);
      else ctx.lineTo(wx, wy);
    }
    ctx.strokeStyle = isBragg ? C.green : C.wall;
    ctx.lineWidth = 2.5;
    ctx.stroke();

    ctx.font = '600 11.5px ' + FM;
    ctx.fillStyle = isBragg ? C.green : C.wall;
    ctx.fillText(isBragg ? 'CONSTRUCTIVE (In-Phase)' : 'DESTRUCTIVE (Out-of-Phase)', rx0, cyWave + (narrow ? 26 : 48));

    ctx.font = '10.5px ' + FD;
    ctx.fillStyle = C.dim;
    ctx.fillText('Path extra = 2d sin θ ' + (isBragg ? '= 1.00 λ (peak)' : '≠ integer λ (cancelled)'), rx0, cyWave + (narrow ? 42 : 68));
  }
};

/* ── Powder XRD Diffractogram & Selection Rules (Callister Fig 3.23) ── */
FIGS.xrdpeaks = {
  ar: .65, arN: 1.0, opt: { sample: 'Pb' },
  chips: [
    { sep: 'sample' },
    { label: 'Lead (FCC, λ = 0.1542 nm)', set: { sample: 'Pb' } },
    { label: 'α-Iron (BCC, λ = 0.1790 nm)', set: { sample: 'Fe' } }
  ],
  draw(ctx, W, H, st) {
    const s = st.opt.sample;
    ctx.clearRect(0, 0, W, H);
    const P = Plot(ctx, W, H, { l: 45, r: 20, t: 38, b: 34 });

    if (s === 'Pb') {
      P.clear().dom(25, 75).ran(0, 132).axes({ xl: 'Diffraction angle 2θ (degrees)', yl: 'Intensity (a.u.)' });
      P.xticks([30, 40, 50, 60, 70], v => v + '°');

      const peaks = [
        { th2: 31.3, hkl: '(111)', relI: 100 },
        { th2: 36.6, hkl: '(200)', relI: 46 },
        { th2: 52.6, hkl: '(220)', relI: 32 },
        { th2: 62.5, hkl: '(311)', relI: 38 },
        { th2: 65.5, hkl: '(222)', relI: 14 }
      ];

      ctx.beginPath();
      for (let x = 25; x <= 75; x += 0.5) {
        let y = 6 + Math.sin(x * 1.5) * 2;
        peaks.forEach(pk => {
          const dx = (x - pk.th2) / 0.35;
          y += pk.relI * Math.exp(-dx * dx);
        });
        const px = P.X(x), py = P.Y(y);
        if (x === 25) ctx.moveTo(px, py);
        else ctx.lineTo(px, py);
      }
      ctx.strokeStyle = C.blue;
      ctx.lineWidth = 1.8;
      ctx.stroke();

      peaks.forEach(pk => {
        P.label(pk.th2, pk.relI + 8, pk.hkl, C.ink, { b: 1, sz: 10.5, align: 'center' });
      });

      capBlock(ctx, [
        ['Lead (FCC) Powder XRD Pattern — λ = 0.1542 nm (Cu Kα)', C.ink],
        ['FCC reflection rule: h, k, l all odd or all even', C.green],
        ['Lattice parameter a = 0.495 nm computed from peaks', C.dim]
      ], 50, 10);

    } else {
      P.clear().dom(40, 135).ran(0, 132).axes({ xl: 'Diffraction angle 2θ (degrees)', yl: 'Intensity (a.u.)' });
      P.xticks([50, 70, 90, 110, 130], v => v + '°');

      const peaks = [
        { th2: 52.4, hkl: '(110)', relI: 100 },
        { th2: 77.2, hkl: '(200)', relI: 20 },
        { th2: 99.6, hkl: '(211)', relI: 35 },
        { th2: 124.3, hkl: '(220)', relI: 12 }
      ];

      ctx.beginPath();
      for (let x = 40; x <= 135; x += 0.5) {
        let y = 6 + Math.sin(x * 1.5) * 2;
        peaks.forEach(pk => {
          const dx = (x - pk.th2) / 0.5;
          y += pk.relI * Math.exp(-dx * dx);
        });
        const px = P.X(x), py = P.Y(y);
        if (x === 40) ctx.moveTo(px, py);
        else ctx.lineTo(px, py);
      }
      ctx.strokeStyle = C.pos;
      ctx.lineWidth = 1.8;
      ctx.stroke();

      peaks.forEach(pk => {
        P.label(pk.th2, pk.relI + 8, pk.hkl, C.ink, { b: 1, sz: 10.5, align: 'center' });
      });

      capBlock(ctx, [
        ['α-Iron (BCC) Powder XRD Pattern — λ = 0.1790 nm (Co Kα)', C.ink],
        ['BCC reflection rule: (h + k + l) must be EVEN', C.green],
        ['Lattice parameter a = 0.2866 nm', C.dim]
      ], 50, 10);
    }
  }
};

/* ── Crystalline vs Amorphous SiO2 Network (Callister Fig 3.24) ── */
FIGS.sio2glass = {
  ar: .56, arN: .95, opt: { mode: 'both' },
  chips: [
    { sep: 'structure' },
    { label: 'side-by-side comparison', set: { mode: 'both' } },
    { label: 'crystalline (quartz)', set: { mode: 'cryst' } },
    { label: 'amorphous (silica glass)', set: { mode: 'glass' } }
  ],
  draw(ctx, W, H, st) {
    const mode = st.opt.mode, narrow = W < 540;
    ctx.clearRect(0, 0, W, H);
    const half = (mode === 'both' && !narrow);
    const pw = half ? W * 0.49 : W;

    const drawCryst = (x0, y0, w, h) => {
      ctx.save();
      ctx.font = '600 12px ' + FD;
      ctx.fillStyle = C.ink;
      ctx.fillText('Crystalline SiO₂ (Quartz) — Long-range order', x0 + 10, y0 + 18);

      const R = narrow ? 18 : 22;
      const cy0 = y0 + h * 0.55;
      for (let row = -2; row <= 2; row++) {
        for (let col = -3; col <= 3; col++) {
          const cx = x0 + w / 2 + col * R * 1.732 + (row % 2 ? (R * 1.732) / 2 : 0);
          const cy = cy0 + row * R * 1.5;
          if (cx < x0 + 20 || cx > x0 + w - 20 || cy < y0 + 25 || cy > y0 + h - 10) continue;

          ctx.strokeStyle = C.rule;
          ctx.lineWidth = 1.4;
          ctx.beginPath();
          for (let i = 0; i < 6; i++) {
            const a = (i * Math.PI) / 3;
            const hx = cx + R * Math.cos(a), hy = cy + R * Math.sin(a);
            if (i === 0) ctx.moveTo(hx, hy);
            else ctx.lineTo(hx, hy);
          }
          ctx.stroke();

          for (let i = 0; i < 6; i++) {
            const a = (i * Math.PI) / 3;
            const sx = cx + R * Math.cos(a), sy = cy + R * Math.sin(a);
            ctx.fillStyle = C.pos;
            ctx.beginPath(); ctx.arc(sx, sy, 3.8, 0, Math.PI * 2); ctx.fill();

            const ox = cx + R * Math.cos(a + Math.PI / 6) * 0.866;
            const oy = cy + R * Math.sin(a + Math.PI / 6) * 0.866;
            ctx.fillStyle = C.neg;
            ctx.beginPath(); ctx.arc(ox, oy, 2.6, 0, Math.PI * 2); ctx.fill();
          }
        }
      }
      ctx.restore();
    };

    const drawGlass = (x0, y0, w, h) => {
      ctx.save();
      ctx.font = '600 12px ' + FD;
      ctx.fillStyle = C.ink;
      ctx.fillText('Amorphous SiO₂ (Glass) — Random network', x0 + 10, y0 + 18);

      const cy0 = y0 + h * 0.55;
      const R = rng(19);
      const nodes = [];
      const stepX = narrow ? 32 : 38, stepY = narrow ? 28 : 34;
      for (let r = -2; r <= 2; r++) {
        for (let c = -3; c <= 3; c++) {
          const nx = x0 + w / 2 + c * stepX + (R() - 0.5) * 14;
          const ny = cy0 + r * stepY + (R() - 0.5) * 14;
          if (nx > x0 + 15 && nx < x0 + w - 15 && ny > y0 + 30 && ny < y0 + h - 12) {
            nodes.push([nx, ny]);
          }
        }
      }
      ctx.strokeStyle = C.rule;
      ctx.lineWidth = 1.3;
      for (let i = 0; i < nodes.length; i++) {
        for (let j = i + 1; j < nodes.length; j++) {
          const d = Math.hypot(nodes[i][0] - nodes[j][0], nodes[i][1] - nodes[j][1]);
          if (d < (narrow ? 40 : 46)) {
            ctx.beginPath();
            ctx.moveTo(nodes[i][0], nodes[i][1]);
            ctx.lineTo(nodes[j][0], nodes[j][1]);
            ctx.stroke();
            const mx = (nodes[i][0] + nodes[j][0]) / 2;
            const my = (nodes[i][1] + nodes[j][1]) / 2;
            ctx.fillStyle = C.neg;
            ctx.beginPath(); ctx.arc(mx, my, 2.6, 0, Math.PI * 2); ctx.fill();
          }
        }
      }
      nodes.forEach(p => {
        ctx.fillStyle = C.pos;
        ctx.beginPath(); ctx.arc(p[0], p[1], 3.8, 0, Math.PI * 2); ctx.fill();
      });
      ctx.restore();
    };

    if (mode === 'cryst') drawCryst(0, 0, W, H);
    else if (mode === 'glass') drawGlass(0, 0, W, H);
    else {
      if (narrow) {
        drawCryst(0, 0, W, H * 0.49);
        ctx.strokeStyle = C.grid;
        ctx.beginPath(); ctx.moveTo(10, H * 0.5); ctx.lineTo(W - 10, H * 0.5); ctx.stroke();
        drawGlass(0, H * 0.51, W, H * 0.49);
      } else {
        drawCryst(0, 0, pw, H);
        ctx.strokeStyle = C.grid;
        ctx.beginPath(); ctx.moveTo(pw, 10); ctx.lineTo(pw, H - 10); ctx.stroke();
        drawGlass(pw + 10, 0, pw, H);
      }
    }
  }
};

/* ── Point Defects: Vacancies and Interstitials (Callister Fig 4.1) ── */
FIGS.vacancies = {
  ar: .46, arN: .95, opt: { kind: 'both' },
  chips: [
    { sep: 'defect' },
    { label: 'vacancy & self-interstitial', set: { kind: 'both' } },
    { label: 'vacancy curve Nv(T)', set: { kind: 'curve' } }
  ],
  draw(ctx, W, H, st) {
    const k = st.opt.kind, narrow = W < 520;
    ctx.clearRect(0, 0, W, H);

    if (k === 'curve') {
      const P = Plot(ctx, W, H, { l: 50, r: 20, t: 36, b: 32 });
      P.clear().dom(300, 1400).ran(0, 1.2e-4).axes({ xl: 'Temperature T (K)', yl: 'Vacancy fraction N_v / N' });
      P.xticks([400, 600, 800, 1000, 1200, 1356], v => v === 1356 ? '1356 (Tm)' : v + ' K');
      P.yticks([0, 0.2e-4, 0.4e-4, 0.6e-4, 0.8e-4, 1.0e-4], v => (v * 1e4).toFixed(1) + '×10⁻⁴');

      P.plot(T => Math.exp(-0.9 / (8.62e-5 * T)), C.pos, 2.2);
      P.vline(1356, C.wallA ? C.wallA(0.5) : '#f00', 1, [3, 3]);
      P.label(1330, 0.9e-4, 'Near melting point:\nNv/N ≈ 10⁻⁴ (1 in 10,000)', C.wall, { b: 1, sz: 10.5, align: 'right' });

      capBlock(ctx, [
        ['Equilibrium Vacancy Concentration: N_v = N·exp(−Q_v / kT)', C.ink],
        ['Boltzmann factor: defects are thermodynamically stable because entropy increases', C.dim]
      ], 55, 10);
      return;
    }

    const pw = narrow ? W : W * 0.62;
    const P = Plot(ctx, pw, H, { l: 20, r: 20, t: 30, b: 20 });
    P.clear().dom(-5, 5).ran(-4, 4);

    P.text(12, 10, 'Point Defects: missing atom (vacancy) vs extra atom (self-interstitial)', C.ink, { d: 1, b: 1, sz: 11.5 });

    const vacPos = [-2, 0];
    const intPos = [2.5, 0.5];

    for (let x = -4; x <= 4; x++) {
      for (let y = -3; y <= 3; y++) {
        if (x === vacPos[0] && y === vacPos[1]) continue;
        let dx = 0, dy = 0;
        const dVac = Math.hypot(x - vacPos[0], y - vacPos[1]);
        if (dVac < 1.6 && dVac > 0.1) {
          dx += (vacPos[0] - x) * 0.14;
          dy += (vacPos[1] - y) * 0.14;
        }
        const dInt = Math.hypot(x - intPos[0], y - intPos[1]);
        if (dInt < 1.8 && dInt > 0.1) {
          dx -= (intPos[0] - x) * 0.22;
          dy -= (intPos[1] - y) * 0.22;
        }
        P.circle(x + dx, y + dy, 7, C.pos, C.ink, 1);
      }
    }

    P.circle(vacPos[0], vacPos[1], 7, 'transparent', C.wall, 1.6, [3, 2]);
    P.circle(intPos[0], intPos[1], 5.8, C.neg, C.ink, 1.5);

    /* callouts sit outside the lattice and point in, so they never cover an atom */
    P.seg(vacPos[0], vacPos[1] - 0.45, vacPos[0], -3.3, C.wallA(.6), 1, [3, 2]);
    P.label(vacPos[0], -3.45, 'vacancy — neighbours relax inward', C.wall, { b: 1, sz: 10, align: 'center' });

    P.seg(intPos[0], intPos[1] + 0.45, intPos[0], 3.3, C.negA(.6), 1, [3, 2]);
    P.label(intPos[0] - 0.7, 3.85, 'self-interstitial — large strain', C.neg, { b: 1, sz: 10, align: 'center' });

    if (!narrow) {
      const sx = pw + 10, sy = 40;
      ctx.font = '600 12.5px ' + FD;
      ctx.fillStyle = C.ink;
      ctx.textAlign = 'left';
      ctx.fillText('Defect Characteristics', sx, sy);

      const notes = [
        ['Vacancy', 'A missing host atom from regular site.'],
        ['Thermodynamics', 'Stable: increases crystal entropy S.'],
        ['Self-interstitial', 'Extra host atom in tiny void.'],
        ['Distortion', 'Much larger strain than vacancy.'],
        ['Concentration', 'Self-interstitials are extremely rare!']
      ];
      let ny = sy + 26;
      notes.forEach(([t, d]) => {
        ctx.font = '600 11px ' + FD;
        ctx.fillStyle = C.ink;
        ctx.fillText(t + ':', sx, ny);
        ctx.font = '11px ' + FD;
        ctx.fillStyle = C.dim;
        ctx.fillText(d, sx, ny + 15);
        ny += 34;
      });
    }
  }
};

/* ── Edge and Screw Dislocations (Callister Fig 4.4, 4.5) ── */
FIGS.dislocations = {
  ar: .62, arN: .98, opt: { type: 'edge' },
  chips: [
    { sep: 'dislocation' },
    { label: 'edge dislocation (extra half-plane)', set: { type: 'edge' } },
    { label: 'screw dislocation (helical ramp)', set: { type: 'screw' } }
  ],
  draw(ctx, W, H, st) {
    const isEdge = st.opt.type === 'edge';
    ctx.clearRect(0, 0, W, H);
    const P = Plot(ctx, W, H, { l: 20, r: 20, t: 34, b: 24 });

    if (isEdge) {
      P.clear().dom(-5, 5).ran(-4, 4);
      P.text(12, 10, 'Edge Dislocation (⊥) — Extra half-plane of atoms ending at slip plane', C.ink, { d: 1, b: 1, sz: 11.5 });

      P.line(-4.5, 0, 4.5, 0, C.wall, 1.5, [4, 3]);
      P.label(4.5, 0.12, 'Slip plane', C.wall, { sz: 10, align: 'right' });

      for (let y = 1; y <= 3; y++) {
        for (let x = -4; x <= 4; x++) {
          const comp = x === 0 ? 0 : (x > 0 ? -0.1 : 0.1);
          const col = (x === 0) ? C.wall : C.pos;
          P.circle(x * 0.95 + comp, y * 0.9, 6.5, col, C.ink, 1);
        }
      }
      /* the rows below the slip plane drop a little further, clearing a band for the Burgers arrow */
      for (let y = -1; y >= -3; y--) {
        for (let x = -3.5; x <= 3.5; x += 1.0) {
          P.circle(x * 1.05, y * 0.9 - 0.35, 6.5, C.pos, C.ink, 1);
        }
      }

      P.label(0, 0.45, '⊥', C.wall, { b: 1, sz: 20, align: 'center' });

      P.label(0, 3.2, 'COMPRESSION (crowded atoms)', C.wall, { b: 1, sz: 10, align: 'center' });
      P.label(0, -3.55, 'TENSION (stretched atoms)', C.blue, { b: 1, sz: 10, align: 'center' });

      P.arrow(-1.5, -0.45, 1.5, -0.45, C.green, 2.5);
      P.label(0, -0.95, 'Burgers vector b ⊥ dislocation line', C.green, { b: 1, sz: 11, align: 'center' });

    } else {
      P.clear().dom(-6, 6).ran(-4, 4);
      P.text(12, 10, 'Screw Dislocation — Shear deformation produces helical atomic ramp (b ∥ line)', C.ink, { d: 1, b: 1, sz: 11.5 });

      const colBlock = C.panel || C.bg;
      ctx.fillStyle = colBlock;
      ctx.strokeStyle = C.axis || C.ink;
      ctx.lineWidth = 1.5;

      const iso = (x, y, z) => [P.X(x * 0.8 - z * 0.5), P.Y(y * 0.8 + z * 0.3)];
      const drawQuad = (p1, p2, p3, p4, fill) => {
        ctx.beginPath();
        const a = iso(...p1), b = iso(...p2), c = iso(...p3), d = iso(...p4);
        ctx.moveTo(a[0], a[1]); ctx.lineTo(b[0], b[1]); ctx.lineTo(c[0], c[1]); ctx.lineTo(d[0], d[1]);
        ctx.closePath();
        if (fill) { ctx.fillStyle = fill; ctx.fill(); }
        ctx.stroke();
      };

      drawQuad([-3, 2, -2], [3, 2, -2], [3, 2, 2], [-3, 2, 2], C.bench);
      drawQuad([-3, -2, 2], [3, -2, 2], [3, 2, 2], [-3, 2, 2], C.panel);

      P.arrow(0, -0.5, 0, 1.5, C.green, 3);
      P.label(0.4, 0.5, 'b (parallel to line)', C.green, { b: 1, sz: 11 });

      P.label(0, -2.8, 'Dislocation line penetrates block front-to-back', C.ink, { b: 1, sz: 11, align: 'center' });
    }
  }
};

/* ── Interfacial Defects: Tilt Boundary & Twin Boundary (Callister Fig 4.8 & 4.10) ── */
FIGS.boundaries = {
  ar: .52, arN: .92, opt: { type: 'tilt' },
  chips: [
    { sep: 'defect' },
    { label: 'small-angle tilt boundary (edge dislocation wall)', set: { type: 'tilt' } },
    { label: 'twin boundary (mirror plane)', set: { type: 'twin' } }
  ],
  draw(ctx, W, H, st) {
    const isTilt = st.opt.type === 'tilt';
    ctx.clearRect(0, 0, W, H);
    const P = Plot(ctx, W, H, { l: 20, r: 20, t: 34, b: 24 });

    if (isTilt) {
      P.clear().dom(-6, 6).ran(-3.9, 3.9);
      P.text(12, 10, 'Small-Angle Tilt Grain Boundary: array of edge dislocations (θ ≈ b / D)', C.ink, { d: 1, b: 1, sz: 11.5 });

      /* two square lattices, each rotated by ±θ/2 about the boundary, clipped to their own half */
      const half = 0.11, aL = 0.58;
      const grain = (sign, col) => {
        ctx.save();
        ctx.beginPath();
        const xa = P.X(sign < 0 ? -5.7 : 0), xb = P.X(sign < 0 ? 0 : 5.7);
        ctx.rect(Math.min(xa, xb), P.Y(3.3), Math.abs(xb - xa), Math.abs(P.Y(-3.3) - P.Y(3.3)));
        ctx.clip();
        const c = Math.cos(sign * half), sn = Math.sin(sign * half);
        for (let i = -14; i <= 14; i++) {
          for (let j = -12; j <= 12; j++) {
            const x = i * aL * c - j * aL * sn, y = i * aL * sn + j * aL * c;
            if (Math.abs(x) > 5.8 || Math.abs(y) > 3.5) continue;
            P.circle(x, y, 4.2, col, C.inkA(.45), 1);
          }
        }
        ctx.restore();
      };
      grain(-1, C.blueA(.85));
      grain(1, C.posA(.85));

      P.line(0, -3.3, 0, 3.3, C.inkA(.35), 1, [3, 3]);

      /* the mismatch is taken up by a vertical wall of edge dislocations, spacing D */
      const dislocY = [-2.2, 0, 2.2];
      dislocY.forEach(y => {
        P.label(0, y - 0.22, '⊥', C.wall, { b: 1, sz: 19, align: 'center' });
      });

      P.arrow(1.15, -2.2, 1.15, 0, C.prob, 1.4);
      P.arrow(1.15, 0, 1.15, -2.2, C.prob, 1.4);
      P.label(1.3, -1.15, 'D', C.prob, { b: 1, sz: 12 });

      P.label(-3.4, 2.95, 'Grain A  (tilted +θ/2)', C.blue, { b: 1, sz: 10.5, align: 'center' });
      P.label(3.4, 2.95, 'Grain B  (tilted −θ/2)', C.pos, { b: 1, sz: 10.5, align: 'center' });
      P.label(0, -3.72, 'misorientation θ = b / D  —  closer dislocations, bigger tilt', C.ink, { b: 1, sz: 10.5, align: 'center' });

    } else {
      P.clear().dom(-6, 6).ran(-4, 4);
      P.text(12, 10, 'Twin Boundary: mirror plane separating crystal regions with twin symmetry', C.ink, { d: 1, b: 1, sz: 11.5 });

      P.line(0, -3.6, 0, 3.6, C.wall, 2);
      P.label(0.3, 3.2, 'Twin plane (mirror)', C.wall, { b: 1, sz: 11 });

      for (let y = -3; y <= 3; y += 0.8) {
        for (let l = 1; l <= 4; l++) {
          const xL = -l * 1.1;
          const yL = y + l * 0.35;
          P.circle(xL, yL, 6, C.blue, C.ink, 1);

          const xR = l * 1.1;
          const yR = y - l * 0.35;
          P.circle(xR, yR, 6, C.pos, C.ink, 1);
        }
      }
      P.label(-3, -2.8, 'Parent crystal', C.blue, { b: 1, sz: 11, align: 'center' });
      P.label(3, -2.8, 'Twin crystal', C.pos, { b: 1, sz: 11, align: 'center' });
    }
  }
};

/* ── ASTM Grain Size Intercept Method (Callister Fig 4.18 & Example 4.5) ── */
FIGS.grainsize = {
  ar: .65, arN: 1.0, opt: { count: 'done' },
  draw(ctx, W, H, st) {
    const narrow = W < 540;
    ctx.clearRect(0, 0, W, H);
    const pw = narrow ? W : W * 0.58;

    const R = rng(15);
    const seeds = scatter(24, [0, 0, pw, H], 35, R);
    const cells = voronoi(seeds, [0, 0, pw, H]);

    ctx.save();
    cells.forEach((poly, i) => {
      ctx.beginPath();
      poly.forEach((pt, j) => {
        if (j === 0) ctx.moveTo(pt[0], pt[1]);
        else ctx.lineTo(pt[0], pt[1]);
      });
      ctx.closePath();
      ctx.fillStyle = i % 3 === 0 ? (C.panel || '#ece9e2') : (i % 3 === 1 ? (C.bench || '#fff') : (C.panel2 || '#e2ded5'));
      ctx.fill();
      ctx.strokeStyle = C.ink;
      ctx.lineWidth = 1.6;
      ctx.stroke();
    });

    const testLines = [H * 0.28, H * 0.52, H * 0.76];
    testLines.forEach(ly => {
      ctx.strokeStyle = C.wall;
      ctx.lineWidth = 1.8;
      ctx.setLineDash([6, 3]);
      ctx.beginPath();
      ctx.moveTo(15, ly);
      ctx.lineTo(pw - 15, ly);
      ctx.stroke();
      ctx.setLineDash([]);

      for (let x = 20; x < pw - 20; x += 18) {
        ctx.fillStyle = C.green;
        ctx.beginPath();
        ctx.arc(x, ly, 3.2, 0, Math.PI * 2);
        ctx.fill();
      }
    });
    ctx.restore();

    const barW = 80;
    ctx.fillStyle = C.ink;
    ctx.fillRect(20, H - 24, barW, 4);
    ctx.font = '600 10.5px ' + FM;
    ctx.fillText('100 µm (M = 160×)', 20, H - 28);

    if (!narrow) {
      const sx = pw + 12, sy = 34;
      ctx.font = '600 13px ' + FD;
      ctx.fillStyle = C.ink;
      ctx.textAlign = 'left';
      ctx.fillText('ASTM Intercept Method (ASTM E112)', sx, sy);

      const Pcount = 58;
      const LT = 350;
      const M = 160;
      const ell = (LT / (Pcount * M)).toFixed(4);
      const G = (-6.6457 * Math.log10(parseFloat(ell)) - 3.298).toFixed(2);

      const rows = [
        ['Total line length (LT)', LT + ' mm'],
        ['Magnification (M)', M + '×'],
        ['Total grain intercepts (P)', '' + Pcount],
        ['Mean intercept length ℓ', ell + ' mm (' + (ell * 1000).toFixed(1) + ' µm)'],
        ['ASTM Grain Size Number G', G + ' ≈ 6']
      ];

      let ry = sy + 28;
      rows.forEach(([label, val], idx) => {
        ctx.font = '11px ' + FD;
        ctx.fillStyle = C.dim;
        ctx.fillText(label, sx, ry);
        ctx.font = '600 12px ' + FM;
        ctx.fillStyle = idx === 4 ? C.green : C.ink;
        ctx.fillText(val, sx, ry + 16);
        ry += 36;
      });

      ctx.font = '11px ' + FD;
      ctx.fillStyle = C.dim;
      ctx.fillText('Equation: G = −6.6457 log₁₀(ℓ) − 3.298', sx, ry + 10);
      ctx.fillText('Grain count at 100×: n = 2^(G−1)', sx, ry + 26);
    }
  }
};

/* ── 3D Crystal Models for Module II ── */

/* FCC Interstitial Sites: Octahedral at center & edge centers, Tetrahedral inside (Callister Fig 4.3a) */
MODELS.fcc_interstitial = opt => {
  const balls = [], bonds = [], labels = [];
  const T = p => T3(p);

  const host = [];
  for (let i = 0; i < 2; i++) for (let j = 0; j < 2; j++) for (let k = 0; k < 2; k++) host.push([i, j, k]);
  [[0.5, 0.5, 0], [0.5, 0.5, 1], [0.5, 0, 0.5], [0.5, 1, 0.5], [0, 0.5, 0.5], [1, 0.5, 0.5]].forEach(p => host.push(p));
  host.forEach(p => balls.push({ c: T(p), r: 0.14, col: 'pos' }));

  boxEdges3([0, 0, 0], [1, 1, 1]).forEach(e => bonds.push({ a: T(e[0]), b: T(e[1]), col: 'rule', w: 1.2 }));

  if (opt.site !== 'tet') {
    const oct = [[0.5, 0.5, 0.5]];
    for (let d = 0; d < 3; d++) {
      for (let a = 0; a < 2; a++) {
        for (let b = 0; b < 2; b++) {
          if (d === 0) oct.push([0.5, a, b]);
          else if (d === 1) oct.push([a, 0.5, b]);
          else oct.push([a, b, 0.5]);
        }
      }
    }
    oct.forEach(p => balls.push({ c: T(p), r: 0.08, col: 'wall' }));
    labels.push({ p: T([0.5, 0.5, 0.5]), t: 'Oct (CN 6, 0.414 R)', col: 'wall', sz: 10.5 });
  } else {
    const tet = [];
    [0.25, 0.75].forEach(x => [0.25, 0.75].forEach(y => [0.25, 0.75].forEach(z => tet.push([x, y, z]))));
    tet.forEach(p => balls.push({ c: T(p), r: 0.065, col: 'green' }));
    labels.push({ p: T([0.25, 0.25, 0.25]), t: 'Tet (CN 4, 0.225 R)', col: 'green', sz: 10.5 });
  }

  return { balls, bonds, faces: [], labels };
};
V3D.fcc_interstitial = {
  model: 'fcc_interstitial', ar: .68, pitch: .25, opt: { site: 'oct' },
  chips: [
    { sep: 'site' },
    { label: 'octahedral sites (CN = 6)', set: { site: 'oct' } },
    { label: 'tetrahedral sites (CN = 4)', set: { site: 'tet' } }
  ]
};

/* BCC Interstitial Sites: Octahedral at face centers and edge centers (Callister Fig 4.3b & Example 4.2) */
MODELS.bcc_interstitial = () => {
  const balls = [], bonds = [], labels = [];
  const T = p => T3(p);

  for (let i = 0; i < 2; i++) for (let j = 0; j < 2; j++) for (let k = 0; k < 2; k++) balls.push({ c: T([i, j, k]), r: 0.15, col: 'blue' });
  balls.push({ c: T([0.5, 0.5, 0.5]), r: 0.15, col: 'blue' });

  boxEdges3([0, 0, 0], [1, 1, 1]).forEach(e => bonds.push({ a: T(e[0]), b: T(e[1]), col: 'rule', w: 1.2 }));

  const oct = [
    [0.5, 0.5, 0], [0.5, 0.5, 1], [0.5, 0, 0.5], [0.5, 1, 0.5], [0, 0.5, 0.5], [1, 0.5, 0.5]
  ];
  oct.forEach(p => balls.push({ c: T(p), r: 0.075, col: 'wall' }));
  labels.push({ p: T([0.5, 0.5, 1]), t: 'Oct site (0.155 R)', col: 'wall', sz: 10.5 });

  return { balls, bonds, faces: [], labels };
};
V3D.bcc_interstitial = { model: 'bcc_interstitial', ar: .68, pitch: .25 };
