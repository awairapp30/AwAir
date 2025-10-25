This file will define the **exact Firestore data model** used in AwAir—including collections, document structures, subcollections, and key query patterns—so your AI CLI can generate accurate data logic.

---

**Content of `database-schema.md`:**

````md
# Database Schema

AwAir uses **Cloud Firestore** (NoSQL) with a denormalized, user-centric schema optimized for offline support, real-time sync, and fast reads.

## Core Collections

### `users/{userId}` — User Profile & Summary Data

**Purpose**: Single-document fetch for home screen, profile, and settings.

```ts
{
  // Profile
  profile: {
    email: string,
    displayName: string,
    isGuest: boolean,
    createdAt: timestamp,
    lastActive: timestamp,
    isPremium: boolean,
    premiumSince: timestamp | null,
    premiumExpiresAt: timestamp | null,
    subscriptionType: 'monthly' | 'annual' | null,
    trialUsed: boolean,
  },

  // Preferences
  preferences: {
    audio: {
      maxVolume: number,        // 0–1, capped at 0.7
      fadeInDuration: number,   // seconds (default: 5)
      fadeOutDuration: number,  // seconds (default: 5)
      backgroundPlayback: boolean,
    },
    notifications: {
      dailyReminder: boolean,
      reminderTime: string,     // "08:00"
      streakReminder: boolean,
      achievementAlerts: boolean,
      presenceInvitations: boolean,
      frequency: 'high' | 'medium' | 'low',
    },
    appearance: {
      darkMode: 'auto' | 'light' | 'dark',
      colorScheme: string,      // future: 'forest', 'ocean'
      animationSpeed: 'slow' | 'normal' | 'fast',
      reducedMotion: boolean,
    },
    practice: {
      defaultDuration: number,  // minutes (default: 10)
      autoPlayNext: boolean,
      showTimer: boolean,
      quoteFrequency: 'minimal' | 'normal' | 'frequent',
      skipIntros: boolean,
    },
  },

  // Aggregated Progress (pre-calculated for performance)
  progress: {
    totalSessions: number,
    totalMinutes: number,
    currentStreak: number,
    longestStreak: number,
    lastSessionDate: timestamp,
    firstSessionDate: timestamp,

    levels: {
      level1: { /* see Level Progress below */ },
      level2: { /* same */ },
      level3: { /* same */ },
    },

    challenges: {
      totalChallenges: number,
      selectedSounds: string[], // ['traffic', 'babies_crying']
      soundMastery: { /* see Sound Mastery below */ },
    },

    achievements: {
      unlocked: string[],       // ['first_session', 'mandala_master']
      unlockedDates: Record<string, timestamp>,
      progress: Record<string, number>, // partial progress
    },

    analytics: {
      weeklyMinutes: number[],  // last 12 weeks
      presenceTrend: number[],  // last 30 sessions
      practiceTimeDistribution: {
        morning: number,
        afternoon: number,
        evening: number,
        night: number,
      },
      favoriteTime: 'morning' | 'afternoon' | 'evening' | 'night',
      averageSessionLength: number,
    },
  }
}
```
````

#### Level Progress (per level)

```ts
{
  sessionsCompleted: number,
  minutesCompleted: number,
  rewardProgress: number,     // 0–10 (mandala), 0–8 (waves), 0–7 (stars)
  rewardComplete: boolean,
  averagePresenceRating: number,
  completionRate: number,
  favoriteTrack: string,      // soundscapeId
  firstCompletedDate: timestamp,
  unlocked: boolean,          // level2/3 only
}
```

#### Sound Mastery (per sound)

```ts
{
  tier: 'bronze' | 'silver' | 'gold' | 'platinum',
  totalSessions: number,
  totalMinutes: number,
  averagePresenceRating: number,
  highIntensitySessions: number,
  longestSession: number,     // minutes
  currentStreak: number,      // consecutive days
  lastPracticeDate: timestamp,
  firstPracticeDate: timestamp,
  progressionRate: number,    // % improvement
  badges: string[],           // ['traffic_aware', 'traffic_accepted']
  nextMilestone: {
    tier: string,
    sessionsNeeded: number,
    minutesNeeded: number,
  }
}
```

---

### Subcollection: `users/{userId}/sessions/{sessionId}` — Session History

