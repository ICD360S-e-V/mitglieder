import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/sdp_kurz.dart';

/// Die Kurzfassung der SDP fürs Protokoll: genug, um einen schwarzen
/// Bildschirm zu erklären — und nichts, was in kein Protokoll gehört.
void main() {
  // Eine Antwort, wie sie die Mitglieds-App auf das Angebot des Vorsitzes
  // gibt: Bild nur in eine Richtung, Ton in beide, dazu der Eingabekanal.
  const antwort = 'v=0\r\n'
      'o=- 4611731400430051336 2 IN IP4 127.0.0.1\r\n'
      's=-\r\n'
      't=0 0\r\n'
      'a=group:BUNDLE 0 1 2\r\n'
      'a=extmap-allow-mixed\r\n'
      'a=msid-semantic: WMS 7721995e-b5c5-4b56-b81e-ca328ac1228b\r\n'
      'm=video 9 UDP/TLS/RTP/SAVPF 96 97 98 99 103 104 107\r\n'
      'c=IN IP4 0.0.0.0\r\n'
      'a=rtcp:9 IN IP4 0.0.0.0\r\n'
      'a=ice-ufrag:GEHEIM1\r\n'
      'a=ice-pwd:GEHEIM2GEHEIM2GEHEIM2\r\n'
      'a=fingerprint:sha-256 AA:BB:CC:DD\r\n'
      'a=setup:active\r\n'
      'a=mid:0\r\n'
      'a=extmap:1 urn:ietf:params:rtp-hdrext:toffset\r\n'
      'a=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time\r\n'
      'a=extmap:4 urn:ietf:params:rtp-hdrext:sdes:mid\r\n'
      'a=sendonly\r\n'
      'a=msid:7721995e-b5c5-4b56-b81e-ca328ac1228b 7721995e-b5c5-4b56-b81e-ca328ac1228b\r\n'
      'a=rtcp-mux\r\n'
      'a=rtpmap:96 VP8/90000\r\n'
      'a=rtcp-fb:96 goog-remb\r\n'
      'a=rtcp-fb:96 transport-cc\r\n'
      'a=rtcp-fb:96 ccm fir\r\n'
      'a=rtcp-fb:96 nack\r\n'
      'a=rtcp-fb:96 nack pli\r\n'
      'a=rtpmap:97 rtx/90000\r\n'
      'a=fmtp:97 apt=96\r\n'
      'a=rtpmap:98 VP9/90000\r\n'
      'a=rtcp-fb:98 nack pli\r\n'
      'a=fmtp:98 profile-id=0\r\n'
      'a=rtpmap:99 rtx/90000\r\n'
      'a=rtpmap:103 red/90000\r\n'
      'a=rtpmap:104 rtx/90000\r\n'
      'a=rtpmap:107 ulpfec/90000\r\n'
      'a=ssrc-group:FID 1111 2222\r\n'
      'a=ssrc:1111 cname:GEHEIM3\r\n'
      'a=ssrc:2222 cname:GEHEIM3\r\n'
      'm=audio 9 UDP/TLS/RTP/SAVPF 111\r\n'
      'a=mid:1\r\n'
      'a=sendrecv\r\n'
      'a=rtpmap:111 opus/48000/2\r\n'
      'm=application 9 UDP/DTLS/SCTP webrtc-datachannel\r\n'
      'a=mid:2\r\n';

  test('eine Zeile für die Sitzung, eine je Bildabschnitt', () {
    final z = sdpVideoKurz(antwort);
    expect(z, hasLength(2));
    expect(z[0], contains('bundle=0,1,2'));
    expect(z[0], contains('extmap-allow-mixed=ja'));
    expect(z[1], startsWith('video mid=0 sendonly'));
  });

  /// Der ERSTE Codec ist der, mit dem gesendet wird — die Reihenfolge ist die
  /// Aussage, also darf sie nicht sortiert werden.
  test('Codecs in der Reihenfolge der SDP, Hilfsformate getrennt', () {
    final z = sdpVideoKurz(antwort)[1];
    expect(z, contains('codecs=VP8,VP9'));
    expect(z, contains('+red'));
    expect(z, contains('+rtx'));
    expect(z, contains('+ulpfec'));
  });

  test('Spurgruppe, Quellen, Rückmeldungen und Erweiterungen sind gezählt', () {
    final z = sdpVideoKurz(antwort)[1];
    expect(z, contains('msid=1'));
    expect(z, contains('ssrc=2'));
    expect(z, contains('nack-pli'));
    expect(z, contains('transport-cc'));
    expect(z, contains('ext=toffset,abs-send-time,mid'));
  });

  /// 🔴 Zugangsdaten der Sitzung und Kennungen gehören in kein Protokoll.
  test('keine Zugangsdaten und keine Kennungen im Protokoll', () {
    final alles = sdpVideoKurz(antwort).join('\n');
    expect(alles, isNot(contains('GEHEIM')));
    expect(alles, isNot(contains('AA:BB')));
    expect(alles, isNot(contains('7721995e')));
    expect(alles, isNot(contains('1111')));
  });

  /// Nur die Einstellung des ersten Codecs — bei H264 entscheidet das Profil
  /// darüber, ob die Gegenseite ihn dekodieren kann.
  test('fmtp nur vom ersten Codec', () {
    const h264 = 'v=0\r\n'
        'm=video 9 UDP/TLS/RTP/SAVPF 100 101 96\r\n'
        'a=mid:1\r\n'
        'a=recvonly\r\n'
        'a=rtpmap:100 H264/90000\r\n'
        'a=fmtp:100 level-asymmetry-allowed=1;packetization-mode=1;profile-level-id=42e01f\r\n'
        'a=rtpmap:101 rtx/90000\r\n'
        'a=fmtp:101 apt=100\r\n'
        'a=rtpmap:96 VP8/90000\r\n';
    final z = sdpVideoKurz(h264)[1];
    expect(z, contains('codecs=H264,VP8'));
    expect(z, contains('fmtp[H264]='));
    expect(z, contains('profile-level-id=42e01f'));
    expect(z, isNot(contains('apt=100')));
  });

  test('ohne Bildabschnitt und ohne SDP steht es da', () {
    expect(sdpVideoKurz(null), ['<leer>']);
    expect(sdpVideoKurz('  '), ['<leer>']);
    expect(
      sdpVideoKurz('v=0\r\nm=audio 9 UDP/TLS/RTP/SAVPF 111\r\na=mid:0\r\n'),
      contains('kein m=video'),
    );
  });
}
