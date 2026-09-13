/* ══════════════════════════════════════════════════════════════════
   Materials Science · Interactive Widgets
   OMR quiz · Leitner 3D flashcards · Match pairs · Fill-in · Checkpoints · Ladders
   ══════════════════════════════════════════════════════════════════ */

const WIDGETS = { omr: widgetOMR, cards: widgetCards, match: widgetMatch, fill: widgetFill };

function shellW(box, tag, title, body, foot) {
  box.classList.add('wg');
  box.innerHTML = '<div class="wh"><span class="tag">' + tag + '</span><span class="ttl">' + (title || '') + '</span><span class="sc"></span></div>' +
    '<div class="wb">' + body + '</div>' + (foot !== false ? '<div class="wf">' + (foot || '') + '</div>' : '');
  return { b: $('.wb', box), f: $('.wf', box), sc: $('.sc', box) };
}

const recordQuiz = (key, val) => {
  state.quiz = state.quiz || {};
  state.quiz[key] = val;
  persist();
};

/* ── OMR Sheet: Exam-style retrieval practice ── */
function widgetOMR(box, d, key) {
  const letters = ['A', 'B', 'C', 'D'], N = d.qs.length, long = N > 12;
  const body = '<div class="omr"><div class="rollrow">Answer sheet <i></i><i></i><i></i><i></i> fill one bubble per question</div>' +
    d.qs.map((q, i) => '<div class="q" data-q="' + i + '"><span class="qn">' + String(i + 1).padStart(2, '0') + '</span><span class="qt">' + q.q + '</span>' +
      '<div class="opts">' + q.o.map((o, j) => '<div class="opt" data-j="' + j + '"><span class="bub">' + letters[j] + '</span><span>' + o + '</span></div>').join('') + '</div>' +
      (q.why ? '<div class="why">' + q.why + '</div>' : '') + '</div>').join('') + '</div>';

  const u = shellW(box, 'OMR · ' + N + ' questions', d.title, body,
    '<button class="btn primary" data-a="mark">Submit sheet</button><button class="btn" data-a="reset">Clear</button>' +
    (long ? '<button class="btn" data-a="wrong" hidden>Only my mistakes</button>' : '') + '<span class="msg"></span>');

  if (long) box.classList.add('long');
  const sheet = $('.omr', u.b), pick = {};
  const best = () => (state.quiz || {})[key];
  const head = () => {
    const n = Object.keys(pick).length;
    u.sc.textContent = (sheet.classList.contains('marked') || !n ? '' : n + '/' + N + ' answered') +
      (best() !== undefined ? (n && !sheet.classList.contains('marked') ? ' · ' : '') + 'best ' + best() + '/' + N : '');
  };
  head();

  u.b.addEventListener('click', e => {
    if (sheet.classList.contains('marked')) return;
    const o = e.target.closest('.opt');
    if (!o) return;
    const q = o.closest('.q');
    $$('.opt', q).forEach(x => x.classList.remove('sel'));
    o.classList.add('sel');
    pick[q.dataset.q] = +o.dataset.j;
    head();
    if (Object.keys(pick).length === N && $('.msg', u.f)) {
      $('.msg', u.f).textContent = 'All answered — submit when ready.';
    }
  });

  u.f.addEventListener('click', e => {
    const a = e.target.closest('[data-a]');
    if (!a) return;
    const wb = $('[data-a="wrong"]', u.f);

    if (a.dataset.a === 'wrong') {
      sheet.classList.toggle('onlywrong');
      a.textContent = sheet.classList.contains('onlywrong') ? 'Show every question' : 'Only my mistakes';
      box.scrollIntoView({ block: 'start', behavior: 'smooth' });
      return;
    }
    if (a.dataset.a === 'reset') {
      sheet.classList.remove('marked', 'onlywrong');
      $$('.opt', sheet).forEach(x => { x.className = 'opt'; });
      $$('.q', sheet).forEach(x => { x.classList.remove('bad'); });
      for (const k in pick) delete pick[k];
      $('.msg', u.f).textContent = '';
      if (wb) { wb.hidden = true; wb.textContent = 'Only my mistakes'; }
      head();
      return;
    }
    if (sheet.classList.contains('marked')) return;
    const blank = N - Object.keys(pick).length;
    if (long && blank && !a.dataset.sure) {
      a.dataset.sure = '1';
      $('.msg', u.f).innerHTML = '<b>' + blank + ' left blank.</b> Tap Submit again to mark anyway.';
      return;
    }
    delete a.dataset.sure;
    let n = 0;
    d.qs.forEach((q, i) => {
      const row = $('.q[data-q="' + i + '"]', sheet);
      if (pick[i] !== q.a) row.classList.add('bad');
      $$('.opt', row).forEach((o, j) => {
        o.classList.remove('sel');
        if (j === q.a && pick[i] === j) { o.classList.add('right'); n++; }
        else if (pick[i] === j) o.classList.add('wrong');
        else if (j === q.a) o.classList.add('miss');
      });
    });
    sheet.classList.add('marked');
    const pct = n / N;
    $('.msg', u.f).innerHTML = '<b class="' + (pct >= 0.6 ? 'good' : 'badc') + '">' + n + '/' + N + '</b> — ' +
      (pct === 1 ? 'perfect!' : pct >= 0.6 ? 'good — read the explanation on mistakes.' : 'review the section, then retry tomorrow.');
    if (wb && n < N) wb.hidden = false;
    const b0 = best() || 0;
    if (n >= b0) recordQuiz(key, n);
    head();
    mj(sheet);
  });
}

