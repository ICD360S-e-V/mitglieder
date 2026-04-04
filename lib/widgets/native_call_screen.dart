import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';

/// Native Android Call Screen - Full-screen UI for incoming/active calls
class NativeCallScreen extends StatefulWidget {
  final String remoteName;
  final bool isIncoming;
  final bool isActive;
  final Duration? callDuration;
  final bool isMuted;
  final bool isSpeakerOn;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback onToggleMute;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onEndCall;
  final String? connectionQuality; // 'excellent', 'good', 'poor', 'disconnected'

  const NativeCallScreen({
    super.key,
    required this.remoteName,
    this.isIncoming = false,
    this.isActive = false,
    this.callDuration,
    required this.isMuted,
    required this.isSpeakerOn,
    this.onAccept,
    this.onReject,
    required this.onToggleMute,
    required this.onToggleSpeaker,
    required this.onEndCall,
    this.connectionQuality,
  });

  @override
  State<NativeCallScreen> createState() => _NativeCallScreenState();
}

class _NativeCallScreenState extends State<NativeCallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  Timer? _autoRejectTimer;
  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();

    // Set status bar to transparent for full-screen effect
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Auto-reject incoming call after 30 seconds
    if (widget.isIncoming && !widget.isActive) {
      _autoRejectTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() => _secondsRemaining--);
          if (_secondsRemaining <= 0) {
            timer.cancel();
            widget.onReject?.call();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _autoRejectTimer?.cancel();

    // Restore status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF4a90d9),
      statusBarIconBrightness: Brightness.light,
    ));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: SafeArea(
        child: widget.isIncoming && !widget.isActive
            ? _buildIncomingCallUI()
            : _buildActiveCallUI(),
      ),
    );
  }

  /// Incoming call UI - full screen
  Widget _buildIncomingCallUI() {
    return Column(
      children: [
        const SizedBox(height: 60),

        // Caller avatar with pulse animation
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            final scale = 1.0 + (_pulseController.value * 0.1);
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4a90d9).withValues(alpha: 0.8),
                      const Color(0xFF2196F3).withValues(alpha: 0.6),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4a90d9).withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 32),

        // Caller name
        Text(
          widget.remoteName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        // "Eingehender Anruf" text
        Text(
          AppLocalizations.of(context)!.incomingCallTitle,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 24),

        // Auto-reject countdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            AppLocalizations.of(context)!.autoRejectIn(_secondsRemaining),
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ),

        const Spacer(),

        // Accept / Reject buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Reject button
            _buildCircleButton(
              icon: Icons.call_end,
              label: AppLocalizations.of(context)!.rejectCall,
              color: Colors.red,
              onPressed: widget.onReject ?? () {},
            ),

            // Accept button
            _buildCircleButton(
              icon: Icons.call,
              label: AppLocalizations.of(context)!.acceptCall,
              color: Colors.green,
              onPressed: widget.onAccept ?? () {},
            ),
          ],
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  /// Active call UI - full screen
  Widget _buildActiveCallUI() {
    return Column(
      children: [
        const SizedBox(height: 40),

        // Network quality indicator
        _buildNetworkQualityIndicator(),

        const SizedBox(height: 40),

        // Remote user avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF4a90d9).withValues(alpha: 0.8),
                const Color(0xFF2196F3).withValues(alpha: 0.6),
              ],
            ),
          ),
          child: const Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 24),

        // Remote name
        Text(
          widget.remoteName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        // Call duration
        if (widget.callDuration != null)
          Text(
            _formatDuration(widget.callDuration!),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

        const Spacer(),

        // Control buttons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Speaker button
            _buildControlButton(
              icon: widget.isSpeakerOn ? Icons.volume_up : Icons.volume_down,
              label: widget.isSpeakerOn ? AppLocalizations.of(context)!.speakerOn : AppLocalizations.of(context)!.speakerOff,
              isActive: widget.isSpeakerOn,
              onPressed: widget.onToggleSpeaker,
            ),

            // Mute button
            _buildControlButton(
              icon: widget.isMuted ? Icons.mic_off : Icons.mic,
              label: widget.isMuted ? AppLocalizations.of(context)!.micMuted : AppLocalizations.of(context)!.micOn,
              isActive: !widget.isMuted,
              onPressed: widget.onToggleMute,
            ),
          ],
        ),

        const SizedBox(height: 40),

        // End call button
        GestureDetector(
          onTap: widget.onEndCall,
          child: Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildNetworkQualityIndicator() {
    final quality = widget.connectionQuality ?? 'good';
    final icon = _getQualityIcon(quality);
    final color = _getQualityColor(quality);
    final text = _getQualityText(quality);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getQualityIcon(String quality) {
    switch (quality) {
      case 'excellent':
        return Icons.signal_cellular_4_bar;
      case 'good':
        return Icons.signal_cellular_alt;
      case 'poor':
        return Icons.signal_cellular_alt_1_bar;
      case 'disconnected':
        return Icons.signal_cellular_connected_no_internet_0_bar;
      default:
        return Icons.signal_cellular_alt;
    }
  }

  Color _getQualityColor(String quality) {
    switch (quality) {
      case 'excellent':
        return Colors.green;
      case 'good':
        return Colors.blue;
      case 'poor':
        return Colors.orange;
      case 'disconnected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getQualityText(String quality) {
    final l = AppLocalizations.of(context)!;
    switch (quality) {
      case 'excellent':
        return l.connectionExcellent;
      case 'good':
        return l.connectionGood;
      case 'poor':
        return l.connectionWeak;
      case 'disconnected':
        return l.connectionLost;
      default:
        return l.unknownValue;
    }
  }

  Widget _buildCircleButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 35),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF4a90d9)
                  : Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
