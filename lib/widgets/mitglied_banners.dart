import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Banner shown for accounts with 'neu' status (trial period warning)
class TrialWarningBanner extends StatelessWidget {
  final int daysRemaining;

  const TrialWarningBanner({
    super.key,
    required this.daysRemaining,
  });

  // Responsive helpers
  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.85;
    if (width < 400) return baseSize * 0.95;
    return baseSize;
  }

  double _getResponsiveSpacing(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.6;
    if (width < 400) return baseSize * 0.8;
    return baseSize;
  }

  @override
  Widget build(BuildContext context) {
    final isUrgent = daysRemaining <= 7;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _getResponsiveSpacing(context, 16),
        vertical: _getResponsiveSpacing(context, 12),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isUrgent
              ? [Colors.red.shade700, Colors.orange.shade700]
              : [Colors.orange.shade600, Colors.amber.shade600],
        ),
      ),
      child: Row(
        children: [
          Icon(
            isUrgent ? Icons.warning : Icons.info_outline,
            color: Colors.white,
            size: _getResponsiveSpacing(context, 24),
          ),
          SizedBox(width: _getResponsiveSpacing(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUrgent
                      ? l10n.trialWarningUrgentTitle(daysRemaining)
                      : l10n.trialWarningTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: _getResponsiveFontSize(context, 14),
                  ),
                ),
                SizedBox(height: _getResponsiveSpacing(context, 2)),
                Text(
                  l10n.trialWarningDescription,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: _getResponsiveFontSize(context, 12),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: _getResponsiveSpacing(context, 12)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: _getResponsiveSpacing(context, 12),
              vertical: _getResponsiveSpacing(context, 6),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              l10n.trialDaysRemaining(daysRemaining),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _getResponsiveFontSize(context, 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