**Purpose**: Detailed log of every practice session.

```ts
{
  sessionId: string,
  timestamp: timestamp,
  level: number,              // 1, 2, 3
  soundscapeId: string,
  trackTitle: string,
  intendedDuration: number,   // minutes selected
  actualDuration: number,     // seconds practiced
  completed: boolean,

  reflection: {
    presenceRating: number,   // 1–5
    soundsHeard: string[],    // ['bird', 'wind']
    soundRelation: 'pushed_away' | 'noticed_neutrally' | 'used_as_anchor' | 'felt_curious',
    notes: string,
    deepReflection: object | null,
  },

  sessionMetrics: {
    pauseCount: number,
    pauseTotalDuration: number,
    interruptions: string[],
    volumeAdjustments: number,
    exitAttempts: number,
    quotesShown: string[],
    tapGamePlayed: boolean,
    tapGameScore: number,
  },

  context: {
    timeOfDay: 'morning' | 'afternoon' | 'evening' | 'night',
    dayOfWeek: string,
    deviceType: string,
    connectionType: 'wifi' | 'cellular' | 'offline',
    location: string,         // optional: 'home', 'work', 'commute'
  },

  soundForm: {
    isJourney: boolean,
    imagesRevealed: string[],
    revealSequence: number[], // timestamps (seconds)
    deepPromptResponse: string,
  },

  metadata: {
    appVersion: string,
    deviceOS: string,
    deviceModel: string,
    audioQuality: 'bundled' | 'streamed' | 'cached',
  }
}
```

**Common Queries**:

```ts
// Last 10 sessions
db.collection('users/{uid}/sessions').orderBy('timestamp', 'desc').limit(10);

// All Level 2 sessions
db.collection('users/{uid}/sessions').where('level', '==', 2);
```

---

### Subcollection: `users/{userId}/reflections/{reflectionId}` — Journal Entries

**Purpose**: Long-form reflections separate from quick session feedback.

```ts
{
  reflectionId: string,
  sessionId: string,          // links to session
  timestamp: timestamp,
  type: 'quick' | 'deep' | 'journal',
  content: {
    text: string,
    moodTags: string[],
    insights: string[],
    questions: string[],
  },
  metadata: {
    wordCount: number,
    timeSpentWriting: number, // seconds
  }
}
```

---

### Global Collection: `soundscapes/{soundscapeId}` — Audio Metadata

**Purpose**: Read-only catalog of all tracks (accessible to authenticated users).

```ts
{
  soundscapeId: string,
  title: string,
  level: number,
  duration: number,           // seconds (master = 1200)
  bundled: boolean,           // true if in APK
  fileSize: number,           // bytes
  format: 'ogg' | 'aac',
  bitrate: number,            // kbps
  description: string,
  difficulty: 'gentle' | 'moderate' | 'challenging' | 'intense',
  tags: string[],             // ['nature', 'urban']
  sounds: string[],           // ['birds', 'traffic']

  isSoundFormJourney: boolean,
  layers: [
    {
      id: string,
      label: string,
      timestamps: number[],   // seconds
      image: string,          // asset name or URL
      imageAlt: string,
    }
  ],

  tapGameCompatible: boolean,
  eventMetadata: object,      // pre-computed YAMNet events

  audioUri: string,           // Firebase Storage path or local asset
  previewUri: string,         // Level 3 preview only
  thumbnailUri: string,

  license: string,
  creator: string,
  createdAt: timestamp,

  stats: {
    totalPlays: number,
    uniqueUsers: number,
    averageCompletionRate: number,
    averagePresenceRating: number,
  }
}
```

**Security Rule**:

```js
match /soundscapes/{id} {
  allow read: if request.auth != null;
  allow write: if request.auth.token.admin == true;
}
```

---

### Global Collection: `appContent/` — Dynamic Content

#### Quotes (`appContent/quotes/{quoteId}`)

```ts
{
  quoteId: string,
  text: string,
  author: string,
  category: 'grounding' | 'acceptance' | 'philosophical' | 'playful',
  level: number | 'all',
  length: 'short' | 'medium' | 'long'
}
```

#### Tips (`appContent/tips/{tipId}`)

