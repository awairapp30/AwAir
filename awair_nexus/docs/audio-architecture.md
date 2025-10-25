### 📄 `audio-architecture.md`

This file will detail everything about **audio handling**: bundling strategy, file formats, playback logic, streaming, caching, metadata, and production pipeline—exactly as specified in your blueprint.

---

**Content of `audio-architecture.md`:**

````md
# Audio Architecture

AwAir’s audio system is designed for **instant playback**, **progressive streaming**, and **safe listening**, while balancing APK size and user experience.

## Bundling Policy by Level

### Level 1: Foundation (Free)

- **Bundled**: 2 full tracks inside APK
  - `Forest Dawn` (~18 MB)
  - `Ocean Whisper` (~18 MB)
- **Streamed**: 2 additional tracks (`Garden Peace`, `Mountain Air`)
- **Rationale**: New users get instant practice without download delay.

### Level 2: Balance (Free)

- **Bundled**: 1 full track
  - `Park Life` (~18 MB)
- **Streamed**: 3 additional tracks (`Café Corner`, `Library Hum`, `Garden with City`)
- **Rationale**: Returning users tolerate brief downloads; saves ~60 MB in APK.

### Level 3: Mastery (Premium 🔒)

- **Bundled**: 5-minute preview only
  - `Urban Rush Preview` (~5 MB)
- **Streamed**: Full tracks (`Urban Rush`, `Office Chaos`, `Transit Hub`)
- **Rationale**: Preview creates desire; full content gated behind paywall.

### Level 4+ & Themed Journeys (Premium 🔒)

- **All streamed** (no bundling)
- **Offline download** available for premium users

> **Total APK size**: ~80–100 MB (acceptable for modern Android devices)

## File Specifications

- **Format**: Ogg Vorbis (Android-native, superior compression)
- **Bitrate**: 64–128 kbps (96 kbps typical)
- **Sample Rate**: 44.1 kHz (CD quality)
- **Channels**: Stereo (spatial immersion)
- **Peak Volume**: Never exceeds -3 dB (headphone safety)
- **Fade**: 5-second fade-in/out on all tracks

## Duration Handling

Users select: **5, 10, 15, 20, or 30 minutes**

**Implementation**:

- All master files are **20 minutes long**
- App **truncates playback programmatically** at selected duration
- Smooth 5-second fade-out at end to avoid jarring cut-off

**30-minute sessions**:

- Loop 20-minute master with crossfade (MVP)
- Future: produce select 30-minute masters (premium only)

## Streaming & Caching Strategy

### Progressive Download Flow

```ts
const streamAndCacheTrack = async (soundscapeId) => {
  const cacheKey = `awair_audio_${soundscapeId}`;

  // 1. Check local cache
  const cachedUri = await AsyncStorage.getItem(cacheKey);
  if (cachedUri && await fileExists(cachedUri)) return cachedUri;

  // 2. Download from Firebase Storage
  const downloadUrl = await getDownloadURL(`audio/${soundscapeId}.ogg`);
  const localUri = await FileSystem.downloadAsync(downloadUrl, ...);

  // 3. Cache for next time
  await AsyncStorage.setItem(cacheKey, localUri);
  return localUri;
};
```
````

### Cache Management

- **Bundled tracks**: Never deleted
- **Streamed tracks**: Cached indefinitely
- **Auto-cleanup**: If cache > 200 MB, delete least-recently-played tracks (keep last 5 sessions)
- **User control**: Settings screen shows cache size + "Clear Cache" button

### Offline Support

- Bundled tracks: always available
- Cached tracks: playable offline
- Uncached tracks: prompt to download (with file size)

## Asset Metadata Schema

Each soundscape has a JSON metadata object:

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
      "label": "Bird chirping",
      "timestamps": [15, 90, 145, 280, 360],
      "image": "bird_cardinal.png"
    }
  ]
}
```

**Used for**:

- `bundled`: Determines local vs remote playback
- `layers`: Drives Sound→Form image reveal sequence
- `timestamps`: Powers TapGame detection windows
- `sounds`: Enables personalized challenge selection

Stored in Firestore (`soundscapes/{id}`) or Firebase Storage.

## Audio Production Pipeline

### Phase 1: Sourcing (2–3 hrs/track)

- **Sources**: Freesound.org, BBC Sound Effects, Zapsplat, Sonniss GDC packs
- **License**: CC0, CC-BY, or purchased commercial
- **Quality**: Long recordings (>5 min), no background noise

### Phase 2: Mixing (6–8 hrs/track)

- **Base layer**: Continuous ambience (-12 to -18 dB)
- **Accent layers**: Intermittent sounds (birds, chimes) with randomized timing/panning
- **Surprise elements**: Subliminal sounds (-24 to -30 dB)
- **Mastering**: Normalize to -1 dB peak, gentle compression, dither on export

### Phase 3: Quality Control (1–2 hrs/track)

- **Test devices**: Phone speaker, cheap earbuds, quality headphones
- **Volume levels**: 50%, 75%, 100% all pleasant
- **Full listen**: Entire 20 minutes (no spot checks)
- **Safety**: No clipping, no startling sounds, consistent loudness

### Phase 4: Export & Metadata (30 min/track)

- **Filename**: `L1_forest_dawn_20min.ogg`
- **Metadata**: Document timestamps, commission illustrations, tag sounds
- **Storage**: Upload to Firebase Storage + create Firestore doc

## Total Production Scope

- **Level 1**: 4 tracks × 10 hrs = 40 hrs
- **Level 2**: 4 tracks × 12 hrs = 48 hrs
- **Level 3**: 3 tracks × 14 hrs = 42 hrs
- **Total**: ~130 hours

> **Timeline**: 8 weeks solo (16–18 hrs/week) or 4–5 weeks with 2 producers

```

---

✅ File 2 is ready!

Shall we proceed to **File 3: `database-schema.md`**?
```
