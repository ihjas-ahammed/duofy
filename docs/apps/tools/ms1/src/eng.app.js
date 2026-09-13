/* ══════════════════════════════════════════════════════════════════
   Materials Science · Application Engine
   Lifecycle · Navigation · Progress · Bookmarks · Firebase Sync · Theme
   ══════════════════════════════════════════════════════════════════ */

const LS = 'ms_state_v1';
const DB = 'https://data-science-ef878-default-rtdb.firebaseio.com';
const APP = 'ms_study';

let state = {
  done: {},
  open: {},
  bm: {},
  quiz: {},
  cards: {},
  checks: {},
  conf: {},
  probs: {},
  theme: 'auto',
  syncId: ''
};

function loadLocal() {
  try {
    const s = localStorage.getItem(LS);
    if (s) state = Object.assign(state, JSON.parse(s));
  } catch (e) {}
}

function saveLocal() {
  state.updated = Date.now();
  try { localStorage.setItem(LS, JSON.stringify(state)); } catch (e) {}
}

let syncTimer = null;
function persist() {
  saveLocal();
  paintAll();
  updateBMBadge();
  if (state.syncId) {
    clearTimeout(syncTimer);
    syncTimer = setTimeout(pushCloud, 1200);
  }
}

/* ── Toast notification using #sync ── */
function toast(m) {
  const s = $('#sync');
  if (!s) return;
  const txt = $('#synctxt');
  if (txt) txt.textContent = m;
  s.classList.add('show');
  clearTimeout(toast._h);
  toast._h = setTimeout(() => s.classList.remove('show'), 1800);
}

function syncToast(msg, ok) {
  const el = $('#sync'), t = $('#synctxt');
  if (!el || !t) return;
  t.textContent = msg;
  el.className = 'show' + (ok ? ' ok' : '');
  setTimeout(() => { el.className = ''; }, 3200);
}

function pushCloud() {
  if (!state.syncId) return;
  fetch(`${DB}/${APP}/${encodeURIComponent(state.syncId)}.json`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(state)
  }).then(r => {
    if (r.ok) syncToast('Progress backed up to cloud', true);
  }).catch(() => {});
}

function pullCloud(cb) {
  if (!state.syncId) return;
  fetch(`${DB}/${APP}/${encodeURIComponent(state.syncId)}.json`)
    .then(r => r.json())
    .then(data => {
      if (data && typeof data === 'object') {
        state.done = Object.assign(data.done || {}, state.done);
        state.bm = Object.assign(data.bm || {}, state.bm);
        state.quiz = Object.assign(data.quiz || {}, state.quiz);
        state.cards = Object.assign(data.cards || {}, state.cards);
        saveLocal();
        paintAll();
        updateBMBadge();
        syncToast('Synced with cloud', true);
      }
      if (cb) cb();
    }).catch(() => {
      syncToast('Cloud sync unreachable (offline)', false);
      if (cb) cb();
    });
}

/* ── Tree Structure & Rendering ── */
let TREE = [];
const SEC = Object.create(null);
let RAW = Object.create(null);

const doneBar = id => `<div class="donebar"><button class="btn primary" data-done="${id}">✓ Mark as completed</button><button class="btn bmbtn" data-bm="${id}">☆ Bookmark for review</button></div>`;
const starBtn = id => `<button class="star" data-bm="${id}" title="Bookmark for review" aria-label="Bookmark for review">☆</button>`;

