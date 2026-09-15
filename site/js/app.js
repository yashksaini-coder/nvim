(() => {
'use strict';

// ---- settings ---------------------------------------------------------------
const CONFIG = {
  crt: 'subtle',        // 'heavy' | 'subtle' | 'off'
  boot: 'full',         // 'full' | 'quick' | 'none'
  username: 'yks',
  hostname: 'kmos',
};

const PROGRAMS = (window.KEYMAPS && window.KEYMAPS.programs) || [];

const L = s => s.split('').map(c => [c, c.toUpperCase(), 4]);
// [id, legend, grid span (4 = 1u), shifted legend]
const LAYOUT = [
  [['esc','ESC',4],['`','`',4,'~'],['1','1',4,'!'],['2','2',4,'@'],['3','3',4,'#'],['4','4',4,'$'],['5','5',4,'%'],['6','6',4,'^'],['7','7',4,'&'],['8','8',4,'*'],['9','9',4,'('],['0','0',4,')'],['-','-',4,'_'],['=','=',4,'+'],['backspace','BKSP',8]],
  [['tab','TAB',6],...L('qwertyuiop'),['[','[',4,'{'],[']',']',4,'}'],['\\','\\',6,'|']],
  [['caps','CAPS',7],...L('asdfghjkl'),[';',';',4,':'],["'","'",4,'"'],['enter','ENTER',9]],
  [['lshift','SHIFT',9],...L('zxcvbnm'),[',',',',4,'<'],['.','.',4,'>'],['/','/',4,'?'],['rshift','SHIFT',11],[null,'',2],[null,'',4],['up','↑',4]],
  [['lctrl','CTRL',5],['super','SUPER',5],['lalt','ALT',5],['space','SPACE',25],['ralt','ALT',5],['fn','FN',5],['menu','MENU',5],['rctrl','CTRL',5],[null,'',2],['left','←',4],['down','↓',4],['right','→',4]],
];
const MODKEY = { lctrl:'ctrl', rctrl:'ctrl', lshift:'shift', rshift:'shift', lalt:'alt', ralt:'alt', super:'super', fn:'fn' };
const COMMANDS = ['help','ls','man','clear','reboot','whoami','date','uname','echo'];

const $ = id => document.getElementById(id);
const el = {
  root:$('root'), screen:$('screen'), topRight:$('top-right'),
  boot:$('boot'), bootLines:$('boot-lines'),
  shell:$('shell'), banner:$('banner'), bannerStats:$('banner-stats'), log:$('log'), user:$('p-user'), host:$('p-host'), inputText:$('input-text'), input:$('hidden-input'),
  program:$('program'), progName:$('prog-name'), progSub:$('prog-sub'), progStats:$('prog-stats'), tabs:$('mode-tabs'), layerText:$('layer-text'), board:$('board'),
  selLabel:$('sel-label'), selBindings:$('sel-bindings'), selNote:$('sel-note'), listTitle:$('list-title'), allBindings:$('all-bindings'), exitBtn:$('exit-btn'),
};

const state = { phase:'boot', program:null, modeIdx:0, selIdx:0, input:'', history:[], histIdx:-1 };
let bootId = 0, skipEvt = null;

// ---- helpers ----------------------------------------------------------------
const sleep = ms => new Promise(r => setTimeout(r, ms));
const eqMods = (a, b) => { a = a || []; b = b || []; return a.length === b.length && a.every(x => b.includes(x)); };
const countBindings = p => p.modes.reduce((a, m) => a + m.bindings.length, 0);
const findProgram = n => { n = String(n || '').toLowerCase(); return PROGRAMS.find(p => p.id === n || (p.aliases || []).includes(n)) || null; };
const cur = () => PROGRAMS.find(p => p.id === state.program) || null;
const prompt = () => `${CONFIG.username}@${CONFIG.hostname}:~$ `;

function line(parent, text, cls) { const d = document.createElement('div'); d.className = 'line' + (cls ? ' ' + cls : ''); d.textContent = text; parent.appendChild(d); return d; }
function scrollBottom() { el.screen.scrollTop = el.screen.scrollHeight; }
function focus() { el.input.focus({ preventScroll: true }); }
function setPhase(ph) {
  state.phase = ph;
  el.boot.hidden = ph !== 'boot'; el.shell.hidden = ph !== 'shell'; el.program.hidden = ph !== 'program';
  if (ph !== 'program') el.topRight.textContent = ph === 'boot' ? 'POST' : 'SHELL · tty1';
}

// ---- boot -------------------------------------------------------------------
async function boot() {
  const id = ++bootId, alive = () => bootId === id;
  setPhase('boot'); el.bootLines.innerHTML = ''; el.screen.scrollTop = 0;
  if (CONFIG.boot === 'none') return finishBoot();
  const full = CONFIG.boot !== 'quick';
  let last = null;
  const push = (t, cls) => { last = line(el.bootLines, t, cls); scrollBottom(); };
  const setLast = t => { if (last) last.textContent = t; };
  const step = async (ms, fn) => { await sleep(ms); if (!alive()) throw 0; if (fn) fn(); };
  try {
    if (full) {
      await step(260, () => push('CPU  : MOTOROLA MC68040 @ 40 MHz       FPU  : INTEGRATED'));
      await step(140, () => push('BUS  : 32-BIT                          VIDEO: RED/ORANGE PHOSPHOR CRT'));
      await step(140, () => push('KBD  : ANSI 60% + ARROW CLUSTER        MOUSE: NOT REQUIRED'));
      await step(200, () => push('MEM  : 000000K'));
      for (let k = 1; k <= 16; k++) await step(50, () => setLast('MEM  : ' + String(k * 4096).padStart(6, '0') + 'K'));
      await step(120, () => setLast('MEM  : 065536K  OK'));
      await step(200, () => push(''));
    }
    await step(full ? 300 : 120, () => push('Mounting keymap volumes ...'));
    if (!PROGRAMS.length) push('  /dev/km0   read error — js/keymaps.js is empty or missing   [ FAIL ]', 'red');
    for (let i = 0; i < PROGRAMS.length; i++) {
      const p = PROGRAMS[i], n = countBindings(p);
      await step(full ? 240 : 90, () => push(`  /dev/km${i}   ${p.name.padEnd(8)} ${String(p.modes.length).padStart(2)} modes  ${String(n).padStart(4)} bindings   [ OK ]`, 'orange'));
    }
    if (full) await step(200, () => push(`  /dev/km${PROGRAMS.length}   (empty slot)                          [ -- ]`, 'dim'));
    await step(160, () => push(''));
    await step(120, () => push('Loading KMOS kernel '));
    for (let k = 0; k < (full ? 14 : 5); k++) await step(full ? 70 : 40, () => setLast(last.textContent + '.'));
    await step(160, () => setLast(last.textContent + ' done'));
    await step(full ? 380 : 150, () => push('Starting shell on tty1 ...'));
    await step(full ? 650 : 250);
    finishBoot();
  } catch (e) { if (e !== 0) console.error(e); }
}
function finishBoot() {
  bootId++;
  el.log.innerHTML = ''; el.banner.hidden = false;
  const total = PROGRAMS.reduce((a, p) => a + countBindings(p), 0);
  el.bannerStats.textContent = `${PROGRAMS.length} program${PROGRAMS.length === 1 ? '' : 's'} mounted · ${total} bindings`;
  state.input = ''; el.input.value = ''; state.histIdx = -1;
  setPhase('shell'); renderInput(); focus(); scrollBottom();
}

// ---- shell --------------------------------------------------------------------
function print(lines) { lines.forEach(l => typeof l === 'string' ? line(el.log, l) : line(el.log, l.text, l.cls)); scrollBottom(); }
function renderInput() { el.inputText.textContent = state.input; scrollBottom(); }
function setInput(v) { state.input = v; el.input.value = v; renderInput(); }

function runCommand(raw) {
  const echo = { text: prompt() + raw, cls: 'dim' };
  const cmd = raw.trim();
  if (!cmd) return print([echo]);
  if (state.history[state.history.length - 1] !== cmd) {
    state.history = state.history.concat(cmd).slice(-100);
    try { localStorage.setItem('kmos.history.v1', JSON.stringify(state.history)); } catch (e) {}
  }
  const [name, ...args] = cmd.split(/\s+/), lc = name.toLowerCase();
  const prog = findProgram(lc);
  if (prog) return openProgram(prog, args[0], echo);
  const out = [echo];
  switch (lc) {
    case 'help': case '?': out.push(...helpLines()); break;
    case 'ls': case 'dir': case 'programs': out.push(...lsLines()); break;
    case 'man': { const p = args[0] && findProgram(args[0]); if (!p) out.push({ text: args[0] ? `man: no manual entry for ${args[0]}` : 'man: what manual page do you want?  e.g. man nvim', cls: 'red' }); else out.push(...manLines(p)); break; }
    case 'clear': case 'cls': el.log.innerHTML = ''; el.banner.hidden = true; return;
    case 'reboot': boot(); return;
    case 'whoami': out.push(CONFIG.username); break;
    case 'date': out.push(new Date().toLocaleString('en-US', { weekday:'short', month:'short', day:'2-digit', year:'numeric', hour:'2-digit', minute:'2-digit' }).toUpperCase()); break;
    case 'uname': out.push('KMOS 2.0.1 tty1 m68k'); break;
    case 'echo': out.push(args.join(' ')); break;
    case 'exit': case 'logout': case 'quit': out.push({ text: 'logout: nowhere to go. This machine only remembers keymaps.', cls: 'dim' }); break;
    case 'vim': case 'vi': case 'tmux': case 'shell': case 'zsh': case 'bash': case 'emacs': out.push({ text: `kmos: ${lc}: no keymap volume mounted — this machine only knows nvim.`, cls: 'red' }); break;
    default: out.push({ text: `kmos: ${name}: command not found. Try 'help'.`, cls: 'red' });
  }
  print(out);
}
function helpLines() {
  const lines = [{ text: 'KMOS SHELL — commands', cls: 'orange' }, ''];
  PROGRAMS.forEach(p => lines.push(`  ${(p.id + ' [mode]').padEnd(16)}open the ${p.name} keymap viewer${p.aliases && p.aliases.length ? '   (' + p.aliases.join(', ') + ')' : ''}`));
  lines.push('  ls              list mounted keymap programs', '  man <program>   describe a program and its modes', '  clear           clear the screen   (ctrl+l)', '  reboot          run the boot sequence again', '  help            this list', '', { text: '  inside a viewer: scroll the bindings list · tab cycles modes · esc returns here', cls: 'dim' });
  return lines;
}
function lsLines() {
  if (!PROGRAMS.length) return [{ text: 'no keymap volumes mounted — check js/keymaps.js', cls: 'red' }];
  const lines = [{ text: 'PROGRAM   MODES  BINDINGS  DESCRIPTION', cls: 'orange' }];
  PROGRAMS.forEach(p => lines.push(`${p.id.padEnd(10)}${String(p.modes.length).padStart(3)}    ${String(countBindings(p)).padStart(5)}   ${p.desc || ''}`));
  return lines;
}
function manLines(p) {
  const lines = [{ text: `${p.name}(1)`.padEnd(20) + 'KMOS PROGRAMS', cls: 'orange' }, '', 'NAME', `    ${p.id} — ${p.desc || p.title || ''}`, '', 'MODES'];
  p.modes.forEach(m => lines.push(`    ${m.id.padEnd(10)}${String(m.bindings.length).padStart(3)} bindings${m.prefix ? '   (prefix: ' + m.prefix + ')' : ''}`));
  lines.push('', 'USAGE', `    ${p.id} [mode]        e.g.  ${p.id} ${p.modes[p.modes.length - 1].id}`);
  return lines;
}
function histNav(d) {
  const h = state.history; if (!h.length) return;
  let i = state.histIdx; if (i === -1) i = h.length;
  i = Math.min(Math.max(i + d, 0), h.length);
  state.histIdx = i >= h.length ? -1 : i;
  setInput(i >= h.length ? '' : h[i]);
}
function complete() {
  const parts = state.input.split(/\s+/), curTok = parts[parts.length - 1].toLowerCase();
  let cands;
  if (parts.length === 1) cands = [...PROGRAMS.map(p => p.id), ...COMMANDS];
  else { const p = findProgram(parts[0]); cands = p ? p.modes.map(m => m.id) : (parts[0] === 'man' ? PROGRAMS.map(p => p.id) : []); }
  const m = cands.filter(c => c.startsWith(curTok));
  if (m.length === 1) { parts[parts.length - 1] = m[0]; setInput(parts.join(' ') + ' '); }
  else if (m.length > 1) print([{ text: prompt() + state.input, cls: 'dim' }, m.join('   ')]);
}

// ---- program (keymap viewer) ----------------------------------------------------
// Scrolling #all-bindings drives the board: the row whose top has crossed the
// reading line (READ px below the list's top edge) is the selected binding.
const READ = 16; // about half a one-line row, so the selected row stays mostly in view
let scrollFrame = 0, settleFrame = 0;

// Every programmatic move of the list goes through here. Writing scrollTop does
// not cancel a smooth scroll already in flight — Chrome animates PageDown,
// arrows and the wheel for ~250ms — and that animation's pending frames still
// land after the write. Mandatory snap does not correct them, so the list is
// left stranded between rows (PageDown then a quick Tab opened the new mode on
// row 1). Re-apply the target for the next two frames, only if it was moved.
function settleTo(top) {
  const list = el.allBindings;
  cancelAnimationFrame(settleFrame);
  list.scrollTop = top;
  let frames = 2;
  const hold = () => {
    if (Math.abs(list.scrollTop - top) > 1) list.scrollTop = top;
    settleFrame = --frames > 0 ? requestAnimationFrame(hold) : 0;
    if (!settleFrame && state.phase === 'program') syncSelection();
  };
  settleFrame = requestAnimationFrame(hold);
}

function openProgram(p, modeArg, echo) {
  let idx = 0;
  if (modeArg) {
    const a = modeArg.toLowerCase();
    idx = p.modes.findIndex(m => m.id.startsWith(a) || m.label.toLowerCase().startsWith(a));
    if (idx < 0) return print([echo, { text: `${p.id}: unknown mode '${modeArg}'. Modes: ${p.modes.map(m => m.id).join(', ')}`, cls: 'red' }]);
  }
  print([echo, { text: `launching ${p.name} keymap viewer — ${p.modes[idx].label.toLowerCase()} mode`, cls: 'dim' }]);
  state.program = p.id;
  setPhase('program'); setMode(idx); el.screen.scrollTop = 0;
}
function exitProgram() {
  const p = cur();
  state.program = null;
  setPhase('shell');
  print([{ text: `[${p ? p.id : 'program'}] closed — back to shell`, cls: 'dim' }]);
  focus();
}
function setMode(i) { state.modeIdx = i; renderMode(); }
function cycleMode(d) { const p = cur(); if (!p) return; const n = p.modes.length; setMode((state.modeIdx + d + n) % n); }
function programKey(e) {
  if (e.key === 'Escape') { e.preventDefault(); return exitProgram(); }
  if (e.key === 'Tab' && !e.ctrlKey && !e.altKey && !e.metaKey) { e.preventDefault(); return cycleMode(e.shiftKey ? -1 : 1); }
}
function twoSpan(cls, a, b) { const d = document.createElement('div'); d.className = cls; const s1 = document.createElement('span'); s1.className = 'seq'; s1.textContent = a; const s2 = document.createElement('span'); s2.className = 'act'; s2.textContent = b; d.append(s1, s2); return d; }

// Bottom padding lets every row, the last included, reach the reading line.
// Clear the old padding before measuring: with box-sizing:border-box a padding
// larger than the list's height inflates the box, so clientHeight would report
// the previous padding and the list would stay stuck at that height whenever it
// got shorter (a smaller window, or the viewport-based height in style.css).
function padList() {
  // Re-pad, then put the SELECTED ROW back on the reading line — by row, not by
  // saved pixel offset. When the list grows (a window gaining height) the
  // browser lays out with the old, too-small padding before 'resize' fires,
  // clamps scrollTop and snap settles on an earlier row, so any pixel value read
  // here is already wrong. state.selIdx is not: the event loop runs resize steps
  // before scroll steps, and syncSelection is deferred to requestAnimationFrame,
  // which runs after both.
  const list = el.allBindings, last = list.lastElementChild;
  list.style.paddingBottom = '0px';
  list.style.paddingBottom = Math.max(0, Math.ceil(list.clientHeight - (last ? last.getBoundingClientRect().height : 0))) + 'px';
  const row = list.children[state.selIdx];
  settleTo(row ? row.offsetTop : 0);
}
function syncSelection() {
  const rows = el.allBindings.children, at = el.allBindings.scrollTop + READ;
  let i = 0; while (i + 1 < rows.length && rows[i + 1].offsetTop <= at) i++;
  if (i !== state.selIdx) { state.selIdx = i; renderSelection(); }
}

function renderMode() {
  const p = cur(); if (!p) return;
  const mode = p.modes[state.modeIdx];
  cancelAnimationFrame(scrollFrame); scrollFrame = 0;

  el.progName.textContent = p.name; el.progSub.textContent = p.title || '';
  el.progStats.textContent = `${p.modes.length} MODES · ${countBindings(p)} BINDINGS`;

  el.tabs.innerHTML = '';
  p.modes.forEach((m, i) => {
    const t = document.createElement('div'); t.className = 'tab' + (i === state.modeIdx ? ' on' : '');
    const a = document.createElement('span'); a.textContent = m.label;
    const n = document.createElement('span'); n.className = 'n'; n.textContent = m.bindings.length;
    t.append(a, n);
    t.addEventListener('click', () => setMode(i));
    el.tabs.appendChild(t);
  });

  el.listTitle.textContent = `ALL BINDINGS · ${mode.label} (${mode.bindings.length})`;
  el.allBindings.innerHTML = '';
  mode.bindings.forEach(b => el.allBindings.appendChild(twoSpan('b-row', b.seq, b.action)));
  state.selIdx = 0;          // before padList, which restores the selected row
  padList();                 // settles on row 0, cancelling any in-flight scroll
  renderSelection();
  el.allBindings.focus({ preventScroll: true });
}

function renderSelection() {
  const p = cur(); if (!p) return;
  const mode = p.modes[state.modeIdx], sel = mode.bindings[state.selIdx] || null;
  const layer = (sel && sel.mods) || [];
  const byKey = {}; mode.bindings.forEach(b => (byKey[b.key] = byKey[b.key] || []).push(b));
  const modLabel = m => (m || []).map(x => x.toUpperCase()).join(' + ');
  const labelOf = id => { for (const r of LAYOUT) for (const k of r) if (k[0] === id) return k[1]; return String(id).toUpperCase(); };

  el.topRight.textContent = `${p.name} · ${mode.label}`;
  el.layerText.textContent = layer.length ? 'LAYER: ' + modLabel(layer) : 'LAYER: BASE';

  el.board.innerHTML = '';
  LAYOUT.forEach(r => {
    const row = document.createElement('div'); row.className = 'row';
    r.forEach(([id, label, span, sub]) => {
      const k = document.createElement('div'); k.style.gridColumn = 'span ' + span;
      if (!id) { k.className = 'key ghost'; row.appendChild(k); return; }
      const mod = MODKEY[id], bs = byKey[id] || [], inLayer = bs.filter(b => eqMods(b.mods, layer));
      let cls = 'key', badge = '', text = label;
      if (mod) cls += ' mod' + (layer.includes(mod) ? ' on' : '');
      else if (sel && sel.key === id) { cls += ' sel'; if (inLayer.length > 1) badge = inLayer.length; }
      else if (mode.prefix === id) { cls += ' prefix'; text = 'LEADER'; if (inLayer.length) badge = inLayer.length; }
      else if (inLayer.length) { cls += ' lit'; if (inLayer.length > 1) badge = inLayer.length; }
      else if (bs.length) { cls += ' other'; badge = '•'; }
      k.className = cls;
      const s1 = document.createElement('span'); s1.className = 'sub'; s1.textContent = sub || '';
      const s2 = document.createElement('span'); s2.className = 'badge'; s2.textContent = badge;
      const s3 = document.createElement('span'); s3.textContent = text;
      k.append(s1, s2, s3);
      row.appendChild(k);
    });
    el.board.appendChild(row);
  });

  const selBs = sel ? byKey[sel.key] : [];
  const selOther = selBs.filter(b => !eqMods(b.mods, layer));
  el.selLabel.textContent = sel ? [modLabel(layer), labelOf(sel.key)].filter(Boolean).join(' + ') : '—';
  el.selBindings.innerHTML = '';
  selBs.filter(b => eqMods(b.mods, layer)).forEach(b => el.selBindings.appendChild(twoSpan('sel-row' + (b === sel ? ' on' : ''), b.seq, b.action)));
  el.selNote.textContent = !sel ? `No bindings in ${mode.label} mode.`
    : selOther.length ? 'Other layers: ' + selOther.map(b => b.seq).join(' · ') : '';
  const onRow = el.selBindings.querySelector('.on');
  if (onRow) el.selBindings.scrollTop = onRow.offsetTop - (el.selBindings.clientHeight - onRow.offsetHeight) / 2;

  const prev = el.allBindings.querySelector('.b-row.on'); if (prev) prev.classList.remove('on');
  if (sel) el.allBindings.children[state.selIdx].classList.add('on');
}

// ---- events ---------------------------------------------------------------------
window.addEventListener('keydown', e => {
  if (e === skipEvt) { skipEvt = null; return; }
  if (state.phase === 'boot') { e.preventDefault(); return finishBoot(); }
  if (state.phase === 'program') return programKey(e);
  if (document.activeElement !== el.input) {
    if (e.key && e.key.length === 1 && !e.ctrlKey && !e.metaKey && !e.altKey) { e.preventDefault(); setInput(state.input + e.key); }
    focus();
  }
});
const repad = () => { if (state.phase === 'program') { padList(); syncSelection(); } };
window.addEventListener('resize', repad);
if (document.fonts) document.fonts.addEventListener('loadingdone', repad); // web fonts swap in after first measure
el.allBindings.addEventListener('scroll', () => {
  if (scrollFrame) return;
  scrollFrame = requestAnimationFrame(() => { scrollFrame = 0; if (state.phase === 'program') syncSelection(); });
});
el.allBindings.addEventListener('click', e => {
  const row = e.target.closest('.b-row'); if (!row) return;
  settleTo(row.offsetTop); syncSelection();
});
el.input.addEventListener('input', () => { if (state.phase === 'shell') { state.input = el.input.value; renderInput(); } });
el.input.addEventListener('keydown', e => {
  if (state.phase !== 'shell') return;
  const k = e.key, lk = (k || '').toLowerCase();
  if (k === 'Enter') { e.preventDefault(); skipEvt = e; const v = state.input; setInput(''); state.histIdx = -1; runCommand(v); }
  else if (k === 'ArrowUp' || k === 'ArrowDown') { e.preventDefault(); histNav(k === 'ArrowUp' ? -1 : 1); }
  else if (k === 'Tab') { e.preventDefault(); complete(); }
  else if (e.ctrlKey && lk === 'l') { e.preventDefault(); el.log.innerHTML = ''; el.banner.hidden = true; }
  else if (e.ctrlKey && lk === 'c') { e.preventDefault(); print([{ text: prompt() + state.input + '^C', cls: 'dim' }]); setInput(''); state.histIdx = -1; }
  else if (e.ctrlKey && lk === 'u') { e.preventDefault(); setInput(''); }
});
el.root.addEventListener('click', () => {
  if (state.phase === 'boot') finishBoot();
  else if (state.phase === 'program') el.allBindings.focus({ preventScroll: true });
  else focus();
});
el.exitBtn.addEventListener('click', exitProgram);

// ---- start ----------------------------------------------------------------------
document.body.dataset.crt = CONFIG.crt;
el.user.textContent = CONFIG.username; el.host.textContent = CONFIG.hostname;
try { const h = JSON.parse(localStorage.getItem('kmos.history.v1') || '[]'); if (Array.isArray(h)) state.history = h.slice(-100); } catch (e) {}
boot();
})();