/* ── Leitner 3D Flashcards ── */
function widgetCards(box, d, key) {
  const u = shellW(box, 'Flashcards · ' + d.list.length, d.title,
    '<div class="deck"><div class="card3d"><div class="face front"></div><div class="face back"></div></div></div>' +
    '<div class="deckbar"><button class="btn" data-a="again">✗ Again</button><button class="btn" data-a="flip">Flip</button><button class="btn primary" data-a="got">✓ Got it</button></div>' +
    '<div class="boxes"></div>', false);

  state.cards = state.cards || {};
  const L = state.cards[key] || (state.cards[key] = {});
  const c = $('.card3d', u.b);
  let order = [], i = 0, flipped = false;

  const due = () => {
    order = d.list.map((_, k) => k).sort((a, b) => (L[a] || 0) - (L[b] || 0) || ((hash(key + a) % 97) - (hash(key + b) % 97)));
    i = 0;
  };

  const face = (x, k) => '<span class="k">' + k + '</span><div class="big">' + x + '</div>';

  function show(anim) {
    const k = order[i % order.length], card = d.list[k];
    flipped = false;
    c.classList.remove('flip', 'out-r', 'out-l');
    $('.front', c).innerHTML = face(card.f, 'front · tap to flip') + '<span class="hint">swipe → got it · ← again</span>';
    $('.back', c).innerHTML = face(card.b, 'back');
    if (anim) {
      c.classList.remove('in');
      void c.offsetWidth;
      c.classList.add('in');
    }
    const counts = [0, 0, 0, 0, 0];
    d.list.forEach((_, j) => counts[Math.min(4, L[j] || 0)]++);
    $('.boxes', u.b).innerHTML = counts.map((n, b) => '<span title="Leitner box ' + (b + 1) + '">box ' + (b + 1) + ': <b>' + n + '</b></span>').join('');
    const known = d.list.filter((_, j) => (L[j] || 0) >= 1).length;
    const mastered = counts[4] + counts[3];
    u.sc.textContent = known + ' / ' + d.list.length + ' known' + (mastered ? ' (' + mastered + ' mastered)' : '');
    const b0 = (state.quiz || {})[key] || 0;
    if (known > b0) recordQuiz(key, known);
    mj(c);
  }

  const flip = () => { flipped = !flipped; c.classList.toggle('flip', flipped); };
  const grade = g => {
    const k = order[i % order.length];
    L[k] = g ? Math.min(4, (L[k] || 0) + 1) : 0;
    persist();
    c.classList.add(g ? 'out-r' : 'out-l');
    setTimeout(() => {
      i++;
      if (i >= order.length) due();
      show(true);
    }, 350);
  };

  c.addEventListener('click', flip);
  u.b.addEventListener('click', e => {
    const a = e.target.closest('[data-a]');
    if (!a) return;
    if (a.dataset.a === 'flip') flip();
    else grade(a.dataset.a === 'got');
  });

  let sx = null;
  c.addEventListener('pointerdown', e => { sx = e.clientX; });
  c.addEventListener('pointerup', e => {
    if (sx === null) return;
    const dx = e.clientX - sx; sx = null;
    if (Math.abs(dx) > 50) { e.stopPropagation(); grade(dx > 0); }
  });

  box.tabIndex = 0;
  box.addEventListener('keydown', e => {
    if (e.key === ' ') { e.preventDefault(); flip(); }
    if (e.key === 'ArrowRight') grade(true);
    if (e.key === 'ArrowLeft') grade(false);
  });

  due();
  show(false);
}