function renderApp() {
  const host = $('#stations');
  if (!host) return;
  host.innerHTML = '';
  TREE = [];
  RAW = Object.create(null);

  (window.MODULES || []).forEach((m, mi) => {
    const modEl = el(`<section class="mod ${m.cls || ('m' + mi)}" id="${m.id}">
      <div class="mh"><span class="caret">▶</span>
        <button class="tick" data-tick="${m.id}" title="Mark module done">✓</button>
        <div class="mt"><b>${m.name}</b><small>${m.sub || ''}</small></div>
        <span class="cnt" data-cnt="${m.id}"></span></div>
      <div class="mbody"><div class="in"></div></div></section>`);
    const mbodyIn = $('.mbody > .in', modEl);
    const node = { id: m.id, name: m.name, secs: [] };

    (m.stations || []).forEach(sid => {
      const st = (window.STATIONS || []).find(x => x.id === sid);
      if (!st) return;
      const title = (st.short || st.title).replace(/<[^>]+>/g, '');
      const secEl = el(`<div class="unit" id="${sid}">
        <div class="uh"><span class="caret">▶</span>
          <button class="tick" data-tick="${sid}" title="Mark section done">✓</button>
          <h3>${title}</h3>
          ${starBtn(sid)}
          <span class="cnt" data-cnt="${sid}"></span>
          <span class="est">${st.est || ''}</span></div>
        <div class="ubody"><div class="in"></div></div></div>`);
      const ubodyIn = $('.ubody > .in', secEl);
      const sec = { id: sid, title, topics: [] };

      // Parse station body and split at each .topic marker
      const tmp = document.createElement('div');
      let fullBody = st.body || '';

      if (window.OMR && window.OMR[sid]) {
        fullBody += tp('Exam Practice · Question Bank & Flashcards');
        fullBody += omr(st.title + ' — Practice', window.OMR[sid]);
      }
      if (window.CARDS && window.CARDS[sid]) {
        fullBody += cards(st.title + ' — Flashcards', window.CARDS[sid]);
      }

      tmp.innerHTML = fullBody;
      let sink = ubodyIn;

      [...tmp.childNodes].forEach(n => {
        if (n.nodeType === 1 && n.classList && n.classList.contains('topic')) {
          const i = sec.topics.length, tid = sid + '__t' + i;
          const h = n.querySelector('h3') || n.querySelector('h4');
          const tHTML = h ? h.innerHTML : 'Topic', tTxt = (h ? h.textContent : 'Topic').trim();
          const tEl = el(`<div class="tunit" id="${tid}">
            <div class="th"><span class="caret">▶</span>
              <button class="tick" data-tick="${tid}" title="Mark topic done">✓</button>
              <h4>${tHTML}</h4>
              ${starBtn(tid)}</div>
            <div class="tbody"><div class="in"></div></div></div>`);
          ubodyIn.appendChild(tEl);
          sink = $('.tbody > .in', tEl);
          sec.topics.push({ id: tid, title: tTxt, el: tEl });
        } else {
          sink.appendChild(n);
        }
      });

      // Add donebar to every topic and store in RAW
      sec.topics.forEach(t => {
        const tbIn = $('.tbody > .in', t.el);
        if (tbIn) {
          tbIn.insertAdjacentHTML('beforeend', doneBar(t.id));
        }
        RAW[t.id] = t.el.outerHTML;
      });

      if (!sec.topics.length) {
        ubodyIn.insertAdjacentHTML('beforeend', doneBar(sid));
      }
      RAW[sid] = secEl.outerHTML;

      mbodyIn.appendChild(secEl);
      node.secs.push(sec);
      SEC[sid] = sec;
    });

    host.appendChild(modEl);
    TREE.push(node);
  });

  wireTree();
  wireLaddersIn(host);
  wireChecksIn(host);
  hydrateWidgetsIn(host);
  setupFigsIn(host);
  restoreFolds();
  paintAll();
  updateBMBadge();
  markDepth();

  mj(host, () => {
    resizeVisibleFigs();
  });
}

/* /* ── Tri-State Tick Engine ── */
function leavesOfSec(sec) { return sec.topics.length ? sec.topics.map(t => t.id) : [sec.id]; }
function leavesOfMod(mod) { return mod.secs.flatMap(leavesOfSec); }
function allLeaves() { return TREE.flatMap(leavesOfMod); }

const leavesOf = id => {
  const m = TREE.find(x => x.id === id);
  if (m) return leavesOfMod(m);
  if (SEC[id]) return leavesOfSec(SEC[id]);
  return [id];
};

const isDone = id => {
  if (SEC[id]) return stateOf(leavesOfSec(SEC[id])).all;
  const m = TREE.find(x => x.id === id);
  if (m) return stateOf(leavesOfMod(m)).all;
  return !!state.done[id];
};

function stateOf(ids) {
  const n = ids.filter(i => state.done[i]).length;
  return { n, total: ids.length, all: ids.length > 0 && n === ids.length, some: n > 0 };
}

function setLeaves(ids, on) {
  ids.forEach(i => {
    if (on) state.done[i] = true;
    else delete state.done[i];
  });
}

