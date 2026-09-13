import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

// ════════════════════════════════════════════════════════════════════════════
// 3D Unit Cell Interactive Widget
// ════════════════════════════════════════════════════════════════════════════

enum CrystalType { sc, bcc, fcc, diamond, nacl }

class CrystalInfo {
  final String name;
  final String label;
  final String nFormula;
  final String nValue;
  final String cn;
  final String arRelation;
  final double packingFraction;
  final String packingText;
  final String touchDirection;
  final String examples;

  const CrystalInfo({
    required this.name,
    required this.label,
    required this.nFormula,
    required this.nValue,
    required this.cn,
    required this.arRelation,
    required this.packingFraction,
    required this.packingText,
    required this.touchDirection,
    required this.examples,
  });
}

const Map<CrystalType, CrystalInfo> kCrystalData = {
  CrystalType.sc: CrystalInfo(
    name: 'Simple Cubic (SC)',
    label: 'SC',
    nFormula: '8 × (1/8)',
    nValue: '1',
    cn: '6',
    arRelation: 'a = 2r',
    packingFraction: 0.5236,
    packingText: 'π/6 ≈ 52.4%',
    touchDirection: 'Cube edges ⟨100⟩',
    examples: 'Polonium (Po)',
  ),
  CrystalType.bcc: CrystalInfo(
    name: 'Body-Centred Cubic (BCC)',
    label: 'BCC',
    nFormula: '8 × (1/8) + 1',
    nValue: '2',
    cn: '8',
    arRelation: '√3 a = 4r',
    packingFraction: 0.6802,
    packingText: 'π√3/8 ≈ 68.0%',
    touchDirection: 'Body diagonal ⟨111⟩',
    examples: 'Na, Fe (α), Cr, W, K',
  ),
  CrystalType.fcc: CrystalInfo(
    name: 'Face-Centred Cubic (FCC)',
    label: 'FCC',
    nFormula: '8 × (1/8) + 6 × (1/2)',
    nValue: '4',
    cn: '12',
    arRelation: '√2 a = 4r',
    packingFraction: 0.7405,
    packingText: 'π/(3√2) ≈ 74.0%',
    touchDirection: 'Face diagonal ⟨110⟩',
    examples: 'Cu, Al, Ag, Au, Pb, Ni',
  ),
  CrystalType.diamond: CrystalInfo(
    name: 'Diamond Cubic',
    label: 'Diamond',
    nFormula: 'FCC (4) + 4 basis atoms',
    nValue: '8',
    cn: '4 (tetrahedral)',
    arRelation: '√3 a = 8r',
    packingFraction: 0.3401,
    packingText: 'π√3/16 ≈ 34.0%',
    touchDirection: '1/4 body diagonal',
    examples: 'Diamond (C), Si, Ge, α-Sn',
  ),
  CrystalType.nacl: CrystalInfo(
    name: 'Sodium Chloride (NaCl)',
    label: 'NaCl',
    nFormula: '4 Na⁺ + 4 Cl⁻',
    nValue: '4 formula units',
    cn: '6 : 6 (octahedral)',
    arRelation: 'a = 2(r₊ + r₋)',
    packingFraction: 0.67,
    packingText: 'Interpenetrating FCC',
    touchDirection: 'Edge centers to corners',
    examples: 'NaCl, KCl, MgO, PbS',
  ),
};

class Interactive3dUnitCell extends StatefulWidget {
  final CrystalType initialType;

  const Interactive3dUnitCell({
    super.key,
    this.initialType = CrystalType.fcc,
  });

  @override
  State<Interactive3dUnitCell> createState() => _Interactive3dUnitCellState();
}

