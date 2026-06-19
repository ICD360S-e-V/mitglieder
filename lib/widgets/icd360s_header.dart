import 'package:flutter/material.dart';

/// Association name + tri-coloured slogan, used on every screen as a
/// constant brand anchor. Two visual sizes:
///
///   • [Icd360sHeader] (default `compact: false`) — large hero version
///     shown on the welcome screen.
///   • [Icd360sHeader] with `compact: true` — smaller version for
///     intermediate screens (login, register, password reset, …) where
///     the form should be the dominant element.
///
/// Slogan word colours stay the same in both sizes:
///   INTEGRATION = light blue, CHANCEN = orange, DIVERSITY = green,
///   360° SUPPORT = light blue.
class Icd360sHeader extends StatelessWidget {
  final bool compact;
  const Icd360sHeader({super.key, this.compact = false});

  static const _integration = Color(0xFF4FC3F7);
  static const _chancen = Color(0xFFFFB74D);
  static const _diversity = Color(0xFF81C784);

  @override
  Widget build(BuildContext context) {
    final nameSize = compact ? 22.0 : 38.0;
    final letterSpacing = compact ? 1.5 : 2.0;
    final sloganSize = compact ? 9.5 : 11.0;
    final sloganBottomSize = compact ? 10.5 : 12.0;
    final spacingAfterName = compact ? 6.0 : 16.0;
    final spacingBetweenSloganLines = compact ? 2.0 : 4.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'ICD360S e.V',
          style: TextStyle(
            fontSize: nameSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: letterSpacing,
          ),
        ),
        SizedBox(height: spacingAfterName),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 4,
          children: [
            Text(
              'INTEGRATION',
              style: TextStyle(
                fontSize: sloganSize,
                fontWeight: FontWeight.w600,
                color: _integration,
                letterSpacing: 1,
              ),
            ),
            Text('•',
                style: TextStyle(
                  fontSize: sloganSize,
                  color: Colors.white.withValues(alpha: 0.5),
                )),
            Text(
              'CHANCEN',
              style: TextStyle(
                fontSize: sloganSize,
                fontWeight: FontWeight.w600,
                color: _chancen,
                letterSpacing: 1,
              ),
            ),
            Text('•',
                style: TextStyle(
                  fontSize: sloganSize,
                  color: Colors.white.withValues(alpha: 0.5),
                )),
            Text(
              'DIVERSITY',
              style: TextStyle(
                fontSize: sloganSize,
                fontWeight: FontWeight.w600,
                color: _diversity,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: spacingBetweenSloganLines),
        Text(
          '360° SUPPORT',
          style: TextStyle(
            fontSize: sloganBottomSize,
            fontWeight: FontWeight.w600,
            color: _integration,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
