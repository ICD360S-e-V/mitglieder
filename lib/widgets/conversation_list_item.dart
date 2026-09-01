import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// A single conversation item in the admin chat list
class ConversationListItem extends StatelessWidget {
  final Map<String, dynamic> conversation;
  final bool isSelected;
  final bool hasActiveCall;
  final VoidCallback onTap;

  const ConversationListItem({
    super.key,
    required this.conversation,
    required this.isSelected,
    required this.hasActiveCall,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unreadCount = conversation['unread_count'] ?? 0;
    final status = conversation['status'] ?? 'open';
    // Das GEGENUEBER, nicht das Mitglied des Gespraechs: hier ist das
    // Mitglied der Anmelder, sonst staende der eigene Name da.
    // Rueckfall fuer aeltere Server, die das Feld nicht kennen.
    final memberName = conversation['gegenueber_name'] ??
        conversation['member_name'] ??
        AppLocalizations.of(context)!.unknownValue;
    final lastMessage = conversation['last_message'] ?? AppLocalizations.of(context)!.noMessages;

    return Container(
      color: isSelected ? const Color(0xFF1a1a2e).withValues(alpha: 0.1) : null,
      child: ListTile(
        dense: true,
        leading: _buildAvatar(context, memberName, status),
        title: _buildTitle(context, memberName, unreadCount),
        subtitle: Text(
          hasActiveCall ? AppLocalizations.of(context)!.inCall : lastMessage,
          style: TextStyle(
            fontSize: 11,
            color: hasActiveCall ? context.colors.successFg : null,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, String memberName, String status) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: hasActiveCall ? context.colors.successBg : context.colors.infoBg,
          child: hasActiveCall
              ? Icon(Icons.call, color: context.colors.successFg, size: 20)
              : Text(
                  (memberName.isEmpty ? '?' : memberName[0].toUpperCase()),
                  style: TextStyle(
                    color: context.colors.infoFg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        if (status == 'open' && !hasActiveCall)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: context.colors.successFg,
                shape: BoxShape.circle,
                // Der Ring soll wie ein Ausschnitt in der Fläche wirken, auf
                // der der Punkt liegt — hier eine Karte, nicht die blaue
                // Kopfleiste. Fest weiß säße er im dunklen Modus als heller
                // Ring auf einer dunklen Karte.
                border: Border.all(color: context.colors.card, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String memberName, int unreadCount) {
    return Row(
      children: [
        Expanded(
          child: Text(
            memberName,
            style: TextStyle(
              fontWeight: isSelected || unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (unreadCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: context.colors.dangerSolid,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$unreadCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
