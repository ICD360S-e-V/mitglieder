import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/ticket_service.dart';

/// Mobile-optimized New Ticket Dialog
class NewTicketDialog extends StatefulWidget {
  final String mitgliedernummer;

  const NewTicketDialog({
    super.key,
    required this.mitgliedernummer,
  });

  @override
  State<NewTicketDialog> createState() => _NewTicketDialogState();
}

class _NewTicketDialogState extends State<NewTicketDialog> {
  final _ticketService = TicketService();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  List<TicketCategory> _categories = [];
  int? _selectedCategoryId;
  String _priority = 'medium';
  bool _isLoadingCategories = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoadingCategories = true);
    final categories = await _ticketService.getCategories(
      mitgliedernummer: widget.mitgliedernummer,
    );
    if (mounted) {
      setState(() {
        _categories = categories;
        _isLoadingCategories = false;
      });
    }
  }

  Future<void> _submitTicket() async {
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    if (subject.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.fillAllFields),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final ticket = await _ticketService.createTicket(
      mitgliedernummer: widget.mitgliedernummer,
      subject: subject,
      message: message,
      priority: _priority,
      categoryId: _selectedCategoryId,
    );

    if (mounted) {
      setState(() => _isSubmitting = false);

      if (ticket != null) {
        Navigator.pop(context, true); // Return true to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.ticketCreatedId(ticket.id)),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorCreatingTicket),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16), // ← Pentru mobile, padding mai mic
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // ← 90% din lățimea ecranului
        constraints: const BoxConstraints(maxWidth: 500), // ← Max 500px pe tablete
        child: SingleChildScrollView(
          // ← IMPORTANT pentru keyboard
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Icon(Icons.add_circle, color: Color(0xFF4a90d9)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.newTicketTitle,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Category dropdown
                if (_isLoadingCategories)
                  const Center(child: CircularProgressIndicator())
                else if (_categories.isNotEmpty)
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.categoryOptional,
                      prefixIcon: const Icon(Icons.category),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _selectedCategoryId,
                        isExpanded: true,
                        isDense: true,
                        items: _categories.map((cat) {
                          return DropdownMenuItem<int>(
                            value: cat.id,
                            child: Row(
                              children: [
                                Icon(
                                  _getIconData(cat.icon),
                                  color: _parseColor(cat.color),
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    cat.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedCategoryId = value);
                        },
                        hint: Text(AppLocalizations.of(context)!.selectCategory),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Subject field
                TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.subjectLabel,
                    prefixIcon: const Icon(Icons.subject),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 16),

                // Message field
                TextField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.messageLabel,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 16),

                // Priority chips (ADAPTAT - Wrap pentru responsive)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Text(AppLocalizations.of(context)!.priorityLabel),
                    ChoiceChip(
                      label: Text(AppLocalizations.of(context)!.ticketPriorityLow),
                      selected: _priority == 'low',
                      onSelected: (_) => setState(() => _priority = 'low'),
                      selectedColor: Colors.green.shade100,
                    ),
                    ChoiceChip(
                      label: Text(AppLocalizations.of(context)!.ticketPriorityMedium),
                      selected: _priority == 'medium',
                      onSelected: (_) => setState(() => _priority = 'medium'),
                      selectedColor: Colors.orange.shade100,
                    ),
                    ChoiceChip(
                      label: Text(AppLocalizations.of(context)!.ticketPriorityHigh),
                      selected: _priority == 'high',
                      onSelected: (_) => setState(() => _priority = 'high'),
                      selectedColor: Colors.red.shade100,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed:
                          _isSubmitting ? null : () => Navigator.pop(context, false),
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitTicket,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4a90d9),
                        foregroundColor: Colors.white,
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(AppLocalizations.of(context)!.submit),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods (IDENTIC cu Windows)
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'build':
        return Icons.build;
      case 'help_outline':
        return Icons.help_outline;
      case 'event':
        return Icons.event;
      case 'description':
        return Icons.description;
      case 'report_problem':
        return Icons.report_problem;
      case 'more_horiz':
        return Icons.more_horiz;
      default:
        return Icons.category;
    }
  }

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
    } catch (e) {
      return Colors.blue;
    }
  }
}