/* ── Match Pairs ── */
const PAIRC = ['#C4391D', '#2B4C91', '#237A4A', '#8A4FB3', '#B07014', '#1F7F86', '#B0306B', '#5B6B2A'];
function widgetMatch(box, d, key) {
  const L = d.pairs.map((p, i) => ({ i, t: p[0] }));
  const R = shuffle(d.pairs.map((p, i) => ({ i, t: p[1] })), hash(key));

  const u = shellW(box, 'Match the following', d.title,
    '<div class="match"><div class="colh">' + (d.left || 'Column A') + '</div><div class="colh">' + (d.right || 'Column B') + '</div>' +
    L.map((l, k) => '<div class="it" data-s="L" data-i="' + l.i + '" style="grid-column:1;grid-row:' + (k + 2) + '"><span class="pn">' + (k + 1) + '</span><span>' + l.t + '</span></div>').join('') +
    R.map((r, k) => '<div class="it" data-s="R" data-i="' + r.i + '" style="grid-column:2;grid-row:' + (k + 2) + '"><span class="pn">' + String.fromCharCode(97 + k) + '</span><span>' + r.t + '</span></div>').join('') +
    '</div>',
    '<button class="btn primary" data-a="check">Check</button><button class="btn" data-a="show">Show answers</button><button class="btn" data-a="reset">Reset</button><span class="msg"></span>');

  const pair = {};
  let pickL = null, pickR = null, col = 0;
  const colour = {};

  const paint = () => {
    $$('.it', u.b).forEach(x => {
      x.classList.remove('pick', 'ok', 'no', 'paired');
      x.style.borderColor = '';
      $('.pn', x).style.background = '';
    });
    Object.keys(pair).forEach(l => {
      const r = pair[l], c = colour[l];
      [$('.it[data-s="L"][data-i="' + l + '"]', u.b), $('.it[data-s="R"][data-i="' + r + '"]', u.b)].forEach(x => {
        if (x) {
          x.classList.add('paired');
          x.style.borderColor = c;
          $('.pn', x).style.background = c;
        }
      });
    });
    if (pickL !== null) {
      const el = $('.it[data-s="L"][data-i="' + pickL + '"]', u.b);
      if (el) el.classList.add('pick');
    }
    if (pickR !== null) {
      const el = $('.it[data-s="R"][data-i="' + pickR + '"]', u.b);
      if (el) el.classList.add('pick');
    }
  };

  u.b.addEventListener('click', e => {
    const it = e.target.closest('.it');
    if (!it) return;
    const i = +it.dataset.i;
    if (it.dataset.s === 'L') {
      if (pair[i] !== undefined) { delete pair[i]; pickL = null; }
      else pickL = pickL === i ? null : i;
    } else {
      const owner = Object.keys(pair).find(l => pair[l] === i);
      if (owner !== undefined) { delete pair[owner]; pickR = null; }
      else pickR = pickR === i ? null : i;
    }
    if (pickL !== null && pickR !== null) {
      pair[pickL] = pickR;
      colour[pickL] = PAIRC[(col++) % PAIRC.length];
      pickL = pickR = null;
    }
    paint();
  });

  u.f.addEventListener('click', e => {
    const a = e.target.closest('[data-a]');
    if (!a) return;
    if (a.dataset.a === 'reset') {
      for (const k in pair) delete pair[k];
      pickL = pickR = null;
      paint();
      $('.msg', u.f).textContent = '';
      return;
    }
    if (a.dataset.a === 'show') {
      for (const k in pair) delete pair[k];
      L.forEach(l => { pair[l.i] = l.i; colour[l.i] = PAIRC[l.i % PAIRC.length]; });
      paint();
    }
    let n = 0;
    L.forEach(l => {
      const x = $('.it[data-s="L"][data-i="' + l.i + '"]', u.b);
      if (pair[l.i] === undefined) return;
      const ok = pair[l.i] === l.i;
      if (ok) n++;
      x.classList.add(ok ? 'ok' : 'no');
      const r = $('.it[data-s="R"][data-i="' + pair[l.i] + '"]', u.b);
      if (r) r.classList.add(ok ? 'ok' : 'no');
    });
    $('.msg', u.f).innerHTML = '<b class="' + (n === L.length ? 'good' : '') + '">' + n + '/' + L.length + '</b> correct';
    if (a.dataset.a === 'check') {
      const b0 = (state.quiz || {})[key] || 0;
      if (n > b0) recordQuiz(key, n);
    }
  });
}

