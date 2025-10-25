# 🗿 AWAIR: DEVELOPER & OPERATIONAL BLUEPRINT

## The Definitive Implementation, Quality, and Environment Guide

**Version:** 1.0
**Purpose:** This document complements the "COMPLETE MASTER BLUEPRINT" by specifying the development environment, quality assurance processes, and operational tooling required to build and maintain AwAir robustly, with a focus on **error prevention and rapid debugging**.

---

### 1. Developer Environment & Tooling (VS Code)

This section ensures that every developer works in a consistent, error-minimizing environment directly within their code editor.

**What it is:** A standardized configuration for VS Code to enforce code quality and style automatically.

**Why it prevents errors:**
*   **Inconsistency is a primary source of bugs.** Enforcing a single style guide eliminates entire classes of errors related to formatting and syntax.
*   **Automated checks catch errors before the code is even run.** Linters act as a real-time spell-check for your code.

**Recommended Implementation:**

1.  **Create a `.vscode` directory** in your project's root.
2.  Inside, create a `settings.json` file:

    ```json
    {
      "editor.formatOnSave": true, // Automatically format code on every save
      "editor.defaultFormatter": "esbenp.prettier-vscode", // Use Prettier as the formatter
      "editor.codeActionsOnSave": {
        "source.fixAll.eslint": "explicit" // Automatically fix ESLint errors on save
      },
      "files.eol": "\n", // Enforce consistent line endings
      "javascript.validate.enable": false, // Disable VS Code's built-in validator in favor of ESLint
      "typescript.validate.enable": false
    }
    ```

3.  **Create a `.vscode/extensions.json` file:** This prompts any developer opening the project to install the recommended extensions.

    ```json
    {
      "recommendations": [
        "dbaeumer.vscode-eslint",   // The official ESLint extension
        "esbenp.prettier-vscode",   // The official Prettier extension
        "eamodio.gitlens",          // Supercharges Git integration, helps track changes
        "ms-azuretools.vscode-docker" // If using Docker for any backend services
      ]
    }
    ```

---

### 2. Code Quality & Type Safety (ESLint & TypeScript)

Your blueprint mentions JavaScript. **Migrating to TypeScript is the single most effective way to prevent errors.**

**What it is:**
*   **ESLint:** A tool that statically analyzes your code to find problems based on a set of rules.
*   **TypeScript:** A superset of JavaScript that adds static types, allowing you to define the "shape" of your data.

**Why it prevents errors:**
*   **TypeScript prevents type-related runtime errors.** It makes crashes like `undefined is not an object` almost impossible by forcing you to handle cases where data might be missing. It ensures you pass the correct props to components.
*   **ESLint enforces best practices.** It will warn you about infinite loops in `useEffect`, unused variables, and incorrect hook usage, which are all common sources of bugs.

**Recommended Implementation:**

1.  **Initialize your Expo project with TypeScript:**
    ```bash
    npx create-expo-app my-awesome-app --template "blank (TypeScript)"
    ```

2.  **Create a comprehensive `.eslintrc.js` file:**

    ```javascript
    module.exports = {
      root: true,
      extends: [
        'universe/native',
        'plugin:@typescript-eslint/recommended',
        'prettier', // Make sure Prettier rules are last
      ],
      rules: {
        // Enforce that useEffect has a dependency array to prevent infinite loops
        'react-hooks/exhaustive-deps': 'error',
        // Disallow console.log in production code to avoid leaving debug logs in
        'no-console': ['warn', { allow: ['warn', 'error'] }],
        // Ensure all components have clear prop types (if not using TS)
        // 'react/prop-types': 'error',
      },
    };
    ```

---

### 3. Firebase Security & Data Validation (Firestore Rules)

Your database schema is excellent, but without robust security rules, it's vulnerable to accidental corruption and malicious attacks.

**What it is:** A set of rules deployed to Firestore that specifies who can read, write, update, and delete which documents, and what the data must look like.

