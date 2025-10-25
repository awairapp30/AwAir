### 📄 `monetization-tech.md`

````md
# Monetization Technical Implementation

AwAir uses a **freemium model** with **subscription-based premium access**, implemented via **RevenueCat** for cross-platform subscription management and **Firestore** for local entitlement state.

## Core Monetization Stack

| Component            | Technology               | Purpose                                                                   |
| -------------------- | ------------------------ | ------------------------------------------------------------------------- |
| Subscription Backend | RevenueCat               | Handles App Store / Play Store receipts, trials, renewals, family sharing |
| Entitlement Sync     | Firestore                | Mirrors premium status for offline access and feature gating              |
| Paywall UI           | React Native             | Presents plans, handles purchase flow                                     |
| Webhooks             | Firebase Cloud Functions | Listens to RevenueCat events (cancellations, renewals)                    |

---

## RevenueCat Integration

### Setup & Initialization

**Dependencies**:

```bash
npm install react-native-purchases
npx pod-install  # iOS only
```
````

**Initialize on App Launch**:

```ts
// services/monetization.ts
import Purchases from 'react-native-purchases';
import { useAuth } from '../contexts/AuthContext';

export const initializeRevenueCat = async (userId: string) => {
  await Purchases.configure({
    apiKey: Config.REVENUECAT_PUBLIC_KEY,
    appUserID: userId, // Firebase UID
  });
};
```

**Called in `AuthProvider` after user login**:

```ts
useEffect(() => {
  if (user?.uid && !user.isGuest) {
    initializeRevenueCat(user.uid);
    syncPremiumStatus(); // Check current entitlement
  }
}, [user?.uid]);
```

---

## Entitlement Sync Strategy

### Premium Status Flow

1. **On app launch**: Fetch entitlement from RevenueCat
2. **If active**: Update Firestore `profile.isPremium = true`
3. **If inactive**: Set `profile.isPremium = false`
4. **All screens**: Read `isPremium` from `AuthContext` (not RevenueCat directly)

### Sync Function

```ts
export const syncPremiumStatus = async () => {
  try {
    const customerInfo = await Purchases.getCustomerInfo();
    const premiumEntitlement = customerInfo.entitlements.active['premium'];

    const isPremium = !!premiumEntitlement;
    const expiresAt = premiumEntitlement?.expirationDate || null;
    const originalPurchase = premiumEntitlement?.originalPurchaseDate || null;
    const type = premiumEntitlement?.productIdentifier.includes('annual')
      ? 'annual'
      : 'monthly';

    // Update Firestore
    await firestore().collection('users').doc(user.uid).update({
      'profile.isPremium': isPremium,
      'profile.premiumExpiresAt': expiresAt,
      'profile.premiumSince': originalPurchase,
      'profile.subscriptionType': type,
    });

    // Update local context
    setAuthUser(prev => ({ ...prev, isPremium }));
  } catch (error) {
    console.error('Failed to sync premium status', error);
  }
};
```

---

## Paywall Implementation

### Plan Configuration (RevenueCat Dashboard)

| Package ID | Product ID (Play Store) | Duration | Price  |
| ---------- | ----------------------- | -------- | ------ |
| `monthly`  | `awair_premium_monthly` | 1 month  | $3.99  |
| `annual`   | `awair_premium_annual`  | 1 year   | $23.99 |

> **Entitlement**: `premium` (granted when either package is active)

### Fetch & Display Plans

```ts
const PaywallScreen = () => {
  const [packages, setPackages] = useState<Package[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadPackages = async () => {
      const offerings = await Purchases.getOfferings();
      if (offerings.current) {
        setPackages(offerings.current.availablePackages);
      }
      setLoading(false);
    };
    loadPackages();
  }, []);

  const handlePurchase = async (pkg: Package) => {
    try {
      const { customerInfo } = await Purchases.purchasePackage(pkg);
      const isPremium = !!customerInfo.entitlements.active['premium'];

      if (isPremium) {
        syncPremiumStatus(); // Update local state + Firestore
        navigation.goBack(); // Return to previous screen
      }
    } catch (e) {
      if (e.userCancelled) return;
      Alert.alert('Purchase failed', e.message);
    }
  };

  const annual = packages.find(p => p.identifier === 'annual');
  const monthly = packages.find(p => p.identifier === 'monthly');

  return (
    <View>
      <PlanCard
        title="Annual (Best Value)"
        price="$23.99/year"
        subtext="Just $1.99/month • Save 50%"
        onPress={() => handlePurchase(annual)}
        highlighted
      />
      <PlanCard
        title="Monthly"
        price="$3.99/month"
        subtext="Cancel anytime"
        onPress={() => handlePurchase(monthly)}
      />
      <Text>7-day free trial • Cancel anytime</Text>
    </View>
  );
};
```

---

## Premium Feature Gating

### Strategy: Context-Based Checks

All premium checks use `user.isPremium` from `AuthContext`:

