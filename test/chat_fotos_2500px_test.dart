import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/widgets/live_chat_dialog.dart' show kChatFotoLangeSeite, kChatFotoQualitaet;

/// Hintergrund: Fotos aus dem Live-Chat gingen in voller Sensorauflösung
/// raus (4600 px, 10 MB). Kamera UND Galerie müssen begrenzen; der Wert muss
/// zum Server passen (bild_verkleinern.php: 2500 / 92).
void main() {
  test('Grenzen: 2500 px lange Seite, Qualität 92', () {
    expect(kChatFotoLangeSeite, 2500);
    expect(kChatFotoQualitaet, 92);
  });

  test('beide Picker im Live-Chat begrenzen Größe und Qualität', () {
    var q = File('lib/widgets/live_chat_dialog.dart').readAsStringSync();
    q = q.replaceAll(RegExp(r'^\s*//.*$', multiLine: true), '');
    final kamera = RegExp(r'pickImage\(\s*source: ImageSource\.camera,\s*maxWidth: kChatFotoLangeSeite,\s*maxHeight: kChatFotoLangeSeite,\s*imageQuality: kChatFotoQualitaet,\s*\)');
    final galerie = RegExp(r'pickMultiImage\(\s*maxWidth: kChatFotoLangeSeite,\s*maxHeight: kChatFotoLangeSeite,\s*imageQuality: kChatFotoQualitaet,\s*\)');
    expect(kamera.hasMatch(q), isTrue, reason: 'Kamera-Picker ohne Begrenzung');
    expect(galerie.hasMatch(q), isTrue, reason: 'Galerie-Picker ohne Begrenzung');
    // und nirgends mehr ein unbegrenzter Aufruf
    expect(RegExp(r'pickImage\(source: ImageSource\.camera\)').hasMatch(q), isFalse);
    expect(RegExp(r'pickMultiImage\(\)').hasMatch(q), isFalse);
  });
}
