import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'eastern.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';

/// AppBar widget for member dashboard with badges and actions
class MitgliedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String mitgliedernummer;
  final String status;
  final int unreadChatCount;
  final int unreadTicketCount;
  final int pendingTerminCount;
  final VoidCallback onHome;
  final VoidCallback onTermine;
  final VoidCallback onTickets;
  final VoidCallback onLiveChat;

  /// Öffnet die Sonderfunktionen — Werkzeuge, die nur Mitglieder haben.
  final VoidCallback onExtras;
  final VoidCallback onProfile;

  const MitgliedAppBar({
    super.key,
    required this.mitgliedernummer,
    required this.status,
    required this.unreadChatCount,
    required this.unreadTicketCount,
    this.pendingTerminCount = 0,
    required this.onHome,
    required this.onTermine,
    required this.onTickets,
    required this.onLiveChat,
    required this.onExtras,
    required this.onProfile,
  });

  /// Basishöhe für ein Telefon der Referenzklasse; skaliert wie alles andere.
  static const double _baseToolbarHeight = 70;

  /// `preferredSize` fragt Flutter vor dem Build ab, ohne BuildContext — daher
  /// der View-basierte Faktor. [build] nimmt denselben Wert, damit
  /// `toolbarHeight` und die gemeldete Höhe nicht auseinanderlaufen.
  static double get _toolbarHeight =>
      _baseToolbarHeight * Responsive.uiScaleOfView();

  @override
  Size get preferredSize => Size.fromHeight(_toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Sechs Schaltflächen plus Plaketten nebeneinander — auf einem schmalen
    // Gerät ist das die Zeile, die als Erste bricht.
    final iconSize = Responsive.scaled(context, 30);
    final spacing = Responsive.space(context, 8);

    return AppBar(
      toolbarHeight: _toolbarHeight,
      backgroundColor: context.colors.brandFill,
      foregroundColor: Colors.white,
      flexibleSpace: SeasonalBackground.isEasterSeason
          ? IgnorePointer(
              child: CustomPaint(
                painter: EasterAppBarPainter(),
                size: Size.infinite,
              ),
            )
          : null,
      iconTheme: IconThemeData(size: iconSize, color: Colors.white),
      centerTitle: true,
      leadingWidth: 0,
      titleSpacing: 0,
      // Die Schaltflächen sitzen im Titel-Slot statt in `actions`, in einer
      // FittedBox.
      //
      // Grund: jeder IconButton hält die von Material geforderten 48 dp
      // Trefferfläche ein. Sechs davon sind 288 dp — auf einem 320 dp breiten
      // Telefon lief die Zeile über, ganz gleich wie klein die Icons gezeichnet
      // wurden. `scaleDown` schrumpft die ganze Zeile gleichmäßig, aber nur
      // wenn sie sonst nicht passt; auf breiteren Geräten ändert sich nichts.
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
        // Home (Overview)
        IconButton(
          icon: Icon(Icons.home_outlined, size: iconSize, color: Colors.white),
          onPressed: onHome,
          tooltip: l10n.overview,
        ),
        SizedBox(width: spacing),
        // Termine (Calendar) with pending badge
        _CalendarIconWithBadge(
          pendingCount: pendingTerminCount,
          onPressed: onTermine,
          tooltip: l10n.appointments,
          iconSize: iconSize,
        ),
        SizedBox(width: spacing),
        // Report problem with unread badge
        _TicketIconWithBadge(
          unreadCount: unreadTicketCount,
          onPressed: onTickets,
          tooltip: l10n.reportProblemTooltip,
          iconSize: iconSize,
        ),
        SizedBox(width: spacing),
        // Live Chat with unread badge
        _ChatIconWithBadge(
          unreadCount: unreadChatCount,
          onPressed: onLiveChat,
          tooltip: l10n.liveChat,
          iconSize: iconSize,
        ),
        SizedBox(width: spacing),
        // Sonderfunktionen
        IconButton(
          icon: Icon(Icons.auto_awesome_outlined, size: iconSize, color: Colors.white),
          onPressed: onExtras,
          tooltip: l10n.extrasTitel,
        ),
        SizedBox(width: spacing),
        // Profile
        IconButton(
          icon: Icon(Icons.person_outlined, size: iconSize, color: Colors.white),
          onPressed: onProfile,
          tooltip: l10n.myProfile,
        ),
          ],
        ),
      ),
    );
  }
}

class _ChatIconWithBadge extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onPressed;
  final String tooltip;
  final double iconSize;

  const _ChatIconWithBadge({
    required this.unreadCount,
    required this.onPressed,
    required this.tooltip,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.forum_outlined, size: iconSize, color: Colors.white),
          onPressed: onPressed,
          tooltip: tooltip,
        ),
        // Unread count badge (shows when > 0)
        if (unreadCount > 0)
          Positioned(
            right: iconSize < 26 ? 2 : 4,
            top: iconSize < 26 ? 2 : 4,
            child: Container(
              padding: EdgeInsets.all(iconSize < 26 ? 2 : 4),
              decoration: BoxDecoration(
                color: context.colors.dangerSolid,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: iconSize < 26 ? 16 : 20,
                minHeight: iconSize < 26 ? 16 : 20,
              ),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: iconSize < 26 ? 9 : 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          // Online indicator (only when no unread messages)
          Positioned(
            right: iconSize < 26 ? 6 : 8,
            bottom: iconSize < 26 ? 6 : 8,
            child: Container(
              width: iconSize < 26 ? 10 : 12,
              height: iconSize < 26 ? 10 : 12,
              decoration: BoxDecoration(
                color: context.colors.successFg,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: iconSize < 26 ? 1.5 : 2),
              ),
            ),
          ),
      ],
    );
  }
}

class _TicketIconWithBadge extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onPressed;
  final String tooltip;
  final double iconSize;

  const _TicketIconWithBadge({
    required this.unreadCount,
    required this.onPressed,
    required this.tooltip,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.local_activity_outlined, size: iconSize, color: Colors.white),
          onPressed: onPressed,
          tooltip: tooltip,
        ),
        // Unread count badge (shows when > 0)
        if (unreadCount > 0)
          Positioned(
            right: iconSize < 26 ? 2 : 4,
            top: iconSize < 26 ? 2 : 4,
            child: Container(
              padding: EdgeInsets.all(iconSize < 26 ? 2 : 4),
              decoration: BoxDecoration(
                color: context.colors.dangerSolid,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: iconSize < 26 ? 16 : 20,
                minHeight: iconSize < 26 ? 16 : 20,
              ),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: iconSize < 26 ? 9 : 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class _CalendarIconWithBadge extends StatelessWidget {
  final int pendingCount;
  final VoidCallback onPressed;
  final String tooltip;
  final double iconSize;

  const _CalendarIconWithBadge({
    required this.pendingCount,
    required this.onPressed,
    required this.tooltip,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.calendar_month_outlined, size: iconSize, color: Colors.white),
          onPressed: onPressed,
          tooltip: tooltip,
        ),
        if (pendingCount > 0)
          Positioned(
            right: iconSize < 26 ? 2 : 4,
            top: iconSize < 26 ? 2 : 4,
            child: Container(
              padding: EdgeInsets.all(iconSize < 26 ? 2 : 4),
              decoration: BoxDecoration(
                color: context.colors.dangerSolid,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: iconSize < 26 ? 16 : 20,
                minHeight: iconSize < 26 ? 16 : 20,
              ),
              child: Text(
                pendingCount > 9 ? '9+' : '$pendingCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: iconSize < 26 ? 9 : 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