```ts
{
  tipId: string,
  text: string,
  category: 'technique' | 'reframing' | 'encouragement',
  context: 'onboarding' | 'practice' | 'reflection'
}
```

#### Articles (`appContent/articles/{articleId}`)

```ts
{
  articleId: string,
  title: string,
  content: string,            // markdown
  category: 'science' | 'technique' | 'philosophy',
  unlockCondition: { type: string, value: number },
  readTime: number            // minutes
}
```

#### Testimonials (`appContent/testimonials/{testimonialId}`)

```ts
{
  testimonialId: string,
  name: string,
  role: string,
  quote: string,
  fullStory: string,
  placement: string[]         // ['home_screen', 'level_2_intro']
}
```

---

### Global Collection: `achievements/{achievementId}` — Achievement Definitions

```ts
{
  achievementId: string,
  title: string,
  description: string,
  icon: string,
  rarity: 'common' | 'uncommon' | 'rare' | 'legendary',
  category: 'consistency' | 'duration' | 'mastery' | 'exploration',
  requirements: {
    type: 'streak' | 'total_sessions' | 'level_complete' | 'sound_mastery',
    value: number,
    specific: object,         // e.g., { level: 2 } or { sound: 'traffic', tier: 'gold' }
  },
  rewardType: 'badge' | 'avatar_item' | 'theme' | 'content_unlock',
  rewardData: object,

  globalStats: {
    totalUnlocked: number,
    unlockPercentage: number, // e.g., 15.7
    lastUpdated: timestamp,
  }
}
```

---

### Analytics Collection: `analytics/{date}` — Daily Business Metrics

```ts
{
  date: string, // YYYY-MM-DD

  users: {
    dailyActive: number,
    newSignups: number,
    guestUsers: number,
    premiumUsers: number,
    churnedUsers: number,
  },

  sessions: {
    totalStarted: number,
    totalCompleted: number,
    averageDuration: number,
    completionRate: number,
    byLevel: { level1: number, level2: number, level3: number },
  },

  conversions: {
    freeToGuest: number,
    guestToAccount: number,
    freeToPremium: number,
    trialStarted: number,
    trialConverted: number,
  },

  revenue: {
    dailyRevenue: number,
    monthlyRecurring: number,
    averageRevenuePerUser: number,
  },

  retention: {
    day1: number,
    day7: number,
    day30: number,
  }
}
```

---

### Cached Analytics: `users/{userId}/analyticsCache/current/`

**Purpose**: Pre-aggregated data for instant premium dashboard load.

```ts
{
  lastUpdated: timestamp,

  weeklyData: {
    thisWeek: { sessions: number, minutes: number, avgPresence: number },
    lastWeek: { /* same */ },
    // ... up to 12 weeks
  },

  levelComparison: {
    level1: { sessions: number, avgPresence: number, avgDuration: number },
    level2: { /* same */ },
    level3: { /* same */ },
  },

  presenceEvolution: {
    overall: number,
    trend: 'improving' | 'stable' | 'declining',
    changePercentage: number,
    chartData: { week: number, avgPresence: number }[],
  },

  predictions: {
    nextAchievement: { id: string, daysEstimate: number },
    recommendedChallenge: string,
    personalizedInsight: string,
  }
}
```

---

## Performance Optimizations

### Compound Indexes (Required by Firestore)

- `users/{uid}/sessions` → `level` (asc), `timestamp` (desc)
- `users/{uid}/sessions` → `timestamp` (desc), `completed` (asc)

### Denormalization Strategy

- Store `averagePresenceRating` in both `users/{uid}/progress/levels` **and** `analyticsCache`
- Duplicate session counts in `progress.totalSessions` and `sessions` subcollection
- **Tradeoff**: Slightly more write complexity for 10x faster reads

### Pagination for Long Lists

```ts
// First page
const first = await sessionsRef.orderBy('timestamp', 'desc').limit(20).get();

// Next page
const next = await sessionsRef
  .orderBy('timestamp', 'desc')
  .startAfter(first.docs[first.docs.length - 1])
  .limit(20)
  .get();
```

### Offline Persistence

- Enabled globally via `firebase.firestore().enablePersistence()`
- All writes queue locally and sync when online
- Critical for guest users and areas with poor connectivity

```

```
