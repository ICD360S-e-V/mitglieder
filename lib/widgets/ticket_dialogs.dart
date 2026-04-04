import 'package:flutter/material.dart';
import 'new_ticket_dialog.dart';
import 'member_ticket_details_dialog.dart';
import '../services/ticket_service.dart';

/// Shows the new ticket creation dialog
/// Returns true if ticket was created successfully
Future<bool> showNewTicketDialog(
    BuildContext context, String mitgliedernummer) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => NewTicketDialog(mitgliedernummer: mitgliedernummer),
  );
  return result ?? false;
}

/// Shows the ticket details dialog (fullscreen for mobile)
/// Returns true if changes were made
Future<bool> showTicketDetailsDialog(
  BuildContext context,
  Ticket ticket,
  String mitgliedernummer,
) async {
  final result = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (context) => MemberTicketDetailsDialog(
        ticket: ticket,
        mitgliedernummer: mitgliedernummer,
      ),
      fullscreenDialog: true, // ← Fullscreen pe mobile
    ),
  );
  return result ?? false;
}
