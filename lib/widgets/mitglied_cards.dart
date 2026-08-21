import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// Card for personal data section in member dashboard - Mobile optimized
class PersonalDataCard extends StatelessWidget {
  final VoidCallback onUpdate;

  const PersonalDataCard({
    super.key,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: context.colors.brand.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: context.colors.brand,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.personalData,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.personalDataSubtitle,
                        style: TextStyle(
                          color: context.colors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onUpdate,
                icon: const Icon(Icons.edit, size: 18),
                label: Text(AppLocalizations.of(context)!.refresh),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.brandFill,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card for membership fee (Mitgliedsbeitrag) section
class BeitragCard extends StatelessWidget {
  final bool isLoading;
  final bool beitragBezahlt;
  final int beitragJahr;

  const BeitragCard({
    super.key,
    required this.isLoading,
    required this.beitragBezahlt,
    required this.beitragJahr,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: beitragBezahlt
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.euro,
                    color: beitragBezahlt ? context.colors.successFg : context.colors.warningFg,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.membershipFee,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.annualFeeYear(beitragJahr.toString()),
                        style: TextStyle(
                          color: context.colors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Badge - loaded from API
                if (isLoading)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  _BeitragStatusBadge(beitragBezahlt: beitragBezahlt),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.amount,
                  style: TextStyle(color: context.colors.textSecondary),
                ),
                const Text(
                  '50,00 €',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.dueBy,
                  style: TextStyle(color: context.colors.textSecondary),
                ),
                Text(
                  '31.03.$beitragJahr',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BeitragStatusBadge extends StatelessWidget {
  final bool beitragBezahlt;

  const _BeitragStatusBadge({required this.beitragBezahlt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: beitragBezahlt
            ? context.colors.successBg
            : context.colors.warningBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: beitragBezahlt
              ? context.colors.successBorder
              : context.colors.warningBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            beitragBezahlt ? Icons.check_circle : Icons.schedule,
            size: 18,
            color: beitragBezahlt
                ? context.colors.successFg
                : context.colors.warningFg,
          ),
          const SizedBox(width: 6),
          Text(
            beitragBezahlt ? AppLocalizations.of(context)!.paid : AppLocalizations.of(context)!.statusPending,
            style: TextStyle(
              color: beitragBezahlt
                  ? context.colors.successFg
                  : context.colors.warningFg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Welcome card for overview section - Mobile optimized
class WelcomeCard extends StatelessWidget {
  final String userName;
  final String greeting;

  const WelcomeCard({
    super.key,
    required this.userName,
    required this.greeting,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: context.colors.brandFill,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'M',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$greeting,',
              style: TextStyle(
                fontSize: 16,
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder card for "Meine Termine" section
class MeineTerminePlaceholder extends StatelessWidget {
  final VoidCallback onRefresh;

  const MeineTerminePlaceholder({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 64, color: context.colors.textDisabled),
          const SizedBox(height: 16),
          Text(
            l10n.myAppointmentsTitle,
            style: TextStyle(
              fontSize: 20,
              color: context.colors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.appointmentsDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.colors.textTertiary),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.loadAppointments),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.brandFill,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
