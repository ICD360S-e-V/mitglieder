import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../utils/app_theme.dart';

/// The two ways out of an unfinished registration. Deliberately kept
/// far apart in the UI: one is free and reversible, the other is
/// permanent and counts against the applicant.
enum _ExitChoice {
  /// Keep the server draft, keep the anonymous_id, just leave. The
  /// visitor can walk back in from the welcome screen banner.
  later,

  /// Call withdraw.php — flips the users row to `gekuendigt_selbst`
  /// and writes the abuse_hash.
  abandon,
}

/// Opens the "leave the registration" sheet used by every wizard step
/// (via [WizardStepShell]) and by the intro screen.
///
/// Before this existed the wizard had no exit at all: the Back button
/// walked down to the intro story, which has no back of its own, and
/// WelcomeScreen pushed the wizard again on the next launch. The only
/// escape was the Android system gesture — and on desktop, nothing.
///
/// Lives outside [WizardStepShell] so the intro screen (which has no
/// shell) can reuse it, and so the shell stays presentational.
///
/// Handles its own navigation: on either exit path it pops the wizard
/// route off [context]'s navigator, which lands the visitor back on
/// the welcome screen.
Future<void> showWizardExitSheet(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  // Captured before the first await — the shell's element stays
  // mounted across the sheet, but the analyzer (and a withdraw that
  // outlives a rebuild) both want these resolved up front.
  final navigator = Navigator.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final dangerSolid = context.colors.dangerSolid;

  final choice = await showModalBottomSheet<_ExitChoice>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _ExitSheet(l10n: l10n),
  );
  if (choice == null) return;

  if (choice == _ExitChoice.later) {
    // No server call: the draft and the anonymous_id both stay put.
    // The flag only stops the launch-time auto-push so the welcome
    // screen is actually reachable.
    await WizardService().suppressAutoResume();
    await navigator.maybePop();
    return;
  }

  if (!context.mounted) return;
  final confirmed = await _confirmAbandon(context, l10n);
  if (confirmed != true) return;

  final outcome = await WizardService().withdrawRequest();
  if (outcome == WizardWithdrawOutcome.failed) {
    // Keep the visitor where they are — a half-applied withdrawal is
    // worse than none, and retrying is free.
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.wizardErrSaveFailed),
        backgroundColor: dangerSolid,
        behavior: SnackBarBehavior.floating,
      ),
    );
    return;
  }
  // `ok` and `nothingToWithdraw` both end the same way: this device no
  // longer has a registration in flight, so drop the anonymous_id and
  // let the next visitor start clean.
  await WizardService().resetLocal();
  await navigator.maybePop();
}

/// Hard confirmation for the destructive path. Spells out the
/// consequence the visitor cannot see: finalize.php refuses an
/// applicant with three withdrawals inside 90 days, so this is not a
/// button to press casually.
Future<bool?> _confirmAbandon(
  BuildContext context,
  AppLocalizations l10n,
) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.wizardAbandonDialogTitle),
      content: Text(l10n.wizardAbandonDialogBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(l10n.wizardAbandonKeep),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: ctx.colors.dangerFg,
          ),
          child: Text(l10n.wizardAbandonConfirm),
        ),
      ],
    ),
  );
}

class _ExitSheet extends StatelessWidget {
  final AppLocalizations l10n;
  const _ExitSheet({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        decoration: BoxDecoration(
          color: context.colors.card,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: context.colors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              l10n.wizardExitSheetTitle,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.wizardExitSheetBody,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(height: 18),
            _option(
              context,
              icon: Icons.bookmark_outline,
              title: l10n.wizardExitLater,
              hint: l10n.wizardExitLaterHint,
              fg: context.colors.brandStrong,
              bg: context.colors.brandFill,
              border: context.colors.brand,
              onTap: () => Navigator.of(context).pop(_ExitChoice.later),
            ),
            const SizedBox(height: 10),
            _option(
              context,
              icon: Icons.cancel_outlined,
              title: l10n.wizardExitAbandon,
              hint: l10n.wizardExitAbandonHint,
              fg: context.colors.dangerFg,
              bg: context.colors.dangerBg,
              border: context.colors.dangerBorder,
              onTap: () => Navigator.of(context).pop(_ExitChoice.abandon),
            ),
            const SizedBox(height: 6),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.wizardExitCancel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// One tappable choice. Title + hint sit in a Column so the
  /// consequence ("your answers stay saved" / "this cannot be undone")
  /// is legible at a glance rather than buried in a confirm dialog.
  Widget _option(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String hint,
    required Color fg,
    required Color bg,
    required Color border,
    required VoidCallback onTap,
  }) {
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: fg, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: fg,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      hint,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
