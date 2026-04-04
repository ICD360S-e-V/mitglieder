import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Sidebar widget for member dashboard
class MitgliedSidebar extends StatelessWidget {
  final String userName;
  final int selectedIndex;
  final Function(int) onIndexChanged;

  const MitgliedSidebar({
    super.key,
    required this.userName,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: 250,
      color: const Color(0xFF1a1a2e),
      child: Column(
        children: [
          // User info in sidebar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF4a90d9),
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : 'M',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n.member,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Navigation items
          _SidebarItem(
            icon: Icons.dashboard,
            title: l10n.overview,
            index: 0,
            selectedIndex: selectedIndex,
            onTap: onIndexChanged,
          ),
          _SidebarItem(
            icon: Icons.people,
            title: l10n.memberManagement,
            index: 1,
            selectedIndex: selectedIndex,
            onTap: onIndexChanged,
          ),
          _SidebarItem(
            icon: Icons.event,
            title: l10n.myAppointments,
            index: 2,
            selectedIndex: selectedIndex,
            onTap: onIndexChanged,
          ),
          _SidebarItem(
            icon: Icons.confirmation_number,
            title: l10n.myTickets,
            index: 3,
            selectedIndex: selectedIndex,
            onTap: onIndexChanged,
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4a90d9).withValues(alpha: 0.2) : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected ? const Color(0xFF4a90d9) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF4a90d9) : Colors.grey.shade400,
                size: 22,
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade400,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
