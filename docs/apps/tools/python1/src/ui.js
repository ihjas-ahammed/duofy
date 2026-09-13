/* ══════════════════════════════════════════════════════════════════
   Python for Data Analysis · Modules I & II · Interactive Engine
   Calicut University B.Sc. Physics Honours SEC2
   ══════════════════════════════════════════════════════════════════ */

const $ = (s, r = document) => r.querySelector(s);
const $$ = (s, r = document) => Array.from(r.querySelectorAll(s));
const esc = s => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
const debounce = (fn, ms) => { let t; return (...a) => { clearTimeout(t); t = setTimeout(() => fn(...a), ms); }; };
const hash = s => { let h = 5381; for (let i = 0; i < s.length; i++) h = ((h << 5) + h + s.charCodeAt(i)) | 0; return Math.abs(h); };
const shuffle = (arr, seed) => {
  const a = arr.slice(); let s = seed;
  for (let i = a.length - 1; i > 0; i--) {
    s = (s * 9301 + 49297) % 233280;
    const j = Math.floor((s / 233280) * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
};

/* App State */
const state = {
  done: {},
  bm: {},
  quiz: {},
  theme: 'auto',
  syncId: ''
};

try {
  const saved = localStorage.getItem('py_state_v2');
  if (saved) Object.assign(state, JSON.parse(saved));
} catch (e) {}

const persist = () => {
  try { localStorage.setItem('py_state_v2', JSON.stringify(state)); } catch (e) {}
  updateProgress();
};

/* Toast Notification (auto-hides in 2.8 seconds, floats above nav) */
let toastTimer = null;
function toast(msg) {
  const el = $('#toast');
  if (!el) return;
  el.textContent = msg;
  el.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => { el.classList.remove('show'); }, 2800);
}

/* File Download & Modal Helpers */
function saveFile(name, blob) {
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = name;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(a.href), 4000);
}

function ask(o) {
  return new Promise(res => {
    const m = $('#askwin'), inp = $('#askinput'), opts = $('.askopts', m);
    $('#asktitle').textContent = o.title || '';
    $('#askmsg').innerHTML = o.msg || '';
    $('#askmsg').hidden = !o.msg;
    inp.hidden = o.value === undefined;
    inp.value = o.value || '';
    inp.placeholder = o.placeholder || '';
    opts.innerHTML = (o.options || []).map((x, i) =>
      `<label><input type="radio" name="askopt" value="${i}"${i === 0 ? ' checked' : ''}><span><b>${esc(x.label)}</b>${x.desc ? `<small>${esc(x.desc)}</small>` : ''}</span></label>`
    ).join('');
    $('#askok').textContent = o.ok || 'OK';
    $('#askok').classList.toggle('danger', !!o.danger);
    m.classList.add('show');
    const finish = v => {
      m.classList.remove('show');
      $('#askok').onclick = $('#askno').onclick = inp.onkeydown = m.onclick = null;
      res(v);
    };
    const ok = () => {
      const k = $('input[name="askopt"]:checked', m);
      finish(o.options ? (o.value !== undefined ? { value: inp.value.trim(), option: k ? +k.value : 0 } : (k ? +k.value : 0)) : o.value !== undefined ? inp.value.trim() : true);
    };
    $('#askok').onclick = ok;
    $('#askno').onclick = () => finish(null);
    inp.onkeydown = e => {
      if (e.key === 'Enter') { e.preventDefault(); ok(); }
      if (e.key === 'Escape') finish(null);
    };
    m.onclick = e => { if (e.target === m) finish(null); };
    setTimeout(() => {
      if (!inp.hidden) {
        inp.focus();
        const d = inp.value.lastIndexOf('.');
        inp.setSelectionRange(0, d > 0 && !o.selectAll ? d : inp.value.length);
      } else $('#askok').focus();
    }, 40);
  });
}

/* Store-only ZIP creation */
const CRC = (() => {
  const t = new Uint32Array(256);
  for (let n = 0; n < 256; n++) {
    let c = n;
    for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1;
    t[n] = c >>> 0;
  }
  return t;
})();

function zipBlob(files) {
  const enc = new TextEncoder(), parts = [], central = [];
  let off = 0;
  const d = new Date();
  const dt = ((d.getFullYear() - 1980) << 9) | ((d.getMonth() + 1) << 5) | d.getDate();
  const tm = (d.getHours() << 11) | (d.getMinutes() << 5) | (d.getSeconds() >> 1);
  files.forEach(f => {
    const name = enc.encode(f.path), data = enc.encode(f.text);
    let c = -1;
    for (let i = 0; i < data.length; i++) c = CRC[(c ^ data[i]) & 255] ^ (c >>> 8);
    c = (c ^ -1) >>> 0;
    const h = new DataView(new ArrayBuffer(30));
    [[0, 0x04034b50, 4], [4, 20, 2], [6, 0x0800, 2], [8, 0, 2], [10, tm, 2], [12, dt, 2], [14, c, 4], [18, data.length, 4], [22, data.length, 4], [26, name.length, 2], [28, 0, 2]]
      .forEach(([o, v, n]) => n === 4 ? h.setUint32(o, v, true) : h.setUint16(o, v, true));
    const cd = new DataView(new ArrayBuffer(46));
    [[0, 0x02014b50, 4], [4, 20, 2], [6, 20, 2], [8, 0x0800, 2], [10, 0, 2], [12, tm, 2], [14, dt, 2], [16, c, 4], [20, data.length, 4], [24, data.length, 4], [28, name.length, 2],
     [30, 0, 2], [32, 0, 2], [34, 0, 2], [36, 0, 2], [38, 0, 4], [42, off, 4]]
      .forEach(([o, v, n]) => n === 4 ? cd.setUint32(o, v, true) : cd.setUint16(o, v, true));
    parts.push(h, name, data);
    central.push(cd, name);
    off += 30 + name.length + data.length;
  });
  const size = central.reduce((s, x) => s + x.byteLength, 0);
  const end = new DataView(new ArrayBuffer(22));
  [[0, 0x06054b50, 4], [4, 0, 2], [6, 0, 2], [8, files.length, 2], [10, files.length, 2], [12, size, 4], [16, off, 4], [20, 0, 2]]
    .forEach(([o, v, n]) => n === 4 ? end.setUint32(o, v, true) : end.setUint16(o, v, true));
  return new Blob([...parts, ...central, end], { type: 'application/zip' });
}

/* Theme Management */
function initTheme() {
  const btn = $('#theme');
  const apply = t => {
    if (t === 'dark' || t === 'light') document.documentElement.setAttribute('data-theme', t);
    else document.documentElement.removeAttribute('data-theme');
  };
  apply(state.theme);
  if (btn) {
    btn.addEventListener('click', () => {
      const cur = document.documentElement.getAttribute('data-theme');
      const next = cur === 'dark' ? 'light' : 'dark';
      state.theme = next;
      apply(next);
      persist();
      toast(next === 'dark' ? 'Dark theme enabled' : 'Light theme enabled');
    });
  }
}

/* Views Navigation */
let curView = 'learn';
function showView(v) {
  curView = v;
  document.body.classList.toggle('v-ide', v === 'ide');
  $$('#nav button').forEach(b => b.classList.toggle('on', b.dataset.view === v));
  $$('.view').forEach(sec => sec.classList.toggle('on', sec.id === 'view-' + v));
  if (v === 'bm') renderBM();
  if (v === 'ide') mountIDE();
  window.scrollTo({ top: 0, behavior: 'instant' });
}

