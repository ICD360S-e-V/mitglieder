import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../l10n/app_localizations.dart';

/// Incoming Call Dialog - shown when receiving a voice call
class IncomingCallDialog extends StatefulWidget {
  final String callerName;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const IncomingCallDialog({
    super.key,
    required this.callerName,
    required this.onAccept,
    required this.onReject,
  });

  @override
  State<IncomingCallDialog> createState() => _IncomingCallDialogState();
}

class _IncomingCallDialogState extends State<IncomingCallDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  Timer? _timeoutTimer;
  int _ringCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Auto-reject after 5 minutes (300 seconds)
    _timeoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _ringCount++);
      }
      if (_ringCount >= 300) {
        timer.cancel();
        widget.onReject();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Incoming call text
            Text(
              AppLocalizations.of(context)!.incomingCallTitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            // Animated caller avatar
            ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade400,
                      Colors.green.shade700,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.phone_in_talk,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Caller name
            Text(
              widget.callerName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Ring duration
            Text(
              AppLocalizations.of(context)!.ringingFor(_ringCount),
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 30),

            // Accept / Reject buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reject button
                _buildCallButton(
                  icon: Icons.call_end,
                  color: Colors.red,
                  label: AppLocalizations.of(context)!.rejectCall,
                  onPressed: widget.onReject,
                ),

                // Accept button
                _buildCallButton(
                  icon: Icons.call,
                  color: Colors.green,
                  label: AppLocalizations.of(context)!.acceptCall,
                  onPressed: widget.onAccept,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 32),
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
}

/// In-Call Overlay - shown during an active call with voice activity indicator
class InCallOverlay extends StatefulWidget {
  final String remoteName;
  final Duration callDuration;
  final bool isMuted;
  final VoidCallback onToggleMute;
  final VoidCallback onEndCall;

  const InCallOverlay({
    super.key,
    required this.remoteName,
    required this.callDuration,
    required this.isMuted,
    required this.onToggleMute,
    required this.onEndCall,
  });

  @override
  State<InCallOverlay> createState() => _InCallOverlayState();
}

class _InCallOverlayState extends State<InCallOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  List<double> _barHeights = [0.3, 0.5, 0.7, 0.5, 0.3];

  // Real-time audio level monitoring
  NoiseMeter? _noiseMeter;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  Timer? _fallbackTimer;
  double _currentDecibel = 50.0; // Default: moderate level

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Start real audio monitoring
    _startAudioMonitoring();
  }

  @override
  void dispose() {
    _stopAudioMonitoring();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _startAudioMonitoring() async {
    // noise_meter only works on Android/iOS - use fallback animation on desktop
    if (!(Platform.isAndroid || Platform.isIOS)) {
      _startFallbackAnimation();
      return;
    }

    try {
      // Request microphone permission
      final status = await Permission.microphone.request();
      if (!status.isGranted) {
        // Fallback to simulated animation if permission denied
        _startFallbackAnimation();
        return;
      }

      // Initialize noise meter
      _noiseMeter = NoiseMeter();

      // Start listening to noise levels
      _noiseSubscription = _noiseMeter!.noise.listen(
        (NoiseReading noiseReading) {
          if (!mounted) return;

          _currentDecibel = noiseReading.meanDecibel;

          // Convert decibel (typically 20-80 dB for speech) to visual bars
          // 40 dB = quiet (min bars)
          // 60 dB = normal speech (medium bars)
          // 80+ dB = loud (max bars)
          double normalizedLevel = (_currentDecibel - 40) / 40; // 40-80dB → 0.0 to 1.0
          normalizedLevel = normalizedLevel.clamp(0.0, 1.0);

          if (mounted && !widget.isMuted) {
            setState(() {
              // Generate 5 bars based on real audio level
              _barHeights = List.generate(5, (i) {
                double baseHeight = normalizedLevel * 0.8;
                // Add variation for visual effect
                double variation = (i % 2 == 0 ? 0.1 : -0.1);
                return (0.2 + baseHeight + variation).clamp(0.2, 1.0);
              });
            });

            if (!_pulseController.isAnimating && normalizedLevel > 0.1) {
              _pulseController.repeat(reverse: true);
            } else if (normalizedLevel <= 0.1) {
              _pulseController.stop();
              _pulseController.reset();
            }
          }
        },
        onError: (error) {
          // Fallback to simulated animation on error
          _startFallbackAnimation();
        },
      );
    } catch (e) {
      // Fallback to simulated animation if noise meter fails
      _startFallbackAnimation();
    }
  }

  void _startFallbackAnimation() {
    _fallbackTimer?.cancel();
    // Fallback simulated animation when real audio monitoring fails
    _fallbackTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (!widget.isMuted) {
        setState(() {
          _barHeights = List.generate(5, (i) {
            return 0.2 + (i % 2 == 0 ? 0.3 : 0.6) * (0.5 + (i * 0.15));
          });
        });
        if (!_pulseController.isAnimating) {
          _pulseController.repeat(reverse: true);
        }
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    });
  }

  Future<void> _stopAudioMonitoring() async {
    await _noiseSubscription?.cancel();
    _noiseSubscription = null;
    _noiseMeter = null;
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    if (d.inHours > 0) {
      return '${twoDigits(d.inHours)}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Voice activity indicator (bars)
          _buildVoiceActivityIndicator(),
          const SizedBox(width: 12),

          // Remote name and duration
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.remoteName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                _formatDuration(widget.callDuration),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Mute button
          IconButton(
            icon: Icon(
              widget.isMuted ? Icons.mic_off : Icons.mic,
              color: widget.isMuted ? Colors.red.shade300 : Colors.white,
            ),
            onPressed: widget.onToggleMute,
            tooltip: widget.isMuted ? AppLocalizations.of(context)!.unmute : AppLocalizations.of(context)!.mute,
          ),

          // End call button
          IconButton(
            icon: const Icon(Icons.call_end, color: Colors.white),
            onPressed: widget.onEndCall,
            style: IconButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            tooltip: AppLocalizations.of(context)!.hangUp,
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceActivityIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(5, (index) {
        final height = widget.isMuted ? 4.0 : (_barHeights[index] * 20);
        final color = widget.isMuted ? Colors.red.shade300 : Colors.white;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          width: 3,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

/// Calling Overlay - shown when initiating a call
class CallingOverlay extends StatelessWidget {
  final String targetName;
  final VoidCallback onCancel;

  const CallingOverlay({
    super.key,
    required this.targetName,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing indicator
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: 12),

          // Calling text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.calling,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
              Text(
                targetName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Cancel button
          IconButton(
            icon: const Icon(Icons.call_end, color: Colors.white),
            onPressed: onCancel,
            style: IconButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            tooltip: AppLocalizations.of(context)!.cancel,
          ),
        ],
      ),
    );
  }
}