const rid = c => c.id.replace(/^bm__/, '');
const cardOf = (src, id) => {
  const c = src && src.closest('.tunit,.unit,.mod');
  return c && rid(c) === id ? c : document.getElementById(id);
};

function toggleNode(id, src) {
  const L = leavesOf(id), nowDone = !stateOf(L).all;
  setLeaves(L, nowDone);
  persist();
  if (nowDone) {
    const c = cardOf(src, id);
    if (c) {
      setOpen(c, false);
      saveLocal();
      const h = c.firstElementChild || c;
      setTimeout(() => h.scrollIntoView({ behavior: 'smooth', block: 'center' }), 50);
      setTimeout(() => h.scrollIntoView({ behavior: 'smooth', block: 'center' }), 320);
    }
  }
}

function completeNode(id, src) {
  const L = leavesOf(id);
  if (stateOf(L).all) {
    setLeaves(L, false);
    persist();
    toast('Marked as not done');
    return;
  }
  setLeaves(L, true);
  persist();
  toast('Completed ✓');
  const c = cardOf(src, id);
  if (c) {
    setOpen(c, false);
    saveLocal();
    const h = c.firstElementChild || c;
    setTimeout(() => h.scrollIntoView({ behavior: 'smooth', block: 'center' }), 50);
    setTimeout(() => h.scrollIntoView({ behavior: 'smooth', block: 'center' }), 320);
  }
}

/* ── Folding / Unfolding ── */
const levelOf = c => c.classList.contains('mod') ? 'mod' : c.classList.contains('unit') ? 'unit' : 'tunit';

function markDepth() {
  $$('.mod, .unit').forEach(c => {
    c.classList.toggle('has-open', c.classList.contains('open') && !!$(':scope > .mbody > .in > .unit.open, :scope > .ubody > .in > .tunit.open', c));
  });
  const root = $('.view.on') || document;
  document.body.classList.toggle('wide', root.id === 'view-rev' ? false :
    !!$('.tunit.open .wg, .tunit.open .ex, .unit.open > .ubody .ex, .unit.open > .ubody .wg, .tunit.open .fig, .unit.open > .ubody .fig', root));
}

function setOpen(card, open) {
  card.classList.toggle('open', open);
  state.open = state.open || {};
  if (open) state.open[card.id] = 1;
  else delete state.open[card.id];
  markDepth();
  if (open) {
    setupFigsIn(card);
    setTimeout(() => {
      resizeFigsIn(card);
      hydrateWidgetsIn(card);
      mj(card);
    }, 40);
    setTimeout(() => {
      resizeFigsIn(card);
    }, 340);
  }
}

function openCard(card, opt) {
  opt = opt || {};
  const lv = levelOf(card);
  const root = card.closest('.view') || document;
  $$('.' + lv + '.open', root).forEach(c => {
    if (c !== card) setOpen(c, false);
  });
  if (root.id === 'view-bm') {
    $$('#bmlist > .open').forEach(c => {
      if (c !== card && !c.contains(card)) setOpen(c, false);
    });
  }
  let p = card.parentElement && card.parentElement.closest('.mod,.unit');
  while (p) {
    if (!p.classList.contains('open')) {
      const plv = levelOf(p);
      $$('.' + plv + '.open', root).forEach(c => {
        if (c !== p) setOpen(c, false);
      });
      setOpen(p, true);
    }
    p = p.parentElement && p.parentElement.closest('.mod,.unit');
  }
  setOpen(card, true);
  saveLocal();
  if (opt.scroll !== false) {
    const h = card.firstElementChild;
    setTimeout(() => {
      const top = h.getBoundingClientRect().top;
      if (top < 60 || top > innerHeight * 0.45) h.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }, 340);
  }
}

function restoreFolds() {
  const o = state.open;
  if (o && Object.keys(o).length) {
    Object.keys(o).forEach(id => {
      const c = document.getElementById(id);
      if (c) c.classList.add('open');
    });
  }
  markDepth();
}

function resizeFigsIn(root) {
  liveFigs.concat(live3D).forEach(r => {
    if (root.contains(r.cv) && r.cv.clientWidth > 0) r.size();
  });
}
function resizeVisibleFigs() {
  liveFigs.concat(live3D).forEach(r => {
    if (r.cv.clientWidth > 0) r.size();
  });
}

/* ── Painting Progress ── */
function paintTick(el, st) {
  el.classList.toggle('on', st.all);
  el.classList.toggle('part', !st.all && st.some);
}