/* ── Fill in the Blanks ── */
function widgetFill(box, d, key) {
  const answers = [];
  let k = 0;
  const html = d.text.replace(/\[\[(.+?)\]\]/g, (m, a) => {
    const alts = a.split('¦');
    answers.push(alts);
    const w = Math.max(...alts.map(x => x.length), 2);
    return '<input data-k="' + (k++) + '" style="width:' + w + 'ch" autocomplete="off" spellcheck="false">';
  });

  const u = shellW(box, 'Fill in the blanks', d.title, '<div class="fillt">' + html + '</div>',
    '<button class="btn primary" data-a="check">Check</button><button class="btn" data-a="show">Reveal</button><span class="msg"></span>');

  const check = () => {
    let n = 0;
    $$('input', u.b).forEach(inp => {
      const alts = answers[+inp.dataset.k];
      const val = inp.value.trim().toLowerCase();
      const ok = alts.some(a => a.trim().toLowerCase() === val);
      inp.classList.toggle('ok', ok);
      inp.classList.toggle('no', !ok && val !== '');
      if (ok) n++;
    });
    $('.msg', u.f).innerHTML = '<b class="' + (n === answers.length ? 'good' : '') + '">' + n + '/' + answers.length + '</b> correct';
    if (n === answers.length) {
      const b0 = (state.quiz || {})[key] || 0;
      if (n > b0) recordQuiz(key, n);
    }
    return n;
  };

  u.b.addEventListener('keydown', e => { if (e.key === 'Enter') { e.preventDefault(); check(); } });
  u.f.addEventListener('click', e => {
    const a = e.target.closest('[data-a]');
    if (!a) return;
    if (a.dataset.a === 'check') check();
    if (a.dataset.a === 'show') {
      $$('input', u.b).forEach(inp => {
        inp.value = answers[+inp.dataset.k][0];
      });
      check();
    }
  });
}

/* ── Hydrate Widgets in DOM ── */
function hydrateW(box) {
  if (box.dataset.h) return;
  box.dataset.h = '1';
  const d = (window.MSREG && window.MSREG.w) ? window.MSREG.w[box.dataset.w] : null;
  if (!d || !WIDGETS[d.type]) return;
  WIDGETS[d.type](box, d, box.dataset.w);
  mj(box);
}

function hydrateWidgetsIn(root) {
  $$('[data-w]', root).forEach(b => {
    const t = b.closest('.tunit');
    if (t && !t.classList.contains('open')) return;
    hydrateW(b);
  });
}

/* ── Derivation Ladders & Checkpoints ── */
function wireLaddersIn(root) {
  $$('.ladder', root).forEach(l => {
    if (l._wired) return;
    l._wired = true;
    const rungs = $$('.rung', l);
    $$('.peek', l).forEach(p => p.onclick = e => {
      const rung = e.target.closest('.rung');
      if (rung) { rung.classList.remove('hidden'); mj(rung); }
    });
    const rev = $('.reveal-next', l), all = $('.reveal-all', l);
    if (rev) rev.onclick = () => {
      const h = rungs.find(r => r.classList.contains('hidden'));
      if (h) { h.classList.remove('hidden'); mj(h); }
      if (!rungs.some(r => r.classList.contains('hidden'))) rev.style.display = 'none';
    };
    if (all) all.onclick = () => {
      rungs.forEach(r => r.classList.remove('hidden'));
      if (rev) rev.style.display = 'none';
      mj(l);
    };
  });
}