**Why it prevents errors:**
*   **Prevents users from corrupting their own (or others') data.** For example, it stops a user from accidentally setting `totalSessions` to a string instead of a number.
*   **Prevents cheating.** It stops a user from giving themselves premium status or unlocking achievements they didn't earn.
*   **The server becomes the single source of truth**, preventing client-side bugs from having catastrophic effects on the database.

**Recommended Implementation:**

Create a `firestore.rules` file:

```
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    // Users can only read and write to their OWN user document.
    match /users/{userId} {
      allow read, update, delete: if request.auth != null && request.auth.uid == userId;
      allow create: if request.auth != null && request.auth.uid == userId;

      // Rule: a user cannot make themselves premium. Only a server/admin process can.
      function cannotChangePremiumStatus() {
        return request.resource.data.profile.isPremium == resource.data.profile.isPremium;
      }

      // Rule: a user cannot grant themselves achievements or fake progress.
      function cannotFakeProgress() {
        // Check a few key fields. The new submission cannot arbitrarily increase progress.
        // True logic for this would be complex, but this shows the concept.
        return request.resource.data.progress.totalSessions >= resource.data.progress.totalSessions;
      }

      // Apply the validation rules
      allow update: if request.auth != null && request.auth.uid == userId
                    && cannotChangePremiumStatus()
                    && cannotFakeProgress();
    }

    // Sessions: Users can create sessions, but cannot edit them after creation.
    match /users/{userId}/sessions/{sessionId} {
      allow read, delete: if request.auth != null && request.auth.uid == userId;
      allow create: if request.auth != null && request.auth.uid == userId;
      allow update: if false; // Disallow editing past sessions
    }

    // Public content like soundscapes and achievements should be read-only for users.
    match /soundscapes/{doc=**} {
      allow read: if request.auth != null;
      allow write: if false; // Only updatable via admin tools/backend
    }

    match /achievements/{doc=**} {
      allow read: if request.auth != null;
      allow write: if false;
    }
  }
}```

---

### 4. Automated Testing Strategy

Your "Testing & Launch Strategy" section needs to be expanded into a concrete plan. Untested code is guaranteed to have errors.

**What it is:** A multi-layered approach to testing different parts of the application automatically.

**Why it prevents errors:**
*   **Catches regressions.** It stops a new feature from breaking an old one. This is the #1 job of automated tests.
*   **Forces modular code.** Code that is easy to test is usually well-designed code.
*   **Provides a safety net** for refactoring and adding new features with confidence.

**Recommended Implementation:**

1.  **Unit Tests (Jest & React Native Testing Library):**
    *   **Focus:** Test individual components in isolation.
    *   **Example:** Create a test file `Button.test.js` to ensure your custom button component works.
        ```jsx
        import { render, fireEvent } from '@testing-library/react-native';
        import MyButton from './MyButton';

        it('calls onPress when tapped', () => {
          const onPressMock = jest.fn(); // Create a fake function
          const { getByText } = render(<MyButton title="Tap Me" onPress={onPressMock} />);

          fireEvent.press(getByText('Tap Me'));

          expect(onPressMock).toHaveBeenCalledTimes(1); // Verify it was called
        });
        ```

2.  **End-to-End (E2E) Tests (Maestro):**
    *   **Focus:** Test critical user flows from start to finish, simulating a real user. Maestro is newer and far simpler than older tools like Detox.
    *   **Example:** A test script `onboarding.yml` that simulates the entire onboarding flow.
        ```yaml
        appId: com.awair.app
        ---
        - launchApp
        - tapOn: "Begin"
        - tapOn: "Next"
        - tapOn: "Got it"
        - tapOn: "Set and Continue"
        - tapOn: "Continue as Guest"
        - assertVisible: "Good morning" # Verify we landed on the home screen
        ```
    *   **Run this automatically before every release.** It is your ultimate guarantee that your core flows (onboarding, login, first practice) are not broken.

---

### 5. Secrets Management (API Keys)

Your app will have API keys (Firebase, RevenueCat). Hardcoding them in your source code and committing them to Git is a massive security risk and a common error.

**What it is:** A system for managing secret keys and making them available to the app without storing them in version control.

**Why it prevents errors:**
*   Prevents you from accidentally leaking sensitive API keys, which can lead to your accounts being hijacked.
*   Allows you to have different keys for development, staging, and production environments, which prevents dev work from impacting real users.

**Recommended Implementation:**

1.  Use `expo-constants` and environment variables.
2.  Create a file named `.env` in your project root.
3.  Add `.env` to your `.gitignore` file. **This is the most important step.**
4.  Put your secrets in the `.env` file:
    ```
    REVENUECAT_API_KEY="your_revenuecat_key_here"
    FIREBASE_API_KEY="your_firebase_key_here"
    ```
5.  In your Expo config (`app.config.js`), load these variables into the `extra` field.

    ```javascript
    import 'dotenv/config';

    export default {
      // ... your other config
      extra: {
        revenueCatApiKey: process.env.REVENUECAT_API_KEY,
        firebaseApiKey: process.env.FIREBASE_API_KEY,
      },
    };
    ```

6.  Access them safely in your code:

    ```javascript
    import Constants from 'expo-constants';

    const revenueCatKey = Constants.expoConfig.extra.revenueCatApiKey;
    ```