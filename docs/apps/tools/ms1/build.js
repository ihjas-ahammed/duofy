#!/usr/bin/env node
/**
 * Build MATERIAL_SCIENCE_12.html (online) and MATERIAL_SCIENCE_12_OFFLINE.html (self-contained offline)
 * from src/ + vendor/ without python.
 */

const fs = require('fs');
const path = require('path');

const HERE = '/home/ihjas/Documents/GitHub/SSC-FILES/SSC-V2/SEM5/PHY/apps/tools/ms1';
const SRC = path.join(HERE, 'src');
const VEN = path.join(HERE, 'vendor');
const OUT = path.resolve(HERE, '..', '..'); // apps/ directory
const ONLINE_URL = 'https://ssc-data-science-qm.web.app/MATERIAL_SCIENCE_12.html';
const GF = ('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600'
  + '&family=Newsreader:ital,opsz,wght@0,6..72,400..600;1,6..72,400..600'
  + '&family=Source+Sans+3:ital,wght@0,400..700;1,400..700&display=swap');

const rd = p => fs.readFileSync(p, 'utf8');
const js = s => s.replace(/<\/script/gi, '<\\/script');

function uiFontsInline() {
  const cache = path.join(VEN, 'uifonts.css');
  if (fs.existsSync(cache)) return rd(cache);
  return '';
}

function bundleJs() {
  const order = [
    'data.head.js',
    'data.start.js',
    'data.m1.js',
    'data.m2.js',
    'data.bank.m1.js',
    'data.bank.m2.js',
    'data.tail.js',
    'eng.core.js',
    'eng.fig.js',
    'eng.figs.m1.js',
    'eng.figs.m2.js',
    'eng.widgets.js',
    'eng.app.js'
  ];
  const parts = [];
  for (const f of order) {
    const p = path.join(SRC, f);
    if (fs.existsSync(p)) {
      parts.push(rd(p));
    } else {
      console.warn(`Warning: file ${f} not found!`);
    }
  }
  return parts.join('\n;\n');
}

function build(online) {
  const shell = rd(path.join(SRC, 'shell.html'));
  const stamp = new Date().toISOString().split('T')[0];

  const headFonts = online
    ? `<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="${GF}">`
    : `<style>${uiFontsInline()}</style>`;

  const cfg = {
    online,
    onlineURL: ONLINE_URL,
    offlineName: 'MATERIAL_SCIENCE_12_OFFLINE.html'
  };

  const scripts = [];
  scripts.push(`<script>window.MS_CFG = ${JSON.stringify(cfg)};</script>`);

  if (online) {
    scripts.push('<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.2/es5/tex-svg.js"></script>');
  } else {
    const texPath = path.join(VEN, 'tex-svg.js');
    if (fs.existsSync(texPath)) {
      scripts.push('<script>' + js(rd(texPath)) + '</script>');
    } else {
      console.warn('Warning: vendor/tex-svg.js not found for offline build!');
    }
  }

  scripts.push('<script>' + js(bundleJs()) + '</script>');

  const foot = (
    `Built ${stamp} · Calicut University CU-FYUGP B.Sc. Physics Honours · Materials Science Modules I &amp; II`
    + (online
      ? ' · <a href="MATERIAL_SCIENCE_12_OFFLINE.html" download>Download 100% self-contained offline copy</a>'
      : ` · Offline edition — zero network dependencies · For web version visit <a href="${ONLINE_URL}">online app</a>`)
  );

  let html = shell
    .replace('<!--MS:FONTS-->', () => headFonts)
    .replace('<!--MS:SCRIPTS-->', () => scripts.join('\n'))
    .replace('<!--MS:FOOT-->', () => foot);

  const name = online ? 'MATERIAL_SCIENCE_12.html' : 'MATERIAL_SCIENCE_12_OFFLINE.html';
  const dest = path.join(OUT, name);
  fs.writeFileSync(dest, html, 'utf8');
  const sizeBytes = Buffer.byteLength(html, 'utf8');
  console.log(`Built ${name}: ${sizeBytes.toLocaleString()} bytes (${(sizeBytes / (1024 * 1024)).toFixed(2)} MB)`);
}

build(true);
build(false);