function wireChecksIn(root) {
  state.checks = state.checks || {};
  state.conf = state.conf || {};
  state.probs = state.probs || {};

  $$('.check', root).forEach(c => {
    if (c._wired) return;
    c._wired = true;
    const id = c.id || c.dataset.ck;
    const rev = $('.reveal', c), ans = $('.ans', c);
    const btns = $$('.conf button', c);
    const hitBtn = $('[data-ck-hit]', c), missBtn = $('[data-ck-miss]', c);
    const statusEl = $('.ck-status', c);

    const syncConf = (val) => {
      btns.forEach((b, idx) => {
        const on = idx === val;
        b.classList.toggle('sel', on);
        b.classList.toggle('on', on);
      });
    };

    if (state.conf[id] !== undefined) {
      syncConf(state.conf[id]);
    }

    const syncFb = (val) => {
      if (!hitBtn || !missBtn) return;
      hitBtn.classList.toggle('hit-on', val === 1);
      missBtn.classList.toggle('miss-on', val === 0);
      if (statusEl) {
        if (val === 1) { statusEl.textContent = '✓ Saved: Got it'; statusEl.style.color = 'var(--pos)'; }
        else if (val === 0) { statusEl.textContent = 'Saved: Needs review'; statusEl.style.color = 'var(--neg)'; }
        else { statusEl.textContent = ''; }
      }
    };

    if (state.checks[id] !== undefined) {
      c.classList.add('open');
      if (ans) ans.style.display = 'block';
      if (rev) rev.style.display = 'none';
      syncFb(state.checks[id]);
    }

    btns.forEach((b, idx) => {
      b.type = 'button';
      b.onclick = (e) => {
        e.stopPropagation();
        syncConf(idx);
        state.conf[id] = idx;
        persist();
      };
    });

    if (rev) {
      rev.type = 'button';
      rev.onclick = (e) => {
        e.stopPropagation();
        c.classList.add('open');
        if (ans) { ans.style.display = 'block'; mj(ans); }
        rev.style.display = 'none';
      };
    }

    const flash = col => {
      const old = c.style.borderColor;
      c.style.borderColor = col;
      setTimeout(() => { c.style.borderColor = old; }, 700);
    };

    if (hitBtn) {
      hitBtn.type = 'button';
      hitBtn.onclick = (e) => {
        e.stopPropagation();
        state.checks[id] = 1;
        syncFb(1);
        flash('#5CE08A');
        persist();
      };
    }

    if (missBtn) {
      missBtn.type = 'button';
      missBtn.onclick = (e) => {
        e.stopPropagation();
        state.checks[id] = 0;
        syncFb(0);
        flash('#FF6B6B');
        persist();
      };
    }
  });

  /* worked problems feedback */
  $$('.prob', root).forEach(pr => {
    if (pr._wired) return;
    pr._wired = true;
    const pTitle = $('.pt', pr);
    const pid = 'pr_' + _h(pTitle ? pTitle.textContent : pr.innerHTML.slice(0, 50));

    const hitBtn = $('[data-pr-hit]', pr), missBtn = $('[data-pr-miss]', pr);
    const statusEl = $('.pr-status', pr);

    const syncPrFb = (val) => {
      if (!hitBtn || !missBtn) return;
      hitBtn.classList.toggle('hit-on', val === 1);
      missBtn.classList.toggle('miss-on', val === 0);
      if (statusEl) {
        if (val === 1) { statusEl.textContent = '✓ Understood'; statusEl.style.color = 'var(--pos)'; }
        else if (val === 0) { statusEl.textContent = 'Need practice'; statusEl.style.color = 'var(--neg)'; }
        else { statusEl.textContent = ''; }
      }
    };

    if (state.probs[pid] !== undefined) {
      syncPrFb(state.probs[pid]);
    }

    const flash = col => {
      const old = pr.style.borderColor;
      pr.style.borderColor = col;
      setTimeout(() => { pr.style.borderColor = old; }, 700);
    };

    if (hitBtn) {
      hitBtn.type = 'button';
      hitBtn.onclick = (e) => {
        e.stopPropagation();
        state.probs[pid] = 1;
        syncPrFb(1);
        flash('#5CE08A');
        persist();
      };
    }

    if (missBtn) {
      missBtn.type = 'button';
      missBtn.onclick = (e) => {
        e.stopPropagation();
        state.probs[pid] = 0;
        syncPrFb(0);
        flash('#FF6B6B');
        persist();
      };
    }
  });
}
