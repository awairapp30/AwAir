# 🗓️ AWAIR: COMPLETE DEVELOPMENT ROADMAP

**Comprehensive Phase-by-Phase Implementation Guide**

---

## TABLE OF CONTENTS

1. [Overview & Methodology](#overview--methodology)
2. [Phase 1: Proven MVP (Weeks 1-10)](#phase-1-proven-mvp-weeks-1-10)
3. [Phase 2: Complete Product (Weeks 11-18)](#phase-2-complete-product-weeks-11-18)
4. [Phase 3: Growth & Optimization (Weeks 19-26)](#phase-3-growth--optimization-weeks-19-26)
5. [Phase 4: Scale & Community (Weeks 27-40)](#phase-4-scale--community-weeks-27-40)
6. [Resource Requirements](#resource-requirements)
7. [Risk Mitigation](#risk-mitigation)
8. [Success Metrics & KPIs](#success-metrics--kpis)

---

## OVERVIEW & METHODOLOGY

### Development Philosophy

**AwAir follows the "Build-Measure-Learn" cycle:**

1. **Build:** Create smallest version that delivers core value
2. **Measure:** Track real user behavior (not opinions)
3. **Learn:** Use data to inform next iteration
4. **Iterate:** Improve based on evidence, not assumptions

**NOT waterfall development** (build everything, then launch)
**YES agile iterations** (launch minimal version, improve based on real usage)

---

### Phase Structure

**Phase 1 (10 weeks):** Proven MVP

- **Goal:** Validate core concept with 15-20 beta users
- **Output:** Android app with Levels 1-2, basic features
- **Success:** 70%+ complete first session, 40%+ return within 7 days

**Phase 2 (8 weeks):** Complete Product

- **Goal:** Launch full-featured app on both platforms
- **Output:** iOS + Android with all 3 levels, premium features
- **Success:** 5,000 downloads, 3% premium conversion

**Phase 3 (8 weeks):** Growth & Optimization

- **Goal:** Achieve product-market fit and revenue sustainability
- **Output:** Marketing campaigns, analytics, conversion optimization
- **Success:** $2,000 MRR, 20% 30-day retention

**Phase 4 (14 weeks):** Scale & Community

- **Goal:** Build network effects and long-term moat
- **Output:** Community features, content expansion, partnerships
- **Success:** 25,000 users, 5% premium conversion, strong brand

---

### Team Roles (Solo or Small Team)

**Solo Developer Path:**

- Weeks 1-26: Focus full-time on development
- Budget 40-50 hours/week
- Outsource audio production (cheaper than your time)

**Two-Person Team:**

- **Developer:** All technical implementation
- **Content Creator:** Audio production, copywriting, design
- Parallel work reduces timeline by ~30%

**Three-Person Team:**

- **Developer:** Technical
- **Audio Producer:** All sound production
- **Designer/Marketer:** UI/UX, marketing materials, social media
- Can compress timeline to 20 weeks for Phases 1-3

---

## PHASE 1: PROVEN MVP (WEEKS 1-10)

### Overarching Goal

**Launch Android app with Levels 1-2 that proves people will use and return to the product.**

### Success Criteria

- 15-20 beta users complete onboarding without confusion
- 70%+ complete at least one full session
- 40%+ return for second session within 7 days
- Average presence rating 3.0+ (out of 5)
- Zero critical bugs (crashes, audio failures, data loss)

---

### WEEK 1-2: Foundation & Audio

#### Development Tasks

**Days 1-2: Environment Setup**

- [ ] Install Node.js 18+, Expo CLI
- [ ] Create new Expo project: `npx create-expo-app AwAir`
- [ ] Initialize Git repository
- [ ] Create GitHub repo, push initial commit
- [ ] Install core dependencies:
  ```bash
  npm install @react-navigation/native @react-navigation/stack @react-navigation/bottom-tabs
  npm install expo-av expo-file-system @react-native-async-storage/async-storage
  npm install firebase @react-native-firebase/app @react-native-firebase/auth @react-native-firebase/firestore
  ```
- [ ] Test Expo Go on physical Android device

**Days 3-5: Firebase Configuration**

- [ ] Create Firebase project (console.firebase.google.com)
- [ ] Enable Authentication (Email/Password, Google)
- [ ] Create Firestore database (test mode initially)
- [ ] Enable Firebase Storage
- [ ] Download `google-services.json`
- [ ] Configure Firebase in `app.json`
- [ ] Create `services/firebase.js` with initialization
- [ ] Test connection (write test document to Firestore)

**Days 6-8: Navigation Framework**

- [ ] Install React Navigation dependencies
- [ ] Create folder structure:
  ```
  src/
    navigation/
      AppNavigator.js
      AuthNavigator.js
      MainNavigator.js
    screens/
      onboarding/
      main/
      practice/
    contexts/
    components/
    services/
    constants/
    assets/
  ```
- [ ] Build AppNavigator (switches auth/main)
- [ ] Build AuthNavigator (onboarding flow)
- [ ] Build MainNavigator (bottom tabs)
- [ ] Create placeholder screens for all planned screens
- [ ] Test navigation flow

**Days 9-10: Design System**

- [ ] Create `constants/colors.js`:
  ```javascript
  export const colors = {
    primary: '#2E7D32', // Forest green
    secondary: '#1565C0', // Ocean blue
    accent: '#FFB300', // Golden
    background: '#FAFAFA',
    surface: '#FFFFFF',
    text: '#212121',
    textSecondary: '#757575',
    error: '#D32F2F',
    success: '#388E3C',
  };
  ```
- [ ] Create `constants/typography.js`
- [ ] Build `components/Button.js` (Primary, Secondary variants)
- [ ] Build `components/Card.js`
- [ ] Build `components/Input.js`
- [ ] Test components on different screen sizes

**Checkpoint 1:** Can navigate through placeholder screens, Firebase connected, design system in place

---

#### Audio Production Tasks

**Days 1-3: Source Audio Library**

- [ ] Create Freesound.org account
- [ ] Search and download 50+ sound files:
  - 10 forest ambience options
  - 20 bird sound variations
  - 10 wind/breeze sounds
  - 10 water sounds (streams, distant ocean)
  - 10 peaceful accents (chimes, bells, bowls)
- [ ] Organize into folders by category
- [ ] Create spreadsheet documenting each file (name, source, license, notes)

**Days 4-7: Create Track 1 - "Forest Dawn"**

- [ ] Install Audacity (free)
- [ ] Import forest ambience base (loop to 20 minutes)
- [ ] Layer 1: Birds (chirp every 60-90 seconds, varied timing)
- [ ] Layer 2: Gentle breeze (constant low volume)
- [ ] Layer 3: Distant stream (very subtle, 20% of total duration)
- [ ] Layer 4: Wind chimes (every 3-4 minutes, barely audible)
- [ ] Balance volumes (base: -12dB, birds: -18dB, breeze: -24dB, stream: -22dB, chimes: -28dB)
- [ ] Add 5-second fade-in/fade-out
- [ ] Export as WAV (master), convert to OGG Vorbis 96kbps
- [ ] Quality check on phone speakers, earbuds, headphones
- [ ] Re-export if needed

**Days 8-10: Create Track 2 - "Ocean Whisper"**

- [ ] Same process as Track 1
- [ ] Base: Ocean waves (rhythmic, 8-10 second cycle)
- [ ] Layer 1: Seagulls (occasional, distant)
- [ ] Layer 2: Wind over water
- [ ] Layer 3: Distant boat horn (twice in 20 minutes, very far)
- [ ] Export OGG Vorbis 96kbps
- [ ] Quality check

**Checkpoint 2:** Two complete 20-minute tracks, properly mixed and exported

---

### WEEK 3-4: Core Audio & Safety

#### Development Tasks

**Days 1-3: AudioService Implementation**

- [ ] Create `services/audio/AudioService.js`
- [ ] Implement methods:
  ```javascript
  class AudioService {
    async initialize()
    async loadTrack(uri)
    async play()
    async pause()
    async stop()
    async setVolume(volume)
    async getStatus()
    async cleanup()
  }
  ```
- [ ] Configure audio mode:
  ```javascript
  await Audio.setAudioModeAsync({
    playsInSilentModeIOS: true,
    staysActiveInBackground: true,
    shouldDuckAndroid: true,
  });
  ```
- [ ] Test each method individually
- [ ] Test method sequences (load → play → pause → resume → stop)

**Days 4-6: AudioContext Setup**

- [ ] Create `contexts/AudioContext.js`
- [ ] Implement state management:
  ```javascript
  {
    sound: Audio.Sound | null,
    isPlaying: boolean,
    currentTime: number,
    duration: number,
    loadTrack: (uri, duration) => Promise<void>,
    play: () => Promise<void>,
    pause: () => Promise<void>,
    stop: () => Promise<void>,
  }
  ```
- [ ] Integrate with AudioService
- [ ] Test context in dummy component

**Days 7-8: Interruption Handling**

- [ ] Create `services/audio/InterruptionHandler.js`
- [ ] Listen for app state changes (background/foreground)
- [ ] Listen for audio interruptions (calls, alarms)
- [ ] Auto-pause on interruption
- [ ] Show "Resume" prompt after interruption ends
- [ ] Test with actual phone call
- [ ] Test with alarm
- [ ] Test with notification

**Days 9-10: Background & Lock Screen**

- [ ] Implement lock screen controls (track metadata, playback position)
- [ ] Test audio continues when screen locks
- [ ] Test audio continues when switching apps
- [ ] Monitor battery drain (should be <2% per 10 minutes)
- [ ] Optimize if needed

**Checkpoint 3:** Audio plays reliably, handles interruptions, works in background

---

#### Onboarding Screens

**Days 1-3: Content Writing**

- [ ] Write WelcomeOnboarding flow copy (5 phases):
  - Phase 1: Welcome message + tagline
  - Phase 2: Value propositions (3 key benefits)
  - Phase 3: Tutorial instructions
  - Phase 4: Safety warnings (volume, tinnitus, discontinue if discomfort)
  - Phase 5: Account creation prompt
- [ ] Get feedback from 2-3 people
- [ ] Revise based on feedback

**Days 4-7: Build Onboarding Screens**

- [ ] Create `screens/onboarding/WelcomeOnboardingScreen.js`
- [ ] Implement 5 phases as vertical scroll or swipeable
- [ ] Phase 1: Animated logo, ambient sound (10 seconds)
- [ ] Phase 2: Value prop cards with icons
- [ ] Phase 3: Interactive tutorial (30-second practice demo)
- [ ] Phase 4:
  - Safety warnings (scrollable text)
  - Volume slider with test button
  - Headphone recommendation
  - Volume capped at 70%
- [ ] Phase 5:
  - Google Sign-In button
  - Email sign-up form (collapsed, expands on tap)
  - Continue as Guest button (small, bottom)
- [ ] Wire up navigation to Home after completion
- [ ] Save onboarding completion to AsyncStorage

**Days 8-10: AuthContext Implementation**

- [ ] Create `contexts/AuthContext.js`
- [ ] Implement Firebase auth methods:
  ```javascript
  {
    user: object | null,
    loading: boolean,
    signUp: (email, password, displayName) => Promise<void>,
    signIn: (email, password) => Promise<void>,
    signInWithGoogle: () => Promise<void>,
    continueAsGuest: () => Promise<void>,
    signOut: () => Promise<void>,
  }
  ```
- [ ] Create Firestore user document on sign-up
- [ ] Listen to auth state changes
- [ ] Test guest mode (anonymous auth)
- [ ] Test email sign-up
- [ ] Test sign-in
- [ ] Test sign-out

**Checkpoint 4:** Complete onboarding flow, auth working, user can create account or continue as guest

---

### WEEK 5-6: Core Practice Experience

#### Development Tasks

**Days 1-3: HomeScreen Implementation**

- [ ] Create `screens/main/HomeScreen.js`
- [ ] Implement UI:
  - Greeting header (personalized with name or "Guest")
  - Quick stats cards (sessions, minutes, streak)
  - Level 1 card (expanded by default)
  - Level 2 card (locked initially)
  - Level 3 card (premium locked)
- [ ] Level 1 card shows:
  - Title, description
  - Progress bar (0/10 mandala pieces)
  - Track list (Forest Dawn, Ocean Whisper)
  - Duration selector (5, 10, 15, 20, 30 min)
  - START button
- [ ] Handle track selection
- [ ] Handle duration selection
- [ ] Navigate to Practice Introduction on START

**Days 4-6: PracticeIntroductionModal**

- [ ] Create `components/PracticeIntroductionModal.js`
- [ ] Display:
  - Track title and level
  - Simple instruction: "Close your eyes. Breathe. Listen—without naming."
  - BEGIN PRACTICE button
  - Checkbox: "Don't show this again" (after 10 sessions)
- [ ] Save checkbox state to user preferences
- [ ] Navigate to PracticeScreen on begin

**Days 7-9: PracticeScreen**

- [ ] Create `screens/practice/PracticeScreen.js`
- [ ] Receive params: `{ soundscapeData, duration }`
- [ ] Initialize AudioContext
- [ ] Load track: `loadTrack(soundscapeData.audioUri, duration)`
- [ ] Auto-play on mount: `play()`
- [ ] UI elements:
  - Large circular timer (center)
  - Quote below timer (changes every 2 minutes)
  - Pause/Resume button (bottom center)
  - Exit button (top-left corner, small)
- [ ] Timer countdown logic:

  ```javascript
  const [remainingTime, setRemainingTime] = useState(duration * 60);

  useEffect(() => {
    const interval = setInterval(() => {
      setRemainingTime(prev => {
        if (prev <= 1) {
          clearInterval(interval);
          handleSessionComplete();
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    return () => clearInterval(interval);
  }, []);
  ```

- [ ] Quote rotation logic (every 120 seconds)
- [ ] Exit confirmation dialog
- [ ] Navigate to ReflectionScreen on completion

**Days 10-12: Quote System**

- [ ] Create `constants/quotes.js`
- [ ] Write 30 quotes for Level 1:
  - 10 grounding quotes
  - 10 acceptance quotes
  - 10 philosophical quotes
- [ ] Categorize by level appropriateness
- [ ] Implement random quote selector (no repeats within session)
- [ ] Test quote display and rotation

**Checkpoint 5:** User can start practice, audio plays, timer counts down, quotes rotate, session completes

---

#### ProgressContext & Reflection

**Days 1-3: ProgressContext Setup**

- [ ] Create `contexts/ProgressContext.js`
- [ ] Implement state structure:
  ```javascript
  {
    progress: {
      totalSessions: number,
      totalMinutes: number,
      currentStreak: number,
      levels: {
        level1: {
          sessionsCompleted: number,
          minutesCompleted: number,
          rewardProgress: number, // 0-10
          rewardComplete: boolean,
        },
        level2: { ...unlocked: false },
        level3: { ...unlocked: false },
      },
    },
    completeSession: (sessionData) => Promise<void>,
  }
  ```
- [ ] Implement `loadProgress()` (from Firestore or AsyncStorage)
- [ ] Implement `completeSession()`:
  - Update total stats
  - Calculate streak
  - Update level progress
  - Award reward pieces (1 per 10 minutes)
  - Check for level completion
  - Save to Firestore/AsyncStorage
- [ ] Test with dummy session data

**Days 4-7: ReflectionScreen**

- [ ] Create `screens/practice/ReflectionScreen.js`
- [ ] Receive params: `{ level, soundscapeId, duration, completed }`
- [ ] UI elements:
  - Completion header (icon, duration summary)
  - Presence rating (1-5 buttons)
  - Sounds heard (8 category chips, multi-select)
  - Sound relation (4 radio options)
  - Optional notes (text input, collapsible)
  - SUBMIT button
- [ ] On submit:
  - Call `completeSession()` with reflection data
  - Check return value for achievements/rewards
  - Show reward animation if applicable
  - Navigate to home
- [ ] Test reflection submission
- [ ] Verify progress updates correctly

**Days 8-10: Reward Animations**

- [ ] Create `components/rewards/MandalaAnimation.js`
- [ ] Implement piece unlock animation:
  - Mandala appears centered
  - New piece position highlights
  - Piece unfolds from center (1.5s)
  - Particle effects radiate
  - Text: "Piece X/10 unlocked!"
- [ ] Test animation performance (should be 60fps)
- [ ] Create complete mandala celebration (all 10 pieces)
- [ ] Integrate into reflection flow

**Checkpoint 6:** Complete practice loop works: start → practice → reflect → see progress update → return home

---

### WEEK 7-8: Beta Testing & Iteration

#### Beta Preparation

**Days 1-2: Pre-Beta QA**

- [ ] Complete end-to-end test:
  - Onboarding → Home → Practice → Reflection → Home
  - Repeat with different durations (5, 10, 15 minutes)
  - Test as guest user
  - Test as authenticated user
- [ ] Check all critical paths work:
  - Sign up → practice → sign out → sign in (data persists)
  - Guest → practice → upgrade to account (data migrates)
- [ ] Fix any bugs found
- [ ] Test on 3+ different Android devices (different brands, OS versions)

**Days 3-4: Beta Build**

- [ ] Create production-ready build:
  ```bash
  eas build --profile preview --platform android
  ```
- [ ] Test build on physical device (install APK)
- [ ] Verify everything works in standalone build (not Expo Go)
- [ ] Upload to Google Play Console Internal Testing track
- [ ] Create shareable link for testers

**Days 5-6: Beta Recruitment & Materials**

- [ ] Write beta tester guide:
  - What to test (onboarding, practice, reflection)
  - How to report bugs (Google Form)
  - What feedback is helpful (specific issues, not just "I like it")
- [ ] Create feedback form (Google Forms):
  - Did you complete onboarding? (Yes/No)
  - Did you complete a practice session? (Yes/No)
  - Presence rating for your session (1-5)
  - Any confusing moments? (Text)
  - Any bugs encountered? (Text)
  - Would you use this regularly? (Yes/Maybe/No)
  - Suggestions for improvement (Text)
- [ ] Recruit 15-20 beta testers:
  - Friends/family (5-7)
  - Reddit: r/meditation, r/mindfulness (5-7)
  - Facebook groups (3-5)
- [ ] Send each tester: Installation link + Beta guide + Feedback form

**Checkpoint 7:** Beta build distributed to 15-20 testers, all materials sent

---

#### Active Beta Testing

**Days 7-14: Testing Period**

**Daily Tasks:**

- [ ] Monitor feedback form responses
- [ ] Respond to tester questions within 12 hours
- [ ] Log all bugs in spreadsheet:
  - Bug description
  - Device/OS
  - Steps to reproduce
  - Severity (Critical / Major / Minor)
  - Status (Open / Fixed / Won't Fix)
- [ ] Encourage testers to complete 3+ sessions

**Key Metrics to Track:**

- Onboarding completion rate (Target: 90%+)
- First session completion rate (Target: 70%+)
- Second session within 7 days (Target: 40%+)
- Average presence rating (Target: 3.0+)
- Most common confusion points
- Most common feature requests

**Bug Fixing:**

- [ ] Prioritize critical bugs (crashes, audio failures, data loss)
- [ ] Fix critical bugs immediately
- [ ] Group similar bugs to identify root causes
- [ ] Push updates to Internal Testing track
- [ ] Notify testers of updates
- [ ] Verify fixes with testers who reported issues

**Common Issues to Watch For:**

- Audio doesn't play (check codec, permissions)
- App crashes on specific devices (device-specific bugs)
- Timer inaccurate (JavaScript timing issues)
- Progress doesn't save (Firebase connection)
- Navigation confusing (UX issues)
- Text overflow on small screens (layout)

**UX Refinements Based on Feedback:**

- [ ] If onboarding too long → shorten or make skippable
- [ ] If puzzle system unclear → add tooltip/explanation
- [ ] If accidental exits common → make confirmation more prominent
- [ ] If users confused about next step → add guidance

**Checkpoint 8:** All critical bugs fixed, major bugs addressed, UX improved based on real feedback

---

### WEEK 9-10: Polish & MVP Launch

#### Performance Optimization

**Days 1-2: Performance Audit**

- [ ] Profile app with React DevTools Profiler
- [ ] Identify slow screens (>1 second load time)
- [ ] Check for memory leaks:
  - Navigate between screens 20 times
  - Check if memory usage keeps increasing
- [ ] Optimize heavy components:
  - Memoize expensive calculations
  - Use `React.memo()` for pure components
  - Lazy load non-critical components
- [ ] Test home screen loads <500ms
- [ ] Test practice screen starts audio <2s
- [ ] Check APK size (<80MB target)

**Days 3-4: Visual Polish**

- [ ] Review every screen for consistency:
  - Button styles match design system
  - Typography consistent (sizes, weights, colors)
  - Spacing follows 8px grid
- [ ] Add subtle animations:
  - Button press feedback (scale 0.95)
  - Screen transitions (fade/slide)
  - Card hover states
- [ ] Test on small screens (5-inch) and large screens (6.5-inch)
- [ ] Fix any layout issues

**Days 5-6: Content Final Review**

- [ ] Proofread all text:
  - Onboarding copy
  - Button labels
  - Instructions
  - Quotes (all 30)
  - Error messages
- [ ] Fix typos and improve clarity
- [ ] Test all copy fits on small screens
- [ ] Have someone else proofread (fresh eyes)

**Checkpoint 9:** App performs smoothly, looks polished, content error-free

---

#### Error Handling & Edge Cases

**Days 7-8: Comprehensive Error Handling**

- [ ] Add loading states to all screens that fetch data
- [ ] Add error states for network failures:
  - Friendly error message
  - Retry button
  - Fallback to cached data if available
- [ ] Add empty states:
  - Zero sessions completed (show encouragement)
  - No internet connection (explain offline mode)
- [ ] Test all error scenarios:
  - Airplane mode
  - Poor network (throttle to 2G in Chrome DevTools)
  - Interrupted downloads
- [ ] Implement Firebase Crashlytics
- [ ] Test that crashes get reported
- [ ] Add user-friendly crash recovery (auto-restart from last state)

**Days 9-10: Final QA**

- [ ] Run through entire app as new user (fresh install)
- [ ] Test as returning user (with existing data)
- [ ] Test edge cases:
  - Complete session with 0 minutes remaining (immediate reflection)
  - Start session, immediately exit (confirm dialog works)
  - Sign up with already-used email (proper error)
  - Pause session, lock phone for 10 minutes, resume
- [ ] Fix any issues found

**Checkpoint 10:** All edge cases handled, no crashes, error messages helpful

---

#### Production Deployment

**Days 1-2: App Store Assets**

- [ ] Design app icon (1024×1024px):
  - Use forest green/ocean blue color scheme
  - Simple, recognizable at small sizes
  - No text in icon
- [ ] Create 5-7 screenshots:
  1. Home screen with level cards
  2. Practice screen with timer
  3. Reflection screen
  4. Profile with mandala progress
  5. Optional: Onboarding highlight
  6. Optional: Quote during practice
- [ ] Write app description:
  - **Short (80 chars):** "Find peace within noise. Sound-based mindfulness for the real world."
  - **Long (4000 chars):**
    - What is AwAir? (unique approach)
    - How it works (3 levels, progressive difficulty)
    - Who it's for (urban dwellers, parents, office workers)
    - Features (practice tracking, visual rewards, personalized)
    - Scientific backing (brief mention)
- [ ] Select keywords for ASO:
  - Primary: mindfulness, meditation, noise, sound meditation
  - Secondary: stress relief, anxiety, urban meditation, focus
- [ ] Set category: Health & Fitness
- [ ] Set content rating: Everyone

**Days 3-4: Legal Requirements**

- [ ] Write Privacy Policy:
  - Use template (termsfeed.com or similar)
  - Customize for AwAir:
    - Data collected: email, practice sessions, reflections
    - Data usage: app functionality, analytics
    - Data sharing: none (except Firebase)
    - User rights: access, deletion, export
- [ ] Host privacy policy:
  - Create simple GitHub Pages site
  - Add privacy policy as `/privacy.html`
- [ ] Write Terms of Service (use template, customize)
- [ ] Host ToS at `/terms.html`
- [ ] Add links in app Settings screen
- [ ] Add links to app store listing

**Days 5-6: Analytics Setup**

- [ ] Configure Firebase Analytics events:
  ```javascript
  // Log key events
  analytics().logEvent('onboarding_started');
  analytics().logEvent('onboarding_completed');
  analytics().logEvent('session_started', { level, duration });
  analytics().logEvent('session_completed', {
    level,
    duration,
    presenceRating,
  });
  analytics().logEvent('puzzle_piece_unlocked', { level, pieceNumber });
  ```
- [ ] Test events fire correctly (view in Firebase Console DebugView)
- [ ] Create custom dashboard with key metrics:
  - Daily active users
  - Session completion rate
  - Average presence rating
  - Retention curve

**Days 7-8: Production Firebase Environment**

- [ ] Create separate Firebase project for production (keep dev project separate)
- [ ] Configure Firestore security rules:
  ```javascript
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      match /users/{userId} {
        allow read, write: if request.auth.uid == userId;
      }
      match /soundscapes/{soundscapeId} {
        allow read: if request.auth != null;
        allow write: if false; // Admin only
      }
    }
  }
  ```
- [ ] Configure Storage security rules:
  ```javascript
  rules_version = '2';
  service firebase.storage {
    match /b/{bucket}/o {
      match /audio/{allPaths=**} {
        allow read: if request.auth != null; // Authenticated users only
        allow write: if false; // Admin only
      }
    }
  }
  ```
- [ ] Test security rules (try to access other user's data - should fail)

**Days 9-10: Production Build & Launch**

- [ ] Build production APK:
  ```bash
  eas build --profile production --platform android
  ```
- [ ] Test production build thoroughly:
  - Install on fresh device
  - Complete full onboarding
  - Practice 2-3 sessions
  - Verify all features work
  - Check Firestore writes are happening
- [ ] Upload to Google Play Console Production track
- [ ] Fill out all store listing details
- [ ] Submit for review
- [ ] Monitor review status (typically 1-3 days)

**Checkpoint 11:** App submitted to Google Play Store, awaiting approval

---

### PHASE 1 DELIVERABLES CHECKLIST

**Technical:**

- [x] Android app built with React Native + Expo
- [x] Firebase backend configured (Auth, Firestore, Storage, Analytics)
- [x] Audio playback working (bundled Level 1 tracks)
- [x] Background audio and lock screen support
- [x] Interruption handling (calls, alarms)
- [x] 5 contexts implemented (Auth, Progress, Audio, Onboarding, Challenge)
- [x] Navigation working (onboarding → main → practice → reflection)

**Content:**

- [x] 2 Level 1 audio tracks (Forest Dawn, Ocean Whisper)
- [x] 30 quotes for practice sessions
- [x] Onboarding copy (5 phases)
- [x] Reflection questions and prompts

**Features:**

- [x] Complete onboarding flow (5 phases)
- [x] Home screen with level selection
- [x] Practice screen with timer and quotes
- [x] Reflection screen with presence rating
- [x] Progress tracking (sessions, minutes, streak)
- [x] Mandala reward system (0-10 pieces)
- [x] Guest mode and account creation
- [x] Data persistence (Firestore + AsyncStorage)

**Quality:**

- [x] Beta tested with 15-20 users
- [x] All critical bugs fixed
- [x] Performance optimized (<500ms home screen load)
- [x] Error handling comprehensive
- [x] Privacy policy and ToS written and hosted
- [x] Analytics configured and tested

**Launch:**

- [x] App icon designed
- [x] Screenshots created (5-7)
- [x] App description written and optimized
- [x] Submitted to Google Play Store
- [x] Approved and live

---

### PHASE 1 SUCCESS VALIDATION

**Before proceeding to Phase 2, verify:**

1. **Usage Metrics:**

   - [ ] 70%+ of downloads complete onboarding
   - [ ] 70%+ complete first practice session
   - [ ] 40%+ return for second session within 7 days
   - [ ] Average presence rating 3.0+

2. **Technical Metrics:**

   - [ ] Zero critical bugs reported
   - [ ] Crash rate <0.1% (Firebase Crashlytics)
   - [ ] Average session completion rate 80%+

3. **Qualitative Feedback:**
   - [ ] Users understand the core concept
   - [ ] Users find value in practice
   - [ ] Users want more content (good signal for Phase 2)

**If metrics NOT met:**

- **Low onboarding completion:** Simplify onboarding (reduce to 3 phases)
- **Low session completion:** Improve audio quality or add more guidance
- **Low return rate:** Add push notifications, improve reward system
- **Low presence ratings:** Practice might be too difficult, add easier option

**Decision point:** Only proceed to Phase 2 if retention (40% 7-day) is met. Otherwise, iterate on Phase 1 until validated.

---

## PHASE 2: COMPLETE PRODUCT (WEEKS 11-18)

### Overarching Goal

**Expand to full 3-level system, launch iOS, add all planned features for complete 1.0 product.**

### Success Criteria

- 5,000 downloads within first month of full launch
- 30% of users progress to Level 2
- 10% of users unlock Level 3 (premium)
- 3% premium conversion rate
- 4.2+ star average rating
- 25% 7-
day retention
- 15% 30-day retention

---

### WEEK 11-12: Level 2 Production & Implementation

#### Audio Production

**Days 1-3: Source Mixed Sounds**
- [ ] Download pleasant sounds (40+ files):
  - Birds (continued variety)
  - Water sounds (fountains, gentle rain)
  - Soft instrumental music (royalty-free)
  - Nature ambience
- [ ] Download challenging sounds (40+ files):
  - Urban traffic (moderate volume)
  - Distant conversations
  - Office ambience (typing, phones)
  - Light construction
  - Occasional sirens (distant)
- [ ] Organize into intensity folders (low/medium/high)
- [ ] Document all sources and licenses

**Days 4-7: Create Track 1 - "Park Life"**
- [ ] Base layer: Park ambience (moderate activity)
- [ ] Pleasant layer: Birds singing (60% prominence)
- [ ] Challenging layer: Distant traffic (20% prominence)
- [ ] Pleasant layer: Children playing (very distant, 10%)
- [ ] Challenging layer: Occasional dog bark (distant, 10%)
- [ ] Mix strategy:
  - Start pleasant-heavy (80/20)
  - Gradually introduce more challenging (60/40)
  - End balanced (50/50)
- [ ] Export 20-minute master
- [ ] Convert to OGG 96kbps
- [ ] Quality check: challenging sounds noticeable but not overwhelming

**Days 8-10: Create Track 2 - "Café Corner"**
- [ ] Base: Café background (cups clinking, low murmur)
- [ ] Pleasant: Soft acoustic guitar (very subtle, -26dB)
- [ ] Challenging: Espresso machine sounds (every 2-3 min)
- [ ] Challenging: Conversation peaks (occasional)
- [ ] Pleasant: Jazz undertones (barely perceptible)
- [ ] Mix strategy: Dynamic—café quiet periods, busier periods
- [ ] Test that it feels like real café (not studio recreation)
- [ ] Export and quality check

**Days 11-12: Create Tracks 3-4**
- [ ] Track 3: "Library Hum" (HVAC, pages, footsteps, whispers)
- [ ] Track 4: "Garden with City" (nature + distant sirens + airplane)
- [ ] Both 20 minutes, OGG 96kbps

**Checkpoint 12:** 4 Level 2 tracks complete, properly balanced difficulty

---

#### Development Tasks

**Days 1-3: Level 2 Integration**
- [ ] Upload 4 Level 2 tracks to Firebase Storage:
  ```
  /audio/level2/park_life_20min.ogg
  /audio/level2/cafe_corner_20min.ogg
  /audio/level2/library_hum_20min.ogg
  /audio/level2/garden_city_20min.ogg
  ```
- [ ] Create metadata in Firestore:
  ```javascript
  soundscapes/park_life: {
    soundscapeId: 'park_life',
    title: 'Park Life',
    level: 2,
    duration: 1200,
    bundled: false, // Streamed, not bundled
    remoteUri: 'https://storage.googleapis.com/awair-prod/audio/level2/park_life_20min.ogg',
    fileSize: 18500000, // ~18MB
    description: 'Birds and breeze mixed with distant traffic',
    difficulty: 'moderate',
    tags: ['nature', 'urban', 'birds', 'traffic'],
  }
  ```
- [ ] Update HomeScreen to show Level 2 tracks
- [ ] Implement unlock logic:
  ```javascript
  const level2Unlocked = progress.levels.level1.rewardComplete;
  ```

**Days 4-6: Download & Caching System**
- [ ] Create `services/AudioCacheService.js`:
  ```javascript
  class AudioCacheService {
    async downloadTrack(soundscapeId, remoteUri) {
      const localUri = FileSystem.documentDirectory + `${soundscapeId}.ogg`;
      
      // Check if already cached
      const info = await FileSystem.getInfoAsync(localUri);
      if (info.exists) return localUri;
      
      // Download with progress callback
      const downloadResumable = FileSystem.createDownloadResumable(
        remoteUri,
        localUri,
        {},
        (progress) => {
          const percent = (progress.totalBytesWritten / progress.totalBytesExpectedToWrite) * 100;
          // Update UI with progress
        }
      );
      
      await downloadResumable.downloadAsync();
      
      // Save to cache registry
      await AsyncStorage.setItem(`cache_${soundscapeId}`, localUri);
      
      return localUri;
    }
    
    async getCachedTrack(soundscapeId) {
      const localUri = await AsyncStorage.getItem(`cache_${soundscapeId}`);
      if (!localUri) return null;
      
      const info = await FileSystem.getInfoAsync(localUri);
      return info.exists ? localUri : null;
    }
    
    async clearCache() {
      // Delete all cached audio files
    }
    
    async getCacheSize() {
      // Calculate total cache size
    }
  }
  ```
- [ ] Update AudioContext to use cache:
  ```javascript
  const loadTrack = async (soundscapeData, duration) => {
    let audioUri;
    
    if (soundscapeData.bundled) {
      // Use bundled asset
      audioUri = require(`../assets/audio/${soundscapeData.audioUri}`);
    } else {
      // Check cache first
      const cachedUri = await AudioCacheService.getCachedTrack(soundscapeData.soundscapeId);
      
      if (cachedUri) {
        audioUri = { uri: cachedUri };
      } else {
        // Download and cache
        const localUri = await AudioCacheService.downloadTrack(
          soundscapeData.soundscapeId,
          soundscapeData.remoteUri
        );
        audioUri = { uri: localUri };
      }
    }
    
    // Load audio
    const { sound } = await Audio.Sound.createAsync(audioUri);
    setSound(sound);
  };
  ```
- [ ] Add download progress indicator to UI
- [ ] Test download over WiFi and cellular

**Days 7-9: Level 2 Progress Tracking**
- [ ] Update ProgressContext for Level 2:
  - Track sessions, minutes, reward progress
  - Award 1 ring per 15 minutes (8 rings total = 120 minutes)
  - Check for completion (all 8 rings)
- [ ] Create ResonanceWavesAnimation component
- [ ] Implement wave ripple animation
- [ ] Test progression and reward unlock
- [ ] Verify Level 3 unlocks after Level 2 complete (but premium-gated)

**Days 10-12: Beta Test Level 2**
- [ ] Deploy updated app to beta testers
- [ ] Ask specific questions:
  - Is difficulty progression appropriate from Level 1 to Level 2?
  - Are challenging sounds too challenging or not enough?
  - Would you continue practicing Level 2?
  - Does the guidance help with acceptance?
- [ ] Collect feedback
- [ ] Adjust audio levels if needed (re-mix and re-upload)
- [ ] Fix any bugs reported

**Checkpoint 13:** Level 2 fully functional, download/cache working, beta-tested and refined

---

### WEEK 13-14: Level 3 Production & iOS Launch

#### Audio Production

**Days 1-3: Source Intense Sounds**
- [ ] Download urban intensity sounds (50+ files):
  - Heavy traffic, multiple lanes
  - Car horns (varied)
  - Emergency sirens (police, ambulance, fire)
  - Construction (jackhammers, drilling, machinery)
  - Crowds (dense, overlapping voices)
  - Public transit (buses, trains, announcements)
- [ ] Ensure no sounds are painful (respect volume safety)
- [ ] Document all sources

**Days 4-6: Create Track 1 - "Urban Rush"**
- [ ] Base: Downtown rush hour traffic (continuous, loud but not painful)
- [ ] Layer: Car horns (frequent, realistic)
- [ ] Layer: Siren (distant, occasional—3 times in 20 min)
- [ ] Layer: Crowd noise (dense, constant undercurrent)
- [ ] Layer: Bus brakes hissing (every 2-3 minutes)
- [ ] Layer: Construction in distance (sporadic)
- [ ] Mix strategy: Immersive urban soundscape, no relief
- [ ] Volume: Loud enough to be genuinely challenging
- [ ] Safety check: Never exceeds -3dB, test on headphones at max volume
- [ ] Export 20 minutes + 5-minute preview version

**Days 7-9: Create Tracks 2-3**
- [ ] Track 2: "Office Chaos"
  - Phones ringing (frequent)
  - Keyboard clicking (multiple people)
  - Conversations (overlapping)
  - Printer/copier sounds
  - Email notification sounds
- [ ] Track 3: "Transit Hub"
  - Train arrival/departure sounds
  - Announcements (realistic PA system)
  - Crowds (echoing in large space)
  - Machinery (escalators, ventilation)
  - Distant trains
- [ ] Both 20 minutes, OGG 96kbps
- [ ] Quality check: Challenging but not hostile

**Days 10-12: Quality Assurance for Level 3**
- [ ] Beta test Level 3 tracks:
  - Send to 5 beta testers who completed Level 2
  - Specific question: "Is this too intense or appropriately challenging?"
  - Track: How many complete full 20 minutes vs stop early
- [ ] If >50% stop early: Reduce intensity by 3-5dB
- [ ] If feedback is "too easy": Increase prominence of challenging sounds
- [ ] Re-export if needed
- [ ] Create 5-minute previews for each track (first 5 minutes, with fade-out)

**Checkpoint 14:** Level 3 audio complete, appropriately challenging, tested

---

#### iOS Development & Launch

**Days 1-2: iOS Environment Setup**
- [ ] Enroll in Apple Developer Program ($99/year)
- [ ] Wait for approval (24-48 hours typically)
- [ ] Set up App Store Connect account
- [ ] Create app listing in App Store Connect
- [ ] Generate necessary certificates and provisioning profiles

**Days 3-5: iOS-Specific Configuration**
- [ ] Add `GoogleService-Info.plist` to iOS folder
- [ ] Configure iOS bundle identifier (com.awair.app)
- [ ] Configure app icon for iOS (all required sizes)
- [ ] Configure splash screen for iOS
- [ ] Test on iOS Simulator
- [ ] Borrow/rent physical iPhone for testing
- [ ] Fix iOS-specific UI issues:
  - Safe area insets (notch handling)
  - Navigation bar differences
  - Different default fonts
  - Status bar styling

**Days 6-7: iOS App Store Assets**
- [ ] Create iOS screenshots (different aspect ratios):
  - iPhone 6.7" display (iPhone 14 Pro Max, 15 Pro Max)
  - iPhone 6.5" display (iPhone 11 Pro Max, XS Max)
  - iPhone 5.5" display (iPhone 8 Plus)
  - iPad Pro 12.9" (optional but recommended)
- [ ] Adjust app description for iOS audience (subtle tone differences)
- [ ] Write iOS-specific "What's New" section
- [ ] Prepare app preview video (optional, 30-second demo)

**Days 8-10: iOS Build & Submission**
- [ ] Build iOS production app:
  ```bash
  eas build --profile production --platform ios
  ```
- [ ] Download IPA file
- [ ] Upload to App Store Connect using Transporter app
- [ ] Fill out all metadata:
  - App name
  - Subtitle
  - Description
  - Keywords
  - Category (Health & Fitness)
  - Age rating
  - Privacy policy URL
  - Support URL
- [ ] Submit for review
- [ ] Respond to any review feedback

**Common Apple Rejection Reasons (Be Prepared):**
- Privacy policy not accessible (double-check URL works)
- In-app purchase not working (even if placeholder)
- UI looks incomplete (all placeholder text removed?)
- Metadata misleading (description matches actual functionality?)
- App crashes on specific iOS version (test on multiple versions)
- Missing required permission explanations (NSMicrophoneUsageDescription if needed)

**Days 11-12: Simultaneous Android Update**
- [ ] Add Level 3 to Android app
- [ ] Update version number (1.0.0 → 1.1.0)
- [ ] Write changelog:
  ```
  What's New:
  • Level 3: Mastery unlocked (Premium)
  • 3 intense urban soundscapes
  • Phoenix Constellation reward system
  • iOS version now available
  • Bug fixes and performance improvements
  ```
- [ ] Build and submit to Google Play
- [ ] Typically approved within hours

**Checkpoint 15:** iOS app approved and live, Android updated, both platforms at feature parity

---

### WEEK 15-16: Personalized Challenges & TapGames (Foundation)

#### Personalized Challenges Implementation

**Days 1-3: Sound Library Setup**
- [ ] Create sound library metadata in Firestore:
  ```javascript
  soundLibrary/traffic: {
    soundId: 'traffic',
    name: 'Traffic Noise',
    category: 'urban',
    description: 'Cars, horns, engines',
    icon: '🚗',
    intensityLevels: {
      low: 'audio/challenges/traffic_low.ogg',
      medium: 'audio/challenges/traffic_medium.ogg',
      high: 'audio/challenges/traffic_high.ogg',
    },
    isPremium: false, // First 2 sounds free
  }
  ```
- [ ] Create 20+ sound definitions (urban, voices, domestic, mechanical)
- [ ] Mark 2 as free (traffic, baby_crying), rest premium

**Days 4-6: Challenge Selection UI**
- [ ] Create `screens/ChallengesScreen.js`
- [ ] Show available sounds:
  - Grid or list view
  - Icon + name for each sound
  - Lock icon on premium sounds
- [ ] Implement selection modal:
  - Select sound from library
  - Choose intensity (low/medium/high)
  - Select duration (5, 10, 15, 20 minutes)
  - Choose base sound (forest, ocean, silence)
- [ ] Save selected challenges to Firestore:
  ```javascript
  users/{uid}/progress/challenges: {
    selectedSounds: ['traffic', 'baby_crying'],
    soundMastery: {
      traffic: {
        tier: 'bronze',
        totalSessions: 5,
        averagePresenceRating: 3.2,
        // ... full structure from earlier specification
      }
    }
  }
  ```

**Days 7-9: Challenge Practice Flow**
- [ ] Update PracticeScreen to handle challenge sessions
- [ ] Load challenge audio:
  - Base sound (forest/ocean) at low volume
  - Selected trigger sound at chosen intensity
  - Mix in real-time or use pre-mixed files
- [ ] For MVP: Use pre-mixed files (simpler):
  - Create 10 common combinations
  - Traffic + Forest (low, medium, high)
  - Baby + Ocean (low, medium, high)
  - Etc.
- [ ] Track challenge-specific data in session:
  ```javascript
  session: {
    type: 'challenge', // vs 'regular'
    challengeSound: 'traffic',
    intensity: 'medium',
    // ... rest of session data
  }
  ```

**Days 10-12: Sound Mastery Tracking**
- [ ] Update ProgressContext with sound mastery logic
- [ ] Implement tier progression:
  ```javascript
  const calculateMasteryTier = (soundData) => {
    const { totalSessions, averagePresenceRating } = soundData;
    
    if (totalSessions >= 50 && averagePresenceRating >= 4.5) return 'platinum';
    if (totalSessions >= 30 && averagePresenceRating >= 4.0) return 'gold';
    if (totalSessions >= 15 && averagePresenceRating >= 3.5) return 'silver';
    if (totalSessions >= 5 && averagePresenceRating >= 2.5) return 'bronze';
    return 'started';
  };
  ```
- [ ] Create sound mastery badges
- [ ] Display in Profile screen
- [ ] Test progression with dummy data

**Checkpoint 16:** Personalized challenges functional, sound mastery tracking implemented

---

#### TapGame Foundation (Basic Implementation)

**Note:** For Phase 2, implement 2 TapGames only (BirdTap, WavePulse). Remaining 3 games in Phase 3.

**Days 1-3: TapGame Audio Preparation**
- [ ] Create TapGame audio files:
  - BirdTap: 60-second forest with 12 distinct bird chirps
  - WavePulse: 90-second ocean with 10 wave crashes
- [ ] Manually document timestamps:
  ```json
  // birdtap_events.json
  {
    "gameId": "birdtap",
    "duration": 60,
    "events": [
      { "eventId": "bird_chirp", "time": 5.2 },
      { "eventId": "bird_chirp", "time": 10.8 },
      // ... 12 total
    ]
  }
  ```
- [ ] Save events JSON to Firebase Storage

**Days 4-6: TapGame UI**
- [ ] Create `screens/TapGameScreen.js`
- [ ] Implement game UI:
  - Large circular tap target (150×150dp)
  - Timer countdown (top-right)
  - Score display (top-left)
  - Event dots at bottom (○ = upcoming, ● = completed)
  - Audio waveform visualization
- [ ] Implement tap handling:
  ```javascript
  const handleTap = (tapTime) => {
    const matchedEvent = events.find(event => {
      const diff = Math.abs(tapTime - event.time * 1000);
      return diff < TOLERANCE_MS; // 300ms window
    });
    
    if (matchedEvent) {
      setScore(score + 1);
      showCorrectFeedback(); // Green flash + vibration
    } else {
      showMissFeedback(); // No feedback (not negative)
    }
  };
  ```
- [ ] Add visual feedback animations
- [ ] Test tap detection accuracy

**Days 7-9: TapGame Integration**
- [ ] Add TapGame prompt to post-reflection flow:
  ```javascript
  // After reflection submitted
  if (Math.random() < 0.7) { // 70% of time, suggest TapGame
    showTapGamePrompt({
      gameId: selectRandomGame(['birdtap', 'wavepulse']),
      duration: 60,
    });
  }
  ```
- [ ] Create TapGame selection screen (access from bottom tab)
- [ ] Show "Unlocks after first session" message for new users
- [ ] Track TapGame stats:
  ```javascript
  users/{uid}/tapgames/birdtap: {
    gamesPlayed: 12,
    totalScore: 98,
    totalPossible: 144,
    averageAccuracy: 68.1,
    bestAccuracy: 91.7,
  }
  ```

**Days 10-12: Testing & Refinement**
- [ ] Beta test TapGames with 10 users
- [ ] Questions:
  - Is the concept clear?
  - Is difficulty appropriate?
  - Does it feel like a meaningful addition or distraction?
  - Would you play it regularly?
- [ ] Adjust tolerance window based on feedback
- [ ] Refine audio if events hard to hear
- [ ] Fix any bugs

**Checkpoint 17:** 2 TapGames working, integrated into post-practice flow, tested

---

### WEEK 17-18: Educational Content & Final Polish

#### Educational Content Development

**Days 1-3: "Science of Sound" Interactive Module**
- [ ] Write content for 5 sections:
  1. Why Noise Stresses You (30 seconds)
     - Brain diagram showing amygdala activation
     - Explanation of fight-or-flight response
  2. The Old Solution: Escape (30 seconds)
     - Noise-canceling headphones, closed doors
     - Why avoidance doesn't work long-term
  3. The New Solution: Acceptance (1 minute)
     - Ocean wave analogy
     - Changing relationship vs changing environment
  4. The Neuroscience (1 minute)
     - Neuroplasticity explanation
     - Before/after brain pathway diagram
  5. Your Practice (1 minute)
     - How 3 levels train this skill
     - Each session = brain rewiring practice
- [ ] Create simple illustrations for each section
- [ ] Write in accessible language (8th-grade reading level)

**Days 4-6: Build Interactive Module**
- [ ] Create `screens/learn/ScienceOfSoundScreen.js`
- [ ] Implement as swipeable cards or scrollable sections
- [ ] Add tap-to-continue between sections
- [ ] Include optional quiz at end:
  - 3 simple questions to reinforce learning
  - Correct answers show encouraging message
- [ ] Award bonus puzzle piece for completion
- [ ] Test that unlock happens after 3 sessions

**Days 7-9: Write Three Educational Articles**
- [ ] Article 1: "Why Noise Stresses You (And What To Do About It)" (500 words)
  - Evolutionary biology of sound perception
  - Fight-or-flight activation mechanisms
  - Why avoidance backfires
  - Mindful listening as intervention
  - Include 2-3 scientific study references
- [ ] Article 2: "The Metaphor That Changed Everything" (400 words)
  - Deep dive into ocean wave analogy
  - Apply to sound: can't control soundscape, can control response
  - Personal story format (relatable)
  - Actionable takeaways
- [ ] Article 3: "Real Users, Real Noise, Real Peace" (600 words)
  - Three case studies (composite fictional users)
  - Urban professional, parent, student
  - Problem → Practice → Transformation format
- [ ] Proofread and edit for clarity

**Days 10-12: Learn Section Implementation**
- [ ] Create Learn screen with three tabs:
  - **Tab 1: Getting Started** (always accessible)
    - "What is AwAir?" (2 min)
    - "How to Practice Effectively" (3 min)
    - "Understanding the Levels" (2 min)
  - **Tab 2: The Science** (unlocks after 1st session)
    - "Science of Sound" interactive module
    - Three educational articles
  - **Tab 3: Quick Guides** (always accessible)
    - Audio setup tips
    - Posture & environment
    - Building daily practice
- [ ] Implement unlock logic
- [ ] Add bookmarking functionality
- [ ] Track article reads in analytics

**Checkpoint 18:** Educational content complete, Learn section fully implemented

---

#### Final Phase 2 Polish

**Days 1-2: App Store Optimization (ASO)**
- [ ] Research competitor keywords:
  - Analyze Headspace, Calm, Insight Timer descriptions
  - Identify gaps ("sound meditation," "noise mindfulness")
- [ ] Update app descriptions with researched keywords
- [ ] Optimize screenshots with text overlays:
  - "Find Peace Within Noise"
  - "Progressive Sound Training"
  - "Track Your Growth"
- [ ] A/B test different screenshot orders (if platform allows)

**Days 3-4: Performance Final Check**
- [ ] Profile app one more time
- [ ] Ensure all screens load <1 second
- [ ] Check APK/IPA sizes (Android <100MB, iOS <120MB)
- [ ] Test on low-end devices (3+ years old)
- [ ] Optimize if performance issues found

**Days 5-6: Comprehensive QA**
- [ ] Test complete user journeys:
  - New user: Onboarding → Level 1 → Level 2 → Premium paywall
  - Returning user: Open app → Continue practice → Complete session
  - Premium user: Access Level 3 → Complete constellation
  - Challenge user: Create challenge → Practice → Mastery progress
  - TapGame user: Play game → View stats → Play different game
- [ ] Test edge cases:
  - Interrupted sessions (calls, alarms)
  - Offline mode (cached tracks work)
  - Account switching (data isolates correctly)
  - Cache clearing (re-downloads work)
- [ ] Fix any issues

**Days 7-8: Analytics & Monitoring Setup**
- [ ] Set up Firebase Performance Monitoring
- [ ] Create dashboards for key metrics:
  - Daily/Weekly/Monthly active users
  - Session completion rates by level
  - Premium conversion funnel
  - TapGame engagement rate
  - Retention curves (D1, D7, D30)
- [ ] Set up alerts:
  - Crash rate >1%
  - Session completion rate drops >10%
  - Premium conversion drops >20%
- [ ] Document how to access and interpret dashboards

**Days 9-10: Launch Preparation**
- [ ] Prepare launch announcement:
  - Blog post (if have blog)
  - Social media posts (Twitter, Instagram, Facebook)
  - Reddit posts (schedule for optimal times)
  - Product Hunt launch (create listing)
- [ ] Prepare press kit:
  - App icon (high-res)
  - Screenshots (all platforms)
  - App description
  - Founder story
  - Press release template
- [ ] Set up support email (support@awair.app)
- [ ] Create FAQ document
- [ ] Prepare for increased support volume

**Checkpoint 19:** App fully polished, analytics in place, launch materials ready

---

### PHASE 2 DELIVERABLES CHECKLIST

**Technical:**
- [x] iOS app launched (App Store approved)
- [x] Android app updated to 1.1.0
- [x] Complete 3-level system (11 audio tracks total)
- [x] Download and caching system working
- [x] Personalized challenges functional
- [x] 2 TapGames implemented (BirdTap, WavePulse)
- [x] Sound mastery tracking operational
- [x] Performance optimized (<1s screen loads)

**Content:**
- [x] 4 Level 2 tracks (Park Life, Café Corner, Library Hum, Garden with City)
- [x] 3 Level 3 tracks (Urban Rush, Office Chaos, Transit Hub)
- [x] 20+ trigger sounds for personalized challenges
- [x] "Science of Sound" interactive module
- [x] 3 educational articles
- [x] 2 TapGame audio files with event metadata

**Features:**
- [x] Level 2 with Resonance Waves reward (8 rings)
- [x] Level 3 with Phoenix Constellation reward (7 stars)
- [x] Personalized challenge creation and practice
- [x] Sound mastery progression (Bronze/Silver/Gold/Platinum)
- [x] TapGames (2 free games)
- [x] Learn section with tiered unlocking
- [x] Offline mode for all cached content
- [x] Cross-platform parity (iOS + Android feature-identical)

**Business:**
- [x] Premium paywall implemented (blocks Level 3)
- [x] RevenueCat integration complete
- [x] Monthly ($3.99) and Annual ($23.99) pricing configured
- [x] 7-day free trial active
- [x] Analytics tracking all key events

**Quality:**
- [x] Tested on 5+ iOS devices, 5+ Android devices
- [x] All critical and major bugs fixed
- [x] App Store and Play Store listings optimized
- [x] Support infrastructure in place

---

### PHASE 2 SUCCESS VALIDATION

**Before proceeding to Phase 3, verify:**

1. **Download Metrics:**
   - [ ] 5,000 total downloads achieved within 30 days of full launch
   - [ ] 60%+ from organic (not paid ads)

2. **Engagement Metrics:**
   - [ ] 30%+ progress to Level 2
   - [ ] 10%+ unlock Level 3 (attempt, regardless of purchase)
   - [ ] 25% 7-day retention
   - [ ] 15% 30-day retention

3. **Monetization Metrics:**
   - [ ] 3%+ premium conversion rate
   - [ ] Average trial-to-paid conversion 25%+
   - [ ] Monthly churn <10%

4. **Quality Metrics:**
   - [ ] 4.2+ star average rating (both stores)
   - [ ] Crash rate <0.5%
   - [ ] <5% negative reviews mentioning bugs

**If metrics NOT met:**
- **Low downloads:** Focus Phase 3 entirely on marketing, not features
- **Low progression:** Level 1 might be too satisfying, add teaser for Level 2
- **Low conversion:** Test different pricing ($2.99 monthly?) or improve paywall
- **Low retention:** Add push notifications, improve streak system, more guidance

**Decision point:** Proceed to Phase 3 regardless (unless critical bugs). Phase 3 is about optimization, not new features.

---

## PHASE 3: GROWTH & OPTIMIZATION (WEEKS 19-26)

### Overarching Goal
**Achieve product-market fit through marketing, optimize conversion funnel, establish revenue sustainability.**

### Success Criteria
- 10,000 total downloads
- $2,000+ monthly recurring revenue (500+ premium subscribers)
- 5% premium conversion rate
- 20% 30-day retention
- 4.5+ star average rating
- Profitable unit economics (LTV > CAC)

---

### WEEK 19-20: Premium Optimization & Advanced Analytics

#### RevenueCat Deep Integration

**Days 1-2: Subscription Event Handling**
- [ ] Implement webhook listener for RevenueCat events:
  ```javascript
  // Cloud Function
  exports.handleSubscriptionEvent = functions.https.onRequest(async (req, res) => {
    const event = req.body;
    
    switch (event.type) {
      case 'INITIAL_PURCHASE':
        await handleNewSubscription(event);
        break;
      case 'RENEWAL':
        await handleRenewal(event);
        break;
      case 'CANCELLATION':
        await handleCancellation(event);
        break;
      case 'BILLING_ISSUE':
        await handleBillingIssue(event);
        break;
    }
    
    res.sendStatus(200);
  });
  ```
- [ ] Update Firestore on subscription events
- [ ] Send user notifications for important events (renewal, expiration)
- [ ] Test webhook with RevenueCat sandbox

**Days 3-5: Paywall A/B Testing**
- [ ] Set up Firebase Remote Config for paywall variants
- [ ] Create 3 paywall variations:
  - **Variant A (Control):** Current design
  - **Variant B (Social Proof Lead):** Lead with "Join 500+ members"
  - **Variant C (Trial Emphasis):** Highlight "7-Day Free Trial" prominently
- [ ] Implement variant assignment (33% each)
- [ ] Track conversion rate per variant
- [ ] Run for 2 weeks minimum (statistical significance)

**Days 6-8: Grace Period & Billing Issues**
- [ ] Implement grace period handling:
  - User's payment fails → RevenueCat gives 3-7 day grace period
  - User retains premium access during grace period
  - Show "Update Payment Method" banner
  - Send push notification reminder
- [ ] Test with sandbox account (simulate failed payment)
- [ ] Implement smooth downgrade when grace period expires

**Checkpoint 20:** Subscription system robust, A/B testing active, billing issues handled gracefully

---

#### Advanced Analytics Dashboard (Premium Feature)

**Days 1-3: Analytics Data Pipeline**
- [ ] Create Cloud Function to calculate analytics:
  ```javascript
  // Runs daily at midnight
  exports.calculateUserAnalytics = functions.pubsub
    .schedule('0 0 * * *')
    .onRun(async (context) => {
      const users = await admin.firestore().collection('users').get();
      
      for (const userDoc of users.docs) {
        const userId = userDoc.id;
        const sessions = await getSessions(userId, last30Days);
        
        const analytics = {
          weekly