function initNav() {
  $$('#nav button').forEach(btn => {
    btn.addEventListener('click', () => showView(btn.dataset.view));
  });
  const hashVal = location.hash.replace(/^#/, '');
  if (hashVal === 'ide') showView('ide');
  else if (hashVal === 'bm') showView('bm');
}

/* Overall Progress Calculation */
function updateProgress() {
  const allLeafIds = [];
  (window.MODULES || []).forEach(m => {
    m.stations.forEach(sid => {
      const st = (window.STATIONS || []).find(s => s.id === sid);
      if (st) {
        const temp = document.createElement('div');
        temp.innerHTML = st.body;
        const topicHeaders = temp.querySelectorAll('.topic h3');
        if (topicHeaders.length) {
          topicHeaders.forEach((_, idx) => allLeafIds.push(sid + '__t' + idx));
        } else {
          allLeafIds.push(sid);
        }
      }
    });
  });

  const doneCount = allLeafIds.filter(id => state.done[id]).length;
  const pct = allLeafIds.length ? Math.round((doneCount / allLeafIds.length) * 100) : 0;
  const pctEl = $('#ringpct');
  const circle = $('#ringp');
  const pbar = $('#pbar');
  if (pctEl) pctEl.textContent = pct + '%';
  if (circle) {
    const offset = 88 - (88 * pct / 100);
    circle.setAttribute('stroke-dashoffset', String(offset));
  }
  if (pbar) pbar.style.width = pct + '%';

  const bmCount = Object.keys(state.bm || {}).length;
  const bmb = $('#nav button[data-view="bm"] .badge');
  if (bmb) {
    bmb.textContent = bmCount;
    bmb.hidden = bmCount === 0;
  }
}

/* ══════════════ Accordion Structure (Modules I & II Only) ══════════════ */
function buildTree() {
  const host = $('#stations');
  if (!host) return;
  host.innerHTML = '';

  (window.MODULES || []).forEach((m, mi) => {
    const modEl = document.createElement('section');
    modEl.className = `mod m${mi + 1}`;
    modEl.id = m.id;
    modEl.innerHTML = `
      <div class="mh">
        <span class="caret">▶</span>
        <button class="tick" data-tick="${m.id}" title="Toggle whole module"></button>
        <div class="mt"><b>${esc(m.name)}</b><small>${esc(m.sub || '')}</small></div>
        <span class="cnt" data-cnt="${m.id}"></span>
      </div>
      <div class="mbody"><div class="in"></div></div>
    `;

    const mbody = $('.mbody > .in', modEl);
    m.stations.forEach(sid => {
      const st = (window.STATIONS || []).find(s => s.id === sid);
      if (!st) return;

      const secEl = document.createElement('div');
      secEl.className = 'unit';
      secEl.id = sid;
      secEl.innerHTML = `
        <div class="uh">
          <span class="caret">▶</span>
          <button class="tick" data-tick="${sid}" title="Toggle section"></button>
          <h3>${esc(st.short || st.title)}</h3>
          <span class="cnt" data-cnt="${sid}"></span>
        </div>
        <div class="ubody"><div class="in"></div></div>
      `;

      const ubody = $('.ubody > .in', secEl);
      const tmp = document.createElement('div');
      tmp.innerHTML = st.body;

      let sink = ubody;
      let topicIdx = 0;
      [...tmp.childNodes].forEach(n => {
        if (n.nodeType === 1 && n.classList && n.classList.contains('topic')) {
          const tid = sid + '__t' + topicIdx;
          const h = n.querySelector('h3');
          const title = h ? h.innerHTML : 'Topic';
          const tEl = document.createElement('div');
          tEl.className = 'tunit';
          tEl.id = tid;
          tEl.innerHTML = `
            <div class="th">
              <span class="caret">▶</span>
              <button class="tick" data-tick="${tid}" title="Toggle topic"></button>
              <h4>${title}</h4>
              <button class="star" data-bm="${tid}" title="Bookmark topic">${state.bm[tid] ? '★' : '☆'}</button>
            </div>
            <div class="tbody"><div class="in"></div></div>
          `;
          ubody.appendChild(tEl);
          sink = $('.tbody > .in', tEl);
          topicIdx++;
        } else {
          sink.appendChild(n.cloneNode(true));
        }
      });

      // Bottom completion bar at lowest topic level only
      $$('.tunit', secEl).forEach(t => {
        const tid = t.id;
        const b = $('.tbody > .in', t);
        if (b) {
          const bar = document.createElement('div');
          bar.className = 'donebar';
          bar.innerHTML = `
            <span class="hint">Finished studying this topic? Mark it done to advance your progress.</span>
            <button class="btn bmbtn${state.bm[tid] ? ' on' : ''}" data-act="bm-topic" data-id="${tid}">${state.bm[tid] ? '★ Bookmarked' : '☆ Bookmark for review'}</button>
            <button class="btn primary${state.done[tid] ? ' completed' : ''}" data-act="done-topic" data-id="${tid}">${state.done[tid] ? '✓ Completed' : 'Mark as completed'}</button>
          `;
          b.appendChild(bar);
        }
      });

      mbody.appendChild(secEl);
    });

    host.appendChild(modEl);
  });

  // Event delegation with auto-folding siblings
  host.addEventListener('click', e => {
    const star = e.target.closest('button.star, button[data-act="bm-topic"]');
    if (star) {
      const id = star.dataset.bm || star.dataset.id;
      toggleBM(id);
      return;
    }

    const doneBtn = e.target.closest('button[data-act="done-topic"]');
    if (doneBtn) {
      const tid = doneBtn.dataset.id;
      state.done[tid] = !state.done[tid];
      persist();
      updateTicks();
      doneBtn.textContent = state.done[tid] ? '✓ Completed' : 'Mark as completed';
      doneBtn.classList.toggle('completed', !!state.done[tid]);
      const tunit = document.getElementById(tid);
      if (tunit) {
        tunit.classList.remove('open');
        tunit.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
      }
      toast(state.done[tid] ? 'Topic marked completed ✓' : 'Topic marked incomplete');
      return;
    }

    const tick = e.target.closest('.tick');
    if (tick) {
      const id = tick.dataset.tick;
      const isDone = !state.done[id];
      state.done[id] = isDone;
      const targetEl = document.getElementById(id);
      if (targetEl) {
        $$('.tick', targetEl).forEach(t => { state.done[t.dataset.tick] = isDone; });
      }
      persist();
      updateTicks();
      toast(isDone ? 'Marked as completed' : 'Marked as incomplete');
      return;
    }

    const th = e.target.closest('.th');
    if (th) {
      const card = th.closest('.tunit');
      const wasOpen = card.classList.contains('open');
      const parent = card.parentElement;
      if (parent) $$(':scope > .tunit', parent).forEach(c => c.classList.remove('open'));
      if (!wasOpen) {
        card.classList.add('open');
        hydrateIn(card);
      }
      return;
    }

    const uh = e.target.closest('.uh');
    if (uh) {
      const card = uh.closest('.unit');
      const wasOpen = card.classList.contains('open');
      const parent = card.parentElement;
      if (parent) $$(':scope > .unit', parent).forEach(c => c.classList.remove('open'));
      if (!wasOpen) {
        card.classList.add('open');
        hydrateIn(card);
      }
      return;
    }

    const mh = e.target.closest('.mh');
    if (mh) {
      const mod = mh.closest('.mod');
      const wasOpen = mod.classList.contains('open');
      $$('.mod').forEach(m => m.classList.remove('open'));
      if (!wasOpen) {
        mod.classList.add('open');
        hydrateIn(mod);
      }
      return;
    }
  });

  updateTicks();
}

function updateTicks() {
  $$('.tick').forEach(t => {
    const id = t.dataset.tick;
    t.classList.toggle('on', !!state.done[id]);
  });
  $$('[data-act="done-topic"]').forEach(b => {
    const tid = b.dataset.id;
    b.textContent = state.done[tid] ? '✓ Completed' : 'Mark as completed';
    b.classList.toggle('completed', !!state.done[tid]);
  });
  updateProgress();
}

function toggleBM(id) {
  state.bm = state.bm || {};
  if (state.bm[id]) {
    delete state.bm[id];
    toast('Removed from bookmarks');
  } else {
    state.bm[id] = Date.now();
    toast('Bookmarked for review ★');
  }
  persist();
  $$(`[data-bm="${id}"]`).forEach(s => {
    s.textContent = state.bm[id] ? '★' : '☆';
    s.classList.toggle('on', !!state.bm[id]);
  });
  $$(`[data-act="bm-topic"][data-id="${id}"]`).forEach(b => {
    b.textContent = state.bm[id] ? '★ Bookmarked' : '☆ Bookmark for review';
    b.classList.toggle('on', !!state.bm[id]);
  });
  if (curView === 'bm') renderBM();
}

/* Hydration of Interactive Elements */
function hydrateIn(container) {
  $$('[data-ex]', container).forEach(hydrateExample);
  $$('[data-w]', container).forEach(hydrateWidget);
}

function hydrateExample(box) {
  if (box.dataset.hydrated) return;
  box.dataset.hydrated = '1';
  const data = (window.PYREG && window.PYREG.ex) ? window.PYREG.ex[box.dataset.ex] : null;
  if (!data) return;

  const initialCode = data.code;
  box.innerHTML = `
    <div class="exh">
      <span class="lbl"><b>${esc(data.title || 'Python Example')}</b></span>
      <button class="minibtn reset-btn" data-act="reset" hidden title="Reset to original code">⟲ reset</button>
      <button class="minibtn" data-act="copy" title="Copy code">⧉ copy</button>
      <button class="minibtn go" data-act="ide" title="Open and edit in full IDE">⌨ Open in IDE</button>
    </div>
    <div class="ex-ed">
      <pre class="ex-hl">${window.PYHL ? window.PYHL.highlight(initialCode) : esc(initialCode)}</pre>
      <textarea class="ex-ta" spellcheck="false" autocapitalize="off" autocomplete="off" autocorrect="off">${esc(initialCode)}</textarea>
    </div>
    ${data.out ? `
      <div class="out">
        <div class="out-hdr">Verified Output</div>
        <pre>${esc(data.out)}</pre>
      </div>` : ''}
  `;

  const ta = $('.ex-ta', box);
  const hl = $('.ex-hl', box);
  const rst = $('[data-act="reset"]', box);

  ta.addEventListener('input', () => {
    hl.innerHTML = window.PYHL ? window.PYHL.highlight(ta.value) : esc(ta.value);
    rst.hidden = (ta.value === initialCode);
  });

  box.addEventListener('click', e => {
    if (e.target.closest('[data-act="reset"]')) {
      ta.value = initialCode;
      hl.innerHTML = window.PYHL ? window.PYHL.highlight(initialCode) : esc(initialCode);
      rst.hidden = true;
      return;
    }
    if (e.target.closest('[data-act="copy"]')) {
      navigator.clipboard.writeText(ta.value).then(() => toast('Code copied!'));
      return;
    }
    if (e.target.closest('[data-act="ide"]')) {
      openInIDE({
        id: box.dataset.ex,
        name: data.title || 'Example',
        main: 'main.py',
        files: [{ path: 'main.py', text: ta.value }]
      });
      return;
    }
  });
}

function hydrateWidget(box) {
  if (box.dataset.hydrated) return;
  box.dataset.hydrated = '1';
  const d = (window.PYREG && window.PYREG.w) ? window.PYREG.w[box.dataset.w] : null;
  if (!d) return;

  box.classList.add('wg');
  if (d.type === 'fill') renderFill(box, d);
  else if (d.type === 'omr') renderOMR(box, d);
  else if (d.type === 'cards') renderCards(box, d);
  else if (d.type === 'match') renderMatch(box, d, box.dataset.w);
  else if (d.type === 'parsons') renderParsons(box, d);
  else if (d.type === 'predict') renderPredict(box, d);
  else if (d.type === 'challenge') renderChallenge(box, d);
}

/* Fill in the blanks with exact width matching */
function renderFill(box, d) {
  const answers = [];
  let k = 0;
  const html = d.text.replace(/\[\[(.+?)\]\]/g, (m, a) => {
    const alts = a.split('|').map(x => x.trim());
    answers.push(alts);
    const w = Math.max(...alts.map(x => x.length), 1);
    return `<input data-k="${k++}" style="width:${w}ch" autocomplete="off" autocapitalize="off" spellcheck="false" aria-label="blank ${k}">`;
  });

  box.innerHTML = `
    <div class="wh"><span class="tag">Fill in the blanks</span><span class="ttl">${esc(d.title || '')}</span></div>
    <div class="wb"><div class="fillt${d.code ? ' code' : ''}">${html}</div></div>
    <div class="wf">
      <button class="btn primary" data-a="check">Check</button>
      <button class="btn" data-a="show">Reveal</button>
      <span class="msg"></span>
    </div>
  `;

  const norm = s => s.trim().replace(/\s+/g, ' ');
  const updateW = inp => {
    const alts = answers[+inp.dataset.k];
    const want = Math.max(...alts.map(x => x.length), 1);
    inp.style.width = Math.max(inp.value.length || want, 1) + 'ch';
  };

  box.addEventListener('input', e => {
    if (e.target.matches('input')) updateW(e.target);
  });

  const check = () => {
    let n = 0;
    $$('input', box).forEach(inp => {
      const alts = answers[+inp.dataset.k];
      const ok = alts.some(a => norm(a).toLowerCase() === norm(inp.value).toLowerCase());
      inp.classList.toggle('ok', ok);
      inp.classList.toggle('no', !ok && inp.value !== '');
      if (ok) n++;
      updateW(inp);
    });
    $('.msg', box).innerHTML = `<b style="color:var(--green)">${n}/${answers.length} correct</b>`;
  };

  box.addEventListener('click', e => {
    const a = e.target.closest('[data-a]');
    if (!a) return;
    if (a.dataset.a === 'check') check();
    if (a.dataset.a === 'show') {
      $$('input', box).forEach(inp => {
        inp.value = answers[+inp.dataset.k][0];
        updateW(inp);
      });
      check();
    }
  });
}

/* OMR Practice */
function renderOMR(box, d) {
  let html = `<div class="omr"><div class="rollrow"><i></i> Multiple Choice Sheet · Select the best answer</div>`;
  d.qs.forEach((q, qi) => {
    const opts = q.opts || q.o || [];
    html += `
      <div class="q" data-qi="${qi}">
        <span class="qn">${qi + 1}.</span>
        <div class="qt">${esc(q.q)}</div>
        <div class="opts">
          ${opts.map((opt, oi) => `
            <div class="opt" data-oi="${oi}">
              <span class="bub">${String.fromCharCode(65 + oi)}</span>
              <span>${esc(opt)}</span>
            </div>
          `).join('')}
        </div>
        <div class="why"><b>Answer (${String.fromCharCode(65 + q.a)}):</b> ${esc(q.why || '')}</div>
      </div>
    `;
  });
  html += `</div>`;

  box.innerHTML = `
    <div class="wh"><span class="tag">OMR Practice</span><span class="ttl">${esc(d.title)}</span></div>
    <div class="wb">${html}</div>
    <div class="wf">
      <button class="btn primary" data-a="submit">Grade sheet</button>
      <button class="btn" data-a="reset">Reset</button>
      <span class="msg"></span>
    </div>
  `;

  box.addEventListener('click', e => {
    const opt = e.target.closest('.opt');
    if (opt && !$('.omr', box).classList.contains('marked')) {
      const q = opt.closest('.q');
      $$('.opt', q).forEach(o => o.classList.remove('sel'));
      opt.classList.add('sel');
      return;
    }

    const btn = e.target.closest('[data-a]');
    if (!btn) return;
    if (btn.dataset.a === 'submit') {
      let score = 0;
      $('.omr', box).classList.add('marked');
      d.qs.forEach((q, qi) => {
        const qEl = $(`[data-qi="${qi}"]`, box);
        const sel = $('.opt.sel', qEl);
        const selIdx = sel ? +sel.dataset.oi : -1;
        const rightOpt = $(`[data-oi="${q.a}"]`, qEl);
        if (rightOpt) rightOpt.classList.add('right');
        if (selIdx === q.a) {
          score++;
        } else if (sel) {
          sel.classList.add('wrong');
        } else if (rightOpt) {
          rightOpt.classList.add('miss');
        }
      });
      $('.msg', box).innerHTML = `<b style="color:var(--green)">${score}/${d.qs.length} correct</b>`;
    }
    if (btn.dataset.a === 'reset') {
      $('.omr', box).classList.remove('marked');
      $$('.opt', box).forEach(o => o.classList.remove('sel', 'right', 'wrong', 'miss'));
      $('.msg', box).textContent = '';
    }
  });
}

/* 3D Flashcards */
function renderCards(box, d) {
  let idx = 0;
  const list = d.list || [];
  box.innerHTML = `
    <div class="wh"><span class="tag">Flashcards</span><span class="ttl">${esc(d.title)}</span><span class="sc">1 / ${list.length}</span></div>
    <div class="wb">
      <div class="deck">
        <div class="card3d">
          <div class="face front"><span class="k">Question</span><div class="big"></div><span class="hint">Tap to flip</span></div>
          <div class="face back"><span class="k">Answer</span><div class="big"></div><span class="hint">Tap to flip</span></div>
        </div>
      </div>
      <div class="deckbar">
        <button class="btn" data-a="prev">← Prev</button>
        <button class="btn" data-a="flip">Flip ↻</button>
        <button class="btn primary" data-a="next">Next →</button>
      </div>
    </div>
  `;

  const card = $('.card3d', box);
  const front = $('.front .big', box);
  const back = $('.back .big', box);
  const sc = $('.sc', box);

  const show = i => {
    idx = (i + list.length) % list.length;
    card.classList.remove('flip');
    front.innerHTML = esc(list[idx].q);
    back.innerHTML = esc(list[idx].a);
    sc.textContent = `${idx + 1} / ${list.length}`;
  };

  show(0);
  card.addEventListener('click', () => card.classList.toggle('flip'));
  box.addEventListener('click', e => {
    const a = e.target.closest('[data-a]');
    if (!a) return;
    if (a.dataset.a === 'prev') show(idx - 1);
    if (a.dataset.a === 'next') show(idx + 1);
    if (a.dataset.a === 'flip') card.classList.toggle('flip');
  });
}

/* Match the following — touch screen verified with instant visual state */
const PAIRC = ['#306998', '#D49A00', '#268A4E', '#8A4FB3', '#B07014', '#1F7F86', '#B0306B', '#5B6B2A'];
function renderMatch(box, d, key) {
  const L = d.pairs.map((p, i) => ({ i, t: p[0] }));
  const R = shuffle(d.pairs.map((p, i) => ({ i, t: p[1] })), hash(key || 'match'));
  box.innerHTML = `
    <div class="wh"><span class="tag">Match</span><span class="ttl">${esc(d.title || 'Match the following')}</span></div>
    <div class="wb">
      <div class="match">
        <div class="colh">${esc(d.left || 'Column A')}</div>
        <div class="colh">${esc(d.right || 'Column B')}</div>
        ${L.map((l, k) => `<div class="it" data-s="L" data-i="${l.i}" style="grid-column:1;grid-row:${k + 2}"><span class="pn">${k + 1}</span><span>${esc(l.t)}</span></div>`).join('')}
        ${R.map((r, k) => `<div class="it" data-s="R" data-i="${r.i}" style="grid-column:2;grid-row:${k + 2}"><span class="pn">${String.fromCharCode(97 + k)}</span><span>${esc(r.t)}</span></div>`).join('')}
      </div>
    </div>
    <div class="wf">
      <button class="btn primary" data-a="check">Check</button>
      <button class="btn" data-a="show">Show answers</button>
      <button class="btn" data-a="reset">Reset</button>
      <span class="msg"></span>
    </div>
  `;

  const pair = {};
  let pickL = null, pickR = null;
  let col = 0;
  const colour = {};

  const paint = () => {
    $$('.it', box).forEach(x => {
      x.classList.remove('pick', 'ok', 'no', 'paired');
      x.style.borderColor = '';
      $('.pn', x).style.background = '';
    });
    Object.keys(pair).forEach(l => {
      const r = pair[l], c = colour[l];
      [$(`.it[data-s="L"][data-i="${l}"]`, box), $(`.it[data-s="R"][data-i="${r}"]`, box)].forEach(x => {
        if (!x) return;
        x.classList.add('paired');
        x.style.borderColor = c;
        $('.pn', x).style.background = c;
      });
    });
    if (pickL !== null) {
      const el = $(`.it[data-s="L"][data-i="${pickL}"]`, box);
      if (el) el.classList.add('pick');
    }
    if (pickR !== null) {
      const el = $(`.it[data-s="R"][data-i="${pickR}"]`, box);
      if (el) el.classList.add('pick');
    }
  };

  box.addEventListener('click', e => {
    const it = e.target.closest('.it');
    if (it) {
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
      return;
    }

    const a = e.target.closest('[data-a]');
    if (!a) return;
    if (a.dataset.a === 'reset') {
      for (const k in pair) delete pair[k];
      pickL = pickR = null;
      paint();
      $('.msg', box).textContent = '';
      return;
    }
    if (a.dataset.a === 'show') {
      for (const k in pair) delete pair[k];
      L.forEach(l => { pair[l.i] = l.i; colour[l.i] = PAIRC[l.i % PAIRC.length]; });
      paint();
    }
    let n = 0;
    L.forEach(l => {
      const x = $(`.it[data-s="L"][data-i="${l.i}"]`, box);
      if (pair[l.i] === undefined || !x) return;
      const ok = pair[l.i] === l.i;
      if (ok) n++;
      x.classList.add(ok ? 'ok' : 'no');
      const rEl = $(`.it[data-s="R"][data-i="${pair[l.i]}"]`, box);
      if (rEl) rEl.classList.add(ok ? 'ok' : 'no');
    });
    $('.msg', box).innerHTML = `<b style="color:var(--green)">${n}/${L.length} correct</b>`;
  });
}

/* Parsons Problem */
function renderParsons(box, d) {
  let lines = d.lines.map((l, i) => ({ i, text: l }));
  let order = shuffle(lines.map((_, i) => i), hash(d.title || 'parsons'));

  const render = () => {
    const html = order.map((idx, pos) => `
      <div class="line" data-pos="${pos}">
        <div class="src">${esc(lines[idx].text)}</div>
        <div class="mv">
          <button data-dir="-1" title="Move up"${pos === 0 ? ' disabled' : ''}>▲</button>
          <button data-dir="1" title="Move down"${pos === order.length - 1 ? ' disabled' : ''}>▼</button>
        </div>
      </div>
    `).join('');
    $('.zone', box).innerHTML = html;
  };

  box.innerHTML = `
    <div class="wh"><span class="tag">Parsons Puzzle</span><span class="ttl">${esc(d.title)}</span></div>
    <div class="wb"><div class="pz"><div class="zl">Arrange lines in logical execution order:</div><div class="zone"></div></div></div>
    <div class="wf">
      <button class="btn primary" data-a="check">Check Order</button>
      <button class="btn" data-a="reset">Reset</button>
      <span class="msg"></span>
    </div>
  `;

  render();
  box.addEventListener('click', e => {
    const b = e.target.closest('.mv button');
    if (b) {
      const pos = +b.closest('.line').dataset.pos;
      const dir = +b.dataset.dir;
      const target = pos + dir;
      if (target >= 0 && target < order.length) {
        [order[pos], order[target]] = [order[target], order[pos]];
        render();
      }
      return;
    }
    const a = e.target.closest('[data-a]');
    if (!a) return;
    if (a.dataset.a === 'check') {
      let ok = true;
      $$('.zone .line', box).forEach((lineEl, p) => {
        const correct = order[p] === p;
        lineEl.classList.toggle('ok', correct);
        lineEl.classList.toggle('no', !correct);
        if (!correct) ok = false;
      });
      $('.msg', box).innerHTML = ok ? `<b style="color:var(--green)">✓ Correct order!</b>` : `<b style="color:var(--red)">Not quite right yet</b>`;
    }
    if (a.dataset.a === 'reset') {
      order = shuffle(lines.map((_, i) => i), hash(d.title || 'parsons'));
      render();
      $('.msg', box).textContent = '';
    }
  });
}

/* Predict Widget */
function renderPredict(box, d) {
  box.innerHTML = `
    <div class="wh"><span class="tag">Predict Output</span><span class="ttl">${esc(d.title)}</span></div>
    <div class="wb">
      <div class="ex-ed" style="border:1px solid var(--rule);border-radius:.55rem;overflow:hidden">
        <pre class="ex-hl">${window.PYHL ? window.PYHL.highlight(d.code) : esc(d.code)}</pre>
      </div>
      <div class="pred"><div class="opts">
        ${d.options.map((opt, i) => `<div class="po" data-oi="${i}"><span class="pl">Option ${String.fromCharCode(65 + i)}</span><pre style="margin:0;font-family:var(--f-m);font-size:.85rem">${esc(opt)}</pre></div>`).join('')}
      </div></div>
      <div class="why" hidden style="margin-top:.8rem;padding:.6rem .8rem;background:var(--panel);border-radius:.45rem;font-size:.84rem"></div>
    </div>
    <div class="wf"><button class="btn primary" data-a="check">Confirm</button><span class="msg"></span></div>
  `;

  let sel = null;
  box.addEventListener('click', e => {
    const po = e.target.closest('.po');
    if (po) {
      $$('.po', box).forEach(p => p.classList.remove('sel'));
      po.classList.add('sel');
      sel = +po.dataset.oi;
      return;
    }
    const a = e.target.closest('[data-a="check"]');
    if (a && sel !== null) {
      const isOk = String(d.options[sel]).trim() === String(d.answer).trim();
      const selEl = $(`[data-oi="${sel}"]`, box);
      if (selEl) {
        selEl.classList.add(isOk ? 'ok' : 'no');
      }
      const whyEl = $('.why', box);
      whyEl.hidden = false;
      whyEl.innerHTML = `<b>Explanation:</b> ${esc(d.why || '')}`;
      $('.msg', box).innerHTML = isOk ? `<b style="color:var(--green)">✓ Correct!</b>` : `<b style="color:var(--red)">Incorrect</b>`;
    }
  });
}

/* Challenge Widget: Fix / Build */
function renderChallenge(box, d) {
  const initial = d.start;
  box.innerHTML = `
    <div class="wh"><span class="tag">${d.kind === 'fix' ? 'Fix the Bug' : 'Write Code Challenge'}</span><span class="ttl">${esc(d.title)}</span></div>
    <div class="wb">
      <div style="font-size:.86rem;color:var(--dim);margin-bottom:.6rem">${esc(d.brief || '')}</div>
      <div class="ex-ed" style="border:1px solid var(--rule);border-radius:.45rem;overflow:hidden">
        <pre class="ex-hl">${window.PYHL ? window.PYHL.highlight(initial) : esc(initial)}</pre>
        <textarea class="ex-ta" spellcheck="false" autocapitalize="off" autocomplete="off" autocorrect="off">${esc(initial)}</textarea>
      </div>
      <ul class="chk-list" style="margin:.6rem 0 0;padding-left:1.2rem;font-size:.82rem;line-height:1.6">
        ${(d.checks || []).map((c, i) => `<li data-ci="${i}">${esc(c.msg)}</li>`).join('')}
      </ul>
    </div>
    <div class="wf">
      <button class="btn reset-btn" data-a="reset" hidden>⟲ Reset</button>
      <button class="btn primary" data-a="ide">⌨ Solve in Full IDE</button>
      <span class="msg"></span>
    </div>
  `;

  const ta = $('.ex-ta', box);
  const hl = $('.ex-hl', box);
  const rst = $('[data-a="reset"]', box);

  const evaluateChecks = () => {
    const val = ta.value;
    hl.innerHTML = window.PYHL ? window.PYHL.highlight(val) : esc(val);
    rst.hidden = (val === initial);
    let allOk = true;
    (d.checks || []).forEach((c, i) => {
      const re = new RegExp(c.re, c.flags || '');
      const ok = re.test(val);
      const li = $(`li[data-ci="${i}"]`, box);
      if (li) {
        li.style.color = ok ? 'var(--green)' : 'var(--dim)';
        li.textContent = (ok ? '✓ ' : '○ ') + c.msg;
      }
      if (!ok) allOk = false;
    });
    if (allOk && (d.checks || []).length > 0) {
      $('.msg', box).innerHTML = `<b style="color:var(--green)">✓ All criteria satisfied!</b>`;
    } else {
      $('.msg', box).textContent = '';
    }
  };

  ta.addEventListener('input', evaluateChecks);
  evaluateChecks();

  box.addEventListener('click', e => {
    if (e.target.closest('[data-a="reset"]')) {
      ta.value = initial;
      evaluateChecks();
      return;
    }
    if (e.target.closest('[data-a="ide"]')) {
      openInIDE({
        id: 'chal_' + hash(d.title),
        name: d.title,
        main: 'main.py',
        files: [{ path: 'main.py', text: ta.value }],
        task: d
      });
      return;
    }
  });
}

/* ══════════════ Bookmarks Tab ══════════════ */
function renderBM() {
  const host = $('#bmlist');
  if (!host) return;
  const keys = Object.keys(state.bm || {});
  if (keys.length === 0) {
    host.innerHTML = `
      <div class="empty">
        <b>☆</b>
        <b>No bookmarks saved yet.</b>
        <p class="mini">Tap the ☆ icon on any topic, exercise, or exam question to collect them here for quick revision.</p>
      </div>
    `;
    return;
  }

  let html = `<div style="display:grid;gap:.8rem">`;
  keys.forEach(id => {
    const target = document.getElementById(id);
    if (target) {
      const clone = target.cloneNode(true);
      clone.classList.add('open');
      html += clone.outerHTML;
    }
  });
  html += `</div>`;
  host.innerHTML = html;
  hydrateIn(host);
}

/* ══════════════ Full LaTeX-Style Python IDE System ══════════════ */
const LSIDE = 'py12_ide_v1';
const IDE_TEMPLATES = {
  pendulum: {
    name: 'Simple Pendulum (NumPy & Pandas)',
    main: 'main.py',
    files: [
      {
        path: 'main.py',
        text: `import numpy as np
import pandas as pd

# Simple Pendulum Experiment: Length L (m) and Period T (s)
df = pd.read_csv('experiment_data.csv')
df['T2'] = df['Period_T_s'] ** 2

# Linear regression: T^2 = (4*pi^2 / g) * L
slope, intercept = np.polyfit(df['Length_m'], df['T2'], 1)
g_calc = (4 * np.pi ** 2) / slope

print("=== Simple Pendulum Observations ===")
print(df.to_string(index=False))
print(f"\\nSlope (T^2 / L): {slope:.4f} s^2/m")
print(f"Calculated g: {g_calc:.2f} m/s^2 (Theoretical: 9.80 m/s^2)")
`
      },
      {
        path: 'experiment_data.csv',
        text: `Length_m,Period_T_s
0.40,1.27
0.50,1.42
0.60,1.55
0.70,1.68
0.80,1.79
0.90,1.90
1.00,2.01
`
      }
    ]
  },

  matrix: {
    name: 'Matrix Algebra & Linear Systems (NumPy)',
    main: 'main.py',
    files: [
      {
        path: 'main.py',
        text: `import numpy as np

# System of linear equations for physics circuit loop analysis:
#  2x +  y -  z =  8
# -3x -  y + 2z = -11
# -2x +  y + 2z = -3

A = np.array([
    [ 2.0,  1.0, -1.0],
    [-3.0, -1.0,  2.0],
    [-2.0,  1.0,  2.0]
])
B = np.array([8.0, -11.0, -3.0])

det_A = np.linalg.det(A)
inv_A = np.linalg.inv(A)
sol = np.linalg.solve(A, B)
evals, evecs = np.linalg.eig(A)

print("Matrix A:\\n", A)
print(f"\\nDeterminant det(A): {det_A:.4f}")
print("\\nInverse Matrix A^(-1):\\n", inv_A.round(4))
print(f"\\nSolution [x, y, z]: {sol.round(4)}")
print(f"Eigenvalues: {evals.round(4)}")
`
      }
    ]
  },

  capacitor: {
    name: 'Capacitor Charging Curve (Matplotlib & NumPy)',
    main: 'main.py',
    files: [
      {
        path: 'main.py',
        text: `import numpy as np
import matplotlib.pyplot as plt

# RC circuit capacitor charging simulation (ExpEYES physics setup)
R = 10000.0   # 10 kOhm
C = 100e-6    # 100 uF
tau = R * C   # Time constant = 1.0 s
V0 = 5.0      # Applied voltage (V)

t = np.linspace(0, 5, 100)
V = V0 * (1 - np.exp(-t / tau))

plt.figure(figsize=(7, 4.5))
plt.plot(t, V, 'b-', lw=2, label='V(t) = V0(1 - e^(-t/tau))')
plt.axvline(tau, color='r', linestyle='--', label=f'tau = {tau:.1f}s (63.2% V0)')
plt.axhline(0.632 * V0, color='g', linestyle=':', label='3.16 V (0.632 V0)')

plt.title('Capacitor Charging Curve (RC Circuit Simulation)')
plt.xlabel('Time t (seconds)')
plt.ylabel('Voltage across Capacitor (V)')
plt.grid(True, alpha=0.3)
plt.legend()
plt.tight_layout()
plt.show()

print(f"RC Time Constant tau: {tau:.2f} seconds")
print(f"Theoretical Voltage at t = tau: {V0 * (1 - np.exp(-1)):.3f} V")
`
      }
    ]
  },

  hooke: {
    name: "Hooke's Law Spring Constant (Pandas)",
    main: 'main.py',
    files: [
      {
        path: 'main.py',
        text: `import pandas as pd

df = pd.read_csv('spring_data.csv')
g = 9.80

df['Force_N'] = (df['Mass_g'] / 1000.0) * g
df['Extension_m'] = df['Extension_mm'] / 1000.0
df['k_N_per_m'] = df['Force_N'] / df['Extension_m']

print("=== Hooke's Law Experimental Data ===")
print(df[['Material', 'Mass_g', 'Extension_mm', 'Force_N', 'k_N_per_m']].round(3))

print("\\n=== Spring Constant Statistics by Material ===")
summary = df.groupby('Material')['k_N_per_m'].agg(['mean', 'std', 'count']).round(2)
print(summary)
`
      },
      {
        path: 'spring_data.csv',
        text: `Material,Mass_g,Extension_mm
Steel,100,4.0
Steel,200,8.1
Steel,300,12.0
Copper,100,7.5
Copper,200,15.2
Copper,300,22.8
`
      }
    ]
  },

  blank: {
    name: 'Blank Python Script',
    main: 'main.py',
    files: [
      {
        path: 'main.py',
        text: `# Python for Data Analysis (SEC2)
import numpy as np
import pandas as pd

print("Ready to analyze physics data!")
`
      }
    ]
  }
};

let ide = null;
function ideLoad() {
  try { ide = JSON.parse(localStorage.getItem(LSIDE)); } catch (e) {}
  if (!ide || !ide.projects) {
    ide = { projects: {}, order: [], cur: null, ui: {} };
    newProject('pendulum', { id: 'pendulum' });
    newProject('matrix', { id: 'matrix', quiet: true });
    newProject('capacitor', { id: 'capacitor', quiet: true });
    ide.cur = 'pendulum';
  }
  ide.ui = ide.ui || {};
}

const ideSave = debounce(() => {
  try { localStorage.setItem(LSIDE, JSON.stringify(ide)); } catch (e) { toast('Storage full — download your project'); }
}, 350);

const curProj = () => ide.projects[ide.cur];

function newProject(tpl, o) {
  o = o || {};
  const t = IDE_TEMPLATES[tpl] || IDE_TEMPLATES.pendulum;
  const id = o.id || ('p' + Date.now().toString(36));
  const files = (o.files || t.files).map(f => ({ path: f.path, text: f.text }));
  const p = {
    id,
    name: o.name || t.name,
    main: o.main || t.main,
    files,
    open: [o.main || t.main],
    cur: o.main || t.main,
    folders: [],
    t: Date.now()
  };
  if (o.orig) p.orig = files.map(f => ({ path: f.path, text: f.text }));
  if (o.task) p.task = o.task;
  ide.projects[id] = p;
  ide.order = [id].concat((ide.order || []).filter(x => x !== id));
  return p;
}

function openInIDE(spec) {
  if (!ide) ideLoad();
  let p = ide.projects[spec.id];
  if (!p) {
    p = newProject(null, { id: spec.id, name: spec.name, files: spec.files, main: spec.main, orig: spec.files, task: spec.task });
  } else {
    p.name = spec.name;
    ide.order = [p.id].concat(ide.order.filter(x => x !== p.id));
  }
  ide.cur = p.id;
  ideSave();
  IDE.from = { view: curView, y: scrollY };
  showView('ide');
  IDE.load();
}

/* Code area with line numbering gutter (--gw: 42px) */
const KEYS = [
  ['def', 'def '],
  ['class', 'class '],
  ['import np', 'import numpy as np\n'],
  ['import pd', 'import pandas as pd\n'],
  ['import plt', 'import matplotlib.pyplot as plt\n'],
  ['import sns', 'import seaborn as sns\n'],
  ['print()', 'print()', 1],
  [':', ':'],
  ['for', 'for i in range():', 2],
  ['tab (4)', '    ']
];

const CODE_HTML = `
  <div class="code">
    <div class="codein" style="position:relative">
      <pre class="hlp" aria-hidden="true"></pre>
      <textarea spellcheck="false" autocapitalize="off" autocomplete="off" autocorrect="off" wrap="soft" aria-label="Python source"></textarea>
    </div>
  </div>
  <div class="keybar"></div>
`;

function codeArea(w, o) {
  const ta = $('textarea', w), pre = $('pre.hlp', w), box = $('.code', w), kb = $('.keybar', w);
  let text = '', lang = 'python', lineHTML = [], lineTxt = [], marks = {};

  kb.innerHTML = KEYS.map((k, i) => `<button data-k="${i}" title="${esc(k[1])}">${esc(k[0])}</button>`).join('');
  kb.addEventListener('pointerdown', e => {
    const b = e.target.closest('button');
    if (!b) return;
    e.preventDefault();
    const k = KEYS[+b.dataset.k];
    insert(k[1], k[2]);
  });

  function insert(txt, inside) {
    ta.focus();
    const s = ta.selectionStart, e = ta.selectionEnd;
    let ok = false;
    try { ok = document.execCommand('insertText', false, txt); } catch (x) {}
    if (!ok) ta.setRangeText(txt, s, e, 'end');
    if (inside) {
      ta.selectionStart = ta.selectionEnd = s + txt.length - inside;
    }
    onInput();
  }

  const paint = () => {
    pre.innerHTML = lineHTML.map((h, i) => `<span class="ln${marks[i + 1] ? ' ' + marks[i + 1] : ''}" data-n="${i + 1}">${h || '\u200b'}</span>`).join('');
  };

  function plainUpdate() {
    const t = text.split('\n');
    let a = 0;
    while (a < t.length && a < lineTxt.length && t[a] === lineTxt[a]) a++;
    let b = 0;
    while (b < t.length - a && b < lineTxt.length - a && t[t.length - 1 - b] === lineTxt[lineTxt.length - 1 - b]) b++;
    lineHTML = lineHTML.slice(0, a).concat(t.slice(a, t.length - b).map(esc), lineHTML.slice(lineHTML.length - b));
    lineTxt = t;
    paint();
  }

  const colour = debounce(() => {
    const hl = window.PYHL ? window.PYHL.highlight(text) : esc(text);
    lineHTML = hl.split('\n');
    lineTxt = text.split('\n');
    paint();
  }, 70);

  function onInput() {
    if (ta.value === text) return;
    text = ta.value;
    plainUpdate();
    colour();
    o.onInput && o.onInput(text);
  }

  ta.addEventListener('input', onInput);
  ta.addEventListener('scroll', () => {
    if (ta.scrollTop !== 0 || ta.scrollLeft !== 0) {
      box.scrollTop += ta.scrollTop;
      box.scrollLeft += ta.scrollLeft;
      ta.scrollTop = 0;
      ta.scrollLeft = 0;
    }
  });

  box.addEventListener('scroll', () => {
    if (ta.scrollTop !== 0 || ta.scrollLeft !== 0) {
      ta.scrollTop = 0;
      ta.scrollLeft = 0;
    }
  });

  ta.addEventListener('keydown', e => {
    const mod = e.ctrlKey || e.metaKey;
    if (e.key === 'Tab') {
      e.preventDefault();
      const s = ta.selectionStart, v = ta.value;
      if (e.shiftKey) {
        const ls = v.lastIndexOf('\n', s - 1) + 1;
        if (v.slice(ls, ls + 4) === '    ') {
          ta.setRangeText('', ls, ls + 4, 'preserve');
          onInput();
        }
      } else {
        insert('    ');
      }
    } else if (e.key === 'Enter' && !mod) {
      const s = ta.selectionStart, v = ta.value;
      const ls = v.lastIndexOf('\n', s - 1) + 1;
      const curLine = v.slice(ls, s);
      const ind = (/^[ \t]*/.exec(curLine) || [''])[0];
      const extra = /:\s*$/.test(curLine) ? '    ' : '';
      e.preventDefault();
      insert('\n' + ind + extra);
    } else if (e.key === 'Enter' && mod) {
      e.preventDefault();
      o.onRun && o.onRun();
    } else if (e.key === '/' && mod) {
      e.preventDefault();
      toggleComment();
    } else if ((e.key === 's' || e.key === 'S') && mod) {
      e.preventDefault();
      o.onSave && o.onSave();
    }
  });

  function toggleComment() {
    const v = ta.value, s = ta.selectionStart, e2 = ta.selectionEnd;
    const ls = v.lastIndexOf('\n', s - 1) + 1;
    const le = v.indexOf('\n', e2);
    const lines = v.slice(ls, le < 0 ? v.length : le).split('\n');
    const all = lines.every(l => /^\s*#/.test(l) || !l.trim());
    const out = lines.map(l => all ? l.replace(/^(\s*)# ?/, '$1') : (l.trim() ? '# ' + l : l)).join('\n');
    ta.setSelectionRange(ls, le < 0 ? v.length : le);
    insert(out);
  }

  function load(t, l) {
    text = t;
    lang = l || 'python';
    ta.value = t;
    lineTxt = t.split('\n');
    const hl = window.PYHL ? window.PYHL.highlight(t) : esc(t);
    lineHTML = hl.split('\n');
    marks = {};
    paint();
  }

  function goLine(n) {
    const lines = text.split('\n');
    n = Math.max(1, Math.min(n || 1, lines.length));
    let pos = 0;
    for (let i = 0; i < n - 1; i++) pos += lines[i].length + 1;
    ta.focus({ preventScroll: true });
    ta.setSelectionRange(pos, pos + lines[n - 1].length);
    const ln = pre.querySelector(`.ln[data-n="${n}"]`);
    if (ln) {
      ln.classList.add('flash');
      setTimeout(() => ln.classList.remove('flash'), 1000);
      box.scrollTop = ln.offsetTop - box.clientHeight / 3;
    }
  }

  return { load, insert, goLine, setMarks(m) { marks = m || {}; paint(); }, get text() { return text; }, ta, box };
}

/* Fast Python Linter */
function lintPython(code) {
  const issues = [];
  const lines = code.split('\n');
  const stack = [];

  lines.forEach((l, idx) => {
    const lineNum = idx + 1;
    const clean = l.replace(/#.*$/, '');
    for (let i = 0; i < clean.length; i++) {
      const ch = clean[i];
      if (ch === '(' || ch === '[' || ch === '{') stack.push({ ch, lineNum });
      else if (ch === ')' || ch === ']' || ch === '}') {
        const top = stack.pop();
        if (!top) {
          issues.push({ line: lineNum, sev: 'error', msg: `Unmatched closing '${ch}'`, fix: `Remove '${ch}' or add matching open bracket.` });
        } else {
          const match = (top.ch === '(' && ch === ')') || (top.ch === '[' && ch === ']') || (top.ch === '{' && ch === '}');
          if (!match) {
            issues.push({ line: lineNum, sev: 'error', msg: `Mismatched '${top.ch}' closed with '${ch}'`, fix: `Close with '${top.ch === '(' ? ')' : top.ch === '[' ? ']' : '}'}' instead.` });
          }
        }
      }
    }
    if (/^\s*(def|class|if|elif|else|for|while|try|except|finally|with)\b[^:]*$/.test(clean.trim())) {
      issues.push({ line: lineNum, sev: 'error', msg: `Missing colon ':' at end of header`, fix: `Add ':' at the end of the line.` });
    }
  });

  while (stack.length) {
    const unclosed = stack.pop();
    issues.push({ line: unclosed.lineNum, sev: 'error', msg: `Unclosed '${unclosed.ch}'`, fix: `Close with '${unclosed.ch === '(' ? ')' : unclosed.ch === '[' ? ']' : '}'}'` });
  }

  return issues;
}

/* Pyodide Runtime Controller */
const PY_RUNTIME = {
  pyodide: null,
  loading: false,

  async get() {
    if (this.pyodide) return this.pyodide;
    if (this.loading) {
      while (this.loading) await new Promise(r => setTimeout(r, 80));
      return this.pyodide;
    }
    if (window.PY_OFFLINE) return null;

    this.loading = true;
    try {
      if (!window.loadPyodide) {
        await new Promise((resolve, reject) => {
          const s = document.createElement('script');
          s.src = 'https://cdn.jsdelivr.net/pyodide/v0.26.4/full/pyodide.js';
          s.onload = resolve;
          s.onerror = () => reject(new Error('Failed to load Pyodide CDN'));
          document.head.appendChild(s);
        });
      }
      const py = await window.loadPyodide({
        indexURL: 'https://cdn.jsdelivr.net/pyodide/v0.26.4/full/'
      });
      this.pyodide = py;
      return py;
    } catch (e) {
      console.warn('Pyodide CDN initialization error:', e);
      return null;
    } finally {
      this.loading = false;
    }
  }
};

/* Mount Full LaTeX IDE */
const IDE = { el: null, load: () => {} };
function mountIDE() {
  if (IDE.el) return;
  if (!ide) ideLoad();

  const host = $('#view-ide');
  const online = !window.PY_OFFLINE;

  host.innerHTML = `
    <div class="ide" data-mode="split">
      <div class="ide-bar">
        <button class="ib" data-i="files" title="Show / hide files">☰</button>
        <button class="ib back" data-i="back" title="Back to where you were" hidden>←</button>
        <button class="projbtn" data-i="proj" title="Projects"><span>📁</span><b></b><span class="car">▾</span></button>
        <span class="grow"></span>
        <div class="seg"><button data-m="code">Code</button><button data-m="split">Split</button><button data-m="out">Output</button></div>
        <button class="ib hide-m" data-i="swap" title="Swap code and output">⇄</button>
        <button class="ib go" data-i="run" title="Run Python code (Ctrl+Enter)">▶<span class="hide-m"> Run</span></button>
        <button class="ib" data-i="more" title="More">⋯</button>
      </div>

      <aside class="ide-files" aria-label="Files">
        <div class="fh">
          <span>Files</span><span class="grow"></span>
          <button data-i="newfile" title="New file">＋</button>
          <button data-i="newfolder" title="New folder">＋🗀</button>
          <button data-i="upload" title="Upload files">⤒</button>
        </div>
        <div class="tree"></div>
        <div class="fmain"></div>
        <input type="file" multiple hidden accept=".py,.csv,.txt,.dat,.json">
      </aside>

      <div class="scrim"></div>

      <div class="ide-main">
        <div class="ide-out lxed">
          <div class="out-back-bar">
            <button class="btn back-to-code" data-m="code">← Back to Code</button>
            <span class="grow"></span>
            <button class="recompile-btn" data-i="run">▶ Run</button>
          </div>
          <div class="outwrap">
            ${online ? `
              <div class="pane on" data-p="term">
                <div class="ide-term-body"><pre><span class="stdout">Python IDE ready. Click '▶ Run' to execute code with Pyodide WebAssembly.</span></pre></div>
              </div>
              <div class="pane" data-p="plot">
                <div style="color:#A0AEC0;font-size:.85rem;text-align:center">No Matplotlib / Seaborn plots generated yet.</div>
              </div>
              <div class="spin"><span><i></i>Python is running…</span></div>
            ` : `
              <div class="pygate">
                <p><b>Pyodide WebAssembly Python Runtime</b></p>
                <p>The interactive IDE runs NumPy, Pandas, Matplotlib, and Seaborn using in-browser WebAssembly when connected to the internet.</p>
                <p><a class="btn primary" href="https://ssc-data-science-qm.web.app/PYTHON_12.html#ide" target="_blank" rel="noopener">Open IDE in Online Version ↗</a></p>
                <p><button class="btn" data-i="zip">⤓ Download Project .zip</button> <button class="btn" data-i="dlpy">⤓ Download Current File</button></p>
                <p class="mini" style="color:var(--faint);margin-top:1rem">All your edits and project files are safely saved in your browser storage.</p>
              </div>
            `}
          </div>
          <div class="tabs">
            <button class="on" data-i="term">Terminal Console</button>
            <button data-i="plot">Matplotlib Plot</button>
            <span class="grow"></span>
            <button data-i="clear" title="Clear console output">Clear</button>
          </div>
        </div>

        <div class="ide-edit lxed">
          <div class="task" hidden></div>
          <div class="ftabs"></div>
          ${CODE_HTML}
          <div class="status"><span class="dot"></span><span class="txt">Ready</span><span class="count"></span></div>
          <div class="errlist"></div>
        </div>
      </div>

      <div class="drop">Drop .py / .csv / .txt files to add them</div>
    </div>
  `;

  const w = $('.ide', host);
  IDE.el = w;
  const status = $('.status', w), list = $('.errlist', w), tree = $('.tree', w), ftabs = $('.ftabs', w);
  const termBody = $('.ide-term-body pre', w), plotPane = $('.pane[data-p="plot"]', w), spin = $('.spin', w);

  let last = { findings: [] };
  const scrolls = {};
  const file = path => curProj().files.find(f => f.path === path);

  const ca = codeArea($('.ide-edit', w), {
    onInput: t => {
      const f = file(curProj().cur);
      if (f) { f.text = t; curProj().t = Date.now(); ideSave(); }
      lint();
    },
    onRun: () => runCode(),
    onSave: () => ideSave()
  });

  const ui = ide.ui;
  const mobile = () => matchMedia('(max-width:899px)').matches;

  function setMode(m) {
    if (mobile() && m === 'split') m = 'code';
    ui.mode = m;
    w.dataset.mode = m;
    $$('.seg button', w).forEach(b => b.classList.toggle('on', b.dataset.m === m));
    ideSave();
  }

  setMode(ui.mode || 'split');
  w.classList.toggle('swap', !!ui.swap);
  w.classList.toggle('nofiles', !!ui.nofiles);

  function paintTree() {
    const p = curProj(), errs = new Set(last.findings.filter(f => f.sev === 'error').map(f => f.file));
    const dirs = new Set(p.folders || []);
    p.files.forEach(f => {
      const parts = f.path.split('/');
      for (let i = 1; i < parts.length; i++) dirs.add(parts.slice(0, i).join('/'));
    });
    const closed = p.closed || {};
    const items = [...dirs].map(d => ({ path: d, dir: true })).concat(p.files.map(f => ({ path: f.path })));
    items.sort((a, b) => a.path.localeCompare(b.path));

    tree.innerHTML = items.filter(it => {
      const parts = it.path.split('/');
      for (let i = 1; i < parts.length; i++) if (closed[parts.slice(0, i).join('/')]) return false;
      return true;
    }).map(it => {
      const depth = it.path.split('/').length - 1, name = it.path.split('/').pop();
      if (it.dir) return `<div class="row dir" data-dir="${esc(it.path)}" style="padding-left:${.4 + depth * .9}rem"><span class="ic">${closed[it.path] ? '▸' : '▾'}</span><span class="nm">${esc(name)}/</span><button class="dot3" data-menu="${esc(it.path)}" data-isdir="1" title="Folder actions">⋯</button></div>`;
      const ic = /\.py$/i.test(name) ? '🐍' : /\.csv$/i.test(name) ? '📊' : '📄';
      return `<div class="row${it.path === p.cur ? ' on' : ''}" data-p="${esc(it.path)}" style="padding-left:${.4 + depth * .9}rem">
        <span class="ic">${ic}</span><span class="nm">${esc(name)}</span>
        ${errs.has(it.path) ? '<span class="err" title="has errors"></span>' : ''}
        ${it.path === p.main ? '<span class="mainb" title="main script">main</span>' : ''}
        <button class="dot3" data-menu="${esc(it.path)}" title="File actions">⋯</button>
      </div>`;
    }).join('') || '<div class="mini" style="padding:.6rem">No files. Tap ＋ to make one.</div>';

    $('.fmain', w).innerHTML = `Runs <b>${esc(p.main)}</b> · ${p.files.length} file${p.files.length > 1 ? 's' : ''}`;
    $('.projbtn b', w).textContent = p.name;
  }

  function paintTabs() {
    const p = curProj();
    p.open = (p.open || []).filter(x => file(x));
    if (p.cur && !p.open.includes(p.cur)) p.open.push(p.cur);
    ftabs.innerHTML = p.open.map(x => `<div class="ft${x === p.cur ? ' on' : ''}" data-p="${esc(x)}" title="${esc(x)}"><span>${esc(x.split('/').pop())}</span><button class="x" data-close="${esc(x)}" aria-label="close">×</button></div>`).join('');
    const on = $('.ft.on', ftabs);
    if (on) on.scrollIntoView({ block: 'nearest', inline: 'nearest' });
  }

  function openFile(path) {
    const p = curProj();
    if (p.cur) scrolls[p.id + ':' + p.cur] = ca.box.scrollTop;
    if (!file(path)) {
      const t = p.files.find(f => /\.py$/i.test(f.path)) || p.files[0];
      path = t ? t.path : null;
    }
    p.cur = path;
    const f = file(path);
    ca.load(f ? f.text : '', f ? (/\.py$/i.test(f.path) ? 'python' : 'text') : 'python');
    ca.ta.disabled = !f;
    ca.box.scrollTop = scrolls[p.id + ':' + path] || 0;
    paintTabs();
    paintTree();
    lint();
    ideSave();
    if (mobile()) w.classList.remove('files-open');
  }

  const lint = debounce(() => {
    const p = curProj();
    const curF = file(p.cur);
    if (!curF || !/\.py$/i.test(curF.path)) {
      last.findings = [];
      paintStatus();
      return;
    }
    const issues = lintPython(curF.text).map(iss => ({ ...iss, file: curF.path }));
    last.findings = issues;
    paintStatus();
    checkTask();
  }, 250);

  function paintStatus() {
    const p = curProj(), F = last.findings;
    const marks = {};
    F.filter(f => f.file === p.cur).forEach(f => {
      if (f.line) marks[f.line] = f.sev === 'error' ? 'err' : 'warn';
    });
    ca.setMarks(marks);

    const E = F.filter(f => f.sev === 'error');
    status.classList.toggle('bad', E.length > 0);
    status.classList.toggle('warn', E.length === 0 && F.length > 0);

    const first = F[0];
    $('.txt', status).innerHTML = first ? `<b>Line ${first.line || '?'}:</b> ${esc(first.msg)}` : `<b>● Ready</b>`;
    $('.count', status).textContent = F.length ? `${F.length} issue${F.length > 1 ? 's' : ''} ▾` : '';
    list.innerHTML = F.map((f, i) => `
      <div class="e${f.sev === 'error' ? '' : ' w'}" data-i="${i}">
        <span class="ln2">L${f.line || '?'}</span>
        <span class="msg">${esc(f.msg)}</span>
        ${f.fix ? `<span class="fix">${esc(f.fix)}</span>` : ''}
      </div>
    `).join('');
    if (!F.length) list.classList.remove('on');
    $$('.e', list).forEach(x => {
      x.onclick = () => {
        const f = F[+x.dataset.i];
        ca.goLine(f.line);
      };
    });
  }

  status.onclick = () => { if (list.innerHTML) list.classList.toggle('on'); };

  function checkTask() {
    const p = curProj(), box = $('.task', w), d = p.task;
    if (!d) { box.hidden = true; return; }
    const main = file(p.main);
    const code = main ? main.text : '';
    const res = (d.checks || []).map(c => ({ msg: c.msg, ok: new RegExp(c.re, c.flags || '').test(code) }));
    const all = res.length > 0 && res.every(x => x.ok);
    box.hidden = false;
    box.classList.toggle('solved', all);
    box.innerHTML = `
      <div class="tk">
        <span class="tag">${d.kind === 'fix' ? 'Fix the Bug' : 'Challenge'}</span>
        <b>${esc(d.title || '')}</b>
        <span class="grow"></span>
        <button class="minibtn" data-i="taskfold">${box.dataset.fold ? 'show' : 'hide'}</button>
      </div>
      ${box.dataset.fold ? '' : `
        ${d.brief ? `<p>${esc(d.brief)}</p>` : ''}
        <ul>${res.map(x => `<li class="${x.ok ? 'ok' : ''}">${esc(x.msg)}</li>`).join('')}</ul>
      `}
      <div class="tkm">${all ? '<b class="good">✓ Every check passes — solved!</b>' : 'The checklist updates as you type.'}</div>
    `;
    if (all && !state.done[p.id]) {
      state.done[p.id] = true;
      persist();
      toast('Challenge solved ✓');
    }
  }

  /* Async Pyodide Execution */
  async function runCode() {
    if (window.PY_OFFLINE) {
      toast('Execution requires the online version with Pyodide Wasm');
      return;
    }

    const p = curProj();
    const mainFile = file(p.main);
    if (!mainFile) { toast('Please set a main .py file'); return; }

    if (mobile()) setMode('out');
    else if (ui.mode === 'code') setMode('split');

    $$('.tabs button', w).forEach(b => b.classList.toggle('on', b.dataset.i === 'term'));
    $('.pane[data-p="term"]', w).classList.add('on');
    $('.pane[data-p="plot"]', w).classList.remove('on');

    if (spin) spin.classList.add('on');
    if (termBody) termBody.innerHTML = '<span class="stdout">Running Python script...</span>\n';

    const t0 = performance.now();
    try {
      const py = await PY_RUNTIME.get();
      if (!py) throw new Error('Could not initialize Pyodide WebAssembly runtime');

      // Write all project files to virtual filesystem
      if (py.FS) {
        p.files.forEach(f => {
          try {
            const parts = f.path.split('/');
            if (parts.length > 1) {
              let cur = '';
              for (let i = 0; i < parts.length - 1; i++) {
                cur += (cur ? '/' : '') + parts[i];
                try { py.FS.mkdir(cur); } catch (e) {}
              }
            }
            py.FS.writeFile(f.path, f.text);
          } catch (e) {}
        });
      }

      // Load packages dynamically from imports
      await py.loadPackagesFromImports(mainFile.text);

      let stdoutBuf = '';
      let stderrBuf = '';
      py.setStdout({ batched: msg => { stdoutBuf += msg + '\n'; } });
      py.setStderr({ batched: msg => { stderrBuf += msg + '\n'; } });

      const harness = `
import sys, io, base64
_captured_plots = []
try:
    import matplotlib.pyplot as _plt
    _plt.close('all')
except Exception:
    pass

try:
    exec(${JSON.stringify(mainFile.text)}, globals())
    try:
        import matplotlib.pyplot as _plt
        for _fignum in _plt.get_fignums():
            _fig = _plt.figure(_fignum)
            _buf = io.BytesIO()
            _fig.savefig(_buf, format='png', bbox_inches='tight', dpi=120)
            _buf.seek(0)
            _captured_plots.append(base64.b64encode(_buf.read()).decode('ascii'))
            _plt.close(_fig)
    except Exception:
        pass
except Exception as _e:
    import traceback
    sys.stderr.write(traceback.format_exc())
`;

      await py.runPythonAsync(harness);
      const elapsed = Math.round(performance.now() - t0);

      termBody.innerHTML = '';
      if (stdoutBuf) termBody.innerHTML += `<span class="stdout">${esc(stdoutBuf)}</span>`;
      if (stderrBuf) {
        termBody.innerHTML += `<span class="stderr">${esc(stderrBuf)}</span>`;
        // Parse traceback line if present
        const m = /File "<string>", line (\d+)/.exec(stderrBuf);
        if (m) {
          last.findings = [{ line: +m[1], sev: 'error', file: p.main, msg: 'Runtime Exception', fix: 'Check traceback output above.' }];
          paintStatus();
        }
      }
      if (!stdoutBuf && !stderrBuf) {
        termBody.innerHTML += `<span style="color:#A0AEC0">Execution completed with no printed output.</span>`;
      }
      termBody.innerHTML += `\n<span style="color:#68D391;font-size:.74rem">✔ Done in ${elapsed}ms</span>`;

      // Render plots
      const plots = py.globals.get('_captured_plots');
      if (plots && plots.length > 0) {
        const plotList = plots.toJs();
        plotPane.innerHTML = plotList.map(b64 => `<img src="data:image/png;base64,${b64}" alt="Matplotlib Plot">`).join('');
        $$('.tabs button', w).forEach(b => b.classList.toggle('on', b.dataset.i === 'plot'));
        $('.pane[data-p="plot"]', w).classList.add('on');
        $('.pane[data-p="term"]', w).classList.remove('on');
        toast('Plot generated!');
      } else {
        plotPane.innerHTML = '<div style="color:#A0AEC0;font-size:.85rem;text-align:center">No Matplotlib / Seaborn plots generated in this run.</div>';
      }

    } catch (err) {
      termBody.innerHTML = `<span class="stderr">Execution error: ${esc(err.message)}</span>`;
    } finally {
      if (spin) spin.classList.remove('on');
    }
  }

  /* Menus */
  let menu = null;
  const closeMenu = () => { if (menu) { menu.remove(); menu = null; } };
  function openMenu(anchor, items) {
    closeMenu();
    menu = document.createElement('div');
    menu.className = 'menu';
    menu.setAttribute('role', 'menu');
    menu.innerHTML = items.map((it, i) =>
      it === '-' ? '<hr>' : it.head ? `<div class="mh2">${esc(it.head)}</div>` :
      `<button data-mi="${i}" class="${it.cur ? 'cur' : ''}${it.danger ? ' danger' : ''}"${it.dis ? ' disabled' : ''}>${it.icon ? `<span>${it.icon}</span>` : ''}<span>${esc(it.label)}</span>${it.hint ? `<small>${esc(it.hint)}</small>` : ''}</button>`
    ).join('');
    w.appendChild(menu);
    const r = anchor.getBoundingClientRect(), mw = menu.offsetWidth, mh = menu.offsetHeight;
    let x = Math.min(r.left, innerWidth - mw - 8), y = r.bottom + 4;
    if (y + mh > innerHeight - 8) y = Math.max(8, r.top - mh - 4);
    menu.style.left = Math.max(8, x) + 'px';
    menu.style.top = y + 'px';
    menu.addEventListener('click', e => {
      const b = e.target.closest('[data-mi]');
      if (!b) return;
      const it = items[+b.dataset.mi];
      closeMenu();
      it.act && it.act();
    });
  }

  document.addEventListener('pointerdown', e => {
    if (menu && !menu.contains(e.target) && !e.target.closest('[data-i="proj"],[data-i="more"],[data-menu]')) closeMenu();
  });

  const validPath = s => /^[A-Za-z0-9_.\-]+(\/[A-Za-z0-9_.\-]+)*$/.test(s) && !/(^|\/)\.\.?(\/|$)/.test(s);

  async function newFile(dir) {
    const v = await ask({ title: 'New file', msg: 'Letters, digits, <code>_ - . /</code>', value: (dir ? dir + '/' : '') + 'untitled.py', ok: 'Create' });
    if (!v) return;
    let path = v.replace(/^\/+/, '');
    if (!/\.\w+$/.test(path)) path += '.py';
    if (!validPath(path)) { toast('Invalid file name'); return; }
    if (file(path)) { toast(path + ' already exists'); openFile(path); return; }
    curProj().files.push({ path, text: /\.py$/i.test(path) ? '# ' + path + '\n' : '' });
    openFile(path);
    lint();
  }

  async function newFolder() {
    const v = await ask({ title: 'New folder', value: 'data', ok: 'Create', selectAll: true });
    if (!v) return;
    const d = v.replace(/^\/+|\/+$/g, '');
    if (!validPath(d)) { toast('Invalid folder name'); return; }
    curProj().folders = [...new Set((curProj().folders || []).concat(d))];
    paintTree();
    ideSave();
  }

  async function renamePath(path, isDir) {
    const v = await ask({ title: isDir ? 'Rename folder' : 'Rename or move file', value: path, ok: 'Rename' });
    if (!v || v === path) return;
    const to = v.replace(/^\/+|\/+$/g, '');
    if (!validPath(to)) { toast('Invalid name'); return; }
    const p = curProj();
    if (isDir) {
      p.files.forEach(f => { if (f.path.startsWith(path + '/')) f.path = to + f.path.slice(path.length); });
      p.folders = (p.folders || []).map(d => d === path || d.startsWith(path + '/') ? to + d.slice(path.length) : d);
      if (p.main.startsWith(path + '/')) p.main = to + p.main.slice(path.length);
      p.open = p.open.map(x => x.startsWith(path + '/') ? to + x.slice(path.length) : x);
      if (p.cur && p.cur.startsWith(path + '/')) p.cur = to + p.cur.slice(path.length);
    } else {
      if (file(to)) { toast(to + ' already exists'); return; }
      const f = file(path);
      f.path = to;
      if (p.main === path) p.main = to;
      p.open = p.open.map(x => x === path ? to : x);
      if (p.cur === path) p.cur = to;
    }
    paintTree();
    paintTabs();
    ideSave();
  }

  function fileMenu(anchor, path, isDir) {
    const p = curProj();
    if (isDir) {
      openMenu(anchor, [
        { icon: '＋', label: 'New file in ' + path, act: () => newFile(path) },
        { icon: '✎', label: 'Rename folder', act: () => renamePath(path, true) },
        { icon: '✕', label: 'Delete folder', danger: true, act: async () => {
          const inside = p.files.filter(f => f.path.startsWith(path + '/'));
          if (!await ask({ title: 'Delete folder “' + path + '”?', msg: inside.length ? inside.length + ' file(s) inside will be deleted.' : '', ok: 'Delete', danger: true })) return;
          p.files = p.files.filter(f => !f.path.startsWith(path + '/'));
          p.folders = (p.folders || []).filter(d => d !== path && !d.startsWith(path + '/'));
          p.open = p.open.filter(x => !x.startsWith(path + '/'));
          if (p.cur && p.cur.startsWith(path + '/')) openFile(p.open[0] || p.main);
          paintTree(); ideSave();
        }}
      ]);
      return;
    }
    openMenu(anchor, [
      /\.py$/i.test(path) ? { icon: '★', label: 'Set as main script', dis: p.main === path, hint: p.main === path ? 'current main' : '', act: () => { p.main = path; paintTree(); lint(); ideSave(); toast(path + ' is now executed on Run'); } } : null,
      { icon: '✎', label: 'Rename or move', act: () => renamePath(path, false) },
      { icon: '⧉', label: 'Duplicate', act: () => {
        const f = file(path);
        const np = path.replace(/(\.\w+)?$/, '-copy$1');
        p.files.push({ path: np, text: f.text });
        openFile(np);
        paintTree();
        ideSave();
      }},
      { icon: '⤓', label: 'Download file', act: () => {
        const f = file(path);
        saveFile(f.path.split('/').pop(), new Blob([f.text], { type: 'text/plain' }));
      }},
      p.files.length > 1 ? { icon: '✕', label: 'Delete', danger: true, act: async () => {
        if (!await ask({ title: 'Delete “' + path + '”?', ok: 'Delete', danger: true })) return;
        p.files = p.files.filter(f => f.path !== path);
        p.open = p.open.filter(x => x !== path);
        if (p.main === path) p.main = (p.files.find(f => /\.py$/i.test(f.path)) || p.files[0]).path;
        if (p.cur === path) openFile(p.open[0] || p.main);
        else { paintTree(); lint(); ideSave(); }
      }} : null
    ].filter(Boolean));
  }

  function projMenu(anchor) {
    closeMenu();
    openMenu(anchor, [
      { head: 'Projects' }
    ].concat(ide.order.map(id => ({
      icon: id === ide.cur ? '●' : '○',
      cur: id === ide.cur,
      label: ide.projects[id].name,
      hint: ide.projects[id].files.length + ' file' + (ide.projects[id].files.length > 1 ? 's' : ''),
      act: () => { ide.cur = id; ideSave(); IDE.load(); }
    }))).concat([
      '-',
      { icon: '＋', label: 'New project…', act: async () => {
        const keys = Object.keys(IDE_TEMPLATES);
        const r = await ask({
          title: 'New project',
          value: 'My Physics Project',
          options: keys.map(k => ({ label: IDE_TEMPLATES[k].name, desc: IDE_TEMPLATES[k].files.map(f => f.path).join(', ') }))
        });
        if (!r) return;
        const np = newProject(keys[r.option], { name: r.value || IDE_TEMPLATES[keys[r.option]].name });
        ide.cur = np.id;
        ideSave();
        IDE.load();
      }},
      { icon: '⧉', label: 'Duplicate project', act: () => {
        const p = curProj();
        const np = newProject(null, { name: p.name + ' (copy)', files: p.files, main: p.main });
        ide.cur = np.id;
        ideSave();
        IDE.load();
      }}
    ]));
  }

  function moreMenu(anchor) {
    const p = curProj();
    openMenu(anchor, [
      { icon: '⤓', label: 'Download project as .zip', act: () => saveFile(p.name.replace(/[^\w\-]+/g, '_') + '.zip', zipBlob(p.files)) },
      p.orig ? { icon: '↺', label: 'Reset to original template', danger: true, act: async () => {
        if (!await ask({ title: 'Reset “' + p.name + '”?', msg: 'Discards your changes and restores original files.', ok: 'Reset', danger: true })) return;
        p.files = p.orig.map(f => ({ path: f.path, text: f.text }));
        p.open = [p.main];
        p.cur = p.main;
        ideSave();
        IDE.load();
      }} : null,
      ide.order.length > 1 ? { icon: '✕', label: 'Delete project', danger: true, act: async () => {
        if (!await ask({ title: 'Delete “' + p.name + '”?', msg: 'All files will be deleted permanently.', ok: 'Delete', danger: true })) return;
        delete ide.projects[p.id];
        ide.order = ide.order.filter(x => x !== p.id);
        ide.cur = ide.order[0];
        ideSave();
        IDE.load();
      }} : null
    ].filter(Boolean));
  }

  /* File upload and drag-and-drop */
  function addFiles(list) {
    const p = curProj();
    let n = 0, lastPath = null;
    for (const f of list) {
      if (f.size > 1000000) { toast(f.name + ' is too large (>1MB)'); continue; }
      const r = new FileReader();
      r.onload = () => {
        const path = f.name;
        const ex = file(path);
        if (ex) ex.text = r.result;
        else p.files.push({ path, text: r.result });
        lastPath = path;
        n++;
        if (n === list.length) {
          openFile(lastPath);
          lint();
          toast(n + ' file' + (n > 1 ? 's' : '') + ' added');
        }
      };
      r.readAsText(f);
    }
  }

  $('input[type=file]', w).addEventListener('change', e => {
    addFiles([...e.target.files]);
    e.target.value = '';
  });

  let dragN = 0;
  w.addEventListener('dragenter', e => {
    if ([...(e.dataTransfer.types || [])].includes('Files')) { dragN++; w.classList.add('dragging'); }
  });
  w.addEventListener('dragleave', () => { if (--dragN <= 0) { dragN = 0; w.classList.remove('dragging'); } });
  w.addEventListener('dragover', e => { if (w.classList.contains('dragging')) e.preventDefault(); });
  w.addEventListener('drop', e => {
    e.preventDefault();
    dragN = 0;
    w.classList.remove('dragging');
    addFiles([...e.dataTransfer.files]);
  });

  w.addEventListener('click', e => {
    const mm = e.target.closest('[data-m]');
    if (mm) { setMode(mm.dataset.m); return; }

    const cl = e.target.closest('[data-close]');
    if (cl) {
      const p = curProj(), x = cl.dataset.close;
      const k = p.open.indexOf(x);
      p.open = p.open.filter(y => y !== x);
      if (p.cur === x) openFile(p.open[Math.max(0, k - 1)] || p.main);
      else paintTabs();
      ideSave();
      return;
    }

    const me = e.target.closest('[data-menu]');
    if (me) { e.stopPropagation(); fileMenu(me, me.dataset.menu, !!me.dataset.isdir); return; }

    const row = e.target.closest('.tree .row[data-p], .ftabs .ft');
    if (row) { openFile(row.dataset.p); return; }

    const dr = e.target.closest('.tree .row[data-dir]');
    if (dr) {
      const p = curProj();
      p.closed = p.closed || {};
      p.closed[dr.dataset.dir] = !p.closed[dr.dataset.dir];
      paintTree();
      ideSave();
      return;
    }

    if (e.target.classList.contains('scrim')) { w.classList.remove('files-open'); return; }

    const b = e.target.closest('[data-i]');
    if (!b) return;
    const a = b.dataset.i;
    if (a === 'files') {
      if (mobile()) w.classList.toggle('files-open');
      else { ui.nofiles = !ui.nofiles; w.classList.toggle('nofiles', ui.nofiles); ideSave(); }
    } else if (a === 'back' && IDE.from) {
      const f = IDE.from;
      IDE.from = null;
      b.hidden = true;
      showView(f.view);
      setTimeout(() => scrollTo(0, f.y), 30);
    } else if (a === 'proj') projMenu(b);
    else if (a === 'more') moreMenu(b);
    else if (a === 'swap') { ui.swap = !ui.swap; w.classList.toggle('swap', ui.swap); ideSave(); }
    else if (a === 'run') runCode();
    else if (a === 'term') {
      $$('.tabs button', w).forEach(tb => tb.classList.toggle('on', tb.dataset.i === 'term'));
      $('.pane[data-p="term"]', w).classList.add('on');
      $('.pane[data-p="plot"]', w).classList.remove('on');
    } else if (a === 'plot') {
      $$('.tabs button', w).forEach(tb => tb.classList.toggle('on', tb.dataset.i === 'plot'));
      $('.pane[data-p="plot"]', w).classList.add('on');
      $('.pane[data-p="term"]', w).classList.remove('on');
    } else if (a === 'clear') {
      if (termBody) termBody.innerHTML = '';
      if (plotPane) plotPane.innerHTML = '<div style="color:#A0AEC0;font-size:.85rem;text-align:center">Cleared.</div>';
    } else if (a === 'zip') {
      const p = curProj();
      saveFile(p.name.replace(/[^\w\-]+/g, '_') + '.zip', zipBlob(p.files));
    } else if (a === 'dlpy') {
      const p = curProj();
      const f = file(p.cur) || file(p.main);
      if (f) saveFile(f.path.split('/').pop(), new Blob([f.text], { type: 'text/plain' }));
    } else if (a === 'newfile') newFile();
    else if (a === 'newfolder') newFolder();
    else if (a === 'upload') $('input[type=file]', w).click();
    else if (a === 'taskfold') {
      const box = $('.task', w);
      if (box.dataset.fold) delete box.dataset.fold; else box.dataset.fold = '1';
      checkTask();
    }
  });

  ca.ta.addEventListener('focus', () => { if (mobile()) document.body.classList.add('typing'); });
  ca.ta.addEventListener('blur', () => setTimeout(() => { if (document.activeElement !== ca.ta) document.body.classList.remove('typing'); }, 150));

  IDE.load = () => {
    closeMenu();
    const p = curProj();
    $('.task', w).hidden = !p.task;
    delete $('.task', w).dataset.fold;
    last = { findings: [] };
    $('[data-i="back"]', w).hidden = !IDE.from;
    openFile(p.cur || p.main);
    lint();
  };

  IDE.load();

  // Background Pyodide preload after idle delay
  if (!window.PY_OFFLINE) {
    if ('requestIdleCallback' in window) {
      window.requestIdleCallback(() => PY_RUNTIME.get(), { timeout: 3500 });
    } else {
      setTimeout(() => PY_RUNTIME.get(), 2500);
    }
  }
}

/* Kick off application */
document.addEventListener('DOMContentLoaded', () => {
  initTheme();
  initNav();
  buildTree();
  updateProgress();
});
