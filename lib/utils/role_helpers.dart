import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Returns the display text for a user role
String getRoleText(String role, [BuildContext? context]) {
  if (context != null) {
    return AppLocalizations.of(context)!.roleMitglied;
  }
  return 'Mitglied';
}

/// Returns the color associated with a user role
Color getRoleColor(String role) {
  // All users get blue color
  return Colors.blue;
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

/// Returns the color associated with a user status
Color getStatusColor(String status) {
  switch (status) {
    case 'active':
      return Colors.green;
    case 'neu':
      return Colors.amber;
    case 'suspended':
      return Colors.orange;
    case 'deleted':
      return Colors.red;
    default:
      return Colors.grey;
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
