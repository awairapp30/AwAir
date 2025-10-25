### 📄 `state-and-screen-architecture.md`

This file defines:

- The **state contexts** that power the app (`AuthContext`, `ProgressContext`, etc.)
- How **screens consume and update state**
- **Navigation structure** and screen responsibilities
- **Provider hierarchy** and data flow

All based strictly on your blueprint.

---

**Content of `state-and-screen-architecture.md`:**

````md
# State and Screen Architecture

AwAir uses a **context-driven state architecture** tightly coupled with an **8-screen navigation flow**. This document defines both systems together because screens directly consume and mutate state.

## Context Architecture (Phase 1: React Context API)

### 1. `AuthContext` — Identity & Account State

**State Shape**:

```ts
{
  user: {
    uid: string | null,
    email: string | null,
    displayName: string | null,
    isGuest: boolean,
    isPremium: boolean,
    premiumExpiresAt: timestamp | null,
  },
  loading: boolean,
  error: string | null
}
```
````

**Key Actions**:

- `signUp(email, password)`
- `signInWithGoogle()`
- `continueAsGuest()`
- `upgradeGuestToAccount(email, password)`
- `checkPremiumStatus()`

**Used By Screens**:

- `WelcomeOnboarding` → `continueAsGuest()` or `signUp()`
- `Home` → Shows "Sign in" CTA if guest
- `Profile` → Account management, subscription status

---

### 2. `ProgressContext` — Practice & Achievement State

**State Shape**:

```ts
{
  progress: {
    totalSessions: number,
    totalMinutes: number,
    currentStreak: number,
    levels: {
      level1: { sessionsCompleted, rewardProgress, rewardComplete, ... },
      level2: { ... },
      level3: { ... }
    },
    challenges: {
      selectedSounds: string[],
      soundMastery: Record<string, SoundMastery>
    },
    achievements: {
      unlocked: string[],
      unlockedDates: Record<string, timestamp>
    }
  },
  loading: boolean,
  syncing: boolean
}
```

**Key Actions**:

- `completeSession(sessionData)` → updates streak, levels, achievements
- `getNextReward(level)` → returns pieces/rings/stars earned
- `updateSoundMastery(soundId, sessionData)`

**Used By Screens**:

- `Practice Session` → calls `completeSession()` on finish
- `Home` → shows level progress, streak, "Continue Practice"
- `Profile` → displays full stats, achievements, sound mastery
- `Reflection` → submits data to `completeSession()`

---

### 3. `AudioContext` — Playback & Session State

**State Shape**:

```ts
{
  sound: Audio.Sound | null,
  isPlaying: boolean,
  isPaused: boolean,
  currentTime: number, // seconds
  duration: number,   // seconds
  soundscapeId: string | null,
  level: number | null,
  selectedDuration: number | null // minutes
}
```

**Key Actions**:

- `loadTrack(soundscapeData, durationMinutes)`
- `play()`, `pause()`, `stop()`
- `setVolume(volume)`

**Used By Screens**:

- `Practice Session` → full control (play/pause/stop)
- `Practice Introduction` → pre-loads track
- `Reflection` → stops audio on submit

---

### 4. `OnboardingContext` — First-Time Flow

**State Shape**:

```ts
{
  completed: boolean,
  currentPhase: 1 | 2 | 3 | 4 | 5,
  volumeCalibrated: boolean,
  safetyAcknowledged: boolean
}
```

**Used By Screens**:

- `WelcomeOnboarding` → tracks phase completion
- `App` root → blocks main app until `completed: true`

---

### 5. `ChallengeContext` — Personalized Sound Mixing

**State Shape**:

```ts
{
  selectedSounds: string[], // ['traffic', 'babies_crying']
  activeMix: {
    sounds: string[],
    intensityLevels: Record<string, number> // 0.0–1.0
  }
}
```

**Used By Screens**:

- `Home` → "Your Sound Challenges" card
- `Practice` → filters tracks by selected sounds
- `Challenge Setup` → configures intensity

---

## Provider Hierarchy

**App.js Structure**:

```tsx
<AuthProvider>
  <ProgressProvider>
    <AudioProvider>
      <OnboardingProvider>
        <ChallengeProvider>
          <NavigationContainer>
            <AppNavigator />
          </NavigationContainer>
        </ChallengeProvider>
      </OnboardingProvider>
    </AudioProvider>
  </ProgressProvider>
</AuthProvider>
```

**Why This Order**:

- `AuthProvider` outermost: all other contexts need user identity
- `ProgressProvider` depends on auth (loads user-specific data)
- `AudioProvider` uses auth preferences (max volume)
- `OnboardingProvider` checks auth + progress to decide if needed
- `ChallengeProvider` uses all above for sound mixing