class _Interactive3dUnitCellState extends State<Interactive3dUnitCell> {
  late CrystalType _type;
  double _rotY = 28.0; // degrees
  double _rotX = 22.0; // tilt degrees
  double _sphereSize = 0.38; // 0.15 to 0.50

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final info = kCrystalData[_type]!;
    final accent = isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131722) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF232D3F) : const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.35 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A2234) : const Color(0xFFF1F5F9),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.box, size: 16, color: accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3D CRYSTAL LATTICE & UNIT CELL',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          color: accent,
                        ),
                      ),
                      Text(
                        info.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LucideIcons.move3d, size: 12, color: accent),
                      const SizedBox(width: 4),
                      Text(
                        'DRAG TO ROTATE',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Structure Selector Tabs
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: CrystalType.values.map((t) {
                  final selected = t == _type;
                  final tInfo = kCrystalData[t]!;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: Text(
                        tInfo.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                          color: selected
                              ? Colors.white
                              : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
                        ),
                      ),
                      selected: selected,
                      selectedColor: accent,
                      backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(
                        color: selected
                            ? accent
                            : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
                      ),
                      onSelected: (val) {
                        if (val) setState(() => _type = t);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // 3D Canvas with drag gesture
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _rotY = (_rotY + details.delta.dx * 0.8) % 360;
                _rotX = (_rotX - details.delta.dy * 0.5).clamp(-60.0, 60.0);
              });
            },
            child: SizedBox(
              height: 240,
              child: CustomPaint(
                painter: _UnitCell3dPainter(
                  type: _type,
                  rotY: _rotY,
                  rotX: _rotX,
                  sphereRadiusFraction: _sphereSize,
                  isDark: isDark,
                  accentColor: accent,
                ),
              ),
            ),
          ),

          // Sliders & Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Row(
              children: [
                Icon(LucideIcons.circle, size: 14, color: isDark ? Colors.white70 : Colors.black54),
                const SizedBox(width: 8),
                Text(
                  'Sphere Radius:',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                      trackHeight: 3,
                      activeTrackColor: accent,
                      inactiveTrackColor: isDark ? const Color(0xFF263345) : const Color(0xFFE2E8F0),
                      thumbColor: accent,
                    ),
                    child: Slider(
                      value: _sphereSize,
                      min: 0.15,
                      max: 0.50,
                      onChanged: (v) => setState(() => _sphereSize = v),
                    ),
                  ),
                ),
                Text(
                  _sphereSize.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'JetBrainsMono',
                    color: accent,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    LucideIcons.rotateCcw,
                    size: 15,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                  tooltip: 'Reset View',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  onPressed: () {
                    setState(() {
                      _rotY = 28.0;
                      _rotX = 22.0;
                      _sphereSize = 0.38;
                    });
                  },
                ),
              ],
            ),
          ),

          // Physics Dashboard Cards
          Container(
            margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F131C) : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? const Color(0xFF1E2838) : const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildMetricBadge('Atoms / Cell (N)', info.nValue, info.nFormula, isDark, accent),
                    const SizedBox(width: 8),
                    _buildMetricBadge('Coordination (CN)', info.cn, 'nearest neighbors', isDark, accent),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildMetricBadge('Lattice Geometry', info.arRelation, info.touchDirection, isDark, accent),
                    const SizedBox(width: 8),
                    _buildMetricBadge('Packing Fraction (f)', info.packingText, 'volume occupied', isDark, accent),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(LucideIcons.info, size: 12, color: accent),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Examples: ${info.examples}',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontStyle: FontStyle.italic,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBadge(String title, String val, String sub, bool isDark, Color accent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF171E2D) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF263347) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              val,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                fontFamily: 'JetBrainsMono',
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            Text(
              sub,
              style: TextStyle(
                fontSize: 8.5,
                color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// 3D Unit Cell CustomPainter with Depth-Sorted Spheres & Projection
// ════════════════════════════════════════════════════════════════════════════

class _Atom3D {
  final double x;
  final double y;
  final double z;
  final int kind; // 0 = primary (Na/Cu/Po), 1 = secondary basis (Cl/Diamond interstitial)

  const _Atom3D(this.x, this.y, this.z, [this.kind = 0]);
}

class _UnitCell3dPainter extends CustomPainter {
  final CrystalType type;
  final double rotY;
  final double rotX;
  final double sphereRadiusFraction;
  final bool isDark;
  final Color accentColor;

  _UnitCell3dPainter({
    required this.type,
    required this.rotY,
    required this.rotX,
    required this.sphereRadiusFraction,
    required this.isDark,
    required this.accentColor,
  });

  static const List<List<double>> kCubeCorners = [
    [0, 0, 0],
    [1, 0, 0],
    [1, 1, 0],
    [0, 1, 0],
    [0, 0, 1],
    [1, 0, 1],
    [1, 1, 1],
    [0, 1, 1],
  ];

  static const List<List<int>> kEdges = [
    [0, 1], [1, 2], [2, 3], [3, 0], // bottom loop
    [4, 5], [5, 6], [6, 7], [7, 4], // top loop
    [0, 4], [1, 5], [2, 6], [3, 7], // vertical pillars
  ];

  List<_Atom3D> _getAtomsForType() {
    final corners = kCubeCorners.map((c) => _Atom3D(c[0], c[1], c[2], 0)).toList();

    switch (type) {
      case CrystalType.sc:
        return corners;

      case CrystalType.bcc:
        return [
          ...corners,
          const _Atom3D(0.5, 0.5, 0.5, 0),
        ];

      case CrystalType.fcc:
        return [
          ...corners,
          const _Atom3D(0.5, 0.5, 0.0, 0),
          const _Atom3D(0.5, 0.5, 1.0, 0),
          const _Atom3D(0.5, 0.0, 0.5, 0),
          const _Atom3D(0.5, 1.0, 0.5, 0),
          const _Atom3D(0.0, 0.5, 0.5, 0),
          const _Atom3D(1.0, 0.5, 0.5, 0),
        ];

      case CrystalType.diamond:
        return [
          ...corners,
          const _Atom3D(0.5, 0.5, 0.0, 0),
          const _Atom3D(0.5, 0.5, 1.0, 0),
          const _Atom3D(0.5, 0.0, 0.5, 0),
          const _Atom3D(0.5, 1.0, 0.5, 0),
          const _Atom3D(0.0, 0.5, 0.5, 0),
          const _Atom3D(1.0, 0.5, 0.5, 0),
          // 4 tetrahedral basis atoms
          const _Atom3D(0.25, 0.25, 0.25, 1),
          const _Atom3D(0.75, 0.75, 0.25, 1),
          const _Atom3D(0.75, 0.25, 0.75, 1),
          const _Atom3D(0.25, 0.75, 0.75, 1),
        ];

      case CrystalType.nacl:
        return [
          // Na+ at corners & face centers
          ...corners,
          const _Atom3D(0.5, 0.5, 0.0, 0),
          const _Atom3D(0.5, 0.5, 1.0, 0),
          const _Atom3D(0.5, 0.0, 0.5, 0),
          const _Atom3D(0.5, 1.0, 0.5, 0),
          const _Atom3D(0.0, 0.5, 0.5, 0),
          const _Atom3D(1.0, 0.5, 0.5, 0),
          // Cl- at edge centers and body center
          const _Atom3D(0.5, 0.5, 0.5, 1),
          const _Atom3D(0.5, 0.0, 0.0, 1),
          const _Atom3D(0.0, 0.5, 0.0, 1),
          const _Atom3D(0.0, 0.0, 0.5, 1),
          const _Atom3D(0.5, 1.0, 0.0, 1),
          const _Atom3D(0.5, 0.0, 1.0, 1),
          const _Atom3D(0.5, 1.0, 1.0, 1),
          const _Atom3D(1.0, 0.5, 0.0, 1),
          const _Atom3D(0.0, 0.5, 1.0, 1),
          const _Atom3D(1.0, 0.5, 1.0, 1),
          const _Atom3D(1.0, 0.0, 0.5, 1),
          const _Atom3D(0.0, 1.0, 0.5, 1),
          const _Atom3D(1.0, 1.0, 0.5, 1),
        ];
    }
  }

  // 3D projection mathematical transformation
  List<double> _project(double x, double y, double z, double S, double ox, double oy) {
    final radY = rotY * math.pi / 180.0;
    final radX = rotX * math.pi / 180.0;

    // Centered coordinates [-0.5, 0.5]
    final cx = x - 0.5;
    final cy = y - 0.5;
    final cz = z - 0.5;

    // Rotate around Y axis
    final rx = cx * math.cos(radY) + cz * math.sin(radY);
    final rz = -cx * math.sin(radY) + cz * math.cos(radY);

    // Tilt around X axis
    final ry = cy * math.cos(radX) - rz * math.sin(radX);
    final depth = cy * math.sin(radX) + rz * math.cos(radX);

    final px = ox + rx * S;
    final py = oy - ry * S; // screen Y is inverted

    return [px, py, depth];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final ox = size.width / 2.0;
    final oy = size.height / 2.0;
    final S = math.min(size.width * 0.46, size.height * 0.60);

    // 1. Project cube corners
    final projectedCorners = kCubeCorners.map((c) {
      return _project(c[0], c[1], c[2], S, ox, oy);
    }).toList();

    // 2. Draw rear wireframe edges
    final edgePaint = Paint()
      ..color = isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    for (final edge in kEdges) {
      final p1 = projectedCorners[edge[0]];
      final p2 = projectedCorners[edge[1]];
      canvas.drawLine(Offset(p1[0], p1[1]), Offset(p2[0], p2[1]), edgePaint);
    }

    // 3. Project and depth-sort all atoms
    final atoms = _getAtomsForType();
    final projectedAtoms = atoms.map((atom) {
      final p = _project(atom.x, atom.y, atom.z, S, ox, oy);
      return (
        x: p[0],
        y: p[1],
        depth: p[2],
        kind: atom.kind,
      );
    }).toList();

    // Sort by depth ascending so farthest atoms render first (painter's algorithm)
    projectedAtoms.sort((a, b) => a.depth.compareTo(b.depth));

    // 4. Render spheres with lighting gradient
    for (final atom in projectedAtoms) {
      final radius = sphereRadiusFraction * S * (atom.kind == 1 ? 0.72 : 1.0) * 0.48;

      final center = Offset(atom.x, atom.y);

      final isKind1 = atom.kind == 1;
      final Color brightColor = isKind1
          ? (isDark ? const Color(0xFF34D399) : const Color(0xFF10B981))
          : (isDark ? const Color(0xFFFBBF24) : const Color(0xFFF59E0B));
      final Color shadowColor = isKind1
          ? (isDark ? const Color(0xFF065F46) : const Color(0xFF047857))
          : (isDark ? const Color(0xFF92400E) : const Color(0xFFB45309));

      final gradient = RadialGradient(
        center: const Alignment(-0.35, -0.35),
        radius: 0.85,
        colors: [
          Colors.white.withOpacity(0.85),
          brightColor,
          shadowColor,
        ],
        stops: const [0.0, 0.45, 1.0],
      );

      final paint = Paint()
        ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, paint);

      // Sphere border
      final strokePaint = Paint()
        ..color = isDark ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.15)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, strokePaint);
    }

    // 5. Draw front wireframe edges highlight
    final frontEdgePaint = Paint()
      ..color = isDark ? const Color(0x6694A3B8) : const Color(0x6664748B)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (final edge in kEdges) {
      final p1 = projectedCorners[edge[0]];
      final p2 = projectedCorners[edge[1]];
      if (p1[2] > 0 || p2[2] > 0) {
        canvas.drawLine(Offset(p1[0], p1[1]), Offset(p2[0], p2[1]), frontEdgePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _UnitCell3dPainter oldDelegate) {
    return oldDelegate.type != type ||
        oldDelegate.rotY != rotY ||
        oldDelegate.rotX != rotX ||
        oldDelegate.sphereRadiusFraction != sphereRadiusFraction ||
        oldDelegate.isDark != isDark;
  }
}

// ════════════════════════════════════════════════════════════════════════════
// 3D Miller Planes Interactive Widget
// ════════════════════════════════════════════════════════════════════════════

class Interactive3dMillerPlanes extends StatefulWidget {
  const Interactive3dMillerPlanes({super.key});

  @override
  State<Interactive3dMillerPlanes> createState() => _Interactive3dMillerPlanesState();
}

class _Interactive3dMillerPlanesState extends State<Interactive3dMillerPlanes> {
  int _h = 1;
  int _k = 1;
  int _l = 0;
  final double _a = 4.0; // lattice constant in Angstroms
  double _rotY = 32.0;
  double _rotX = 24.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? const Color(0xFFA78BFA) : const Color(0xFF7C3AED);

    final sumSq = _h * _h + _k * _k + _l * _l;
    final dHkl = sumSq > 0 ? _a / math.sqrt(sumSq) : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131722) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF232D3F) : const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.35 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A2234) : const Color(0xFFF1F5F9),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.layers, size: 16, color: accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3D MILLER INDICES & LATTICE PLANES',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          color: accent,
                        ),
                      ),
                      Text(
                        'Plane ($_h $_k $_l) in Cubic System',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'BENCH 01',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Preset Planes Selector Pills
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  [1, 0, 0],
                  [1, 1, 0],
                  [1, 1, 1],
                  [2, 0, 0],
                  [2, 2, 0],
                ].map((plane) {
                  final active = _h == plane[0] && _k == plane[1] && _l == plane[2];
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ActionChip(
                      label: Text(
                        '(${plane[0]}${plane[1]}${plane[2]})',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                          color: active ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                        ),
                      ),
                      backgroundColor: active
                          ? accent
                          : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      side: BorderSide(
                        color: active
                            ? accent
                            : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
                      ),
                      onPressed: () {
                        setState(() {
                          _h = plane[0];
                          _k = plane[1];
                          _l = plane[2];
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // 3D Canvas
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _rotY = (_rotY + details.delta.dx * 0.8) % 360;
                _rotX = (_rotX - details.delta.dy * 0.5).clamp(-60.0, 60.0);
              });
            },
            child: SizedBox(
              height: 230,
              child: CustomPaint(
                painter: _MillerPlanes3dPainter(
                  h: _h,
                  k: _k,
                  l: _l,
                  a: _a,
                  rotY: _rotY,
                  rotX: _rotX,
                  isDark: isDark,
                  accentColor: accent,
                ),
              ),
            ),
          ),

          // Steppers for h, k, l
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIndexStepper('h', _h, (val) => setState(() => _h = val), isDark, accent),
                _buildIndexStepper('k', _k, (val) => setState(() => _k = val), isDark, accent),
                _buildIndexStepper('l', _l, (val) => setState(() => _l = val), isDark, accent),
              ],
            ),
          ),

          // Live Metrics Readout
          Container(
            margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F131C) : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? const Color(0xFF1E2838) : const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interplanar Spacing (d_hkl)',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sumSq > 0 ? '${dHkl.toStringAsFixed(3)} Å' : 'Undefined',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'JetBrainsMono',
                          color: accent,
                        ),
                      ),
                      Text(
                        'a / √(h² + k² + l²) = ${_a.toStringAsFixed(1)} / √$sumSq',
                        style: TextStyle(
                          fontSize: 9,
                          color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 38,
                  width: 1,
                  color: isDark ? const Color(0xFF263347) : const Color(0xFFE2E8F0),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intercepts (a/h, b/k, c/l)',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '(${_h == 0 ? "∞" : "1/$_h"}, ${_k == 0 ? "∞" : "1/$_k"}, ${_l == 0 ? "∞" : "1/$_l"})',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'JetBrainsMono',
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        _h == 0 || _k == 0 || _l == 0 ? 'Parallel to zero-index axes' : 'Cuts all 3 crystal axes',
                        style: TextStyle(
                          fontSize: 9,
                          color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexStepper(String name, int val, ValueChanged<int> onChanged, bool isDark, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF171E2D) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isDark ? const Color(0xFF263347) : const Color(0xFFCBD5E1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$name = ',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              fontFamily: 'JetBrainsMono',
              color: accent,
            ),
          ),
          Text(
            '$val',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'JetBrainsMono',
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(width: 3),
          InkWell(
            onTap: val > 0 ? () => onChanged(val - 1) : null,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Icon(
                LucideIcons.minus,
                size: 11,
                color: val > 0 ? (isDark ? Colors.white70 : Colors.black87) : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 1),
          InkWell(
            onTap: val < 3 ? () => onChanged(val + 1) : null,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Icon(
                LucideIcons.plus,
                size: 11,
                color: val < 3 ? (isDark ? Colors.white70 : Colors.black87) : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MillerPlanes3dPainter extends CustomPainter {
  final int h;
  final int k;
  final int l;
  final double a;
  final double rotY;
  final double rotX;
  final bool isDark;
  final Color accentColor;

  _MillerPlanes3dPainter({
    required this.h,
    required this.k,
    required this.l,
    required this.a,
    required this.rotY,
    required this.rotX,
    required this.isDark,
    required this.accentColor,
  });

  static const List<List<double>> kCubeCorners = [
    [0, 0, 0], [1, 0, 0], [1, 1, 0], [0, 1, 0],
    [0, 0, 1], [1, 0, 1], [1, 1, 1], [0, 1, 1],
  ];

  static const List<List<int>> kEdges = [
    [0, 1], [1, 2], [2, 3], [3, 0],
    [4, 5], [5, 6], [6, 7], [7, 4],
    [0, 4], [1, 5], [2, 6], [3, 7],
  ];

  List<double> _project(double x, double y, double z, double S, double ox, double oy) {
    final radY = rotY * math.pi / 180.0;
    final radX = rotX * math.pi / 180.0;

    final cx = x - 0.5;
    final cy = y - 0.5;
    final cz = z - 0.5;

    final rx = cx * math.cos(radY) + cz * math.sin(radY);
    final rz = -cx * math.sin(radY) + cz * math.cos(radY);

    final ry = cy * math.cos(radX) - rz * math.sin(radX);
    final depth = cy * math.sin(radX) + rz * math.cos(radX);

    final px = ox + rx * S;
    final py = oy - ry * S;

    return [px, py, depth];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final ox = size.width / 2.0;
    final oy = size.height / 2.0;
    final S = math.min(size.width * 0.44, size.height * 0.56);

    // 1. Draw cube wireframe
    final projectedCorners = kCubeCorners.map((c) => _project(c[0], c[1], c[2], S, ox, oy)).toList();

    final wirePaint = Paint()
      ..color = isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (final edge in kEdges) {
      final p1 = projectedCorners[edge[0]];
      final p2 = projectedCorners[edge[1]];
      canvas.drawLine(Offset(p1[0], p1[1]), Offset(p2[0], p2[1]), wirePaint);
    }

    // 2. Compute 3D plane polygon intersecting the unit cell cube
    final sum = h * h + k * k + l * l;
    if (sum > 0) {
      double f(List<double> p) => h * p[0] + k * p[1] + l * p[2] - 1.0;

      final pts = <List<double>>[];
      for (final edge in kEdges) {
        final A = kCubeCorners[edge[0]];
        final B = kCubeCorners[edge[1]];
        final fa = f(A);
        final fb = f(B);

        if (fa * fb < 0) {
          final t = fa / (fa - fb);
          final ix = A[0] + t * (B[0] - A[0]);
          final iy = A[1] + t * (B[1] - A[1]);
          final iz = A[2] + t * (B[2] - A[2]);
          pts.add(_project(ix, iy, iz, S, ox, oy));
        } else if (fa.abs() < 1e-9) {
          pts.add(_project(A[0], A[1], A[2], S, ox, oy));
        }
      }

      if (pts.length >= 3) {
        // Calculate centroid of points to sort them radially in 2D
        final cx = pts.map((p) => p[0]).reduce((a, b) => a + b) / pts.length;
        final cy = pts.map((p) => p[1]).reduce((a, b) => a + b) / pts.length;

        pts.sort((a, b) {
          final angleA = math.atan2(a[1] - cy, a[0] - cx);
          final angleB = math.atan2(b[1] - cy, b[0] - cx);
          return angleA.compareTo(angleB);
        });

        final path = Path();
        path.moveTo(pts[0][0], pts[0][1]);
        for (var i = 1; i < pts.length; i++) {
          path.lineTo(pts[i][0], pts[i][1]);
        }
        path.close();

        // Shaded plane fill
        final planeFill = Paint()
          ..color = accentColor.withOpacity(0.35)
          ..style = PaintingStyle.fill;
        canvas.drawPath(path, planeFill);

        // Crisp plane border
        final planeStroke = Paint()
          ..color = accentColor
          ..strokeWidth = 2.2
          ..style = PaintingStyle.stroke;
        canvas.drawPath(path, planeStroke);
      }

      // 3. Mark axis intercept dots
      final axes = [
        (h, 0, 'a'),
        (k, 1, 'b'),
        (l, 2, 'c'),
      ];

      for (final ax in axes) {
        if (ax.$1 != 0) {
          final q = [0.0, 0.0, 0.0];
          q[ax.$2] = 1.0 / ax.$1;
          final p = _project(q[0], q[1], q[2], S, ox, oy);

          final dotPaint = Paint()..color = const Color(0xFF10B981);
          canvas.drawCircle(Offset(p[0], p[1]), 4.5, dotPaint);

          final tp = TextPainter(
            text: TextSpan(
              text: '${ax.$3}/${ax.$1}',
              style: const TextStyle(
                color: Color(0xFF10B981),
                fontSize: 10,
                fontWeight: FontWeight.w800,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout();
          tp.paint(canvas, Offset(p[0] + 6, p[1] - 8));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MillerPlanes3dPainter oldDelegate) {
    return oldDelegate.h != h ||
        oldDelegate.k != k ||
        oldDelegate.l != l ||
        oldDelegate.a != a ||
        oldDelegate.rotY != rotY ||
        oldDelegate.rotX != rotX ||
        oldDelegate.isDark != isDark;
  }
}
