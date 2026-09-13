/* ═══════════════════ MODULE MAP ═══════════════════ */
const MODULES = [
  { id: 'mod-0', name: 'Start here', sub: 'Course syllabus · Modules I & II roadmap', stations: ['start'] },
  { id: 'mod-1', name: 'Module I', sub: 'Core Python, collections & NumPy', stations: ['m1-types', 'm1-collections', 'm1-control', 'm1-functions', 'm1-numpy'] },
  { id: 'mod-2', name: 'Module II', sub: 'Pandas DataFrames, stats & groupby', stations: ['m2-dataframe', 'm2-attributes', 'm2-missing', 'm2-stats', 'm2-correlation', 'm2-wrangling'] },
  { id: 'mod-3', name: 'Model tests', sub: 'Two full-length exam papers (50m each)', stations: ['test-1', 'test-2'] },
  { id: 'mod-4', name: 'Practice', sub: 'Retrieval OMR sheet with instant feedback', stations: ['omr-practice'] }
];

window.MODULES = MODULES;
window.STATIONS = STATIONS;
