import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../services/logger_service.dart';

/// Debug Console Dialog - shows app logs
class DebugConsole extends StatefulWidget {
  const DebugConsole({super.key});

  @override
  State<DebugConsole> createState() => _DebugConsoleState();
}

class _DebugConsoleState extends State<DebugConsole> {
  final _logger = LoggerService();
  final _scrollController = ScrollController();
  StreamSubscription<List<LogEntry>>? _logSubscription;
  List<LogEntry> _logs = [];
  bool _autoScroll = true;

  @override
  void initState() {
    super.initState();
    _logs = _logger.logs;
    _logSubscription = _logger.logStream.listen((logs) {
      if (mounted) {
        setState(() => _logs = logs);
        if (_autoScroll) {
          _scrollToBottom();
        }
      }
    });
  }

  @override
  void dispose() {
    _logSubscription?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _copyLogs() {
    final text = _logger.exportLogs();
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.logsCopied),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 700,
        height: 500,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.terminal, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  'Debug Console',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.logEntries(_logs.length),
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(
                    _autoScroll ? Icons.vertical_align_bottom : Icons.vertical_align_center,
                    color: _autoScroll ? Colors.green : Colors.grey,
                  ),
                  onPressed: () => setState(() => _autoScroll = !_autoScroll),
                  tooltip: _autoScroll ? AppLocalizations.of(context)!.autoScrollOn : AppLocalizations.of(context)!.autoScrollOff,
                ),
                IconButton(
                  icon: const Icon(Icons.copy, color: Colors.blue),
                  onPressed: _copyLogs,
                  tooltip: AppLocalizations.of(context)!.copyLogs,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    _logger.clear();
                    setState(() => _logs = []);
                  },
                  tooltip: AppLocalizations.of(context)!.deleteLogs,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),

            // Logs
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1e1e1e),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _logs.isEmpty
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.noLogs,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        itemCount: _logs.length,
                        itemBuilder: (context, index) {
                          final entry = _logs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text(
                              entry.toString(),
                              style: TextStyle(
                                fontFamily: 'Consolas',
                                fontSize: 12,
                                color: _getLogColor(entry.level),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getLogColor(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Colors.grey;
      case LogLevel.info:
        return Colors.white;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
    }
  }
}

/// Shows the debug console dialog
void showDebugConsole(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const DebugConsole(),
  );
}
