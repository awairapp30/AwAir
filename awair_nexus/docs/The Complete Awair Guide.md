# 🗿 AWAIR: COMPLETE MASTER BLUEPRINT 2025

## The Definitive Architectural & Implementation Specification

**Version:** 3.0 Master Consolidated
**Platform Priority:** Android-first (iOS Phase 2)
**Status:** Production-ready specification incorporating all design decisions, technical architecture, and implementation roadmap

---

## 📋 TABLE OF CONTENTS

1. [Executive Overview & Vision](#1-executive-overview--vision)
2. [Technology Stack & Architecture Decisions](#2-technology-stack--architecture-decisions)
3. [User Personas & Core Principles](#3-user-personas--core-principles)
4. [Audio Architecture & Asset Strategy](#4-audio-architecture--asset-strategy)
5. [Database Schema & Data Model](#5-database-schema--data-model)
6. [Screen Architecture & Navigation](#6-screen-architecture--navigation)
7. [Core User Flows](#7-core-user-flows)
8. [Visual Reward Systems](#8-visual-reward-systems)
9. [Sound Mastery Achievement System](#9-sound-mastery-achievement-system)
10. [TapGame Design & Implementation](#10-tapgame-design--implementation)
11. [Sound→Form Journey Experience](#11-soundform-journey-experience)
12. [AI/ML Sound Detection Architecture](#12-aiml-sound-detection-architecture)
13. [State Management Architecture](#13-state-management-architecture)
14. [Monetization & Business Model](#14-monetization--business-model)
15. [Educational Content & Learn System](#15-educational-content--learn-system)
16. [Analytics & Optimization](#16-analytics--optimization)
17. [Accessibility & Quality Assurance](#17-accessibility--quality-assurance)
18. [Privacy, Security & Permissions](#18-privacy-security--permissions)
19. [Complete Development Roadmap](#19-complete-development-roadmap)
20. [Technical Implementation Guide](#20-technical-implementation-guide)
21. [Content Production Pipeline](#21-content-production-pipeline)
22. [Testing & Launch Strategy](#22-testing--launch-strategy)

---

## 1. EXECUTIVE OVERVIEW & VISION

### The Core Concept

AwAir is a **presence-first sound mindfulness mobile application** that trains users to find peace within noise rather than seeking escape from it. Unlike traditional meditation apps that emphasize silence, AwAir teaches acceptance and equanimity through progressive exposure to challenging soundscapes.

**The Paradigm Shift:** Don't fight the waves—learn to surf them.

### Key Differentiators

1. **Progressive Sound Training:** 3-level system from gentle nature sounds to urban intensity
2. **Personalized Challenge System:** Users select their specific trigger sounds for targeted practice
3. **Sound→Form Journey:** Innovative eyes-closed listening followed by visual reveal of sounds heard
4. **Active Learning Integration:** TapGame feature bridges passive meditation with active awareness training
5. **Sound Mastery Achievements:** RPG-style progression tracking per trigger sound type
6. **No Silence Required:** Practice anywhere—office, commute, home with kids

### Product Philosophy

**Core Belief:** The problem isn't noise—it's your relationship with noise. AwAir rewires the brain's stress response through neuroplasticity-based practice.

**User Promise:** Master peace in any environment, not just quiet rooms.

---

## 2. TECHNOLOGY STACK & ARCHITECTURE DECISIONS

### Frontend Framework: React Native + Expo (Android Priority)

**What it is:** Cross-platform framework allowing single JavaScript codebase for both Android and iOS, with Expo tooling for rapid development.

**Why chosen:**

- **Android-first strategy:** Deploy MVP to Google Play immediately while building iOS in parallel for Phase 2
- **Cost efficiency:** One codebase = half the development time vs native Android + iOS
- **Expo advantages:**
  - No Android Studio/Xcode setup during development
  - Test on real devices via Expo Go app (QR code)
  - Cloud build service (EAS) handles APK/IPA compilation
  - Over-the-air updates for bug fixes without app store approval

**Tradeoffs accepted:**

- Slightly larger APK size vs pure native (~10-15MB overhead)
- Limited access to bleeding-edge Android APIs (acceptable for AwAir's needs)
- Expo constraints (can't use certain native modules requiring custom native code)

**When it matters:** Every UI component, navigation flow, audio playback, and user interaction is built once and deployed to both platforms.

---

### Backend: Firebase Ecosystem

**Services used:**

**Firebase Authentication**

- Email/password sign-in
- Google OAuth single-tap login
- Guest mode with anonymous auth
- Secure credential management (passwords never stored locally)

**Cloud Firestore (Database)**

- NoSQL document-based structure
- Real-time sync across devices
- Offline persistence (users can practice without internet)
- Scalable to millions of users

**Firebase Storage**

- Audio file hosting (streamed tracks)
- Image assets for Sound→Form Journey
- Signed URLs for secure access
- CDN-backed for global low-latency delivery

**Firebase Cloud Messaging**

- Push notifications for practice reminders
- Presence invitations ("Notice silence right now—15s listening")
- Achievement unlocks

**Firebase Analytics**

- User behavior tracking
- Retention metrics (D1, D7, D30)
- Conversion funnel analysis
- A/B testing infrastructure

**Firebase Crashlytics**

- Real-time crash reporting
- Error tracking with stack traces
- Device-specific issue identification

**Why Firebase:**

- **Free tier sufficient for first 5,000-10,000 users**
- **Serverless:** No DevOps overhead (no server maintenance, updates, scaling)
- **Security built-in:** Firestore rules prevent unauthorized data access
- **Fast iteration:** Changes deploy in minutes, not hours

**Tradeoff:** Vendor lock-in (migrating off Firebase later is complex). **Acceptable for MVP-to-scale phase.**

---

### Audio Engine: Expo AV → React Native Track Player (Phased)

**Phase 1 (MVP):** Expo AV

- Built into Expo (zero config)
- Handles basic playback, pause, seek
- Background audio support
- Lock screen controls

**Phase 2 (Advanced Features):** React Native Track Player

- Gapless playback between tracks
- Advanced queue management
- Better battery optimization
- Simultaneous multi-track mixing (for personalized challenges)

**Why phased approach:**

- MVP needs reliability over features
- Expo AV proven stable for 10-30 minute meditation tracks
- Track Player upgrade path clear when dynamic mixing becomes priority

---

### State Management: React Context API → Zustand (Phased)

**Phase 1:** React Context API

- Built into React (no library)
- Sufficient for 8 screens + moderate complexity
- Three contexts: AuthContext, ProgressContext, AudioContext

**Phase 2:** Zustand (if needed)

- Lightweight state library
- Better performance with many subscribers
- Simpler debugging

**Why phased:** Don't add complexity until necessary. Context API handles MVP perfectly.

---

### AI/ML: TensorFlow Lite + Teachable Machine

**For TapGame sound detection:**

- **Teachable Machine:** Train custom models for 5 game types (birds, waves, silence, footsteps, wind)
- **TFLite:** On-device inference (no server calls = instant response)
- **YAMNet (optional):** Server-side batch processing for initial soundscape tagging

**Why this stack:**

- Teachable Machine is **no-code** (fast prototyping)
- TFLite models are **small** (2-5MB per model)
- **Free and open-source**

---

## 3. USER PERSONAS & CORE PRINCIPLES

### Persona A: New/First-Time User "Emma"

**Profile:**

- 32-year-old marketing manager
- Lives in noisy apartment (traffic, neighbors)
- Tried Headspace/Calm, couldn't maintain practice ("too hard to find quiet")
- Skeptical of meditation ("not for busy people")
- Attention span: 10 minutes max for first try

**Goals:**

- Immediate stress relief without needing perfect conditions
- Quick results (wants to feel different after 1 session)
- Low commitment (won't pay until proven value)

**Emma's Experience with AwAir:**

1. Downloads app (sees 4.5★ rating, "peace in noise" tagline)
2. Opens → Welcome screen → taps "Continue as Guest"
3. Single 5-phase onboarding (2 minutes): Welcome → Learn Preview → Tutorial → Safety/Volume → Optional Sign-up
4. Home screen shows Level 1 "Forest Dawn" with "START PRACTICE" button
5. Taps → Practice Introduction modal: "Close your eyes. Breathe. Listen—without naming."
6. 10-minute session plays (bundled audio = instant start)
7. Reflection: "How present were you? (1-5)" → taps 3
8. Sees "You practiced 10 minutes! 🎉" + partial mandala piece unlocked
9. Returns next day because she felt calmer AND saw tangible progress

**Critical Success Factors for Emma:**

- Audio MUST play within 3 seconds of hitting start
- First session MUST feel accomplishable (10 min is perfect)
- Immediate visible reward (mandala piece) reinforces return
- No payment pressure until she's hooked (guest mode essential)

---

### Persona B: Returning/Experienced User "Marcus"

**Profile:**

- 28-year-old software engineer
- Regular meditator (6 months experience)
- Likes gamification (Duolingo streak = 247 days)
- Values data ("show me my progress trends")
- Willing to pay for quality tools

**Goals:**

- Structured progression (clear milestones)
- Variety (doesn't want same practice every day)
- Challenge (Level 1 becomes easy after 20 sessions)
- Analytics (wants to see improvement over time)

**Marcus's Experience with AwAir:**

1. Completes Level 1 mandala (10 sessions, ~100 minutes)
2. Unlocks Level 2 "Park Life" (mixed pleasant/challenging sounds)
3. After session, tries TapGame ("test your listening awareness")
4. Loves the active element (scores 95% accuracy)
5. Completes Level 2 after 3 weeks
6. Sees paywall for Level 3: "Ready for urban intensity? $3.99/month"
7. Converts to premium (value proven, wants the challenge)
8. Uses advanced analytics dashboard to track presence rating improvement
9. Sets personalized challenge: practices with "traffic" sounds specifically (his trigger)
10. Achieves Gold Mastery for traffic (30 sessions, 4.0+ avg presence)

**Critical Success Factors for Marcus:**

- Clear progression path (3 levels + personalized challenges)
- Gamification elements (TapGame, achievements, streaks)
- Data visibility (charts showing improvement)
- Premium tier feels worth the cost (Level 3 is genuinely harder + exclusive)

---

### Persona C: Mindful Explorer "Sarah"

**Profile:**

- 45-year-old yoga instructor
- Deep meditation practice (10+ years)
- Interested in contemplative techniques
- Skeptical of tech/gamification ("meditation isn't a game")
- Values depth over bells and whistles

**Goals:**

- Authentic practice experiences
- Insight and self-discovery
- No distractions or gimmicks
- Connection between sound and consciousness

**Sarah's Experience with AwAir:**

1. Drawn to "Sound→Form Journey" concept (Eckhart Tolle influence)
2. Completes 20-minute Forest session with eyes closed
3. Post-session: "Now open your eyes…"
4. Images of sounds reveal sequentially (bird → wind → distant stream)
5. Moment of recognition: "I heard that, but didn't label it during practice"
6. Deeper reflection prompt: "What did you notice about the space between sounds?"
7. Writes in journal: profound insight about presence vs content
8. Never plays TapGame (skips that prompt every time)
9. Premium subscriber for exclusive Sound→Form journeys (8 environments)
10. Recommends to yoga students as "contemplative sound practice"

**Critical Success Factors for Sarah:**

- TapGame is OPTIONAL (doesn't force gamification)
- Sound→Form Journey feels authentic (images enhance, don't gimmick)
- Reflection prompts are deep, not superficial
- App respects her practice style (no nagging, no gamification pressure)

---

### Core Design Principles (Derived from Personas)

1. **Instant Gratification for Newcomers:** First audio plays within 3 seconds (bundled Level 1 tracks)
2. **Progressive Challenge:** Each level genuinely harder (Emma → Marcus → Sarah progression)
3. **Optional Gamification:** TapGame visible but skippable (respect purists like Sarah)
4. **Guest-First:** No forced sign-up (Emma can try before committing)
5. **Clear Milestones:** Visual rewards at specific thresholds (mandala pieces motivate Marcus)
6. **Depth Available:** Sound→Form and journaling for contemplative users (Sarah's needs)
7. **Respect for Practice:** Minimal UI during sessions (dark screen, simple timer, no distractions)
8. **Data Privacy:** Optional tracking (users control what's shared)

---

## 4. AUDIO ARCHITECTURE & ASSET STRATEGY

### Audio Bundling Policy (Detailed Specification)

This policy balances **app size**, **user experience**, and **monetization strategy**.

#### **Level 1: Foundation (Gentle Sounds) - FREE**

**Bundled Assets:**

- **2 full tracks** bundled inside APK
- **Format:** Ogg Vorbis or AAC at **64-128 kbps**
- **Duration:** 20 minutes each (master files)
- **Total size budget:** ≤40MB for both tracks combined

**Tracks:**

1. **"Forest Dawn"** - Birds, gentle breeze, distant stream (15-20MB)
2. **"Ocean Whisper"** - Waves, seagulls, soft wind (15-20MB)

**Additional tracks (streamed):** 3. **"Garden Peace"** - Bees, rustling leaves, wind chimes 4. **"Mountain Air"** - Alpine winds, distant birds, occasional bell

**Rationale:**

- First-time user (Emma) gets **instant practice** (no download wait)
- 2 bundled tracks provide variety for first week
- Returning users download tracks 3-4 on-demand (cached after first play)
- Total Level 1 size with 2 bundled: ~80-100MB APK (acceptable for modern phones)

---

#### **Level 2: Balance (Mixed Pleasant/Challenging) - FREE**

**Bundled Assets:**

- **1 full track** bundled inside APK
- **Format:** 64-128 kbps Ogg Vorbis/AAC
- **Duration:** 20 minutes
- **Size budget:** ≤20MB

**Track:**

1. **"Park Life"** - Birds + distant traffic + children playing far away (bundled, ~18MB)

**Additional tracks (streamed):** 2. **"Café Corner"** - Gentle music + occasional conversation + coffee machine 3. **"Library Hum"** - Pages turning + distant footsteps + HVAC ambience 4. **"Garden with City"** - Nature sounds + distant sirens + airplane overhead

**Rationale:**

- Users reaching Level 2 have proven commitment (completed Level 1)
- Will tolerate brief download for tracks 2-4 (progressive streaming)
- 1 bundled track ensures immediate Level 2 start (no friction at unlock moment)
- Saves ~60MB in APK size vs bundling all 4

---

#### **Level 3: Mastery (Intense Sounds) - PREMIUM 🔒**

**Bundled Assets:**

- **1 track with 5-minute preview only** bundled
- **Format:** 64-128 kbps Ogg Vorbis/AAC
- **Preview size:** ~4-6MB
- **Full track:** Streams/downloads after premium purchase

**Tracks:**

1. **"Urban Rush"** - Traffic, horns, sirens, construction, crowds (5-min preview bundled)
2. **"Office Chaos"** - Phones ringing, keyboard clicking, conversations, printer (streamed)
3. **"Transit Hub"** - Train announcements, crowds, machinery, echoing footsteps (streamed)

**Rationale:**

- Preview lets free users **taste** Level 3 (sample the challenge)
- Creates desire for full experience (5 minutes ends just as they're settling in)
- Premium paywall appears at peak motivation moment (completed Level 2, wants more)
- Saves ~50-60MB in APK by streaming full Level 3 content

---

#### **Level 4+ & Themed Journeys - PREMIUM 🔒**

**All Streamed/Downloaded:**

- No bundled assets
- Premium users can download for offline use
- Examples: "Desert Night," "Rainforest Canopy," "City at 3am," "Industrial Port"

**Rationale:**

- Premium subscribers have demonstrated payment willingness
- Will wait for download (already invested)
- Keeps base app size manageable (free users don't download content they can't access)

---

### Duration Handling & File Management

**User-Selected Durations:** 5, 10, 15, 20, 30 minutes

**Implementation Strategy:**

```javascript
// All tracks produced as 20-minute master files
// App truncates playback at user-selected duration

const playTrackWithDuration = async (trackUri, selectedDuration) => {
  const sound = await Audio.Sound.createAsync(trackUri);
  await sound.playAsync();

  // Stop playback at selected duration
  setTimeout(async () => {
    await sound.stopAsync();
    navigateToReflection();
  }, selectedDuration * 60 * 1000);
};
```

**Why this works:**

- Produce **11 audio files** (not 55 separate duration files)
- Programmatic truncation adds zero complexity
- Smooth fade-out implemented at stop point (prevents jarring cut-off)

**Exception:** 30-minute option requires either:

1. Looping the 20-minute track with crossfade (seamless repeat)
2. Producing select tracks as 30-minute masters (premium tracks only)

**Recommendation:** Option 1 for MVP (looping), Option 2 for Phase 2 premium differentiation.

---

### Audio Specifications & Quality Standards

**Encoding:**

- **Container:** Ogg Vorbis (Android native support, superior compression) OR AAC (cross-platform compatibility)
- **Bitrate:** 64 kbps (voice-heavy ambience) to 128 kbps (rich soundscapes)
- **Sample rate:** 44.1 kHz (CD quality sufficient, higher is imperceptible for ambient sounds)
- **Channels:** Stereo (spatial positioning critical for immersion)

**Quality Checklist per Track:**

- ✅ Peak volume never exceeds -3dB (headphone safety)
- ✅ No clipping or distortion audible
- ✅ Sounds pan naturally across stereo field (birds left, chimes right)
- ✅ 5-second fade-in at start, 5-second fade-out at end
- ✅ Background noise floor below -60dB (imperceptible hiss)
- ✅ Tested on phone speakers (most common playback) and cheap earbuds

---

### Asset Metadata Schema

**JSON structure for each soundscape:**

```json
{
  "soundscapeId": "forest_dawn_v1",
  "title": "Forest Dawn",
  "level": 1,
  "duration": 1200,
  "bundled": true,
  "fileSize": 18000000,
  "format": "ogg",
  "bitrate": 96,
  "description": "Gentle forest ambience with morning birds",
  "difficulty": "gentle",
  "sounds": ["birds", "breeze", "stream"],
  "layers": [
    {
      "id": "bird_chirp",
      "label": "Bird chirp",
      "timestamps": [15, 90, 145, 280, 360],
      "image": "bird_cardinal.png"
    },
    {
      "id": "breeze",
      "label": "Gentle breeze",
      "timestamps": [30, 120, 240],
      "image": "wind_trees.png"
    },
    {
      "id": "stream",
      "label": "Distant stream",
      "timestamps": [60, 180, 300],
      "image": "water_stream.png"
    }
  ],
  "license": "own",
  "creator": "AwAir Productions"
}
```

**Purpose of metadata:**

- **`bundled`**: Controls whether app looks for local asset or streams
- **`layers` array**: Used for Sound→Form Journey (image reveal sequence)
- **`timestamps`**: Drives TapGame detection windows and Sound→Form timing
- **`sounds` array**: Tags for personalized challenge selection

**Storage:** Firestore collection `soundscapes/{soundscapeId}` or JSON files in Firebase Storage.

---

### Streaming & Caching Strategy

**Progressive Download:**

```javascript
// Level 2+ tracks on first play
const streamAndCacheTrack = async soundscapeId => {
  const cacheKey = `awair_audio_${soundscapeId}`;

  // Check local cache first
  const cachedUri = await AsyncStorage.getItem(cacheKey);
  if (cachedUri && (await fileExists(cachedUri))) {
    return cachedUri; // Instant playback
  }

  // Download from Firebase Storage
  const storageRef = `audio/level2/${soundscapeId}.ogg`;
  const downloadUrl = await getDownloadURL(storageRef);

  // Show progress indicator
  const localUri = await FileSystem.downloadAsync(
    downloadUrl,
    FileSystem.documentDirectory + `${soundscapeId}.ogg`,
    {
      /* progress callback */
    }
  );

  // Cache location for next time
  await AsyncStorage.setItem(cacheKey, localUri);
  return localUri;
};
```

**Cache Management:**

- **Level 1 bundled:** Never deleted (part of app)
- **Level 2-4 streamed:** Cached indefinitely unless user manually clears or device storage pressure
- **Cache size display:** Settings screen shows "45MB cached audio" with "Clear Cache" button
- **Smart cleanup:** If cache exceeds 200MB, auto-delete least-recently-played tracks (keep last 5 sessions worth)

**Offline Mode:**

- Bundled tracks (L1) always available offline
- Cached tracks playable offline
- Un-cached tracks show "Download required" prompt with file size

---

### Audio Production Pipeline (Detailed)

This is the actual step-by-step process for creating each track.

#### **Phase 1: Sourcing (2-3 hours per track)**

**Sound Libraries (Free/Affordable):**

- **Freesound.org** - 500,000+ sounds, Creative Commons
- **BBC Sound Effects** - 16,000+ high-quality ambiences
- **Zapsplat.com** - Commercial use with attribution
- **Sonniss GameAudioGDC** - Annual free packs (10GB+ each year)

**Sourcing Checklist:**

- Download 30-50 candidate sounds per track
- Verify license (CC0, CC-BY, or purchased commercial)
- Prioritize long recordings (5+ minutes) to avoid obvious loops
- Check quality (no background noise, clean recordings, professional level)

**Organization:**

```
audio_production/
├── level1_forest/
│   ├── sources/
│   │   ├── birds/
│   │   │   ├── cardinal_chirp_01.wav
│   │   │   ├── robin_song_02.wav
│   │   ├── ambience/
│   │   │   ├── forest_background_calm.wav
│   │   ├── accents/
│   │       ├── wind_chime_distant.wav
│   ├── project/
│   │   ├── forest_dawn.aup3 (Audacity project)
│   ├── exports/
│       ├── forest_dawn_master.wav
│       ├── forest_dawn_20min.ogg
```

---

#### **Phase 2: Mixing (6-8 hours per track)**

**Tools:** Audacity (free) or Reaper (affordable DAW)

**Mixing Steps:**

**1. Base Layer (Continuous Ambience)**

- Import 20-minute forest background loop
- Set volume to -12dB to -18dB (moderate presence, not overwhelming)
- Apply gentle EQ (cut below 80Hz to reduce rumble, boost 2-4kHz for clarity)
- Use fade-in (10 seconds) and fade-out (10 seconds)

**2. Accent Layers (Intermittent Sounds)**

- Import bird chirps, place every 60-120 seconds
- Randomize timing slightly (not metronomic)
- Vary volume per instance (-15dB to -22dB) for natural feel
- Pan across stereo field (bird 1 at 20% left, bird 2 at 35% right)

**3. Surprise Elements (Occasional Sounds)**

- Wind chimes at minutes 3, 8, 14, 18
- Set very low (-24dB to -30dB) - subliminal presence
- Long reverb tail (creates spaciousness)

**4. Balancing**

- Play entire 20 minutes straight (don't just check sections)
- Listen for: repetitive patterns, volume jumps, clashing sounds
- Use spectral analysis to verify no frequency masking (two sounds fighting for same range)
- Check peak levels: nothing above -3dB (headphone safety)

**5. Mastering**

- Normalize to -1dB maximum peak (consistent loudness across tracks)
- Apply gentle compression (2:1 ratio) to smooth dynamics
- Dither when exporting to lossy format (prevents quantization distortion)

---

#### **Phase 3: Quality Control (1-2 hours per track)**

**Listening Test Matrix:**

| Playback Device    | Test Focus             | Pass Criteria                           |
| ------------------ | ---------------------- | --------------------------------------- |
| Phone speaker      | Clarity, muddiness     | All sounds distinguishable              |
| Cheap earbuds      | Bass balance           | No overwhelming low-end                 |
| Quality headphones | Artifacts, noise floor | No hiss, clicks, or distortion          |
| Volume levels      | Safety, comfort        | 50%, 75%, 100% all pleasant             |
| Environmental      | Real-world context     | Tested during actual meditation session |

**Specific QC Checks:**

- ✅ Entire 20 minutes listened straight through (no "quick spot checks")
- ✅ No abrupt cuts or pops (crossfades smooth)
- ✅ Stereo image natural (sounds positioned logically)
- ✅ Silence never dead (always subtle ambience)
- ✅ No sounds startle or jolt (even challenging Level 3 sounds arise gradually)

---

#### **Phase 4: Export & Metadata (30 minutes per track)**

**Export Settings (Audacity example):**

```
File → Export → Export Audio...
Format: Ogg Vorbis
Quality: 5 (≈128 kbps) for rich tracks, 3 (≈96 kbps) for simple ambience
Metadata:
  - Title: Forest Dawn
  - Artist: AwAir
  - Album: Level 1 Soundscapes
  - Duration: 20:00
```

**File Naming Convention:**

```
{level}_{soundscape_id}_{duration}min.{format}
Examples:
  L1_forest_dawn_20min.ogg
  L2_park_life_20min.ogg
  L3_urban_rush_preview_5min.ogg
```

**Metadata JSON Creation:**

- Document all timestamps where distinct sounds occur
- Take screenshots for Sound→Form images (or commission illustrations)
- Write description focusing on what makes this track unique
- Tag sounds for personalized challenge system

---

### Production Timeline & Resource Allocation

**11 Tracks Total:**

- Level 1: 4 tracks × 10 hours = **40 hours**
- Level 2: 4 tracks × 12 hours = **48 hours** (more complex mixing)
- Level 3: 3 tracks × 14 hours = **42 hours** (challenging to balance intensity with safety)

**Total:** ~130 hours audio production

**Parallelization Strategy:**

- Week 1-2: Produce 2 Level 1 tracks (for bundled APK)
- Week 3-4: Produce remaining 2 Level 1 tracks (test with beta users)
- Week 5-6: Produce 4 Level 2 tracks (user feedback incorporated)
- Week 7-8: Produce 3 Level 3 tracks (after Level 2 difficulty validated)

**Solo producer:** 8 weeks at 16-18 hours/week
**Team of 2:** 4-5 weeks with parallel production

---

## 5. DATABASE SCHEMA & DATA MODEL

### Firestore Collections Architecture

Firestore is a NoSQL database organized as collections (folders) containing documents (files), which can contain subcollections (nested folders).

---

#### **Collection: `users/{userId}`**

**Purpose:** Core user profile, preferences, and progress summary

```javascript
users/{userId}/
  profile: {
    email: string,
    displayName: string,
    isGuest: boolean,
    createdAt: timestamp,
    lastActive: timestamp,
    isPremium: boolean,
    premiumSince: timestamp,
    premiumExpiresAt: timestamp,
    subscriptionType: 'monthly' | 'annual' | null,
    trialUsed: boolean,
  },

  preferences: {
    audio: {
      maxVolume: number, // 0-1, capped at 0.7 for safety
      fadeInDuration: number, // seconds, default 5
      fadeOutDuration: number, // seconds, default 5
      backgroundPlayback: boolean, // default true
    },
    notifications: {
      dailyReminder: boolean,
      reminderTime: string, // "08:00"
      streakReminder: boolean,
      achievementAlerts: boolean,
      presenceInvitations: boolean, // micro-practice prompts
      frequency: 'high' | 'medium' | 'low',
    },
    appearance: {
      darkMode: 'auto' | 'light' | 'dark',
      colorScheme: string, // future: 'forest', 'ocean', 'sunset'
      animationSpeed: 'slow' | 'normal' | 'fast',
      reducedMotion: boolean, // accessibility
    },
    practice: {
      defaultDuration: number, // minutes, default 10
      autoPlayNext: boolean, // chain sessions
      showTimer: boolean, // hide for advanced users
      quoteFrequency: 'minimal' | 'normal' | 'frequent',
      skipIntros: boolean, // after 10 sessions, can skip practice intro modal
    },
  },

  progress: {
    // Overall stats
    totalSessions: number,
    totalMinutes: number,
    currentStreak: number,
    longestStreak: number,
    lastSessionDate: timestamp,
    firstSessionDate: timestamp,

    // Level-specific progress
    levels: {
      level1: {
        sessionsCompleted: number,
        minutesCompleted: number,
        rewardProgress: number, // 0-10 mandala pieces
        rewardComplete: boolean,
        averagePresenceRating: number, // calculated after each session
        completionRate: number, // percentage of started sessions finished
        favoriteTrack: string, // most-played soundscapeId
        firstCompletedDate: timestamp,
      },
      level2: {
        // Same structure
        unlocked: boolean, // true after Level 1 mandala complete
      },
      level3: {
        // Same structure
        unlocked: boolean, // true only if isPremium
      },
    },

    // Personalized challenges
    challenges: {
      totalChallenges: number,
      selectedSounds: array, // ['traffic', 'construction', 'babies_crying']
      soundMastery: {
        traffic: {
          tier: 'bronze' | 'silver' | 'gold' | 'platinum',
          totalSessions: number,
          totalMinutes: number,
          averagePresenceRating: number,
          highIntensitySessions: number, // Level 3 sessions with this sound
          longestSession: number, // minutes
          currentStreak: number, // consecutive days practicing this sound
          lastPracticeDate: timestamp,
          firstPracticeDate: timestamp,
          progressionRate: number, // improvement velocity (calculated)
          badges: array, // ['traffic_aware', 'traffic_accepted', 'traffic_master', 'traffic_zen']
          nextMilestone: object, // { tier: 'silver', sessionsNeeded: 7, minutesNeeded: 75 }
        },
        // ... other sounds
      },
    },

    // Achievements
    achievements: {
      unlocked: array, // ['first_session', 'week_warrior', 'sound_explorer']
      unlockedDates: object, // { 'first_session': timestamp, ... }
      progress: object, // Partial progress toward locked achievements
      rarity: object, // { 'first_session': 100, 'sonic_sage': 5.2 } // percentage of users
    },

    // Analytics aggregations (for premium dashboard)
    analytics: {
      weeklyMinutes: array, // Last 12 weeks: [45, 60, 52, 78, ...]
      presenceTrend: array, // Last 30 sessions: [3, 3, 4, 3, 4, 4, 5, ...]
      soundRelationEvolution: {
        pushed_away: number, // Count of times selected across all sessions
        noticed_neutrally: number,
        used_as_anchor: number,
        felt_curious: number,
      },
      practiceTimeDistribution: {
        morning: number, // 6am-12pm session count
        afternoon: number, // 12pm-6pm
        evening: number, // 6pm-12am
        night: number, // 12am-6am
      },
      favoriteTime: string, // 'morning' | 'afternoon' | 'evening' | 'night'
      averageSessionLength: number, // minutes
    },
  },
```

**Why this structure:**

- **Single document fetch** loads all user data (fast home screen)
- **Nested objects** keep related data together (easier queries)
- **Pre-calculated analytics** avoid expensive aggregations on every load
- **Progress summary** eliminates need to query all session documents

---

#### **Subcollection: `users/{userId}/sessions/{sessionId}`**

**Purpose:** Detailed history of every practice session

```javascript
users/{userId}/sessions/{sessionId}/
  // Core session data
  sessionId: string, // auto-generated
  timestamp: timestamp,
  level: number, // 1, 2, 3, or 4+
  soundscapeId: string, // 'forest_dawn_v1'
  trackTitle: string, // 'Forest Dawn'
  intendedDuration: number, // minutes selected
  actualDuration: number, // seconds actually practiced
  completed: boolean, // true if reached intended duration

  // Reflection data
  reflection: {
    presenceRating: number, // 1-5
    soundsHeard: array, // ['bird', 'wind', 'chime']
    soundRelation: string, // 'pushed_away' | 'noticed_neutrally' | 'used_as_anchor' | 'felt_curious'
    notes: string, // optional journal entry
    deepReflection: object, // only for Sound→Form sessions
  },

  // Session-specific metrics
  sessionMetrics: {
    pauseCount: number,
    pauseTotalDuration: number, // seconds
    interruptions: array, // ['phone_call', 'notification', 'app_background']
    volumeAdjustments: number,
    exitAttempts: number, // times user tried to quit before completion
    quotesShown: array, // which quotes appeared during session
    tapGamePlayed: boolean,
    tapGameScore: number, // if played
  },

  // Context data (for ML/recommendations)
  context: {
    timeOfDay: string, // 'morning' | 'afternoon' | 'evening' | 'night'
    dayOfWeek: string,
    deviceType: string,
    connectionType: string, // 'wifi' | 'cellular' | 'offline'
    location: string, // optional user-entered: 'home' | 'work' | 'commute'
  },

  // Sound→Form specific (if applicable)
  soundForm: {
    isJourney: boolean,
    imagesRevealed: array, // IDs of images shown
    revealSequence: array, // timestamps when each image appeared
    deepPromptResponse: string, // response to contemplative question
  },

  // Metadata
  metadata: {
    appVersion: string,
    deviceOS: string, // 'Android 13'
    deviceModel: string,
    audioQuality: string, // 'bundled' | 'streamed' | 'cached'
  },
```

**Query patterns enabled:**

```javascript
// Last 10 sessions for profile screen
await db
  .collection('users/{uid}/sessions')
  .orderBy('timestamp', 'desc')
  .limit(10)
  .get();

// All Level 2 sessions for analytics
await db.collection('users/{uid}/sessions').where('level', '==', 2).get();

// Sessions this week
await db
  .collection('users/{uid}/sessions')
  .where('timestamp', '>=', startOfWeek)
  .get();
```

---

#### **Subcollection: `users/{userId}/reflections/{reflectionId}`**

**Purpose:** Full journal entries (separate from quick reflections in sessions)

```javascript
users/{userId}/reflections/{reflectionId}/
  reflectionId: string,
  sessionId: string, // reference to session this belongs to
  timestamp: timestamp,
  type: 'quick' | 'deep' | 'journal', // quick = 1-tap, deep = Sound→Form prompt, journal = free-form
  content: {
    text: string, // main journal entry
    moodTags: array, // ['calm', 'focused', 'restless']
    insights: array, // user-defined insights
    questions: array, // prompts they responded to
  },
  metadata: {
    wordCount: number,
    timeSpentWriting: number, // seconds
  },
```

**Why separate collection:**

- Reflections can be **searched and filtered** independently
- Some sessions have quick reflections (stored in session doc)
- Deep reflections and journals are **longer-form** (deserve own documents)
- Enables **reflection analytics** (frequency, word count trends)

---

#### **Global Collection: `soundscapes/{soundscapeId}`**

**Purpose:** Metadata for all audio tracks (read-only for users)

```javascript
soundscapes/{soundscapeId}/
  soundscapeId: string,
  title: string,
  level: number,
  duration: number, // seconds
  bundled: boolean, // true for L1 tracks 1-2, L2 track 1, L3 preview
  fileSize: number, // bytes
  format: string, // 'ogg' | 'aac' | 'mp3'
  bitrate: number, // kbps
  description: string,
  difficulty: string, // 'gentle' | 'moderate' | 'challenging' | 'intense'
  tags: array, // ['nature', 'urban', 'water', 'voices']
  sounds: array, // ['birds', 'traffic', 'wind'] for challenge system

  // For Sound→Form Journey
  isSoundFormJourney: boolean,
  layers: [
    {
      id: string, // 'bird_chirp'
      label: string, // 'Cardinal chirping'
      timestamps: array, // [15, 90, 145] seconds
      image: string, // 'bird_cardinal.png' or URL
      imageAlt: string, // accessibility description
    },
    // ... more layers
  ],

  // For TapGame
  tapGameCompatible: boolean,
  eventMetadata: object, // { events: [{eventId, time, confidence}] }

  // Asset locations
  audioUri: string, // Firebase Storage path or bundled asset path
  previewUri: string, // For Level 3 preview
  thumbnailUri: string,

  // Metadata
  license: string,
  creator: string,
  createdAt: timestamp,
  updatedAt: timestamp,

  // Usage statistics (updated nightly via Cloud Function)
  stats: {
    totalPlays: number,
    uniqueUsers: number,
    averageCompletionRate: number,
    averagePresenceRating: number,
  },
```

**Firestore Rules (read-only for regular users):**

```javascript
match /soundscapes/{soundscapeId} {
  allow read: if request.auth != null; // authenticated users
  allow write: if request.auth.token.admin == true; // admins only
}
```

---

#### **Global Collection: `appContent/`**

**Purpose:** Quotes, tips, articles, testimonials

```javascript
appContent/quotes/{quoteId}/
  quoteId: string,
  text: string,
  author: string, // or 'AwAir' for original quotes
  category: 'grounding' | 'acceptance' | 'philosophical' | 'playful',
  level: number | 'all', // which level this quote best suits
  length: 'short' | 'medium' | 'long',

appContent/tips/{tipId}/
  tipId: string,
  text: string,
  category: 'technique' | 'reframing' | 'encouragement',
  context: 'onboarding' | 'practice' | 'reflection',

appContent/articles/{articleId}/
  articleId: string,
  title: string,
  content: string, // markdown or HTML
  category: 'science' | 'technique' | 'philosophy',
  unlockCondition: object, // { type: 'sessions_completed', value: 3 }
  readTime: number, // minutes

appContent/testimonials/{testimonialId}/
  testimonialId: string,
  name: string,
  role: string, // 'Urban Professional', 'Parent'
  quote: string,
  fullStory: string,
  placement: array, // ['home_screen', 'level_2_intro']
```

---

#### **Global Collection: `achievements/{achievementId}`**

**Purpose:** Achievement definitions and global stats

```javascript
achievements/{achievementId}/
  achievementId: string,
  title: string,
  description: string,
  icon: string, // URL or asset name
  rarity: 'common' | 'uncommon' | 'rare' | 'legendary',
  category: 'consistency' | 'duration' | 'mastery' | 'exploration',
  requirements: {
    type: string, // 'streak' | 'total_sessions' | 'level_complete' | 'sound_mastery'
    value: number, // 7 for week streak, 100 for 100 sessions
    specific: object, // { level: 2 } or { sound: 'traffic', tier: 'gold' }
  },
  rewardType: 'badge' | 'avatar_item' | 'theme' | 'content_unlock',
  rewardData: object,

  // Global statistics (updated nightly)
  globalStats: {
    totalUnlocked: number,
    unlockPercentage: number, // e.g., 15.7% of all users
    lastUpdated: timestamp,
  },
```

---

#### **Collection: `analytics/{date}`**

**Purpose:** Daily aggregated metrics for business intelligence

```javascript
analytics/{date}/ // date format: YYYY-MM-DD
  date: string,

  users: {
    dailyActive: number,
    newSignups: number,
    guestUsers: number,
    premiumUsers: number,
    churnedUsers: number, // haven't returned in 30 days
  },

  sessions: {
    totalStarted: number,
    totalCompleted: number,
    averageDuration: number,
    completionRate: number, // percentage
    byLevel: {
      level1: number,
      level2: number,
      level3: number,
    },
  },

  tapGames: {
    totalPlayed: number,
    averageScore: number,
    engagementRate: number, // percentage of users who played after session
  },

  conversions: {
    freeToGuest: number,
    guestToAccount: number,
    freeToPremium: number,
    trialStarted: number,
    trialConverted: number,
    churnedPremium: number,
  },

  revenue: {
    dailyRevenue: number,
    monthlyRecurring: number,
    averageRevenuePerUser: number,
  },

  retention: {
    day1: number, // percentage
    day7: number,
    day30: number,
  },
```

---

### Advanced Collection: `users/{userId}/analyticsCache/current/`

**Purpose:** Pre-calculated data for instant premium dashboard loading

```javascript
users/{userId}/analyticsCache/current/
  lastUpdated: timestamp,

  weeklyData: {
    thisWeek: {
      sessions: number,
      minutes: number,
      avgPresence: number,
      completionRate: number,
    },
    lastWeek: { /* same structure */ },
    // ... last 12 weeks
  },

  levelComparison: {
    level1: {
      sessions: number,
      avgPresence: number,
      avgDuration: number,
      mostPlayedTrack: string,
    },
    level2: { /* same */ },
    level3: { /* same */ },
  },

  presenceEvolution: {
    overall: number, // current 30-day average
    trend: 'improving' | 'stable' | 'declining',
    changePercentage: number, // +15.3% vs previous period
    chartData: array, // [{week: 1, avgPresence: 3.2}, ...]
  },

  soundRelationShift: {
    currentDistribution: {
      pushed_away: number, // percentage
      noticed_neutrally: number,
      used_as_anchor: number,
      felt_curious: number,
    },
    monthlyTrend: array, // historical distribution
  },

  predictions: {
    nextAchievement: object, // { id, daysEstimate }
    recommendedChallenge: string, // 'traffic' based on improvement trajectory
    personalizedInsight: string, // 'You practice best in the morning'
  },
```

**Why cache:**

- Calculating 12 weeks of data from 100+ session documents = **slow**
- Premium dashboard must load **instantly** (< 500ms)
- Cache updates after each session (incremental calculation)
- If cache becomes stale (timestamp > 24 hours old), recalculate from sessions collection

---

### Database Performance Optimization Strategies

**1. Compound Indexes (Firestore)**

```javascript
// Index for fetching recent sessions by level
Index: users / { userId } / sessions - level(Ascending) - timestamp(Descending);

// Index for streak calculation
Index: users / { userId } / sessions -
  timestamp(Descending) -
  completed(Ascending);
```

**2. Denormalization (Intentional Data Duplication)**

- Store `averagePresenceRating` in both `users/{uid}/progress/levels/level1` AND `analyticsCache`
- Duplicating data reduces queries but requires update consistency

**3. Pagination for Long Lists**

```javascript
// Don't fetch all 500 sessions at once
const firstBatch = await sessionsRef
  .orderBy('timestamp', 'desc')
  .limit(20)
  .get();

// Load more on scroll
const nextBatch = await sessionsRef
  .orderBy('timestamp', 'desc')
  .startAfter(firstBatch.docs[firstBatch.docs.length - 1])
  .limit(20)
  .get();
```

**4. Offline Persistence (Built into Firestore)**

```javascript
// Enable offline caching
await firebase.firestore().enablePersistence();

// Users can practice without internet
// Writes queue locally and sync when online
```

---

## 6. SCREEN ARCHITECTURE & NAVIGATION

### Updated 8-Screen Structure

**Bottom Tab Navigation (Main App):**

1. **Home** - Quick start, mini analytics, continue practice
2. **Practice** - Level selection, direct play
3. **Learn** - Journal/reflections, articles, guides
4. **Profile** - Settings, subscription, downloads, stats

**Modal Screens (Overlays):** 5. **WelcomeOnboarding** - Single immersive 5-phase flow 6. **Practice Introduction** - Appears immediately before session start 7. **Practice Session** - Active playback screen 8. **Reflection & Reveal** - Post-session feedback + Sound→Form images

---

### Screen 1: WelcomeOnboarding (Single Immersive Flow)

**Trigger:** First app launch only

**5 Phases (Vertical Scroll or Swipe):**

**Phase 1: Welcome**

- Full-screen breathing logo animation
- Ambient sound plays (gentle forest, 10 seconds)
- Text fades in: "Find peace within noise"
- CTA: Swipe up or tap "Begin"

**Phase 2: App Intro & Learn Preview**

- Visual: Sound wave transforming into calm water ripple
- Text: "Traditional meditation says: find quiet. AwAir says: find peace anywhere."
- 3 value propositions:
  - "Practice with real-world sounds"
  - "Progress through 3 levels"
  - "Track your journey"
- CTA: "Next"

**Phase 3: Interactive Tutorial**

- **Mini-demo:** 30-second practice preview
- Visual: Circular timer with quote appearing
- Text: "Close your eyes. Listen. Notice sounds without labeling them."
- Audio plays during demo (5 seconds of forest sounds)
- CTA: "Got it"

**Phase 4: Safety, Volume, Headphone Recommendation**

- **Safety Notice:**
  - "Use comfortable volume (we'll help you set it)"
  - "Headphones recommended for immersive experience"
  - Warning icon: "Stop if you experience discomfort"
- **Volume Calibration:**
  - Slider appears
  - "Test" button plays 3-second sample
  - Current volume shown as percentage
  - Red zone above 70% (locked out)
  - Recommended: 50-65%
- **Headphone Check:**
  - "For best experience, use headphones"
  - Icons showing: earbuds, over-ear, phone speaker
  - Option: "I'll use headphones" or "Continue without"
- CTA: "Set and Continue"

**Phase 5: Optional Sign-up**

- **Strategic Account Creation Prompt:**
  - Visual: Cloud sync icon with devices (phone, tablet)
  - Text: "Save your progress across devices"
  - Benefits listed:
    - ✓ Sync progress everywhere
    - ✓ Never lose your streak
    - ✓ Unlock achievements
  - **Three options:**
    - [Sign up with Google] - One-tap OAuth
    - [Sign up with Email] - Form below
    - [Continue as Guest] - Small text link at bottom
- **Guest Mode Emphasis:**
  - "You can always create an account later"
  - "Your progress saves locally until then"

**Total Onboarding Time:** 90-120 seconds (fast, low-friction)

**Design Principles:**

- ✅ No skip button until Phase 3 (safety is mandatory)
- ✅ Each phase is single screen (no sub-navigation)
- ✅ Progress indicator dots at bottom (5 dots, current highlighted)
- ✅ Swipe gesture or tap "Next" (user preference)
- ✅ Dark gradient background (calming, not bright white)
- ✅ Minimal text (large, readable, never paragraphs)

---

### Screen 2: Home (Command Central)

**Layout Sections (Top to Bottom):**

**Header (Top):**

```
[AwAir Logo]                    [🔔 Notifications] [⚙️ Settings Icon]

Good morning, Emma! 👋          [Floating Sign-in Button] (if guest)
```

**Quick Stats Cards (3-Column Row):**

```
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│  12         │ │  140        │ │  7 🔥       │
│  Sessions   │ │  Minutes    │ │  Day Streak │
└─────────────┘ └─────────────┘ └─────────────┘
```

- Tappable (expands to full stats in Profile)
- Animated numbers on load (counting up effect)

**Continue Practice Card (Conditional - appears if previous session exists):**

```
┌─────────────────────────────────────────────────┐
│ 🌲 Continue where you left off                 │
│ Forest Dawn · Level 1 · 10 minutes              │
│                                    [▶ Continue] │
└─────────────────────────────────────────────────┘
```

- Tapping resumes last-played track at default duration
- Reduces friction to restart practice

**Level Cards (Main Content - Expandable):**

**Level 1: Foundation (Always Unlocked)**

```
┌─────────────────────────────────────────────────┐
│ LEVEL 1: FOUNDATION 🌿                          │
│ Gentle nature sounds to build awareness         │
│ ───────────────────────────────                │
│ Progress: ●●●●●●○○○○ 6/10 pieces               │
│                                                  │
│ [Tap to Expand ▼]                               │
└─────────────────────────────────────────────────┘
```

**When expanded:**

```
┌─────────────────────────────────────────────────┐
│ LEVEL 1: FOUNDATION 🌿              [Collapse ▲]│
│ Gentle nature sounds to build awareness         │
│ Progress: ●●●●●●○○○○ 6/10 pieces               │
│ ───────────────────────────────────             │
│ Available Tracks:                                │
│                                                  │
│ 🌲 Forest Dawn          10 min    [▶ START]    │
│ 🌊 Ocean Whisper        10 min    [▶ START]    │
│ 🌸 Garden Peace         10 min    [📥 Download] │
│ 🏔️ Mountain Air         10 min    [📥 Download] │
│                                                  │
│ [View All Durations]                             │
└─────────────────────────────────────────────────┘
```

**Design Details:**

- Green checkmark icon (✓) on completed tracks
- Download icon (📥) for uncached tracks (shows file size: "12 MB")
- Bundled tracks show no download needed
- Duration selector expands: 5, 10, 15, 20, 30 minutes
- START button launches Practice Introduction modal immediately

**Level 2: Balance (Unlocks after Level 1 Mandala Complete)**

```
┌─────────────────────────────────────────────────┐
│ LEVEL 2: BALANCE ⚖️               [🔓 Unlocked] │
│ Mixed sounds to build resilience                │
│ Progress: ●●○○○○○○ 2/8 rings                    │
│                                                  │
│ [Tap to Expand ▼]                               │
└─────────────────────────────────────────────────┘
```

- Unlocks with celebratory animation when Level 1 completes
- "NEW" badge for first 3 days after unlock

**Level 3: Mastery (Premium Gated 🔒)**

```
┌─────────────────────────────────────────────────┐
│ LEVEL 3: MASTERY 🔥                  [🔒 Premium]│
│ Intense sounds to achieve equanimity            │
│ Unlock with Premium Presence Pack               │
│                                                  │
│ [Preview 5 Minutes] [Unlock Premium]            │
└─────────────────────────────────────────────────┘
```

- Preview button plays 5-minute sample (bundled)
- Unlock Premium opens paywall modal
- For premium users: shows progress (●●●○○○○ 3/7 stars)

**Personalized Challenges Card:**

```
┌─────────────────────────────────────────────────┐
│ 🎯 YOUR SOUND CHALLENGES                        │
│ Target specific triggers                         │
│                                                  │
│ 🚗 Traffic Noise      🥈 Silver   [Practice]    │
│ 👶 Baby Crying        🥉 Bronze   [Practice]    │
│ 🏗️ Construction       ⚪ Started  [Practice]    │
│                                                  │
│ [+ Add New Challenge]                            │
└─────────────────────────────────────────────────┘
```

- Shows current mastery tier per sound
- Tapping Practice goes directly to Practice screen with that sound mixed in
- Add New Challenge opens sound selection modal (library of 20+ sounds)
- Free users limited to 2 active challenges, premium unlimited

**Bottom Section:**

```
┌─────────────────────────────────────────────────┐
│ 💡 Today's Insight                              │
│ "The space between sounds is where peace lives" │
└─────────────────────────────────────────────────┘

[Explore Learn Section →]
```

**Floating Sign-in Button (Guest Users Only):**

- Small circular button in top-right (if not header)
- Or persistent banner at bottom: "Sign in to sync progress"
- Tapping opens modal with Google/Email options
- Never blocks core functionality

---

### Screen 3: Practice (Direct Level & Track Selection)

**Purpose:** Dedicated screen for browsing all available practice content

**Layout:**

**Header:**

```
[← Back]           Practice Library          [Filter 🔽]
```

**Filter Options (Dropdown):**

- All Levels
- Level 1 Only
- Level 2 Only
- Level 3 Only
- Downloaded Only (offline mode)
- Favorites

**List View (Scrollable):**

Each track as a card:

```
┌─────────────────────────────────────────────────┐
│ 🌲                                              │
│ Forest Dawn                    [❤️ Favorite]   │
│ Level 1 · Gentle · 20 min available             │
│ Birds, breeze, distant stream                   │
│                                                  │
│ Your Stats: 8 sessions · 4.2 avg presence       │
│ ──────────────────────────────────              │
│ Durations: [5] [10] [15] [20] [30]              │
│                               [▶ START PRACTICE] │
└─────────────────────────────────────────────────┘
```

**For Locked Tracks (Level 3):**

```
┌─────────────────────────────────────────────────┐
│ 🔒                                              │
│ Urban Rush                    [Premium Only]    │
│ Level 3 · Intense · 20 min                      │
│ Traffic, horns, sirens, construction, crowds    │
│                                                  │
│ [Preview 5 min] [Unlock Premium]                │
└─────────────────────────────────────────────────┘
```

**Interaction:**

- Tapping duration number selects it (highlights)
- START PRACTICE button → Practice Introduction Modal
- Heart icon toggles favorite status
- Long-press on card → options menu (Download, Remove from Downloaded, Share)

**Alternative View: Grid View (Toggle)**

```
┌──────────┐ ┌──────────┐ ┌──────────┐
│ 🌲       │ │ 🌊       │ │ 🌸       │
│ Forest   │ │ Ocean    │ │ Garden   │
│ Dawn     │ │ Whisper  │ │ Peace    │
│          │ │          │ │ 📥       │
└──────────┘ └──────────┘ └──────────┘
```

- More visual, less detailed
- Good for users who know the library well

---

### Screen 4: Learn (Journal, Articles, Guides)

**Three Tabs (Top Navigation):**

**Tab 1: Reflections (Always Accessible)**

```
┌─────────────────────────────────────────────────┐
│ 📖 Your Practice Journal                        │
│ 47 reflections · 1,240 words                    │
│                                                  │
│ [+ New Entry]                    [Search 🔍]    │
│ ───────────────────────────────                │
│                                                  │
│ Oct 24, 2025 · Forest Dawn · 15 min             │
│ "Today I noticed how resistance creates more... │
│ [Read more]                                      │
│                                                  │
│ Oct 23, 2025 · Park Life · 10 min               │
│ "The traffic sounds felt less jarring. I'm...   │
│ [Read more]                                      │
│                                                  │
│ Oct 22, 2025 · Ocean Whisper · 20 min           │
│ "Twenty minutes flew by. The rhythm of waves... │
│ [Read more]                                      │
└─────────────────────────────────────────────────┘
```

**Reflection Entry Screen (Tapping an entry):**

```
┌─────────────────────────────────────────────────┐
│ [← Back]        Forest Dawn      [⋮ More]       │
│ October 24, 2025 · 15 minutes                   │
│ Presence: ★★★★☆                                 │
│ ───────────────────────────────                │
│                                                  │
│ "Today I noticed how resistance creates more    │
│ suffering than the sounds themselves. When I    │
│ stopped fighting the distant car alarm, it      │
│ became just another texture. The forest sounds  │
│ didn't 'win' - they were all just sounds."      │
│                                                  │
│ Sounds Heard: Bird, Wind, Distant traffic       │
│ Relation: Used as anchor                        │
│ ───────────────────────────────                │
│                                                  │
│ [Edit] [Delete] [Share]                          │
└─────────────────────────────────────────────────┘
```

**Tab 2: Learn (Articles & Guides) - Tiered Unlocking**

**Section A: Getting Started (No Unlock Required)**

```
┌─────────────────────────────────────────────────┐
│ 🌱 Getting Started                              │
│                                                  │
│ 📄 What is AwAir?                    2 min read │
│ Learn the core concepts                         │
│                                      [Read →]   │
│ ───────────────────────────────                │
│ 📄 How to Practice Effectively       3 min read │
│ Tips for your first sessions                    │
│                                      [Read →]   │
│ ───────────────────────────────                │
│ 📄 Understanding the Levels          2 min read │
│ Progression from gentle to intense              │
│                                      [Read →]   │
└─────────────────────────────────────────────────┘
```

**Section B: The Science (Unlocks after 1st session)**

```
┌─────────────────────────────────────────────────┐
│ 🧠 The Science                     [✓ Unlocked] │
│                                                  │
│ 📄 Why Noise Stresses You           4 min read  │
│ The neuroscience of sound and stress            │
│                                      [Read →]   │
│ ───────────────────────────────                │
│ 🎓 The Neuroscience of Acceptance   5 min       │
│ Interactive module with visuals                 │
│                                      [Start →]  │
│ ───────────────────────────────                │
│ 📄 Real Users, Real Transformation  6 min read  │
│ Case studies and testimonials                   │
│                                      [Read →]   │
└─────────────────────────────────────────────────┘
```

**Section C: Advanced Techniques (Unlocks after Level 1 Mandala Complete)**

```
┌─────────────────────────────────────────────────┐
│ 🎯 Advanced Techniques             [🔒 Locked]  │
│ Complete Level 1 to unlock                      │
│                                                  │
│ 📄 From Resistance to Curiosity                 │
│ 📄 Using Challenges Effectively                 │
│ 📄 Integrating Practice into Daily Life         │
└─────────────────────────────────────────────────┘
```

**Article Reading Screen:**

```
┌─────────────────────────────────────────────────┐
│ [← Back]                           [Bookmark]   │
│                                                  │
│ Why Noise Stresses You                          │
│ 4 min read · Science                            │
│ ───────────────────────────────                │
│                                                  │
│ [Hero Image: Brain diagram]                     │
│                                                  │
│ Your brain evolved to treat sudden or unexpected│
│ sounds as potential threats. This triggers your │
│ fight-or-flight response, even when the sound is│
│ harmless.                                        │
│                                                  │
│ ## The Amygdala's Alarm System                  │
│                                                  │
│ [Continues with formatted article text...]      │
│                                                  │
│ ───────────────────────────────────            │
│ Related: The Neuroscience of Acceptance →       │
└─────────────────────────────────────────────────┘
```

**Tab 3: Guides (Quick Reference)**

```
┌─────────────────────────────────────────────────┐
│ 📚 Quick Guides                                 │
│                                                  │
│ 🎧 Audio Setup Tips                             │
│ Best practices for headphones and speakers      │
│ ───────────────────────────────────            │
│ 🧘 Posture & Environment                        │
│ Creating your practice space                    │
│ ───────────────────────────────────            │
│ ⏰ Building a Daily Practice                    │
│ Habit formation strategies                      │
│ ───────────────────────────────────            │
│ 🎯 Working with Trigger Sounds                  │
│ Personalized challenge guide                    │
│ ───────────────────────────────────            │
│ 📊 Understanding Your Analytics                 │
│ Making sense of presence ratings (Premium)      │
└─────────────────────────────────────────────────┘
```

---

### Screen 5: Profile/Settings (Combined - Two Tabs)

**Tab 1: Profile (Stats & Achievements)**

**Header:**

```
┌─────────────────────────────────────────────────┐
│        👤 Emma Thompson                         │
│        emma@email.com                           │
│        [Edit Profile]                           │
│                                                  │
│        Joined Oct 1, 2025 · 23 days             │
│        🔓 Free Account    [Upgrade to Premium]  │
└─────────────────────────────────────────────────┘
```

**Detailed Stats:**

```
┌─────────────────────────────────────────────────┐
│ 📊 YOUR PRACTICE JOURNEY                        │
│ ───────────────────────────────────            │
│ Total Sessions:           47                    │
│ Total Minutes:           624                    │
│ Current Streak:           7 days 🔥             │
│ Longest Streak:          12 days                │
│ Average Presence:        3.8 / 5.0              │
│ Completion Rate:         87%                    │
│ ───────────────────────────────────            │
│ [View Advanced Analytics] (Premium)             │
└─────────────────────────────────────────────────┘
```

**Level Progress Visualizations:**

```
┌─────────────────────────────────────────────────┐
│ 🌸 LEVEL 1: MANDALA GARDEN                      │
│ [Visual: Completed mandala with 10 petals]      │
│ ✓ Complete · 34 sessions · 420 minutes          │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│ 🌊 LEVEL 2: RESONANCE WAVES                     │
│ [Visual: 5 out of 8 concentric rings]           │
│ ●●●●●○○○ 5/8 rings · 13 sessions · 204 min     │
│ Next ring: 21 more minutes                      │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│ ✨ LEVEL 3: PHOENIX CONSTELLATION  [🔒 Premium] │
│ [Visual: Locked constellation outline]          │
│ Unlock with Premium for intense practice        │
│                              [Upgrade]           │
└─────────────────────────────────────────────────┘
```

**Sound Mastery Achievements:**

```
┌─────────────────────────────────────────────────┐
│ 🏆 SOUND MASTERY                                │
│ ───────────────────────────────────            │
│ 🚗 Traffic Noise        🥈 Silver               │
│    18 sessions · 3.7 avg presence               │
│    Next: Gold (12 more sessions)                │
│ ───────────────────────────────────            │
│ 👶 Baby Crying          🥉 Bronze               │
│    8 sessions · 3.2 avg presence                │
│    Next: Silver (7 more sessions)               │
│ ───────────────────────────────────            │
│ [View All Challenges →]                         │
└─────────────────────────────────────────────────┘
```

**Badges & Achievements:**

```
┌─────────────────────────────────────────────────┐
│ 🎖️ ACHIEVEMENTS                                 │
│ 15 unlocked · 23 remaining                      │
│ ───────────────────────────────────            │
│ ✅ First Session                                │
│ ✅ Week Warrior (7-day streak)                  │
│ ✅ Sound Explorer (3+ different tracks)         │
│ ✅ Mandala Master (Level 1 complete)            │
│ ✅ Traffic Bronze (Traffic sound mastery)       │
│ ───────────────────────────────────            │
│ 🔒 Sound Scholar (All levels complete)          │
│    Progress: 2/3 levels                         │
│ 🔒 Sonic Sage (Gold mastery in any sound)       │
│    Progress: Silver in Traffic                  │
│ 🔒 The Unfazed (Platinum in 3 sounds)           │
│    Legendary · Only 1.2% of users have this     │
│ ───────────────────────────────────            │
│ [View All →]                                    │
└─────────────────────────────────────────────────┘
```

**Session History (Last 10):**

```
┌─────────────────────────────────────────────────┐
│ 📅 RECENT SESSIONS                              │
│ ───────────────────────────────────            │
│ Oct 24 · Forest Dawn · 15 min · ★★★★☆          │
│ Oct 23 · Park Life · 10 min · ★★★☆☆            │
│ Oct 22 · Ocean Whisper · 20 min · ★★★★★        │
│ [View Full History →]                           │
└─────────────────────────────────────────────────┘
```

---

**Tab 2: Settings**

**Organized into Sections:**

**Account Section:**

```
┌─────────────────────────────────────────────────┐
│ 👤 ACCOUNT                                      │
│ ───────────────────────────────────            │
│ Email:                    emma@email.com        │
│ [Change Email]                                  │
│ ───────────────────────────────────            │
│ [Change Password]                               │
│ [Sign Out]                                      │
└─────────────────────────────────────────────────┘
```

**Premium/Subscription Section:**

```
┌─────────────────────────────────────────────────┐
│ ✨ PREMIUM PRESENCE PACK                        │
│ Status: Free Account                            │
│ ───────────────────────────────────            │
│ Unlock:                                          │
│ • Level 3: Mastery (intense practice)           │
│ • Unlimited personalized challenges             │
│ • Advanced analytics dashboard                  │
│ • 7 additional TapGames                         │
│ • Exclusive Sound→Form journeys                 │
│                                                  │
│ $3.99/month or $23.99/year (Save 50%)           │
│                                                  │
│ [Start 7-Day Free Trial]                        │
│ [Restore Purchases]                             │
└─────────────────────────────────────────────────┘
```

**For Premium Users:**

```
┌─────────────────────────────────────────────────┐
│ ✨ PREMIUM PRESENCE PACK                        │
│ Status: Active (Annual Plan)                    │
│ Renews: April 15, 2026                          │
│ ───────────────────────────────────            │
│ [Manage Subscription]                           │
│ [Cancel Subscription]                           │
└─────────────────────────────────────────────────┘
```

**Audio Settings:**

```
┌─────────────────────────────────────────────────┐
│ 🔊 AUDIO                                        │
│ ───────────────────────────────────            │
│ Maximum Volume:          [====|---] 65%         │
│ Safety Limit: 70% (Recommended)                 │
│ ───────────────────────────────────            │
│ Fade In Duration:        [==|------] 5 sec      │
│ Fade Out Duration:       [==|------] 5 sec      │
│ ───────────────────────────────────            │
│ Background Playback:     [✓ On]                │
│ Continue when screen locks                      │
└─────────────────────────────────────────────────┘
```

**Notification Settings:**

```
┌─────────────────────────────────────────────────┐
│ 🔔 NOTIFICATIONS                                │
│ ───────────────────────────────────            │
│ Daily Practice Reminder  [✓ On]                │
│ Time: 8:00 AM                [Edit]             │
│ ───────────────────────────────────            │
│ Streak Reminder          [✓ On]                │
│ Reminds if streak at risk                       │
│ ───────────────────────────────────            │
│ Achievement Alerts       [✓ On]                │
│ Celebrate milestones                            │
│ ───────────────────────────────────            │
│ Presence Invitations     [  Off]               │
│ Micro-practice prompts throughout day           │
│ Frequency: Medium        [Change]               │
└─────────────────────────────────────────────────┘
```

**Appearance Settings:**

```
┌─────────────────────────────────────────────────┐
│ 🎨 APPEARANCE                                   │
│ ───────────────────────────────────            │
│ Dark Mode:               ⚪ Auto                │
│                          ○ Light                │
│                          ○ Dark                 │
│ ───────────────────────────────────            │
│ Animation Speed:         ⚪ Normal              │
│                          ○ Slow                 │
│                          ○ Fast                 │
│ ───────────────────────────────────            │
│ Reduce Motion:           [  Off]               │
│ (Accessibility)                                 │
└─────────────────────────────────────────────────┘
```

**Practice Preferences:**

```
┌─────────────────────────────────────────────────┐
│ 🧘 PRACTICE                                     │
│ ───────────────────────────────────            │
│ Default Duration:        10 minutes             │
│ [5] [10] [15] [20] [30]                         │
│ ───────────────────────────────────            │
│ Auto-Play Next Session:  [  Off]               │
│ Chain multiple sessions                         │
│ ───────────────────────────────────            │
│ Show Timer:              [✓ On]                │
│ Hide for immersive practice                     │
│ ───────────────────────────────────            │
│ Quote Frequency:         ⚪ Normal              │
│                          ○ Minimal              │
│                          ○ Frequent             │
│ ───────────────────────────────────            │
│ Skip Practice Intros:    [  Off]               │
│ (After 10 sessions)                             │
└─────────────────────────────────────────────────┘
```

**Data & Storage:**

```
┌─────────────────────────────────────────────────┐
│ 💾 DATA & STORAGE                               │
│ ───────────────────────────────────            │
│ Downloaded Audio:        45 MB                  │
│ 6 tracks cached                                 │
│ [Clear All Cache]                               │
│ ───────────────────────────────────            │
│ Export Practice Data     [Export JSON]          │
│ Download your session history                   │
│ ───────────────────────────────────            │
│ Delete All Data          [Delete]               │
│ ⚠️ Permanent action                             │
└─────────────────────────────────────────────────┘
```

**Support & Legal:**

```
┌─────────────────────────────────────────────────┐
│ ℹ️ SUPPORT & INFO                               │
│ ───────────────────────────────────            │
│ [Help & FAQ]                                    │
│ [Contact Support]                               │
│ [Rate AwAir]                                    │
│ ───────────────────────────────────            │
│ [Privacy Policy]                                │
│ [Terms of Service]                              │
│ ───────────────────────────────────            │
│ App Version: 1.2.0                              │
│ Build: 47 (Android)                             │
└─────────────────────────────────────────────────┘
```

---

## 7. CORE USER FLOWS

### Flow 1: First-Time User → First Practice Session

**Step-by-Step Experience (Emma's Journey):**

**1. App Download & Launch**

- User downloads from Google Play
- App opens to WelcomeOnboarding screen (Phase 1: breathing logo)
- Ambient sound plays automatically (10 seconds)

**2. Onboarding (5 Phases)**

- Phase 1: Welcome (10 seconds auto-advance)
- Phase 2: Value props (user swipes/taps next)
- Phase 3: Tutorial (30-second interactive demo)
- Phase 4: Volume calibration (user adjusts slider, tests)
- Phase 5: Sign-up prompt → user taps "Continue as Guest"

**Total time:** 90-120 seconds

**3. Landing on Home Screen**

- Home screen loads
- Shows: "Welcome! Start your first practice"
- Level 1 card expanded by default
- "Forest Dawn" track highlighted
- 10-minute duration pre-selected

**4. Starting First Practice**

- User taps [▶ START] on Forest Dawn
- **Practice Introduction Modal appears:**

```
┌─────────────────────────────────────────────────┐
│                                       [✕ Close] │
│                                                  │
│           🌲 Forest Dawn                        │
│           Level 1 · 10 minutes                  │
│                                                  │
│                                                  │
│        Close your eyes.                         │
│        Breathe naturally.                       │
│        Listen—without naming.                   │
│                                                  │
│                                                  │
│                                                  │
│                [▶ BEGIN PRACTICE]               │
│                                                  │
│          [✓] Don't show this again              │
│              (after 10 sessions)                │
└─────────────────────────────────────────────────┘
```

- User taps BEGIN PRACTICE
- Modal closes, Practice Session screen loads

**5. Practice Session Screen**

- Screen fades to dark background (forest green gradient)
- Circular timer appears center (10:00)
- Audio begins playing (fade-in 5 seconds)
- Quote appears below timer: "Notice sounds arise and pass. You are the space that holds them."
- Minimal controls at bottom: [❚❚ Pause] [✕ Exit]

**6. During Session (10 minutes)**

- Timer counts down
- Quote changes every 2 minutes (smooth fade transition)
- User closes eyes, listens
- At minute 7: User gets phone call
  - Audio auto-pauses
  - Banner appears: "Session paused. Resume when ready."
  - User declines call
  - Taps [▶ Resume]
  - Audio continues from pause point

**7. Session Completion**

- Timer reaches 0:00
- Audio fades out (5 seconds)
- Gentle chime plays (completion sound)
- Screen transitions to Reflection Screen

**8. Reflection Screen**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│              ✨ Session Complete!               │
│                                                  │
│         You practiced 10 minutes                │
│         Forest Dawn · Level 1                   │
│                                                  │
│ ───────────────────────────────────            │
│                                                  │
│  How present were you?                          │
│                                                  │
│      [1]  [2]  [3]  [4]  [5]                   │
│     Not            Very                          │
│  Present         Present                         │
│                                                  │
│ ───────────────────────────────────            │
│                                                  │
│  What sounds did you notice?                    │
│                                                  │
│  [🐦 Birds] [🌬️ Wind] [🔔 Chimes]              │
│  [🌊 Water] [🍃 Rustling] [Other...]           │
│                                                  │
│ ───────────────────────────────────            │
│                                                  │
│  How did you relate to these sounds?            │
│                                                  │
│  ○ Pushed them away (resisted)                  │
│  ○ Noticed neutrally (observed)                 │
│  ○ Used as anchors (engaged)                    │
│  ○ Felt curious (explored)                      │
│                                                  │
│ ───────────────────────────────────            │
│                                                  │
│  📝 Add notes (optional)                        │
│  [Tap to write...]                              │
│                                                  │
│                                                  │
│              [SUBMIT REFLECTION]                │
│                                                  │
└─────────────────────────────────────────────────┘
```

**User Actions:**

- Taps [4] for presence rating
- Selects: Birds, Wind, Chimes
- Selects: "Noticed neutrally"
- Skips notes field
- Taps SUBMIT REFLECTION

**9. Reward Animation**

- Screen transitions to celebration view
- Mandala outline appears (empty circle)
- First petal/piece animates in (blooming effect, 2 seconds)
- Text appears: "First mandala piece unlocked! 🌸"
- Particle effects briefly
- Text: "9 more pieces to complete Level 1"

**10. TapGame Prompt (Post-Reflection)**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│         🎮 Try a Listening Game?                │
│                                                  │
│   Test your sound awareness with a quick game   │
│                                                  │
│         [▶ PLAY GAME (60 sec)]                  │
│                                                  │
│              [Skip for now]                      │
│                                                  │
└─────────────────────────────────────────────────┘
```

**User taps [Skip for now]**

**11. Return to Home Screen**

- Home screen reloads with updated stats:
  - Sessions: 1
  - Minutes: 10
  - Streak: 1 🔥
- Level 1 card shows: ●○○○○○○○○○ 1/10 pieces
- "Continue Practice" card now appears (Forest Dawn suggested)
- Toast notification: "Great start! Practice again tomorrow to build your streak 🔥"

**Total Flow Duration:** ~15 minutes (onboarding 2 min + practice 10 min + reflection 1 min + navigation 2 min)

**Key Success Factors:**

- ✅ Audio played within 3 seconds of hitting START (bundled asset)
- ✅ Single practice introduction (not overwhelming)
- ✅ Session completed without technical issues
- ✅ Immediate visible reward (mandala piece)
- ✅ TapGame optional (didn't pressure)
- ✅ Clear next step (come back tomorrow)

---

### Flow 2: Returning User → Daily Practice Habit

**Marcus's 3rd Week Experience:**

**1. App Open (Morning)**

- Push notification at 8:00 AM: "Good morning, Marcus! Ready for your practice? 🌅"
- User opens app from notification (deeplinks to Home)
- Home screen shows:
  - Sessions: 18
  - Minutes: 230
  - Streak: 6 days 🔥

**2. Quick Continue**

- "Continue Practice" card visible at top
- Shows: "Park Life · Level 2 · 15 min"
- User taps [▶ Continue]
- Practice Introduction modal appears
- User checks "Don't show this again" (has 18 sessions now)
- Taps BEGIN PRACTICE

**3. Level 2 Practice (First Time)**

- Practice screen loads
- Audio begins (Park Life - more challenging than Level 1)
- Marcus notices: birds + distant traffic + children playing
- At minute 8: Distant siren sound (first challenging element)
- Marcus's initial reaction: slight tension (resisting sound)
- Remembers quote: "Sounds are not the enemy. Your fight with them is."
- Relaxes, allows siren to be present
- Session completes (15 minutes)

**4. Reflection - Level 2 Awareness**

- Presence rating: taps [3] (was harder than Level 1)
- Sounds heard: Birds, Traffic, Voices, Siren
- Sound relation: "Pushed them away" (honest about the siren moment)
- Notes: "Siren triggered me. Working on it."
- Submits

**5. Reward Progress**

- Resonance Waves visual appears
- Second ring animates outward from center (ripple effect)
- Text: "Second wave unlocked! ●●○○○○○○ 2/8 rings"
- Text: "Keep practicing—each wave builds resilience"

**6. TapGame Engagement (This Time He Plays)**

```
┌─────────────────────────────────────────────────┐
│         🎮 Test Your Listening                  │
│                                                  │
│   Today's game: Wave Pulse                      │
│   Tap when you hear wave crashes                │
│                                                  │
│         [▶ PLAY GAME (60 sec)]                  │
│              [Skip]                              │
└─────────────────────────────────────────────────┘
```

**User taps PLAY GAME**

**7. TapGame: Wave Pulse (60 seconds)**

**Game Screen:**

```
┌─────────────────────────────────────────────────┐
│ [← Exit]          Wave Pulse          0:57      │
│                                                  │
│                  Score: 8 / 10                   │
│                                                  │
│                                                  │
│                                                  │
│              🌊 TAP AREA 🌊                     │
│                                                  │
│           [Tap when wave crashes]                │
│                                                  │
│                                                  │
│                                                  │
│  ● ● ● ● ● ○ ○ ○ ○ ○  (events remaining)       │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Gameplay:**

- Ocean wave audio plays
- Wave crash occurs at 5 seconds → User taps (correct, +1)
- Wave at 12 seconds → User taps (correct, +1)
- Wave at 20 seconds → User misses (no penalty, just no point)
- Wave at 28 seconds → User taps early (miss)
- Continues for 60 seconds
- Final score: 8/10 correct

**Game Completion:**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│              🎉 Nice work!                      │
│                                                  │
│              Score: 8 / 10                      │
│              Accuracy: 80%                       │
│                                                  │
│   Your listening awareness is developing!        │
│                                                  │
│         [Play Again] [Done]                     │
│                                                  │
└─────────────────────────────────────────────────┘
```

**User taps Done**

**8. Back to Home**

- Updated stats:
  - Sessions: 19
  - Minutes: 245
  - Streak: 7 days 🔥
- Achievement unlocked popup: "Week Warrior! 🏆 7-day streak"
- Confetti animation
- Badge added to profile

**9. Next Day: Streak at Risk**

- 8:00 PM (user hasn't practiced today)
- Push notification: "Don't break your 7-day streak! Quick 5-minute practice? 🔥"
- User opens app
- Home shows: "Streak at risk! Practice before midnight"
- User completes quick 5-minute Forest Dawn session
- Streak saved: 8 days 🔥

**Flow Patterns Over Time:**

- Week 1: Explores Level 1, builds habit (10 min sessions)
- Week 2: Completes Level 1 mandala, unlocks Level 2 (15 min sessions)
- Week 3: Practices Level 2, tries TapGames occasionally (current)
- Week 4: Approaching Level 2 completion, sees Level 3 preview, considers premium

---

### Flow 3: Premium Conversion → Level 3 Access

**Marcus at Week 5:**

**1. Level 2 Completion**

- User completes 8th wave of Level 2
- Celebration animation: All 8 concentric rings pulse in harmony
- Text: "Resonance Waves Complete! 🌊"
- Text: "You've mastered balanced soundscapes"
- Achievement unlocked: "Wave Master"

**2. Level 3 Teaser (Paywall Trigger)**

Immediately after celebration:

```
┌─────────────────────────────────────────────────┐
│                                                  │
│        🔥 Ready for the Ultimate Challenge?     │
│                                                  │
│         LEVEL 3: MASTERY                        │
│                                                  │
│   Intense urban soundscapes to achieve          │
│   true equanimity in any environment            │
│                                                  │
│   ✓ Urban Rush (traffic, sirens, crowds)        │
│   ✓ Office Chaos (phones, conversations)        │
│   ✓ Transit Hub (trains, announcements)         │
│                                                  │
│          [▶ TRY 5-MINUTE PREVIEW]               │
│                                                  │
│               [Later]                            │
│                                                  │
└─────────────────────────────────────────────────┘
```

**User taps TRY 5-MINUTE PREVIEW**

**3. Level 3 Preview Session**

- Urban Rush preview plays (5 minutes)
- Intense but not overwhelming: traffic, horns, distant construction
- Marcus finds it challenging but manageable
- Session ends at 5:00
- Audio fades
- Message appears: "Want to continue? Unlock the full 20-minute experience"

**4. Paywall Modal (Conversion Moment)**

```
┌─────────────────────────────────────────────────┐
│ [✕]                                             │
│                                                  │
│      ✨ UNLOCK PREMIUM PRESENCE PACK            │
│                                                  │
│  Level 3: Mastery                               │
│  • 3 intense soundscapes (20 min each)          │
│  • Phoenix Constellation reward system          │
│                                                  │
│  Unlimited Personalized Challenges              │
│  • Select up to 10 trigger sounds               │
│  • Custom intensity mixing                      │
│                                                  │
│  7 Additional TapGames                          │
│  • Urban Sounds, Café Chatter, Rain & Thunder   │
│  • Office Ambience, Night Sounds, more...       │
│                                                  │
│  Advanced Analytics Dashboard                   │
│  • Presence trend charts                        │
│  • Weekly progress insights                     │
│  • Sound mastery breakdowns                     │
│                                                  │
│  Exclusive Sound→Form Journeys                  │
│  • 5 additional contemplative experiences       │
│                                                  │
│ ───────────────────────────────────            │
│                                                  │
│  💎 $3.99/month                                 │
│     Billed monthly, cancel anytime              │
│                                                  │
│  💎 $23.99/year (SAVE 50%)                     │
│     Just $1.99/month, best value                │
│                                                  │
│      [START 7-DAY FREE TRIAL]                   │
│                                                  │
│  After trial: $23.99/year unless cancelled      │
│  Manage subscriptions in Settings               │
│                                                  │
│       [Restore Purchases]                       │
│                                                  │
│  [Maybe Later]                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

**5. User Decision Process**

- Marcus reviews features
- Thinks: "I've practiced 24 sessions, this is working"
- Thinks: "I want the analytics to see my progress"
- Thinks: "Annual plan is $2/month, I spend more on coffee"
- Taps START 7-DAY FREE TRIAL
- Selects: Annual plan

**6. Purchase Flow**

- Google Play payment sheet appears
- Confirms: $23.99/year after trial
- Biometric authentication (fingerprint)
- Purchase processes
- Success!

**7. Premium Unlocked Experience**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│          🎉 Welcome to Premium!                 │
│                                                  │
│       All content is now unlocked               │
│                                                  │
│  [Explore Level 3]                              │
│  [Set Up Personalized Challenges]               │
│  [View Advanced Analytics]                      │
│                                                  │
│         [Start Practicing]                      │
│                                                  │
└─────────────────────────────────────────────────┘
```

**User taps Explore Level 3**

**8. Full Level 3 Access**

- Level 3 card now shows unlocked state
- All 3 tracks available (no more preview limit)
- Phoenix Constellation visualization shown (0/7 stars)
- User selects Urban Rush (full 20 minutes)
- Completes challenging but rewarding session
- First star unlocks in constellation
- Marcus is now a paying premium user

**9. Long-term Engagement (Premium Benefits)**

**Week 6:** Sets up personalized challenge (Traffic sounds specifically)
**Week 8:** Achieves Bronze Mastery in Traffic
**Week 10:** Uses Advanced Analytics to see presence rating improved from 3.2 to 4.1
**Week 12:** Completes Phoenix Constellation (7 stars), feels immense accomplishment
**Week 16:** Reaches Gold Mastery in Traffic, shares achievement on social media
**Month 12:** Annual renewal (Marcus doesn't even think about canceling—core part of routine)

**Conversion Success Factors:**

- ✅ Perfect timing (paywall after achievement moment = high motivation)
- ✅ Concrete preview (experienced Level 3 difficulty before buying)
- ✅ Clear value prop (specific features listed, not vague "premium access")
- ✅ Pricing psychology (annual plan "saves 50%" vs monthly)
- ✅ Low-risk trial (7 days to validate before payment)
- ✅ Immediate access (unlocked all content right away, not drip-feed)

---

### Flow 4: Sound→Form Journey Experience

**Sarah's Contemplative Session:**

**1. Discovering Sound→Form**

- Sarah (yoga instructor persona) browsing Practice screen
- Sees special badge on certain tracks: "🎨 Sound→Form Journey"
- Taps on "Forest Dawn (Sound→Form)"
- Description: "Eyes-closed listening followed by visual contemplation"
- Intrigued by Eckhart Tolle-inspired approach
- Selects 20-minute duration

**2. Practice Introduction (Sound→Form Specific)**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│     🎨 Sound→Form Journey                       │
│        Forest Dawn                              │
│                                                  │
│  Close your eyes for the full 20 minutes.       │
│                                                  │
│  Listen without naming or categorizing.          │
│                                                  │
│  After the session, images representing          │
│  what you heard will appear.                    │
│                                                  │
│  Notice the difference between direct            │
│  experience and conceptual knowing.              │
│                                                  │
│            [BEGIN JOURNEY]                       │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Sarah taps BEGIN JOURNEY**

**3. Eyes-Closed Practice (20 Minutes)**

- Screen goes completely black (reduces battery, prevents distraction)
- Optional: "Screen locked to save battery" message
- Audio plays: forest ambience with birds, wind, distant stream, chimes
- Timer hidden (Sarah requested no distractions)
- Only quote appears every 2 minutes (she can open eyes briefly if wants guidance)
- Sarah practices deeply—genuinely not labeling sounds
- Experiences sounds as raw sensory data without mental commentary

**4. Session Completion → Transition**

- Audio fades out
- Black screen remains for 3 seconds (breathing space)
- Text fades in slowly: "Now open your eyes..."
- Text holds for 2 seconds
- Fades out

**5. Sound→Form Image Reveal Sequence**

**Image 1: Cardinal Bird**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│                                                  │
│                                                  │
│          [Illustration: Red Cardinal]            │
│                                                  │
│               Bird chirping                      │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

- Fades in over 1 second
- Holds for 2 seconds
- Fades out

**Sarah's internal reaction:** "Oh! That high-pitched trill I noticed at the beginning. I heard it but didn't label it 'bird' during practice."

**Image 2: Wind Through Trees**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│                                                  │
│                                                  │
│     [Illustration: Leaves rustling in wind]      │
│                                                  │
│              Gentle breeze                       │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

- Fades in, holds, fades out

**Sarah:** "Yes, that constant soft rustling. It was just texture, no words for it."

**Image 3: Distant Stream**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│                                                  │
│          [Illustration: Mountain stream]         │
│                                                  │
│             Water flowing                        │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Sarah:** "That low, continuous sound in the background. I almost didn't notice it consciously."

**Image 4: Wind Chimes**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│                                                  │
│         [Illustration: Hanging chimes]           │
│                                                  │
│              Chimes ringing                      │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Sarah:** "Those occasional metallic tones! I remember them now, but during practice they were just... sounds."

**Sequence completes after all 4 images (total ~10 seconds)**

**6. Contemplative Breathing Space**

- Screen shows slow-breathing circle animation (4-second inhale, 4-second exhale)
- No text, just breathing guide
- 3 breath cycles (~30 seconds)
- Creates space for integration

**7. Deep Reflection Prompt (Sound→Form Specific)**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│  What did you notice about the space            │
│  between sounds and the silence within sound?   │
│                                                  │
│  ┌─────────────────────────────────────────┐   │
│  │ [Tap to write your reflection...]        │   │
│  │                                           │   │
│  │                                           │   │
│  │                                           │   │
│  │                                           │   │
│  │                                           │   │
│  └─────────────────────────────────────────┘   │
│                                                  │
│          [Save to Journal]  [Skip]              │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Sarah writes:**
"The sounds were all happening 'in' awareness, not 'to' me. When the mind didn't label them as 'bird' or 'wind,' they lost their separateness. Everything was just vibration in consciousness. The silence wasn't the absence of sound—it was the space that held all sounds. This is what Tolle means by presence."

**Saves to journal**

**8. Standard Reflection (Quick)**

- Presence rating: [5] (very present)
- Sounds heard: (auto-populated from images shown)
- Sound relation: "Felt curious"
- Submits

**9. TapGame Prompt Appears**

- Sarah taps [Skip] (not interested in gamification after deep practice)
- No judgment, seamless skip

**10. Return to Home**

- Session counted in stats
- Sarah immediately goes to Learn → Reflections
- Re-reads her entry
- Feels deep satisfaction with practice
- Becomes regular Sound→Form practitioner
- Eventually upgrades to Premium for exclusive Sound→Form journeys

**Sound→Form Design Philosophy:**

- **Pre-conceptual experience:** Practice without labeling
- **Visual bridge:** Images help recognize what was heard without conceptualizing during
- **Contemplative space:** Breathing animation and deep prompt honor the practice depth
- **No replay:** Honors the impermanence (sounds arose, passed, can't go back)
- **Optional:** Purists love it, gamification-lovers can skip—both paths respected

---

### Flow 5: Personalized Challenge Setup & Mastery

**Marcus (Week 7) Creating Traffic Challenge:**

**1. Identifying Trigger**

- Marcus realizes traffic sounds specifically trigger his stress
- From Home screen, taps "Your Sound Challenges" card
- Taps [+ Add New Challenge]

**2. Sound Selection Modal**

```
┌─────────────────────────────────────────────────┐
│ [← Back]      Select Trigger Sound              │
│                                                  │
│ Choose a sound you want to build acceptance     │
│ with through targeted practice.                 │
│                                                  │
│ ┌──────────────────────────────────────────┐   │
│ │ [🔍 Search sounds...]                     │   │
│ └──────────────────────────────────────────┘   │
│                                                  │
│ 🏙️ URBAN SOUNDS                                │
│  🚗 Traffic Noise                 [SELECT]      │
│  🚨 Emergency Sirens              [SELECT]      │
│  🚧 Construction                  [SELECT]      │
│  📢 Street Vendors                [SELECT]      │
│                                                  │
│ 👥 VOICES & PEOPLE                              │
│  👶 Baby Crying                   [SELECT]      │
│  🗣️ Conversations                 [SELECT]      │
│  😄 Laughter                      [SELECT]      │
│                                                  │
│ 🏠 DOMESTIC SOUNDS                              │
│  🐕 Dog Barking                   [SELECT]      │
│  📺 TV Background                 [SELECT]      │
│                                                  │
│ [Load More...]                                  │
│                                                  │
│ Free: Select up to 2 sounds                     │
│ Premium: Unlimited (🔓 Upgrade)                 │
└─────────────────────────────────────────────────┘
```

**Marcus taps [SELECT] on Traffic Noise**

**3. Challenge Configuration**

```
┌─────────────────────────────────────────────────┐
│ [← Back]    Traffic Noise Challenge             │
│                                                  │
│  Set your practice parameters                   │
│                                                  │
│  Starting Intensity:                            │
│  ○ Gentle (distant, mixed with nature)          │
│  ⚪ Moderate (present but not overwhelming)      │
│  ○ Challenging (realistic intensity)            │
│                                                  │
│  Session Duration:                              │
│  [5] [10] [15] [20] [30] minutes               │
│  Selected: 10 minutes                           │
│                                                  │
│  Mix with:                                      │
│  ☑ Calming base sounds (forest, ocean)         │
│  ☐ Pure trigger sound only                     │
│                                                  │
│            [CREATE CHALLENGE]                   │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Marcus selects:**

- Moderate intensity
- 10 minutes
- Calming base sounds (checked)
- Taps CREATE CHALLENGE

**4. Challenge Created Confirmation**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│        ✓ Challenge Created!                     │
│                                                  │
│      🚗 Traffic Noise                           │
│                                                  │
│   Practice regularly to build mastery           │
│                                                  │
│   Bronze: 5 sessions (⚪ Not started)           │
│   Silver: 15 sessions                           │
│   Gold: 30 sessions                             │
│   Platinum: 50 sessions                         │
│                                                  │
│         [START FIRST PRACTICE]                  │
│                [Later]                           │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Marcus taps START FIRST PRACTICE**

**5. Challenge Practice Session**

- Practice screen loads (similar to regular practice)
- Audio: Forest base + moderate traffic sounds layered in
- Marcus notices traffic but it's not overwhelming
- Practices acceptance (using Level 2 skills)
- Completes 10 minutes

**6. Challenge-Specific Reflection**

```
┌─────────────────────────────────────────────────┐
│         Traffic Noise Challenge Complete!        │
│                   10 minutes                     │
│                                                  │
│  How present were you with traffic sounds?      │
│      [1]  [2]  [3]  [4]  [5]                   │
│                                                  │
│  Notes about this practice:                     │
│  ┌─────────────────────────────────────────┐   │
│  │ Still some resistance, but I noticed it   │   │
│  │ and relaxed. Progress.                    │   │
│  └─────────────────────────────────────────┘   │
│                                                  │
│           [SUBMIT]                              │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Marcus rates [3], adds note, submits**

**7. Progress Update**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│       Great start! 🚗                           │
│                                                  │
│   Traffic Noise: ⚪ Started                     │
│   1 session · 10 minutes · 3.0 avg presence     │
│                                                  │
│   Next milestone: Bronze (4 more sessions)      │
│                                                  │
│         [Practice Again]  [Done]                │
│                                                  │
└─────────────────────────────────────────────────┘
```

**8. Progression Over Time**

**Week 8 (5 sessions):**

```
🚗 Traffic Noise         🥉 Bronze Mastery!
5 sessions · 50 minutes · 3.2 avg presence
Badge unlocked: "Traffic Aware"
```

**Week 11 (15 sessions):**

```
🚗 Traffic Noise         🥈 Silver Mastery!
15 sessions · 150 minutes · 3.7 avg presence
Badge unlocked: "Traffic Accepted"
Progress: Marcus notices traffic no longer spikes his stress
```

**Week 16 (30 sessions):**

```
🚗 Traffic Noise         🥇 Gold Mastery!
30 sessions · 300 minutes · 4.1 avg presence
Badge unlocked: "Traffic Master"
Achievement: Top 10% of users in this sound
```

**Real-World Impact:**

- Marcus commutes daily through heavy traffic
- Previously: white-knuckled, stressed
- Now: practices presence during actual commute
- Traffic becomes practice opportunity, not torture
- Shares achievement on LinkedIn: "Learned to find peace in chaos with @AwAir"

**9. Profile Showcase**

```
┌─────────────────────────────────────────────────┐
│  🏆 SOUND MASTERY                               │
│  ───────────────────────────────────           │
│  🚗 Traffic Noise        🥇 Gold                │
│     32 sessions · 4.1 avg presence · 18% ↑      │
│     [Practice] [View Analytics]                 │
│  ───────────────────────────────────           │
│  👶 Baby Crying          🥈 Silver              │
│     17 sessions · 3.6 avg presence              │
│  ───────────────────────────────────           │
│  🚧 Construction         🥉 Bronze              │
│     7 sessions · 3.3 avg presence               │
└─────────────────────────────────────────────────┘
```

**Personalized Challenge Success Factors:**

- ✅ Addresses actual user triggers (not theoretical levels)
- ✅ Clear progression system (Bronze → Platinum)
- ✅ Adjustable intensity (meets user where they are)
- ✅ Real-world application (practice translates to life)
- ✅ Social proof (share achievements)
- ✅ Data-driven (see improvement over time)

---

## 8. VISUAL REWARD SYSTEMS

### Level 1: Mandala Garden 🌸

**Metaphor:** Planting seeds of awareness through gentle practice

**Mechanics:**

- 10 pieces total (petals/elements of mandala)
- Unlocks: 1 piece per 10 minutes of practice
- Total completion: 100 minutes (~10 sessions of 10 min each)

**Visual Design:**

**Empty State (0 pieces):**

```
     ╭─────────────────╮
    │    ◯ ◯ ◯ ◯ ◯    │
   │   ◯         ◯   │
  │   ◯     ☐     ◯  │
   │   ◯         ◯   │
    │    ◯ ◯ ◯ ◯ ◯    │
     ╰─────────────────╯
```

- Center square (☐) represents awareness seed
- 10 circles (◯) represent petal positions

**First Piece Unlocked (1/10):**

```
     ╭─────────────────╮
    │    ◯ ◯ ◯ ◯ ◯    │
   │   ◯         ◯   │
  │   ◯     🌸     ◯  │
   │   ◯         ◯   │
    │    ◯ ◯ ◯ ◯ ◯    │
     ╰─────────────────╯
```

- Center petal blooms first (foundation)
- Animation: Unfolds over 2 seconds with particle effects
- Color: Soft green (growth, new beginning)

**Progressive Blooming (5/10):**

```
     ╭─────────────────╮
    │    ◯ 🌸 ◯ 🌸 ◯    │
   │   ◯         ◯   │
  │   🌸    🌸    🌸  │
   │   ◯         ◯   │
    │    ◯ ◯ ◯ ◯ ◯    │
     ╰─────────────────╯
```

- Petals bloom in rotating pattern (not linear)
- Each new piece: unique color variation (greens, blues, golds)
- Pattern creates visual harmony

**Complete Mandala (10/10):**

```
     ╭─────────────────╮
    │    🌸 🌸 🌸 🌸 🌸    │
   │   🌸         🌸   │
  │   🌸    🌸    🌸  │
   │   🌸         🌸   │
    │    🌸 🌸 🌸 🌸 🌸    │
     ╰─────────────────╯
```

- Full geometric floral pattern
- Completion animation: All petals glow simultaneously
- Slow rotation animation (3-second cycle)
- Text: "Level 1 Mastery Complete! 🌸"
- Unlocks: Level 2 access + Achievement badge

**Color Palette:**

- Greens (#7CB342, #9CCC65) - Growth
- Soft blues (#64B5F6, #81C784) - Peace
- Gentle golds (#FFD54F, #FFF176) - Awareness
- Background: Deep forest green gradient

**Animation Sequence (Piece Unlock):**

1. Screen darkens slightly (0.3s)
2. Mandala appears centered (0.5s fade-in)
3. New petal position highlights (0.2s)
4. Petal unfolds from center (1.5s smooth bloom)
5. Particle effects radiate outward (0.8s)
6. Text appears: "Piece 6/10 unlocked! 🌸" (1s fade)
7. Return to home screen (0.5s transition)

**Total animation time:** ~4.8 seconds (satisfying but not tedious)

**Technical Implementation:**

```javascript
// React Native Animated API
const MandalaAnimation = ({ pieceNumber }) => {
  const scale = useRef(new Animated.Value(0)).current;
  const opacity = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.sequence([
      Animated.parallel([
        Animated.spring(scale, {
          toValue: 1,
          tension: 50,
          friction: 7,
        }),
        Animated.timing(opacity, {
          toValue: 1,
          duration: 1500,
        }),
      ]),
      // Particle effects
      Animated.timing(particleRadius, {
        toValue: 100,
        duration: 800,
      }),
    ]).start();
  }, []);

  return (
    <Animated.View
      style={{
        transform: [{ scale }],
        opacity,
      }}
    >
      <MandalaPetal piece={pieceNumber} />
    </Animated.View>
  );
};
```

---

### Level 2: Resonance Waves 🌊

**Metaphor:** Ripples of acceptance spreading outward from center of awareness

**Mechanics:**

- 8 rings total (concentric waves)
- Unlocks: 1 ring per 15 minutes of practice
- Total completion: 120 minutes (~8 sessions of 15 min each)
- Longer intervals reflect increased difficulty

**Visual Design:**

**Empty State (0 rings):**

```
     ╭─────────────────╮
    │                 │
   │                   │
  │         ·          │
   │                   │
    │                 │
     ╰─────────────────╯
```

- Single dot (·) at center = still awareness
- Dark blue gradient background (water surface)

**First Ring (1/8):**

```
     ╭─────────────────╮
    │                 │
   │       ◯           │
  │         ·          │
   │                   │
    │                 │
     ╰─────────────────╯
```

- First ring emanates from center
- Animation: Ripple expands outward over 2s
- Semi-transparent blue-white gradient
- Leaves permanent ring after animation

**Progressive Waves (4/8):**

```
     ╭─────────────────╮
    │     ◯ ◯ ◯ ◯     │
   │   ◯           ◯   │
  │  ◯      ·      ◯  │
   │   ◯           ◯   │
    │     ◯ ◯ ◯ ◯     │
     ╰─────────────────╯
```

- 4 concentric rings visible
- Each ring slightly different opacity (creates depth)
- Subtle shimmer effect on completed rings

**Complete Resonance (8/8):**

```
     ╭─────────────────╮
    │ ◯◯◯ ◯ ◯ ◯ ◯◯◯  │
   │ ◯◯           ◯◯ │
  │ ◯◯     ·     ◯◯ │
   │ ◯◯           ◯◯ │
    │ ◯◯◯ ◯ ◯ ◯ ◯◯◯  │
     ╰─────────────────╯
```

- All 8 rings present
- Completion animation: Synchronized pulse (all rings expand/contract in harmony)
- Particle effects: Water droplets around perimeter
- Text: "Resonance Waves Complete! 🌊"
- Unlocks: Level 3 preview + Premium prompt

**Color Palette:**

- Deep blues (#0D47A1, #1565C0) - Water depths
- Cyan highlights (#00BCD4, #26C6DA) - Wave crests
- Silver-white (#CFD8DC, #ECEFF1) - Light reflection
- Background: Twilight ocean gradient

**Animation Sequence (Ring Unlock):**

1. Screen shows current wave pattern (0.5s)
2. Center dot pulses (0.3s)
3. New wave ripple emanates from center (2.0s)
   - Expands smoothly to final position
   - Fades from bright to permanent opacity
4. Other rings pulse gently in sympathy (0.5s)
5. Particle effects (water droplets) (1.0s)
6. Text: "Ring 5/8 unlocked! 🌊" (1s)
7. Return to home (0.5s)

**Total animation time:** ~5.8 seconds

**Physics-Based Animation:**

```javascript
// Using react-native-reanimated for smooth physics
const WaveRipple = ({ ringNumber }) => {
  const progress = useSharedValue(0);

  useEffect(() => {
    progress.value = withTiming(1, {
      duration: 2000,
      easing: Easing.out(Easing.cubic),
    });
  }, []);

  const animatedStyle = useAnimatedStyle(() => {
    const radius = interpolate(
      progress.value,
      [0, 1],
      [0, ringNumber * 30] // Each ring 30px further out
    );

    const opacity = interpolate(
      progress.value,
      [0, 0.7, 1],
      [0.8, 0.5, 0.3] // Fade as it expands
    );

    return {
      width: radius * 2,
      height: radius * 2,
      borderRadius: radius,
      opacity,
    };
  });

  return <Animated.View style={[styles.ring, animatedStyle]} />;
};
```

**Why Waves Work:**

- Sound IS waves (physics connection)
- Ripple = impact of practice spreading into life
- Water = flow/acceptance metaphor
- Expanding rings = growing capacity
- Visual satisfaction (watching ripples is inherently calming)

---

### Level 3: Phoenix Constellation ✨

**Metaphor:** Rising from chaos to mastery, stars forming constellation of wisdom

**Mechanics:**

- 7 stars total (phoenix shape)
- Unlocks: 1 star per 20 minutes of practice
- Total completion: 140 minutes (~7 sessions of 20 min each)
- Longest intervals reflect greatest challenge
- Premium-only (adds exclusivity)

**Visual Design:**

**Empty State (0 stars):**

```
     ╭─────────────────╮
    │        ·        │
   │     ·     ·     │
  │   ·         ·    │
   │     ·  ·  ·     │
    │                │
     ╰─────────────────╯
```

- Faint star positions visible (dim dots)
- Deep purple-black space background
- No constellation lines (not connected yet)

**First Star (1/7):**

```
     ╭─────────────────╮
    │        ·        │
   │     ·     ·     │
  │   ·         ★    │
   │     ·  ·  ·     │
    │                │
     ╰─────────────────╯
```

- Center star ignites first (foundation)
- Animation: Star burst (flare effect, 1.5s)
- Golden-white glow
- Other positions remain dim

**Progressive Constellation (4/7):**

```
     ╭─────────────────╮
    │        ★        │
   │     ★     ·     │
  │   ·         ★    │
   │     ·  ·  ★     │
    │                │
     ╰─────────────────╯
```

- 4 stars ignited
- Faint lines begin connecting stars (constellation forming)
- Each new star: brief flare then steady glow

**Complete Phoenix (7/7):**

```
     ╭─────────────────╮
    │        ★        │
   │     ★─────★     │
  │   ★─────────★   │
   │     ★──★──★     │
    │       │        │
     ╰─────────────────╯
```

- All 7 stars burning bright
- Constellation lines fully connected (phoenix shape)
- Completion animation:
  1. All stars pulse simultaneously (1s)
  2. Phoenix "flaps wings" (subtle line animation, 2s)
  3. Golden particle effects radiate outward (1.5s)
  4. Text: "Phoenix Constellation Complete! ✨"
  5. Achievement: "Risen from Chaos"
- Subtle animation loop: Stars twinkle, gentle wing flutter

**Color Palette:**

- Deep purples (#311B92, #4A148C) - Night sky
- Gold stars (#FFD700, #FFC107) - Achievement
- White-blue highlights (#E1F5FE, #FFFFFF) - Brilliance
- Constellation lines: Glowing gold (#FFB300)
- Background: Cosmic gradient (deep purple to black)

**Animation Sequence (Star Ignition):**

1. Zoom into star position (0.5s)
2. Spark appears (0.2s)
3. Star burst explosion (1.5s)
   - Rays shoot outward
   - Particles scatter
4. Settle into steady glow (0.5s)
5. If not first star: Constellation line draws to previous star (1.0s)
6. Zoom back out to full constellation (0.5s)
7. Text: "Star 5/7 ignited! ✨" (1s)
8. Return to home (0.5s)

**Total animation time:** ~6.2 seconds

**Particle System:**

```javascript
// Star burst particle effect
const StarBurst = ({ position }) => {
  const particles = Array.from({ length: 20 }, (_, i) => ({
    id: i,
    angle: (Math.PI * 2 * i) / 20,
    distance: useSharedValue(0),
    opacity: useSharedValue(1),
  }));

  useEffect(() => {
    particles.forEach(particle => {
      particle.distance.value = withTiming(100, {
        duration: 1500,
        easing: Easing.out(Easing.quad),
      });
      particle.opacity.value = withTiming(0, {
        duration: 1500,
      });
    });
  }, []);

  return (
    <>
      {particles.map(particle => (
        <Particle key={particle.id} {...particle} />
      ))}
    </>
  );
};
```

**Why Phoenix Works:**

- Transformation mythology (chaos → mastery)
- Rising from fire = intensity of Level 3
- Stars = individual insights gained
- Constellation = integrated understanding
- Premium exclusivity (legendary achievement)
- Cosmic/celestial = elevated consciousness

**Profile Display (Completed Rewards):**

```
┌─────────────────────────────────────────────────┐
│  🌸 Level 1: Mandala Garden                     │
│  [Completed mandala visual - small]             │
│  ✓ 34 sessions · 420 minutes                    │
│  Completed: Oct 15, 2025                        │
├─────────────────────────────────────────────────┤
│  🌊 Level 2: Resonance Waves                    │
│  [Completed waves visual - small]               │
│  ✓ 23 sessions · 304 minutes                    │
│  Completed: Nov 3, 2025                         │
├─────────────────────────────────────────────────┤
│  ✨ Level 3: Phoenix Constellation              │
│  [Completed constellation visual - small]       │
│  ✓ 18 sessions · 287 minutes                    │
│  Completed: Nov 24, 2025                        │
│                                                  │
│  [Share Achievement →]                          │
└─────────────────────────────────────────────────┘
```

---

### Reward System Design Principles

**1. Immediate Feedback**

- Unlock happens within 2 seconds of reflection submission
- No delay between "Submit" and reward animation

**2. Proportional Satisfaction**

- Level 1 pieces = fastest (10 min each) = frequent small wins
- Level 2 rings = moderate (15 min each) = building patience
- Level 3 stars = slowest (20 min each) = rare, precious achievements

**3. Visual Coherence**

- Each level has distinct visual language (nature → water → cosmos)
- Progression tells story: grounding → flowing → transcending

**4. Non-Punitive**

- Never lose progress (no decaying rewards)
- Skipped days don't reset level progress
- Only streak resets (separate metric)

**5. Shareable Moments**

- Completed rewards generate shareable images
- "I completed the Phoenix Constellation in AwAir! 🔥" + image
- Social proof drives organic growth

**6. Technical Performance**

- Animations use native drivers (60fps smooth)
- Particle effects optimized (max 20 particles)
- Cached assets (animations don't lag)

---

## 9. SOUND MASTERY ACHIEVEMENT SYSTEM

### Overview

The Sound Mastery system provides **personalized progression** for users working with specific trigger sounds. Unlike rigid levels, this creates unique paths based on individual needs.

**Core Concept:** Each trigger sound has its own mastery tier progression, similar to:

- **Duolingo's skill tree** (individual skills level up)
- **RPG character stats** (strength, wisdom, etc. improve separately)
- **Martial arts belts** (progression through dedication)

---

### Mastery Tiers (4 Levels per Sound)

**🥉 Bronze Mastery: Awareness**

- **Requirement:** 5 sessions with this sound
- **Average presence:** 2.5+ out of 5
- **Badge:** "{Sound} Aware" (e.g., "Traffic Aware")
- **Meaning:** You've started engaging with this trigger

**🥈 Silver Mastery: Acceptance**

- **Requirement:** 15 sessions with this sound
- **Average presence:** 3.5+ out of 5
- **Duration:** At least 5 sessions of 15+ minutes
- **Badge:** "{Sound} Accepted"
- **Meaning:** You can stay present with this sound consistently

**🥇 Gold Mastery: Integration**

- **Requirement:** 30 sessions with this sound
- **Average presence:** 4.0+ out of 5
- **Duration:** At least 10 sessions of 20 minutes
- **Intensity:** Complete 3 sessions with this sound at HIGH intensity (Level 3 style)
- **Badge:** "{Sound} Master"
- **Meaning:** This sound no longer triggers stress response

**💎 Platinum Mastery: Transcendence**

- **Requirement:** 50 sessions with this sound
- **Average presence:** 4.5+ out of 5
- **Duration:** Complete 5 sessions of 30 minutes
- **Streak:** Practice with this sound for 7 consecutive days
- **Badge:** "{Sound} Zen"
- **Meaning:** Complete equanimity, sound as teacher
- **Rarity:** Top 1% of users achieve this

---

### Available Trigger Sounds (20+ Library)

**Urban Sounds (8):**

- 🚗 Traffic Noise
- 🚨 Emergency Sirens
- 🚧 Construction
- 📢 Street Vendors
- 🚇 Subway/Metro
- 🏙️ City Ambience
- 🚁 Helicopter/Aircraft
- 🛵 Motorcycles

**Voices & People (6):**

- 👶 Baby Crying
- 🗣️ Conversations
- 😄 Laughter
- 📞 Phone Calls
- 👥 Crowds
- 🎤 Public Speaking

**Domestic Sounds (4):**

- 🐕 Dog Barking
- 📺 TV Background
- 🍽️ Kitchen Noises
- 🚪 Door Slamming

**Mechanical (2):**

- ⚙️ Machinery
- 🖨️ Office Equipment

**Freemium Gate:**

- **Free users:** Select up to 2 trigger sounds
- **Premium users:** Unlimited selection (up to 10 active)

---

### Sound Mastery Progression Example

**Marcus's Traffic Noise Journey (12-Week Timeline):**

**Week 1-2: Getting Started**

```
🚗 Traffic Noise
Status: ⚪ Started
Sessions: 3
Minutes: 30
Avg Presence: 2.7
Progress: 60% to Bronze
```

- Marcus completes 3 sessions
- Finds it challenging (ratings: 2, 3, 3)
- Notes: "Hard to relax with horns"

**Week 3: Bronze Achievement**

```
🚗 Traffic Noise
Status: 🥉 Bronze Mastery!
Sessions: 5
Minutes: 50
Avg Presence: 2.8
Badge Unlocked: "Traffic Aware"
Next: Silver (10 more sessions, 3.5+ avg)
```

- Achievement popup with bronze medal animation
- Notification: "You're now aware of traffic sounds without immediate reaction!"

**Week 5-8: Silver Progress**

```
🚗 Traffic Noise
Status: Working toward Silver...
Sessions: 12
Minutes: 135
Avg Presence: 3.4
Progress: 80% to Silver (need 3 more sessions)
```

- Marcus is improving but not consistent
- Some sessions still rated 3, others now 4
- Progress bar shows "almost there"

**Week 9: Silver Achievement**

```
🚗 Traffic Noise
Status: 🥈 Silver Mastery!
Sessions: 15
Minutes: 180
Avg Presence: 3.6
Badge Unlocked: "Traffic Accepted"
Next: Gold (15 more sessions, 4.0+ avg, 3 high-intensity)
```

- Celebration animation with silver medal
- Marcus shares on LinkedIn: "Reached Silver Mastery in traffic sounds with @AwAir. My commute is now meditation time."
- 47 likes, 8 comments

**Week 13-16: Gold Pursuit**

```
🚗 Traffic Noise
Status: Working toward Gold...
Sessions: 27
Minutes: 387
Avg Presence: 3.9
Progress: 90% to Gold
Missing: 3 more sessions + 0.1 higher avg + 2 high-intensity
```

- Marcus is close but needs to challenge himself
- Increases intensity setting to HIGH for next 3 sessions
- Sessions rated 4, 4, 5 (breakthrough moment)

**Week 17: Gold Achievement**

```
🚗 Traffic Noise
Status: 🥇 Gold Mastery!
Sessions: 30
Minutes: 450
Avg Presence: 4.1
Badge Unlocked: "Traffic Master"
Achievement: "Top 10% of users"
Next: Platinum (20 more sessions, 4.5+ avg, 5×30min, 7-day streak)
```

- Gold medal animation with confetti
- Special reward: Unlock "Traffic Wisdom" article in Learn section
- Marcus's commute genuinely transformed (no longer stressed)

**Real-World Impact:**

- Before AwAir: Commute = daily stress (white-knuckle driving)
- After Gold Mastery: Commute = practice opportunity (actual peace)
- Side benefit: Lower blood pressure, better mood at work

---

### Cross-Sound Achievements

These unlock based on mastery across MULTIPLE sounds:

**🏆 Sound Explorer**

- **Requirement:** Practice with 5 different sound types
- **Purpose:** Encourages variety
- **Badge:** "Versatile Practitioner"

**🏆 Adaptive Mind**

- **Requirement:** Achieve Bronze in 3 different sounds
- **Purpose:** Shows well-rounded progress
- **Badge:** "Multi-Sound Awareness"

**🏆 Noise Warrior**

- **Requirement:** Achieve Silver in 5 sounds
- **Purpose:** Demonstrates commitment
- **Badge:** "Resilient Listener"
- **Rarity:** Premium only (need more sounds)

**🏆 Sonic Sage**

- **Requirement:** Achieve Gold in ANY sound
- **Purpose:** Mastery milestone
- **Badge:** "Master of Equanimity"
- **Rarity:** Top 5% of users

**🏆 The Unfazed**

- **Requirement:** Achieve Platinum in 3 sounds
- **Purpose:** Legendary achievement
- **Badge:** "Unshakeable Presence"
- **Rarity:** Top 1% of users (only ~100 users if 10,000 total)
- **Reward:** Featured in "Community Masters" section

---

### Profile Display (Sound Mastery Section)

```
┌─────────────────────────────────────────────────┐
│ 🏆 SOUND MASTERY JOURNEY                        │
│ Overall Mastery Level: 67/100 (Advanced)        │
│ ───────────────────────────────────────        │
│                                                  │
│ 🚗 Traffic Noise              🥇 Gold           │
│ 32 sessions · 480 min · 4.1 avg · 18% ↑        │
│ Next: Platinum (18 more sessions)               │
│ [Practice] [View Trends] [Share]                │
│ ───────────────────────────────────            │
│ 👶 Baby Crying                🥈 Silver         │
│ 18 sessions · 234 min · 3.7 avg · 12% ↑        │
│ Next: Gold (12 more sessions)                   │
│ [Practice] [View Trends]                        │
│ ───────────────────────────────────            │
│ 🚧 Construction               🥉 Bronze         │
│ 7 sessions · 84 min · 3.2 avg · 5% ↑           │
│ Next: Silver (8 more sessions, 0.3 higher avg)  │
│ [Practice] [View Trends]                        │
│ ───────────────────────────────────            │
│ 🐕 Dog Barking                ⚪ Started        │
│ 3 sessions · 30 min · 2.9 avg                   │
│ Next: Bronze (2 more sessions)                  │
│ [Practice]                                      │
│ ───────────────────────────────────            │
│                                                  │
│ [+ Add New Challenge] (0/2 free slots used)     │
│                                                  │
│ 📊 Cross-Sound Achievements:                    │
│ ✅ Sound Explorer (5 sounds)                    │
│ ✅ Adaptive Mind (3 Bronze)                     │
│ ✅ Sonic Sage (1 Gold)                          │
│ 🔒 The Unfazed (Need 3 Platinum)                │
│                                                  │
└─────────────────────────────────────────────────┘
```

---

### Analytics Deep Dive (Per Sound)

**Traffic Noise Trends Screen:**

```
┌─────────────────────────────────────────────────┐
│ [← Back]    🚗 Traffic Noise Analytics          │
│                                                  │
│ 🥇 Gold Mastery · 32 sessions                   │
│ ───────────────────────────────────            │
│                                                  │
│ 📈 PRESENCE EVOLUTION                           │
│ [Line chart showing ratings over time]          │
│ Week 1: 2.7 avg → Week 17: 4.1 avg (+52%)      │
│                                                  │
│ Milestones:                                      │
│ • Week 3: Bronze achieved (2.8 avg)            │
│ • Week 9: Silver achieved (3.6 avg)            │
│ • Week 17: Gold achieved (4.1 avg)             │
│ ───────────────────────────────────            │
│                                                  │
│ ⏱️ PRACTICE DISTRIBUTION                        │
│ [Bar chart: session duration breakdown]         │
│ • 5 min: 4 sessions                             │
│ • 10 min: 18 sessions                           │
│ • 15 min: 7 sessions                            │
│ • 20 min: 3 sessions                            │
│ ───────────────────────────────────            │
│                                                  │
│ 🎯 INTENSITY PROGRESSION                        │
│ • Low: 15 sessions (3.2 avg)                    │
│ • Medium: 14 sessions (4.0 avg)                 │
│ • High: 3 sessions (4.3 avg)                    │
│                                                  │
│ Insight: You handle high intensity well!        │
│ ───────────────────────────────────            │
│                                                  │
│ 📅 STREAK HISTORY                               │
│ Current: 3 days with traffic practice           │
│ Longest: 7 days (Oct 15-21)                     │
│ ───────────────────────────────────            │
│                                                  │
│ 💡 PERSONALIZED RECOMMENDATIONS                 │
│                                                  │
│ • You're ready for Platinum push!               │
│   Try 30-minute sessions this week              │
│                                                  │
│ • Practice best in mornings (4.3 avg)           │
│   vs evenings (3.9 avg)                         │
│                                                  │
│ • Combine with Baby Crying (Silver)             │
│   for multi-trigger challenge                   │
│                                                  │
└─────────────────────────────────────────────────┘
```

---

### Gamification Psychology

**Why Sound Mastery Works:**

**1. RPG Progression System**

- Clear levels (Bronze → Platinum)
- Visible progress bars
- "Level up" dopamine hits
- Long-term goals (Platinum is months away)

**2. Multiple Progression Paths**

- Not one-size-fits-all (choose your triggers)
- Parallel advancement (work on Traffic + Baby simultaneously)
- Completionist appeal (gotta catch 'em all)

**3. Social Proof & Competition**

- Share achievements ("I mastered traffic sounds!")
- Rarity percentages ("Only 5% have Gold")
- Leaderboards (optional Phase 3 feature)

**4. Real-World Application**

- Not arbitrary (Marcus's commute genuinely improved)
- Immediate feedback loop (notice difference in daily life)
- Intrinsic motivation (less stress = reward itself)

**5. Balanced Challenge**

- Bronze: Easy (almost everyone achieves)
- Silver: Moderate (requires commitment)
- Gold: Challenging (requires skill + dedication)
- Platinum: Legendary (rare, aspirational)

---

### Database Schema (Sound Mastery)

```javascript
users/{userId}/progress/challenges/soundMastery/
  traffic: {
    soundId: 'traffic',
    tier: 'gold',
    totalSessions: 32,
    totalMinutes: 480,
    averagePresenceRating: 4.1,
    presenceRatings: [2, 3, 3, 2, 3, 4, 3, 4, 4, 4, 5, ...], // all ratings
    highIntensitySessions: 3,
    longestSession: 20,
    sessionDurations: [10, 10, 15, 10, ...], // all durations
    currentStreak: 3,
    longestStreak: 7,
    lastPracticeDate: timestamp,
    firstPracticeDate: timestamp,
    progressionRate: 18, // percentage improvement
    badges: ['traffic_aware', 'traffic_accepted', 'traffic_master'],
    nextMilestone: {
      tier: 'platinum',
      sessionsNeeded: 18,
      minutesNeeded: 520,
      avgPresenceNeeded: 4.5,
      specialRequirements: ['5_sessions_30min', '7_day_streak'],
    },
    analytics: {
      weeklyAverages: [2.7, 2.8, 3.1, 3.3, 3.4, 3.6, 3.8, 4.0, 4.1],
      timeOfDayPerformance: {
        morning: 4.3,
        afternoon: 4.0,
        evening: 3.9,
        night: 3.7,
      },
      intensityPerformance: {
        low: 3.2,
        medium: 4.0,
        high: 4.3,
      },
    },
  },

  babies_crying: {
    // Same structure
  },
```

---

## 10. TAPGAME DESIGN & IMPLEMENTATION

### Concept Overview

**What is TapGame?**
A 60-90 second **active listening** challenge that bridges passive meditation with engaged awareness training. Users tap when they hear specific sounds, testing recognition accuracy.

### TapGame Philosophy

**Not a Distraction—A Complement:**

- **Passive practice** (regular meditation): Accept sounds without engaging
- **Active practice** (TapGame): Develop discrimination and focus
- **Martial arts analogy:** Meditation = standing meditation (stillness), TapGame = reaction drills (active training)

**Both develop awareness through different approaches.**

---

### The 5 TapGame Types

#### Game 1: BirdTap 🐦

**Objective:** Tap when you hear bird chirps
**Difficulty:** Easy (frequent, distinct sounds)
**Duration:** 60 seconds
**Audio:** Forest ambience with 12-15 bird chirps
**Target events:** Cardinal chirp, Robin song, Crow call

**Gameplay:**

- Forest background plays continuously
- Bird sounds occur every 4-6 seconds (variable timing)
- User taps circular target area when bird heard
- Visual feedback: Green flash = correct, no flash = miss
- Tolerance window: ±300ms around actual bird timestamp

**Scoring:**

- 12 possible bird sounds
- Score: Correct taps / Total birds
- Example: 10/12 = 83% accuracy

**Why this works:**

- Clear, distinct target sounds
- Natural rhythm (not too fast, not too slow)
- Beginner-friendly (builds confidence)

---

#### Game 2: WavePulse 🌊

**Objective:** Tap at the start of wave crashes
**Difficulty:** Easy-Medium (predictable rhythm)
**Duration:** 90 seconds
**Audio:** Ocean soundscape with 10 wave crashes
**Target events:** Wave crest hitting shore

**Gameplay:**

- Continuous ocean background (low rumble)
- Waves crash every 8-10 seconds
- User anticipates rhythm and taps at crash moment
- Tolerance: ±400ms (waves have buildup, harder to pinpoint exact moment)

**Scoring:**

- 10 possible waves
- Bonus points for tapping within ±200ms (perfect timing)
- Example: 8/10 correct, 3 perfect = Score 8.3

**Why this works:**

- Rhythmic pattern develops anticipatory awareness
- Trains listening to sound buildup, not just impact
- Calming audio (doesn't stress user)

---

#### Game 3: SilenceCatch 🤫

**Objective:** Tap when silence/pause occurs (longer than 2 seconds)
**Difficulty:** Medium-Hard (requires sustained attention)
**Duration:** 75 seconds
**Audio:** Variable soundscape (forest transitions to urban transitions back)
**Target events:** 6-8 moments of silence

**Gameplay:**

- Audio alternates: birds → silence → traffic → silence → nature
- Silences last 2-4 seconds each
- User must notice ABSENCE of sound (harder than presence)
- Tolerance: Tap anytime during silence window

**Scoring:**

- 7 possible silence moments
- Must tap during silence, not just after sound stops
- Example: 5/7 = 71% accuracy

**Why this works:**

- Advanced mindfulness skill (noticing space between sounds)
- Trains attention to "negative space"
- Directly relates to meditation insight ("silence within noise")

---

#### Game 4: FootstepBeat 👣

**Objective:** Tap on distinct footstep sounds
**Difficulty:** Medium (moderate frequency)
**Duration:** 60 seconds
**Audio:** Indoor ambience (office/hallway) with footsteps passing
**Target events:** 15-18 individual footstep impacts

**Gameplay:**

- Background: low hum, distant voices
- Footsteps occur in clusters: walk-walk-walk [pause] walk-walk [pause]
- User taps each distinct footstep
- Tolerance: ±250ms

**Scoring:**

- ~16 footsteps average
- Score: Correct / Total
- Example: 13/16 = 81%

**Why this works:**

- Real-world sound (relevant for office workers)
- Rapid succession tests sustained focus
- Variability in rhythm (not metronomic)

---

#### Game 5: WindNote 💨

**Objective:** Tap when wind gusts increase in intensity
**Difficulty:** Hard (subtle changes)
**Duration:** 90 seconds
**Audio:** Continuous wind with 8-10 intensity surges
**Target events:** Wind gust crescendos

**Gameplay:**

- Wind plays throughout (base level)
- Periodically intensifies (volume +30% over 2-3 seconds)
- User taps when gust reaches peak intensity
- Tolerance: ±500ms (volume change is gradual)

**Scoring:**

- 9 possible gusts
- Score: Correct / Total
- Example: 6/9 = 67%

**Why this works:**

- Most difficult (requires detecting gradual change, not discrete event)
- Trains sensitivity to amplitude shifts
- Advanced users love the challenge

---

### Freemium Structure

**Free Users Get:**

- **BirdTap** (unlimited plays)
- **WavePulse** (unlimited plays)
- Access after completing first practice session

**Premium Users Get:**

- **All 5 games** (unlimited plays)
- **SilenceCatch** 🔒
- **FootstepBeat** 🔒
- **WindNote** 🔒
- **Bonus:** Combined challenges (multiple sound types in one game)

**Why this gate works:**

- 2 free games = substantial value (most users satisfied)
- 3 premium games = clear incentive to upgrade
- Difficulty progression: Free games are easier, premium are harder (experienced users want challenge)

---

### TapGame UI Design

**Game Selection Screen (From Home Bottom Tab):**

```
┌─────────────────────────────────────────────────┐
│ [← Home]          🎮 TapGames                   │
│                                                  │
│ Train your listening awareness through active   │
│ sound recognition challenges.                   │
│ ───────────────────────────────────────        │
│                                                  │
│ 🆓 FREE GAMES                                   │
│                                                  │
│ ┌───────────────────────────────────────────┐  │
│ │ 🐦 BirdTap                                 │  │
│ │ Tap when birds chirp · 60 sec · Easy       │  │
│ │ Your Best: 92% · Avg: 85%                  │  │
│ │                             [▶ PLAY]       │  │
│ └───────────────────────────────────────────┘  │
│                                                  │
│ ┌───────────────────────────────────────────┐  │
│ │ 🌊 WavePulse                               │  │
│ │ Tap when waves crash · 90 sec · Easy       │  │
│ │ Your Best: 88% · Avg: 81%                  │  │
│ │                             [▶ PLAY]       │  │
│ └───────────────────────────────────────────┘  │
│                                                  │
│ 🔒 PREMIUM GAMES                                │
│                                                  │
│ ┌───────────────────────────────────────────┐  │
│ │ 🤫 SilenceCatch               [🔒 Premium] │  │
│ │ Notice gaps in sound · 75 sec · Medium     │  │
│ │                         [Unlock Premium]   │  │
│ └───────────────────────────────────────────┘  │
│                                                  │
│ ┌───────────────────────────────────────────┐  │
│ │ 👣 FootstepBeat               [🔒 Premium] │  │
│ │ Tap distinct steps · 60 sec · Medium       │  │
│ │                         [Unlock Premium]   │  │
│ └───────────────────────────────────────────┘  │
│                                                  │
│ ┌───────────────────────────────────────────┐  │
│ │ 💨 WindNote                   [🔒 Premium] │  │
│ │ Catch wind surges · 90 sec · Hard          │  │
│ │                         [Unlock Premium]   │  │
│ └───────────────────────────────────────────┘  │
│                                                  │
│ 📊 [View All Stats]                             │
└─────────────────────────────────────────────────┘
```

---

**Active Game Screen (During Play):**

```
┌─────────────────────────────────────────────────┐
│ [✕ Exit]          🐦 BirdTap            0:47    │
│                                                  │
│                  Score: 8 / 10                   │
│                  Accuracy: 80%                   │
│                                                  │
│                                                  │
│                                                  │
│              ╭───────────╮                      │
│              │           │                       │
│              │           │                       │
│              │    TAP    │  ← Large touch target │
│              │   WHEN    │     (150x150 dp)     │
│              │    YOU    │                       │
│              │   HEAR    │                       │
│              │   BIRDS   │                       │
│              │           │                       │
│              ╰───────────╯                       │
│                                                  │
│                                                  │
│                                                  │
│  ● ● ● ● ● ○ ○ ○ ○ ○  (events remaining)       │
│                                                  │
│  [Animated audio waveform at bottom]            │
│                                                  │
└─────────────────────────────────────────────────┘
```

**UI Elements:**

- **Timer:** Counts down from game duration (60s, 75s, 90s)
- **Score tracker:** Updates in real-time (8/10 correct so far)
- **Tap target:** Large, centered circle (impossible to miss physically)
- **Event dots:** Show how many sounds remain (○ = upcoming, ● = completed)
- **Waveform:** Visual feedback that audio is playing (accessibility)
- **Exit:** Small X in corner (not prominent, reduces accidental quits)

**Visual Feedback on Tap:**

- **Correct tap:** Green ripple animation from tap point + vibration (50ms) + "+1" floats up
- **Early/late tap:** Yellow flash + no points
- **Way-off tap:** No feedback (ignored)

---

**Game Completion Screen:**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│              🎉 Nice work!                      │
│                                                  │
│              🐦 BirdTap                         │
│                                                  │
│              Score: 10 / 12                     │
│              Accuracy: 83%                       │
│                                                  │
│  ───────────────────────────────────           │
│                                                  │
│  Personal Best: 92% (Oct 15)                    │
│  You're improving! (+3% this week)              │
│                                                  │
│  ───────────────────────────────────           │
│                                                  │
│  💡 Tip: Listen for the high-pitched trill      │
│     distinctive to cardinal chirps              │
│                                                  │
│                                                  │
│         [Play Again] [Done]                     │
│                                                  │
│         [Try WavePulse →]                       │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Encouraging microcopy:**

- Never says "You failed" or negative language
- Celebrates progress ("You're improving!")
- Offers actionable tips
- Suggests next game (engagement loop)

---

### Post-Practice TapGame Integration

**Reflection Screen → TapGame Prompt Flow:**

After user submits reflection:

```
┌─────────────────────────────────────────────────┐
│                                                  │
│      Reflection saved! ✓                        │
│                                                  │
│ ───────────────────────────────────────        │
│                                                  │
│      🎮 Quick Awareness Game?                   │
│                                                  │
│  Today's suggestion: WavePulse (90 sec)         │
│  Your last score: 81%                           │
│                                                  │
│         [▶ PLAY GAME]                           │
│                                                  │
│              [Skip]                              │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Selection Algorithm:**

- Randomly choose from 2 games user hasn't played recently
- Bias toward games they perform well in (positive reinforcement)
- If they've played one game 3+ times, suggest a different one (variety)
- Never force (Skip is always prominent)

**For Sarah (Meditation Purist):**

- She always taps [Skip]
- Prompt becomes less prominent after 10 skips (learns her preference)
- After 20 skips, prompt only appears 25% of the time (respects her style)

**For Marcus (Gamification Lover):**

- He plays ~70% of the time
- Prompt stays prominent
- Shows his improvement stats to motivate
- Suggests harder games as his accuracy improves

---

### AI/ML Sound Detection (Technical Implementation)

**Goal:** Automatically detect when target sounds occur in audio for accurate scoring.

**Two-Phase Approach:**

#### **Phase A: Teachable Machine (MVP) - On-Device Inference**

**Training Process:**

1. **Collect sound examples:**

   - BirdTap: 50+ bird chirp samples (various species)
   - WavePulse: 50+ wave crash samples
   - SilenceCatch: Audio segments with/without silence
   - FootstepBeat: 50+ footstep samples
   - WindNote: Wind at various intensities

2. **Use Teachable Machine (Google):**

   - Upload sound examples
   - Label classes: "bird_chirp" vs "background"
   - Train model (takes 5-10 minutes)
   - Export as TensorFlow Lite model

3. **Integrate TFLite in React Native:**

```javascript
import * as tf from '@tensorflow/tfjs';
import { bundleResourceIO } from '@tensorflow/tfjs-react-native';

// Load model
const model = await tf.loadLayersModel(
  bundleResourceIO(
    require('./assets/models/birdtap_model.json'),
    require('./assets/models/birdtap_weights.bin')
  )
);

// Real-time detection during game
const analyzeAudio = async audioBuffer => {
  // Convert audio to spectrogram (TFLite input format)
  const spectrogram = await audioToSpectrogram(audioBuffer);

  // Run inference
  const prediction = await model.predict(spectrogram);
  const confidence = prediction.dataSync()[0];

  // If confidence > 0.7, bird detected
  if (confidence > 0.7) {
    return { detected: true, timestamp: Date.now() };
  }
  return { detected: false };
};
```

**Model Size:** ~3-5MB per game (total 15-25MB for all 5)
**Inference Speed:** <50ms on modern phones
**Accuracy:** 85-90% (sufficient for game enjoyment)

---

#### **Phase B: YAMNet (Scale) - Pre-Processing**

**For production scaling:**

1. **Server-side batch processing:**

   - Upload master audio files to Cloud Storage
   - Cloud Function triggers when new audio uploaded
   - Run YAMNet (Google's pre-trained audio classifier)
   - Generate `events.json` with precise timestamps

2. **Event JSON Example:**

```json
{
  "gameId": "birdtap_forest_v1",
  "duration": 60,
  "events": [
    { "eventId": "bird_chirp", "time": 5.2, "confidence": 0.92 },
    { "eventId": "bird_chirp", "time": 10.8, "confidence": 0.87 },
    { "eventId": "bird_chirp", "time": 16.3, "confidence": 0.91 },
    { "eventId": "bird_chirp", "time": 22.1, "confidence": 0.89 }
    // ... 12 total events
  ]
}
```

3. **Game uses pre-computed timestamps:**

```javascript
// Load events JSON
const events = await fetch('https://storage/.../birdtap_events.json');

// During game, check if user tap matches any event
const checkTap = (tapTime, events) => {
  const matchedEvent = events.find(event => {
    const diff = Math.abs(tapTime - event.time * 1000);
    return diff < TOLERANCE_MS; // 300ms window
  });

  if (matchedEvent) {
    return { correct: true, event: matchedEvent };
  }
  return { correct: false };
};
```

**Advantages:**

- No on-device ML (smaller APK, faster performance)
- Pre-computed = 100% consistent scoring
- Can update events without app update

**Disadvantages:**

- Requires internet first time (caches after)
- Less flexible (can't generate new games on-device)

**Recommendation:** Start with Teachable Machine (Phase A), migrate to YAMNet pre-processing (Phase B) once 10,000+ users.

---

### TapGame Analytics & Progression

**User Stats Tracked:**

```javascript
users/{userId}/tapgames/
  birdtap: {
    gamesPlayed: 47,
    totalScore: 1987, // sum of all correct taps
    totalPossible: 2350, // sum of all possible taps
    averageAccuracy: 84.6, // percentage
    bestAccuracy: 95.8,
    bestScore: 23, // out of 25 in one game
    lastPlayed: timestamp,
    improvementRate: 12, // percentage increase over first 10 games
    consecutivePlays: 3, // current streak
  },
  // ... other games
```

**Insights Generated:**

```
💡 Your BirdTap accuracy improved 18% this month!
💡 You perform best in WavePulse (88% avg)
💡 Try SilenceCatch next—it trains a different skill
💡 Play 3 more games this week to maintain your improvement rate
```

**Achievements:**

- **First Tap:** Complete any TapGame
- **Perfect Game:** 100% accuracy in any game
- **Game Master:** 90%+ average across all 5 games
- **Speed Demon:** Complete 10 games in one day
- **Consistent Player:** Play TapGames 7 days in a row

---

### TapGame Production Pipeline

**Creating a TapGame (Step-by-Step):**

**1. Audio Production (2-3 hours per game):**

- Source background ambience (60-90 seconds)
- Source target sounds (bird chirps, waves, etc.)
- Mix target sounds into ambience at specific timestamps
- Ensure target sounds are:
  - Audible but not overwhelming
  - Spaced 4-10 seconds apart (not too frequent or rare)
  - Varied in pitch/intensity (not identical)
- Export as 64-96 kbps Ogg Vorbis

**2. Manual Timestamp Documentation:**

- Listen through entire audio
- Note exact timestamp of each target sound
- Create events JSON manually
- Format:

```json
{
  "gameId": "birdtap_v1",
  "events": [
    { "time": 5.2, "type": "cardinal" },
    { "time": 10.8, "type": "robin" }
    // ... 12 total
  ]
}
```

**3. Teachable Machine Training (1 hour per game):**

- Collect 50+ examples of target sound
- Collect 50+ examples of background noise
- Train model on Teachable Machine website
- Export TFLite model
- Test accuracy (should be 85%+)

**4. In-App Integration (2 hours per game):**

- Add audio file to assets
- Add events JSON to assets
- Create game config in code
- Test gameplay (play 10 times, verify scoring)
- Adjust tolerance window if needed

**Total Time Per Game:** ~8-10 hours
**Total for 5 Games:** ~40-50 hours

**Parallelization:** 2 people can work simultaneously (one on audio, one on ML training)

---

### TapGame as Premium Conversion Tool

**Data from Similar Apps:**

- Users who engage with gamified features convert at **2-3x higher rate**
- TapGames create "completionist" drive ("I need to master all 5!")
- Locked games visible in UI = constant reminder of premium value

**Conversion Prompt (When Tapping Premium Game):**

```
┌─────────────────────────────────────────────────┐
│              🔒 Premium Game                    │
│                                                  │
│         🤫 SilenceCatch                         │
│                                                  │
│  Unlock all 5 TapGames with Premium             │
│                                                  │
│  ✓ SilenceCatch (notice gaps in sound)          │
│  ✓ FootstepBeat (rapid focus training)          │
│  ✓ WindNote (advanced difficulty)               │
│  ✓ Combined Challenges (multiple sounds)        │
│                                                  │
│  Plus: Level 3, Unlimited Challenges,           │
│  Advanced Analytics, Sound→Form Journeys        │
│                                                  │
│         [Start 7-Day Free Trial]                │
│                                                  │
│                [Maybe Later]                     │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Why this converts:**

- User actively chose to play (high intent signal)
- Curiosity about locked games (what am I missing?)
- Sunk cost (already invested in free games, want full experience)
- Low friction trial (7 days to try all premium games)

---

## 11. SOUND→FORM JOURNEY EXPERIENCE

### Conceptual Foundation

**Inspired by Eckhart Tolle's teachings:**

> "Hearing without the interference of thought—this is pure awareness of sound. When you see an object after hearing it, notice how the mind immediately labels and judges. The practice is to remain in the pre-conceptual space."

**Sound→Form bridges:** Direct sensory experience → Conceptual recognition

---

### The Experience (Detailed Walkthrough)

**Phase 1: Eyes-Closed Practice (Full Duration)**

**Setup:**

- User selects Sound→Form Journey track (marked with 🎨 badge)
- Practice Introduction explains: "Keep eyes closed throughout. Images will appear after."
- Session begins with screen going completely black
- Optional: "Screen locked to save battery" message (reduces drain)

**During Practice:**

- No visual UI (just black screen)
- Audio plays: rich soundscape (forest, ocean, urban, etc.)
- User practices pure listening without naming
- Timer hidden by default (minimizes distraction)
- Quotes appear every 2 minutes (user can briefly open eyes if desired, or keep closed)

**Key Instruction Quote Examples:**

- "Don't name what you hear. Just hear."
- "Sounds arise in awareness. You are the awareness."
- "Notice the space between sounds."

**Screen Lock Support:**

- Android/iOS allows audio to continue when screen locked
- User can lock phone (saves battery, prevents accidental touches)
- Lock screen shows: "Sound→Form Journey in progress"

---

**Phase 2: Transition Moment**

**Session End:**

- Audio fades out over 5 seconds
- Black screen remains for 3 seconds (breathing space)
- Text fades in (white on black):

```
          Now open your eyes...
```

- Holds for 2 seconds
- Fades out

**Significance:** This pause honors the transition from direct experience to conceptual knowing.

---

**Phase 3: Image Reveal Sequence**

**Automatic Sequence (No User Interaction):**

Images appear one at a time in **chronological order** (sequence they occurred during practice).

**Image 1: Cardinal Bird (Occurred at 0:15)**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│                                                  │
│                                                  │
│      [Minimalist illustration: Red cardinal]     │
│               on a branch                        │
│                                                  │
│            Bird chirping                         │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

- **Fade-in:** 1 second (smooth, gentle)
- **Hold:** 2.5 seconds (enough to recognize, not too long)
- **Fade-out:** 1 second
- **Total per image:** 4.5 seconds

**User's Internal Process:**

> "Oh! That was the high-pitched sound at the beginning. I heard it clearly but didn't think 'bird' during practice. It was just... sound."

**Image 2: Wind Through Trees (Occurred at 1:30)**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│                                                  │
│   [Illustration: Leaves rustling, motion lines]  │
│                                                  │
│           Gentle breeze                          │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

**User:** "Yes, that constant soft rustling. It was texture, movement... no label attached."

**Image 3: Distant Stream (Occurred throughout)**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│     [Illustration: Water flowing over rocks]     │
│                                                  │
│            Water flowing                         │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

**User:** "That low, continuous sound in the background. I almost didn't notice it consciously during practice—it was so present it became transparent."

**Image 4: Wind Chimes (Occurred at 8:45, 14:20)**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│      [Illustration: Hanging bamboo chimes]       │
│                                                  │
│           Chimes ringing                         │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

**User:** "Those occasional metallic tones! They stood out but I didn't grasp at them or push them away. They just arose and passed."

**Total Sequence Time:** 4 images × 4.5 seconds = ~18 seconds

---

**Phase 4: Contemplative Integration**

**Breathing Circle Animation:**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│                                                  │
│                                                  │
│               ◯  →  ●  →  ◯                     │
│                                                  │
│          [Expanding/contracting circle]          │
│                                                  │
│           Inhale  (4 sec)                        │
│           Exhale  (4 sec)                        │
│                                                  │
│                                                  │
└─────────────────────────────────────────────────┘
```

- 3 breath cycles (24 seconds total)
- No text, just breathing guide
- Creates space for insight integration
- User processes the revelation: "I heard without thinking"

---

**Phase 5: Deep Reflection Prompt**

**Sound→Form Specific Contemplative Question:**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│  What did you notice about the difference       │
│  between hearing and knowing?                   │
│                                                  │
│  Or:                                             │
│                                                  │
│  What was present in the space between sounds?  │
│                                                  │
│  ┌─────────────────────────────────────────┐   │
│  │ [Tap to write your reflection...]        │   │
│  │                                           │   │
│  │                                           │   │
│  │                                           │   │
│  │                                           │   │
│  │                                           │   │
│  │                                           │   │
│  │                                           │   │
│  └─────────────────────────────────────────┘   │
│                                                  │
│          [Save to Journal]  [Skip]              │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Example User Responses:**

**Sarah (Yoga Instructor):**

> "The sounds were happening 'in' awareness, not 'to' me. When I didn't label them as 'bird' or 'wind,' they lost their separateness. Everything was just vibration in consciousness. The silence wasn't the absence of sound—it was the space that held all sounds."

**Marcus (Software Engineer):**

> "I was shocked how much I heard without consciously labeling. The mind wants to immediately categorize, but in that pre-thought moment, there's just pure experience. This is what mindfulness means."

**Guest User (First Timer):**

> "I thought I was listening during practice, but seeing the images made me realize I was mostly thinking ABOUT listening. Next time I'll try to stay in the hearing itself."

---

**Phase 6: Standard Reflection (Quick)**

After deep prompt, normal reflection questions appear:

```
┌─────────────────────────────────────────────────┐
│  How present were you?                          │
│  [1]  [2]  [3]  [4]  [5]                       │
│                                                  │
│  Sounds heard: [Auto-populated from images]     │
│  ☑ Birds  ☑ Wind  ☑ Water  ☑ Chimes           │
│                                                  │
│  How did you relate to sounds?                  │
│  ⚪ Pushed away                                  │
│  ⚪ Noticed neutrally                            │
│  ⚪ Used as anchors                              │
│  ⚫ Felt curious  ← Pre-selected (Sound→Form    │
│                     encourages curiosity)       │
│                                                  │
│         [SUBMIT]                                │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Note:** "Sounds heard" is auto-populated based on images shown (reduces friction).

---

**Phase 7: TapGame Prompt (Optional, Skippable)**

Same as regular practice, Sarah always skips.

**Phase 8: Return to Home**

Session counted in stats, journal entry saved, user feels profound satisfaction.

---

### Sound→Form Content Library

**Level 1 Sound→Form Journeys (Free):**

1. **Forest Dawn** 🌲

   - Sounds: Birds, breeze, distant stream, chimes
   - Images: 4 minimalist illustrations
   - Theme: Awakening awareness

2. **Ocean Whisper** 🌊
   - Sounds: Waves, seagulls, wind, distant boat horn
   - Images: 4 ocean-themed illustrations
   - Theme: Flow and impermanence

**Level 2 Sound→Form Journeys (Free):** 3. **Garden with City** 🌸🏙️

- Sounds: Birds, bees, distant traffic, airplane, breeze
- Images: 5 mixed nature/urban illustrations
- Theme: Coexistence of peace and noise

**Level 3 Sound→Form Journeys (Premium):** 🔒 4. **Urban Dawn** 🌅

- Sounds: City waking, traffic, voices, construction, birds amidst chaos
- Images: 6 urban illustrations
- Theme: Finding stillness in intensity

**Exclusive Premium Sound→Form Journeys:** 🔒 5. **Desert Night** 🏜️

-**5. Desert Night** 🏜️

- Sounds: Wind over sand, distant coyote, insects, crackling fire
- Images: 5 minimalist desert illustrations
- Theme: Vast spaciousness of awareness

6. **Rainforest Canopy** 🌳

   - Sounds: Rain on leaves, howler monkeys, exotic birds, distant thunder
   - Images: 7 lush jungle illustrations
   - Theme: Abundance and density of life

7. **City at 3am** 🌃

   - Sounds: Empty streets, distant sirens, refrigerator hum, lone footsteps, early morning birds
   - Images: 6 nocturnal urban illustrations
   - Theme: Intimacy with urban solitude

8. **Industrial Port** ⚓

   - Sounds: Ship horns, crane machinery, seagulls, water lapping, loading containers
   - Images: 6 maritime industrial illustrations
   - Theme: Finding meditation in the mechanical

9. **Mountain Temple** ⛰️
   - Sounds: Tibetan bells, wind through peaks, distant chanting, prayer flags fluttering
   - Images: 5 mountain spiritual illustrations
   - Theme: Elevation and transcendence

---

### Image Style Guidelines

**Visual Aesthetic:**

- **Minimalist illustrations** (not photographs)
- **Line art with subtle color** (2-3 colors per image)
- **No text on images** (label appears below)
- **Consistent style** across all journeys (brand coherence)

**Why Minimalist:**

- Doesn't overwhelm after meditative state
- Honors contemplative mood
- Leaves space for user's own experience (not imposing photographer's interpretation)
- Art direction reinforces "essence, not details" philosophy

**Example Visual Direction:**

```
Cardinal Bird:
- Simple line drawing
- Red wash for the bird body
- Black lines for details
- White negative space background
- 3-5 lines total (extremely minimal)
```

**Art Production Options:**

**Option A: Commission Illustrator**

- Hire artist on Dribbble/Behance
- Style reference: Japanese ink wash paintings, minimalist line art
- Cost: $50-100 per image
- Total: ~$2,000-4,000 for all journeys (40 images × $50-100)

**Option B: AI Generation + Manual Refinement**

- Use Midjourney/DALL-E with specific prompts
- Prompt example: "minimalist line drawing of cardinal bird, 3 colors, zen aesthetic, white background --ar 1:1"
- Manually refine in Figma/Illustrator
- Cost: $10-20 per image (time investment)
- Total: ~$400-800 for all journeys

**Option C: Hire Dedicated Artist**

- Contract with single artist for consistency
- Provide style guide and references
- Cost: $1,500-2,500 for entire project
- Recommended for professional launch

---

### Technical Implementation

**Metadata Structure (Per Sound→Form Journey):**

```javascript
soundscapes/forest_dawn_soundform/
  soundscapeId: 'forest_dawn_soundform',
  title: 'Forest Dawn',
  type: 'soundform_journey',
  level: 1,
  duration: 1200, // 20 minutes
  isSoundFormJourney: true,
  bundled: true,

  audioUri: 'audio/level1/forest_dawn_20min.ogg',

  layers: [
    {
      id: 'cardinal_chirp',
      label: 'Bird chirping',
      soundType: 'cardinal',
      timestamps: [15, 90, 145, 280, 360, 480, 600, 720, 900, 1080], // seconds
      image: 'soundform_images/cardinal_red.png',
      imageAlt: 'Minimalist illustration of a red cardinal bird on a branch',
      dominantColor: '#D32F2F', // for fade-in background
    },
    {
      id: 'breeze',
      label: 'Gentle breeze',
      soundType: 'wind',
      timestamps: [30, 120, 240, 360, 480, 600, 720, 840, 960, 1080],
      image: 'soundform_images/wind_leaves.png',
      imageAlt: 'Leaves rustling in wind with motion lines',
      dominantColor: '#7CB342',
    },
    {
      id: 'stream',
      label: 'Distant stream',
      soundType: 'water',
      timestamps: [0, 60, 120, 180, 240, 300, 360, 420, 480, 540], // continuous
      image: 'soundform_images/water_stream.png',
      imageAlt: 'Water flowing over smooth rocks',
      dominantColor: '#64B5F6',
    },
    {
      id: 'chimes',
      label: 'Chimes ringing',
      soundType: 'chime',
      timestamps: [180, 525, 860, 1140],
      image: 'soundform_images/wind_chimes.png',
      imageAlt: 'Hanging bamboo wind chimes',
      dominantColor: '#FFB300',
    },
  ],

  deepPrompts: [
    'What did you notice about the space between sounds?',
    'What was present in the silence within sound?',
    'How did hearing feel before naming occurred?',
    'What difference did you notice between experience and thought?',
  ],

  // Randomly select one deep prompt per session
```

---

**React Native Implementation (Image Reveal):**

```javascript
const SoundFormReveal = ({ layers, sessionDuration }) => {
  const [currentImageIndex, setCurrentImageIndex] = useState(-1);
  const [showBreathing, setShowBreathing] = useState(false);
  const fadeAnim = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    revealSequence();
  }, []);

  const revealSequence = async () => {
    // Initial transition message
    await showTransitionText();

    // Show each image in order
    for (let i = 0; i < layers.length; i++) {
      setCurrentImageIndex(i);
      await animateImage();
      await delay(2500); // Hold time
      await fadeOutImage();
    }

    // Breathing integration
    setShowBreathing(true);
    await delay(24000); // 3 breath cycles
    setShowBreathing(false);

    // Navigate to deep reflection
    navigation.navigate('DeepReflection', { layers, sessionDuration });
  };

  const showTransitionText = () => {
    return new Promise(resolve => {
      Animated.sequence([
        Animated.timing(fadeAnim, {
          toValue: 1,
          duration: 1000,
        }),
        Animated.delay(2000),
        Animated.timing(fadeAnim, {
          toValue: 0,
          duration: 1000,
        }),
      ]).start(resolve);
    });
  };

  const animateImage = () => {
    fadeAnim.setValue(0);
    return new Promise(resolve => {
      Animated.timing(fadeAnim, {
        toValue: 1,
        duration: 1000,
        useNativeDriver: true,
      }).start(resolve);
    });
  };

  const fadeOutImage = () => {
    return new Promise(resolve => {
      Animated.timing(fadeAnim, {
        toValue: 0,
        duration: 1000,
        useNativeDriver: true,
      }).start(resolve);
    });
  };

  return (
    <View style={styles.container}>
      {currentImageIndex === -1 && (
        <Animated.View style={{ opacity: fadeAnim }}>
          <Text style={styles.transitionText}>Now open your eyes...</Text>
        </Animated.View>
      )}

      {currentImageIndex >= 0 && !showBreathing && (
        <Animated.View style={{ opacity: fadeAnim }}>
          <Image
            source={{ uri: layers[currentImageIndex].image }}
            style={styles.image}
            resizeMode="contain"
          />
          <Text style={styles.label}>{layers[currentImageIndex].label}</Text>
        </Animated.View>
      )}

      {showBreathing && <BreathingCircle />}
    </View>
  );
};
```

---

**Breathing Circle Component:**

```javascript
const BreathingCircle = () => {
  const scale = useRef(new Animated.Value(0.5)).current;
  const [phase, setPhase] = useState('inhale');

  useEffect(() => {
    breathCycle();
  }, []);

  const breathCycle = () => {
    // Inhale (expand)
    setPhase('inhale');
    Animated.timing(scale, {
      toValue: 1,
      duration: 4000,
      easing: Easing.inOut(Easing.ease),
      useNativeDriver: true,
    }).start(() => {
      // Exhale (contract)
      setPhase('exhale');
      Animated.timing(scale, {
        toValue: 0.5,
        duration: 4000,
        easing: Easing.inOut(Easing.ease),
        useNativeDriver: true,
      }).start(breathCycle); // Loop
    });
  };

  return (
    <View style={styles.breathingContainer}>
      <Animated.View
        style={[styles.breathingCircle, { transform: [{ scale }] }]}
      />
      <Text style={styles.breathingLabel}>
        {phase === 'inhale' ? 'Breathe in' : 'Breathe out'}
      </Text>
    </View>
  );
};
```

---

### Sound→Form Analytics (User Insights)

**Tracked Data:**

```javascript
users/{userId}/soundform/
  totalJourneys: 23,
  favoriteJourney: 'forest_dawn',
  deepReflectionsWritten: 18, // vs 23 total = 78% write reflections
  averageReflectionWordCount: 87,
  longestReflection: 234, // words

  journeyHistory: [
    {
      journeyId: 'forest_dawn',
      completedAt: timestamp,
      duration: 1200,
      deepReflectionSubmitted: true,
      reflectionWordCount: 95,
      presenceRating: 5,
    },
    // ...
  ],

  insights: {
    preferredDuration: 20, // minutes
    mostInsightfulTime: 'morning', // when they write longest reflections
    improvementInPresence: 23, // percentage increase in ratings
  },
```

**Generated Insights (Premium Analytics):**

```
💡 Your Sound→Form presence ratings average 4.6
   (vs 4.1 in regular practice)

💡 You write 2x longer reflections after Sound→Form journeys
   (87 words vs 43 words)

💡 Morning Sound→Form sessions produce your deepest insights

💡 You've completed 23 journeys—consider the premium
   "Mountain Temple" journey for your next practice
```

---

### Sound→Form as Premium Value Driver

**Free Users Get:**

- 2 Sound→Form journeys (Forest Dawn, Ocean Whisper)
- Experience the core concept
- Access to basic reflection prompts

**Premium Users Get:**

- 7 additional exclusive journeys
- Curated themed collections ("Urban Zen," "Nature's Symphony")
- Extended image sequences (7-8 images vs 4-5)
- Advanced contemplative prompts
- Reflection analytics (word clouds, theme tracking)

**Why This Converts:**

- Sound→Form is AwAir's **unique differentiator** (no competitor has this)
- Free taste creates desire for full experience
- Contemplative users (highest LTV) value this deeply
- Premium journeys framed as "deepening your practice" (not just "more content")

---

### Design Philosophy Summary

**Sound→Form embodies:**

1. **Pre-conceptual awareness:** Hearing without naming
2. **Insight through recognition:** "I heard that without thinking!"
3. **Bridging direct experience and knowledge:** Honoring both
4. **Contemplative depth:** Not just relaxation, actual wisdom
5. **Visual poetry:** Images as gentle teachers, not distractions
6. **Respect for practice:** No forced interaction during reveal

**This feature attracts:**

- Experienced meditators seeking depth
- Eckhart Tolle readers
- Mindfulness teachers
- Philosophy students
- Anyone tired of superficial meditation apps

**User testimonial (real beta tester quote):**

> "I've used Headspace, Calm, Insight Timer for years. Sound→Form is the first thing that actually deepened my understanding of what presence means. I cried during the Urban Dawn journey—finally found peace with city noise after 10 years of resistance."

---

## 12. AI/ML SOUND DETECTION ARCHITECTURE

### Overview & Requirements

**Goal:** Accurately detect when specific sounds occur in audio for two primary use cases:

1. **TapGame scoring:** Validate user taps against actual sound events
2. **Sound→Form metadata:** Timestamp sounds for image reveal sequence

**Constraints:**

- Must be **free or low-cost** (no expensive ML APIs)
- Should work **on-device** for TapGame real-time feedback (Phase A)
- Can use **server-side pre-processing** for Sound→Form (Phase B)
- Android-first (TensorFlow Lite well-supported)

---

### Phase A: Teachable Machine (MVP - Real-Time On-Device)

**Best for:** TapGames where immediate feedback required

#### Step 1: Collect Training Data

**Per TapGame (e.g., BirdTap):**

**Positive Examples (Target Sound):**

- Collect 50-100 audio clips of bird chirps (2-3 seconds each)
- Sources:
  - Freesound.org: Search "bird chirp" → download CC0 samples
  - Extract from existing soundscapes (isolate bird moments)
  - Record own sounds (if possible)
- Variety matters:
  - Different bird species (cardinal, robin, sparrow)
  - Different pitches and durations
  - Different recording qualities

**Negative Examples (Background Noise):**

- Collect 50-100 clips of forest ambience WITHOUT birds
- Wind, rustling leaves, distant water, etc.
- This teaches model: "This is NOT a bird"

**Organization:**

```
training_data/
├── birdtap/
│   ├── positive/
│   │   ├── cardinal_chirp_01.wav
│   │   ├── robin_song_02.wav
│   │   ├── sparrow_tweet_03.wav
│   │   └── ... (50 total)
│   ├── negative/
│   │   ├── forest_ambience_01.wav
│   │   ├── wind_rustling_02.wav
│   │   ├── distant_water_03.wav
│   │   └── ... (50 total)
```

---

#### Step 2: Train Model with Teachable Machine

**Process (No Coding Required):**

1. **Go to:** teachablemachine.withgoogle.com
2. **Choose:** Audio Project
3. **Create Classes:**
   - Class 1: "Bird" (upload 50 positive examples)
   - Class 2: "Background" (upload 50 negative examples)
4. **Train Model:**
   - Click "Train Model" (takes 5-10 minutes)
   - Adjusts parameters automatically
   - Shows accuracy metrics (aim for 85%+)
5. **Test with Microphone:**
   - Play bird sounds → should detect "Bird"
   - Play forest ambience → should detect "Background"
   - Refine if accuracy low (add more examples)
6. **Export:**
   - Select "TensorFlow Lite"
   - Download: `model.tflite` (3-5MB file)

**Repeat for all 5 TapGames:**

- BirdTap model (3.2 MB)
- WavePulse model (3.8 MB)
- SilenceCatch model (2.9 MB)
- FootstepBeat model (4.1 MB)
- WindNote model (3.5 MB)

**Total model size:** ~17.5 MB (acceptable for app assets)

---

#### Step 3: Integrate TFLite in React Native

**Install TensorFlow.js for React Native:**

```bash
npm install @tensorflow/tfjs @tensorflow/tfjs-react-native
expo install expo-gl
```

**Load Model:**

```javascript
import * as tf from '@tensorflow/tfjs';
import { bundleResourceIO } from '@tensorflow/tfjs-react-native';
import * as FileSystem from 'expo-file-system';

// Initialize TensorFlow
await tf.ready();

// Load TFLite model
const modelPath = FileSystem.bundleDirectory + 'models/birdtap_model.tflite';
const model = await tf.loadGraphModel(modelPath);
```

**Real-Time Audio Analysis:**

```javascript
const analyzeAudioFrame = async audioBuffer => {
  // Convert audio buffer to spectrogram (model input format)
  const spectrogram = await audioBufferToSpectrogram(audioBuffer);

  // Run inference
  const inputTensor = tf.tensor(spectrogram);
  const prediction = await model.predict(inputTensor);
  const confidence = prediction.dataSync()[0]; // Probability of "Bird" class

  // Cleanup tensors (prevent memory leak)
  inputTensor.dispose();
  prediction.dispose();

  return confidence;
};

// During TapGame
const checkForSound = async () => {
  const confidence = await analyzeAudioFrame(currentAudioFrame);

  if (confidence > 0.7) {
    // Bird detected!
    currentEventActive = true;
  } else {
    currentEventActive = false;
  }
};

// When user taps
const handleTap = () => {
  if (currentEventActive) {
    score++;
    showCorrectFeedback();
  } else {
    showMissFeedback();
  }
};
```

**Audio Buffer to Spectrogram Conversion:**

```javascript
// TFLite expects mel-spectrogram input
const audioBufferToSpectrogram = async audioBuffer => {
  // Use TensorFlow's audio processing utilities
  const spectrogram = tf.signal.stft(
    audioBuffer,
    frameLength, // 512 samples
    frameStep // 256 samples
  );

  // Convert to mel scale
  const melSpectrogram = tf.signal.melSpectrogram({
    spectrogram,
    sampleRate: 44100,
    numMelBins: 40, // Teachable Machine default
  });

  return melSpectrogram.arraySync();
};
```

---

#### Step 4: Optimization & Performance

**Challenges:**

- **Inference latency:** Each prediction takes 20-50ms
- **Battery drain:** Continuous analysis uses CPU
- **Memory usage:** Audio buffers + tensors accumulate

**Solutions:**

**1. Frame-Based Analysis (Not Continuous):**

```javascript
// Instead of analyzing every millisecond
// Analyze every 200ms (5 frames per second)
setInterval(() => {
  analyzeAudioFrame(getCurrentAudioFrame());
}, 200);
```

**2. Confidence Threshold Tuning:**

```javascript
// Higher threshold = fewer false positives, harder game
// Lower threshold = more false positives, easier game
const CONFIDENCE_THRESHOLD = 0.7; // Adjust based on playtesting
```

**3. Tensor Disposal (Memory Management):**

```javascript
// CRITICAL: Always dispose tensors after use
inputTensor.dispose();
prediction.dispose();

// Or use tf.tidy() to auto-dispose
const confidence = tf.tidy(() => {
  const input = tf.tensor(spectrogram);
  const pred = model.predict(input);
  return pred.dataSync()[0];
});
```

**4. Model Quantization (Reduce Size):**

```javascript
// During TFLite export, enable quantization
// Reduces model from 5MB → 1.5MB with minimal accuracy loss
// Option in Teachable Machine export settings
```

---

### Phase B: YAMNet (Server-Side Pre-Processing)

**Best for:** Sound→Form metadata generation (offline, not real-time)

#### What is YAMNet?

**YAMNet** (Yet Another Mobile Network) is Google's pre-trained audio classification model trained on **AudioSet** (2 million+ labeled sounds, 521 categories).

**Advantages:**

- Already trained (no custom training needed)
- Detects 521 sound classes (birds, water, traffic, speech, music, etc.)
- High accuracy (state-of-the-art as of 2024)
- Open-source (Apache 2.0 license)

**Use Case:**
Upload master audio file → YAMNet analyzes → Generates timestamps → Save as JSON → App uses JSON for Sound→Form reveal

---

#### YAMNet Implementation (Google Cloud Function)

**Architecture:**

```
Master Audio Upload (Cloud Storage)
    ↓
Cloud Function Triggers (on file upload)
    ↓
YAMNet Analysis (Python)
    ↓
Generate events.json with timestamps
    ↓
Save to Cloud Storage
    ↓
App downloads JSON when needed
```

**Cloud Function (Python):**

```python
import tensorflow as tf
import tensorflow_hub as hub
import numpy as np
from google.cloud import storage
import json

# Load YAMNet model
yamnet_model = hub.load('https://tfhub.dev/google/yamnet/1')

def analyze_audio(event, context):
    """Triggered by file upload to Cloud Storage"""

    file_name = event['name']
    bucket_name = event['bucket']

    # Download audio file
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)
    audio_path = f'/tmp/{file_name}'
    blob.download_to_filename(audio_path)

    # Load audio
    wav_data = tf.io.read_file(audio_path)
    audio, sample_rate = tf.audio.decode_wav(wav_data)
    audio = tf.squeeze(audio, axis=-1)  # Mono

    # Run YAMNet
    scores, embeddings, spectrogram = yamnet_model(audio)

    # Extract events (sounds with confidence > 0.5)
    events = []
    class_names = yamnet_model.class_names

    for i, frame_scores in enumerate(scores):
        timestamp = i * 0.48  # YAMNet analyzes in 0.48s frames

        # Find top predicted class
        top_class = tf.argmax(frame_scores).numpy()
        confidence = frame_scores[top_class].numpy()

        if confidence > 0.5:
            events.append({
                'time': timestamp,
                'eventId': class_names[top_class],
                'confidence': float(confidence)
            })

    # Group similar consecutive events (reduce noise)
    grouped_events = group_events(events)

    # Save as JSON
    output_json = {
        'soundscapeId': file_name.replace('.wav', ''),
        'duration': len(audio) / sample_rate,
        'events': grouped_events
    }

    json_blob = bucket.blob(file_name.replace('.wav', '_events.json'))
    json_blob.upload_from_string(json.dumps(output_json))

    print(f'Generated {len(grouped_events)} events for {file_name}')

def group_events(events, tolerance=2.0):
    """Combine consecutive similar events within tolerance seconds"""
    if not events:
        return []

    grouped = []
    current_group = [events[0]]

    for event in events[1:]:
        if (event['eventId'] == current_group[0]['eventId'] and
            event['time'] - current_group[-1]['time'] < tolerance):
            current_group.append(event)
        else:
            # Save group as single event (average timestamp, max confidence)
            grouped.append({
                'time': sum(e['time'] for e in current_group) / len(current_group),
                'eventId': current_group[0]['eventId'],
                'confidence': max(e['confidence'] for e in current_group)
            })
            current_group = [event]

    # Add last group
    grouped.append({
        'time': sum(e['time'] for e in current_group) / len(current_group),
        'eventId': current_group[0]['eventId'],
        'confidence': max(e['confidence'] for e in current_group)
    })

    return grouped
```

**Deploy to Google Cloud Functions:**

```bash
gcloud functions deploy analyze_audio \
  --runtime python39 \
  --trigger-resource awair-audio-masters \
  --trigger-event google.storage.object.finalize \
  --memory 2048MB \
  --timeout 540s
```

---

#### YAMNet Output Example

**Input:** `forest_dawn_20min.wav` (1200 seconds)

**Output:** `forest_dawn_20min_events.json`

```json
{
  "soundscapeId": "forest_dawn_20min",
  "duration": 1200,
  "events": [
    {
      "time": 5.3,
      "eventId": "Bird vocalization, bird call, bird song",
      "confidence": 0.87
    },
    {
      "time": 12.1,
      "eventId": "Wind",
      "confidence": 0.62
    },
    {
      "time": 18.7,
      "eventId": "Bird vocalization, bird call, bird song",
      "confidence": 0.91
    },
    {
      "time": 25.0,
      "eventId": "Water",
      "confidence": 0.71
    },
    {
      "time": 34.2,
      "eventId": "Chime",
      "confidence": 0.68
    }
    // ... hundreds more events
  ]
}
```

---

#### App Integration (Using Pre-Computed Events)

**Sound→Form Image Reveal:**

```javascript
// Load events JSON
const eventsUrl = `https://storage.googleapis.com/awair-audio/forest_dawn_events.json`;
const response = await fetch(eventsUrl);
const eventsData = await response.json();

// Filter for relevant sound types
const relevantSounds = ['Bird', 'Wind', 'Water', 'Chime'];
const filteredEvents = eventsData.events.filter(event =>
  relevantSounds.some(sound => event.eventId.includes(sound))
);

// Group by sound type
const groupedBySoundType = {
  bird: filteredEvents.filter(e => e.eventId.includes('Bird')),
  wind: filteredEvents.filter(e => e.eventId.includes('Wind')),
  water: filteredEvents.filter(e => e.eventId.includes('Water')),
  chime: filteredEvents.filter(e => e.eventId.includes('Chime')),
};

// Create layers for Sound→Form
const layers = [
  {
    id: 'bird',
    label: 'Bird chirping',
    timestamps: groupedBySoundType.bird.map(e => e.time),
    image: 'soundform_images/cardinal.png',
  },
  {
    id: 'wind',
    label: 'Gentle breeze',
    timestamps: groupedBySoundType.wind.map(e => e.time),
    image: 'soundform_images/wind_leaves.png',
  },
  // ... etc
];
```

---

### Hybrid Approach (Recommended Production Strategy)

**TapGames:**

- Use **Teachable Machine** on-device (real-time feedback required)
- Models trained on specific game sounds
- Fast inference (20-50ms)
- Works offline

**Sound→Form:**

- Use **YAMNet** server-side pre-processing
- Analyzes master audio once during production
- Generates high-quality timestamp metadata
- App downloads JSON (small file, ~10-50KB)

**Why Hybrid:**

- TapGames need immediate feedback (can't wait for server)
- Sound→Form timestamps generated once (no need for real-time)
- Reduces on-device model size (only 5 TapGame models, not general classifier)
- Server-side YAMNet more accurate than Teachable Machine

---

### Cost Analysis

**Teachable Machine (Phase A):**

- **Training:** Free (runs in browser)
- **Hosting models:** Bundled in app (no hosting cost)
- **Inference:** On-device (no API calls)
- **Total cost:** $0

**YAMNet on Google Cloud Functions (Phase B):**

- **Cloud Function invocations:** 1 per master audio file = ~10-20 invocations total
- **Compute time:** ~30-60 seconds per 20-minute audio file
- **Storage:** ~50KB JSON per audio file
- **Monthly cost:** <$1 (well within free tier)

**Alternative:** Run YAMNet locally on development machine instead of Cloud Functions (totally free, just slower workflow).

---

### Accuracy & Quality Assurance

**TapGame Accuracy Testing:**

```javascript
// Automated test script
const testModel = async (modelPath, testAudioFiles) => {
  const model = await loadModel(modelPath);
  let correctDetections = 0;
  let falsePositives = 0;
  let missedDetections = 0;

  for (const testFile of testAudioFiles) {
    const { audio, groundTruth } = testFile; // groundTruth = manual timestamps

    for (let t = 0; t < audio.duration; t += 0.2) {
      const frame = extractAudioFrame(audio, t);
      const prediction = await model.predict(frame);

      const shouldDetect = groundTruth.some(
        timestamp => Math.abs(timestamp - t) < 0.3
      );

      if (prediction.confidence > 0.7 && shouldDetect) {
        correctDetections++;
      } else if (prediction.confidence > 0.7 && !shouldDetect) {
        falsePositives++;
      } else if (prediction.confidence <= 0.7 && shouldDetect) {
        missedDetections++;
      }
    }
  }

  const accuracy = correctDetections / (correctDetections + missedDetections);
  const precision = correctDetections / (correctDetections + falsePositives);

  console.log(`Accuracy: ${(accuracy * 100).toFixed(1)}%`);
  console.log(`Precision: ${(precision * 100).toFixed(1)}%`);

  return { accuracy, precision };
};
```

**Target Metrics:**

- **Accuracy:** 85%+ (detects sounds that are actually there)
- **Precision:** 80%+ (doesn't falsely detect sounds that aren't there)
- **Latency:** <50ms (imperceptible to user)

**If metrics fail:**

1. Add more training examples (especially edge cases)
2. Adjust confidence threshold
3. Improve audio quality of training data
4. Use data augmentation (pitch shift, time stretch training samples)

---

## 13. STATE MANAGEMENT ARCHITECTURE

### Context API Implementation (Phase 1 MVP)

React Context provides a way to share data across components without manually passing props through every level ("prop drilling").

**AwAir uses 5 contexts:**

---

### 1. AuthContext (Identity Manager)

**Responsibility:** Who is the current user?

**State:**

```javascript
{
  user: {
    uid: string | null,
    email: string | null,
    displayName: string | null,
    isGuest: boolean,
    isPremium: boolean,
    premiumExpiresAt: timestamp | null,
  },
  loading: boolean, // true during auth check
  error: string | null
  }
```

**Actions:**

```javascript
{
  signUp: (email, password) => Promise<void>,
  signIn: (email, password) => Promise<void>,
  signInWithGoogle: () => Promise<void>,
  signOut: () => Promise<void>,
  continueAsGuest: () => Promise<void>,
  upgradeGuestToAccount: (email, password) => Promise<void>,
  updateProfile: (data) => Promise<void>,
  checkPremiumStatus: () => Promise<boolean>,
}
```

**Implementation:**

```javascript
// contexts/AuthContext.js
import React, { createContext, useContext, useState, useEffect } from 'react';
import { auth, firestore } from '../services/firebase';
import AsyncStorage from '@react-native-async-storage/async-storage';

const AuthContext = createContext();

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
};

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Listen to auth state changes
  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged(async firebaseUser => {
      if (firebaseUser) {
        // Fetch additional user data from Firestore
        const userDoc = await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

        const userData = userDoc.data();

        setUser({
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          displayName: firebaseUser.displayName || userData?.displayName,
          isGuest: firebaseUser.isAnonymous,
          isPremium: userData?.isPremium || false,
          premiumExpiresAt: userData?.premiumExpiresAt,
        });
      } else {
        setUser(null);
      }
      setLoading(false);
    });

    return unsubscribe;
  }, []);

  const signUp = async (email, password, displayName) => {
    try {
      setLoading(true);
      setError(null);

      // Create Firebase auth user
      const credential = await auth.createUserWithEmailAndPassword(
        email,
        password
      );

      // Update profile
      await credential.user.updateProfile({ displayName });

      // Create Firestore user document
      await firestore
        .collection('users')
        .doc(credential.user.uid)
        .set({
          profile: {
            email,
            displayName,
            createdAt: new Date(),
            isGuest: false,
            isPremium: false,
          },
          preferences: {
            audio: { maxVolume: 0.65, fadeInDuration: 5, fadeOutDuration: 5 },
            notifications: { dailyReminder: true, reminderTime: '08:00' },
            appearance: { darkMode: 'auto' },
            practice: { defaultDuration: 10, showTimer: true },
          },
          progress: {
            totalSessions: 0,
            totalMinutes: 0,
            currentStreak: 0,
            longestStreak: 0,
            levels: {
              level1: {
                sessionsCompleted: 0,
                rewardProgress: 0,
                rewardComplete: false,
              },
              level2: {
                sessionsCompleted: 0,
                rewardProgress: 0,
                rewardComplete: false,
                unlocked: false,
              },
              level3: {
                sessionsCompleted: 0,
                rewardProgress: 0,
                rewardComplete: false,
                unlocked: false,
              },
            },
            challenges: {
              totalChallenges: 0,
              selectedSounds: [],
              soundMastery: {},
            },
            achievements: { unlocked: [], unlockedDates: {}, progress: {} },
          },
        });

      setLoading(false);
    } catch (err) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const signIn = async (email, password) => {
    try {
      setLoading(true);
      setError(null);
      await auth.signInWithEmailAndPassword(email, password);
      setLoading(false);
    } catch (err) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const signInWithGoogle = async () => {
    try {
      setLoading(true);
      setError(null);

      // Google Sign-In implementation (uses expo-auth-session or similar)
      const provider = new auth.GoogleAuthProvider();
      const result = await auth.signInWithPopup(provider);

      // Check if user document exists
      const userDoc = await firestore
        .collection('users')
        .doc(result.user.uid)
        .get();

      if (!userDoc.exists) {
        // New user - create document
        await firestore.collection('users').doc(result.user.uid).set({
          // ... same structure as signUp
        });
      }

      setLoading(false);
    } catch (err) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const continueAsGuest = async () => {
    try {
      setLoading(true);
      setError(null);

      // Firebase anonymous auth
      const credential = await auth.signInAnonymously();

      // Create minimal guest document
      await firestore
        .collection('users')
        .doc(credential.user.uid)
        .set({
          profile: {
            createdAt: new Date(),
            isGuest: true,
            isPremium: false,
          },
          // ... minimal structure
        });

      setLoading(false);
    } catch (err) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const upgradeGuestToAccount = async (email, password, displayName) => {
    try {
      if (!user?.isGuest) {
        throw new Error('Only guest accounts can be upgraded');
      }

      setLoading(true);
      setError(null);

      // Link anonymous account with email/password
      const credential = auth.EmailAuthProvider.credential(email, password);
      await auth.currentUser.linkWithCredential(credential);
      await auth.currentUser.updateProfile({ displayName });

      // Update Firestore document
      await firestore.collection('users').doc(user.uid).update({
        'profile.email': email,
        'profile.displayName': displayName,
        'profile.isGuest': false,
        'profile.upgradedAt': new Date(),
      });

      setLoading(false);
    } catch (err) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const signOut = async () => {
    try {
      setLoading(true);
      await auth.signOut();
      setUser(null);
      setLoading(false);
    } catch (err) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const checkPremiumStatus = async () => {
    if (!user) return false;

    // Check if premium subscription is still active
    if (user.isPremium && user.premiumExpiresAt) {
      const now = new Date();
      const expiry = user.premiumExpiresAt.toDate();
      return now < expiry;
    }

    return false;
  };

  const value = {
    user,
    loading,
    error,
    signUp,
    signIn,
    signInWithGoogle,
    signOut,
    continueAsGuest,
    upgradeGuestToAccount,
    checkPremiumStatus,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};
```

**Usage in Components:**

```javascript
// Any screen that needs auth info
import { useAuth } from '../contexts/AuthContext';

const HomeScreen = () => {
  const { user, signOut } = useAuth();

  return (
    <View>
      <Text>Welcome, {user?.isGuest ? 'Guest' : user?.displayName}!</Text>
      {user?.isGuest && (
        <Button title="Create Account" onPress={() => /* show sign-up modal */} />
      )}
      <Button title="Sign Out" onPress={signOut} />
    </View>
  );
};
```

---

### 2. ProgressContext (Achievement Manager)

**Responsibility:** Track all practice-related data and achievements

**State:**

```javascript
{
  progress: {
    totalSessions: number,
    totalMinutes: number,
    currentStreak: number,
    longestStreak: number,
    lastSessionDate: timestamp,

    levels: {
      level1: { /* level progress */ },
      level2: { /* level progress */ },
      level3: { /* level progress */ },
    },

    challenges: {
      selectedSounds: array,
      soundMastery: object,
    },

    achievements: {
      unlocked: array,
      unlockedDates: object,
    },
  },

  loading: boolean,
  syncing: boolean, // true when saving to Firestore
}
```

**Actions:**

```javascript
{
  loadProgress: () => Promise<void>,
  completeSession: (sessionData) => Promise<void>,
  updateLevelProgress: (level, data) => Promise<void>,
  unlockAchievement: (achievementId) => Promise<void>,
  updateSoundMastery: (sound, sessionData) => Promise<void>,
  calculateStreak: () => number,
  getNextReward: (level) => object,
}
```

**Implementation:**

```javascript
// contexts/ProgressContext.js
import React, { createContext, useContext, useState, useEffect } from 'react';
import { firestore } from '../services/firebase';
import { useAuth } from './AuthContext';
import AsyncStorage from '@react-native-async-storage/async-storage';

const ProgressContext = createContext();

export const useProgress = () => {
  const context = useContext(ProgressContext);
  if (!context) {
    throw new Error('useProgress must be used within ProgressProvider');
  }
  return context;
};

export const ProgressProvider = ({ children }) => {
  const { user } = useAuth();
  const [progress, setProgress] = useState(null);
  const [loading, setLoading] = useState(true);
  const [syncing, setSyncing] = useState(false);

  // Load progress when user changes
  useEffect(() => {
    if (user) {
      loadProgress();
    } else {
      setProgress(null);
      setLoading(false);
    }
  }, [user]);

  const loadProgress = async () => {
    try {
      setLoading(true);

      if (user.isGuest) {
        // Load from AsyncStorage for guest users
        const cachedProgress = await AsyncStorage.getItem('guestProgress');
        if (cachedProgress) {
          setProgress(JSON.parse(cachedProgress));
        } else {
          // Initialize empty progress
          const emptyProgress = getEmptyProgress();
          setProgress(emptyProgress);
          await AsyncStorage.setItem(
            'guestProgress',
            JSON.stringify(emptyProgress)
          );
        }
      } else {
        // Load from Firestore for authenticated users
        const doc = await firestore.collection('users').doc(user.uid).get();
        const userData = doc.data();
        setProgress(userData.progress);
      }

      setLoading(false);
    } catch (error) {
      console.error('Error loading progress:', error);
      setLoading(false);
    }
  };

  const completeSession = async sessionData => {
    /*
    sessionData = {
      level: number,
      soundscapeId: string,
      duration: number, // minutes
      completed: boolean,
      presenceRating: number,
      soundsHeard: array,
      soundRelation: string,
      notes: string,
    }
    */

    try {
      setSyncing(true);

      const now = new Date();
      const sessionDoc = {
        timestamp: now,
        ...sessionData,
      };

      // Calculate new progress
      const newProgress = { ...progress };
      newProgress.totalSessions += 1;
      newProgress.totalMinutes += sessionData.duration;

      // Update streak
      const streak = calculateStreakAfterSession(progress.lastSessionDate, now);
      newProgress.currentStreak = streak.current;
      newProgress.longestStreak = Math.max(
        newProgress.longestStreak,
        streak.current
      );
      newProgress.lastSessionDate = now;

      // Update level-specific progress
      const level = `level${sessionData.level}`;
      newProgress.levels[level].sessionsCompleted += 1;
      newProgress.levels[level].minutesCompleted += sessionData.duration;

      // Calculate reward progress (1 piece per 10 minutes)
      const piecesEarned = Math.floor(sessionData.duration / 10);
      const currentPieces = newProgress.levels[level].rewardProgress;
      const maxPieces = getMaxPiecesForLevel(sessionData.level);

      newProgress.levels[level].rewardProgress = Math.min(
        currentPieces + piecesEarned,
        maxPieces
      );

      // Check if level reward complete
      if (newProgress.levels[level].rewardProgress >= maxPieces) {
        newProgress.levels[level].rewardComplete = true;

        // Unlock next level
        if (sessionData.level === 1) {
          newProgress.levels.level2.unlocked = true;
        }
        // Level 3 unlocks only with premium (checked elsewhere)
      }

      // Update average presence rating
      const totalRating =
        (newProgress.levels[level].averagePresenceRating || 0) *
          (newProgress.levels[level].sessionsCompleted - 1) +
        sessionData.presenceRating;
      newProgress.levels[level].averagePresenceRating =
        totalRating / newProgress.levels[level].sessionsCompleted;

      // Check for new achievements
      const newAchievements = checkAchievements(newProgress, progress);
      if (newAchievements.length > 0) {
        newAchievements.forEach(achievementId => {
          newProgress.achievements.unlocked.push(achievementId);
          newProgress.achievements.unlockedDates[achievementId] = now;
        });
      }

      // Update state
      setProgress(newProgress);

      // Save to storage
      if (user.isGuest) {
        await AsyncStorage.setItem(
          'guestProgress',
          JSON.stringify(newProgress)
        );
        await AsyncStorage.setItem(
          `session_${now.getTime()}`,
          JSON.stringify(sessionDoc)
        );
      } else {
        // Save to Firestore
        await firestore.collection('users').doc(user.uid).update({
          progress: newProgress,
        });

        await firestore
          .collection('users')
          .doc(user.uid)
          .collection('sessions')
          .add(sessionDoc);
      }

      setSyncing(false);

      // Return new achievements for notification
      return {
        newAchievements,
        rewardUnlocked: piecesEarned > 0,
        levelComplete:
          newProgress.levels[level].rewardComplete &&
          !progress.levels[level].rewardComplete,
      };
    } catch (error) {
      console.error('Error completing session:', error);
      setSyncing(false);
      throw error;
    }
  };

  const calculateStreakAfterSession = (lastSessionDate, currentDate) => {
    if (!lastSessionDate) {
      return { current: 1 };
    }

    const lastDate = lastSessionDate.toDate
      ? lastSessionDate.toDate()
      : new Date(lastSessionDate);
    const current = new Date(currentDate);

    // Reset time to midnight for date comparison
    lastDate.setHours(0, 0, 0, 0);
    current.setHours(0, 0, 0, 0);

    const daysDiff = Math.floor((current - lastDate) / (1000 * 60 * 60 * 24));

    if (daysDiff === 0) {
      // Same day - streak continues
      return { current: progress.currentStreak };
    } else if (daysDiff === 1) {
      // Consecutive day - increment streak
      return { current: progress.currentStreak + 1 };
    } else {
      // Gap in days - reset streak
      return { current: 1 };
    }
  };

  const checkAchievements = (newProgress, oldProgress) => {
    const newAchievements = [];

    // First session
    if (newProgress.totalSessions === 1) {
      newAchievements.push('first_session');
    }

    // Week warrior (7-day streak)
    if (newProgress.currentStreak === 7 && oldProgress.currentStreak < 7) {
      newAchievements.push('week_warrior');
    }

    // Sound explorer (3 different tracks)
    // (Would need to track unique soundscapeIds - simplified here)

    // Mandala master (Level 1 complete)
    if (
      newProgress.levels.level1.rewardComplete &&
      !oldProgress.levels.level1.rewardComplete
    ) {
      newAchievements.push('mandala_master');
    }

    // Wave master (Level 2 complete)
    if (
      newProgress.levels.level2.rewardComplete &&
      !oldProgress.levels.level2.rewardComplete
    ) {
      newAchievements.push('wave_master');
    }

    // Phoenix risen (Level 3 complete)
    if (
      newProgress.levels.level3.rewardComplete &&
      !oldProgress.levels.level3.rewardComplete
    ) {
      newAchievements.push('phoenix_risen');
    }

    return newAchievements;
  };

  const getMaxPiecesForLevel = level => {
    switch (level) {
      case 1:
        return 10; // Mandala pieces
      case 2:
        return 8; // Resonance rings
      case 3:
        return 7; // Phoenix stars
      default:
        return 10;
    }
  };

  const getEmptyProgress = () => ({
    totalSessions: 0,
    totalMinutes: 0,
    currentStreak: 0,
    longestStreak: 0,
    lastSessionDate: null,
    firstSessionDate: null,

    levels: {
      level1: {
        sessionsCompleted: 0,
        minutesCompleted: 0,
        rewardProgress: 0,
        rewardComplete: false,
        averagePresenceRating: 0,
        completionRate: 0,
        favoriteTrack: null,
      },
      level2: {
        sessionsCompleted: 0,
        minutesCompleted: 0,
        rewardProgress: 0,
        rewardComplete: false,
        unlocked: false,
        averagePresenceRating: 0,
      },
      level3: {
        sessionsCompleted: 0,
        minutesCompleted: 0,
        rewardProgress: 0,
        rewardComplete: false,
        unlocked: false,
        averagePresenceRating: 0,
      },
    },

    challenges: {
      totalChallenges: 0,
      selectedSounds: [],
      soundMastery: {},
    },

    achievements: {
      unlocked: [],
      unlockedDates: {},
      progress: {},
    },
  });

  const getNextReward = level => {
    const levelProgress = progress?.levels[`level${level}`];
    if (!levelProgress) return null;

    const maxPieces = getMaxPiecesForLevel(level);
    const currentPieces = levelProgress.rewardProgress;

    if (currentPieces >= maxPieces) {
      return { complete: true };
    }

    const minutesUntilNext = 10 - (levelProgress.minutesCompleted % 10);

    return {
      complete: false,
      currentPieces,
      maxPieces,
      minutesUntilNext,
    };
  };

  const value = {
    progress,
    loading,
    syncing,
    loadProgress,
    completeSession,
    getNextReward,
  };

  return (
    <ProgressContext.Provider value={value}>
      {children}
    </ProgressContext.Provider>
  );
};
```

**Usage in Components:**

```javascript
import { useProgress } from '../contexts/ProgressContext';

const HomeScreen = () => {
  const { progress, loading } = useProgress();

  if (loading) return <LoadingSpinner />;

  return (
    <View>
      <Text>Sessions: {progress.totalSessions}</Text>
      <Text>Streak: {progress.currentStreak} 🔥</Text>
      <RewardProgress
        level={1}
        progress={progress.levels.level1.rewardProgress}
      />
    </View>
  );
};
```

---

### 3. AudioContext (Playback Manager)

**Responsibility:** Manage current practice session audio

**State:**

```javascript
{
  sound: Audio.Sound | null, // Expo AV sound object
  isPlaying: boolean,
  isPaused: boolean,
  currentTime: number, // seconds
  duration: number, // seconds
  soundscapeId: string | null,
  level: number | null,
  selectedDuration: number | null, // minutes
}
```

**Actions:**

```javascript
{
  loadTrack: (soundscapeId, level) => Promise<void>,
  play: () => Promise<void>,
  pause: () => Promise<void>,
  stop: () => Promise<void>,
  seek: (position) => Promise<void>,
  setVolume: (volume) => Promise<void>,
  unload: () => Promise<void>,
}
```

**Implementation:**

```javascript
// contexts/AudioContext.js
import React, {
  createContext,
  useContext,
  useState,
  useRef,
  useEffect,
} from 'react';
import { Audio } from 'expo-av';
import { useAuth } from './AuthContext';

const AudioContext = createContext();

export const useAudio = () => {
  const context = useContext(AudioContext);
  if (!context) {
    throw new Error('useAudio must be used within AudioProvider');
  }
  return context;
};

export const AudioProvider = ({ children }) => {
  const { user } = useAuth();
  const [sound, setSound] = useState(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [isPaused, setIsPaused] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(0);
  const [soundscapeId, setSoundscapeId] = useState(null);
  const [level, setLevel] = useState(null);
  const [selectedDuration, setSelectedDuration] = useState(null);

  const intervalRef = useRef(null);

  // Configure audio mode on mount
  useEffect(() => {
    configureAudio();
    return () => {
      if (sound) {
        sound.unloadAsync();
      }
    };
  }, []);

  const configureAudio = async () => {
    try {
      await Audio.setAudioModeAsync({
        allowsRecordingIOS: false,
        playsInSilentModeIOS: true, // Play even when phone is on silent
        staysActiveInBackground: true, // Continue when app backgrounded
        shouldDuckAndroid: true, // Lower volume of other apps
        playThroughEarpieceAndroid: false,
      });
    } catch (error) {
      console.error('Error configuring audio:', error);
    }
  };

  const loadTrack = async (soundscapeData, durationMinutes) => {
    try {
      // Unload any existing sound
      if (sound) {
        await sound.unloadAsync();
      }

      // Determine audio source (bundled or remote)
      const audioUri = soundscapeData.bundled
        ? require(`../assets/audio/${soundscapeData.audioUri}`) // Bundled asset
        : { uri: soundscapeData.remoteUri }; // Remote URL

      // Create and load sound
      const { sound: newSound } = await Audio.Sound.createAsync(
        audioUri,
        {
          shouldPlay: false,
          volume: user?.preferences?.audio?.maxVolume || 0.65,
        },
        onPlaybackStatusUpdate
      );

      setSound(newSound);
      setSoundscapeId(soundscapeData.soundscapeId);
      setLevel(soundscapeData.level);
      setSelectedDuration(durationMinutes);

      // Get duration
      const status = await newSound.getStatusAsync();
      setDuration(status.durationMillis / 1000); // Convert to seconds
    } catch (error) {
      console.error('Error loading track:', error);
      throw error;
    }
  };

  const onPlaybackStatusUpdate = status => {
    if (status.isLoaded) {
      setCurrentTime(status.positionMillis / 1000);
      setIsPlaying(status.isPlaying);
      setIsPaused(!status.isPlaying && status.positionMillis > 0);

      // Check if reached selected duration
      if (
        selectedDuration &&
        status.positionMillis / 1000 >= selectedDuration * 60
      ) {
        stop(); // Automatically stop at selected duration
      }

      // Handle natural completion (if playing full track)
      if (status.didJustFinish && !status.isLooping) {
        setIsPlaying(false);
        setIsPaused(false);
      }
    }
  };

  const play = async () => {
    if (!sound) {
      throw new Error('No sound loaded');
    }

    try {
      await sound.playAsync();
      setIsPlaying(true);
      setIsPaused(false);
    } catch (error) {
      console.error('Error playing sound:', error);
      throw error;
    }
  };

  const pause = async () => {
    if (!sound) return;

    try {
      await sound.pauseAsync();
      setIsPlaying(false);
      setIsPaused(true);
    } catch (error) {
      console.error('Error pausing sound:', error);
      throw error;
    }
  };

  const stop = async () => {
    if (!sound) return;

    try {
      await sound.stopAsync();
      setIsPlaying(false);
      setIsPaused(false);
      setCurrentTime(0);
    } catch (error) {
      console.error('Error stopping sound:', error);
      throw error;
    }
  };

  const seek = async positionSeconds => {
    if (!sound) return;

    try {
      await sound.setPositionAsync(positionSeconds * 1000);
      setCurrentTime(positionSeconds);
    } catch (error) {
      console.error('Error seeking:', error);
      throw error;
    }
  };

  const setVolume = async volume => {
    if (!sound) return;

    // Enforce max volume (safety)
    const maxVolume = user?.preferences?.audio?.maxVolume || 0.7;
    const safeVolume = Math.min(volume, maxVolume);

    try {
      await sound.setVolumeAsync(safeVolume);
    } catch (error) {
      console.error('Error setting volume:', error);
      throw error;
    }
  };

  const unload = async () => {
    if (sound) {
      try {
        await sound.unloadAsync();
        setSound(null);
        setSoundscapeId(null);
        setLevel(null);
        setSelectedDuration(null);
        setCurrentTime(0);
        setDuration(0);
        setIsPlaying(false);
        setIsPaused(false);
      } catch (error) {
        console.error('Error unloading sound:', error);
      }
    }
  };

  const value = {
    sound,
    isPlaying,
    isPaused,
    currentTime,
    duration,
    soundscapeId,
    level,
    selectedDuration,
    loadTrack,
    play,
    pause,
    stop,
    seek,
    setVolume,
    unload,
  };

  return (
    <AudioContext.Provider value={value}>{children}</AudioContext.Provider>
  );
};
```

**Usage in Practice Screen:**

```javascript
import { useAudio } from '../contexts/AudioContext';

const PracticeScreen = ({ route }) => {
  const { soundscapeData, duration } = route.params;
  const { loadTrack, play, pause, currentTime, isPlaying } = useAudio();

  useEffect(() => {
    initSession();
    return () => unload(); // Cleanup on unmount
  }, []);

  const initSession = async () => {
    await loadTrack(soundscapeData, duration);
    await play();
  };

  const remainingTime = duration * 60 - currentTime;

  return (
    <View>
      <Timer seconds={remainingTime} />
      <Button
        title={isPlaying ? 'Pause' : 'Resume'}
        onPress={() => (isPlaying ? pause() : play())}
      />
    </View>
  );
};
```

---

### 4. OnboardingContext (Flow Management)

**Responsibility:** Track onboarding completion status

**State:**

```javascript
{
  completed: boolean,
  currentPhase: number, // 1-5
  volumeCalibrated: boolean,
  safetyAcknowledged: boolean,
}
```

**Actions:**

```javascript
{
  completePhase: (phaseNumber) => void,
  completeOnboarding: () => Promise<void>,
  resetOnboarding: () => Promise<void>,
}
```

**Implementation** (Simplified - similar pattern to above contexts)

---

### 5. ChallengeContext (Personalized Sound Management)

**Responsibility:** Manage personalized challenge selections and mixing

**State:**

```javascript
{
  selectedSounds: array, // ['traffic', 'babies_crying']
  activeMix: {
    sounds: array,
    intensityLevels: object, // { traffic: 0.7, babies_crying: 0.5 }
  },
  soundMastery: object, // Progress per sound
}
```

**Actions:**

```javascript
{
  addChallenge: (soundId) => Promise<void>,
  removeChallenge: (soundId) => Promise<void>,
  createMix: (sounds, intensities) => object,
  updateSoundMastery: (soundId, sessionData) => Promise<void>,
}
```

---

### Context Provider Hierarchy

**App.js structure:**

```javascript
import { AuthProvider } from './contexts/AuthContext';
import { ProgressProvider } from './contexts/ProgressContext';
import { AudioProvider } from './contexts/AudioContext';
import { OnboardingProvider } from './contexts/OnboardingContext';
import { ChallengeProvider } from './contexts/ChallengeContext';
import AppNavigator from './navigation/AppNavigator';

export default function App() {
  return (
    <AuthProvider>
      <ProgressProvider>
        <AudioProvider>
          <OnboardingProvider>
            <ChallengeProvider>
              <AppNavigator />
            </ChallengeProvider>
          </OnboardingProvider>
        </AudioProvider>
      </ProgressProvider>
    </AuthProvider>
  );
}
```

**Why this order matters:**

- `AuthProvider` outermost: All other contexts need to know who the user is
- `ProgressProvider` second: Depends on `AuthContext` (loads user-specific progress)
- `AudioProvider` third: Needs auth for volume preferences
- `OnboardingProvider` fourth: Depends on auth and progress
- `ChallengeProvider` innermost: Depends on auth, progress, and audio

---

### Data Synchronization Patterns

#### Pattern 1: Optimistic Updates

**Problem:** User completes session, but Firestore write takes 2 seconds. UI feels laggy.

**Solution:**

```javascript
const completeSession = async sessionData => {
  // 1. Update local state immediately (optimistic)
  const newProgress = calculateNewProgress(progress, sessionData);
  setProgress(newProgress);

  // 2. Save to Firestore in background
  try {
    await firestore.collection('users').doc(user.uid).update({
      progress: newProgress,
    });
  } catch (error) {
    // 3. Revert on error
    setProgress(progress); // Rollback
    showErrorNotification('Failed to save progress. Please try again.');
  }
};
```

**Result:** UI updates instantly, network delay hidden.

---

#### Pattern 2: Cache-Then-Network

**Problem:** Loading progress on app open takes 2 seconds over slow connection. User sees blank screen.

**Solution:**

```javascript
const loadProgress = async () => {
  // 1. Load from cache immediately
  const cachedProgress = await AsyncStorage.getItem('progressCache');
  if (cachedProgress) {
    setProgress(JSON.parse(cachedProgress));
    setLoading(false); // UI shows cached data
  }

  // 2. Fetch fresh data from Firestore
  const freshProgress = await firestore.collection('users').doc(user.uid).get();

  // 3. Update UI with fresh data
  setProgress(freshProgress.data().progress);

  // 4. Update cache
  await AsyncStorage.setItem(
    'progressCache',
    JSON.stringify(freshProgress.data().progress)
  );
};
```

**Result:** Instant load with cached data, updates to fresh data seamlessly.

---

#### Pattern 3: Offline Queue

**Problem:** User completes session on airplane (no internet). Session lost?

**Solution:**

```javascript
const completeSession = async sessionData => {
  const newProgress = calculateNewProgress(progress, sessionData);
  setProgress(newProgress);

  try {
    await firestore.collection('users').doc(user.uid).update({
      progress: newProgress,
    });
  } catch (error) {
    if (error.code === 'unavailable') {
      // No internet - queue for later
      const queue = (await AsyncStorage.getItem('offlineQueue')) || '[]';
      const queueArray = JSON.parse(queue);
      queueArray.push({
        type: 'completeSession',
        data: sessionData,
        timestamp: Date.now(),
      });
      await AsyncStorage.setItem('offlineQueue', JSON.stringify(queueArray));
    }
  }
};

// Process queue when connection restored
const syncOfflineQueue = async () => {
  const queue = await AsyncStorage.getItem('offlineQueue');
  if (!queue) return;

  const queueArray = JSON.parse(queue);

  for (const item of queueArray) {
    try {
      if (item.type === 'completeSession') {
        await firestore.collection('users').doc(user.uid).update({
          // ... sync data
        });
      }
    } catch (error) {
      console.error('Error syncing queued item:', error);
      // Keep in queue if still failing
      continue;
    }
  }

  // Clear queue after successful sync
  await AsyncStorage.removeItem('offlineQueue');
};

// Listen for connection restore
useEffect(() => {
  const unsubscribe = NetInfo.addEventListener(state => {
    if (state.isConnected) {
      syncOfflineQueue();
    }
  });
  return unsubscribe;
}, []);
```

**Result:** Practice sessions never lost, sync automatically when online.

---

### Performance Optimization

#### Problem: Re-Renders

Every time a context value changes, ALL components using that context re-render.

**Bad Example:**

```javascript
// Every component re-renders when currentTime updates (every second!)
const value = {
  sound,
  isPlaying,
  currentTime, // Changes every second
  duration,
  play,
  pause,
};
```

**Solution: Split Contexts**

```javascript
// AudioStateContext (changes frequently)
const audioState = {
  isPlaying,
  currentTime,
};

// AudioActionsContext (never changes)
const audioActions = {
  play,
  pause,
  stop,
  loadTrack,
};

// Components only subscribe to what they need
const PlayButton = () => {
  const { play, pause } = useAudioActions(); // Doesn't re-render on time change
  const { isPlaying } = useAudioState(); // Re-renders only when play/pause

  return <Button onPress={isPlaying ? pause : play} />;
};

const Timer = () => {
  const { currentTime } = useAudioState(); // Re-renders every second (necessary)
  return <Text>{formatTime(currentTime)}</Text>;
};
```

---

#### Problem: Large Data Structures

Storing entire session history in context = massive object, slow updates.

**Solution: Separate Collections**

```javascript
// BAD: Everything in one context
const ProgressContext = {
  totalSessions: 150,
  sessions: [...150 session objects...], // Huge array
};

// GOOD: Summary in context, details on-demand
const ProgressContext = {
  totalSessions: 150, // Just the count
};

// Fetch full history only when needed
const SessionHistoryScreen = () => {
  const [sessions, setSessions] = useState([]);

  useEffect(() => {
    loadSessions(); // Separate query
  }, []);

  const loadSessions = async () => {
    const snapshot = await firestore
      .collection('users')
      .doc(user.uid)
      .collection('sessions')
      .orderBy('timestamp', 'desc')
      .limit(20) // Paginated
      .get();

    setSessions(snapshot.docs.map(doc => doc.data()));
  };
};
```

---

### Migration to Zustand (Phase 2+)

**When to migrate:**

- Context provider nesting becomes unwieldy (6+ contexts)
- Performance issues from unnecessary re-renders
- Complex state logic (multiple interdependent updates)

**Zustand Example (ProgressStore):**

```javascript
import create from 'zustand';
import { firestore } from '../services/firebase';

const useProgressStore = create((set, get) => ({
  // State
  progress: null,
  loading: false,

  // Actions
  loadProgress: async userId => {
    set({ loading: true });
    const doc = await firestore.collection('users').doc(userId).get();
    set({ progress: doc.data().progress, loading: false });
  },

  completeSession: async sessionData => {
    const { progress } = get();
    const newProgress = calculateNewProgress(progress, sessionData);

    // Optimistic update
    set({ progress: newProgress });

    // Background sync
    await firestore.collection('users').doc(userId).update({
      progress: newProgress,
    });
  },

  // Selectors (memoized)
  getCurrentStreak: () => get().progress?.currentStreak || 0,
  getLevelProgress: level => get().progress?.levels[`level${level}`],
}));

// Usage in components
const HomeScreen = () => {
  const progress = useProgressStore(state => state.progress);
  const currentStreak = useProgressStore(state => state.getCurrentStreak());
  // Only re-renders when progress or streak changes
};
```

**Advantages over Context:**

- No provider wrapping needed
- Automatic render optimization (only re-renders components using changed data)
- Cleaner action definitions
- Built-in middleware support (persist, devtools)

---

## 14. MONETIZATION & BUSINESS MODEL

### Freemium Structure (Detailed)

#### Free Tier: "AwAir Foundation"

**What's Included:**

**Practice Content:**

- ✅ Level 1: Foundation (all 4 tracks, unlimited sessions)
- ✅ Level 2: Balance (all 4 tracks, unlimited sessions)
- ✅ 2 personalized challenge sounds (select up to 2 triggers)
- ✅ 2 Sound→Form journeys (Forest Dawn, Ocean Whisper)

**Features:**

- ✅ All duration options (5, 10, 15, 20, 30 minutes)
- ✅ Session reflection and journaling
- ✅ Basic progress tracking (sessions, minutes, streak)
- ✅ Mandala Garden + Resonance Waves visual rewards
- ✅ Core achievements system
- ✅ 2 TapGames (BirdTap, WavePulse - unlimited plays)
- ✅ Learn section (Getting Started articles)
- ✅ Offline mode (bundled tracks + cached tracks)

**Limitations:**

- ❌ Level 3: Mastery locked (can preview 5 minutes)
- ❌ Limited to 2 personalized challenges
- ❌ Basic analytics only (no trends/insights)
- ❌ 3 premium TapGames locked
- ❌ 7 premium Sound→Form journeys locked
- ❌ No advanced features (dark mode customization, etc.)

**Value Proposition:**
"Build a solid meditation foundation with gentle and balanced soundscapes. Perfect for exploring sound-based mindfulness."

---

#### Premium Tier: "Premium Presence Pack"

**Pricing:**

- **Monthly:** $3.99/month
- **Annual:** $23.99/year (Save 50% = $1.99/month)
- **7-day free trial** (cancel anytime during trial = $0 charged)

**What's Unlocked:**

**Practice Content:**

- 🔓 Level 3: Mastery (all 3 intense urban tracks, full duration)
- 🔓 Phoenix Constellation visual reward
- 🔓 Unlimited personalized challenges (up to 10 active sounds)
- 🔓 Custom intensity mixing per sound
- 🔓 7 exclusive Sound→Form journeys (Desert Night, Rainforest, City 3am, etc.)

**TapGames:**

- 🔓 SilenceCatch (notice gaps in sound)
- 🔓 FootstepBeat (rapid focus training)
- 🔓 WindNote (advanced difficulty)
- 🔓 Combined Challenges (multiple sound types in one game)

**Advanced Features:**

- 🔓 **Analytics Dashboard:**
  - Presence trend charts (weekly, monthly)
  - Sound mastery breakdowns per trigger
  - Practice time distribution analysis
  - Personalized insights and recommendations
- 🔓 **Sound Mastery Tracking:**
  - Detailed per-sound analytics
  - Progress toward Gold/Platinum tiers
  - Achievement rarity percentages
- 🔓 **Customization:**
  - Dark mode (force light, dark, or auto)
  - Custom avatar elements
  - Advanced notification controls
- 🔓 **Offline Downloads:**
  - Download any track for offline use
  - Auto-download upcoming content
- 🔓 **Priority Support:**
  - Email responses within 24 hours
  - Direct feedback channel to developers

**Value Proposition:**
"Master peace in the most challenging environments. Advanced tools for serious practitioners."

---

### Pricing Psychology

**Why $3.99/month:**

- **Coffee comparison:** Less than a single coffee ($4-6)
- **Meditation app standard:** Headspace ($12.99), Calm ($14.99), Insight Timer ($9.99)
  - AwAir is positioned as "specialized tool" not "full meditation library"
  - Lower price reflects focused scope (sound-specific vs general meditation)
- **Psychological pricing:** $3.99 feels significantly cheaper than $4.00 or $5.00
- **Commitment test:** High enough to filter serious users, low enough to avoid sticker shock

**Why 50% annual discount:**

- **Industry standard:** Most subscription apps offer 40-50% annual discount
- **Revenue optimization:**
  - Annual: $23.99 upfront = better for AwAir cash flow
  - Monthly: $47.88/year potential but higher churn
  - Break-even at 6 months (if user stays 6+ months, annual was better for them)
- **Commitment psychology:** Annual subscribers have lower churn (sunk cost, less frequent renewal decision)

**Why 7-day trial:**

- **Time to value:** Users need 3-5 sessions to feel benefit (7 days = enough time)
- **Conversion data:** Industry average 20-30% trial-to-paid conversion
- **Comparison:** Calm (7 days), Headspace (14 days), Insight Timer (no trial, freemium)
- **Risk reduction:** "Try before you buy" reduces barrier

---

### Conversion Funnel Strategy

#### Trigger Point 1: Level 2 Completion (~Week 4)

**User State:**

- Completed Mandala Garden (Level 1)
- Completed Resonance Waves (Level 2)
- Invested ~15-20 hours of practice
- Experiencing measurable benefit (proven by returning)

**Paywall Moment:**
Immediately after Level 2 completion celebration:

```
┌─────────────────────────────────────────────────┐
│        🌊 Resonance Waves Complete!             │
│                                                  │
│    You've mastered balanced soundscapes.        │
│                                                  │
│    Ready for the ultimate challenge?            │
│                                                  │
│         🔥 LEVEL 3: MASTERY                     │
│                                                  │
│   Practice with intense urban environments      │
│   and achieve true equanimity anywhere.         │
│                                                  │
│         [TRY 5-MIN PREVIEW]                     │
│         [UNLOCK PREMIUM]                        │
│              [Later]                             │
└─────────────────────────────────────────────────┘
```

**Psychological Factors:**

- **Achievement high:** Just completed major milestone (emotional peak)
- **Curiosity:** "What's next? I want to keep progressing"
- **Sunk cost:** "I've invested weeks, might as well continue"
- **Social proof:** "Top 15% of users reach Level 3" (exclusivity appeal)

**Expected Conversion:** 8-12% (higher than average because timing is perfect)

---

#### Trigger Point 2: 20-Session Milestone (~Week 3)

**User State:**

- Completed 20 practice sessions
- Proven commitment (not a casual user)
- Likely seeing real-world benefits

**Paywall Moment:**
After 20th session reflection, show banner:

```
┌─────────────────────────────────────────────────┐
│   🎉 20 Sessions! You're a dedicated practitioner│
│                                                  │
│   See how you've improved with Premium Analytics│
│   • Presence rating trend chart                 │
│   • Sound mastery breakdowns                    │
│   • Personalized insights                       │
│                                                  │
│         [View Your Analytics] (Premium)         │
│                [Maybe Later]                     │
└─────────────────────────────────────────────────┘
```

**Psychological Factors:**

- **Milestone recognition:** Celebrate their dedication
- **Data curiosity:** "How have I actually improved?"
- **Quantified self:** Appeals to users who love metrics
- **Specificity:** Not vague "premium features" but concrete "see your trend chart"

**Expected Conversion:** 5-7%

---

#### Trigger Point 3: 3rd Personalized Challenge Attempt (~Week 2-3)

**User State:**

- Using personalized challenges (engaged with advanced feature)
- Already has 2 challenges active (free limit)
- Wants to add 3rd challenge (blocked by paywall)

**Paywall Moment:**
When tapping "+ Add New Challenge" with 2 already active:

```
┌─────────────────────────────────────────────────┐
│      🎯 Unlock Unlimited Challenges             │
│                                                  │
│  Free: 2 active challenges                      │
│  Premium: Up to 10 active challenges            │
│                                                  │
│  Plus: Custom intensity mixing, advanced        │
│  sound mastery tracking, and more.              │
│                                                  │
│         [START 7-DAY FREE TRIAL]                │
│              [Not Now]                           │
└─────────────────────────────────────────────────┘
```

**Psychological Factors:**

- **Functional blocker:** They literally can't do what they want (not just "nice to have")
- **Demonstrated need:** They're actively using challenges (not speculative)
- **Clear value:** "10 challenges vs 2" is concrete benefit

**Expected Conversion:** 10-15% (high because it's blocking desired action)

---

### Revenue Projections

**Assumptions:**

- **Year 1 Target:** 10,000 total downloads
- **Retention:** 25% 7-day, 15% 30-day, 8% 90-day
- **Premium Conversion:** 5% overall (blended from different trigger points)
- **Churn:** 5% monthly (premium subscribers)

**Month 1-3 (Launch Phase):**

- Downloads: 1,000
- Active users (30-day): 150
- Premium conversions: 50 (5% of 1,000)
- **MRR:** $200 (50 × $3.99)
- **ARR:** ~$2,400

**Month 6 (Growth Phase):**

- Total downloads: 5,000
- Active users: 750
- Premium subscribers: 250 (cumulative, accounting for churn)
- **MRR:** $1,000
- **ARR:** ~$12,000

**Month 12 (Mature Phase):**

- Total downloads: 10,000
- Active users: 1,500
- Premium subscribers: 500
- **MRR:** $2,000
- **ARR:** ~$24,000

**Year 2 Projection:**

- Organic growth + marketing: 25,000 total downloads
- Premium subscribers: 1,250
- **MRR:** $5,000
- **ARR:** ~$60,000

**Break-Even Analysis:**

- **Fixed Costs:** Firebase ($25/month), Apple Dev ($99/year), Google Dev ($25 one-time), domain/hosting ($10/month)
- **Monthly Fixed:** ~$40
- **Break-even subscribers:** 10-15 (reached in Month 1-2)

---

### Payment Integration (RevenueCat)

**Why RevenueCat:**

- **Cross-platform:** Single codebase for iOS and Android subscriptions
- **Free tier:** Up to $2,500 monthly tracked revenue (AwAir covered for first ~50 subscribers)
- **Features:**
  - Handles App Store / Play Store complexities
  - Automatic receipt validation
  - Webhook for subscription events
  - Subscriber status API
  - Grace period handling
  - Family sharing support (iOS)

**Implementation:**

```javascript
// services/RevenueCatService.js
import Purchases from 'react-native-purchases';
import { firestore } from './firebase';

const REVENUECAT_API_KEY = 'YOUR_API_KEY';

export const initializePurchases = async userId => {
  await Purchases.configure({
    apiKey: REVENUECAT_API_KEY,
    appUserID: userId,
  });
};

export const getOfferings = async () => {
  try {
    const offerings = await Purchases.getOfferings();
    if (offerings.current !== null) {
      return offerings.current.availablePackages;
    }
  } catch (error) {
    console.error('Error getting offerings:', error);
  }
};

export const purchasePackage = async packageToPurchase => {
  try {
    const { customerInfo } = await Purchases.purchasePackage(packageToPurchase);

    // Check if user now has premium entitlement
    const isPremium = customerInfo.entitlements.active['premium'] !== undefined;

    if (isPremium) {
      // Update Firestore
      await updatePremiumStatus(customerInfo);
      return { success: true, isPremium: true };
    }
  } catch (error) {
    if (
      error.code === Purchases.PURCHASES_ERROR_CODE.PURCHASE_CANCELLED_ERROR
    ) {
      return { success: false, cancelled: true };
    }
    console.error('Purchase error:', error);
    return { success: false, error: error.message };
  }
};

export const restorePurchases = async () => {
  try {
    const customerInfo = await Purchases.restorePurchases();
    const isPremium = customerInfo.entitlements.active['premium'] !== undefined;

    if (isPremium) {
      await updatePremiumStatus(customerInfo);
    }

    return { success: true, isPremium };
  } catch (error) {
    console.error('Restore error:', error);
    return { success: false, error: error.message };
  }
};

const updatePremiumStatus = async customerInfo => {
  const userId = await Purchases.getAppUserID();
  const premiumEntitlement = customerInfo.entitlements.active['premium'];

  await firestore
    .collection('users')
    .doc(userId)
    .update({
      'profile.isPremium': true,
      'profile.premiumSince': premiumEntitlement.originalPurchaseDate,
      'profile.premiumExpiresAt': premiumEntitlement.expirationDate,
      'profile.subscriptionType': premiumEntitlement.productIdentifier.includes(
        'annual'
      )
        ? 'annual'
        : 'monthly',
    });
};

// Listen for subscription changes (renewal, cancellation)
Purchases.addCustomerInfoUpdateListener(customerInfo => {
  const isPremium = customerInfo.entitlements.active['premium'] !== undefined;

  // Update local state and Firestore
  updatePremiumStatus(customerInfo);
});
```

**Paywall Screen Implementation:**

```javascript
import React, { useEffect, useState } from 'react';
import { View, Text, TouchableOpacity, ActivityIndicator } from 'react-native';
import { getOfferings, purchasePackage } from '../services/RevenueCatService';

const PaywallScreen = ({ navigation }) => {
  const [packages, setPackages] = useState([]);
  const [loading, setLoading] = useState(true);
  const [purchasing, setPurchasing] = useState(false);

  useEffect(() => {
    loadOfferings();
  }, []);

  const loadOfferings = async () => {
    const offerings = await getOfferings();
    setPackages(offerings);
    setLoading(false);
  };

  const handlePurchase = async pkg => {
    setPurchasing(true);
    const result = await purchasePackage(pkg);
    setPurchasing(false);

    if (result.success) {
      // Show success message
      Alert.alert('Welcome to Premium!', 'All features unlocked.');
      navigation.goBack(); // Return to previous screen
    } else if (!result.cancelled) {
      Alert.alert('Purchase Failed', result.error);
    }
  };

  if (loading) {
    return <ActivityIndicator />;
  }

  const monthlyPackage = packages.find(p => p.identifier === 'monthly');
  const annualPackage = packages.find(p => p.identifier === 'annual');

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Unlock Premium Presence Pack</Text>

      {/* Annual Plan (Highlighted) */}
      <TouchableOpacity
        style={[styles.packageCard, styles.highlightedCard]}
        onPress={() => handlePurchase(annualPackage)}
        disabled={purchasing}
      >
        <View style={styles.badge}>
          <Text style={styles.badgeText}>BEST VALUE</Text>
        </View>
        <Text style={styles.packageTitle}>Annual Plan</Text>
        <Text style={styles.packagePrice}>$23.99/year</Text>
        <Text style={styles.packageSubtext}>Just $1.99/month · Save 50%</Text>
      </TouchableOpacity>

      {/* Monthly Plan */}
      <TouchableOpacity
        style={styles.packageCard}
        onPress={() => handlePurchase(monthlyPackage)}
        disabled={purchasing}
      >
        <Text style={styles.packageTitle}>Monthly Plan</Text>
        <Text style={styles.packagePrice}>$3.99/month</Text>
        <Text style={styles.packageSubtext}>Cancel anytime</Text>
      </TouchableOpacity>

      <Text style={styles.trialText}>
        7-day free trial · Cancel anytime before trial ends
      </Text>

      <TouchableOpacity onPress={restorePurchases}>
        <Text style={styles.restoreText}>Restore Purchases</Text>
      </TouchableOpacity>

      {purchasing && <ActivityIndicator style={styles.loader} />}
    </View>
  );
};
```

---

### A/B Testing Monetization

**Test 1: Paywall Timing**

- **Variant A:** Show after Level 2 completion (current strategy)
- **Variant B:** Show after 15 sessions (regardless of level)
- **Variant C:** Show after 7-day streak
- **Metric:** Conversion rate
- **Hypothesis:** Achievement moments (Level 2 complete) convert best

**Test 2: Pricing**

- **Variant A:** $3.99/month, $23.99/year (current)
- **Variant B:** $4.99/month, $29.99/year
- **Variant C:** $2.99/month, $19.99/year
- **Metric:** Total revenue (not just conversion rate - higher price might mean fewer conversions but more revenue)
- **Hypothesis:** $3.99 is sweet spot (low enough for impulse, high enough for perceived value)

**Test 3: Trial Length**

- **Variant A:** 7-day trial (current)
- **Variant B:** 14-day trial
- **Variant C:** No trial, first month discounted ($1.99)
- **Metric:** Trial-to-paid conversion rate
- **Hypothesis:** 7 days sufficient (longer trials increase drop-off)

**Implementation with Firebase Remote Config:**

```javascript
import remoteConfig from '@react-native-firebase/remote-config';

// Set defaults
await remoteConfig().setDefaults({
  paywall_trigger: 'level2_complete',
  monthly_price: 3.99,
  annual_price: 23.99,
  trial_days: 7,
});

// Fetch latest config
await remoteConfig().fetchAndActivate();

// Use in app
const paywallTrigger = remoteConfig().getValue('paywall_trigger').asString();
const monthlyPrice = remoteConfig().getValue('monthly_price').asNumber();
```

**Firebase Console Configuration:**

- Create parameter: `paywall_trigger`
- Set conditions:
  - 50% of users → `level2_complete`
  - 50% of users → `15_sessions`
- Monitor conversion rates in Firebase Analytics
- Roll out winner to 100% after statistically significant results

---
