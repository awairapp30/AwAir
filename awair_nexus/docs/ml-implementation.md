### 📄 `ml-implementation.md`

This file will detail **how sound detection works** in AwAir—specifically for **TapGame** (real-time on-device) and **Sound→Form** (pre-processed server-side)—using **TensorFlow Lite + Teachable Machine** and **YAMNet**, exactly as specified in your blueprint.

---

**Content of `ml-implementation.md`:**

````md
# ML Implementation: Sound Detection Architecture

AwAir uses a **hybrid AI/ML approach**:

- **On-device inference** for real-time TapGame scoring (no network dependency)
- **Server-side pre-processing** for Sound→Form metadata (high accuracy, one-time cost)

Both paths use **free, open-source models** and avoid expensive cloud APIs.

## TapGame: Real-Time On-Device Detection (Phase A)

### Goal

Detect target sounds **during gameplay** to validate user taps within a tolerance window (±250–500ms).

### Stack

- **Training**: [Teachable Machine](https://teachablemachine.withgoogle.com/) (no-code)
- **Inference**: TensorFlow Lite (TFLite) in React Native
- **Audio Format**: Ogg Vorbis @ 96 kbps, 44.1 kHz, stereo

### Model Training (Per Game)

#### Data Collection

For each TapGame (e.g., `BirdTap`):

- **Positive samples**: 50–100 clips of target sound (e.g., bird chirps)
  - Sources: Freesound.org, BBC Sound Effects, extracted from master tracks
  - Variety: species, pitch, duration, recording quality
- **Negative samples**: 50–100 clips of background ambience **without** target sound
  - Teaches model: “This is NOT a bird”

#### Training Process

1. Go to [Teachable Machine → Audio Project](https://teachablemachine.withgoogle.com/train/audio)
2. Create 2 classes:
   - `target` (e.g., `bird_chirp`)
   - `background` (e.g., `forest_ambience`)
3. Upload samples
4. Click **Train Model** (5–10 mins, auto-tuned)
5. Validate accuracy (>85% target)
6. Export as **TensorFlow Lite**

#### Model Specs

| Game            | Model Size | Target Sound          | Tolerance Window |
| --------------- | ---------- | --------------------- | ---------------- |
| BirdTap 🐦      | 3.2 MB     | Bird chirps           | ±300 ms          |
| WavePulse 🌊    | 3.8 MB     | Wave crashes          | ±400 ms          |
| SilenceCatch 🤫 | 2.9 MB     | Silence gaps (>2s)    | Entire gap       |
| FootstepBeat 👣 | 4.1 MB     | Distinct footsteps    | ±250 ms          |
| WindNote 💨     | 3.5 MB     | Wind intensity surges | ±500 ms          |

**Total bundled size**: ~17.5 MB

### Integration in React Native

#### Dependencies

```bash
npm install @tensorflow/tfjs @tensorflow/tfjs-react-native
expo install expo-gl
```
````

#### Model Loading

```ts
import * as tf from '@tensorflow/tfjs';
import { bundleResourceIO } from '@tensorflow/tfjs-react-native';

const loadModel = async (modelPath: string) => {
  await tf.ready();
  return await tf.loadGraphModel(modelPath);
};

// Usage
const birdModel = await loadModel(
  FileSystem.bundleDirectory + 'models/birdtap_model.tflite'
);
```

#### Real-Time Analysis

```ts
const analyzeAudioFrame = async (
  audioBuffer: Float32Array
): Promise<number> => {
  // Convert to mel-spectrogram (TFLite input)
  const spectrogram = await audioBufferToSpectrogram(audioBuffer);

  // Run inference
  const inputTensor = tf.tensor(spectrogram);
  const prediction = await birdModel.predict(inputTensor);
  const confidence = prediction.dataSync()[0]; // Probability of "bird"

  // Cleanup to prevent memory leaks
  inputTensor.dispose();
  prediction.dispose();

  return confidence;
};
```

#### Tap Validation

```ts
let currentEventActive = false;

// Run every 200ms during gameplay
setInterval(async () => {
  const confidence = await analyzeAudioFrame(getCurrentAudioFrame());
  currentEventActive = confidence > 0.7; // Tunable threshold
}, 200);

// On user tap
const handleTap = () => {
  if (currentEventActive) {
    score++;
    showFeedback('correct');
  } else {
    showFeedback('miss');
  }
};
```

### Optimization Strategies

- **Frame-based analysis**: Only analyze every 200ms (5 FPS) → reduces CPU load
- **Confidence threshold**: `0.7` balances false positives vs. sensitivity
- **Tensor disposal**: Always `dispose()` tensors or use `tf.tidy()`
- **Quantization**: Enable in Teachable Machine export → 60% smaller models

---

## Sound→Form: Server-Side Pre-Processing (Phase B)

### Goal

Generate **precise timestamps** for sounds in master audio files to drive **image reveal sequences**.

### Stack

- **Model**: [YAMNet](https://tfhub.dev/google/yamnet/1) (pre-trained on AudioSet)
- **Runtime**: Google Cloud Function (Python)
- **Output**: `events.json` per soundscape

### YAMNet Advantages

- Detects **521 sound classes** (birds, water, traffic, speech, etc.)
- **No custom training needed**
- **High accuracy** (state-of-the-art)
- **Free and open-source**

### Cloud Function Workflow

#### Trigger

- On upload of master audio (`.wav`) to Firebase Storage

#### Processing Steps

1. Download audio file
2. Run YAMNet inference
3. Extract high-confidence events (`confidence > 0.5`)
4. Group consecutive similar events (reduce noise)
5. Save as `soundscapeId_events.json`

#### Python Implementation

```python
import tensorflow_hub as hub
import tensorflow as tf

yamnet = hub.load('https://tfhub.dev/google/yamnet/1')

def analyze_audio(audio_path: str):
    # Load audio
    wav = tf.io.read_file(audio_path)
    audio, _ = tf.audio.decode_wav(wav)
    audio = tf.squeeze(audio, axis=-1)

    # Run YAMNet
    scores, _, _ = yamnet(audio)

    events = []
    for i, frame_scores in enumerate(scores):
        top_class = tf.argmax(frame_scores).numpy()
        confidence = frame_scores[top_class].numpy()
        timestamp = i * 0.48  # YAMNet frame = 0.48s

        if confidence > 0.5:
            events.append({
                'time': timestamp,
                'eventId': yamnet.class_names[top_class],
                'confidence': float(confidence)
            })

    return group_events(events)  # Merge nearby duplicates
```

#### Output Example (`forest_dawn_events.json`)

```json
{
  "soundscapeId": "forest_dawn_v1",
  "duration": 1200,
  "events": [
    { "time": 5.3, "eventId": "Bird vocalization...", "confidence": 0.87 },
    { "time": 12.1, "eventId": "Wind", "confidence": 0.62 },
    { "time": 18.7, "eventId": "Bird vocalization...", "confidence": 0.91 },
    { "time": 25.0, "eventId": "Water", "confidence": 0.71 }
  ]
}
```

### App Integration

```ts
// Load pre-computed events
const fetchEvents = async (soundscapeId: string) => {
  const res = await fetch(`https://storage/.../${soundscapeId}_events.json`);
  return await res.json();
};

// Filter for relevant sounds
const layers = [
  {
    id: 'bird',
    label: 'Bird chirping',
    timestamps: events.filter(e => e.eventId.includes('Bird')).map(e => e.time),
    image: 'soundform_images/cardinal.png',
  },
  // ... other layers
];
```

### Why Hybrid?

| Use Case        | On-Device (Teachable Machine) | Server-Side (YAMNet)         |
| --------------- | ----------------------------- | ---------------------------- |
| **Latency**     | <50ms (real-time)             | N/A (pre-computed)           |
| **Accuracy**    | 85–90%                        | 95%+                         |
| **Cost**        | $0 (bundled)                  | <$1/month (Cloud Functions)  |
| **Flexibility** | Game-specific models          | General sound detection      |
| **Offline**     | ✅ Works offline              | ❌ Requires initial download |

---

## Quality Assurance

### Accuracy Targets

- **Recall**: >85% (detect sounds that are present)
- **Precision**: >80% (avoid false positives)
- **Latency**: <50ms per inference

### Testing Protocol

1. **Manual validation**: Play test audio, verify detections match ground truth
2. **Automated script**: Compare model output vs. hand-labeled timestamps
3. **Edge cases**: Test low-volume, overlapping, or distant sounds

### Failure Recovery

- If model accuracy <80%:
  - Add more training samples (especially edge cases)
  - Use data augmentation (pitch shift, time stretch)
  - Adjust confidence threshold per game

---

## Production Roadmap

### Phase 1 (MVP)

- Train 5 Teachable Machine models
- Bundle in app
- Use manual timestamping for Sound→Form (fallback)

### Phase 2 (Scale)

- Migrate Sound→Form to YAMNet pre-processing
- Add Cloud Function trigger
- Cache `events.json` in Firebase Storage

### Phase 3 (Advanced)

- On-device YAMNet for dynamic TapGames (user-uploaded sounds)
- Federated learning: Improve models from anonymized user tap data
