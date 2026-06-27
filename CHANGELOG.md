# Changelog

## [1.55.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.54.0...v1.55.0) (2026-06-27)


### Features

* **wizard:** live chat over phone everywhere — FAB on every step + replaces "Sună-ne" CTAs ([4252f21](https://github.com/ICD360S-e-V/mitglieder/commit/4252f21a940df4f3ae2e3eb8fe9b74731ee0d1d4))

## [1.54.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.53.1...v1.54.0) (2026-06-27)


### Features

* **wizard:** duplicate-applicant probe at Stufe 1b + polite handoff screen ([039baf9](https://github.com/ICD360S-e-V/mitglieder/commit/039baf9e1794e33f54a4b6cff2cb58e5d3fbea18))

## [1.53.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.53.0...v1.53.1) (2026-06-27)


### Documentation

* **wizard:** switch withdraw to 3-year retention model (DSGVO Art. 6(1)(f) + §195 BGB) ([326fdfe](https://github.com/ICD360S-e-V/mitglieder/commit/326fdfeade07a4fbe8bbc16a906ad96787d998f3))

## [1.53.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.52.0...v1.53.0) (2026-06-27)


### Features

* **wizard:** GDPR-friendly withdraw — anonymise row + hash for abuse throttle ([7800a09](https://github.com/ICD360S-e-V/mitglieder/commit/7800a0902409e2f93ffc2b5d7c2ab78c7eea2c0a))

## [1.52.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.51.1...v1.52.0) (2026-06-27)


### Features

* **wizard:** voluntary withdraw — discreet link + hard confirm + audit-friendly row ([d2c459e](https://github.com/ICD360S-e-V/mitglieder/commit/d2c459e228c9628d03b2222247c84edcf997b812))

## [1.51.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.51.0...v1.51.1) (2026-06-27)


### Bug Fixes

* **wizard:** final screen is non-dismissable, system back becomes no-op ([6e3d641](https://github.com/ICD360S-e-V/mitglieder/commit/6e3d641074f4ec967cccc1c9bbede7bed2da5743))

## [1.51.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.50.1...v1.51.0) (2026-06-27)


### Features

* **wizard:** final screen — Status Card replaces verbose timeline + tap to expand ([436f541](https://github.com/ICD360S-e-V/mitglieder/commit/436f54189b0c797ea160391bda944ac498dd05ae))

## [1.50.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.50.0...v1.50.1) (2026-06-27)


### Bug Fixes

* **wizard:** drop "first meeting" timeline step — out of scope for registration flow ([9b1fbdf](https://github.com/ICD360S-e-V/mitglieder/commit/9b1fbdf2246ebee58ae76003751b73b06c6f419d))

## [1.50.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.49.7...v1.50.0) (2026-06-27)


### Features

* **wizard:** final screen — live status timeline + 1-business-day copy ([e2146c8](https://github.com/ICD360S-e-V/mitglieder/commit/e2146c8ba4b69effa44c147b1c0f26603e5ad168))
* **wizard:** final screen adult body becomes 3 conversational Claudiu beats ([93a98a6](https://github.com/ICD360S-e-V/mitglieder/commit/93a98a6ffddd9f8183e143ee4e3ea8b1a129cd2f))


### Bug Fixes

* **wizard:** Stufe 6/7/8 — ValueKey per dataKey to stop state bleed + per-Stufe timestamps ([17dcc6a](https://github.com/ICD360S-e-V/mitglieder/commit/17dcc6ab83f442eeb41ce418f07b2eefbcc9ebce))

## [1.49.7](https://github.com/ICD360S-e-V/mitglieder/compare/v1.49.6...v1.49.7) (2026-06-27)


### Bug Fixes

* **ci:** force WebRTC-SDK pod upgrade so flutter_webrtc 1.5.2 macOS build resolves ([b9bc377](https://github.com/ICD360S-e-V/mitglieder/commit/b9bc3778a39ed81b0eacac5487ca36e882f48fcd))

## [1.49.6](https://github.com/ICD360S-e-V/mitglieder/compare/v1.49.5...v1.49.6) (2026-06-27)


### Bug Fixes

* **ci:** work around flutter_webrtc 1.5.2 Linux header + macOS pod issues ([093b7ce](https://github.com/ICD360S-e-V/mitglieder/commit/093b7ce0fa4c99daf916bc15608f8351ba032dd4))

## [1.49.5](https://github.com/ICD360S-e-V/mitglieder/compare/v1.49.4...v1.49.5) (2026-06-27)


### Bug Fixes

* **wizard:** Stufe 6/7/8 — Android keeps inline WebView, others route to OS browser ([5e80d66](https://github.com/ICD360S-e-V/mitglieder/commit/5e80d662ae6b1e554e0c27f4e92692c1128bfa29))

## [1.49.4](https://github.com/ICD360S-e-V/mitglieder/compare/v1.49.3...v1.49.4) (2026-06-27)


### Bug Fixes

* **ci:** bump flutter_webrtc to ^1.5.2 + drop Windows junction workaround ([efe13ac](https://github.com/ICD360S-e-V/mitglieder/commit/efe13ace5b585d066f9d57855b546c70d6b6da6b))

## [1.49.3](https://github.com/ICD360S-e-V/mitglieder/compare/v1.49.2...v1.49.3) (2026-06-27)


### Bug Fixes

* **wizard:** Stufe 3 upload — fix "Failed to store" + per-Behörde subfolder ([c18106f](https://github.com/ICD360S-e-V/mitglieder/commit/c18106fa318577ad70a0c059c56661091d956d26))

## [1.49.2](https://github.com/ICD360S-e-V/mitglieder/compare/v1.49.1...v1.49.2) (2026-06-27)


### Bug Fixes

* **wizard:** drop unused _kMaxTotalBytes constant breaking analyze ([eacebbd](https://github.com/ICD360S-e-V/mitglieder/commit/eacebbd252426c216f2ceb6ced82486ad8cac0f3))

## [1.49.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.49.0...v1.49.1) (2026-06-27)


### Refactor

* **wizard:** Stufe 3 files moved to relational wizard_draft_files table ([a05138c](https://github.com/ICD360S-e-V/mitglieder/commit/a05138c854d774251ca6bf75d95b4e64aad1a4f8))

## [1.49.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.48.0...v1.49.0) (2026-06-27)


### Features

* **wizard:** Stufe 3 multi-file Leistungsbescheid (up to 20 / 100 MB) ([1edfba7](https://github.com/ICD360S-e-V/mitglieder/commit/1edfba7e953b159cd306b156c5607bd45324f25a))

## [1.48.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.47.0...v1.48.0) (2026-06-27)


### Features

* **wizard:** Stufe 3 upload — camera + gallery + documents picker sheet ([4a61eb6](https://github.com/ICD360S-e-V/mitglieder/commit/4a61eb6f486aff571b995982a8bc5a435cd9a30b))

## [1.47.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.46.0...v1.47.0) (2026-06-27)


### Features

* **wizard:** add ALG I and Krankengeld as fee-exempt categories in Stufe 3 ([6c37c9b](https://github.com/ICD360S-e-V/mitglieder/commit/6c37c9b9bf9278ffd5ce7b8e5dbb026e22fbdc04))

## [1.46.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.45.0...v1.46.0) (2026-06-25)


### Features

* **wizard:** re-add Stufe 1f email as optional, highlight E2E in-app channel ([374680b](https://github.com/ICD360S-e-V/mitglieder/commit/374680b1be73ea9f1340d5e38e497f103ffc84bf))

## [1.45.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.44.0...v1.45.0) (2026-06-25)


### Features

* **wizard:** reserve mitgliedernummer at check_age + show pill from Stufe 1c ([868f01c](https://github.com/ICD360S-e-V/mitglieder/commit/868f01c013cbd5be60c3ebed3928c6839964cc88))

## [1.44.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.43.0...v1.44.0) (2026-06-25)


### Features

* **wizard:** surface Satzung §6 rules inline across Stufe 4, 5 and final ([10d9165](https://github.com/ICD360S-e-V/mitglieder/commit/10d916545a35e2bbfb22c1f0da190dededb169db))


### Refactor

* **wizard:** drop email field from Stufe 1f — phone + in-app only ([673873f](https://github.com/ICD360S-e-V/mitglieder/commit/673873f6ba64a2f505e5f711105c1f1ec925426a))

## [1.43.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.42.1...v1.43.0) (2026-06-25)


### Features

* **wizard:** mark SEPA-Lastschrift as "Coming soon" in Stufe 4 ([c7ebb53](https://github.com/ICD360S-e-V/mitglieder/commit/c7ebb537f07504b84e37d134c3eb1e3051b865a1))

## [1.42.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.42.0...v1.42.1) (2026-06-25)


### Bug Fixes

* **wizard:** send X-Device-Key header so server validateApiKey passes ([3ecd907](https://github.com/ICD360S-e-V/mitglieder/commit/3ecd907c64628e4113341e9f0057bc27ae71c335))

## [1.42.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.41.0...v1.42.0) (2026-06-25)


### Features

* **wizard:** orchestrator — state machine + welcome integration ([9c582bb](https://github.com/ICD360S-e-V/mitglieder/commit/9c582bb4f6dffb84ce07ef3932230910882e1de8))

## [1.41.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.40.0...v1.41.0) (2026-06-25)


### Features

* **wizard:** final screen — adult celebration + minor waiting variants ([264fe0e](https://github.com/ICD360S-e-V/mitglieder/commit/264fe0e23e485506245721084c3287c0822c8fc4))

## [1.40.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.39.0...v1.40.0) (2026-06-21)


### Features

* **wizard:** Stufe 6/7/8 — document acceptance with scroll-to-bottom ([0ae1323](https://github.com/ICD360S-e-V/mitglieder/commit/0ae1323988043f71eb6fa9c1f7cdcb35ebf1a502))

## [1.39.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.38.0...v1.39.0) (2026-06-21)


### Features

* **wizard:** Stufe 5 — Mitgliedschaftsbeginn (3 options + retroBeitrag) ([5559d40](https://github.com/ICD360S-e-V/mitglieder/commit/5559d40ac6a2a1583c2f7d889cee71d7fc6bf1ea))

## [1.38.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.37.0...v1.38.0) (2026-06-21)


### Features

* **wizard:** Stufe 4 — Zahlungsmethode + Zahlungstag ([e4b2ff2](https://github.com/ICD360S-e-V/mitglieder/commit/e4b2ff25c602c7a1d0b312f87647f4780ee4caa6))

## [1.37.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.36.0...v1.37.0) (2026-06-21)


### Features

* **wizard:** Stufe 3 — Finanzielle Situation (+ conditional upload) ([34eac58](https://github.com/ICD360S-e-V/mitglieder/commit/34eac58c6c9188647febf9d9c6f427b74dc22a82))

## [1.36.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.35.0...v1.36.0) (2026-06-21)


### Features

* **wizard:** Stufe 2 — Mitgliedsart (3 option cards) ([ad38ef8](https://github.com/ICD360S-e-V/mitglieder/commit/ad38ef8c2e9a236710b02cc56c76410d84bd12fb))

## [1.35.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.34.0...v1.35.0) (2026-06-20)


### Features

* **wizard:** Stufe 1f — contact (Telefon mobil + Email) ([2d54fef](https://github.com/ICD360S-e-V/mitglieder/commit/2d54fefdd63db5a5d5b98df6603407fbd87f9988))

## [1.34.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.33.0...v1.34.0) (2026-06-20)


### Features

* **wizard:** Stufe 1e — postal address (Straße/Nr/PLZ/Ort/Land) ([0a07160](https://github.com/ICD360S-e-V/mitglieder/commit/0a071608664615175b692c058183d65cce89c4aa))

## [1.33.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.32.0...v1.33.0) (2026-06-20)


### Features

* **wizard:** Stufe 1d — Staatsangehörigkeit + Aufenthalt + Muttersprache ([9fcafe3](https://github.com/ICD360S-e-V/mitglieder/commit/9fcafe3fabd67ac2061063f007ad3e7183ca35c4))

## [1.32.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.31.1...v1.32.0) (2026-06-20)


### Features

* **wizard:** Stufe 1c — Geschlecht + Familienstand ([60e4309](https://github.com/ICD360S-e-V/mitglieder/commit/60e4309a1a63f9343a93ab9baaeb6369b6aba762))

## [1.31.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.31.0...v1.31.1) (2026-06-20)


### Bug Fixes

* **wizard:** drop unused wizard_service import from age gate screen ([3356e48](https://github.com/ICD360S-e-V/mitglieder/commit/3356e486d76b9b14ea9de176c3e089cabdb5d8d4))

## [1.31.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.30.0...v1.31.0) (2026-06-20)


### Features

* **wizard:** Stufe 1b1 — parent hint capture for 16-17 minors ([839e587](https://github.com/ICD360S-e-V/mitglieder/commit/839e5875c95d96cc45c508301004c1b5eb773d7f))

## [1.30.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.29.0...v1.30.0) (2026-06-20)


### Features

* **wizard:** Stufe 1b (birthdate + birthplace) + Age Gate ([c118d5d](https://github.com/ICD360S-e-V/mitglieder/commit/c118d5dc4788d259514358db3239bdcd22dcede2))

## [1.29.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.28.0...v1.29.0) (2026-06-20)


### Features

* **wizard:** step shell + Stufe 1a (identity matching official docs) ([2beba44](https://github.com/ICD360S-e-V/mitglieder/commit/2beba44e4376f60b9fef5a739b097f89a10f8de9))

## [1.28.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.27.0...v1.28.0) (2026-06-20)


### Features

* **wizard:** intro story screen — Claudiu narrates 6 founding bubbles ([435da10](https://github.com/ICD360S-e-V/mitglieder/commit/435da10268d91ddf74accdb90a03277fa9a157bc))

## [1.27.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.26.1...v1.27.0) (2026-06-20)


### Features

* **wizard:** backend foundation for self-service member onboarding ([d339f88](https://github.com/ICD360S-e-V/mitglieder/commit/d339f883fdc21370e7c12a9825023b39507c60fb))

## [1.26.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.26.0...v1.26.1) (2026-06-20)


### Refactor

* **auth:** drop recovery_code + password from passwordless register ([66b9c16](https://github.com/ICD360S-e-V/mitglieder/commit/66b9c16e3a9f3a97cbd2a3df61fadd2e41daff6b))

## [1.26.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.25.2...v1.26.0) (2026-06-20)


### Features

* **login:** conversational Claudiu wait dialog while Vorsitzer approves ([a981214](https://github.com/ICD360S-e-V/mitglieder/commit/a98121411e0c6cd5711756fe7e87bff2aa39f924))

## [1.25.2](https://github.com/ICD360S-e-V/mitglieder/compare/v1.25.1...v1.25.2) (2026-06-20)


### Bug Fixes

* **imports:** restore http aliased imports my static check missed ([6771477](https://github.com/ICD360S-e-V/mitglieder/commit/6771477e6e6dd65721d9e94a5504f41e8f3b5539))

## [1.25.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.25.0...v1.25.1) (2026-06-20)


### Refactor

* **l10n:** migrate Claudiu inline _Strings to .arb across 28 locales ([52eb15f](https://github.com/ICD360S-e-V/mitglieder/commit/52eb15feed94882e54212df105804c669e08f77c))

## [1.25.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.24.1...v1.25.0) (2026-06-19)


### Features

* **server:** /api/vorstand/anonymous_chat_users.php — Vorstand metadata pull ([0e45ca8](https://github.com/ICD360S-e-V/mitglieder/commit/0e45ca8f986cb28b75d5deb629b9b91c449042db))

## [1.24.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.24.0...v1.24.1) (2026-06-19)


### Bug Fixes

* **anon-chat:** HTTP-first send + 3s polling so messages actually persist ([a8cc962](https://github.com/ICD360S-e-V/mitglieder/commit/a8cc962c154a237c1229a97b74fc6b0247430b28))

## [1.24.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.23.0...v1.24.0) (2026-06-19)


### Features

* **chat:** live anonymous chat — server schema + endpoint, client service + screen ([48f9e82](https://github.com/ICD360S-e-V/mitglieder/commit/48f9e825034854daa537b7263e2678bffa5b2037))

## [1.23.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.22.1...v1.23.0) (2026-06-19)


### Features

* **welcome:** split "I have a problem" into write/chat choice (chat coming soon) ([81d7148](https://github.com/ICD360S-e-V/mitglieder/commit/81d71485b03ea1ca7d558822f39c3ebddcb08072))

## [1.22.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.22.0...v1.22.1) (2026-06-19)


### Bug Fixes

* **deeplinks:** declare tel:/sms: schemes for url_launcher on every platform ([fd13880](https://github.com/ICD360S-e-V/mitglieder/commit/fd13880935bf5ed2be8a8353512d439d878ff6ff))

## [1.22.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.21.2...v1.22.0) (2026-06-19)


### Features

* **welcome:** emergency bottom-sheet — office hours, call, SMS template ([16c7817](https://github.com/ICD360S-e-V/mitglieder/commit/16c7817c64bd1514469e3528c3ff70978b50c7a1))

## [1.21.2](https://github.com/ICD360S-e-V/mitglieder/compare/v1.21.1...v1.21.2) (2026-06-19)


### Documentation

* **server:** bug_report.php + schema reflect the existing ws_broadcast polling ([0e4a4f5](https://github.com/ICD360S-e-V/mitglieder/commit/0e4a4f5ad48fdb74073c88eff0bce5d8c52fe468))

## [1.21.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.21.0...v1.21.1) (2026-06-19)


### Bug Fixes

* **server:** bug_report.php uses project conventions (require ../config.php, jsonResponse, getDBConnection) ([3a5f3c2](https://github.com/ICD360S-e-V/mitglieder/commit/3a5f3c2905bf2707d6bd233820b15c7a4debd30b))

## [1.21.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.20.1...v1.21.0) (2026-06-19)


### Features

* **report:** interactive ProblemReportScreen + public bug-report endpoint ([924f63f](https://github.com/ICD360S-e-V/mitglieder/commit/924f63fa0274f01de459f1368d0cfefc913a638f))

## [1.20.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.20.0...v1.20.1) (2026-06-19)


### Bug Fixes

* **login:** forgot-number panel — drop WhatsApp, hide details behind click ([f832a8b](https://github.com/ICD360S-e-V/mitglieder/commit/f832a8baec76ecd8518611905058ede16770671e))

## [1.20.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.19.0...v1.20.0) (2026-06-19)


### Features

* **login:** two-box M+5-digits form, Claudiu coach, brand header on the page ([9669ca1](https://github.com/ICD360S-e-V/mitglieder/commit/9669ca11097eaab03aa8f806888666c85ab1e4d4))

## [1.19.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.18.4...v1.19.0) (2026-06-19)


### Features

* **diag:** Claudiu-style consent dialog + anonymize the payload ([e334da2](https://github.com/ICD360S-e-V/mitglieder/commit/e334da230a311290078968a64d5f394d31a4f7c2))

## [1.18.4](https://github.com/ICD360S-e-V/mitglieder/compare/v1.18.3...v1.18.4) (2026-06-19)


### Bug Fixes

* **flatpak:** add RuntimeRepo= to .flatpakref so GUI store can install ([a8a0887](https://github.com/ICD360S-e-V/mitglieder/commit/a8a08870500e6ca96c3e0587942a6386cc2c3b30))

## [1.18.3](https://github.com/ICD360S-e-V/mitglieder/compare/v1.18.2...v1.18.3) (2026-06-19)


### Bug Fixes

* **flatpak:** GPG-sign the OSTree commits + embed pubkey in .flatpakref/.flatpakrepo ([d9b9568](https://github.com/ICD360S-e-V/mitglieder/commit/d9b9568b05a915a8f2dab11460d1a967835ee2ad))

## [1.18.2](https://github.com/ICD360S-e-V/mitglieder/compare/v1.18.1...v1.18.2) (2026-06-19)


### Bug Fixes

* Fix:  ([bd74fb1](https://github.com/ICD360S-e-V/mitglieder/commit/bd74fb17ccd9d97c54a3900b26859e862a1e3028))
* **flatpak:** ship .flatpakref so installs can actually 'flatpak update' ([bd74fb1](https://github.com/ICD360S-e-V/mitglieder/commit/bd74fb17ccd9d97c54a3900b26859e862a1e3028))

## [1.18.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.18.0...v1.18.1) (2026-06-19)


### Refactor

* **welcome:** use flutter_animate + animated_text_kit instead of hand-rolled state ([168d0d5](https://github.com/ICD360S-e-V/mitglieder/commit/168d0d593805dcc0a8151041306ed3c137addd00))

## [1.18.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.17.0...v1.18.0) (2026-06-19)


### Features

* **welcome:** staged reveal — Claudiu rolls in, then bubble, then options at T+9s ([348cb28](https://github.com/ICD360S-e-V/mitglieder/commit/348cb2865cd432e2aadedf1bb72038489972c42e))

## [1.17.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.16.6...v1.17.0) (2026-06-19)


### Features

* **welcome:** conversational entry — Claudiu mascot replaces button stack ([820f092](https://github.com/ICD360S-e-V/mitglieder/commit/820f0923823fab12107ce2f58f1f5eb1a6d1791f))

## [1.16.6](https://github.com/ICD360S-e-V/mitglieder/compare/v1.16.5...v1.16.6) (2026-06-18)


### Documentation

* **readme:** add Flatpak auto-update install instructions for Kinoite/KDE/GNOME ([e55ad8a](https://github.com/ICD360S-e-V/mitglieder/commit/e55ad8ac6b3628bd43f68e062befa8951cd36848))

## [1.16.5](https://github.com/ICD360S-e-V/mitglieder/compare/v1.16.4...v1.16.5) (2026-06-18)


### Bug Fixes

* **l10n:** ship SVG country flags so the language picker renders on Linux ([b97b849](https://github.com/ICD360S-e-V/mitglieder/commit/b97b849cae3393cf787017929edf5e45db05fe93))

## [1.16.4](https://github.com/ICD360S-e-V/mitglieder/compare/v1.16.3...v1.16.4) (2026-06-18)


### Performance

* **ci:** cache .dart_tool across analyze and build jobs ([1fef2a3](https://github.com/ICD360S-e-V/mitglieder/commit/1fef2a3a5eda1f620ad46257c5bcd7219649b303))

## [1.16.3](https://github.com/ICD360S-e-V/mitglieder/compare/v1.16.2...v1.16.3) (2026-06-18)


### Performance

* **ci:** enable pub-cache in subosito/flutter-action across all 3 workflows ([2405108](https://github.com/ICD360S-e-V/mitglieder/commit/24051087d5794e21e3b60a38a2d95323994957a4))

## [1.16.2](https://github.com/ICD360S-e-V/mitglieder/compare/v1.16.1...v1.16.2) (2026-06-18)


### Bug Fixes

* **ci:** timeout-minutes 30 on Flatpak job so container-init hangs fail fast ([e4781f3](https://github.com/ICD360S-e-V/mitglieder/commit/e4781f30e9c3f65f2d9befb91d28167341009807))

## [1.16.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.16.0...v1.16.1) (2026-06-18)


### Bug Fixes

* **l10n:** restore dart:io import for File type, drop redundant foundation import ([2a2d8e5](https://github.com/ICD360S-e-V/mitglieder/commit/2a2d8e501a1ba6c88f5bc7ab234218b334ad6ce6))

## [1.16.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.15.0...v1.16.0) (2026-06-18)


### Features

* **l10n:** explicit first-launch language picker, drop device-locale inference ([7831709](https://github.com/ICD360S-e-V/mitglieder/commit/78317092139f0cfeb3e29ff9efc99e70dd18b9f0))

## [1.15.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.14.5...v1.15.0) (2026-06-18)


### Features

* **diag:** per-platform endpoint routing + MITGLIEDER_STARTUP_DIAG_KEY rename ([2673802](https://github.com/ICD360S-e-V/mitglieder/commit/2673802df5e292821128a221f7aa13c758aff740))

## [1.14.5](https://github.com/ICD360S-e-V/mitglieder/compare/v1.14.4...v1.14.5) (2026-06-18)


### Bug Fixes

* **flatpak:** grant system-bus access to NetworkManager for connectivity_plus ([0279595](https://github.com/ICD360S-e-V/mitglieder/commit/027959553a327d56bc197c3fbcc1be182af0b152))

## [1.14.4](https://github.com/ICD360S-e-V/mitglieder/compare/v1.14.3...v1.14.4) (2026-06-18)


### Bug Fixes

* **network:** cap connectivity_plus probe to 2s so it can't freeze startup ([f6c2c28](https://github.com/ICD360S-e-V/mitglieder/commit/f6c2c28ecff9fbe451b487170842bd199e7e61d4))

## [1.14.3](https://github.com/ICD360S-e-V/mitglieder/compare/v1.14.2...v1.14.3) (2026-06-18)


### Bug Fixes

* **linux:** provide LinuxInitializationSettings + raise net init budgets ([7d4cf09](https://github.com/ICD360S-e-V/mitglieder/commit/7d4cf0995f766a0aaafda48cb06eae39ac110907))

## [1.14.2](https://github.com/ICD360S-e-V/mitglieder/compare/v1.14.1...v1.14.2) (2026-06-18)


### Bug Fixes

* **tls:** survive bad cert in flatpak runtime's system bundle ([5fa7ea5](https://github.com/ICD360S-e-V/mitglieder/commit/5fa7ea5ff53d45ddc629fb15a9ec0b9ba69947a1))

## [1.14.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.14.0...v1.14.1) (2026-06-18)


### Bug Fixes

* **linux:** match Vorsitzer SDK + flutter_webrtc to unblock VM rendering ([e59ae16](https://github.com/ICD360S-e-V/mitglieder/commit/e59ae16d86e1a4cf667acb555808efa20d202c6b))

## [1.14.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.13.0...v1.14.0) (2026-06-18)


### Features

* **diag:** inject STARTUP_DIAG_KEY via --dart-define, never in source ([052a7a0](https://github.com/ICD360S-e-V/mitglieder/commit/052a7a09b7213bd1d411253b7cd3e7dd4e766455))

## [1.13.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.12.0...v1.13.0) (2026-06-18)


### Features

* **diag:** auto-upload startup transcript to the central log endpoint ([5bb103d](https://github.com/ICD360S-e-V/mitglieder/commit/5bb103df0e3ee299228e059f4cff4305b47734f0))

## [1.12.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.11.3...v1.12.0) (2026-06-18)


### Features

* **diag:** write per-step startup log to disk so gray-screen launches are debuggable ([825d251](https://github.com/ICD360S-e-V/mitglieder/commit/825d251b70b4649e00b109ec01349602b1c77a27))

## [1.11.3](https://github.com/ICD360S-e-V/mitglieder/compare/v1.11.2...v1.11.3) (2026-06-18)


### Bug Fixes

* **linux:** timeout desktop init so runApp fires on GPU-less VMs ([427e40c](https://github.com/ICD360S-e-V/mitglieder/commit/427e40c3c25354d25dd2d288b97c969511fa4965))

## [1.11.2](https://github.com/ICD360S-e-V/mitglieder/compare/v1.11.1...v1.11.2) (2026-06-17)


### Bug Fixes

* **analyze:** drop now-orphan shared_preferences + device_key_service imports ([028e526](https://github.com/ICD360S-e-V/mitglieder/commit/028e526c4aed5c94b7bd81ef9bb788e9ee6fc86f))

## [1.11.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.11.0...v1.11.1) (2026-06-17)


### Bug Fixes

* **analyze:** clear five warnings flagged by the new analyze gate ([bdc9720](https://github.com/ICD360S-e-V/mitglieder/commit/bdc97200bd1deb58467e4564131bb21d27bc90c7))

## [1.11.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.10...v1.11.0) (2026-06-17)


### Features

* **ci:** analyze gate + split release into priority (Android/Linux/Flatpak) + secondary (Windows/Apple) ([9197512](https://github.com/ICD360S-e-V/mitglieder/commit/9197512ef84eebce230c9bbb0776fe3dfdf20c15))

## [1.10.10](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.9...v1.10.10) (2026-06-17)


### Bug Fixes

* **ci/windows:** use .NET Directory.Delete + robocopy for junction → copy ([09cee26](https://github.com/ICD360S-e-V/mitglieder/commit/09cee26fc675c6aa78dbc74aba775755c345a58f))

## [1.10.9](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.8...v1.10.9) (2026-06-17)


### Bug Fixes

* **ci/windows:** replace flutter_webrtc plugin junction with a copy ([dd4cd14](https://github.com/ICD360S-e-V/mitglieder/commit/dd4cd14d5e0f51c782cd8aaa79d60c2fcdfd4263))

## [1.10.8](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.7...v1.10.8) (2026-06-17)


### Bug Fixes

* **ci:** tag bump to ship the Flutter pin revert ([f542b6d](https://github.com/ICD360S-e-V/mitglieder/commit/f542b6dea2b432051599f681b8ebc85ad32d057f))

## [1.10.7](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.6...v1.10.7) (2026-06-17)


### Reverts

* **flatpak:** drop GL ext + LIBGL_ALWAYS_SOFTWARE — both made it worse ([972c8e4](https://github.com/ICD360S-e-V/mitglieder/commit/972c8e49183bd6e06ccaa2f8b82aa673346325a4))

## [1.10.6](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.5...v1.10.6) (2026-06-17)


### Bug Fixes

* **flatpak:** force Mesa software rendering for Proxmox VM (no GPU) ([8d12ab3](https://github.com/ICD360S-e-V/mitglieder/commit/8d12ab3409c87b92d875be394cc48b5beb289e15))

## [1.10.5](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.4...v1.10.5) (2026-06-17)


### Bug Fixes

* **flatpak:** declare GL add-extension so Mesa drivers mount in sandbox ([9dd8174](https://github.com/ICD360S-e-V/mitglieder/commit/9dd8174727ac260268029411b5ec5965245728a8))

## [1.10.4](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.3...v1.10.4) (2026-06-16)


### Bug Fixes

* **ci:** pin Flutter to 3.38.4 to fix blank content area on Plasma Wayland ([815109f](https://github.com/ICD360S-e-V/mitglieder/commit/815109f6d8e26835635611246bc2c6082df27519))

## [1.10.3](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.2...v1.10.3) (2026-06-16)


### Bug Fixes

* **flatpak:** tag bump to ship the GDK_BACKEND=x11 revert ([3dda8fd](https://github.com/ICD360S-e-V/mitglieder/commit/3dda8fd77084a27ad5d65b3155a33f48d59dc0d9))

## [1.10.2](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.1...v1.10.2) (2026-06-16)


### Bug Fixes

* **flatpak:** force XWayland on KDE Plasma to render the content area ([e6eee7d](https://github.com/ICD360S-e-V/mitglieder/commit/e6eee7d8647a6559110d387fff8914ac9c2eba49))

## [1.10.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.10.0...v1.10.1) (2026-06-16)


### Bug Fixes

* **flatpak:** resize app icon from 1024×1024 to 256×256 ([38b927d](https://github.com/ICD360S-e-V/mitglieder/commit/38b927de161548de118173f09289fff2a446e85d))

## [1.10.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.9.0...v1.10.0) (2026-06-16)


### Features

* **flatpak:** publish OSTree repo to GitHub Pages for `flatpak update` ([5648194](https://github.com/ICD360S-e-V/mitglieder/commit/564819470db589a451d9c9df340d40687bb3d29e))

## [1.9.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.8.0...v1.9.0) (2026-06-16)


### Features

* **linux:** add Flatpak single-file bundle to release pipeline ([1a70453](https://github.com/ICD360S-e-V/mitglieder/commit/1a70453457fc226f26a359dd8c3109b54840636a))

## [1.8.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.7.0...v1.8.0) (2026-06-15)


### Features

* **updater:** move release delivery to GitHub Releases, drop VPS deploy ([1aad610](https://github.com/ICD360S-e-V/mitglieder/commit/1aad6102d7c5d89281c7081e54439da00eb1c1b7))


### Bug Fixes

* **android:** move includeSubdomains attribute to &lt;domain&gt; element ([c484edd](https://github.com/ICD360S-e-V/mitglieder/commit/c484edd51f284927fead8ccf36090be388db1edb))

## [1.7.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.6.1...v1.7.0) (2026-06-15)


### Features

* **android:** strip REQUEST_INSTALL_PACKAGES from googleplay flavor ([a2f1ddb](https://github.com/ICD360S-e-V/mitglieder/commit/a2f1ddb58e3e60617d5ff63f8d2f4366cac83a9b))
* **security:** harden TLS with OS-level pinning + ISRG Root X2 backup ([1815443](https://github.com/ICD360S-e-V/mitglieder/commit/1815443e91916c5a7da150e1fbfa7a69445e0f1c))


### Bug Fixes

* **ios:** extract App Store ID to a named constant with TODO ([5ea1473](https://github.com/ICD360S-e-V/mitglieder/commit/5ea1473340949bb67f8364090b27485392c3fdef))
* **termine:** refresh expired JWT instead of silently looping 401 ([14dc56d](https://github.com/ICD360S-e-V/mitglieder/commit/14dc56d2c0b470f7488de4bd1c7e7519151651ec))

## [1.6.1](https://github.com/ICD360S-e-V/mitglieder/compare/v1.6.0...v1.6.1) (2026-05-23)


### Bug Fixes

* **call:** actionable error when mic permission denied or device missing ([05fdb19](https://github.com/ICD360S-e-V/mitglieder/commit/05fdb197dbf4116d7ae78f28c1d49f59448be8ef))

## [1.6.0](https://github.com/ICD360S-e-V/mitglieder/compare/v1.5.1...v1.6.0) (2026-05-22)


### Features

* **chat:** Snapchat-strict — bubble vanishes at 5-min TTL, no tombstone ([0ec155f](https://github.com/ICD360S-e-V/mitglieder/commit/0ec155fbd1e90642110955ea6375f31381808e90))

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