function paintAll() {
  const both = id => [document.getElementById(id), document.getElementById('bm__' + id)].filter(Boolean);
  TREE.forEach(m => {
    m.secs.forEach(sec => {
      sec.topics.forEach(t => {
        const on = !!state.done[t.id];
        $$(`.tick[data-tick="${t.id}"]`).forEach(b => {
          b.classList.toggle('on', on);
          b.classList.remove('part');
        });
        both(t.id).forEach(c => c.classList.toggle('done', on));
      });
      const ss = stateOf(leavesOfSec(sec));
      $$(`.tick[data-tick="${sec.id}"]`).forEach(b => paintTick(b, ss));
      $$(`[data-cnt="${sec.id}"]`).forEach(c => c.textContent = sec.topics.length ? `${ss.n}/${ss.total}` : '');
      both(sec.id).forEach(c => c.classList.toggle('done', ss.all));
    });
    const ms = stateOf(leavesOfMod(m));
    $$(`.tick[data-tick="${m.id}"]`).forEach(b => paintTick(b, ms));
    $$(`[data-cnt="${m.id}"]`).forEach(c => c.textContent = `${ms.n}/${ms.total}`);
  });

  const bm = state.bm || {};
  $$('[data-bm]').forEach(b => {
    const on = !!bm[b.dataset.bm];
    b.classList.toggle('on', on);
    if (b.classList.contains('star')) {
      b.textContent = on ? '★' : '☆';
      b.title = on ? 'Bookmarked — tap to remove' : 'Bookmark for review';
    } else {
      b.textContent = on ? '★ Bookmarked' : '☆ Bookmark for review';
    }
  });

  $$('[data-done]').forEach(b => {
    const id = b.dataset.done, dn = isDone(id);
    b.classList.toggle('completed', dn);
    b.classList.toggle('primary', !dn);
    b.textContent = dn ? '✓ Completed · undo' : (SEC[id] && SEC[id].topics.length ? '✓ Mark whole section as completed' : '✓ Mark as completed');
  });

  const n = Object.keys(bm).length, badge = $('#nav .badge');
  if (badge) {
    badge.hidden = !n;
    badge.textContent = n;
  }

  const ov = stateOf(allLeaves()), pct = ov.total ? Math.round((ov.n / ov.total) * 100) : 0;
  const ringPct = $('#ringpct'), ringP = $('#ringp'), pbar = $('#pbar');
  if (ringPct) ringPct.textContent = pct + '%';
  if (ringP) ringP.style.strokeDashoffset = 88 * (1 - pct / 100);
  if (pbar) pbar.style.width = pct + '%';
}

/* ── Bookmarks Engine ── */
let bmDirty = true;
function toggleBM(id) {
  state.bm = state.bm || {};
  const on = !state.bm[id];
  if (on) state.bm[id] = Date.now();
  else delete state.bm[id];
  persist();
  bmDirty = true;
  toast(on ? '★ Bookmarked for review' : 'Removed from bookmarks');
  if (!on && curView === 'bm') {
    const r = $(`#bmlist > [data-bmroot="${id}"]`);
    if (r) {
      r.classList.add('bye');
      setTimeout(() => {
        r.remove();
        tidyBM();
      }, 260);
    }
  }
}

