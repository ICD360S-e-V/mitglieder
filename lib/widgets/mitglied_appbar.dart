import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'eastern.dart';

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
  final VoidCallback onNotifications;
  final VoidCallback onProfile;
  final VoidCallback onLogout;

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
    required this.onNotifications,
    required this.onProfile,
    required this.onLogout,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70); // Increased from 56

  // Responsive icon size based on screen width
  double _getResponsiveIconSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) {
      return 22.0; // Small screens (320-359px) - reduce by 27%
    } else if (screenWidth < 400) {
      return 26.0; // Medium screens (360-399px) - reduce by 13%
    } else {
      return 30.0; // Large screens (400px+) - original size
    }
  }

  // Responsive spacing based on screen width
  double _getResponsiveSpacing(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) {
      return 4.0; // Small screens - half spacing
    } else if (screenWidth < 400) {
      return 6.0; // Medium screens - 75% spacing
    } else {
      return 8.0; // Large screens - full spacing
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final iconSize = _getResponsiveIconSize(context);
    final spacing = _getResponsiveSpacing(context);

    return AppBar(
      title: null,
      toolbarHeight: 70,
      backgroundColor: const Color(0xFF4a90d9),
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
      centerTitle: false,
      leadingWidth: 0,
      titleSpacing: 0,
      actions: [
        // Spacer to push icons to center
        const Spacer(),
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
        // Notifications bell
        _NotificationIcon(
          onPressed: onNotifications,
          tooltip: l10n.notifications,
          iconSize: iconSize,
        ),
        SizedBox(width: spacing),
        // Profile
        IconButton(
          icon: Icon(Icons.person_outlined, size: iconSize, color: Colors.white),
          onPressed: onProfile,
          tooltip: l10n.myProfile,
        ),
        SizedBox(width: spacing),
        // Logout
        IconButton(
          icon: Icon(Icons.logout, size: iconSize, color: Colors.white),
          onPressed: onLogout,
          tooltip: l10n.logout,
        ),
        const Spacer(),
      ],
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
              decoration: const BoxDecoration(
                color: Colors.red,
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
                color: Colors.green,
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
              decoration: const BoxDecoration(
                color: Colors.red,
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
              decoration: const BoxDecoration(
                color: Colors.red,
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

class _NotificationIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String tooltip;
  final double iconSize;

  const _NotificationIcon({
    required this.onPressed,
    required this.tooltip,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, size: iconSize, color: Colors.white),
          onPressed: onPressed,
          tooltip: tooltip,
        ),
        // Red badge for unread notifications
        Positioned(
          right: 6,
          top: 6,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 10,
              minHeight: 10,
            ),
          ),
        ),
      ],
    );
  }
}
