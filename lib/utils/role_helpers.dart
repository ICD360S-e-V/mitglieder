import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'app_theme.dart';

/// Returns the display text for a user role
String getRoleText(String role, [BuildContext? context]) {
  if (context != null) {
    return AppLocalizations.of(context)!.roleMitglied;
  }
  return 'Mitglied';
}

/// Returns the color associated with a user role.
///
/// See [getStatusColor] for why this needs the context.
Color getRoleColor(BuildContext context, String role) {
  // All users get blue color
  return context.colors.infoFg;
}

/// Returns the display text for a user status
String getStatusText(String status, [BuildContext? context]) {
  final l10n = context != null ? AppLocalizations.of(context)! : null;
  switch (status) {
    case 'active':
      return l10n?.statusActive ?? 'Aktiv';
    case 'neu':
      return l10n?.statusNew ?? 'Neu';
    case 'suspended':
      return l10n?.statusSuspended ?? 'Gesperrt';
    case 'deleted':
      return l10n?.statusDeleted ?? 'Gelöscht';
    default:
      return status;
  }
}

/// Returns the color associated with a user status.
///
/// Takes the context because the status palette is theme-dependent: the light
/// theme's dark green would sit almost invisibly on a dark card.
Color getStatusColor(BuildContext context, String status) {
  switch (status) {
    case 'active':
      return context.colors.successFg;
    case 'neu':
      return context.colors.warningFg;
    case 'suspended':
      return context.colors.warningFg;
    case 'deleted':
      return context.colors.dangerFg;
    default:
      return context.colors.textSecondary;
  }
}

/// Returns the role prefix for Mitgliedernummer
String getRolePrefix(String role) {
  // All users are Mitglied with prefix M
  return 'M';
}

/// Checks if a role is an admin role
bool isAdminRole(String role) {
  // No admin roles exist anymore
  return false;
}