function renderBM() {
  bmDirty = false;
  const host = $('#bmlist'), bm = state.bm || {}, groups = [];
  TREE.forEach(m => m.secs.forEach(sec => {
    const items = [];
    if (bm[sec.id]) items.push(sec.id);
    else {
      sec.topics.forEach(t => { if (bm[t.id]) items.push(t.id); });
    }
    if (items.length) groups.push({ label: m.name + ' · ' + sec.title, items });
  }));
  const clone = h => h.replace(/(\s)id="/g, '$1id="bm__');
  host.innerHTML = groups.map(g => `<div class="bmgroup">${esc(g.label)}</div>` + g.items.map(id => RAW[id] ? clone(RAW[id]).replace(/^<div /, `<div data-bmroot="${id}" `) : '').join('')).join('');
  tidyBM();
  wireLaddersIn(host);
  wireChecksIn(host);
  hydrateWidgetsIn(host);
  setupFigsIn(host);
  paintAll();
  const first = $('#bmlist > .unit, #bmlist > .tunit');
  if (first) openCard(first, { scroll: false });
}

function tidyBM() {
  const host = $('#bmlist');
  if (!host) return;
  $$('.bmgroup', host).forEach(g => {
    const n = g.nextElementSibling;
    if (!n || n.classList.contains('bmgroup')) g.remove();
  });
  if (!host.querySelector('[data-bmroot]')) {
    host.innerHTML = `<div class="empty"><b>☆</b>Nothing bookmarked yet.<br>Tap <b>☆</b> on any topic — or <b>Bookmark for review</b> at the end of a topic — and it collects here.</div>`;
  }
}

function updateBMBadge() {
  const n = Object.keys(state.bm || {}).length;
  const badge = $('#nav .badge');
  if (badge) {
    badge.hidden = !n;
    badge.textContent = n;
  }
}

/* ── Review: one flat page, rendered on first visit ── */
let revDone = false;
function renderReview() {
  if (revDone) return;
  const host = $('#revbody');
  if (!host || !window.REVIEW) return;
  revDone = true;
  host.innerHTML = window.REVIEW;
  wireLaddersIn(host);
  wireChecksIn(host);
  hydrateWidgetsIn(host);
  setupFigsIn(host);
  mj(host, () => resizeVisibleFigs());
}

/* ── Navigation & Views: Learn · Review · Bookmarks ── */
let curView = 'learn';
const vScroll = {};
function showView(v) {
  if (!['learn', 'rev', 'bm'].includes(v)) v = 'learn';
  const was = curView;
  if (was !== v) vScroll[was] = scrollY;
  curView = v;
  $$('.view').forEach(x => x.classList.toggle('on', x.id === 'view-' + v));
  $$('#nav button').forEach(b => {
    b.classList.toggle('on', b.dataset.view === v);
    b.setAttribute('aria-current', b.dataset.view === v ? 'page' : 'false');
  });
  document.body.classList.remove('v-learn', 'v-rev', 'v-bm', 'typing');
  document.body.classList.add('v-' + v);
  if (v === 'rev') { renderReview(); setTimeout(resizeVisibleFigs, 60); }
  if (v === 'bm' && bmDirty) renderBM();
  markDepth();
  if (was !== v) scrollTo(0, vScroll[v] || 0);
  try { localStorage.setItem('ms_view', v); } catch (e) {}
  const frag = { learn: '', rev: '#review', bm: '#bookmarks' }[v] || '';
  try { history.replaceState(null, '', frag || location.pathname + location.search); } catch (e) {}
}

function expandAll(on) {
  const root = $('.view.on') || document;
  $$('.mod, .unit, .tunit', root).forEach(c => c.classList.toggle('open', on));
  state.open = {};
  if (on) {
    $$('.mod, .unit, .tunit', root).forEach(c => state.open[c.id] = 1);
    setupFigsIn(root);
  }
  markDepth();
  saveLocal();
  setTimeout(resizeVisibleFigs, 40);
}

function initNav() {
  $$('#nav button').forEach(b => {
    b.onclick = () => {
      if (b.dataset.view === curView) scrollTo({ top: 0, behavior: 'smooth' });
      else showView(b.dataset.view);
    };
  });
  const top = $('#top'), setTop = () => document.documentElement.style.setProperty('--toph', top.offsetHeight + 'px');
  if (top) {
    setTop();
    new ResizeObserver(setTop).observe(top);
  }
  let allOpen = false;
  const btn = $('#expandall');
  if (btn) {
    btn.onclick = () => {
      allOpen = !allOpen;
      expandAll(allOpen);
      btn.textContent = allOpen ? '⇡' : '⇕';
      btn.title = allOpen ? 'Collapse everything' : 'Expand everything';
    };
  }
  addEventListener('scroll', () => {
    const top = $('#top');
    if (top) top.classList.toggle('scrolled', scrollY > 10);
  }, { passive: true });
}

/* ── Central Event Delegate ── */
let wired = false;
function wireTree() {
  if (wired) return;
  wired = true;
  const syncToast = $('#sync');
  if (syncToast) {
    syncToast.onclick = () => {
      clearTimeout(toast._h);
      syncToast.classList.remove('show');
    };
  }
  document.addEventListener('click', e => {
    const t = e.target.closest('[data-tick]');
    if (t) {
      e.preventDefault();
      e.stopPropagation();
      toggleNode(t.dataset.tick, t);
      return;
    }
    const d = e.target.closest('[data-done]');
    if (d) {
      e.preventDefault();
      e.stopPropagation();
      completeNode(d.dataset.done, d);
      return;
    }
    const b = e.target.closest('[data-bm]');
    if (b) {
      e.preventDefault();
      e.stopPropagation();
      toggleBM(b.dataset.bm);
      return;
    }
    const h = e.target.closest('.mh, .uh, .th');
    if (h) {
      const c = h.parentElement;
      if (c.classList.contains('open')) {
        setOpen(c, false);
        saveLocal();
      } else {
        openCard(c);
      }
    }
  }, true);

  /* Phones: while typing anywhere, hide bottom bar for keyboard */
  document.addEventListener('focusin', e => {
    if (matchMedia('(max-width:899px)').matches && e.target && e.target.matches && e.target.matches('textarea, input:not([type="checkbox"]):not([type="radio"])')) {
      document.body.classList.add('typing');
    }
  });
  document.addEventListener('focusout', e => {
    setTimeout(() => {
      const a = document.activeElement;
      if (!a || !a.matches || !a.matches('textarea, input:not([type="checkbox"]):not([type="radio"])')) {
        document.body.classList.remove('typing');
      }
    }, 150);
  });
}

/* ── Theme Switcher ── */
function initTheme() {
  const btn = $('#theme');
  const apply = t => {
    if (t === 'dark' || t === 'light') document.documentElement.setAttribute('data-theme', t);
    else document.documentElement.removeAttribute('data-theme');
    setTimeout(() => {
      readPalette();
      redrawAll();
    }, 60);
  };
  apply(state.theme);

  if (btn) {
    btn.onclick = () => {
      const next = state.theme === 'dark' ? 'light' : (state.theme === 'light' ? 'auto' : 'dark');
      state.theme = next;
      apply(next);
      saveLocal();
    };
  }
}

/* ── Pristine Download & Cloud Modal ── */
function initHeader() {
  const dlBtn = $('#dl');
  if (dlBtn) {
    if (location.protocol === 'http:' || location.protocol === 'https:') {
      dlBtn.hidden = false;
      dlBtn.onclick = () => {
        fetch(location.href)
          .then(r => r.text())
          .then(html => {
            const blob = new Blob([html], { type: 'text/html;charset=utf-8' });
            const a = document.createElement('a');
            a.href = URL.createObjectURL(blob);
            a.download = CFG.offlineName || 'MATERIAL_SCIENCE_12_OFFLINE.html';
            document.body.appendChild(a);
            a.click();
            a.remove();
          });
      };
    }
  }

  const cloudBtn = $('#cloud'), modal = $('#idmodal'), closeBtn = $('#idclose'), saveBtn = $('#idsave'), input = $('#idinput');
  if (cloudBtn && modal) {
    cloudBtn.onclick = () => {
      if (input) input.value = state.syncId || '';
      modal.classList.add('show');
    };
    if (closeBtn) closeBtn.onclick = () => modal.classList.remove('show');
    modal.onclick = e => { if (e.target === modal) modal.classList.remove('show'); };
    if (saveBtn) {
      saveBtn.onclick = () => {
        const id = (input.value || '').trim();
        state.syncId = id;
        saveLocal();
        if (id) {
          const st = $('#idstatus');
          if (st) st.textContent = 'Connecting and syncing...';
          pullCloud(() => {
            modal.classList.remove('show');
            if (st) st.textContent = '';
          });
        } else {
          modal.classList.remove('show');
        }
      };
    }
  }
}

/* ── DOM Init ── */
function boot() {
  readPalette();
  loadLocal();
  initTheme();
  initNav();
  initHeader();
  renderApp();

  let v = 'learn';
  try { v = localStorage.getItem('ms_view') || 'learn'; } catch (e) {}
  const h = location.hash.slice(1);
  if (h === 'bookmarks') v = 'bm';
  else if (h === 'review') v = 'rev';
  else if (h) {
    const t = document.getElementById(h);
    if (t) {
      v = 'learn';
      showView(v);
      openCard(t.closest('.tunit, .unit, .mod') || t);
    }
  }
  showView(v);
}

if (document.readyState !== 'loading') boot();
else document.addEventListener('DOMContentLoaded', boot);
