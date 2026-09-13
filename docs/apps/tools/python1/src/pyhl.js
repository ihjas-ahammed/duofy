/* ══════════════════════════════════════════════════════════════════
   Zero-lag Python syntax highlighter for code snippets and IDE
   ══════════════════════════════════════════════════════════════════ */
(function() {
  const esc = s => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

  const TOKEN_RE = /("""[\s\S]*?"""|'''[\s\S]*?'''|[fFrRuUbB]?"(?:\\.|[^"\\])*"|[fFrRuUbB]?'(?:\\.|[^'\\])*'|#[^\n]*|\b(?:def|class|if|elif|else|for|while|try|except|finally|with|as|import|from|return|yield|break|continue|pass|raise|lambda|global|nonlocal|assert|in|is|not|and|or)\b|\b(?:True|False|None)\b|\b(?:print|len|range|int|float|complex|str|list|dict|set|tuple|open|input|sum|min|max|abs|round|enumerate|zip|sorted|type|isinstance|map|filter)\b|\b(?:np|pd|plt|sns|numpy|pandas|matplotlib|seaborn|scipy)\b|\b\d+(?:\.\d+)?(?:[eE][+-]?\d+)?[jJ]?\b|@[a-zA-Z_]\w*|\b[a-zA-Z_]\w*(?=\s*\())/g;

  function highlight(code) {
    if (!code) return '';
    TOKEN_RE.lastIndex = 0;
    let out = '';
    let lastIndex = 0;
    let m;
    while ((m = TOKEN_RE.exec(code)) !== null) {
      if (m.index > lastIndex) {
        out += esc(code.slice(lastIndex, m.index));
      }
      const token = m[0];
      let cls = '';
      if (token.startsWith('#')) cls = 'c';
      else if (token.startsWith('"""') || token.startsWith("'''") || token.startsWith('"') || token.startsWith("'") || /^[fFrRuUbB]?['"]/.test(token)) cls = 's';
      else if (/^(?:True|False|None)$/.test(token)) cls = 'b';
      else if (/^(?:def|class|if|elif|else|for|while|try|except|finally|with|as|import|from|return|yield|break|continue|pass|raise|lambda|global|nonlocal|assert|in|is|not|and|or)$/.test(token)) cls = 'k';
      else if (/^(?:print|len|range|int|float|complex|str|list|dict|set|tuple|open|input|sum|min|max|abs|round|enumerate|zip|sorted|type|isinstance|map|filter)$/.test(token)) cls = 'bi';
      else if (/^(?:np|pd|plt|sns|numpy|pandas|matplotlib|seaborn|scipy)$/.test(token)) cls = 'pkg';
      else if (/^\d/.test(token)) cls = 'num';
      else if (token.startsWith('@')) cls = 'dec';
      else cls = 'fn';

      out += '<span class="tok-' + cls + '">' + esc(token) + '</span>';
      lastIndex = TOKEN_RE.lastIndex;
    }
    if (lastIndex < code.length) {
      out += esc(code.slice(lastIndex));
    }
    return out;
  }

  window.PYHL = {
    highlight,
    highlightInline: s => highlight(s)
  };
})();
