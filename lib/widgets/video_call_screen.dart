import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../l10n/app_localizations.dart';
import '../services/voice_call_service.dart';

/// Full-screen 1:1 video call UI: the remote camera fills the screen, a small
/// local preview sits in the corner, with mute / camera-toggle / switch-camera /
/// hang-up controls. Driven by the shared [VoiceCallService] singleton — it pops
/// itself when the call reaches [CallState.idle] (either side hung up).
class VideoCallScreen extends StatefulWidget {
  final String remoteName;

  const VideoCallScreen({super.key, required this.remoteName});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _service = VoiceCallService();
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  bool _renderersReady = false;

  StreamSubscription<MediaStream?>? _remoteSub;
  StreamSubscription<CallState>? _stateSub;
  Timer? _durationTimer;
  Duration _duration = Duration.zero;
  bool _popped = false;

  @override
  void initState() {
    super.initState();
    _initRenderers();

    _stateSub = _service.callStateStream.listen((state) {
      if (!mounted) return;
      if (state == CallState.inCall && _durationTimer == null) {
        _duration = Duration.zero;
        _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (mounted) setState(() => _duration += const Duration(seconds: 1));
        });
      }
      if (state == CallState.idle) {
        _popIfNeeded();
      } else {
        setState(() {});
      }
    });
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    if (!mounted) return;
    _localRenderer.srcObject = _service.localStream;
    _remoteRenderer.srcObject = _service.remoteStream;
    _remoteSub = _service.remoteStreamStream.listen((stream) {
      _remoteRenderer.srcObject = stream;
      if (mounted) setState(() {});
    });
    setState(() => _renderersReady = true);
  }

  void _popIfNeeded() {
    if (_popped) return;
    _popped = true;
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _remoteSub?.cancel();
    _stateSub?.cancel();
    _durationTimer?.cancel();
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  void _hangUp() {
    _service.endCall();
    _popIfNeeded();
  }

  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final m = two(d.inMinutes.remainder(60));
    final s = two(d.inSeconds.remainder(60));
    return d.inHours > 0 ? '${two(d.inHours)}:$m:$s' : '$m:$s';
  }

  bool get _hasRemoteVideo =>
      _remoteRenderer.srcObject?.getVideoTracks().isNotEmpty ?? false;

  bool get _hasLocalVideo =>
      _localRenderer.srcObject?.getVideoTracks().isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final connected = _service.callState == CallState.inCall;

    return Scaffold(
      backgroundColor: const Color(0xFF0d0d17),
      body: Stack(
        children: [
          // Remote video fills the screen; placeholder until it arrives.
          Positioned.fill(
            child: (_renderersReady && _hasRemoteVideo)
                ? RTCVideoView(
                    _remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                : _buildPlaceholder(connected, l),
          ),

          // Local preview (top-right corner).
          Positioned(
            top: 48,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 108,
                height: 156,
                color: Colors.black,
                child: (_renderersReady && !_service.isCameraOff && _hasLocalVideo)
                    ? RTCVideoView(
                        _localRenderer,
                        mirror: true,
                        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      )
                    : const Center(
                        child: Icon(Icons.videocam_off, color: Colors.white54, size: 30),
                      ),
              ),
            ),
          ),

          // Remote name + duration / status (top-left).
          Positioned(
            top: 52,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.remoteName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    shadows: [Shadow(blurRadius: 6, color: Colors.black54)],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  connected ? _fmt(_duration) : l.calling,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    shadows: [Shadow(blurRadius: 6, color: Colors.black54)],
                  ),
                ),
              ],
            ),
          ),

          // Bottom controls.
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _control(
                  icon: _service.isMuted ? Icons.mic_off : Icons.mic,
                  label: _service.isMuted ? l.micMuted : l.micOn,
                  onTap: () {
                    _service.toggleMute();
                    setState(() {});
                  },
                ),
                _control(
                  icon: _service.isCameraOff ? Icons.videocam_off : Icons.videocam,
                  label: l.camera,
                  onTap: () {
                    _service.toggleCamera();
                    setState(() {});
                  },
                ),
                _control(
                  icon: Icons.cameraswitch,
                  label: l.camera,
                  onTap: () async {
                    await _service.switchCamera();
                    if (mounted) setState(() {});
                  },
                ),
                _control(
                  icon: Icons.call_end,
                  label: l.hangUp,
                  color: Colors.red,
                  onTap: _hangUp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(bool connected, AppLocalizations l) {
    return Container(
      color: const Color(0xFF1a1a2e),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2a2a44),
              ),
              child: const Icon(Icons.person, color: Colors.white70, size: 52),
            ),
            const SizedBox(height: 16),
            Text(
              connected ? widget.remoteName : l.calling,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _control({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? Colors.white24,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }
}
