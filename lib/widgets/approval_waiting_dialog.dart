import 'dart:async';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';

/// Dialog shown while waiting for admin to approve passwordless login
class ApprovalWaitingDialog extends StatefulWidget {
  final String requestToken;
  final String memberName;
  final String expiresAt;
  final Function(Map<String, dynamic> result) onApproved;
  final VoidCallback onDenied;
  final VoidCallback onExpired;

  const ApprovalWaitingDialog({
    super.key,
    required this.requestToken,
    required this.memberName,
    required this.expiresAt,
    required this.onApproved,
    required this.onDenied,
    required this.onExpired,
  });

  @override
  State<ApprovalWaitingDialog> createState() => _ApprovalWaitingDialogState();
}

class _ApprovalWaitingDialogState extends State<ApprovalWaitingDialog> {
  final _apiService = ApiService();
  Timer? _pollTimer;
  Timer? _countdownTimer;
  int _remainingSeconds = 300; // 5 minutes
  String _statusText = '';
  bool _isResolved = false;

  @override
  void initState() {
    super.initState();
    _statusText = 'Warten auf Genehmigung vom Vorstand...';

    // Poll every 3 seconds
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) => _checkStatus());

    // Countdown timer
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds <= 0 && !_isResolved) {
          _isResolved = true;
          _pollTimer?.cancel();
          _countdownTimer?.cancel();
          widget.onExpired();
        }
      });
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkStatus() async {
    if (_isResolved) return;

    final result = await _apiService.checkApprovalStatus(widget.requestToken);

    if (!mounted || _isResolved) return;

    final status = result['status'] ?? result['data']?['status'];

    if (status == 'approved') {
      _isResolved = true;
      _pollTimer?.cancel();
      _countdownTimer?.cancel();
      final data = result['data'] ?? result;
      widget.onApproved(data);
    } else if (status == 'denied') {
      _isResolved = true;
      _pollTimer?.cancel();
      _countdownTimer?.cancel();
      setState(() => _statusText = 'Login wurde abgelehnt.');
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) widget.onDenied();
    } else if (status == 'expired') {
      _isResolved = true;
      _pollTimer?.cancel();
      _countdownTimer?.cancel();
      widget.onExpired();
    }
  }

  String _formatTime(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: const Color(0xFF1E2A3A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          // Animated icon
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0d47a1).withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: _isResolved
                ? const Icon(Icons.check_circle, size: 48, color: Colors.green)
                : const SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      color: Color(0xFF4a90d9),
                      strokeWidth: 3,
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          // Status text
          Text(
            _statusText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Member name
          Text(
            widget.memberName,
            style: const TextStyle(
              color: Color(0xFF4a90d9),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Countdown
          if (!_isResolved) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _remainingSeconds < 60
                    ? Colors.red.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer,
                    color: _remainingSeconds < 60 ? Colors.red : Colors.white70,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: TextStyle(
                      color: _remainingSeconds < 60 ? Colors.red : Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Der Vorstand wurde benachrichtigt.\nBitte warten Sie auf die Genehmigung.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
      actions: [
        if (!_isResolved)
          TextButton(
            onPressed: () {
              _isResolved = true;
              _pollTimer?.cancel();
              _countdownTimer?.cancel();
              Navigator.pop(context);
            },
            child: Text(
              l10n.cancel,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
      ],
    );
  }
}
