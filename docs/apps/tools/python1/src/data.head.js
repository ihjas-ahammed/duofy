/* ══════════════════════════════════════════════════════════════════
   Python for Data Analysis · Calicut Univ B.Sc. Physics SEC2
   Content Helpers & Interactive Widget Registry
   ══════════════════════════════════════════════════════════════════ */
window.PYREG = { ex: {}, w: {} };
const PYR = window.PYREG;
const P = (s, ...v) => String.raw(s, ...v);
const H = P;
const hsh = s => { let h = 5381; for (let i = 0; i < s.length; i++) h = ((h << 5) + h + s.charCodeAt(i)) | 0; return Math.abs(h).toString(36); };
const escH = s => String(s).replace(/[&<>"]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));

/* Example box: displays clean code snippet + pre-generated terminal/table output + "Open in IDE" */
function ex(code, o) {
  o = o || {};
  const id = 'x' + hsh(code + (o.title || ''));
  PYR.ex[id] = {
    code: code.trim(),
    out: o.out !== undefined ? String(o.out).trim() : '',
    title: o.title || '',
    note: o.note || '',
    plot: o.plot || null,
    lang: 'python'
  };
  return `<div class="ex" data-ex="${id}"></div>`;
}

function W(type, d) {
  const id = type + hsh(JSON.stringify(d));
  PYR.w[id] = Object.assign({ type }, d);
  return `<div data-w="${id}"></div>`;
}

const omr = (title, qs) => W('omr', { title, qs });
const cards = (title, list) => W('cards', { title, list });
const match = (title, pairs, o) => W('match', Object.assign({ title, pairs }, o || {}));
const fill = (title, text, o) => W('fill', Object.assign({ title, text }, o || {}));
const parsons = (title, lines, o) => W('parsons', Object.assign({ title, lines }, o || {}));
const predict = (title, code, options, answer, why, out) => W('predict', { title, code, options, answer, why, out });
const fix = (title, start, o) => W('challenge', Object.assign({ kind: 'fix', title, start }, o || {}));
const build = (title, start, o) => W('challenge', Object.assign({ kind: 'build', title, start }, o || {}));
const editor = (code, o) => W('editor', Object.assign({ code }, o || {}));

const tp = t => `<div class="topic"><h3>${t}</h3></div>`;
const gist = t => `<div class="gist"><span class="k">in one line</span>${t}</div>`;
const must = h => `<div class="note"><div class="nh">learn this by heart</div>${h}</div>`;
const trap = h => `<div class="note pitfall"><div class="nh">where marks get lost</div>${h}</div>`;
const why = h => `<div class="note why"><div class="nh">why it is taught this way</div>${h}</div>`;
const k = x => `<code>${escH(x)}</code>`;
const paper = (name, time, marks) => `<div class="paperhead"><b>${name}</b><div class="meta"><span>Time: ${time}</span><span>Max marks: ${marks}</span></div></div>`;
const secband = (l, r) => `<div class="secband"><b>Section ${l}</b><span>${r}</span></div>`;
const qa = (m, q, a) => {
  const id = 'qa' + hsh(q + a);
  return `<details class="qa" data-q="${id}"><summary><span class="pn">${m}</span><span class="pt">${q}</span><button class="star" data-bm="${id}" title="Bookmark this question for review" aria-label="Bookmark for review">☆</button><span class="chev">›</span></summary><div class="pbody"><div class="qmeta">model answer</div>${a}</div></details>`;
};

window.STATIONS = [];
