import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Centralized HttpClient factory with Let's Encrypt Root CA pinning.
///
/// All HTTP and WebSocket connections to our server MUST use this factory.
///
/// How it works:
/// - Creates a SecurityContext that ONLY trusts ISRG Root X1 (Let's Encrypt root)
/// - Any certificate NOT signed by Let's Encrypt will be rejected
/// - Protects against MITM attacks with rogue/fake CA certificates
/// - Zero maintenance: ISRG Root X1 is valid until 2035, doesn't change at cert renewal
///
/// If migrating to another CA in the future:
/// 1. Add new root CA PEM to _trustedRoots FIRST
/// 2. Release app update (users now trust both CAs)
/// 3. Switch server certificate to new CA
/// 4. Remove old root CA PEM in next release
class HttpClientFactory {
  /// ISRG Root X1 - Let's Encrypt Root CA
  /// Valid: June 4, 2015 - June 4, 2035
  /// Source: https://letsencrypt.org/certificates/
  static const String _isrgRootX1Pem = '''
-----BEGIN CERTIFICATE-----
MIIFazCCA1OgAwIBAgIRAIIQz7DSQONZRGPgu2OCiwAwDQYJKoZIhvcNAQELBQAw
TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMTUwNjA0MTEwNDM4
WhcNMzUwNjA0MTEwNDM4WjBPMQswCQYDVQQGEwJVUzEpMCcGA1UEChMgSW50ZXJu
ZXQgU2VjdXJpdHkgUmVzZWFyY2ggR3JvdXAxFTATBgNVBAMTDElTUkcgUm9vdCBY
MTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAK3oJHP0FDfzm54rVygc
h77ct984kIxuPOZXoHj3dcKi/vVqbvYATyjb3miGbESTtrFj/RQSa78f0uoxmyF+
0TM8ukj13Xnfs7j/EvEhmkvBioZxaUpmZmyPfjxwv60pIgbz5MDmgK7iS4+3mX6U
A5/TR5d8mUgjU+g4rk8Kb4Mu0UlXjIB0ttov0DiNewNwIRt18jA8+o+u3dpjq+sW
T8KOEUt+zwvo/7V3LvSye0rgTBIlDHCNAymg4VMk7BPZ7hm/ELNKjD+Jo2FR3qyH
B5T0Y3HsLuJvW5iB4YlcNHlsdu87kGJ55tukmi8mxdAQ4Q7e2RCOFvu396j3x+UC
B5iPNgiV5+I3lg02dZ77DnKxHZu8A/lJBdiB3QW0KtZB6awBdpUKD9jf1b0SHzUv
KBds0pjBqAlkd25HN7rOrFleaJ1/ctaJxQZBKT5ZPt0m9STJEadao0xAH0ahmbWn
OlFuhjuefXKnEgV4We0+UXgVCwOPjdAvBbI+e0ocS3MFEvzG6uBQE3xDk3SzynTn
jh8BCNAw1FtxNrQHusEwMFxIt4I7mKZ9YIqioymCzLq9gwQbooMDQaHWBfEbwrbw
qHyGO0aoSCqI3Haadr8faqU9GY/rOPNk3sgrDQoo//fb4hVC1CLQJ13hef4Y53CI
rU7m2Ys6xt0nUW7/vGT1M0NPAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNV
HRMBAf8EBTADAQH/MB0GA1UdDgQWBBR5tFnme7bl5AFzgAiIyBpY9umbbjANBgkq
hkiG9w0BAQsFAAOCAgEAVR9YqbyyqFDQDLHYGmkgJykIrGF1XIpu+ILlaS/V9lZL
ubhzEFnTIZd+50xx+7LSYK05qAvqFyFWhfFQDlnrzuBZ6brJFe+GnY+EgPbk6ZGQ
3BebYhtF8GaV0nxvwuo77x/Py9auJ/GpsMiu/X1+mvoiBOv/2X/qkSsisRcOj/KK
NFtY2PwByVS5uCbMiogziUwthDyC3+6WVwW6LLv3xLfHTjuCvjHIInNzktHCgKQ5
ORAzI4JMPJ+GslWYHb4phowim57iaztXOoJwTdwJx4nLCgdNbOhdjsnvzqvHu7Ur
TkXWStAmzOVyyghqpZXjFaH3pO3JLF+l+/+sKAIuvtd7u+Nxe5AW0wdeRlN8NwdC
jNPElpzVmbUq4JUagEiuTDkHzsxHpFKVK7q4+63SM1N95R1NbdWhscdCb+ZAJzVc
oyi3B43njTOQ5yOf+1CceWxG1bQVs5ZufpsMljq4Ui0/1lvh+wjChP4kqKOJ2qxq
4RgqsahDYVvTH9w7jXbyLeiNdd8XM2w9U/t7y0Ff/9yi0GE44Za4rF2LN9d11TPA
mRGunUHBcnWEvgJBQl9nJEiU0Zsnvgc/ubhPgXRR4Xq37Z0j4r7g1SgEEzwxA57d
emyPxgcYxn/eR44/KJ4EBs+lVDR3veyJm+kXQ99b21/+jh5Xos1AnX5iItreGCc=
-----END CERTIFICATE-----''';

  /// Create an HttpClient pinned to Let's Encrypt Root CA.
  /// ONLY certificates signed by Let's Encrypt will be accepted.
  ///
  /// In debug mode, uses system trust store (no pinning) for easier testing.
  static HttpClient createPinnedHttpClient({
    Duration connectionTimeout = const Duration(seconds: 15),
    Duration idleTimeout = const Duration(seconds: 15),
  }) {
    // In debug mode, skip pinning for easier development/testing
    if (kDebugMode) {
      debugPrint('[SSL] Debug mode: certificate pinning DISABLED');
      return HttpClient()
        ..connectionTimeout = connectionTimeout
        ..idleTimeout = idleTimeout;
    }

    // Release mode: create SecurityContext that ONLY trusts ISRG Root X1
    final securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(utf8.encode(_isrgRootX1Pem));

    final client = HttpClient(context: securityContext)
      ..connectionTimeout = connectionTimeout
      ..idleTimeout = idleTimeout;

    debugPrint('[SSL] Certificate pinning ENABLED (ISRG Root X1 only)');
    return client;
  }

  /// Create a default HttpClient WITHOUT pinning.
  /// Use ONLY for connections to external services (STUN servers, etc.)
  static HttpClient createDefaultHttpClient({
    Duration connectionTimeout = const Duration(seconds: 15),
    Duration idleTimeout = const Duration(seconds: 15),
  }) {
    return HttpClient()
      ..connectionTimeout = connectionTimeout
      ..idleTimeout = idleTimeout;
  }
}