---

## Screen Architecture & State Usage

### Screen 1: `WelcomeOnboarding` (Modal)

**State Used**:

- `OnboardingContext` → tracks current phase
- `AuthContext` → calls `continueAsGuest()` or `signUp()`

**Navigation Trigger**: Completes → sets `onboarding.completed = true` → navigates to `Home`

---

### Screen 2: `Home` (Bottom Tab)

**State Used**:

- `AuthContext` → shows guest vs premium UI
- `ProgressContext` → displays stats, level progress, streak
- `ChallengeContext` → shows active challenges

**Key Logic**:

- "Continue Practice" card appears if `progress.lastSessionDate` exists
- Level 2 unlocks when `progress.levels.level1.rewardComplete === true`
- Level 3 shows premium paywall if `!user.isPremium`

**Navigation Triggers**:

- Tap "START" → `Practice Introduction` modal
- Tap "Practice" tab → `Practice` screen
- Tap "Learn" tab → `Learn` screen

---

### Screen 3: `Practice` (Bottom Tab)

**State Used**:

- `AuthContext` → shows premium content if `isPremium`
- `ChallengeContext` → filters tracks by selected sounds
- `AudioContext` → pre-loads on "START"

**Navigation Trigger**: Tap "START" → `Practice Introduction` modal

---

### Screen 4: `Learn` (Bottom Tab)

**State Used**:

- `AuthContext` → unlocks articles based on `isPremium` and session count
- `ProgressContext` → shows reflection count

**Navigation Triggers**:

- Tap reflection → full journal entry
- Tap article → article reader

---

### Screen 5: `Profile` (Bottom Tab)

**State Used**:

- `AuthContext` → displays account info, subscription
- `ProgressContext` → shows full stats, achievements, sound mastery
- `ChallengeContext` → lists active challenges

**Navigation Triggers**:

- Tap "Upgrade" → Paywall modal
- Tap "Sound Mastery" → detailed analytics screen

---

### Modal 6: `Practice Introduction`

**State Used**:

- `AudioContext` → calls `loadTrack()` on mount
- `ProgressContext` → checks if user can skip (after 10 sessions)

**Navigation Trigger**: Tap "BEGIN" → `Practice Session` screen

---

### Modal 7: `Practice Session`

**State Used**:

- `AudioContext` → full playback control
- `ProgressContext` → none (saves on exit)

**Navigation Trigger**: Session end → `Reflection` screen

---

### Modal 8: `Reflection`

**State Used**:

- `ProgressContext` → calls `completeSession()` on submit
- `ChallengeContext` → auto-populates sounds for challenges

**Navigation Triggers**:

- Submit → shows reward animation → returns to `Home`
- Skip TapGame → returns to `Home`
- Play TapGame → `TapGame` screen

---

## Data Synchronization Patterns

### Optimistic Updates

- `completeSession()` updates local state **immediately**
- Firestore write happens in background
- On error: rollback + toast notification

### Cache-Then-Network (Guest Mode)

- Guest progress stored in `AsyncStorage`
- On sign-up: migrates `AsyncStorage` → Firestore
- No data loss during guest → account transition

### Offline Queue

- All writes queued if offline
- Syncs automatically when connection restored
- Critical for session completion in poor connectivity

---

## Performance Optimizations

### Context Splitting

- `AudioContext` split into:
  - `AudioState` (frequently updated: `currentTime`)
  - `AudioActions` (static: `play`, `pause`)
- Prevents unnecessary re-renders in timer vs play button

### Selective State Subscriptions

- `Home` screen only subscribes to:
  - `progress.totalSessions`
  - `progress.currentStreak`
  - `progress.levels`
- Not full session history (loaded on-demand in `Profile`)

### Memoized Selectors

```ts
// In components
const streak = useMemo(() => progress.currentStreak, [progress.currentStreak]);
const level1Complete = useMemo(
  () => progress.levels.level1.rewardComplete,
  [progress.levels.level1.rewardComplete]
);
```

---

## Migration Path: Zustand (Phase 2)

**When to Migrate**:

- If re-render performance degrades with 5+ contexts
- If state logic becomes too complex (e.g., inter-context dependencies)

**Zustand Advantages**:

- No provider nesting
- Automatic render optimization
- Built-in persistence middleware

**Example Store**:

```ts
const useProgressStore = create((set, get) => ({
  progress: null,
  completeSession: async data => {
    const newProgress = calculate(data);
    set({ progress: newProgress }); // Optimistic
    await saveToFirestore(newProgress); // Background
  },
}));
```
