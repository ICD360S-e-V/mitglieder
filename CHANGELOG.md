# Changelog

## [1.5.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.5.0...v1.5.1) (2026-05-21)


### Bug Fixes

* **footer:** show real app version, not the hardcoded 1.1.26 ([9ebc25f](https://github.com/ICD360S-e-V/mitglieder/commit/9ebc25f4c9fb4c6287e234bd2bcccb005af60b54))

## [1.5.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.4.1...v1.5.0) (2026-05-21)


### Features

* **chat:** typing-as-read with 5-min ghost bubble TTL ([6176dda](https://github.com/ICD360S-e-V/mitglieder/commit/6176dda2c9a7d538074635114b6c78ab659cf88b))


### Bug Fixes

* **windows:** disable ACG mitigation that blocked ANGLE shader JIT ([b86e7af](https://github.com/ICD360S-e-V/mitglieder/commit/b86e7afc18e47d4756382f1fd4f64d77a2317167))

## [1.4.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.4.0...v1.4.1) (2026-05-21)


### Bug Fixes

* **update:** break update-prompt loop after install ([db59540](https://github.com/ICD360S-e-V/mitglieder/commit/db59540e8ecdacaf00269e04482ef9712c12c728))

## [1.4.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.3.0...v1.4.0) (2026-05-21)


### Features

* **termine:** parent users see their children's termine with pink badge ([3d46d35](https://github.com/ICD360S-e-V/mitglieder/commit/3d46d35ca8a226a70b238b3ee7508f7ced57d3a0))

## [1.3.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.2.0...v1.3.0) (2026-05-15)


### Features

* **security:** TLS interception telemetry + circuit breaker + UI banner ([6643ec8](https://github.com/ICD360S-e-V/mitglieder/commit/6643ec808039c0068ac1a73d48912263e8e84c44))

## [1.2.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.1.29...v1.2.0) (2026-04-24)


### Features

* **chat:** add crop_your_image for document photo cropping ([9197881](https://github.com/ICD360S-e-V/mitglieder/commit/9197881e29722c4bd7ebbef41305684f96ed2384))
* **chat:** crop dialog after camera photo — drag corners to trim document ([1aac02f](https://github.com/ICD360S-e-V/mitglieder/commit/1aac02f9b8862ad87f486ebb55b9a5fd4c80c8de))


### Bug Fixes

* **chat:** handle CropResult sealed class with pattern matching ([edc7f33](https://github.com/ICD360S-e-V/mitglieder/commit/edc7f332156290bc1811216347047335352fb540))
* **chat:** remove invalid fixArea parameter from Crop widget ([3dc8dac](https://github.com/ICD360S-e-V/mitglieder/commit/3dc8dac496bb480d85ce59182dee5ab464c954a9))
* **chat:** use CropResult.image instead of raw Uint8List (crop_your_image v2 API) ([231f872](https://github.com/ICD360S-e-V/mitglieder/commit/231f87272b0288a0b6a07043b2e4e3adbbf158ea))
