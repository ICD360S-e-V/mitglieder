import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../utils/responsive.dart';

/// Banner shown for accounts with 'neu' status (trial period warning)
class TrialWarningBanner extends StatelessWidget {
  final int daysRemaining;

  /// Exact end of the trial, from `trial_ends_at`. Null for older servers that
  /// only return a day count. Rendered as a plain numeric date, which needs no
  /// translation and no per-locale date initialisation.
  final DateTime? trialEndsAt;

  const TrialWarningBanner({
    super.key,
    required this.daysRemaining,
    this.trialEndsAt,
  });

  @override
  Widget build(BuildContext context) {
    final isUrgent = daysRemaining <= 7;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.space(context, 16),
        vertical: Responsive.space(context, 12),
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
            size: Responsive.space(context, 24),
          ),
          SizedBox(width: Responsive.space(context, 12)),
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
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: Responsive.space(context, 2)),
                Text(
                  l10n.trialWarningDescription,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (trialEndsAt != null) ...[
                  SizedBox(height: Responsive.space(context, 2)),
                  Text(
                    DateFormat('dd.MM.yyyy').format(trialEndsAt!),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: Responsive.space(context, 12)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.space(context, 12),
              vertical: Responsive.space(context, 6),
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
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
