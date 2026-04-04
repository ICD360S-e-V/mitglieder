import 'dart:math';
import 'package:flutter/material.dart';

/// Seasonal background decoration widget.
/// Automatically shows Easter/Spring theme during April (any year).
/// Wrap any screen content with this widget for seasonal decorations.
class SeasonalBackground extends StatelessWidget {
  final Widget child;
  /// When true, Easter decorations are painted BEHIND child (for chat messages).
  /// When false (default), decorations are painted ON TOP as overlay.
  final bool paintBehind;

  const SeasonalBackground({super.key, required this.child, this.paintBehind = false});

  /// Returns true if current month is April (Easter season).
  static bool get isEasterSeason {
    final now = DateTime.now();
    return now.month == 4;
  }

  @override
  Widget build(BuildContext context) {
    if (!isEasterSeason) return child;

    final decoration = Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: _EasterBackgroundPainter(
            brightness: Theme.of(context).brightness,
          ),
        ),
      ),
    );

    return Stack(
      children: paintBehind
          ? [decoration, child]
          : [child, decoration],
    );
  }
}

/// Painter for AppBar Easter decorations (eggs, bunny ears, flowers along the bar).
class EasterAppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(99);
    final opacity = 0.35;

    // Small Easter eggs along the bottom of the AppBar
    final eggColors = [
      Colors.pink.shade300, Colors.purple.shade300, Colors.cyan.shade300,
      Colors.amber.shade400, Colors.lime.shade400, Colors.orange.shade300,
      Colors.red.shade300, Colors.teal.shade300,
    ];

    for (int i = 0; i < 14; i++) {
      final x = 20.0 + rng.nextDouble() * (size.width - 40);
      final y = size.height * 0.3 + rng.nextDouble() * (size.height * 0.6);
      final color = eggColors[i % eggColors.length];
      final eggW = 6.0 + rng.nextDouble() * 5;
      final eggH = eggW * 1.3;
      final rotation = (rng.nextDouble() - 0.5) * 0.5;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);

      final eggPaint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: eggW, height: eggH),
        eggPaint,
      );

      // Stripe
      final stripePaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.7)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawLine(
        Offset(-eggW * 0.35, 0), Offset(eggW * 0.35, 0), stripePaint,
      );

      canvas.restore();
    }

    // Bunny ears poking up from bottom-left
    final bunnyPaint = Paint()
      ..color = Colors.white.withValues(alpha: opacity * 0.6)
      ..style = PaintingStyle.fill;

    final earL = Path();
    earL.moveTo(35, size.height);
    earL.quadraticBezierTo(30, size.height - 28, 35, size.height - 25);
    earL.quadraticBezierTo(40, size.height - 22, 40, size.height);
    canvas.drawPath(earL, bunnyPaint);

    final earR = Path();
    earR.moveTo(45, size.height);
    earR.quadraticBezierTo(44, size.height - 24, 48, size.height - 22);
    earR.quadraticBezierTo(52, size.height - 20, 50, size.height);
    canvas.drawPath(earR, bunnyPaint);

    // Inner ears
    final earInner = Paint()
      ..color = Colors.pink.shade200.withValues(alpha: opacity * 0.5)
      ..style = PaintingStyle.fill;
    final earLI = Path();
    earLI.moveTo(36, size.height);
    earLI.quadraticBezierTo(33, size.height - 20, 36, size.height - 18);
    earLI.quadraticBezierTo(38, size.height - 16, 38, size.height);
    canvas.drawPath(earLI, earInner);

    // Small flowers
    final flowerColors = [Colors.yellow.shade300, Colors.pink.shade200, Colors.white];
    for (int i = 0; i < 6; i++) {
      final fx = size.width * 0.3 + rng.nextDouble() * (size.width * 0.6);
      final fy = size.height * 0.2 + rng.nextDouble() * (size.height * 0.6);
      final fc = flowerColors[i % flowerColors.length];
      final ps = 2.5 + rng.nextDouble() * 2;

      final petalPaint = Paint()
        ..color = fc.withValues(alpha: opacity * 0.6)
        ..style = PaintingStyle.fill;
      for (int p = 0; p < 5; p++) {
        final angle = p * 2 * pi / 5;
        canvas.drawCircle(
          Offset(fx + cos(angle) * ps, fy + sin(angle) * ps), ps * 0.5, petalPaint,
        );
      }
      canvas.drawCircle(
        Offset(fx, fy), ps * 0.3,
        Paint()..color = Colors.amber.shade500.withValues(alpha: opacity * 0.8),
      );
    }

    // Bunny ears poking from bottom-right
    final earR2 = Path();
    earR2.moveTo(size.width - 45, size.height);
    earR2.quadraticBezierTo(size.width - 50, size.height - 26, size.width - 45, size.height - 23);
    earR2.quadraticBezierTo(size.width - 40, size.height - 20, size.width - 40, size.height);
    canvas.drawPath(earR2, bunnyPaint);

    final earR3 = Path();
    earR3.moveTo(size.width - 35, size.height);
    earR3.quadraticBezierTo(size.width - 36, size.height - 22, size.width - 32, size.height - 20);
    earR3.quadraticBezierTo(size.width - 28, size.height - 18, size.width - 30, size.height);
    canvas.drawPath(earR3, bunnyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EasterBackgroundPainter extends CustomPainter {
  final Brightness brightness;

  _EasterBackgroundPainter({required this.brightness});

  @override
  void paint(Canvas canvas, Size size) {
    final isDark = brightness == Brightness.dark;
    final rng = Random(42);

    _drawSky(canvas, size, isDark);
    _drawClouds(canvas, size, isDark, rng);
    _drawGrass(canvas, size, isDark, rng);
    _drawEasterEggs(canvas, size, isDark, rng);
    _drawFlowers(canvas, size, isDark, rng);
    _drawBunnies(canvas, size, isDark, rng);
    _drawButterflies(canvas, size, isDark, rng);
    _drawChicks(canvas, size, isDark, rng);
  }

  void _drawSky(Canvas canvas, Size size, bool isDark) {
    // Subtle gradient sky
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDark
            ? [
                Colors.indigo.shade900.withValues(alpha: 0.15),
                Colors.transparent,
              ]
            : [
                Colors.lightBlue.shade100.withValues(alpha: 0.25),
                Colors.transparent,
              ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.5));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.5), skyPaint);
  }

  void _drawClouds(Canvas canvas, Size size, bool isDark, Random rng) {
    final cloudPaint = Paint()
      ..color = (isDark ? Colors.grey.shade600 : Colors.white)
          .withValues(alpha: isDark ? 0.12 : 0.35)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 4; i++) {
      final x = 50.0 + rng.nextDouble() * (size.width - 100);
      final y = 20.0 + rng.nextDouble() * (size.height * 0.2);
      final scale = 0.7 + rng.nextDouble() * 0.6;

      canvas.save();
      canvas.translate(x, y);
      canvas.scale(scale);

      canvas.drawOval(Rect.fromCenter(center: const Offset(0, 0), width: 60, height: 25), cloudPaint);
      canvas.drawOval(Rect.fromCenter(center: const Offset(-20, -8), width: 40, height: 22), cloudPaint);
      canvas.drawOval(Rect.fromCenter(center: const Offset(18, -6), width: 45, height: 20), cloudPaint);

      canvas.restore();
    }
  }

  void _drawGrass(Canvas canvas, Size size, bool isDark, Random rng) {
    // Thick grass layer at bottom
    final grassPaint = Paint()
      ..color = (isDark ? Colors.green.shade900 : Colors.green.shade400)
          .withValues(alpha: isDark ? 0.25 : 0.35)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    // Wavy grass top
    for (double x = 0; x <= size.width; x += 15) {
      final y = size.height - 40 - sin(x * 0.04) * 12 - sin(x * 0.08) * 6;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, grassPaint);

    // Second layer - darker
    final grass2Paint = Paint()
      ..color = (isDark ? Colors.green.shade800 : Colors.green.shade500)
          .withValues(alpha: isDark ? 0.2 : 0.3)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x += 15) {
      final y = size.height - 25 - sin(x * 0.06 + 1) * 8 - sin(x * 0.03) * 5;
      path2.lineTo(x, y);
    }
    path2.lineTo(size.width, size.height);
    path2.close();
    canvas.drawPath(path2, grass2Paint);

    // Individual grass blades - tall and visible
    final bladePaint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 80; i++) {
      final x = rng.nextDouble() * size.width;
      final baseY = size.height - 30 - sin(x * 0.04) * 12;
      final height = 15.0 + rng.nextDouble() * 25;
      final curve = (rng.nextDouble() - 0.5) * 15;

      bladePaint.color = (isDark
              ? Color.lerp(Colors.green.shade700, Colors.green.shade500, rng.nextDouble())!
              : Color.lerp(Colors.green.shade500, Colors.green.shade700, rng.nextDouble())!)
          .withValues(alpha: isDark ? 0.3 : 0.4);

      final bladePath = Path();
      bladePath.moveTo(x, baseY);
      bladePath.quadraticBezierTo(x + curve, baseY - height * 0.6, x + curve * 0.3, baseY - height);
      canvas.drawPath(bladePath, bladePaint);
    }
  }

  void _drawEasterEggs(Canvas canvas, Size size, bool isDark, Random rng) {
    final eggColors = [
      Colors.pink.shade400,
      Colors.purple.shade400,
      Colors.blue.shade400,
      Colors.teal.shade400,
      Colors.amber.shade500,
      Colors.orange.shade400,
      Colors.red.shade400,
      Colors.indigo.shade400,
      Colors.cyan.shade400,
      Colors.lime.shade500,
    ];

    final opacity = isDark ? 0.3 : 0.45;

    // Eggs in the grass (bottom area)
    for (int i = 0; i < 20; i++) {
      final x = 20.0 + rng.nextDouble() * (size.width - 40);
      final y = size.height * 0.72 + rng.nextDouble() * (size.height * 0.2);
      _drawSingleEgg(canvas, x, y, eggColors[i % eggColors.length], opacity,
          10.0 + rng.nextDouble() * 8, rng, i);
    }

    // Eggs scattered higher (decorative)
    for (int i = 0; i < 8; i++) {
      final x = 40.0 + rng.nextDouble() * (size.width - 80);
      final y = size.height * 0.1 + rng.nextDouble() * (size.height * 0.45);
      _drawSingleEgg(canvas, x, y, eggColors[(i + 3) % eggColors.length], opacity * 0.7,
          8.0 + rng.nextDouble() * 6, rng, i + 20);
    }
  }

  void _drawSingleEgg(Canvas canvas, double x, double y, Color color,
      double opacity, double eggW, Random rng, int index) {
    final eggH = eggW * 1.35;
    final rotation = (rng.nextDouble() - 0.5) * 0.5;

    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(rotation);

    // Egg shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(2, eggH * 0.1), width: eggW * 1.1, height: eggH * 0.3),
      shadowPaint,
    );

    // Egg body
    final eggPaint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: eggW, height: eggH),
      eggPaint,
    );

    // Egg highlight (shine)
    final shinePaint = Paint()
      ..color = Colors.white.withValues(alpha: opacity * 0.5)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(-eggW * 0.15, -eggH * 0.2),
        width: eggW * 0.25,
        height: eggH * 0.2,
      ),
      shinePaint,
    );

    // Decorations based on index
    final decoOpacity = opacity * 0.8;
    final decoPaint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    switch (index % 5) {
      case 0: // Horizontal stripes
        decoPaint.color = Colors.white.withValues(alpha: decoOpacity);
        canvas.drawLine(Offset(-eggW * 0.38, -eggH * 0.15), Offset(eggW * 0.38, -eggH * 0.15), decoPaint);
        canvas.drawLine(Offset(-eggW * 0.35, eggH * 0.1), Offset(eggW * 0.35, eggH * 0.1), decoPaint);
        break;
      case 1: // Dots
        final dotPaint = Paint()
          ..color = Colors.white.withValues(alpha: decoOpacity)
          ..style = PaintingStyle.fill;
        for (int d = 0; d < 4; d++) {
          final angle = d * pi / 2;
          canvas.drawCircle(
            Offset(cos(angle) * eggW * 0.2, sin(angle) * eggH * 0.15),
            1.8,
            dotPaint,
          );
        }
        break;
      case 2: // Zigzag
        decoPaint.color = Colors.white.withValues(alpha: decoOpacity);
        final zigPath = Path();
        zigPath.moveTo(-eggW * 0.35, 0);
        for (double zx = -eggW * 0.35; zx < eggW * 0.35; zx += eggW * 0.14) {
          zigPath.lineTo(zx + eggW * 0.07, -eggH * 0.08);
          zigPath.lineTo(zx + eggW * 0.14, 0);
        }
        canvas.drawPath(zigPath, decoPaint);
        break;
      case 3: // Cross pattern
        decoPaint.color = Colors.white.withValues(alpha: decoOpacity);
        canvas.drawLine(Offset(-eggW * 0.2, -eggH * 0.2), Offset(eggW * 0.2, eggH * 0.2), decoPaint);
        canvas.drawLine(Offset(eggW * 0.2, -eggH * 0.2), Offset(-eggW * 0.2, eggH * 0.2), decoPaint);
        break;
      case 4: // Hearts / small circles ring
        final ringPaint = Paint()
          ..color = Colors.white.withValues(alpha: decoOpacity)
          ..style = PaintingStyle.fill;
        for (int r = 0; r < 6; r++) {
          final angle = r * pi / 3;
          canvas.drawCircle(
            Offset(cos(angle) * eggW * 0.22, sin(angle) * eggH * 0.18),
            1.3,
            ringPaint,
          );
        }
        break;
    }

    // Egg outline
    final outlinePaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.7)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: eggW, height: eggH),
      outlinePaint,
    );

    canvas.restore();
  }

  void _drawFlowers(Canvas canvas, Size size, bool isDark, Random rng) {
    final flowerColors = [
      Colors.pink.shade300,
      Colors.yellow.shade400,
      Colors.purple.shade300,
      Colors.orange.shade300,
      Colors.red.shade300,
      Colors.white,
    ];

    final opacity = isDark ? 0.3 : 0.45;

    for (int i = 0; i < 18; i++) {
      final x = 15.0 + rng.nextDouble() * (size.width - 30);
      final y = size.height * 0.45 + rng.nextDouble() * (size.height * 0.4);
      final color = flowerColors[i % flowerColors.length];
      final petalSize = 4.0 + rng.nextDouble() * 5;
      final stemHeight = 18.0 + rng.nextDouble() * 20;

      // Stem
      final stemPaint = Paint()
        ..color = Colors.green.shade600.withValues(alpha: opacity * 0.8)
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final stemPath = Path();
      stemPath.moveTo(x, y);
      stemPath.quadraticBezierTo(x + (rng.nextDouble() - 0.5) * 8, y + stemHeight * 0.6, x, y + stemHeight);
      canvas.drawPath(stemPath, stemPaint);

      // Leaf
      if (i % 2 == 0) {
        final leafPaint = Paint()
          ..color = Colors.green.shade500.withValues(alpha: opacity * 0.7)
          ..style = PaintingStyle.fill;
        final leafPath = Path();
        final leafY = y + stemHeight * 0.4;
        leafPath.moveTo(x, leafY);
        leafPath.quadraticBezierTo(x + 8, leafY - 4, x + 12, leafY);
        leafPath.quadraticBezierTo(x + 8, leafY + 3, x, leafY);
        canvas.drawPath(leafPath, leafPaint);
      }

      // Petals
      final petalPaint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      final petalCount = 5 + (i % 3);
      for (int p = 0; p < petalCount; p++) {
        final angle = (p * 2 * pi / petalCount) + rng.nextDouble() * 0.2;
        final px = x + cos(angle) * petalSize;
        final py = y + sin(angle) * petalSize;
        canvas.drawOval(
          Rect.fromCenter(center: Offset(px, py), width: petalSize * 0.8, height: petalSize * 1.1),
          petalPaint,
        );
      }

      // Center
      final centerPaint = Paint()
        ..color = Colors.amber.shade600.withValues(alpha: opacity * 1.2)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), petalSize * 0.4, centerPaint);
    }
  }

  void _drawBunnies(Canvas canvas, Size size, bool isDark, Random rng) {
    final opacity = isDark ? 0.25 : 0.35;

    for (int i = 0; i < 5; i++) {
      final x = 50.0 + rng.nextDouble() * (size.width - 100);
      final y = size.height * 0.6 + rng.nextDouble() * (size.height * 0.25);
      final scale = 0.8 + rng.nextDouble() * 0.5;
      final flip = rng.nextBool() ? 1.0 : -1.0;

      canvas.save();
      canvas.translate(x, y);
      canvas.scale(flip * scale, scale);

      final bunnyColor = isDark ? Colors.grey.shade300 : Colors.grey.shade500;
      final bunnyPaint = Paint()
        ..color = bunnyColor.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      // Body
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(0, 0), width: 28, height: 22),
        bunnyPaint,
      );

      // Belly (lighter)
      final bellyPaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.6)
        ..style = PaintingStyle.fill;
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(2, 2), width: 16, height: 14),
        bellyPaint,
      );

      // Head
      canvas.drawCircle(const Offset(16, -8), 11, bunnyPaint);

      // Ear 1 (left)
      final earPath = Path();
      earPath.moveTo(11, -16);
      earPath.quadraticBezierTo(8, -42, 14, -40);
      earPath.quadraticBezierTo(18, -38, 15, -16);
      canvas.drawPath(earPath, bunnyPaint);

      // Ear inner
      final earInner = Paint()
        ..color = Colors.pink.shade200.withValues(alpha: opacity * 0.8)
        ..style = PaintingStyle.fill;
      final earInnerPath = Path();
      earInnerPath.moveTo(12, -18);
      earInnerPath.quadraticBezierTo(10, -36, 14, -35);
      earInnerPath.quadraticBezierTo(16, -34, 14, -18);
      canvas.drawPath(earInnerPath, earInner);

      // Ear 2 (right)
      final ear2Path = Path();
      ear2Path.moveTo(17, -16);
      ear2Path.quadraticBezierTo(18, -40, 24, -38);
      ear2Path.quadraticBezierTo(28, -36, 21, -16);
      canvas.drawPath(ear2Path, bunnyPaint);

      // Ear 2 inner
      final ear2InnerPath = Path();
      ear2InnerPath.moveTo(18, -18);
      ear2InnerPath.quadraticBezierTo(19, -35, 23, -34);
      ear2InnerPath.quadraticBezierTo(26, -33, 20, -18);
      canvas.drawPath(ear2InnerPath, earInner);

      // Tail (fluffy)
      final tailPaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.9)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(const Offset(-15, -2), 6, tailPaint);

      // Eye
      final eyePaint = Paint()
        ..color = Colors.black.withValues(alpha: opacity * 1.5)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(const Offset(20, -10), 2.5, eyePaint);

      // Eye shine
      final eyeShinePaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity * 1.2)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(const Offset(19.5, -11), 1.0, eyeShinePaint);

      // Nose
      final nosePaint = Paint()
        ..color = Colors.pink.shade300.withValues(alpha: opacity * 1.2)
        ..style = PaintingStyle.fill;
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(25, -7), width: 3.5, height: 2.5),
        nosePaint,
      );

      // Whiskers
      final whiskerPaint = Paint()
        ..color = Colors.grey.shade600.withValues(alpha: opacity * 0.8)
        ..strokeWidth = 0.8
        ..style = PaintingStyle.stroke;
      canvas.drawLine(const Offset(25, -6), const Offset(36, -9), whiskerPaint);
      canvas.drawLine(const Offset(25, -5), const Offset(35, -4), whiskerPaint);
      canvas.drawLine(const Offset(25, -7), const Offset(35, -12), whiskerPaint);

      // Front paw
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(10, 10), width: 8, height: 5),
        bunnyPaint,
      );

      canvas.restore();
    }
  }

  void _drawButterflies(Canvas canvas, Size size, bool isDark, Random rng) {
    final butterflyColors = [
      Colors.blue.shade300,
      Colors.pink.shade300,
      Colors.amber.shade300,
      Colors.purple.shade300,
      Colors.orange.shade300,
    ];

    final opacity = isDark ? 0.25 : 0.4;

    for (int i = 0; i < 7; i++) {
      final x = 30.0 + rng.nextDouble() * (size.width - 60);
      final y = 20.0 + rng.nextDouble() * (size.height * 0.55);
      final color = butterflyColors[i % butterflyColors.length];
      final wingSize = 6.0 + rng.nextDouble() * 5;
      final rotation = (rng.nextDouble() - 0.5) * 0.6;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);

      final wingPaint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      // Upper wings
      canvas.drawOval(
        Rect.fromCenter(center: Offset(-wingSize * 0.8, -wingSize * 0.4),
            width: wingSize * 1.5, height: wingSize),
        wingPaint,
      );
      canvas.drawOval(
        Rect.fromCenter(center: Offset(wingSize * 0.8, -wingSize * 0.4),
            width: wingSize * 1.5, height: wingSize),
        wingPaint,
      );

      // Lower wings (smaller)
      canvas.drawOval(
        Rect.fromCenter(center: Offset(-wingSize * 0.6, wingSize * 0.3),
            width: wingSize * 1.1, height: wingSize * 0.7),
        wingPaint,
      );
      canvas.drawOval(
        Rect.fromCenter(center: Offset(wingSize * 0.6, wingSize * 0.3),
            width: wingSize * 1.1, height: wingSize * 0.7),
        wingPaint,
      );

      // Wing spots
      final spotPaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.6)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(-wingSize * 0.7, -wingSize * 0.3), wingSize * 0.2, spotPaint);
      canvas.drawCircle(Offset(wingSize * 0.7, -wingSize * 0.3), wingSize * 0.2, spotPaint);

      // Body
      final bodyPaint = Paint()
        ..color = Colors.brown.shade600.withValues(alpha: opacity * 1.2)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(0, -wingSize * 0.6), Offset(0, wingSize * 0.5), bodyPaint);

      // Antennae
      final antPaint = Paint()
        ..color = Colors.brown.shade600.withValues(alpha: opacity)
        ..strokeWidth = 0.8
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset(0, -wingSize * 0.6), Offset(-wingSize * 0.4, -wingSize), antPaint);
      canvas.drawLine(Offset(0, -wingSize * 0.6), Offset(wingSize * 0.4, -wingSize), antPaint);

      // Antenna dots
      final dotPaint = Paint()
        ..color = Colors.brown.shade600.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(-wingSize * 0.4, -wingSize), 1.2, dotPaint);
      canvas.drawCircle(Offset(wingSize * 0.4, -wingSize), 1.2, dotPaint);

      canvas.restore();
    }
  }

  void _drawChicks(Canvas canvas, Size size, bool isDark, Random rng) {
    final opacity = isDark ? 0.25 : 0.4;

    for (int i = 0; i < 3; i++) {
      final x = 80.0 + rng.nextDouble() * (size.width - 160);
      final y = size.height * 0.7 + rng.nextDouble() * (size.height * 0.15);
      final scale = 0.7 + rng.nextDouble() * 0.4;
      final flip = rng.nextBool() ? 1.0 : -1.0;

      canvas.save();
      canvas.translate(x, y);
      canvas.scale(flip * scale, scale);

      // Body
      final bodyPaint = Paint()
        ..color = Colors.yellow.shade400.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(const Offset(0, 0), 10, bodyPaint);

      // Head
      canvas.drawCircle(const Offset(9, -10), 7.5, bodyPaint);

      // Wing
      final wingPaint = Paint()
        ..color = Colors.yellow.shade600.withValues(alpha: opacity * 0.8)
        ..style = PaintingStyle.fill;
      final wingPath = Path();
      wingPath.moveTo(-4, -2);
      wingPath.quadraticBezierTo(-14, 0, -12, 6);
      wingPath.quadraticBezierTo(-8, 8, -2, 4);
      canvas.drawPath(wingPath, wingPaint);

      // Eye
      final eyePaint = Paint()
        ..color = Colors.black.withValues(alpha: opacity * 1.5)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(const Offset(12, -12), 1.8, eyePaint);

      // Beak
      final beakPaint = Paint()
        ..color = Colors.orange.shade600.withValues(alpha: opacity * 1.2)
        ..style = PaintingStyle.fill;
      final beakPath = Path();
      beakPath.moveTo(15, -9);
      beakPath.lineTo(20, -8);
      beakPath.lineTo(15, -7);
      beakPath.close();
      canvas.drawPath(beakPath, beakPaint);

      // Feet
      final feetPaint = Paint()
        ..color = Colors.orange.shade500.withValues(alpha: opacity)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      canvas.drawLine(const Offset(-2, 9), const Offset(-4, 15), feetPaint);
      canvas.drawLine(const Offset(-4, 15), const Offset(-8, 15), feetPaint);
      canvas.drawLine(const Offset(3, 9), const Offset(5, 15), feetPaint);
      canvas.drawLine(const Offset(5, 15), const Offset(1, 15), feetPaint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _EasterBackgroundPainter oldDelegate) {
    return oldDelegate.brightness != brightness;
  }
}
