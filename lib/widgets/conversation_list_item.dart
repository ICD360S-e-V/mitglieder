import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

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
    final memberName = conversation['member_name'] ?? AppLocalizations.of(context)!.unknownValue;
    final lastMessage = conversation['last_message'] ?? AppLocalizations.of(context)!.noMessages;

    return Container(
      color: isSelected ? const Color(0xFF1a1a2e).withValues(alpha: 0.1) : null,
      child: ListTile(
        dense: true,
        leading: _buildAvatar(memberName, status),
        title: _buildTitle(memberName, unreadCount),
        subtitle: Text(
          hasActiveCall ? AppLocalizations.of(context)!.inCall : lastMessage,
          style: TextStyle(
            fontSize: 11,
            color: hasActiveCall ? Colors.green.shade700 : null,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildAvatar(String memberName, String status) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: hasActiveCall ? Colors.green.shade100 : Colors.blue.shade100,
          child: hasActiveCall
              ? Icon(Icons.call, color: Colors.green.shade700, size: 20)
              : Text(
                  memberName[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.blue.shade700,
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
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle(String memberName, int unreadCount) {
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
              color: Colors.red,
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
