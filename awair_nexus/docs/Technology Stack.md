# Technology Stack

AwAir uses a lean, scalable, and cross-platform stack optimized for rapid iteration and Android-first deployment.

## Frontend: React Native + Expo (Android Priority)

- **What**: Cross-platform mobile framework with JavaScript/TypeScript.
- **Why**:
  - Android-first MVP deployment without iOS overhead.
  - Single codebase reduces dev time by ~50% vs native.
  - Expo enables:
    - QR-code testing via Expo Go.
    - Over-the-air (OTA) updates.
    - Cloud builds via EAS (Expo Application Services).
- **Tradeoffs**:
  - APK ~10–15MB larger than pure native.
  - Limited access to bleeding-edge native APIs (acceptable for AwAir’s scope).
- **Used for**: All UI, navigation, session flow, and user interactions.

## Backend: Firebase Ecosystem

### Services Used

- **Authentication**: Email/password, Google OAuth, anonymous guest mode.
- **Cloud Firestore**: NoSQL real-time database with offline persistence.
- **Firebase Storage**: Hosts audio files, Sound→Form images, and TFLite models.
- **Cloud Messaging (FCM)**: Practice reminders, achievement alerts, presence invitations.
- **Analytics**: Tracks retention (D1/D7/D30), conversion funnels, A/B tests.
- **Crashlytics**: Real-time crash reporting with stack traces.

### Why Firebase

- Free tier supports 5K–10K users.
- Zero DevOps: auto-scaling, security rules, no server maintenance.
- Real-time sync and offline support critical for meditation sessions.
- **Tradeoff**: Vendor lock-in (accepted for MVP-to-scale phase).

## Audio Engine (Phased)

### Phase 1 (MVP): Expo AV

- Built into Expo → zero config.
- Supports background playback, lock screen controls, fade-in/out.
- Used for all Level 1–2 tracks and Level 3 preview.

### Phase 2 (Advanced): React Native Track Player

- Enables gapless playback, dynamic mixing (for personalized challenges), and better battery efficiency.
- Migration path clear once multi-track mixing becomes essential.

## State Management (Phased)

### Phase 1: React Context API

- Built into React → no external deps.
- Three contexts: `AuthContext`, `ProgressContext`, `AudioContext`.
- Sufficient for 8-screen app with moderate complexity.

### Phase 2: Zustand (if needed)

- Lightweight, performant, simpler debugging.
- Only adopted if re-render performance becomes an issue.

## AI/ML: On-Device + Server Hybrid

### On-Device (TapGame): TensorFlow Lite + Teachable Machine

- Train custom models for 5 sound types (birds, waves, silence, footsteps, wind).
- Models bundled in app (~3–5MB each).
- Real-time inference (<50ms) with no network dependency.

### Server-Side (Sound→Form): YAMNet on Google Cloud Functions

- Pre-process master audio files to generate precise sound timestamps.
- Outputs `events.json` used for Sound→Form image reveal sequencing.
- Runs once per soundscape during content production.

## Monetization: RevenueCat

- Handles iOS/Android subscriptions with unified API.
- Free up to $2,500/month tracked revenue.
- Manages trials, renewals, family sharing, and receipt validation.
- Webhooks sync subscription status to Firestore.

## Build & Deployment

- **Development**: `expo start` → test on real device via Expo Go.
- **Production Builds**: EAS Build (cloud-compiled APKs).
- **Updates**: OTA updates via Expo for non-native changes.
- **Permissions**: Minimal—only audio, background, and storage.

## Constraints & Guardrails

- **Max Volume**: Capped at 70% (headphone safety).
- **APK Size**: ~80–100MB (2 bundled Level 1 tracks + 1 Level 2 track + Level 3 preview).
- **Offline Support**: Bundled tracks always available; streamed tracks cached after first play.
