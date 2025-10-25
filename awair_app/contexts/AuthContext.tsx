import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { 
  getAuth, 
  signInWithEmailAndPassword, 
  createUserWithEmailAndPassword, 
  signOut as firebaseSignOut,
  onAuthStateChanged,
  User as FirebaseUser,
  signInAnonymously,
  GoogleAuthProvider,
  signInWithPopup
} from 'firebase/auth';
import { 
  getFirestore, 
  doc, 
  getDoc, 
  setDoc 
} from 'firebase/firestore';
import { initializeApp } from 'firebase/app';

// Define TypeScript interfaces
interface UserData {
  uid: string;
  email: string | null;
  displayName: string | null;
  isGuest: boolean;
  isPremium: boolean;
  premiumExpiresAt: Date | null;
}

interface AuthContextType {
  user: UserData | null;
  loading: boolean;
  error: string | null;
  signUp: (email: string, password: string, displayName: string) => Promise<void>;
  signIn: (email: string, password: string) => Promise<void>;
  signInWithGoogle: () => Promise<void>;
  signOut: () => Promise<void>;
  continueAsGuest: () => Promise<void>;
  upgradeGuestToAccount: (email: string, password: string, displayName: string) => Promise<void>;
  updateProfile: (data: Partial<UserData>) => Promise<void>;
  checkPremiumStatus: () => Promise<boolean>;
}

// Initialize Firebase app (this will be configured in a separate service file)
// For now, we'll assume Firebase is initialized elsewhere
const firebaseConfig = {
  // This will be filled in with actual config later
  apiKey: process.env.EXPO_PUBLIC_FIREBASE_API_KEY,
  authDomain: process.env.EXPO_PUBLIC_FIREBASE_AUTH_DOMAIN,
  projectId: process.env.EXPO_PUBLIC_FIREBASE_PROJECT_ID,
  storageBucket: process.env.EXPO_PUBLIC_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.EXPO_PUBLIC_FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.EXPO_PUBLIC_FIREBASE_APP_ID,
  measurementId: process.env.EXPO_PUBLIC_FIREBASE_MEASUREMENT_ID,
};

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const firestore = getFirestore(app);

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

interface AuthProviderProps {
  children: ReactNode;
}

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [user, setUser] = useState<UserData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Listen to auth state changes
  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, async (firebaseUser) => {
      if (firebaseUser) {
        try {
          // Fetch additional user data from Firestore
          const userDoc = await getDoc(doc(firestore, 'users', firebaseUser.uid));
          const userData = userDoc.data();

          setUser({
            uid: firebaseUser.uid,
            email: firebaseUser.email,
            displayName: firebaseUser.displayName || userData?.displayName,
            isGuest: firebaseUser.isAnonymous,
            isPremium: userData?.isPremium || false,
            premiumExpiresAt: userData?.premiumExpiresAt || null,
          });
        } catch (err) {
          console.error('Error fetching user data:', err);
          setError('Failed to fetch user data');
        }
      } else {
        setUser(null);
      }
      setLoading(false);
    });

    return unsubscribe;
  }, []);

  const signUp = async (email: string, password: string, displayName: string) => {
    try {
      setLoading(true);
      setError(null);

      // Create Firebase auth user
      const credential = await createUserWithEmailAndPassword(auth, email, password);
      
      // Update profile
      await credential.user.updateProfile({ displayName });

      // Create Firestore user document
      await setDoc(doc(firestore, 'users', credential.user.uid), {
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
          achievements: { unlocked: [], unlockedDates: {}, progress: {} },
        },
        createdAt: new Date(),
        lastActive: new Date(),
      });

      setLoading(false);
    } catch (err: any) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const signIn = async (email: string, password: string) => {
    try {
      setLoading(true);
      setError(null);
      await signInWithEmailAndPassword(auth, email, password);
      setLoading(false);
    } catch (err: any) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const signInWithGoogle = async () => {
    try {
      setLoading(true);
      setError(null);

      const provider = new GoogleAuthProvider();
      const result = await signInWithPopup(auth, provider);

      // Check if user document exists
      const userDoc = await getDoc(doc(firestore, 'users', result.user.uid));
      
      if (!userDoc.exists()) {
        // New user - create document
        await setDoc(doc(firestore, 'users', result.user.uid), {
          profile: {
            email: result.user.email,
            displayName: result.user.displayName,
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
            achievements: { unlocked: [], unlockedDates: {}, progress: {} },
          },
          createdAt: new Date(),
          lastActive: new Date(),
        });
      }

      setLoading(false);
    } catch (err: any) {
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
      const credential = await signInAnonymously(auth);

      // Create minimal guest document
      await setDoc(doc(firestore, 'users', credential.user.uid), {
        profile: {
          createdAt: new Date(),
          isGuest: true,
          isPremium: false,
        },
        preferences: {
          audio: { maxVolume: 0.65, fadeInDuration: 5, fadeOutDuration: 5 },
          notifications: { dailyReminder: false },
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
          achievements: { unlocked: [], unlockedDates: {}, progress: {} },
        },
        createdAt: new Date(),
        lastActive: new Date(),
      });

      setLoading(false);
    } catch (err: any) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const upgradeGuestToAccount = async (email: string, password: string, displayName: string) => {
    if (!auth.currentUser || !user?.isGuest) {
      throw new Error('Only guest accounts can be upgraded');
    }

    try {
      setLoading(true);
      setError(null);

      // This is a simplified version - in a real app, you'd need to reauthenticate
      // the user and link the anonymous account with email/password
      // For now, we'll just update the user's email in their profile
      await auth.currentUser.updateEmail(email);
      await auth.currentUser.updatePassword(password);
      await auth.currentUser.updateProfile({ displayName });

      // Update Firestore document
      // Note: In a real implementation, you'd need special handling for guest-to-registered conversion
      setLoading(false);
    } catch (err: any) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const signOut = async () => {
    try {
      setLoading(true);
      await firebaseSignOut(auth);
      setUser(null);
      setLoading(false);
    } catch (err: any) {
      setError(err.message);
      setLoading(false);
      throw err;
    }
  };

  const updateProfile = async (data: Partial<UserData>) => {
    if (!auth.currentUser) return;

    try {
      // Update on Firebase Auth
      if (data.displayName) {
        await auth.currentUser.updateProfile({ displayName: data.displayName });
      }
      
      // Update in Firestore
      // This would require additional implementation to update the Firestore user document
    } catch (err: any) {
      setError(err.message);
      throw err;
    }
  };

  const checkPremiumStatus = async (): Promise<boolean> => {
    if (!user) return false;

    // Check if premium subscription is still active
    if (user.isPremium && user.premiumExpiresAt) {
      const now = new Date();
      return now < user.premiumExpiresAt;
    }

    return false;
  };

  const value: AuthContextType = {
    user,
    loading,
    error,
    signUp,
    signIn,
    signInWithGoogle,
    signOut,
    continueAsGuest,
    upgradeGuestToAccount,
    updateProfile,
    checkPremiumStatus,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};