```tsx
// In any screen
import { useAuth } from '../contexts/AuthContext';

const Level3Card = () => {
  const { user } = useAuth();

  if (user.isPremium) {
    return <Level3Content />;
  }

  return (
    <LockedCard
      title="Level 3: Mastery 🔒"
      subtitle="Unlock with Premium"
      onPress={() => navigation.navigate('Paywall')}
    />
  );
};
```

### Granular Feature Flags (Optional)

For advanced control, use Firestore feature flags:

```ts
// users/{uid}/profile/features
{
  level3: true,
  unlimitedChallenges: true,
  advancedAnalytics: true,
  soundformJourneys: true
}
```

> **Why**: Allows gradual rollout, A/B testing, or temporary access (e.g., beta features).

---

## Webhook Integration (Server-Side Sync)

### Purpose

Handle subscription events that occur **outside the app**:

- Cancellations
- Renewals
- Refunds
- Trial conversions

### Firebase Cloud Function (Node.js)

```js
// functions/index.js
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.revenuecatWebhook = functions.https.onRequest(async (req, res) => {
  const event = req.body;

  // Verify webhook signature (omitted for brevity)
  if (!isValidSignature(req)) {
    return res.status(401).send('Unauthorized');
  }

  const userId = event.app_user_id; // Firebase UID
  const entitlement = event.payload?.entitlements?.premium;

  if (entitlement) {
    const isPremium = entitlement.expires_date > Date.now();

    await admin.firestore().collection('users').doc(userId).update({
      'profile.isPremium': isPremium,
      'profile.premiumExpiresAt': entitlement.expires_date,
    });
  }

  res.status(200).send('OK');
});
```

### RevenueCat Webhook Setup

- **URL**: `https://us-central1-your-project.cloudfunctions.net/revenuecatWebhook`
- **Events**: `INITIAL_PURCHASE`, `RENEWAL`, `CANCELLATION`, `EXPIRATION`
- **Secret**: Used to verify payload authenticity

---

## Trial & Grace Period Handling

### Free Trial

- Enabled in RevenueCat dashboard
- Automatically applied to new users
- **No code required**—RevenueCat handles trial eligibility

### Grace Period (iOS)

- RevenueCat automatically extends access during payment retries
- `customerInfo.entitlements.active['premium']` remains `true` during grace period
- **No extra logic needed**—just rely on entitlement status

---

## Restore Purchases

For users switching devices or reinstalling:

```ts
const restorePurchases = async () => {
  try {
    const customerInfo = await Purchases.restorePurchases();
    const isPremium = !!customerInfo.entitlements.active['premium'];

    if (isPremium) {
      syncPremiumStatus();
      Alert.alert('Restored!', 'Your premium access is active.');
    } else {
      Alert.alert('No purchases found');
    }
  } catch (e) {
    Alert.alert('Restore failed', e.message);
  }
};
```

**UI Placement**: Settings → "Restore Purchases" button

---

## Offline & Guest Mode Considerations

### Guest Users

- Cannot purchase (paywall disabled)
- Can **preview** Level 3 (5-minute bundled track)
- On account creation: migrate progress, **do not** grant premium

### Offline Access

- Premium status cached in `AsyncStorage` (via `AuthContext`)
- All premium content (Level 3 tracks, journeys) **streamed**, but:
  - Once downloaded, playable offline
  - Paywall checks use **cached** `isPremium` value

---

## Testing Strategy

### Sandbox Testing (Android/iOS)

1. Use test accounts (Play Store / App Store sandbox)
2. Simulate:
   - Free trial start
   - Trial conversion
   - Cancellation
   - Renewal failure
3. Verify Firestore updates correctly

### Local Overrides (Dev Only)

```ts
// For testing premium UI without purchasing
if (__DEV__) {
  return (
    <View>
      <Button title="Force Premium ON" onPress={() => setForcePremium(true)} />
      <Level3Content />
    </View>
  );
}
```

---

## Security Notes

1. **Never trust client-side checks alone**
   - Firestore security rules enforce data access:
     ```js
     match /soundscapes/{id} {
       allow read: if resource.data.level <= 2 ||
                    (resource.data.level == 3 && request.auth.token.premium == true);
     }
     ```
2. **Validate RevenueCat webhooks**
   - Use secret key to verify payload origin
3. **Obfuscate RevenueCat API key**
   - Store in environment variables (not in code)

---

## Error Handling & Edge Cases

| Scenario                         | Handling                                    |
| -------------------------------- | ------------------------------------------- |
| Purchase succeeds but sync fails | Retry sync on next app launch               |
| User cancels during trial        | `isPremium` becomes `false` at trial end    |
| Multiple devices                 | RevenueCat syncs entitlement across devices |
| Clock tampering                  | RevenueCat uses server time for expiration  |
| Network failure during purchase  | RevenueCat retries automatically            |

```

---

✅ **All 6 technical Markdown files are now complete!**

### 📁 Final File List:
1. `tech-stack.md`
2. `audio-architecture.md`
3. `database-schema.md`
4. `ml-implementation.md`
5. `state-and-screen-architecture.md`
6. `monetization-tech.md`
```
