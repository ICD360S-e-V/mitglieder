import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../screens/anonymous_chat.dart';

/// Persistent live-chat affordance shared across every wizard surface
/// (per-step shell + final/waiting screen + duplicate + age gate).
///
/// Pinned at end-float so it sits above the bottom Next/Back row on
/// step screens and above the body on terminal screens. Tapping pushes
/// [AnonymousChatScreen], the same anonymous chat the welcome screen's
/// "Am o problemă → Vorbim acum" path uses, so visitor and Vorstand
/// share one inbox throughout registration AND while the visitor
/// waits for validation post-finalize.
class WizardChatFab extends StatelessWidget {
  const WizardChatFab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FloatingActionButton.extended(
      heroTag: 'wizard_chat_fab',
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF0d47a1),
      elevation: 4,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AnonymousChatScreen()),
      ),
      icon: const Icon(Icons.chat_bubble_outline, size: 20),
      label: Text(
        l10n.wizardChatHelp,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
