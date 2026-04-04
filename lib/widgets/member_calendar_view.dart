import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../services/termin_service.dart';

/// Member Termine View - List of member's appointments with response actions
class MemberCalendarView extends StatefulWidget {
  final String mitgliedernummer;

  const MemberCalendarView({
    super.key,
    required this.mitgliedernummer,
  });

  @override
  State<MemberCalendarView> createState() => _MemberCalendarViewState();
}

class _MemberCalendarViewState extends State<MemberCalendarView> {
  final _terminService = TerminService();
  Timer? _pollTimer;

  List<Termin> _termine = [];
  bool _isLoading = true;
  String _filter = 'upcoming'; // upcoming, past, all
  int _pendingCount = 0;

  @override
  void initState() {
    super.initState();
    _loadTermine();
    _pollTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      _loadTermineSilent();
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  /// Silent reload - no loading spinner, just refresh data
  Future<void> _loadTermineSilent() async {
    try {
      final result = await _terminService.getMyTermine(filter: _filter);
      if (mounted) {
        final termineList = result['termine'] as List? ?? [];
        final pendingCount = result['pending_count'];
        setState(() {
          _termine = termineList
              .map((t) => Termin.fromJson(t as Map<String, dynamic>))
              .toList();
          _pendingCount = pendingCount is int
              ? pendingCount
              : int.tryParse(pendingCount?.toString() ?? '0') ?? 0;
        });
      }
    } catch (e) {
      debugPrint('[MemberTermine] Silent poll error: $e');
    }
  }

  Future<void> _loadTermine() async {
    setState(() => _isLoading = true);

    try {
      final result = await _terminService.getMyTermine(filter: _filter);

      if (mounted) {
        final termineList = result['termine'] as List? ?? [];
        final pendingCount = result['pending_count'];

        setState(() {
          _termine = termineList
              .map((t) => Termin.fromJson(t as Map<String, dynamic>))
              .toList();
          _pendingCount = pendingCount is int
              ? pendingCount
              : int.tryParse(pendingCount?.toString() ?? '0') ?? 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('[MemberTermine] Error loading termine: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _respondToTermin(Termin termin, String response, {String? reason}) async {
    final l = AppLocalizations.of(context)!;
    try {
      final result = await _terminService.respondToTermin(
        terminId: termin.id,
        response: response,
        reason: reason,
      );

      if (mounted && result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response == 'confirmed'
                  ? l.terminConfirmed
                  : response == 'declined'
                      ? l.terminDeclined
                      : l.terminRescheduleRequested,
            ),
            backgroundColor: response == 'confirmed' ? Colors.green : Colors.orange,
          ),
        );
        _loadTermine(); // Reload to get updated response
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.error(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  // ==================== COLORS ====================

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'vorstandssitzung':
        return const Color(0xFF9C27B0);
      case 'mitgliederversammlung':
        return const Color(0xFF2196F3);
      case 'schulung':
        return const Color(0xFF4CAF50);
      case 'sonstiges':
        return const Color(0xFFFFA726);
      default:
        return Colors.grey;
    }
  }

  Color _getResponseColor(String? response) {
    switch (response) {
      case 'confirmed':
        return Colors.green;
      case 'declined':
        return Colors.red;
      case 'rescheduling':
        return Colors.blue;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  String _getResponseLabel(String? response) {
    final l = AppLocalizations.of(context)!;
    switch (response) {
      case 'confirmed':
        return l.statusConfirmed;
      case 'declined':
        return l.statusDeclined;
      case 'rescheduling':
        return l.statusRescheduling;
      case 'pending':
      default:
        return l.statusPending;
    }
  }

  String _getCategoryLabel(String category) {
    final l = AppLocalizations.of(context)!;
    switch (category) {
      case 'vorstandssitzung':
        return l.categoryVorstandssitzung;
      case 'mitgliederversammlung':
        return l.categoryMitgliederversammlung;
      case 'schulung':
        return l.categorySchulung;
      case 'sonstiges':
        return l.categorySonstiges;
      default:
        return category;
    }
  }

  IconData _getResponseIcon(String? response) {
    switch (response) {
      case 'confirmed':
        return Icons.check_circle;
      case 'declined':
        return Icons.cancel;
      case 'rescheduling':
        return Icons.schedule;
      case 'pending':
      default:
        return Icons.hourglass_empty;
    }
  }

  // ==================== BUILD ====================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildFilterChips(),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _termine.isEmpty
                  ? _buildEmptyState()
                  : _buildTermineList(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      color: const Color(0xFF4a90d9),
      child: Row(
        children: [
          const Icon(Icons.event_note, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l.myAppointments,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (_pendingCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                l.openCount(_pendingCount),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadTermine,
            tooltip: l.refresh,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _buildFilterChip('upcoming', l.filterUpcoming),
          const SizedBox(width: 8),
          _buildFilterChip('past', l.filterPast),
          const SizedBox(width: 8),
          _buildFilterChip('all', l.filterAll),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: const Color(0xFF4a90d9),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected && _filter != value) {
          setState(() => _filter = value);
          _loadTermine();
        }
      },
    );
  }

  Widget _buildEmptyState() {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            _filter == 'upcoming'
                ? l.noUpcomingAppointments
                : _filter == 'past'
                    ? l.noPastAppointments
                    : l.noAppointmentsAvailable,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(
            l.appointmentsShownHere,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildTermineList() {
    return RefreshIndicator(
      onRefresh: _loadTermine,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _termine.length,
        itemBuilder: (context, index) => _buildTerminCard(_termine[index]),
      ),
    );
  }

  Widget _buildTerminCard(Termin termin) {
    final categoryColor = _getCategoryColor(termin.category);
    final responseColor = _getResponseColor(termin.myResponse);
    final dateFormat = DateFormat('HH:mm');
    final endTime = termin.terminEndTime;

    // Localized month abbreviations
    final l = AppLocalizations.of(context)!;
    final months = [l.monthJan, l.monthFeb, l.monthMar, l.monthApr, l.monthMay, l.monthJun, l.monthJul, l.monthAug, l.monthSep, l.monthOct, l.monthNov, l.monthDec];

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showTerminDetails(termin),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left: Date block with category color
              Container(
                width: 64,
                color: categoryColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${termin.terminDate.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      months[termin.terminDate.month - 1],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Center: Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        termin.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Time + Location
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            '${dateFormat.format(termin.terminDate)} - ${dateFormat.format(endTime)}',
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                          ),
                          if (termin.location.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            Icon(Icons.place, size: 14, color: Colors.grey.shade600),
                            const SizedBox(width: 2),
                            Flexible(
                              child: Text(
                                termin.location,
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Category + Response status
                      Row(
                        children: [
                          // Category badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: categoryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.circle, size: 8, color: categoryColor),
                                const SizedBox(width: 4),
                                Text(
                                  _getCategoryLabel(termin.category),
                                  style: TextStyle(fontSize: 11, color: categoryColor, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // Response badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: responseColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: responseColor.withAlpha(100)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(_getResponseIcon(termin.myResponse), size: 12, color: responseColor),
                                const SizedBox(width: 4),
                                Text(
                                  _getResponseLabel(termin.myResponse),
                                  style: TextStyle(fontSize: 11, color: responseColor, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Right: Arrow
              Container(
                width: 32,
                color: Colors.grey.shade50,
                child: const Center(
                  child: Icon(Icons.chevron_right, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== DETAIL DIALOG ====================

  void _showTerminDetails(Termin termin) {
    final l = AppLocalizations.of(context)!;
    final categoryColor = _getCategoryColor(termin.category);
    final responseColor = _getResponseColor(termin.myResponse);
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat('dd. MMMM yyyy', locale);
    final timeFormat = DateFormat('HH:mm');
    final endTime = termin.terminEndTime;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: categoryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getCategoryLabel(termin.category),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: () => Navigator.pop(dialogContext),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                termin.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Date
              _buildDetailRow(Icons.calendar_today, l.dateLabel, dateFormat.format(termin.terminDate)),
              const SizedBox(height: 10),
              // Time
              _buildDetailRow(
                Icons.access_time,
                l.timeLabel,
                '${timeFormat.format(termin.terminDate)} - ${timeFormat.format(endTime)} (${l.durationMinutes(termin.durationMinutes)})',
              ),
              const SizedBox(height: 10),
              // Location
              if (termin.location.isNotEmpty) ...[
                _buildDetailRow(Icons.place, l.locationLabel, termin.location),
                const SizedBox(height: 10),
              ],
              // Creator
              if (termin.createdByName != null) ...[
                _buildDetailRow(Icons.person, l.createdByLabel, termin.createdByName!),
                const SizedBox(height: 10),
              ],
              // Description
              if (termin.description.isNotEmpty) ...[
                _buildDetailRow(Icons.description, l.descriptionLabel, ''),
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(termin.description, style: TextStyle(color: Colors.grey.shade700)),
                ),
                const SizedBox(height: 10),
              ],
              // Linked ticket
              if (termin.ticketId != null) ...[
                _buildDetailRow(Icons.confirmation_number, l.ticketLabel, '#${termin.ticketId} ${termin.ticketSubject ?? ''}'),
                const SizedBox(height: 10),
              ],
              // Divider
              const Divider(height: 24),
              // Response status
              Row(
                children: [
                  Text(l.yourStatus, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: responseColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: responseColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_getResponseIcon(termin.myResponse), size: 14, color: responseColor),
                        const SizedBox(width: 4),
                        Text(
                          _getResponseLabel(termin.myResponse),
                          style: TextStyle(color: responseColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (termin.myReschedulingReason != null && termin.myReschedulingReason!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  l.reasonLabel(termin.myReschedulingReason!),
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                ),
              ],
            ],
          ),
        ),
        actions: [
          // Action buttons based on current status
          if (termin.status == 'scheduled' && termin.isUpcoming) ...[
            if (termin.myResponse != 'confirmed')
              TextButton.icon(
                icon: const Icon(Icons.check_circle, color: Colors.green, size: 18),
                label: Text(l.confirm, style: const TextStyle(color: Colors.green)),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _respondToTermin(termin, 'confirmed');
                },
              ),
            if (termin.myResponse != 'declined')
              TextButton.icon(
                icon: const Icon(Icons.cancel, color: Colors.red, size: 18),
                label: Text(l.decline, style: const TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _respondToTermin(termin, 'declined');
                },
              ),
            if (termin.myResponse != 'rescheduling')
              TextButton.icon(
                icon: const Icon(Icons.schedule, color: Colors.blue, size: 18),
                label: Text(l.reschedule, style: const TextStyle(color: Colors.blue)),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _showRescheduleDialog(termin);
                },
              ),
          ],
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l.close),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: value.isEmpty
              ? Text(label, style: const TextStyle(fontWeight: FontWeight.w500))
              : RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
                      TextSpan(text: value),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  void _showRescheduleDialog(Termin termin) {
    final l = AppLocalizations.of(context)!;
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l.requestReschedule),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l.appointmentLabel(termin.title)),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                labelText: l.rescheduleReason,
                hintText: l.rescheduleReasonHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l.pleaseProvideReason), backgroundColor: Colors.orange),
                );
                return;
              }
              Navigator.pop(dialogContext);
              _respondToTermin(termin, 'rescheduling', reason: reason);
            },
            child: Text(l.request),
          ),
        ],
      ),
    );
  }
}
